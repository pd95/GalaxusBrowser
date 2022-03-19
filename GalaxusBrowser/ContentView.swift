//
//  ContentView.swift
//  GalaxusBrowser
//
//  Created by Philipp on 19.03.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ProductView(product: .example)
            .border(Color.black)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
