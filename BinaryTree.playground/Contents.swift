import Foundation

var root = BinaryNode(value: 10)
root.left = BinaryNode(value: 11)
root.right = BinaryNode(value: 12)

root.preorder { print($0) }     // root 노드가 가장 먼저 출력된다.
root.postorder { print($0) }    // root 노드가 가장 늦게 출력된다.
root.inorder { print($0) }      // root 노드는 왼쪽 자식노드 이후에 출력된다.
