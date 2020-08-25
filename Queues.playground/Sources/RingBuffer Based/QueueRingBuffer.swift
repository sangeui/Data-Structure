import Foundation

public struct QueueRingBuffer<T>: QueueProtocol {
    private var ringBuffer: RingBuffer<T>
    
    public init(count: Int) {
        ringBuffer = RingBuffer<T>(count: count)
    }
    public var isEmpty: Bool {
        ringBuffer.isEmpty
    }
    public var peek: T? {
        ringBuffer.first
    }
}
// MARK: - Enqueue
extension QueueRingBuffer {
    public mutating func enqueue(_ element: T) -> Bool {
        ringBuffer.write(element)
    }
}
// MARK: - Dequeue
extension QueueRingBuffer {
    public mutating func dequeue() -> T? {
        ringBuffer.read()
    }
}
// MARK: - CustomStringConvertible
extension QueueRingBuffer: CustomStringConvertible {
    public var description: String {
        String(describing: ringBuffer)
    }
}
