//: [Previous](@previous)

import Foundation

// Value 타입의 값과 다음 Node 를 옵셔널로 가짐
// Node 만으로도 연결된 리스트를 구성할 수 있지만
// 실용적이지 못하므로 Linked List 라는 노드 컨테이너를 만들어 이를 관리한다.
public class Node<Value> {
    public var value: Value
    public var next: Node?
    
    public init(value: Value, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

extension Node: CustomStringConvertible {
    public var description: String {
        guard let next = next else { return "\(value)" }
        return "\(value) -> " + String(describing: next) + " "
    }
}

public struct LinkedList<Value> {
    // 변수 이름 그대로 연결 리스트의 양끝을 각각 가진다.
    public var head: Node<Value>?
    public var tail: Node<Value>?
    
    public init() {}
    
    // tail 이 nil 이더라도 연결 리스트에는 하나의 노드가 존재할 수 있으나
    // head 가 nil 이라는 것은 연결 리스트가 비어있음을 나타낸다.
    public var isEmpty: Bool {
        self.head == nil
    }
}
extension LinkedList {
    // 연결 리스트의 Adding 연산
    // 스택과 달리 어느 곳이든 노드가 더해질 수 있다.
    // 따라서 연결 리스트의 더하기 연산에는
    // 1. Push (앞) 2. Append (뒤) 3. Insert (중간)
    // 총 세 가지의 연산이 있다.
    public func push(value: Value) {}
    public func append(value: Value) {}
    public func insert(value: Value, after node: Node<Value>) -> Node<Value> {}
}
extension LinkedList: CustomStringConvertible {
    public var description: String {
        guard let head = head else { return "Empty List" }
        return String(describing: head)
    }
}



//: [Next](@next)
