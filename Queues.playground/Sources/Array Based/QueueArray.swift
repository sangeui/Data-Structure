import Foundation

// MARK: - Array-based implementation
public struct QueueArray<T>: QueueProtocol {
    private var array: [T] = []
    public init() {}
    
    public var isEmpty: Bool {
        array.isEmpty
    }
    public var peek: T? {
        array.first
    }
}
// MARK: - Array-based Queue 의 enqueue 연산
extension QueueArray {
    public mutating func enqueue(_ element: T) -> Bool {
        // 배열의 마지막에 element 를 삽입하는 것 뿐이므로
        // O(1) 의 시간 복잡도를 가진다
        array.append(element)
        return true
    }
}
// MARK: - Array-based Queue 의 dequeue 연산
extension QueueArray {
    public mutating func dequeue() -> T? {
        // enqueue 연산과는 달리 dequeue 연산 이후 메모리 이동이 일어나므로
        // 매 연산마다 O(n) 시간복잡도가 발생한다.
        isEmpty ? nil : array.removeFirst()
    }
}
// MARK: - CustomStringConvertible
extension QueueArray: CustomStringConvertible {
    public var description: String {
        String(describing: array)
    }
}
