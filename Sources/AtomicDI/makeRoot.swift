public func makeRoot<RootObject, Export>(_ make: (Context<Export>) -> Scope<RootObject, Export>) -> RootObject
    where Export : ExportedRootDependencies
{
    Context<Export>.makeScope(nil, make)
}
