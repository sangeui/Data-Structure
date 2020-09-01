import Foundation

public class BinaryNode<Element> {
    // Binary Tree 는 각각의 노드가 최대 한 쌍의 자식 노드를 가질 수 있다.
    public var value: Element
    public var left: BinaryNode?
    public var right: BinaryNode?
    
    public init(value: Element) {
        self.value = value
    }
}

public extension BinaryNode {
    typealias Visit = (Element) -> Void
    
    func preorder(visit: Visit) {
        visit(value)
        left?.preorder(visit: visit)
        right?.preorder(visit: visit)
    }
    func postorder(visit: Visit) {
        left?.postorder(visit: visit)
        right?.postorder(visit: visit)
        visit(value)
    }
    func inorder(visit: Visit) {
        left?.inorder(visit: visit)
        visit(value)
        right?.inorder(visit: visit)
    }
}
