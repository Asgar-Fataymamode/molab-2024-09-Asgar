//
//  ImagePicker.swift
//  FootballDiary
//
//  Created by Muhammad Ali Asgar Fataymamode on 23/10/2024.
//

import SwiftUI

struct FootballImagePicker: View {
    @Binding var selectedImage: UIImage?
    let footballImages: [String]

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Choose a Football Image")
                .font(.title)
                .padding()

            ScrollView(.vertical) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 20) {
                    ForEach(footballImages, id: \.self) { imageName in
                        Button(action: {
                            if let image = UIImage(named: imageName) {
                                selectedImage = image
                                presentationMode.wrappedValue.dismiss()
                            }
                        }) {
                            Image(imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipped()
                                .border(Color.gray, width: 2)
                        }
                    }
                }
            }
            .padding()

            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Close")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}
