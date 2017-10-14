Courseraののコースを受講した際のノートです
Algorythms on Graphs
Data Structures and Algorithms
by University of California, San Diego & Higher School of Economics



# week1
----------------------

Graphとは

定義
An (undirected) Graph is a collection $V$ of
vertices, and a collection $E$ of edges each of
which connects a pair of vertices.

グラフにはVertices(nodes 頂点). Edges(エッジ、辺)があります

種類
* 有向グラフ
	辺に向きがある
* 無向グラフ
	辺に向きはない
* 加重グラフ
	辺に重み（値）がついている

## 隣接行列 (adjacency matrix)

|Op.|Is Edge?|List Edge|List Nbrs.|
|---|---|---|---|
|Adj. Matrix|$Θ(1)$|$Θ(&#124;V&#124;^2$)|$Θ(&#124;V&#124;)$|
|Edge List|$Θ(&#124;E&#124;)$|$Θ(&#124;E&#124;)$|$Θ(&#124;E&#124;)$|
|Adj. List|$Θ(deg)$|$Θ(&#124;E&#124;)$|$Θ(deg)$|

## 道 (Paths)
※英語のpathには「誰かが通ってできた道筋」という意味がある。

定義
グラフGお経路は点の連続である（$v_0, v_1, ... v_n$）。
任意のiについて（$v\_i, v\_{i+1}$）は線である。

到達可能性 (Reachability)
入力：グラフG, 点s
出力：点sからの経路が存在するグラフGの点vの集合


```
Component (s)
	DiscoveredNodes ← {s}
	while there is an edge e leaving
	DiscoveredNodes that has not been explored:
		add vertex at other end of e to DiscoveredNodes
	return DiscoveredNodes
```


## 深さ優先探索 (DFS: Depth First Search)

探索対象となる最初のノードから、目的のノードが見つかるか子のないノードに行き着くまで、深く伸びていく探索である。
その後はバックトラックして、最も近くの探索の終わっていないノードまで戻る。

```
Explore (v)
	visited (v) ← true
	//vからの線分ループ
	for (v , w) ∈ E :
		//もし点wが未訪問の場合
		if not visited (w) :
			Explore (w)
```


定理
もしすべての点が未訪問の状態で開始した場合、
Explore(v)は点vから到達可能な点をマークする。



グラフのすべての点を探索する

```
DFS (G)
	for all v ∈ V :
		mark v unvisited
	for v ∈ V :
		if not visited (v) :
			Explore (v)
```

探索メソッドのコール数
探索された各頂点は訪問済とマークされる。
1度探索が終わると頂点は再度探索されない。

隣接点のチェック：
各頂点において、各隣接点をチェックする。
すべての頂点の隣接点の総数は$O(&#124;E&#124;)$

実行時間：
$O(1)$ work per vertex.
$O(1)$ work per edge.
Total $O(&#124;V&#124; + &#124;E&#124;)$ 


### 到達可能性 (Reachability)
定理
グラフGの点は連結成分(conneted component)に分割される。
そのため、もし点vが点wから到達可能であれば、２点は同じ連結成分に存在する。


証明
到達可能性の証明

点vは点vから到達可能である。
もし、点vが点wから到達可能であれば、点wは点vから到達可能である。
もし、点vがuから到達可能であれば、点wは点vから到達可能であり、点uから到達可能である。


考え方
Explore(v)はvの連結成分を探索する。
他の連結成分を探すためにDFSを修正する。

```
Explore(v)
	visited(v) ← true
	// 連結成分の連番を格納
	CCnum(v) ← cc
	for (v, w) ∈ E :
		if not visited(w) :
			Explore(w)
```

```
DFS(G)
	for all v ∈ V mark v unvisited
	cc ← 1
	for v ∈ V :
		if not visited(v) :
			Explore(v)
			//連結成分の点を探索し尽したら連番をインクリメント
			cc ← cc + 1
```


### 訪問前と訪問後関数 (Previsit and Postvisit Functions)

```
Explore(v)
	visited(v) ← true
	previsit(v)
	for (v, w) ∈ E :
		if not visited (w) :
			explore (w)
	postvisit(v)
```

```
previsit(v)
	pre(v) ← clock
	clock ← clock + 1
```

```
postvisit(v)
	post(v) ← clock
	clock ← clock + 1
```


Previsit数とPostvisit数はDFSの実行についての情報となる

補助定理
任意の点uと点vについて、  
間隔 [$pre(u), post(u)$] と [$pre(v), post(v)$]は以下のどちらかである。

* nested  
&nbsp;&nbsp;&nbsp;|----|  
|--------------|  

* disjoint  
|----|  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|-------|  


証明
点uに訪問した後、点vに訪問したと仮定する。
2つのケース  
1. 点uを探索している最中に点vに訪問した (nested)
1. 点uを探索している最中に点vを訪問した (disjoint)



# week2
----------------------


## 有向グラフ (Directed Graphs)

定義  
各エッジが開始点と修了点を持つグラフ

例えば
* 一方通行道路
* ウェブページのリンク
* SNSのフォロワー
* タスクの依存性

## 有向DFS (Directed DFS)

有向グラフでもDFSは可能だが、有向エッジに従う必要がある。


## 閉路 (サイクル：Cycle)
定義  
グラフにおける閉路は連続した頂点$v_1 , v_2 , . . . , v_n$であり、  
$(v\_1 , v\_2), (v\_2 , v\_3), ..., (v\_{n− 1} , v\_n), (v\_n , v\_1)$は全てエッジである。

定理
グラフ$G$が閉路となら、線形順序 (Linearly Ordered) ではない。

証明
1. 閉路$v_1 , . . . , v_n$を持つ。
1. 線形順序と仮定する。
1. 頂点$v_k$を開始点とする。
1. すると $v\_k$ は $v\_{k− 1}$ の前に現れることとなり、これは矛盾である。

## 閉路なし有向グラフ (	有向非巡回グラフ, Directed Acyclic Graph: DAG)

定義  
閉路がない有向グラフ

定理  
任意のDAGは線形順序になりえる

最後の頂点
最後の頂点から他の頂点に向かうエッジはない

## 源点 (Source) と沈点 (Sink)
定義  
源点：有向辺の終了点がない頂点
沈点：有向辺の開始点がない頂点

問題  
いくつの沈点があるか？

考え方
1. 沈点を見つける
1. 順番の最後に格納する
1. グラフから取り除く
1. 繰り返す

沈点の探索  
どのようにして沈点を見つけるか

道を辿る  
行けるとこまで道を辿っていく

$v_1 → v_2 → . . . → v_n$

結果はいずれかになる:
* これ以上進めない（沈点へ到達）
* 同じ頂点へ到達（サイクルあり）


**基本的なアルゴリズム**

```
LinearOrder(G)
	while Gが空でない:
		それ以上進めない頂点まで道を辿る (沈点vの発見)
		vを順番の最後とする
		Gからvを取り除く
```

| |計算量|
|---|---|
|道の数|$O(&#124;V&#124;)$|
|１つの頂点について調べる計算量|$O(&#124;V&#124;)$|
|全体の実行時間|$O(&#124;V&#124;^2)$|


実行速度の向上のために
通ったパスの情報は記憶しておき、同じパスを再び通るときに使用する。

より良いアルゴリズム

```
TopologicalSort(G)
	DFS(G)
	post-orderの降順で頂点をソートする
```


**定理**  
もし$G$が有向非巡回グラフ(DAG)である場合、  
点$u$から点$v$のエッジについて、$post(u) > post(v)$である。

** 証明 **  
以下のケースを考える  
1. $u$の前に$v$を探索する
1. $u$を探索している途中に$v$を探索する
1. $u$の後に$v$を探索する （道があるためありえない）

ケース I  
$u$の前に$v$を探索する  
$v$から$u$に到達できない（DAG）  
$u$を見つける前に$v$に到達するはずなので、  
$post(u) > post (v)$


ケース II  
$u$を探索している途中に$v$を探索する  
Must nish exploring v before can nish
exploring u . Therefore 
$post(u) > post (v)$




## 強連結成分 (SCC: Strongly Connected Components)

定義
有向グラフにおける2つの頂点$v, w$が互いに$v$から$w$、$w$から$v$に到達できるとき、  
$v$と$w$は強結合成分と呼ぶ。


結果
定理
有向グラフは強連結成分に分けられ、
その成分は、もし2つの頂点が同じコンポーネントに存在するならば、それらは結合している

**証明**  
Need to show an equivalence relation.



## メタグラフ
メタグラフを用いることにより、強結合成分の関係性を図示することが可能である。

定理
グラフ$G$のメタグフはいつもDAGである。

証明
もしDAGでないとしたら、メタグラフはサイクル（cycle）であることになり、全ての頂点は互いに到達できる関係にあるため、SCCとなり矛盾する。

まとめ
* 頂点の集合を（複数の）強結合成分として分割可能である。
* メタグラフにより強結合成分の関係性を説明できる。
* メタグラフはどんなときもDAG（有向非巡回グラフ）である。


問題  
入力: 有向グラフ$G$  
出力: $G$の強連結成分  


簡単なアルゴリズム  
```
EasySCC (G )
	for each vertex v :
		$v$から到達可能な頂点を決定するためにexpore(v)を実行
	for each vertex v :
		$v$から到達可能であり、かつ$v$に到達可能である$u$を探索する
	these are the SCCs
```

実行時間 $O(&#124;V&#124;^2 + &#124;V&#124;&#124;E&#124;)$  
より早くする必要がある

### 沈コンポーネント (Sink Components)  
もし$v$が沈SCCである場合、explore(v)は$v$から到達可能な頂点を見つける。  
これはまさに$v$のSCCである。
Idea: If v is in a sink SCC, explore (v ) finds vertices reachable from v . This is exactly the SCC of v .

沈SCCの探索
Need a way to find a sink SCC.

定理
もし$C$と$C'$が$C$のある頂点から$C'$のある頂点で結合した強結合成分であるとき、$C$の最も大きいpost-order numberは$C'$の最大のpost-order numberより大きい。


証明  
考えうるケース  
1. $C'$より前にに$C$に訪問する
1. $C$より前にに$C'$に訪問する

ケース１: 先に$C$に訪問する  
$C$から$C'$の全て頂点に到達可能である。  
$C$は最も大きなpost-order numberを持つ。  


ケース２: 先に$C'$に訪問する  
$C$から$C'$に到達不可能である。  
$C$を探索する前に$C'$の探索を完了させる必要がある。  
$C$は最も大きなpost-order numberを持つ。  


結論
最も大きいpost-order numberを持つ成分が源成分（Source Component）である。  

** → しかし、問題は沈成分を求めることである。**


### 逆グラフ (Reverse Graph)
逆グラフ$G^R$は$G$の全てのエッジを逆にしたグラフである。


逆グラフ成分 (Reverse Graph Components)
* $G^R$と$G$は同じSCCを持つ。
* $G^R$の源コンポーネントは$G$の沈コンポーネントである。
$G^R$にてDFSを実行して$G$の沈コンポーネントを見つける。



基礎的なアルゴリズム
```
SCCs(G)
	DFS(逆G)
	Explore(v) // vは最大のpost-orderを持つ
	最終的に到達した頂点は１つ目のSCC
	最終的に到達した頂点をGから取り除き、繰り返す
```

改善点  
$G^R$において再度DFSを実行する必要はない。  
残っているpost-numberの最大値を持つ頂点は沈コンポーネント内に存在する。
Largest remaining post number comes from sink component.


新しいアルゴリズムは以下の通り

```
SCCs(G)
	DFS(逆G)
	for v ∈ V in postorderの降順:
		if not visited(v):
			Explore(v)
			訪問した頂点を新しいSCCとする
```

実行時間
Essentially DFS on $G^R$ and then on $G$ .
Runtime $O(&#124;V&#124; + &#124;E&#124;)$





# week3

----------------------
## 道 (Paths) と距離 (Distances)

Paths and lengths

** 道 (Path) **  
> 頂点の列であり、各頂点とその次の頂点との間に辺が存在する。  
https://ja.wikipedia.org/wiki/%E9%81%93_(%E3%82%B0%E3%83%A9%E3%83%95%E7%90%86%E8%AB%96)

** 長さ (Length)**  
道の長さ$L(P)$とは道に存在するエッジの数である。

** 距離 (Distance) **  
距離とは2つの頂点を結ぶ最も短い長さである。

** 距離レイヤー (Distance layers)**  
任意の点からの距離ごとに分けた集合群


## 幅優先探索 (Breadth-first Search)

```
BFS(G ,S)
	for all u ∈ V :
		dist[u] ← ∞
	dist[S] ← 0
	Q ← {S} //キューの要素はこの時Sのみ
	while Q is not empty:
		u ← Dequeue(Q)
			for all(u, v) ∈ E :
				if dist[v] = ∞ :
					Enqueue(Q, v)
					dist[v] ← dist[u] + 1
```

### 実行時間

**定理**  
幅優先探索の実行時間は$O(&#124;E&#124; + &#124;V&#124;)$である。

**証明**  
* それぞれの頂点は最大1回キューに並ぶ
* それぞれのエッジは有向グラフの場合は1回、非有向グラフの場合は2回評価（examine）される


到達可能性 (Reachability)

**定義**  
$S$から$u$まで道がある場合、頂点$u$は到達可能である

**定理**  
到達可能な頂点はあるポイントで発見される。そのためそれらの頂点は開始点から有限の距離にある。
到達不可能な点は発見されない。そしてそれらの頂点は開始点から無限の距離にある。

**証明**  
* $u$ - reachable undiscovered closest to $S$
* $S - v_1 − · · · − v_k − u$ shortest path
* $u$ is discovered while processing $v_k$


* u first unreachable discovered
* u was discovered while processing v
* u is reachable through v

Order Lemma

**定理**  
$S$から距離$d$にある頂点$u$がキューから取り出されるまでに、$S$から距離$d$以下の全ての頂点はキューに格納される。

**証明**  
Consider the first time the order was broken
d ′ ≤ d ⇒ d ′ − 1 ≤ d − 1, so v ′ was
discovered before u ′ was dequeued


Correct distances
Lemma
When node u is discovered (enqueued),
dist[u] is assigned exactly d (S, u) .

証明
Use mathematical induction
Base: when S is discovered, dist[S] is
assigned 0 = d (S, S)
Inductive step: suppose proved for all
nodes at distance ≤ k from S → prove
for nodes at distance k + 1


証明
Take a node v at distance k + 1 from S
v was discovered while processing u
d (S, v ) ≤ d (S, u) + 1 ⇒ d (S, u) ≥ k
v is discovered after u is dequeued, so
d (S, u) < d (S, v ) = k + 1
So d (S, u) = k , and
dist [v ] ← dist [u] + 1 = k + 1


Queue property

Lemma
At any moment, if the rst node in the
queue is at distance d from S , then all the
nodes in the queue are either at distance d
from S or at distance d + 1 from S . All the
nodes in the queue at distance d go before
(if any) all the nodes at distance d + 1.

Proof
Queue property
All nodes at distance d were enqueued
before rst such node is dequeued, so
they go before nodes at distance d + 1
Nodes at distance d − 1 were enqueued
before nodes at d , so they are not in the
queue anymore
Nodes at distance > d + 1 will be
discovered when all d are gone



### Shortest-path Tree

Lemma
Shortest-path tree is indeed a tree, i.e. it
doesn't contain cycles (it is a connected
component by construction).

Proof
* Only one outgoing edge from each node
* Distance to S decreases after going by edge


Constructing shortest-path tree

```
BFS(G ,S)
	for all u ∈ V :
		dist[u] ← ∞ , prev[u] ← nil
	dist [S] ← 0
	Q ← {S} { queue containing just S}
	while Q is not empty:
		u ← Dequeue (Q)
		for all (u, v) ∈ E :
			if dist[v] = ∞ :
				Enqueue(Q, v)
				dist[v] ← dist[u] + 1 , prev[v] ← u
```

Reconstructing Shortest Path

```
ReconstructPath(S, u, prev)
	result ← empty
	while u != S :
		result.append(u)
		u ← prev[u]
	return Reverse(result)
```

# week4


## 最速のルート (Fastest Route)

**最適な下部構造**  
最適な道の任意の一部はどの部分でも最適である。

**証明**  
頂点$S$から$t$の最適な道とその道上にある頂点$u$と$v$を考える。  
頂点$u$から$v$を結ぶより短い道がある場合、$S$から$t$を結ぶ道もより短くなる。  

**導かれる命題**  
もし$S → ... → u → t$が$S$から$t$までの最短の道の場合、下記の式が成り立つ  

$d(S, t) = d(S, u) + w(u, t)$

※ $w(u, t)$は$u$から$t$のエッジの重み(weight)。


## 緩和法 (Edge relaxation)

* dist[v]は$S$から$v$までの実際の距離の上界となる。（dist[v]は実際の距離以上の値を取る）
* エッジ$(u, v)$に対して行う緩和操作は、$S$から$u$を通り$v$へ行くことが現在のdist[v]の値を向上するかどうかを検証する。


```
Relax((u, v) ∈ E)
	if dist[v] > dist[u] + w(u, v):
		dist[v] ← dist[u] + w(u, v)
		prev[v] ← u
```


Naiveアプローチ

```
Naive(G ,S)
	for all u ∈ V:
		dist[u] ← ∞
		prev[u] ← nil
	dist[S] ← 0
	do:
		全てのエッジに対して緩和操作を実行する
	while 1つ以上のdistが変更されている:
```

**定理**  
Naive()メソッドを呼び出した後はすべての距離が正しく設定されている。

**証明**  
* 矛盾のために、どのエッジも緩和できず、$dist[v] > d(S, v)$を満たす頂点$v$があると仮定する。
* $S$から$v$までの最短距離を考え、$u$を道上の同じプロパティを持った最初の頂点とし、頂点$p$を$u$の直前の頂点とする。

$S → ... → p → u → ... → v$

このとき、$d(S, p) = dist[p]$ となり、
よって、

$d(S, u)  \\\
= d(S, p) + w(p, u)  \\\
= dist [p] + w (p, u)$


$dist [u] > d (S, u) \\\
= dist [p] + w (p, u)$

⇒ エッジ$(p, u)$は緩和可能となり、矛盾である

## Dijkstraアルゴリズム

* 距離が予めわかっている頂点の集合$R$（"known region"）を保つ。
* 最初に$R$に追加される頂点は$S$である。
* イテレーションごとに$R$以外で最小の距離を持つ頂点を取り出し$R$に追加し、その頂点の全てのエッジに対して緩和操作を実行する。

```
Dijkstra(G ,S)
	for all u ∈ V:
		dist[u] ← ∞, prev[u] ← nil
	dist[S] ← 0
	H ← MakeQueue(V) {dist-values as keys}
	while H is not empty:
		u ← ExtractMin(H)
		for all(u, v) ∈ E:
			if dist[v] > dist[u] + w(u, v):
				dist[v] ← dist[u] + w (u, v)
				prev[v] ← u
				ChangePriority(H, v, dist[v])
```

Correct distances

Lemma
When a node $u$ is selected via ExtractMin, dist[u] = d(S, u).




### 実行時間

**実行時間**
総実行時間:
$T(MakeQueue) + |V| · T( ExtractMin ) + |E| · T(ChangePriority)$

優先度キューの実装方法:  
配列:  
$O(&#124;V&#124; + &#124;V&#124; 2 + &#124;E&#124;) = O(&#124;V&#124; 2 )$

バイナリーヒープ:  
$O(&#124;V&#124; + &#124;V&#124; log &#124;V&#124; + &#124;E&#124; log &#124;V&#124;) \\\
= O((&#124;V&#124; + &#124;E&#124;) log &#124;V&#124;)$


## 為替 (Currency Exchange)

Maximum product over paths  
入力:  
いくつかの通貨の間にある為替レートに対応する重み$r\_{e\_i}$が付いた有向エッジ$e_i$が存在する為替グラフ  

出力:  
グラフ内のUSDからRURを通るパス($e\_1, e\_2, ..., e\_k$)上の  
$\sum^{k}\_{j=1} r\_{e\_j} = r\_{e\_1} r\_{e\_2} ... r\_{e\_k}$  
を最大化する

最短パスへのReduction
標準的な2つの方法
* 重みの対数にした値の合算に変更する
* Replace product with sum by taking logarithms of weights
* 最大化に代わって
* Negate weights to solve minimization instead of maximization

**対数を取る方法**  
$xy = 2^{log\_2 (x)} 2^{log\_2(y)} = 2^{log\_2(x)+log\_2(y)}$  
$xy → max ⇔ log\_2(x) + log\_2(y) → max$  
$4 × 1 × 12 = 2 = 2 1$  
$log\_2 (4)+log\_2 (1)+log\_2 (\frac{1}{2}) = 2+0+(−1) = 1$  
$\sum^{k}\_{j=1}r_{e\_j} → max ⇔ \sum^{k}\_{j=1}log(r\_{e\_j}) → max$  


**Negation**  
$\sum^{k}\_{j=1}log(r\_{e\_j}) → max ⇔ − \sum^{k}\_{j=1}log(r\_{e\_j}) → min$  
$\sum^{k}\_{j=1}log(r\_{e\_j}) → max ⇔ \sum^{k}\_{j=1}( - log(r\_{e\_j})) → min$  

Reduction  
Finally: replace edge weights r e i by
(− log(r e i )) and find the shortest path
between USD and RUR in the graph.


Solved?  
Create currency exchange graph with
weights r e i corresponding to exchange
rates
Replace r e i → (− log(r e i ))
Find the shortest path from USD to
RUR by Dijkstra’s algorithm
Do the exchanges corresponding to the
shortest path


Where Dijkstra’s algorithm goes wrong?
* Dijkstra’s algorithm relies on the fact that a shortest path from s to t goes only through vertices that are closer to s.
* This is no longer the case for graphs with negative edges:

Negative weight cycles
$d(S, A) = d(S, B) = d(S, C ) = d(S, D) = −∞$
In currency exchange, a negative cycle can make you a billionaire!

## Bellman–Ford algorithm
Naive algorithm

```
BellmanFord(G , S)
	{no negative weight cycles in G }
	for all u ∈ V:
		dist[u] ← ∞
		prev[u] ← nil
	dist[S] ← 0
	repeat |V| − 1 times:
		for all (u, v) ∈ E:
			Relax(u, v)
```

実行時間  
**定理**  
Bellman–Fordアルゴリズムの実行時間は
$O(|V ||E |)$

**証明**  
* Initialize dist — O(|V |)
* $|V| − 1 iterations, each O(|E |) — O(|V ||E |)$


### Proof of Correctness

**定理**  
緩和操作の$k$回のイテレーション後、どの頂点$u$についても$dist[u]$は多くとも$k$個のエッジを含む$S$から$u$までの道の最小の距離である。

**証明**  
数学的帰納法を用いる  
Base:  
after 0 iterations, all dist-values are ∞, but for dist[S] = 0, which is correct.
Induction:  
proved for k → prove for k + 1

Before k + 1-th iteration, dist[u] is the smallest length of a path from S to u containing at most k edges
Each path from S to u goes through one of the incoming edges (v , u) 
Relaxing by (v , u) is comparing it with the smallest length of a path from S to u through v containing at most k + 1 edge

Corollary  
In a graph without negative weight cycles,
Bellman–Ford algorithm correctly finds all distances from the starting node S.
Corollary
If there is no negative weight cycle reachable from S such that u is reachable from this negative weight cycle, Bellman–Ford algorithm correctly finds dist[u] = d (S, u).


### 負閉路 (Negative weight cycles)

**定理**  
もしBellmanFord(G , S)の(追加の)|V|番目 のイテレーションが距離$dist$の値を更新する場合に限り、グラフ$G$は負閉路を含む。

**証明**  
If there are no negative cycles, then
all shortest paths from S contain at
most |V | − 1 edges (any path with
≥ |V | edges contains a cycle, it is
non-negative, so it can be removed
from the shortest path), so no
dist-value can be updated on
|V |-th iteration.

⇒ There’s a negative weight cycle, say
a → b → c → a, but no
relaxations on |V |-th iteration.
dist[b] ≤ dist[a] + w (a, b)
dist[c] ≤ dist[b] + w (b, c)
dist[a] ≤ dist[c] + w (c, a)
w (a, b) + w (b, c) + w (c, a) ≥ 0 —
a contradiction.

**負閉路を見つける**  
アルゴリズム:  
1. Bellman–Ford アルゴリズムを|V|回実行し、最後のイテレーションで緩和操作をした頂点$v$を記憶する。
1. $v$は負閉路から到達可能である。
1. $x ← v$から開始し、$x ← prev[x]$のリンクを|V|回辿る。これは閉路上である。
1. $y ← x$を記憶し、$x = y$になるまで$x ← prev[x]$を繰り返す。

### 無限の鞘取り (Infinite Arbitrage)

Detect Infinite Arbitrage

**定理**  
It is possible to get any amount of currency u
from currency S if and only if u is reachable
from some node w for which dist[w ]
decreased on iteration V of Bellman-Ford.

**証明**  
dist[w] decreased on iteration V ⇒ w is
reachable from a negative weight cycle
w is reachable ⇒ u is also reachable ⇒
infinite arbitrage

Let L be the length of the shortest path
to u with at most V − 1 edges
After V − 1 iterations, dist[u] is equal
to L
Infinite arbitrage to u ⇒ there exists a
path shorter than L
Thus dist[u] will be decreased on some
iteration k ≥ V

If edge (x, y ) was not relaxed and
dist[x] did not decrease on i-th
iteration, then edge (x, y ) will not be
relaxed on i + 1-st iteration
Only nodes reachable from those relaxed
on previous iterations can be relaxed
dist[u] is decreased on iteration
k ≥ V ⇒ u is reachable from some
node relaxed on V -th iteration

Detect Infinite Arbitrage

Do |V | iterations of Bellman–Ford, save
all nodes relaxed on V -th iteration —
set A
Put all nodes from A in queue Q
Do breadth-first search with queue Q
and find all nodes reachable from A
All those nodes and only those can have
infinite arbitrage

Reconstruct Infinite Arbitrage
During Breadth-First Search, remember
the parent of each visited node
Reconstruct the path to u from some
node w relaxed on iteration V
Go back from w to find negative cycle
from which w is reachable
Use this negative cycle to achieve
infinite arbitrage from S to u


# week5
## Building a Network

最小全域木 (MST: Minimum spanning tree)  
入力:  
正の重みがあるエッジを持つ連結かつ非有向グラフ$G = (V, E)$  
出力:  
グラフ$(V, E′)$が連結かつエッジの重みの総和が最小となるような部分グラフ$E′ ⊆ E$

Remark
エッジの集合$E′$はいつも木構造である。

木の性質
* 木とは連結かつ閉路が無い非有向グラフである。
* $n$個の頂点を持つ木は$n-1$個のエッジを持つ。
* $|E| = |V| − 1$であるどの連結な非有向グラフ$G(V, E)$は木である。
* 任意の2つの頂点を結ぶ道が1意に決まる非有向グラフは木である。


## Cut Property
以下を仮定する:
1. $X ⊆ E$をグラフ$G(V, E)$のMSTの部分とする。
1. $S ⊆ V$の$S$と$V - S$間を結ぶ$X$のエッジは存在しない。
1. $e ∈ E$はこの2つの集合間の最小の重みを持ったエッジとする。
このとき、$X + {e}$はMSTの部分である。


## 2つの貪欲法
### Kruskalアルゴリズム
* 閉路を作らない重みが最小のエッジ$e$を集合$X$に繰り返し追加する。
* 集合$X$は森である（木の集合）。
* 次のエッジ$e$は2つの異なる木$T\1$と$T\_2$を連結する。
* エッジ$e$は$T\_1$と$V-T\_1$間の最小のものである。よって$e$を追加することは安全である。

**実装詳細**
* 連結していない集合を使用する。
* 初期状態として、それぞれの頂点は異なる集合に属している。
* 各集合は連結成分の頂点の集合である。
* 現在のエッジ{$u, v$}が閉路を作るかどうかを検証するために、$u$と$v$が同じ集合に属するかを検証する。

```
Kruskal(G)
	for all u ∈ V:
		MakeSet(v)
	X ← empty set
	sort the edges E by weight
	for all {u, v} ∈ E in non-decreasing
		weight order:
		if Find(u) != Find(v):
			add {u, v} to X
			Union(u, v)
	return X
```

**実行時間**  
**エッジのソート:**  
$O(&#124;E&#124; log &#124;E&#124;) = O(&#124;E&#124; log&#124;V&#124; 2) =$
$O(2&#124;E&#124; log&#124;V&#124;) = O(&#124;E&#124; log&#124;V&#124;)$

**エッジの処理:**  
$2&#124;E&#124; · T (Find) + &#124;V&#124; · T (Union) =$
$O((&#124;E&#124;+&#124;V&#124;) log&#124;V&#124;) = O(&#124;E&#124; log&#124;V&#124;)$

**総実行時間:**  
$O(&#124;E&#124; log&#124;V&#124;)$


### Primアルゴリズム
* $X$はいつも部分木であり、イテレーションごとに1つのエッジが追加される。
* 1つの木の頂点と1つの木でない頂点を結ぶ最も軽いエッジを追加する。
* Dikstraアルゴリズムに類似している。


```
Prim(G)
	for all u ∈ V:
		cost[u] ← ∞
		parent[u] ← nil
	pick any initial vertex u0
	cost[u0] ← 0
	PrioQ ← MakeQueue(V)
	{priority is cost}
	while PrioQ is not empty:
		v ← ExtractMin(PrioQ)
		for all {v ,z} ∈ E:
			if z ∈ PrioQ and cost[z] > w (v, z):
				cost[z] ← w (v, z), parent[z] ← v
				ChangePriority(PrioQ, z, cost[z])
```

**実行時間**  
$&#124;V&#124;·T (ExtractMin)+&#124;E&#124;·T (ChangePriority)$
配列ベースの実装:  
$O(&#124;V&#124; 2 )$
ヒープベースの実装:  
$O((&#124;V&#124; + &#124;E&#124;) log &#124;V&#124;) = O(&#124;E&#124; log &#124;V&#124;)$






