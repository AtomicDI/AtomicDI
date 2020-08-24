public struct Scope<FunctionResult, Export> where Export: ExportedDependencies {
    public let result: FunctionResult
    public let export: Export

    public init(result: FunctionResult, export: Export) {
        self.result = result
        self.export = export
    }
}
