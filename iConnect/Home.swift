import SwiftUI
import Playgrounds

struct Home: View {
    
    @State private var tapped = false
    
    var body: some View {
        
        Button {
            print("Maps tapped")
        } label: {
            Text("Maps")
                .rockwellFont(28)

        }
        .buttonStyle(.custom(variant: .cutout))
        .frame(width: 150, height: 150)
        .sensoryFeedback(.success, trigger: tapped)
        
        
    }
}   

#Preview {
    Home()
}


