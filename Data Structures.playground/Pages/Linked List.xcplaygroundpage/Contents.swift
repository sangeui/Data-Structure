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




//: [Next](@next)
