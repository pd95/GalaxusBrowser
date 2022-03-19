//
//  ContentView.swift
//  GalaxusBrowser
//
//  Created by Philipp on 19.03.22.
//

import SwiftUI

enum MainTabs: String {
    case liveShopping
    case browseProducts
}

struct ContentView: View {
    @AppStorage("selectedTab") var selectedTab: MainTabs = .liveShopping

    var body: some View {
        TabView(selection: $selectedTab) {
            LiveShopping()
                .tabItem {
                    Label("Tagesangebot", systemImage: "target")
                }
                .tag(MainTabs.liveShopping)

            BrowseProducts()
                .tabItem {
                    Label("Browse", systemImage: "tortoise")
                }
                .tag(MainTabs.browseProducts)
        }
    }
}

struct LiveShopping: View {
    var body: some View {
        NavigationView {
            VStack {
                ProductView(product: .example)
                    .navigationTitle("Tagesangebot")
                Spacer()
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct BrowseProducts: View {
    var body: some View {
        NavigationView {
        }
        .navigationViewStyle(.stack)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
