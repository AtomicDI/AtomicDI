@dynamicMemberLookup
public struct Context<Dependencies> where Dependencies: ExportedDependencies {
    private let _parentExport: Dependencies.Parent?

    init(parentExport: Dependencies.Parent?) {
        self._parentExport = parentExport
    }

    public var parentExport: Dependencies.Parent {
        guard let parentExport = _parentExport else {
            fatalError("Root doesn't have dependencies")
        }

        return parentExport
    }

    private let promisedExport = Promised<Dependencies>()
}

extension Context {
    public subscript<T>(dynamicMember keyPath: KeyPath<Container<Dependencies.Parent>, T>) -> T {
        Container(dependencies: parentExport)[keyPath: keyPath]
    }

    public subscript<T>(dynamicMember keyPath: KeyPath<ExportedDependenciesExtensions<Dependencies>, T>) -> T {
        ExportedDependenciesExtensions(promisedDependencies: promisedExport)[keyPath: keyPath]
    }
}

extension Context {
    static func makeScope<FunctionResult>(
        _ dependencies: Dependencies.Parent?,
        _ make: (Context) -> Scope<FunctionResult, Dependencies>
    ) -> FunctionResult {
        let context = Context(parentExport: dependencies)
        let scope = make(context)
        context.promisedExport.set(value: scope.export)
        return scope.result
    }
}
