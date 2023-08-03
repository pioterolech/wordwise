import Swinject
import OpenAI

final class AppDependencies {
    private let container = Container()

    func register() {
        container.register(OpenAIToken.self) { _ in
            OpenAIToken(value: "")
        }
        
        container.register(OpenAI.self) { r in
            let token = r.resolve(OpenAIToken.self)!
            return OpenAI(apiToken: token.value)
        }
        
        container.register(OpenAIClient.self) { r in
            OpenAIClient(client: r.resolve(OpenAI.self)!)
        }
    }
    
    func resolve<T>() -> T {
        
        return container.resolve(T.self)!
    }
}
