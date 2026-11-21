import SwiftUI

struct CustomTabBar: View {

    private let selectedBlue = Color(red: 0.10, green: 0.42, blue: 0.80)

    private let items: [(title: String, symbol: String)] = [
        ("My Campus", "house.fill"),
        ("Settings", "gearshape"),
        ("Calendar", "calendar"),
        ("Alerts", "bell"),
        ("Search", "magnifyingglass")
    ]

    var body: some View {
        HStack(spacing: 25) {
            ForEach(items, id: \.title) { item in

                VStack(spacing: 5) {

                    Image(systemName: item.symbol)
                        .font(.system(size: 18, weight: .medium))

                    Text(item.title)
                        .font(.system(size: 12, weight: .bold))
                }
                .foregroundStyle(
                    item.title == "My Campus" ? selectedBlue : .black
                )
            }
        }
        .frame(maxWidth: .infinity)
    }
}
