import Foundation

public class DoublyLinkedList<T> {
    private var head: Node<T>?
    private var tail: Node<T>?
    
    public init() {}
    
    public var isEmpty: Bool { head == nil }
    public var first: Node<T>? { head }
}
// MARK: - Add Value
extension DoublyLinkedList {
    public func append(_ value: T) {
        let newNode = Node(value: value)
        
        guard let tailNode = tail else {
            head = newNode
            tail = newNode
            return
        }
        
        newNode.previous = tailNode
        tailNode.next = newNode
        tail = newNode
    }
}
// MARK: - Remove node
extension DoublyLinkedList {
    public func remove(_ node: Node<T>) -> T {
        let prev = node.previous
        let next = node.next
        
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        
        next?.previous = prev
        
        if next == nil {
            tail = prev
        }
        
        node.previous = nil
        node.next = nil
        
        return node.value
    }
}
// MARK: - CustomStringConvertible
extension DoublyLinkedList: CustomStringConvertible {
    public var description: String {
        var string = ""
        var current = head
        while let node = current {
            string.append("\(node.value) -> ")
            current = node.next
        }
        
        return string + "end"
    }
}
// MARK: - Sequence
extension DoublyLinkedList: Sequence {
    public func makeIterator() -> LinkedListIterator<T> {
        LinkedListIterator(node: head)
    }
}
