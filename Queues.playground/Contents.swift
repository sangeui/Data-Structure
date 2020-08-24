import Foundation

public class QueueLinkedList<T>: QueueProtocol {
    private var list = DoublyLinkedList<T>()
    public init() {}
}
