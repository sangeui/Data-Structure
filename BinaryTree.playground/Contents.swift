import Foundation

public class BinaryNode<Element> {
    public var value: Element
    public var leftChild: BinaryNode<Element>?
    public var rightChild: BinaryNode<Element>?
    
    public init(value: Element) {
        self.value = value
    }
}
