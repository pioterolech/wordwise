struct Config: Codable {
    let openAIKey: String
    
    private enum CodingKeys : String, CodingKey {
        case openAIKey =  "open_ai_key"
    }
}

extension Config {
    static var empty: Config {
        return .init(openAIKey: "")
    }
}
 
