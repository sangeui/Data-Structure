//: [Previous](@previous)

import Foundation

var list = LinkedList<Int>()
list.push(value: 3)
list.push(value: 2)

print(list)

list.append(value: 4)

print(list)

if let node = list.search(at: 1) {
    list.insert(value: 1, after: node)
    print(list)
}

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
    public mutating func push(value: Value) {
        // 연결 리스트의 가장 앞에 파라미터로 전달 받은 값을 갖는 노드를 더함.
        head = Node(value: value, next: head)
        if tail == nil { tail = head }
    }
    public mutating func append(value: Value) {
        // 연결 리스트의 마지막에 파라미터로 전달 받은 값을 갖는 노드를 더함.
        guard isEmpty == false else {
            push(value: value)
            return
        }
        tail!.next = Node(value: value)
        tail = tail!.next
    }
    @discardableResult
    public mutating func insert(value: Value, after node: Node<Value>) -> Node<Value> {
        // 파라미터로 전달 받은 노드의 뒤에 value 값을 갖는 노드를 더함.
        // 기준 노드를 인자로 전달 받으므로 해당 노드를 탐색할 수 있는 헬퍼 메소드가 필요함.
        guard tail !== node else {
            // 연결 리스트의 마지막 노드가 탐색된 노드라면 바로 append 메소드를 호출하고 리턴.
            append(value: value)
            return tail!
        }
        
        node.next = Node(value: value, next: node.next)
        
        return node.next!
    }
}
// MARK: - Helper Methods
extension LinkedList {
    public func search(at index: Int) -> Node<Value>? {
        // 인자로 전달 받은 정수 값에 해당하는 인덱스의 노드를 찾는다.
        var currentNode = head
        var currentIndex = 0
        
        while currentNode != nil && currentIndex < index {
            // head 부터 시작하여 순차 탐색을 하므로 O(n) 의 계산 복잡도를 가진다.
            currentNode = currentNode!.next
            currentIndex += 1
        }
        
        return currentNode
    }
}
extension LinkedList: CustomStringConvertible {
    public var description: String {
        guard let head = head else { return "Empty List" }
        return String(describing: head)
    }
}



//: [Next](@next)
