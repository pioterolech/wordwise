import ComposableArchitecture

struct ExportWordsFeature: Reducer {
    struct State: Equatable {
        var words: [String]
    }
    
    enum Action: Equatable {
        case wordsReceived([String])
        case executeWordsAPICall
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .executeWordsAPICall:
            return .run { send in
                let result = ["1", "2", "3"]
                await send(
                    .wordsReceived(result)
                )
            }
        case .wordsReceived(let words):
            state.words = words
            return .none
        }
    }
}

