import ComposableArchitecture
import SwiftUI

struct FeatureView: View {
  let store: StoreOf<ExportWordsFeature>

  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      VStack {
        HStack {
            Text("\(viewStore.words.count)")
        }
        Button("Number fact") { viewStore.send(.executeWordsAPICall) }
      }
    }
  }
}
