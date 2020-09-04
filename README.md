### Table of Contents
- [Stack](#stack)  
- [Queue](#queues)  
	-  [Array based Queue](#queuearray)
    - [Double Stack based Queue](#queuedoublestack)
	- [Linked list based Queue](#queuelinkedlist)
	- [Ring buffer based Queue](#queueringbuffer)
		- [Ring Buffer](#ringbuffer)
- [Tree](#Tree)
	- [Binary Tree](#BinaryTree)
	- [Binary Search Tree](#BinarySearchTree)
	- [Trie](#trie)
---

#### Stack
#### Queues

요즘에는 우리가 자주 접하는 문화 생활을 위해 줄을 서는 일이 현저히 줄었다. 
스마트폰의 앱을 통해서 식당을 예약하고 영화를 예매한다. 

오히려 이제는 희귀한 서비스나 제품들을 위해 우리는 기꺼이 줄을 선다.

S 커피 체인점의 굿즈를 구매하기 위해 그리고 제주도의 소문난 Y 돈까스를 먹기 위해 우리는 시간을 내어 줄을 선다.

여기서 줄을 서는 행위는 Queue 의 구조와 아주 유사하다.
먼저 도착한 사람 순서대로 서비스를 받을 수 있듯이, Queue 에서도 먼저 도착한 순서대로 제거될 수 있다. 

---
Queue 는 Array, Doubly linked list 등 다양한 방법으로 구현이 될 수 있다. 

구현 방법은 다양하나 이 구현체들이 행하는 행위들은 아주 간단하다. 
```
- enqueue
데이터를 삽입하고
- dequeue
데이터를 제거한다.
```

이 주요 행위들을 제외하고, 부수적으로 Queue 가 비어 있는지, 첫번째 값은 무엇인지 들여다보는 등의 행위들이 포함될 수 있다. 

---

##### Protocol
위에 언급된 Queue 의 기본 오퍼레이터들을 갖는 프로토콜이다. 
```swift
public protocol Queue {
	associatedType Element
	// Key methods
	mutating func enqueue(_ element: Element) -> Bool
	mutating func dequeue() -> Element?
	// Supplementary methods
	var isEmpty: Bool { get }
	var peek: Element? { get }
}
```

##### QueueArray

Queue 를 구현하는 방법 중 가장 간단하다. 
Array 를 Data 컨테이너로써 선언하고 Array 의 메소드를 이용해 Queue 를 조작할 수 있다.

###### QueueArray 의 기본 골격
```swift
public struct QueueArray<T>: Queue {
	private var array: [T] = []
	public init() {}
}
```

###### Enqueue · Dequeue
```swift
public mutating func enqueue(_ element: T) -> Bool {
	array.append(element)
	return true
}
public mutating func dequeue() -> T? {
	isEmpty ? nil : array.removeFirst()
}
```

###### Pros and Cons
개발자들이 친숙한 Array 로 구현했기 때문에 아주 쉽게 구현될 수 있다. 
하지만 쉽게 구현이 된 만큼 여기에는 성능의 문제가 발생한다. 

|Operations|Average case|Worst case|
|--|--|--|
|enqueue|O(1)|O(n)
|dequeue|O(n)|O(n)
|Space Complexity|O(n)|O(n)

위 테이블에서 알 수 있듯이 enqueue 연산의 에버리지 케이스를 제외하고 모두 O(n) 의 시간복잡도를 가지고 있음을 알 수 있다. 

첫번째로 enqueue 의 경우 Array 공간이 가득 차게 되면 **Resizing** 이 발생하는데, 이는 새로운 메모리 공간을 할당하여 이 곳으로 기존 Array 를 옮기는 작업이 요구된다. 

따라서 대부분의 enqueue 연산이 Constant 복잡도를 가질 수 있겠지만, Array 가 가득 차게 된 경우에는 O(n) 의 복잡도를 가지게 된다.

두번째, dequeue 에서는 Array 의 첫번째 엘리먼트를 제거하는 메소드를 사용했다. 이는 뒤에 있는 엘리먼트들을 앞으로 당기는 작업이 필요하므로 O(n) 의 복잡도를 가지는 것은 당연하다. 

---

따라서 배열을 이용한 Queue 의 구현은 간단할지 몰라도 보다 나은 성능이 요구된다면 다른 방법을 이용해야 할 것이다. 

---

##### QueueDoubleStack

왜 하나가 아닌 두개의 스택을 이용해서 Queue 를 구현하려는 것일까?

결론만 살펴보자면, Array-based Queue 에 비해 O(n) 의 ```dequeue``` 연산을 ```amortized O(1)``` 연산으로 만들고 Ring buffer based Queue 에 비해 고정된 크기를 갖지 않아 완전히 동적인 구조가 된다. 

Linked list based Queue 에 비하면 Stack 의 기반 구조가 되는 Array 가 메모리 블록 내에서 연속적으로 배치가 되기 때문에 ```spacial locality``` 측면에서 이점을 챙길 수 있다. 

###### Implementation
```swift
struct QueueStack<T>: Queue {
	private var dequeueStack: [T] = []
	private var enqueueStack: [T] = []
	public init() {}
}
```

변수 이름에서 알 수 있듯이, dequeue 연산을 위한 stack 과 enqueue 연산을 위한 stack 을 하나씩 만든다.

이 두 스택을 이용해서 어떻게 Queue 의 동작들을 구현할 수 있을까?

###### Enqueue 동작 이미지
![the image for queuestack's enqueing](https://github.com/sangeui/Data-Structure/blob/master/Resources/Images/queuestack_enqueue.png)

위 그림에서 볼 수 있듯이 Enqueue 는 해당 엘리먼트를 반드시 오른쪽 스택으로 넣는다. 

이때, Stack 의 기반 구조가 되는 Array 는 동적으로 사이즈를 변경하기 때문에 사이즈는 고려하지 않아도 된다. 다만, 사이즈 변경이 일어나게 되는 시점에는 O(n) 의 연산이 발생하게 된다. 

###### Dequeue 동작 이미지
![the image for queuestack's queueing](https://github.com/sangeui/Data-Structure/blob/master/Resources/Images/queuestack_dequeue.png)

Dequeue 는 왼쪽 스택에서 발생한다. 왼쪽 스택에 Element 가 존재하는 경우 단순히 이를 가져온다. 그렇지 않을 경우, 오른쪽 스택의 Element 들을 거꾸로 뒤집어서 왼쪽 스택으로 가져온 다음에 하나씩 리턴한다. 

---

##### QueueLinkedList
##### QueueRingBuffer

아래 설명될 Ring buffer (circular list) 를 이용한 Queue 의 구현이다. 

###### Performance Table
|Operations|Average case|Worst case|
|--|--|--|
|enqueue|O(1)|O(1)
|dequeue|O(1)|O(1)
|Space Complexity|O(n)|O(n)

위의 퍼포먼스 테이블을 살펴보면 Linked list 를 이용한 Queue 와 동일하다. 다만, Ring buffer 라는 데이터 구조가 고정되 사이즈를 가지므로 가득 찬 상태의 버퍼에 추가로 enqueue 연산을 수행한다면 이는 실패하게 된다. 

###### Enqueue · Dequeue
```swift
public mutating func enqueue(_ element: T) -> Bool {
	ringBuffer.write(element)
}
public mutating func dequeue() -> T? {
	ringBuffer.read()
}
```

##### RingBuffer

링 버퍼 또는 원형 버퍼 (A circular buffer) 라고도 부른다. 

배열로 구현이 되긴 하지만 배열의 마지막 인덱스에 도달한 후 다시 쓰기 동작을 하려면 첫 인덱스로 돌아와야 한다. 

이는 마치 배열을 구부려서 원형으로 만든 것과 같다. 

한가지 특별한 것은 배열의 인덱스를 위해 두가지 변수를 사용한다. 

- 첫번째는 write 인덱스로써, 값을 넣기 위한 인덱스를 의미한다.
- 두번째는 read 인덱스로써, 다음 read 연산이 실행되면 해당 인덱스의 값을 불러온다.

###### 초기 Ring buffer
||[|nil|nil|nil|]|
|--|--|--|--|--|--|
|write index||w|||
|read index||r|||

위 테이블을 통해 아주 단순한 Ring buffer 를 그렸다. 현재 배열의 각 메모리 공간에는 값이 주어지지 않은 상태이며, ```w```, ```r``` 의 표현을 통해 각각 write 포인터와 read 포인터가 배열의 첫 인덱스에 위치하고 있음을 알 수 있다. 

또한 write 와 read 가 같은 인덱스를 가리키고 있다는 것은 곧, Ring buffer 가 비어있음을 의미한다.

###### 값을 하나 더한 이후의 Ring buffer 
||[|1|nil|nil|]|
|--|--|--|--|--|--|
|write index||→|w||
|read index||r|||

1 을 Ring buffer 에 넣었다고 가정했을 때, 배열의 내부 표현 뿐 아니라 write index 의 위치도 변했음을 알 수 있다. 
여기에서는 write 연산을 실행했으므로 read index 는 그대로 두고, ```write index``` 만 움직였다. 

###### 배열를 가득 채운 후 값을 하나 뺀 Ring buffer

차례대로 2, 3 을 ring buffer 에 집어넣고 read 연산을 한번 실행했을 때의 테이블이다.
||[|1|2|3|]|
|--|--|--|--|--|--|
|write index||-|-|→|w
|read index||→|r||

우리는 read 연산을 통해 read index 가 가리키던 첫번째 값을 가져왔고, 이 인덱스를 하나 증가시켰음을 볼 수 있다. 

###### 다시 값을 더한 이후의 Ring buffer

읽기 연산과 쓰기 연산을 모두 해보았다. 여기서 고려해야 할 것이 하나 더 있는데, 만약 어느 인덱스라도 배열의 마지막을 초과한다면 어떻게 될까?

배열의 원형의 형태를 띈다는 점, 따라서 인덱스가 마지막을 넘었을 때에는 다시 처음 인덱스로 돌아와야 한다는 점을 고려해야 한다. 

위 링 버퍼에서 이미 3 을 채움으로써 write index 는 배열의 끝을 넘어섰다. 다시 값을 더하기 위해서는 배열의 처음으로 돌아가야 하므로 우리는 ```modulo 연산```을 사용할 수 있다.

- ```writeIndex % array.count```
- ```readIndex % array.count```

위 두 연산을 통해 index 에 대해 걱정할 필요는 없어진다. 

||[|4|2|3|]|
|--|--|--|--|--|--|
|write index||→|w||
|read index||→|r||

---

#### Tree

![the image for tree](https://github.com/sangeui/Data-Structure/blob/master/Resources/Images/Tree.png)

최상위 노드를 기준으로 뒤집어 보면 마치 나무의 모습이 된다. 

트리는 `노드` 들로 구성이 되는데, 각 노드들은 개별적인 값과 그 `children` 을 갖는다. 

트리에서 최상위에 있는 노드를 `root`, 가장 아래에서 자식을 갖지 않는 노드를 `leaf` 라고 부른다. 

트리는 (1) `노드들` 로 구성된다 했으며 각 노드들은 `값` 과 `자식 노드` 들을 갖는다고 했다.

```swift
class Node<T> {
	var value: T
	var children: [Node] = []
	init(_ value: T) {
		self.value = value
	}
}
```

트리를 형성하기 위한 최소한의 노드가 완성되었다. 

이제 이 노드에 `자식 노드` 를 더하는 동작을 추가해본다. 

```swift
extension Node {
	func add(_ child: Node) {
		self.children.append(child)
	}
}
```

그런데 이것만 가지고는 트리를 효율적으로 사용할 수 없다. 일일이 노드의 자식 노드를 꺼내보고 확인하고 비교하는 등의 일은 상상만 하더라도 비효율적이다.

그래서 `traversing` 을 도입해보자.

여행자 한 명이 어떤 트리의 `root` 에 도착했다. 이 여행자는 이 트리의 모든 노드에 방문해보겠다는 꿈을 가지고 있다. 

이 여행자는 곰곰이 생각하다가 두가지 방법을 떠올린다.

1. 같은 층에 있는 노드들을 먼저 방문한다.
2. 노드들과 그 자식들을 먼저 방문해보고, 다른 노드로 건너간다.

1번과 같은 방식은 각 노드가 위치해 있는 층, 즉 레벨에 따라 방문을 하므로 `Level-order` 가 된다. 
2번과 같은 방식은 각 노드를 중심으로 자식들을 찾아 아래까지 방문했다가 다시 올라와 다른 노드를 방문하므로 `Depth-first` 가 된다. 

먼저 `Depth-first` 의 구현은 아래와 같으며 재귀를 사용한다. 

```swift
typealias Visit = (Node) -> Void
extension Node {
	func depthFirstOrder(visit: Visit) {
		visit(self)
		children.forEach { child in
			child.depthFirstOrder(visit: visit)
		}
	}
}
```

먼저 해당 노드를 방문한 다음, 자식 노드를 순서대로 같은 방식으로 방문했다. 

다음으로 `Level order` 를 살펴보면, 다음과 같으며 `Queue` 구조를 사용했다는 것을 볼 수 있다.

```swift
typealias Visit = (Node) -> Void
extension Node {
	func levelOrder(visit: Visit) {
		visit(self)
		var queue = Queue<Node>()
		children.forEach { queue.enqueue($0) }
		while let node = queue.dequeue() {
			visit(node)
			node.children.forEach { queue.enqueue($0) }
		}
	}
}
```

다소 직관적으로 위처럼 두 종류의 `traversing` 을 구현할 수 있다.

---
#### BinaryTree

기본 트리는 자식의 수에 제한이 없었다. 하지만 `Binary tree` 는 자식을 최대 한 쌍까지만 가질 수 있다. 

구현은 기본 트리와 유사하다. 
```swift
class BinaryNode<Element> {
	var value: Element
	var left: BinaryNode?
	var right: BinaryNode?
	
	init() {...{
}
```

노드 자신이 가질 `value` 변수를 선언하고 `left`, `right` 자식 노드를 위한 변수를 선언한다. 자식 노드는 `nil` 을 가지는 것이 가능하므로, `optional` 로 선언하는 것이 바람직하다. 

기본 트리에서는 Traversal algorithms 으로 `level-order` 와 `depth-first` 알고리즘을 살펴보았는데, `Binary tree` 에서도 이와 유사한 알고리즘을 갖고 있다. 

```
In-order traversal
1. 노드가 왼쪽 자식노드를 갖고 있다면 이를 방문한다.
2. 자신을 방문한다. -> in
3. 오른쪽 자식을 갖는다면, 1번의 방식으로 이를 방문한다.

left.inorder(visit: visit)
visit(value)
right.inorder(visit: visit)

Pre-order traversal
1. 자신을 방문한다. -> pre
2. 왼쪽 자식노드를 갖고 있다면 이를 방문한다.
3. 오른쪽 자식노드를 갖고 있다면 이를 방문한다.

visit(value)
left.preorder(visit: visit)
right.preorder(visit: visit)

Post-order traversal
1. 왼쪽 자식노드를 갖고 있다면 이를 방문한다.
2. 오른쪽 자식노드를 갖고 있다면 이를 방문한다. 
3. 자신을 방문한다. -> post

left.preorder(visit: visit)
right.preorder(visit: visit)
visit(value)
```
---

#### BinarySearchTree (BST)

Binary Tree 구조를 이용해서 빠른 탐색, 삽입, 삭제 연산을 가능케 하는 데이터 구조이다. 

`Binary Tree` 이므로 각각의 노드는 최대 두개의 자식 노드를 가질 수 있다. 

추가로, `left child` 는 부모 노드보다 작은 값을 가져야 하며 `right child` 는 부모 노드보다 같거나 큰 값을 가져야 한다. 이것이 바로 `Binary Search Tree` 의 핵심 규칙이라고 할 수 있다. 

이 규칙이 의미하는 바는 무엇일까? 

Array 와 BST 를 대표적인 연산에 따라 비교해본다. 

**Lookup**

- Array: 처음부터 탐색하므로 최악의 경우, 맨 마지막 인덱스까지탐색해야 하므로 **O(n)** 의 계산 복잡도를 가진다. 
- BST: 이 트리가 가지는 핵심 규칙은 각 노드들이 배치되는 조건이었다. 이 조건을 이용해 탐색을 수행할 경우, 노드를 거칠 때마다 탐색해야 할 범위는 절반으로 줄어든다. 따라서 BST 는 기껏해야 **O(log n)** 복잡도를 가진다. 

**Insertion**

- Array: 배열의 끝에 삽입하는 것은 배열의 크기를 확장해야 할 때를 제외하고 **O(1)** 계산 복잡도를 가진다. 하지만 삽입은 배열의 첫 부분 혹은 중간에서도 일어날 수 있는데 이 때, 이후의 요소들을 한칸씩 미뤄주는 연산이 필요하므로 최악의 경우 **O(n)** 복잡도를 가질 수 있다. 
- BST: 삽입은 항상 `Leaf 노드` 에서 발생한다. 그리고 이 노드를 찾기 위해 탐색 (**O(log n)**)을 해야 한다. 따라서 삽입 연산도 동일한 복잡도를 가진다. 

**Removal**

- Array: 삽입 연산과 마찬가지로, 마지막 요소의 제거를 제외하면 각 요소들을 한칸씩 당기는 작업이 필요하므로 **O(n)** 복잡도를 가진다. 
- BST: 삭제할 노드를 찾기 위해서 역시 탐색 연산을 사용한다. 하지만 이 노드가 자식 노드를 가졌을 때 추가적인 작업이 필요하다. 하지만 그래도 Array 와 비교했을 때 훨씬 효율적임을 알 수 있다. 

**삽입 연산 구현**

```swift

extension BST {
	public mutating func insert(_ value: Element) {
		root = insert(from: root, value: value)
	}
	private func insert(from node: BinaryNode<Element>?, value: Element) -> BinaryNode<Element> {
	guard let node = node else { return BinaryNode(value: value) }
	
	if value < node.value {
		node.left = insert(from: node.left, value: value)
	} else {
		node.right = insert(from: node.right, value: value)
	}
	return node
}

```

---

#### Trie

Collection 타입의 데이터를 저장하는 데 유용한 트리이다. 

```[Trie 예시 다이어그램]```

Trie 에 단어 ```Swift``` 를 저장하려고 하면, 각각의 ```Character``` 들이 ```node``` 를 형성하여 Trie 에 저장된다. 

이러한 데이터 구조는 특히 ```prefix matching``` 에 아주 유용하게 사용된다. 

물론 prefix matching 을 위해서 아래와 같은 방법을 이용할 수도 있다. 

```swift
var words: [String] = [...]

func findMatchingWords(prefixWords: String) -> [String] {
	return words.filter { $0.hasPrefix(prefixWords) }
}
```

좋다. 위의 방법도 나쁘진 않다. 데이터의 양이 많지 않다면.

words 의 Element 수가 어마어마하게 늘어난다면, 그때도 의자에 앉아 태평하게 위 함수를 호출하는 것으로 만족할 수 있을까?
1억 개가 넘는 방문을 일일이 두드려 '여기 ** 단어 계십니까?' 하고 물어볼 수 있을까?

그래서 우리는 이렇게 일일이 탐색하는 대신 Trie 의 도움을 빌려 필요한 브런치만 가져와서 원하는 단어를 찾을 수 있다. 
