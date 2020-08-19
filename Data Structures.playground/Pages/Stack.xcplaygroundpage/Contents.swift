//: [Previous](@previous)

import Foundation

example(of: "Test") {
    var stack = Stack<Int>()
    stack.push(1)
    stack.push(2)
    stack.pop()
    
    print(stack)
}

func example(of message: String, codes: () -> Void) {
    print("Examples of \(message)\n")
    codes()
}
