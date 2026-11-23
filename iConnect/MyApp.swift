import SwiftUI

@main struct MyApp: App {
    
    @State private var progress: AppData.Progress?
    @State private var connectionType: AppData.ConnectionType = .studentConnect
    @Environment(AppData.self) private var appData
    
    var body: some Scene {
        WindowGroup {
            switch progress {
            case .overview:
                iConnectOverview(progress: $progress)
            case .home:
                iConnectHome(progress: $progress)
            case .profile:
                Profile(progress: $progress)
            case .connectionSelector:
                ConnectionSelector(progress: $progress)
            case .searchScreen:
                SearchScreen(progress: $progress)
            case .matchScreen:
                switch connectionType {
                case .studentConnect:
                    StudentMatchScreen(connectionType: $connectionType)
                case .homeLink:
                    FamilyMatchScreen(connectionType: $connectionType)
                case .penPal:
                    PenPalMatchScreen(connectionType: $connectionType)
                }
            case nil:
                Home(progress: $progress)
            }
        }
        .environment(AppData())
    }
}
