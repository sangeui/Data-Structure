import Foundation

public struct Heap<Element: Equatable> {
    var elements: [Element] = []
    let sort: (Element, Element) -> Bool

    public init(sort: @escaping (Element, Element) -> Bool, elements: [Element] = []) {
        self.sort = sort
        self.elements = elements
        
        if !elements.isEmpty {
            for i in stride(from: elements.count / 2 - 1, through: 0, by: -1) {
                siftDown(from: i)
            }
        }
    }
}
// MARK: - Searching
public extension Heap {
    func index(of element: Element, startingAt i: Int) -> Int? {
        if i >= count { return nil }
        if sort(element, elements[i]) { return nil }
        if element == elements[i] { return i }
        if let j = index(of: element, startingAt: leftChildIndex(ofParentAt: i)) {
            return j
        }
        if let j = index(of: element, startingAt: rightChildIndex(ofParentAt: i)) {
            return j
        }
        
        return nil
    }
}
// MARK: - Addition
// 1. 가장 마지막에 값을 새로 삽입
// 2. Heap 유지 (Shift up)
public extension Heap {
    mutating func insert(_ element: Element) {
        elements.append(element)
        siftUp(from: elements.count - 1)
    }
    mutating func siftUp(from index: Int) {
        var child = index
        var parent = parentIndex(ofChildAt: child)
        while child > 0 && sort(elements[child], elements[parent]) {
            elements.swapAt(child, parent)
            
            print(child, parent)
            child = parent
            parent = parentIndex(ofChildAt: child)
        }
    }
}
// MARK: - Removal
// 1. 가장 위의 노드를 삭제
// 2. Heap 유지 (Shift down
public extension Heap {
    mutating func remove() -> Element? {
        guard !isEmpty else { return nil }
        elements.swapAt(0, count-1)
        defer { siftDown(from: 0) }
        return elements.removeLast()
    }
    mutating func siftDown(from index: Int) {
        // `parent` 인덱스를 저장하는데, 최초로 `root` 의 인덱스, 0 이 저장된다.
        var parent = index
        while true {
            // 각각 오른쪽과 왼쪽 자식의 인덱스를 가져온다.
            let left = leftChildIndex(ofParentAt: parent)
            let right = rightChildIndex(ofParentAt: parent)
            var candidate = parent
            
            // 스왑 될 수 있는 후보를 결정한다.
            // 처음으로 `left` 의 값과 비교하고 성공 시, 이를 `candidate` 로 다시 설정한다.
            if left < count && sort(elements[left], elements[candidate]) { candidate = left }
            // 다음으로 `right` 의 값이 더 큰 경우를 고려하여 이를 비교하고, 성공 시 `candidate` 로 설정한다.
            if right < count && sort(elements[right], elements[candidate]) { candidate = right }
            // 비교 결과 `candidate` 가 원래의 `parent` 와 같다면 그냥 리턴한다.
            if candidate == parent { return }
            // 이제 `parent` 와 `candidate` 를 스왑하고
            elements.swapAt(parent, candidate)
            // 새로운 `parent` 로 `candidate` 를 설정한다.
            parent = candidate
            
            // 다시 새로 설정된 `parent` 에 대해서 같은 로직을 반복한다.
        }
        
    }
}
// MARK: Removal-anarbitrary index
public extension Heap {
    mutating func remove(at index: Int) -> Element? {
        guard index < elements.count else { return nil }
        
        if index == elements.count - 1 {
            return elements.removeLast()
        } else {
            elements.swapAt(index, elements.count-1)
            defer {
                siftDown(from: index)
                siftUp(from: index)
            }
            
            return elements.removeLast()
        }
    }
}

public extension Heap {
    var isEmpty: Bool { self.elements.isEmpty }
    var count: Int { self.elements.count }
    func peek() -> Element? { elements.first }
    func leftChildIndex(ofParentAt index: Int) -> Int { return (2 * index) + 1 }
    func rightChildIndex(ofParentAt index: Int) -> Int { return (2 * index) + 2 }
    func parentIndex(ofChildAt index: Int) -> Int { return (index - 1) / 2 }
}
