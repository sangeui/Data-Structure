import Foundation

/// 스택 기본 구현체, 백업 스토리지로 Array 를 사용한다.
public struct Stack<Element> {
    private var storage: [Element] = []
    public init() {}
    public init(_ elements: [Element]) {
        storage = elements
    }
}
extension Stack {
    /// 스택의 push 연산
    /// 백업 Array 스토리지의 append 메소드를 호출함.
    public mutating func push(_ element: Element) {
        storage.append(element)
    }
}
extension Stack {
    /// 스택의 pop 연산
    /// 백업 Array 스토리지의 popLast 를 호출함.
    /// 이는 Generic 타입에 해당하는 값을 optional 로 돌려줌.
    public mutating func pop() -> Element? {
        storage.popLast()
    }
}
extension Stack {
    /// 스택의 peek 연산
    /// 백업 Array 스토리지의 last 변수를 통해
    /// 값의 존재 유무를 확인함.
    public func peek() -> Element? {
        storage.last
    }
    /// 스택의 isEmpty 변수
    /// peek 연산을 통해 스토리지의 값 존재 유무를 확인함.
    public var isEmpty: Bool {
        peek() == nil
    }
}
// MARK: Stack+ExpressibleByArrayLiteral
extension Stack: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        storage = elements
    }
}
// MARK: Stack+CustomStringConvertible
extension Stack: CustomStringConvertible {
    public var description: String {
        """
        ----top----
        \(storage.map { "\($0)" }
        .reversed()
        .joined(separator: "\n"))
        """
    }
}
