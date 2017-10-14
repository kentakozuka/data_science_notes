Courseraの以下のコースを受講した際のノートです
Data Structures
Data Structures and Algorithms
by University of California, San Diego & Higher School of Economics


# Data Structures

## week1

### 配列 (Array)

#### 実行時間

||Add|Remove|
|---|---|---|
|先頭|$O(n)$|$O(n)$|
|最後|$O(1)$|$O(1)$|
|途中|$O(n)$|$O(n)$|


### 片方向リスト (Singly-Linked List)

#### API
```
PushFront(key )
    node ←new node
    node.key ← key
    node.next ← head
    head ← node
    if tail = nil:
        tail ← head
```

```
PopFront()
    if head = nil:
        ERROR: empty list
    head ← head .next
    if head = nil:
        tail ← nil
```

```
PushBack(key )
    node ←new node
    node.key ← key
    node.next =nil
    if tail = nil:
        head ← tail ← node
    else:
        tail .next ← node
        tail ← node
```

```
PopBack()
    if head = nil: ERROR: empty list
    if head = tail :
        head ← tail ←nil
    else:
        p ← head
        while p.next.next ̸ = nil:
            p ← p.next
        p.next ← nil; tail ← p
```

```
AddAfter(node, key )
    node2 ←new node
    node2.key ← key
    node2.next = node.next
    node.next = node2
    if tail = node:
        tail ← node2
```

#### 実行時間

|単方向リスト|no tail|with tail|
|---|---|---|
|PushFront(Key)|O(1)||
|TopFront()|O(1)||
|PopFront()|O(1)||
|PushBack(Key)|O(n)|O(1)|
|TopBack()|O(n)|O(1)|
|PopBack()|O(n)||
|Find(Key)|O(n)||
|Erase(Key)|O(n)||
|Empty()|O(1)||
|AddBefore(Node, Key)|O(n)||
|AddAfter(Node, Key)|O(1)||

### 双方向リスト (Doubly-Linked List)

#### API

```
PushBack(key )
    node ←new node
    node.key ← key ; node.next =nil
    if tail = nil:
        head ← tail ← node
        node.prev ←nil
    else:
        tail .next ← node
        node.prev ← tail
        tail ← node
```

```
PopBack()
    if head = nil: ERROR: empty list
    if head = tail :
        head ← tail ←nil
    else:
        tail ← tail .prev
        tail .next ←nil
```

```
AddAfter(node, key )
    node2 ←new node
    node2.key ← key
    node2.next ← node.next
    node2.prev ← node
    node.next ← node2
    if node2.next ̸ = nil:
        node2.next.prev ← node2
    if tail = node:
        tail ← node2
```

```
AddBefore(node, key )
    node2 ←new node
    node2.key ← key
    node2.next ← node
    node2.prev ← node.prev
    node.next ← node2
    if node2.next ̸ = nil:
        node2.prev .next ← node2
    if head = node:
        head ← node2
```

#### 実行時間

|双方向リスト|no tail|with tail|
|---|---|---|
|PushFront(Key)|O(1)||
|TopFront()|O(1)||
|PopFront()|O(1)||
|PushBack(Key)|O(n)|O(1)|
|TopBack()|O(n)|O(1)|
|PopBack()|O(1)||
|Find(Key)|O(n)||
|Erase(Key)|O(n)||
|Empty()|O(1)||
|AddBefore(Node, Key)|O(1)||
|AddAfter(Node, Key)|O(1)||

### スタック (Stack)
Definition
Stack: Abstract data type with the following
operations:
Push(Key): adds key to collection
Key Top(): returns most
recently-added key
Key Pop(): removes and returns most
recently-added key
Boolean Empty(): are there any
elements?

Summary
Stacks can be implemented with either
an array or a linked list.
Each stack operation is O(1): Push,
Pop, Top, Empty.
Stacks are ocassionaly known as LIFO
queues.

### キュー (Queue)
Definition
Queue: Abstract data type with the following
operations:
Enqueue(Key): adds key to collection
Key Dequeue(): removes and returns
least recently-added key
Boolean Empty(): are there any
elements?
FIFO: First-In, First-Out

Queue Implementation with
Linked List
Enqueue: use List.PushBack
Dequeue: use List.TopFront and
List.PopFront
Empty: use List.Empty

Summary
Queues can be implemented with either
a linked list (with tail pointer) or an
array.
Each queue operation is O(1): Enqueue,
Dequeue, Empty.

### 木 (Tree)
Definition
A Tree is:
empty, or
a node with:
a key, and
a list of child trees.

Node contains:
key
children: list of children nodes
(optional) parent

For binary tree, node contains:
key
left
right
(optional) parent

```
Height(tree)
if tree = nil :
return 0
return 1 + Max(Height(tree.left),
Height(tree.right))
```

```
Size(tree)
if tree = nil
return 0
return 1 + Size(tree.left) +
Size(tree.right)
```

Walking a Tree
Often we want to visit the nodes of a tree in
a particular order.
For example, print the nodes of the tree.
Depth-first: We completely traverse one
sub-tree before exploring a sibling
sub-tree.
Breadth-first: We traverse all nodes at
one level before progressing to the next
level.


Depth-first
```
InOrderTraversal(tree)
if tree = nil :
return
InOrderTraversal(tree.left)
Print(tree.key )
InOrderTraversal(tree.right)
```

Depth-first
```
PreOrderTraversal(tree)
if tree = nil :
return
Print(tree.key )
PreOrderTraversal(tree.left)
PreOrderTraversal(tree.right)
```

Depth-first
```
PostOrderTraversal(tree)
if tree = nil :
return
PostOrderTraversal(tree.left)
PostOrderTraversal(tree.right)
Print(tree.key )
```

Breadth-first
```
LevelTraversal(tree)
if tree = nil:
return
Queue q
q.Enqueue(tree)
while not q.Empty() :
node ← q.Dequeue()
Print(node)
if node.left ̸ = nil :
q.Enqueue(node.left)
if node.right ̸ = nil :
q.Enqueue(node.right)
```

Summary
Trees are used for lots of different
things.
Trees have a key and children.
Tree walks: DFS (pre-order, in-order,
post-order) and BFS.
When working with a tree, recursive
algorithms are common.
In Computer Science, trees grow down!

## week2

### 動的配列 (Dynamic Array)
Definition
Dynamic Array:
Abstract data type with the following
operations (at a minimum):
Get(i): returns element at location i *
Set(i, val ): Sets element i to val *
PushBack(val ): Adds val to the end
Remove(i): Removes element at
location i
Size(): the number of elements

Implementation
Store:
arr: dynamically-allocated array
capacity: size of the
dynamically-allocated array
size: number of elements currently in
the array

```
Get(i)
if i < 0 or i ≥ size:
ERROR: index out of range
return arr [i]
```

```
Set(i, val )
if i < 0 or i ≥ size:
ERROR: index out of range
arr [i] = val
```

```
PushBack(val )
if size = capacity :
allocate new _arr [2 × capacity ]
for i from 0 to size − 1:
new _arr [i] ← arr [i]
free arr
arr ← new _arr ; capacity ← 2 × capacity
arr [size] ← val
size ← size + 1
```

```
Remove(i)
	if i < 0 or i ≥ size:
		ERROR: index out of range
	for j from i to size − 2:
		arr [j] ← arr [j + 1]
	size ← size − 1
```

```
Size()
return size
```

#### 実行時間

|API|実行時間|
|---|---|
|Get(i)|$O(1)$|
|Set(i, val )|$O(1)$|
|PushBack(val )|$O(n)$|
|Remove(i)|$O(n)$|
|Size()|$O(1)$|


Summary
Unlike static arrays, dynamic arrays can
be resized.
Appending a new element to a dynamic
array is often constant time, but can
take O(n).
Some space is wasted—at most half.

### 償却解析 (Amortized Analysis)

> 償却解析 (Amortized analysis, ならし解析ともよばれる)とは、与えられたアルゴリズムの時間計算量（英語版）または、コンピュータプログラムの文脈における資源、特に時間またはメモリをどれだけ必要とするかを分析する手法である。
> 償却解析の動機は、一回の実行あたりの最悪実行時間を見ることがあまりにも悲観的であるということである。
> 与えられたアルゴリズムの一定の動作は著しく計算資源を消費するかもしれないし、他の動作はそれほど消費しないかもしれない。償却分析はアルゴリズムの一連の動作全体にわたってコストが高い、またはそうでもない動作の両方を考慮する。


ここで全体が$n$回の一連の処理（実行時間：$C(n)$）におけるi回目の実行時間を$c_i$とし、償却計算量（Amortized Cost）を定義します。

$
\frac{C(n)}{n} = \frac{\sum_{i=1}^{n}c_i}{n}
$

#### 総和法 (Aggregate Method)
総和法はnまでの実行時間の総和を計算する方法です。
動的配列を例とすると、PushBackに掛かる実行時間は

- 通常の場合
- 要素が入り切らなくなり配列を再定義する場合

の2通りになります。
数式にすると以下のようになります。

$
\begin{eqnarray}
    c_i = 1 + \left\{ \begin{array}{ll}
        i-1, \hspace{2em}  if \ i-1 \ is \ a \ power \ of \ 2 \\\
        0, \hspace{4em} otherwise \\\
    \end{array} \right.
\end{eqnarray}
$

この$c_i$をnまで足し合わせます。

$
\frac{\sum_{i=1}^{n}c_i}{n} = \frac{n + \sum_{j=1}^{\log_{2}(n-1)}2^j}{n} = \frac{O(n)}{n} = O(1)
$


#### 銀行家法 (Banker’s Method)
銀行家法とは今実行している処理の実行時間に対象となる要素に将来に必要となる実行時間（講義中ではトークン：tokenと呼ばれていました）を先に足し合わせてその処理の実行時間として考える方法です。

動的配列を例とすると、
1回のPushBackに掛かる実行時間はO(1)ですが、将来に配列を再定義する場合を先読みすると

- この処理で追加した要素を新しい配列に移動する実行時間が$O(1)$$
- 既に1回新しい配列に移動した（将来使える実行時間が残っていない）要素を新しい配列に移動する実行時間が$O(1)$$

を先に考えておかないと、将来かかる実行時間をトークンでまかなえません。
よって、上記トークンを合わせた1回のPushBackに必要となる実行時間は$O(3)=O(1)$となります。


#### 物理学者法 (Physicist’s Method)
物理学者法とは高校で習う物理法則のように処理時間を位置エネルギーと運動エネルギーの相関関係に置き換えて全体の実行時間を概算する方法です。


まず、ポテンシャル関数$\phi$を以下のように定義します。

$
\phi(h_0) = 0 \\\
\phi(h_n) ≥ 0
$

$c_n$を$n$回目に必要な計算量と定義すると、

$
c_n + \phi(h_n) − \phi(h_{n−1})
$

以下のような$\phi$を選択します。
もし$c_n$が小さいとき、同じくらいポテンシャルは大きくなる
もし$c_n$が大きいとき、同じくらいポテンシャルは小さくなる


$n$回の処理のコストは$\sum_{i=1}^{n}c_i$となり
償却コストの総和は

$
\sum _{i=1}^{n} (c_i + \phi (h_i) - \phi ( h _{i-1} ) )
$

$
= c_i + \phi(h_1) - \phi(h_0) + c_i + \phi(h_2) - \phi(h_1) + ... + c_i + \phi(h_n) - \phi( h_{n-1} )
$


各項は互いに打ち消し合うため、最終的には

$
= \phi (h_n) - \phi (h_0) + \sum _{i=1}^{n} c_i
$

$
\geq \sum_{i=1}^{n}c_i
$

となります


動的配列のPushBack関数を例とすると、ポテンシャル関数は以下のように定義します。

$
\phi(h) = 2 \times size - capacity \\\
\phi(h_0) = 2 \times 0 - 0 = 0 \\\
\phi(h_i) = 2 \times size - capacity \gt 0\\\
(size \gt \frac{capacity}{2})
$
## week3
### 優先度つきキュー (Priority Queues)
### 二分ヒープ (Binary Max Heap)
### ツリーの深さの定義
In the previous module, we defined the height of a tree as the number of nodes on a longest path from the root to a leaf. In this module, we use a slightly different definition of the height: we define it to be equal to the number of edges on the longest path from the root to a leaf. In particular, the height of a tree that consists of one node is equal to 0 and the height of tree shown below is equal to 3.

Both definitions of height are used in practice frequently, so it is always a matter of context. If there is no definition in the text, you should look at the examples discussed to understand which of the two definitions is used.

## week4

### ハッシュ

#### 直接アドレス指定 (Direct Addressing)
配列で実装します。
値を格納したり、取り出したりする場合は配列のインデックスを指定します。



|||
|---|---|
|UpdateAccessList is |O(1) per log line|
|AccessedLastHour is |O(1)|
|In general: |O(N) memory, N = |S||


h should be fast to compute
Different values for different objects
Direct addressing with O(m) memory
Want small cardinality m
Impossible to have all different values if
number of objects |S| is more than m

#### リスト式マッピング

Direct addressing requires too much
memory
Let’s store only active IPs
Store them in a list
Store only last occurrence of each IP
Keep the order of occurrence


n is number of active IPs
Memory usage is Θ(n)
L.Append, L.Top, L.Pop are Θ(1)
L.Find and L.Erase are Θ(n)
UpdateAccessList is Θ(n) per log line
AccessedLastHour is Θ(n)


##### ハッシュ関数 (Hash Function)

定義1
For any set of objects S and any integer
m > 0, a function h : S → {0, 1, . . . , m − 1}
is called a hash function.

定義2
m is called the cardinality of hash function h.

##### 衝突 (Collision)

定義
When h(o 1 ) = h(o 2 ) and o 1 ̸ = o 2 , this is a
collision.


#### マップ
定義
Map from S to V is a data structure with
methods HasKey(O), Get(O), Set(O, v ),
where O ∈ S, v ∈ V .

h : S → {0, 1, . . . , m − 1}
O, O ′ ∈ S
v , v ′ ∈ V
A ← array of m lists (chains) of pairs (O, v )

```
HasKey(O)
	L ← A[h(O)]
	for (O ′ , v ′ ) in L:
		if O ′ == O:
			return true
	return false
```

```
Get(O)
	L ← A[h(O)]
	for (O ′ , v ′ ) in L:
		if O ′ == O:
			return v ′
	return n/a
```

```
Set(O, v )
	L ← A[h(O)]
	for p in L:
		if p.O == O:
			p.v ← v
			return
	L.Append(O, v )
```
Lemma
Let c be the length of the longest chain in A.
Then the running time of HasKey, Get, Set
is Θ(c + 1).

Proof
If L = A[h(O)], len(L) = c, O ∈
/ L,
need to scan all c itemsProof
If L = A[h(O)], len(L) = c, O ∈
/ L,
need to scan all c items

Lemma
Let n be the number of different keys O
currently in the map and m be the cardinality
of the hash function. Then the memory
consumption for chaining is Θ(n + m).

Proof
Θ(n) to store n pairs (O, v )


#### セット

定義
Set is a data structure with methods
Add(O), Remove(O), Find(O).

Implementing Set
Two ways to implement a set using chaining:
Set is equivalent to map from S to
V = {true, false}
Store just objects O instead of pairs
(O, v ) in chains

h : S → {0, 1, . . . , m − 1}
O, O ′ ∈ S
A ← array of m lists (chains) of objects O

```
Find(O)
	L ← A[h(O)]
	for O ′ in L:
		if O ′ == O:
			return true
	return false
```

```
Add(O)
	L ← A[h(O)]
	for O ′ in L:
		if O ′ == O:
			return
	L.Append(O)
```

```
Remove(O)
	if not Find(O):
		return
	L ← A[h(O)]
	L.Erase(O)
```


Hash Table
Definition
An implementation of a set or a map using
hashing is called a hash table.



Chaining is a technique to implement a
hash table
Memory consumption is O(n + m)
Operations work in time O(c + 1)
How to make both m and c small?
## week5

## week6

    根節点、左部分木、右部分木の順で節点の番号を出力する。これを木の先行順巡回 (preorder tree walk) と呼びます。
    左部分木、根節点、右部分木の順で節点の番号を出力する。これを木の中間順巡回 (inorder tree walk) と呼びます。
    左部分木、右部分木、根節点の順で節点の番号を出力する。これを木の後行順巡回 (postorder tree walk) と呼びます。
