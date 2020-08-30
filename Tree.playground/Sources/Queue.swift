//
//  Queue.swift
//  
//
//  Created by 서상의 on 2020/08/28.
//

import Foundation

public struct Queue<T> {
    var array: [T] = []
    public init() {}
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    public var peek: T? {
        return array.first
    }
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    public mutating func dequeue() -> T? {
        isEmpty ? nil : array.removeFirst()
    }
}
