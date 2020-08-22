//: [Previous](@previous)

import Foundation

var list1 = LinkedList<Int>()
(1...3).forEach { list1.append(value: $0) }

var list2 = list1

print("\tList1:", list1)
print("\tList2:", list2)

list2.push(value: 0)

print("\tList1:", list1)
print("\tList2:", list2)

list1.push(value: 100)

print("\tList1:", list1)
print("\tList2:", list2)

//: [Next](@next)
