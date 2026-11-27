import SwiftUI

struct Home: View {

    @State private var tapped = false
    @Environment(AppData.self) private var appData
    @Binding var progress: AppData.Progress?

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        VStack(spacing: 20) {

            // University logo at the top
            Image("UoBLogo")
                .resizable()
                .scaledToFit()
                .frame(height: 65)
                .frame(maxWidth: .infinity)
                .padding(.top, 10)

            // Scrollable button grid
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {

                    Button {
                        tapped.toggle()
                        print("Search UoB tapped")
                    } label: {
                        Text("Search UoB")
                            .rockwellFont(22)
                    }
                    .buttonStyle(.custom(variant: .cutout))
                    .frame(height: 125)
                    .sensoryFeedback(.success, trigger: tapped)

                    Button {
                        tapped.toggle()
                        print("Maps tapped")
                    } label: {
                        Text("Maps")
                            .rockwellFont(22)
                    }
                    .buttonStyle(.custom(variant: .cutout))
                    .frame(height: 125)
                    .sensoryFeedback(.success, trigger: tapped)

                    Button {
                        tapped.toggle()
                        print("Blackboard tapped")
                    } label: {
                        Text("Blackboard")
                            .rockwellFont(19)
                    }
                    .buttonStyle(.custom(variant: .cutout))
                    .frame(height: 125)
                    .sensoryFeedback(.success, trigger: tapped)
                }
                .padding()
                
                LazyVGrid(columns: columns, spacing: 12) {

                    Button {
                        tapped.toggle()
                        print("iConnect tapped")
                        if appData.hasConnected {
                            progress = .overview
                        } else if appData.hasCreatedProfile {
                            progress = .connectionSelector
                        } else {
                            progress = .home
                        }
                    } label: {
                        Text("iConnect")
                            .rockwellFont(22)
                    }
                    .buttonStyle(.custom(variant: .cutout))
                    .frame(height: 125)
                    .sensoryFeedback(.success, trigger: tapped)

                    Button {
                        tapped.toggle()
                        print("Support tapped")
                    } label: {
                        Text("Support")
                            .rockwellFont(22)
                    }
                    .buttonStyle(.custom(variant: .cutout))
                    .frame(height: 125)
                    .sensoryFeedback(.success, trigger: tapped)

                    Button {
                        tapped.toggle()
                        print("Security tapped")
                    } label: {
                        Text("Security")
                            .rockwellFont(22)
                    }
                    .buttonStyle(.custom(variant: .cutout))
                    .frame(height: 125)
                    .sensoryFeedback(.success, trigger: tapped)
                }
                .padding()
                
                LazyVGrid(columns: columns, spacing: 12) {

                    Button {
                        tapped.toggle()
                        print("Careers tapped")
                    } label: {
                        Text("Careers")
                            .rockwellFont(22)
                    }
                    .buttonStyle(.custom(variant: .cutout))
                    .frame(height: 125)
                    .sensoryFeedback(.success, trigger: tapped)

                    Button {
                        tapped.toggle()
                        print("Study tapped")
                    } label: {
                        Text("Study")
                            .rockwellFont(22)
                    }
                    .buttonStyle(.custom(variant: .cutout))
                    .frame(height: 125)
                    .sensoryFeedback(.success, trigger: tapped)

                    Button {
                        tapped.toggle()
                        print("Find & Book tapped")
                    } label: {
                        Text("Find & Book")
                            .rockwellFont(22)
                    }
                    .buttonStyle(.custom(variant: .cutout))
                    .frame(height: 125)
                    .sensoryFeedback(.success, trigger: tapped)
                }
                .padding()
                
                Button {
                    tapped.toggle()
                    print("Record attendance tapped")
                } label: {
                    Text("Record attendance")
                        .rockwellFont(30)
                }
                .buttonStyle(.custom(variant: .regular))
                .padding(10)
                .frame(height: 125)
                .sensoryFeedback(.success, trigger: tapped)
            }
            
            CustomTabBar()
        }
    }
}

#Preview {
    Home(progress: .constant(nil))
        .environment(AppData())
}


