import Foundation

public struct QueueStack<T>: QueueProtocol {
    private var dequeueStack: [T] = []
    private var enqueueStack: [T] = []
    public init() {}
    
    public var isEmpty: Bool {
        dequeueStack.isEmpty && enqueueStack.isEmpty
    }
    public var peek: T? {
        dequeueStack.isEmpty ? enqueueStack.first : dequeueStack.last
//        !dequeueStack.isEmpty ? dequeueStack.last : enqueueStack.first
    }
}
extension QueueStack {
    public mutating func enqueue(_ element: T) -> Bool {
        enqueueStack.append(element)
        return true
    }
}
extension QueueStack {
    public mutating func dequeue() -> T? {
        if dequeueStack.isEmpty {
            dequeueStack = enqueueStack.reversed()
            enqueueStack.removeAll()
        }
        return dequeueStack.popLast()
    }
}


