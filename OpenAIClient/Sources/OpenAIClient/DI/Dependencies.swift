import Swinject
import OpenAI
import Foundation

final class AppDependencies {
    private let container = Container()

    func register() {
        container.register(Config.self) { _ in
            guard let configUrl = Bundle.main.url(forResource: "config", withExtension: "json") else {
                return .empty
            }
            
            do {
                let decoder = JSONDecoder()
                let data = try Data(contentsOf: configUrl)
                let decodedConfig = try decoder.decode(Config.self, from: data)
                return decodedConfig
            } catch {
                return .empty
            }
        }
        
        container.register(OpenAI.self) { r in
            let config = r.resolve(Config.self)!
            return OpenAI(apiToken: config.openAIKey)
        }
        
        container.register(OpenAIClient.self) { r in
            OpenAIClient(client: r.resolve(OpenAI.self)!)
        }
    }
    
    func resolve<T>() -> T {
        container.resolve(T.self)!
    }
}
