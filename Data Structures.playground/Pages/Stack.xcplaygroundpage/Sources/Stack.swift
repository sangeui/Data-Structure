import Foundation

public struct Stack<Element> {
    private var storage: [Element] = []
    
    public init() {}
}

extension Stack: CustomStringConvertible {
    public var description: String {
        """
        ----top----
        """
    }
}
