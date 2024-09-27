////
//// NavigationView for pages
//
//import SwiftUI
//
//struct Page9: View {
//    var body: some View {
//        NavigationView {
//            List {
//                NavigationLink {
//                    ChelseaView()
//                } label: {
//                    Text("Chelsea")
//                }
//                NavigationLink {
//                    ManUView()
//                } label: {
//                    Text("Manchester United")
//                }
//                NavigationLink {
//                    LiverpoolView()
//                } label: {
//                    Text("Liverpool")
//                }
//                NavigationLink {
//                    ArsenalView()
//                } label: {
//                    Text("Arsenal")
//                }
//            }
//        }
//        .navigationTitle("My Shapes")
//    }
//}
//
//struct Page9_Previews: PreviewProvider {
//    static var previews: some View {
//        Page9()
//    }
//}
//

import SwiftUI

struct Page0: View {
    var body: some View {
        NavigationView {
            VStack {
                // Add a heading at the top
                Text("Football Clubs - Random Facts")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                // List of football clubs
                List {
                    NavigationLink {
                        ChelseaView()
                    } label: {
                        Text("Chelsea")
                    }
                    NavigationLink {
                        ManUView()
                    } label: {
                        Text("Manchester United")
                    }
                    NavigationLink {
                        LiverpoolView()
                    } label: {
                        Text("Liverpool")
                    }
                    NavigationLink {
                        ArsenalView()
                    } label: {
                        Text("Arsenal")
                    }
                }
            }
        }
        .navigationTitle("Football Clubs")
    }
}

struct Page0_Previews: PreviewProvider {
    static var previews: some View {
        Page0()
    }
}
