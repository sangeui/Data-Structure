//: [Previous](@previous)

import Foundation

var list1 = LinkedList<Int>()
list1.append(value: 1)
list1.append(value: 2)

var list2 = list1

print("List1: \(list1)")
print("List2: \(list2)")

print("After appending 3 to list2")
list2.append(value: 3)

print("List1: \(list1)")
print("List2: \(list2)")

//: [Next](@next)
