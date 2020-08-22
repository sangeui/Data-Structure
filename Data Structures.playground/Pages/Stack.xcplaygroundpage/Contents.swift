//: [Previous](@previous)

import Foundation

var pureStack = Stack<Int>()

pureStack.push(1)
pureStack.push(2)
pureStack.pop()

var literalStack: Stack = [1, 2, 3, 4]

literalStack.push(1)
literalStack.push(2)
literalStack.pop()

// MARK: - Challenge 1: Reverse an Array
// Create a function that prints the contents of an array in reversed order
func challenge1<T>(array: [T]) {
    var stack = Stack<T>()
    
    array.forEach { stack.push($0) }
    
    while let value = stack.pop() {
        print(value)
    }
}

challenge1(array: [1, 2, 3, 4, 5])

// MARK: - Challenge 2: Balance the parentheses
// Check for balanced parantheses. Given a string, check if there are '(' and ')' characters, and return true
// if the parentheses in the string are balanced.
func challenge2(string: String) -> Bool {
//    let leftParentheses = string.filter { $0 == "(" }
//    let rightParentheses = string.filter { $0 == ")" }
//    return leftParentheses.count == rightParentheses.count
    var stack = Stack<Character>()
    
    for character in string {
        if character == "(" { stack.push(character) }
        else if character == ")" {
            if stack.isEmpty { return false }
            else { stack.pop() }
        }
    }
    
    return stack.isEmpty
}

challenge2(string: "(hello world)")
