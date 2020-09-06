import Foundation

public protocol Queue {
    associatedtype Element
    mutating func enqueue(_ element: Element) -> Bool
    mutating func dequeue() -> Element?
    var isEmpty: Bool { get }
    var peek: Element? { get }
}

struct PriorityQueue<Element: Equatable>: Queue {
    private var heap: Heap<Element>
    
    var isEmpty: Bool { return heap.isEmpty }
    var peek: Element? { return heap.peek() }
    
    init(sort: @escaping (Element, Element) -> Bool, elements: [Element] = []) {
        heap = Heap(sort: sort, elements: elements)
    }
}

extension PriorityQueue {
    mutating func enqueue(_ element: Element) -> Bool {
        heap.insert(element)
        return true
    }
    mutating func dequeue() -> Element? {
        return heap.remove()
    }
}
