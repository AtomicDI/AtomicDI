@dynamicMemberLookup
public struct Container<Dependencies> where Dependencies: ExportedDependencies {
    let dependencies: Dependencies

    public subscript<T>(dynamicMember keyPath: KeyPath<Dependencies, T>) -> T {
        dependencies[keyPath: keyPath]
    }

    public subscript<T>(dynamicMember keyPath: KeyPath<Container<Dependencies.Parent>, T>) -> T {
        Container<Dependencies.Parent>(dependencies: dependencies.parentExport)[keyPath: keyPath]
    }

    public subscript<T>(dynamicMember keyPath: KeyPath<ExportedDependenciesExtensions<Dependencies>, T>) -> T {
        ExportedDependenciesExtensions(promisedDependencies: Promised(value: dependencies))[keyPath: keyPath]
    }
}

public struct ExportedDependenciesExtensions<Dependencies> where Dependencies: ExportedDependencies {
    let promisedDependencies: Promised<Dependencies>

    public var factoryMaker: FactoryMaker<Dependencies> {
        FactoryMaker(promisedExport: promisedDependencies)
    }
}
