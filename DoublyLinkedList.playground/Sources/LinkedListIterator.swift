import Foundation

// MARK: - IteratorProtocol
public class LinkedListIterator<T>: IteratorProtocol {
    private var current: Node<T>?
    init(node: Node<T>?) {
        current = node
    }
    public func next() -> Node<T>? {
        defer { current = current?.next }
        return current
    }
}
