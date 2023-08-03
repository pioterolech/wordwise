//
//  ContentView.swift
//  WordWise
//
//  Created by Piotr Olechnowicz on 8/3/23.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    var body: some View {
        FeatureView(
            store: Store(initialState: ExportWordsFeature.State(words: [])) {
              ExportWordsFeature()
          }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
