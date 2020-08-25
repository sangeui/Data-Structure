import Foundation

public struct RingBuffer<T> {
    private var array: [T?]
    private var readIndex = 0
    private var writeIndex = 0
    
    public init(count: Int) {
        array = [T?](repeating: nil, count: count)
    }
}
extension RingBuffer {
    // Ring buffer 쓰기 연산
    public mutating func write(_ element: T) -> Bool {
        if !isFull {
            array[writeIndex % array.count] = element; writeIndex += 1
            return true
        } else {
            return false
        }
    }
}
extension RingBuffer {
    // Ring buffer 읽기 연산
    public mutating func read() -> T? {
        if !isEmpty {
            let element = array[readIndex & array.count]; readIndex += 1
            return element
        } else {
            return nil
        }
    }
}
extension RingBuffer {
    private var availableSpaceForReading: Int {
        print(writeIndex - readIndex)
        return writeIndex - readIndex
    }
    private var availableSpaceForWriting: Int {
        return array.count - availableSpaceForReading
    }
    public var isEmpty: Bool {
        return availableSpaceForReading == 0
    }
    public var isFull: Bool {
        return availableSpaceForWriting == 0
    }
}
