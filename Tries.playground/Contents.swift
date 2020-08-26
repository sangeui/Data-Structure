import Foundation

public class TrieNode<Key: Hashable> {
    public var key: Key?
    public weak var parent: TrieNode?
    public var children: [Key: TrieNode] = [:]
    public var isTerminating = false
    
    public init(key: Key?, parent: TrieNode?) {
        self.key = key
        self.parent = parent
    }
}

public class Trie<CollectionType: Collection> where CollectionType.Element: Hashable {
    public typealias Node = TrieNode<CollectionType.Element>
    public let root = Node(key: nil, parent: nil)
    public init() {}
}
extension Trie {
    public func insert(_ collection: CollectionType) {
        var current = root
        
        for element in collection {
            if current.children[element] == nil {
                current.children[element] = Node(key: element, parent: current)
            }
            current = current.children[element]!
        }
        
        current.isTerminating = true
    }
}
extension Trie {
    public func remove(_ collection: CollectionType) {
        var current = root
        for element in collection {
            guard let child = current.children[element] else { return }
            current = child
        }
        
        guard current.isTerminating else { return }
        
        current.isTerminating = false
        
        while let parent = current.parent, current.children.isEmpty && !current.isTerminating {
            parent.children[current.key!] = nil
            current = parent
        }
    }
}
extension Trie {
    public func contains(_ collection: CollectionType) -> Bool {
        var current = root
        
        for element in collection {
            guard let child = current.children[element] else { return false }
            current = child
        }
        
        return current.isTerminating
    }
}
extension Trie where CollectionType: RangeReplaceableCollection {
    func collections(startingWith prefix: CollectionType, maximumLength: Int? = nil) -> [CollectionType] {
        var current = root
        for element in prefix {
            guard let child = current.children[element] else { return [] }
            current = child
        }
        
        if let length = maximumLength {
            return collections(startingWith: prefix, after: current, maximumLength: length - prefix.count)
        } else {
            return collections(startingWith: prefix, after: current)
        }
    }
    private func collections(startingWith prefix: CollectionType, after node: Node, maximumLength: Int? = nil) -> [CollectionType] {
        var results: [CollectionType] = []
        
        if node.isTerminating {
            results.append(prefix)
        }
        if let maximumLength = maximumLength {
            var count = 0
            for child in node.children.values {
                if count >= maximumLength {
                    break
                } else {
                    var prefix = prefix
                    prefix.append(child.key!)
                    results.append(contentsOf: collections(startingWith: prefix, after: child, maximumLength: maximumLength))
                    
                    count += 1
                }
            }
        } else {
            for child in node.children.values {
                var prefix = prefix
                prefix.append(child.key!)
                results.append(contentsOf: collections(startingWith: prefix, after: child))
            }
        }
        
        return results
    }
}

let trie = Trie<String>()
trie.insert("car")
trie.insert("card")
trie.insert("care")
trie.insert("cared")
trie.insert("cars")

trie.collections(startingWith: "car", maximumLength: 3)
