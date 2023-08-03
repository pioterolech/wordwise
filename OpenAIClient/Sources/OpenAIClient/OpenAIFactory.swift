public final class OpenAIFactory {
    public static func create() -> OpenAIClient {
        let dependencies = AppDependencies()
        dependencies.register()
        return dependencies.resolve()
    }
}
