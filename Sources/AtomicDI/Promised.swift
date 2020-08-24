final class Promised<Value> {
    private var _value: Value?

    init(value: Value? = nil) {
        self._value = value
    }

    func set(value: Value) {
        guard _value == nil else {
            preconditionFailure()
        }

        _value = value
    }

    func get() -> Value {
        guard let value = _value else {
            preconditionFailure()
        }

        return value
    }
}
