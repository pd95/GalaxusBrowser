//
//  ContentView.swift
//  GalaxusBrowser
//
//  Created by Philipp on 19.03.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            LiveShopping()
                .tabItem {
                    Label("Tagesangebot", systemImage: "target")
                }

            BrowseProducts()
                .tabItem {
                    Label("Browse", systemImage: "tortoise")
                }
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
