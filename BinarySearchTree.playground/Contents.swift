import Foundation

/*
 A binary search tree, or BST, is a data structure that facilitates fast,
 insert and removal operations.
 */

// The value of a left child must be less than the value of its parent.
// The value of a right child must be greater than or equal to the value of its parent.

struct BinarySearchTree<Element: Comparable> {
    public private(set) var root: BinaryNode<Element>?
    public init() {}
}

//Inserting elements
extension BinarySearchTree {
    public mutating func insert(_ value: Element) {
        root = insert(from: root, value: value)
    }
    private func insert(from node: BinaryNode<Element>?, value: Element) -> BinaryNode<Element> {
        // 재귀 호출을 종료하기 위한 베이스 케이스
        guard let node = node else { return BinaryNode(value: value) }
        
        // 새로운 값을 현재 노드의 값과 비교한다.
        if value < node.value {
            node.left = insert(from: node.left, value: value)
        } else {
            node.right = insert(from: node.right, value: value)
        }
        
        return node
    }
}

extension BinarySearchTree: CustomStringConvertible {
    var description: String {
        guard let root = root else { return "Empty" }
        return String(describing: root)
    }
}
