import SwiftUI

@main struct MyApp: App {
    
    @State private var progress: AppData.Progress?
    @State private var connectionType: AppData.ConnectionType = .studentConnect
    @State private var appData = AppData()
    
    var body: some Scene {
        WindowGroup {
            Group {
                switch progress {
                case .overview:
                    iConnectOverview(progress: $progress, connectionType: $connectionType)
                case .home:
                    iConnectHome(progress: $progress)
                case .profile:
                    Profile(progress: $progress)
                case .connectionSelector:
                    ConnectionSelector(progress: $progress, connectionType: $connectionType)
                case .searchScreen:
                    SearchScreen(progress: $progress, connectionType: $connectionType)
                case .matchScreen:
                    switch connectionType {
                    case .studentConnect:
                        StudentMatchScreen(connectionType: $connectionType, progress: $progress)
                    case .homeLink:
                        FamilyMatchScreen(connectionType: $connectionType, progress: $progress)
                    case .penPal:
                        PenPalMatchScreen(connectionType: $connectionType, progress: $progress)
                    }
                case nil:
                    Home(progress: $progress)
                }
            }
            .onAppear {
                if let savedType = appData.selectedConnectionType {
                    connectionType = savedType
                }
            }
        }
        .environment(appData)
    }
}
