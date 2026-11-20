import SwiftUI
import Playgrounds

struct Home: View {
    var body: some View {
        Button {
            print("Search UoB tapped")
        } label: {
            Text("Search UoB")
        }
        .buttonStyle(.custom(variant: .cutout))
        .frame(width: 150, height: 150)
        
        
    }
}   

#Preview {
    Home()
}


