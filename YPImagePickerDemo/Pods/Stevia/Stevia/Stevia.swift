import Foundation

// MARK: - Closures

func *(count: Int, closure: () -> ()) {
    for _ in 1...count {
        closure()
    }
}


// MARK: - Comparison operators

infix operator ⩵ { precedence 130 }

func ⩵<T:Equatable>(left: T, right: T) -> Bool {
    return left == right
}

infix operator ≠ { precedence 130 }

func ≠<T:Equatable>(left: T, right: T) -> Bool {
    return left != right
}

infix operator ≤ { precedence 130 }

func ≤<T:Comparable>(left: T, right: T) -> Bool {
    return left <= right
}

infix operator ≥ { precedence 130 }

func ≥<T:Comparable>(left: T, right: T) -> Bool {
    return left >= right
}


// MARK: - Arrays

public func +<Element>(left: [Element], right: Element) -> Array<Element> {
    return left + [right]
}

public func +<Element>(left: Element, right: [Element]) -> Array<Element> {
    return [left] + right
}
