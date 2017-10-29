Courseraののコースを受講した際のノートです
Algorythms on Strings
Data Structures and Algorithms
by University of California, San Diego & Higher School of Economics



# week1

パターンマッチング

## 総当りマッチング (Brute Force)
Brute Force Approach to Pattern Matching


• single Pattern:
O(|Text| * |Pattern|)
• multiple Patterns:
O(Σ|Text| * |Pattern|)=
all strings Pattern
In Patterns
O(|Text| * |Patterns|)

Approach is Slow for Billions of Patterns
実行時間が遅すぎる

## トライ木マッチング (Trie Matching)
Herding Patterns into Trie

You may find it useful before implementing some of the problems in the Programming Assignment to look closer at the pseudocode for the algorithms discussed in the lectures.

Here is the pseudocode for constructing a trie from a collection of patterns:

**擬似コード**

```
TRIE_CONSTRUCTION(Patterns)
	Trie := a graph consisting of a single node root
	for each string Pattern in Patterns
		currentNode := root
		for i := 1 to |Pattern|
			currentSymbol := i-th symbol of Pattern
			if there is an outgoing edge from currentNode with label currentSymbol
				currentNode := ending node of this edge
			else
				add a new node newNode to Trie
				add a new edge from currentNode to newNode with label currentSymbol
				currentNode := newNode
	return Trie
```

```
PREFIX_TRIE_MATCHING(Text, Trie)
	symbol := first letter of Text
	v := root of Trie
	while forever
		if v is a leaf in Trie
			return the pattern spelled by the path from the root to v
		else if there is an edge(v, w) in Trie labeled by symbol
			symbol := next letter of Text
			v := w
		else
			output "no matches found"
			return
```

```
TRIE_MATCHING(Text, Trie)
	while Text is nonempty
		PREFIX_TRIE_MATCHING(Text, Trie)
		remove first symbol from Text
```

Our trie has 30 edges
a
n
• # edges = O(|Patterns|)!

メモリー使用量が多すぎる


## Herding Text into Suffix Trie

The suffix trie is formed
from |Text| suffixes
with total length:

|Text|*(|Text|– 1)/2

メモリー使用量が多すぎる

## From Suffix Tries to Suffix Trees

Since each suffix adds one leaf and at most one
internal vertex to the suffix tree:
• # $vertices < 2|Text|$ >
• memory footprint of the suffix tree: O(|Text|)
• storing edge labels

Why did we bother to add “$” to “panamabananas”?
• to make sure that each suffix corresponds to a leaf
Why do we want to make sure that each suffix
correspond to a leaf?
• construct suffix tree for “papa”(without adding “$”)
and compare it with the suffix tree for “papa$”


Constructing Suffix Tree: Linear-Time Algorithm
• Linear runtime (for a constant-size alphabet):
– O(|Text|)

Linear-time algorithm (Weiner, 1973) was simplified by Ukkonen (1995)
but it is still too complex to cover in this course

Big Secret of the Big O Notation
• Suffix trees enable fast Exact Multiple Pattern Matching:
• Runtime: O(|Text| + |Patterns|)
• Memory: O(|Text|)
• However, big-O notation hides constants!
• suffix tree algorithms has large memory footprint
~ 20|Text| for long texts like human genome
• We want to find mutations!
• it is unclear how to develop fast Approximate
Multiple Pattern Matching using suffix trees


# week2

## ブロックソート (Burrows-Wheeler Transform)

week2では文字列の圧縮に使用されるブロックソート(Burrows-Wheeler Transform)を学びます

> 長さ n のデータを巡回シフトし、得られるすべての文字列を辞書順にソートする。このようにしてできた n×n 行列の第 n 列を取り出したものが、BWT系列である。このBWT系列と、元の文字列がソートされた時行列の第何番目になったかを記憶しておくと、これから元の文字列を復号する事ができる。

https://ja.wikipedia.org/wiki/%E3%83%96%E3%83%AD%E3%83%83%E3%82%AF%E3%82%BD%E3%83%BC%E3%83%88

||A|B|C|D|E|F|
|---|---|---|---|---|---|
|**1**|c|a|c|a|o|**$**|
|**2**|**$**|c|a|c|a|o|
|**3**|o|**$**|c|a|c|a|
|**4**|a|o|**$**|c|a|c|
|**5**|c|a|o|**$**|c|a|
|**6**|a|c|a|o|**$**|c|

||A|B|C|D|E|F|
|---|---|---|---|---|---|
|**1**|**$**|c|a|c|a|o|
|**2**|a|c|a|o|**$**|c|
|**3**|a|o|**$**|c|a|c|
|**4**|c|a|c|a|o|**$**|
|**5**|c|a|o|**$**|c|a|
|**6**|o|**$**|c|a|c|a|


得られる値  
BWT(cacao$) = occ$aa

※後述の通り、ブロックソートで必要なのは最終列のため、以下のコードで得ることができる

```
def BWT(text):
    table = sorted(text[i:] + text[:i] for i in range(len(text)))
    last_column = [row[-1:] for row in table]
    return ''.join(last_column)
```

### ブロックソートの逆変換

BWT系列の文字列「occ$aa」をソートすると求める行列のA列が得られる。 (A列とE列に含まれるアルファベットは同一であり, A列はソートされているため)

||A|B|C|D|E|F|
|---|---|---|---|---|---|
|**1**|**$**|?|?|?|?|o|
|**2**|a|?|?|?|?|c|
|**3**|a|?|?|?|?|c|
|**4**|c|?|?|?|?|**$**|
|**5**|c|?|?|?|?|a|
|**6**|o|?|?|?|?|a|

右シフトする

||A|B|C|D|E|F|
|---|---|---|---|---|---|
|**1**|o|**$**|?|?|?|?|
|**2**|c|a|?|?|?|?|
|**3**|c|a|?|?|?|?|
|**4**|**$**|c|?|?|?|?|
|**5**|a|c|?|?|?|?|
|**6**|a|o|?|?|?|?|

A列でソート

||A|B|C|D|E|F|
|---|---|---|---|---|---|
|**1**|**$**|c|?|?|?|o|
|**2**|a|c|?|?|?|c|
|**3**|a|o|?|?|?|c|
|**4**|c|a|?|?|?|**$**|
|**5**|c|a|?|?|?|a|
|**6**|o|**$**|?|?|?|a|

右シフト、A列でソートを繰り返す

||A|B|C|D|E|F|
|---|---|---|---|---|---|
|**1**|**$**|**c**|**a**|**c**|**a**|**o**|
|**2**|a|c|a|o|$|c|
|**3**|a|o|$|c|a|c|
|**4**|c|a|c|a|o|$|
|**5**|c|a|o|$|c|a|
|**6**|o|$|c|a|c|a|

元の文字列cacao$が得られる

テキストの再構築  
メモリ使用量  
$|Text|^2$

実行時間  
$O(|Text|^3log|Text|)$


→ メモリ・計算量を減らしたい

#### First-Last Property

ここで、巡回行列には以下の法則があるります。

任意の1字Cについて、初列でk番目に現れる文字$c\_{k\_f}$と最終列でk番目に現れる$c\_{k\_l}$は求める文字列$Text$内で同じ位置の文字である。


||A|B|C|D|E|F|
|---|---|---|---|---|---|
|**1**|**$**|?|?|?|?|o1|
|**2**|a1|?|?|?|?|c1|
|**3**|a2|?|?|?|?|c2|
|**4**|c1|?|?|?|?|**$**|
|**5**|c2|?|?|?|?|a1|
|**6**|o1|?|?|?|?|a2|

この法則を利用し求める文字列$Text$を逆順に求めていく

1行目A列の$から始め、F列のo1（最終列の文字は初列の1つ前の文字）

A列で1番目に現れる6行目のo1を探索

6行目のF列のa2（最終列の文字は初列の1つ前の文字）

...

（繰り返し）

...

このようにして逆順に文字列を求めていく

メモリ使用量と実行時間は以下のようになる  

|||
|---|---|
|メモリ使用量|$2&#124;Text&#124;$|
|実行時間|$O(&#124;Text&#124;)$#|

## パターンマッチングでBWTを使う


```
BWMATCHING(FirstColumn, LastColumn, Pattern, LASTTOFIRST):
	top0
	bottomLastColumn1
	while topS bottom:
		if Pattern is nonempty:
			symbollast letter in Pattern
			remove last letter from Pattern
			if positions from top to bottom in LastColumn contain symbol:
				toplndex :=  first position of symbol among positions from top to bottom in LastColumn
				bottomindex := last position of symbol among positions from top to bottom in LastColumn
				top := LASTTOFIRST(toplndex)
				bottom := LASTTOFIRST(bottomlndex)
			else:
				return O
		else:
			return bottom -top
```

```
BETTERBWMMATCHING(FIRSTOCCURRENCE, LastColumn, Patterm, COUNT):
	top0 := 0
	bottom := |LastColumnl - 1
	while top <= bottom:
		if Pattern is nonempty:
			symbol := last letter in Pattern
			remove last letter from Pattern
			top := FIRSTOCCURRENCE(symbol) + COUNT_symbol(top, LastColumn)
			bottom := FIRSTOCCURRENCE(symbol) + COUNT_symbol(bottom+1, LastColumn)-1
		else:
			return bottom - top + 1
	return
```



## Suffix Arrays
Where Are the Matches?

Suffix array: holds starting
position of each suffix
beginning
a row.

Naïve algorithm for constructing suffix array (sorting all suffixes of Text)
O(|Text| log|Text|) comparisons

Constructing Suffix Array
• Depth-first traversal of suffix tree
• O(|Text|) time and ~20|Text| space
• Manber-Myers algorithm (1990):
• O(|Text|) time and ~4|Text| space

Reducing Memory Footprint for Suffix Array
• Can we store only a fraction of the suffix array
but still do fast pattern matching?
• Partial suffix array SuffixArray K (Text) only
contains values that are multiples of some
integer K

## Approximate Pattern Matching

Returning to Search for Mutations
• Approximate Pattern Matching Problem:
• Input: A string Pattern, a string Text, and an integer d.
• Output: All positions in Text where the string Pattern
appears as a substring with at most d mismatches.

Revealing Mutations by Analyzing
Billions of Reads
• Multiple Approximate Pattern Matching Problem
• Input: A set of strings Patterns, a string Text, and an integer d.
• Output: All positions in Text where a string from Patterns appears
as a substring with at most d mismatches.


# week3


## 完全パターンマッチ (Exact Pattern Matching)

Exact Pattern Matching
Input:
Strings T
Output: All such positions in where P P (Pattern). T (Text) (Text) and (Pattern) appears as a substring.

### 総当り (Brute Force Algorithm)
Slide the Pattern down Text
実行時間:  
$Θ(|T||P|)$

#### Skipping Positions

Definitions  
Border of string S is a prefix of S which is equal to a suffix S, but not equal to the whole S.  

Example  
'a' is a border of 'arba'  
'ab' is a border of 'abcdab'  
'abab' is a border of 'ababab'  
'ab' is not a border of 'ab'  


#### Shifting Pattern
Find longest common prex
u
w  the longest border of u
Move P such that prex w in P aligns
with sux w of u in T

Now you know we can skip some of the
comparisons
But we shouldn't miss any of the
pattern occurrences in the text
Is it safe to shift the pattern this way?

## Safe Shift

### Suffix notation
定義  
$S\_k$は位置$k$から始まる文字列$S$の接尾辞である。

Examples  
$S = 'abcd' ⇒ S\_2 = 'cd'$
$T = 'abc' ⇒ T\_0 = 'abc'$
$P = 'aa' ⇒ P\_1 = 'a'$


定理  
Let u
T k . Let
be the longest common prex of
w
be the longest border of
u .
P
and
Then
P in T starting
between positions k and (k + |u| − |w |) 
the start of sux w in the prex u of T k .


Suppose P occurs in T in position i
between k and start of sux w
Then there is prex v of P equal to
sux in u , and v is longer than w

Then there is prex
sux in
v
u ,
and
v
v
of
equal to
w
w , but w
is longer than
is a border longer than
longest border of
P
u
 contradiction

Now you know it is possible to avoid
many of the comparisons which Brute
Force algorithm does
But how to determine the best pattern
shifts?

## 接頭辞関数 (Prefix Function)

定義  
文字列$P$の接頭辞関数とはそれぞれの$i$について接頭辞$P[0:i]$の最長のBorderを返す関数である。

|文字列|a|b|a|b|a|b|c|a|a|b|
|---|---|---|---|---|---|---|---|---|---|---|---|
|s(i)|0|0|1|2|3|4|0|1|1|2|

定理  
P[ 0 ..i]
has a border of length
s(i + 1 ) − 1

証明  
Take the longest border
w
of
Cut the last character from
border of
P[ 0 ..i]
now

Corollary
s(i + 1 ) ≤ s(i) + 1

Enumerating borders
Lemma
If
s(i) > 0,
then all borders of
P[ 0 ..i]
the longest one are also borders of
P[ 0 ..s(i) − 1 ] .

証明  
|u| \lt s(i)
Then u is both a prex and a sux of
P[ 0 ..s(i) − 1 ]
u ̸ = P[ 0 ..s(i) − 1 ] , so u is a border of
P[ 0 ..s(i) − 1 ]

Now you know lots of properties of
prex function
But how to compute all of its values??

## 接頭辞関数の計算

```
ComputePrefixFunction( P )
	s ← array of integers of length |P|
	s[ 0 ] ← 0 , border ← 0
	for i from 1 to |P| − 1 :
		while (border > 0 ) and (P[i] != P[border]):
			border ← s[border − 1 ]
		if P[i] == P[border ] :
			border ← border + 1
		else:
			border ← 0
		s[i] ← border
	return s
```

Lemma
The running time of
ComputePrefixFunction
is
O(|P|) .

Proof
Everything but for inner while loop is
O(|P|)
initialization plus
iterations of the for loop
O(|P|)
with O( 1 )
assignments on each iteration

Now we will bound the number of the
while loop iterations by
O(|P|)

border
can increase at most by 1 on
each iteration of the for loop
In total,
border
is increased
O(|P|)
times
border
is decreased at least by 1 on
each iteration of the while loop
border ≥ 0
So there are
while loop
O(|



Now you know how to compute prex
function in linear time
But how to nd pattern in text??

## Knuth-Morris-Prattアルゴリズム

**文字列$T$からパターン$P$を検索する**   
* $S = P + '\$' + T$を作成。  
* $S$について接頭辞関数を計算する。
* $i > |P|$と$s(i) = |P|$を満たす全ての位置$i$について、$i − 2 |P|$を出力する。

Explanation  
For all i , s(i) ≤ |P| because of the special character '$'
if i > |P| and s(i) = |P| , then P = S[ 0 ..|P| − 1 ] = S[i − |P| + 1 ..i] = T [i − 2 |P|..i − |P| − 1 ]
If s(i) < |P| , no full occurrence of |P| ends in position i

>

```
FindAllOccurrences( P, T )
	S ← P + ’$’ + T
	s ← ComputePrefixFunction(S)
	result ← empty list
	for i from |P| + 1 to |S| − 1 :
		if s[i] == |P| :
			result.Append( i − 2 |P| )
	return result
```

Lemma
The running time of Knuth-Morris-Pratt algorithm is O(|P| + |T |) .

Proof
* Building string S is O(|P| + |T |)
* Computing prex function is O(|S|) = O(|P| + |T |)
* The for loop runs O(|S|) = O(|P| + |T |) iterations

Conclusion
* Can search pattern in text in linear time
* Can compute prex function of a string in linear time
* Can enumerate all borders of a string




# week4

## 接尾辞配列 (Suffix Array)

接尾辞配列の構築
入力: 文字列S
出力: 辞書順の全ての接尾辞

例）
S = ababaa の場合の辞書順の接尾辞は以下のようになる  
a  
aa  
abaa  
ababaa  
baa  
babaa  

### 接尾辞配列の保持
Total length of all suffixes is
$1 + 2 + · · · + |S| = Θ(|S|^2)$
メモリー消費量が多すぎる
接尾辞の順番を持つようにする
$O(|S|)$

例）  
S = ababaa$  
接尾辞は開始位置のインデックスとする  
例えば ababaa$ is 0, abaa$ is 2
接尾辞配列は以下のようになる  
[6, 5, 4, 2, 0, 3, 1]  

## 一般的な接尾辞配列の構築方法

### 巡回シフトのソート (Sorting Cyclic Shifts)

|1. 巡回シフト|2. ソート|3. '$'移行を削除|
|---|---|---|
|ababaa$|$ababaa|$|
|babaa$a|a$ababa|a$|
|abaa$ab|aa$abab|aa$|
|baa$aba|abaa$ab|abaa$|
|aa$abab|ababaa$|ababaa$|
|a$ababa|baa$aba|baa$|
|$ababaa|babaa$a|babaa$|

定理  
After adding to the end of string S character
$ which is smaller than all other characters,
sorting cyclic shifts of S and suffixes of S is
equivalent.

### 部分的巡回シフト (Partial Cyclic Shifts)

各接尾辞の全ての文字でなくてもソートできる場合がある。

定義  
巡回文字列$S$の部分文字列を部分的巡回シフトと呼ぶ

**一般的な戦略**  
1. $S$の1文字のソートから開始する。
1. 長さ$L = 1$の巡回シフトをソートする。
1. While $L &lt; |S|$, sort 長さ$2L$の巡回シフトをソートする。
1. もし$L ≥ |S|$のとき、長さ$L$の巡回シフトをソートする。
1. 長さ$|S|$の巡回シフトについても同様の操作を行う。

## 初期化 

1文字のソート 

```
SortCharacters(S)
	order ← 要素数|S|の配列
	count ← 要素数|Σ|の要素の値が0の配列 // |Σ|は文字の数（種類）
	for i from 0 to |S| − 1:
		count[S[i]] ← count[S[i]] + 1
	for j from 1 to |Σ| − 1:
		count[j] ← count[j] + count[j − 1]
	for i from |S| − 1 down to 0:
		c ← S[i]
		count[c] ← count[c] − 1
		order [count[c]] ← i
	return order
```

定理  
SortCharactersの実行時間は  
$O(|S| + |\Sigma|)$

証明  
We know this is the running time of the counting sort for |S| items that can take |Σ| different values.

### 等価クラス (Equivalence classes)

$C_i$ — 開始位置がiの長さLの部分巡回シフト  
2つは同値なりえる — $C_i$と$C_j$が１つの等価クラスに属する  
Compute class[i] — number of different  
cyclic shifts of length L that are strictly  
smaller than C i  
C i == C j ⇔ class[i] == class[j]  

例）  
S = ababaa$  
6 $   
0 a   
2 a   
4 a   
5 a   
1 b   
3 b  
order = [6, 0, 2, 4, 5, 1, 3]  
class = [1, 2, 1, 2, 1, 1, 0]  

```
ComputeCharClasses(S, order )
	class ← array of size |S|
	class[order [0]] ← 0
	for i from 1 to |S| − 1:
		if S[order [i]] ̸ = S[order [i − 1]]:
			class[order [i]] = class[order [i − 1]] + 1
		else:
			class[order [i]] = class[order [i − 1]]
	return class
```
定理  
ComputeCharClassesの実行時間は  
$O(|S|)$

証明  
One for loop with O(|S|) iterations.

## 2倍長巡回シフト (Doubled Cyclic Shifts) のソート

$C\_i$ — 開始位置がiの長さLの巡回シフト  
$C\_i'$ — $i$から始まる2倍長巡回シフト
$C\_i' = C\_i C\_{i+L}$ — 文字列の結合  
$C\_i′$と$C\_j′$を比較するには、$C\_i$と$C\_j$、それに$C\_{i+L}$と$C\_{j+L}$を比較すれば十分である。  

例）  
$S = ababaa$  
$L = 2$  
$i = 2$  
$C\_i = C\_2 = ab$  
$C\_{i+L} = C\_{2+2} = C\_4 = aa$  
$C\_i′ = C\_2′ = abaa = C\_2 C\_4$  

## ペアのソート (Sorting pairs)

1. 第二のペアをソートする
1. 第一のペアを安定ソートする

Sorting doubled cyclic shifts
C i ′ — doubled cyclic shift starting in i
C i ′ is a pair (C i , C i+L )
C order [0] , C order [1] , . . . , C order [|S|−1] are
already sorted
Take doubled cyclic shifts starting
exactly L counter-clockwise (“to the
left”)
′
′
C order
[0]−L , C order [1]−L , . . . , C order [|S|−1]−L
are sorted by second element of pair

C order
[0]−L , C order [1]−L , . . . , C order [|S|−1]−L
are sorted by second element of pair
Need a stable sort by first elements of
pairs
Counting sort is stable!
We know equivalence classes of single
shifts for counting sort

```
SortDoubled(S, L, order , class)
	count ← zero array of size |S|
	newOrder ← array of size |S|
	for i from 0 to |S| − 1:
		count[class[i]] ← count[class[i]] + 1
	for j from 1 to |S| − 1:
		count[j] ← count[j] + count[j − 1]
	for i from |S| − 1 down to 0:
		start ← (order [i] − L + |S|) mod |S|
		cl ← class[start]
		count[cl] ← count[cl] − 1
		newOrder [count[cl]] ← start
	return newOrder
```

定理  
The running time of SortDoubled is O(|S|).

証明  
Three for loops with O(|S|) iterations each.

## クラスの更新
Pairs are sorted — go through them in
order, if a pair is different from previous,
put it into a new class, otherwise put it
into previous class
(P 1 , P 2 ) == (Q 1 , Q 2 ) ⇔
(P 1 == Q 1 ) and (P 2 == Q 2 )
We know equivalence classes of
elements of pairs

```
UpdateClasses(newOrder , class, L)
	n ← |newOrder |
	newClass ← array of size n
	newClass[newOrder [0]] ← 0
	for i from 1 to n − 1:
		cur ← newOrder [i], prev ← newOrder [i − 1]
		mid ← (cur + L), midPrev ← (prev + L) (mod n)
		if class[cur ] ̸ = class[prev ] or class[mid] ̸ = class[midPrev ]:
			newClass[cur ] ← newClass[prev ] + 1
		else:
			newClass[cur ] ← newClass[prev ]
	return newClass
```

**定理**  
UpdateClassesの実行時間は
$O(|S|)$

**証明**  
One for loop with O(|S|) iterations.

```
BuildSuffixArray(S)
	order ← SortCharacters(S)
	class ← ComputeCharClasses(S, order )
	L ← 1
	while L &lt; |S|:
		order ← SortDoubled(S, L, order , class)
		class ← UpdateClasses(order , class, L)
		L ← 2L
	return order
```

**定理**  
BuildSuffixArrayの実行時間は  
$O(|S| log |S| + |\Sigma|)$

**証明**  
Initialization: SortCharacters in
O(|S| + |Σ|) and
ComputeCharClasses in O(|S|)
While loop iteration: SortDoubled and
UpdateClasses run in O(|S|)
O(log |S|) iterations while $L &lt; |S|$



**結論**  
接尾辞配列を  
実行時間: $O(|S| log |S|)$  
メモリー消費量: $O(|S|)$  
で構築可能。  
全ての巡回シフトを$O(|S|log|S|)$でソート可能。


## 接尾辞配列と接尾辞木

### 接尾辞配列の構築

入力: 文字列 S
出力: Sの接尾辞配列
このコースの初めに学んだアルゴリズムでは実行時間が$O(|S|^2)$のため、短い文字列にしか適用できない。

### 最長共通接頭辞 (LCP: Longest Common Prefix)

定義  
2つの文字列$S$と$T$のLCPは両方の共通接頭語のなかで最も長い文字列$u$である。

例）
LCP(“ababc”, “abc”) = 2
LCP(“a”, “b”) = 0

LCP array property
Lemma
For any $i &lt; j$, LCP(A[i], A[j]) ≤ lcp[i] and
LCP(A[i], A[j]) ≤ lcp[j − 1].


Computing LCP array
For each i, compute LCP(A[i], A[i + 1])
via comparing A[i] and A[i + 1]
character-by-character
O(|S|) for each i, O(|S|) different i —
total time O(|S| 2 )
How to do this faster?

## LCP配列の計算

定理  
$h$を接尾辞配列の要素$S_{i-1}とその隣（次）の接尾辞のLCPとすると、
$S_i$とその隣（次）の接尾辞のLCPは少なくとも$h-1$となる。

例）
S = abracadabra$

|index|sorted suffix|LCP|
|---|---|---|
|...|...|...|
|i = 10|a$|1 ≥ h − 1|
|7|abra$|...|
|...|...|...|
|j = 3|acadabra$|...|
|...|...|...|
|i − 1 = 9|ra$|h = 2|
|j − 1 = 2|racadabra$|...|


* Start by computing LCP(A[0], A[1]) directly
* Instead of computing to LCP(A[1], A[2]), move A[0] one position to the right in the string, get some A[k] and compute LCP(A[k], A[k + 1])
* Repeat this until LCP array is fully computed
* Length of the LCP never decreases by more than one each iteration

Notation
Let A n(i) be the suffix starting in the next position in the string after A[i]

例）
A[0] = “ababdabc”, A[1] = “abc”
Compute LCP(A[0], A[1]) = 2 directly
LCP(A n(0) , A n(1) ) ≥ LCP(A[0], A[1]) − 1
A[0] &lt; A[1] ⇒ A n(0) &lt; A n(1)
LCP of A n(0) with the next in order
A[j] is also at least LCP(A[0], A[1]) − 1


LCP(A n(0) , A n(1) ) ≥ LCP(A[0], A[1]) − 1
A[0] &lt; A[1] ⇒ A n(0) &lt; A n(1)
LCP of A n(0) with the next in order
A[j] is also at least LCP(A[0], A[1]) − 1
Compute LCP(A n(0) , A[j]) directly, but
don’t compare first LCP(A[0], A[1]) − 1
characters: they are equal


Algorithm
Compute LCP(A[0], A[1]) directly, save
as lcp
First suffix goes to the next in the
string
Second suffix is the next in the order
Compute LCP knowing that first lcp − 1
characters are equal, save lcp
Repeat

```
LCPOfSuffixes(S, i, j, equal )
	lcp ← max(0, equal )
	while i + lcp < |S| and j + lcp < |S|:
		if S[i + lcp] == S[j + lcp]:
			lcp ← lcp + 1
		else:
			break
	return lcp
```

```
InvertSuffixArray(order )
	pos ← array of size |order |
	for i from 0 to |pos| − 1:
		pos[order [i]] ← i
	return pos
```
Conclusion
Can build suffix tree from suffix array in
linear time
Can build suffix tree from scratch in
time O(|S| log |S|)

```
ComputeLCPArray(S, order )
	lcpArray ← array of size |S| − 1
	lcp ← 0
	posInOrder ← InvertSuffixArray(order )
	suffix ← order [0]
	for i from 0 to |S| − 1:
		orderIndex ← posInOrder [suffix]
		if orderIndex == |S| − 1:
			lcp ← 0
			suffix ← (suffix + 1) mod |S|
			continue
		nextSuffix ← order [orderIndex + 1]
		lcp ← LCPOfSuffixes(S, suffix, nextSuffix, lcp − 1)
		lcpArray [orderIndex] ← lcp
		suffix ← (suffix + 1) mod |S|
	return lcpArray
```

Lemma
This algorithm computes LCP array in
O(|S|)

Proof
Each comparison increases lcp
lcp ≤ |S|
Each iteration lcp decreases by at most
1
Number of comparisons is O(|S|)

## 接尾時木の構築

* Build suffix array and LCP array
* Start from only root vertex
* Grow first edge for the first suffix
* For each next suffix, go up from the leaf until LCP with previous is below
* Build a new edge for the new suffix

```
class SuffixTreeNode:
	SuffixTreeNode parent
	Map<char, SuffixTreeNode> children
	integer stringDepth
	integer edgeStart
	integer edgeEnd
```

```
STFromSA(S, order , lcpArray )
	root ← new SuffixTreeNode(
		children = {} , parent = nil, stringDepth = 0,
		edgeStart = −1, edgeEnd = −1)
	lcpPrev ← 0
	curNode ← root
	for i from 0 to |S| − 1:
		suffix ← order [i]
		while curNode.stringDepth > lcpPrev :
			curNode ← curNode.parent
		if curNode.stringDepth == lcpPrev :
			curNode ← CreateNewLeaf(curNode, S, suffix)
		else:
			edgeStart ← order [i − 1] + curNode.stringDepth
			offset ← lcpPrev − curNode.stringDepth
			midNode ← BreakEdge(curNode, S, edgeStart, offset)
			curNode ← CreateNewLeaf(midNode, S, suffix)
		if i < |S| − 1:
			lcpPrev ← lcpArray [i]
	return root
```

```
CreateNewLeaf(node, S, suffix)
	leaf ← new SuffixTreeNode(
		children = {} ,
		parent = node,
		stringDepth = |S| − suffix,
		edgeStart = suffix + node.stringDepth,
		edgeEnd = |S| − 1)
	node.children[S[leaf .edgeStart]] ← leaf
	return leaf
```

```
BreakEdge(node, S, start, offset)
	startChar ← S[start]
	midChar ← S[start + offset]
	midNode ← new SuffixTreeNode(
		children = {} ,
		parent = node,
		stringDepth = node.stringDepth + offset,
		edgeStart = start,
		edgeEnd = start + offset − 1)
	midNode.children[midChar ] ← node.children[startChar ]
	node.children[startChar ].parent ← midNode
	node.children[startChar ].edgeStart ← start + offset
	node.children[startChar ] ← midNode
	return midNode
```


Lemma
This algorithm runs in O(|S|)

Proof
Total number of edges in suffix tree is
O(|S|)
For each edge, we go at most once
down and at most once up
Constant time to create a new edge and
possibly a new node

Conclusion
Can build suffix tree from suffix array in
linear time
Can build suffix tree from scratch in
time O(|S| log |S|)


