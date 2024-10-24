//
//  ContentView.swift
//  FootballDiary
//
//  Created by Muhammad Ali Asgar Fataymamode on 23/10/2024.
//


import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    let footballImages = ["chelsea_badge", "real_badge", "manchester_badge", "liverpool_badge", "chelsea_stadium", "real_stadium", "manchester_stadium", "liverpool_stadium", "chelsea_real", "chelsea_manchester", "chelsea_liverpool", "manchester_liverpool", "manchester_real", "real_liverpool"]

    @State private var pages: [Page] = [Page(image: nil, description: "")]
    @State private var currentPageIndex: Int = 0
    @State private var showFootballImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    @State private var showingFilters = false
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var isEditing = false
    let context = CIContext()

    var body: some View {
        VStack {
            Text("Football Diary")
                .font(.largeTitle)
                .padding()

            if let processedImage {
                processedImage
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .padding(.vertical, 2)
            } else if let image = pages[currentPage()].image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .padding(.vertical, 2)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .padding(.vertical, 2)
            }



            HStack {
                if !isEditing {
                    Button(action: {
                        isEditing = true
                    }) {
                        Text("Edit")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
            
            if isEditing {
                
                HStack{
                    Button(action: {
                                        showFootballImagePicker = true
                                    }) {
                                        Text("Upload")
                                            .padding()
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .cornerRadius(10)
                                    }
                    Button(action: saveImage) {
                        Text("Save")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    
                }
                Spacer()
                
                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity, perform: { _ in applyProcessing() })
                }
                .padding()
                HStack {
                    Button(action: changeFilter) {
                        Text("Filter")
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.vertical, 5)
            }
            
            TextEditor(text: $pages[currentPage()].description)
                .border(Color.gray, width: 1)
                .frame(height: 100)
                .padding()

            HStack {
                Button(action: {
                    saveImage()
                    previousPage()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .foregroundColor(currentPageIndex == 0 ? .gray : .blue)
                }
                .disabled(currentPageIndex == 0)

                Spacer()

                Button(action: {
                    saveImage()
                    nextPage()
                }) {
                    Image(systemName: "arrow.right")
                        .font(.title)
                        .foregroundColor(currentPageIndex == pages.count - 1 ? .gray : .blue)
                }
                .disabled(currentPageIndex == pages.count - 1)
            }
            .padding()


            HStack {
                Button(action: addNewPage) {
                    Text("Add Page")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Spacer()

                Button(action: deleteCurrentPage) {
                    Text("Delete Page")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(pages.count == 1)
            }
        }
        
        .sheet(isPresented: $showFootballImagePicker) {
            FootballImagePicker(selectedImage: $selectedImage, footballImages: footballImages)
                .onDisappear {
                    if let selectedImage = selectedImage {
                        setImageForCurrentPage(selectedImage)
                        loadImage(selectedImage)
                    }
                }
        }
        
        .confirmationDialog("Select a filter", isPresented: $showingFilters) {
            Button("Monochrome") { setFilter(CIFilter.colorMonochrome()) }
            Button("Bloom") { setFilter(CIFilter.bloom()) }
            Button("Sharpen") { setFilter(CIFilter.sharpenLuminance()) }
            Button("Sepia Tone") { setFilter(CIFilter.sepiaTone() )}
            Button("Comic Effect") { setFilter(CIFilter.comicEffect()) }
            Button("Posterize") { setFilter(CIFilter.colorPosterize()) }
            Button("Noir") { setFilter(CIFilter.photoEffectNoir()) }
            Button("Invert Colors") { setFilter(CIFilter.colorInvert()) }
            Button("Vintage Effect") { setFilter(CIFilter.photoEffectInstant()) }
            Button("Cancel", role: .cancel) { }
        }
    }

    func currentPage() -> Int {
        return currentPageIndex
    }

    func previousPage() {
        if currentPageIndex > 0 {
            currentPageIndex -= 1
        }
        processedImage = nil
    }

    func nextPage() {
        if currentPageIndex < pages.count - 1 {
            currentPageIndex += 1
        }
        processedImage = nil
    }


    func addNewPage() {
        let newPage = Page(image: nil, description: "")
        pages.append(newPage)
        withAnimation {
            currentPageIndex = pages.count - 1
        }
        processedImage = nil
    }

    func deleteCurrentPage() {
        guard pages.count > 1 else { return }

        pages.remove(at: currentPageIndex)
        if currentPageIndex >= pages.count {
            currentPageIndex = pages.count - 1
        }
        processedImage = nil
    }

    func setImageForCurrentPage(_ image: UIImage) {
        pages[currentPageIndex].image = image
    }

    func saveImage() {
        isEditing = false
        if let processedImage = processedImage, let cgImage = context.createCGImage(currentFilter.outputImage!, from: currentFilter.outputImage!.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            pages[currentPageIndex].image = uiImage
        }
    }

    func changeFilter() {
        showingFilters = true
    }

    func loadImage(_ image: UIImage) {
        let beginImage = CIImage(image: image)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }

    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
        }

        guard let outputImage = currentFilter.outputImage else { return }
        if let cgimage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimage)
            processedImage = Image(uiImage: uiImage)
        }
    }

    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        if let image = pages[currentPage()].image {
            loadImage(image)
        }
    }
}
