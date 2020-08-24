public protocol ExportedDependencies {
    associatedtype Parent: ExportedDependencies

    var parentExport: Parent { get }
}

public protocol ExportedRootDependencies: ExportedDependencies where Parent == Never { }

extension ExportedRootDependencies {
    public var parentExport: Never { fatalError() }
}

extension Never: ExportedDependencies {
    public var parentExport: Never { fatalError() }
}

public struct EmptyExports<Parent>: ExportedDependencies where Parent: ExportedDependencies {
    public let parentExport: Parent

    public init(parentExport: Parent) {
        self.parentExport = parentExport
    }
}
