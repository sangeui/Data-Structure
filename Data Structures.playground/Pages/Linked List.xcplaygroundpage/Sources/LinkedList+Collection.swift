import Foundation

// Becoming a Swift collection
extension LinkedList: Collection {
    public struct Index: Comparable {
        public var node: Node<Value>?
        static public func ==(lhs: Index, rhs: Index) -> Bool {
            switch (lhs.node, rhs.node) {
            case let (left?, right?):
                return left.next === right.next
            case (nil, nil):
                return true
            default:
                return false
            }
        }
        
        static public func <(lhs: Index, rhs: Index) -> Bool {
            guard lhs != rhs else { return false }
            let nodes = sequence(first: lhs.node) { $0?.next }
            return nodes.contains { $0 === rhs.node }
        }
    }
    // startIndex 는 당연히 연결 리스트의 head 가 된다.
    public var startIndex: Index {
        Index(node: head)
    }
    // Collection 은 endIndex 를 접근 가능한 마지막 value 의 다음 index 로 정의한다.
    // 따라서 endIndex 는 tail 의 next 이다.
    public var endIndex: Index {
        Index(node: tail?.next)
    }
    // index(after:) 메소드는 index 가 어떻게 증가될 것인가에 대해 정의한다.
    public func index(after i: Index) -> Index {
        Index(node: i.node?.next)
    }
    //
    public subscript(position: Index) -> Value {
        position.node!.value
    }    
}
