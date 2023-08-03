import OpenAI
import Foundation

public protocol OpenAIClientProtocol {
    func executeQuestion(question: String) async throws -> String
}

public struct OpenAIClient: OpenAIClientProtocol {
    private let client: OpenAI
    
    public init(client: OpenAI) {
        self.client = client
    }
    
    public func executeQuestion(question: String) async throws -> String {
        let query = ChatQuery(model: .gpt3_5Turbo,
                              messages: [.init(role: .user, content: question)])

        guard let response = try await client.chats(query: query).choices.first?.message.content else {
            throw OpenAIError.emptyResponse
        }

        return response
    }
    
    public func executeAndDecode<T: Decodable>(question: String) async throws -> T {
        let response = try await executeQuestion(question: question)
        
        print(response)
        
        guard let data = response.data(using: .utf8) else {
            throw OpenAIError.unableToConvertStringToData
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    public func getDifficultWordsFromArticle(article: String) async throws -> DifficultWords {
        let extractPart = "Can you extract words from an article that might be difficult for a C1 english student, "
        let translate = "translate them to polish language, "
        let sentence = "provide example sentence from that article, "
        let translateSentence = "and translate that sentence, "
        let swiftStruct = """
        {
            "value": "landed",
            "translation": "przymuszenie",
            "exampleSentence": "His success at The Skirvin Hotel ultimately landed him at a culinary school.",
            "translatedExampleSentence: "Jego sukces osiagniety w hotelu Skirvin doprowadzil go do szkoly kulinarnej."
        }
        """
        let json = "provide them as a json output with will map to the json array with key \"words\"  and structure of element same as \n " + swiftStruct + " \n "
        let article = "Article to transform: \n \(article)"
        let question = extractPart + translate + sentence + translateSentence + json + article
        
        return try await executeAndDecode(question: question)
    }
}

