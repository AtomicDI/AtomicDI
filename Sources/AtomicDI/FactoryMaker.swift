public struct FactoryMaker<Dependencies> where Dependencies: ExportedDependencies {
    let promisedExport: Promised<Dependencies>

    public func make<Export, FunctionResult>(
        _ make: @escaping (Context<Export>) -> Scope<FunctionResult, Export>
    ) -> () -> FunctionResult
        where Export: ExportedDependencies, Export.Parent == Dependencies
    {
        { () -> FunctionResult in
            Context<Export>.makeScope(self.promisedExport.get()) {
                make($0)
            }
        }
    }

    public func make<Export, A0, FunctionResult>(
        _ make: @escaping (Context<Export>, A0) -> Scope<FunctionResult, Export>
    ) -> (A0) -> FunctionResult
        where Export: ExportedDependencies, Export.Parent == Dependencies
    {
        { a -> FunctionResult in
            Context<Export>.makeScope(self.promisedExport.get()) {
                make($0, a)
            }
        }
    }

    public func make<Export, A0, A1, FunctionResult>(
        _ make: @escaping (Context<Export>, A0, A1) -> Scope<FunctionResult, Export>
    ) -> (A0, A1) -> FunctionResult
        where Export: ExportedDependencies, Export.Parent == Dependencies
    {
        { a0, a1 -> FunctionResult in
            Context<Export>.makeScope(self.promisedExport.get()) {
                make($0, a0, a1)
            }
        }
    }

    public func make<Export, A0, A1, A2, FunctionResult>(
        _ make: @escaping (Context<Export>, A0, A1, A2) -> Scope<FunctionResult, Export>
    ) -> (A0, A1, A2) -> FunctionResult
        where Export: ExportedDependencies, Export.Parent == Dependencies
    {
        { a0, a1, a2 -> FunctionResult in
            Context<Export>.makeScope(self.promisedExport.get()) {
                make($0, a0, a1, a2)
            }
        }
    }
}
