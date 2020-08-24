import Foundation

public class QueueLinkedList<T>: QueueProtocol {
    private var list = DoublyLinkedList<T>()
    public init() {}
    
    public var peek: T? {
        list.first?.value
    }
    public var isEmpty: Bool {
        list.isEmpty
    }
}
// MARK: - Enqueue
extension QueueLinkedList {
    public func enqueue(_ element: T) -> Bool {
        list.append(element)
        return true
    }
}
// MAKR: - Dequeue
extension QueueLinkedList {
    public func dequeue() -> T? {
        guard !list.isEmpty, let element = list.first else {
            return nil
        }
        return list.remove(element)
    }
}
// MARK: - CustomStringConvertible
extension QueueLinkedList: CustomStringConvertible {
    public var description: String {
        String(describing: list)
    }
}
