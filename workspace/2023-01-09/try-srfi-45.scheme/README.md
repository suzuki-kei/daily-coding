# try-srfi-45

## 関連文書

 * SRFI-45 Primitives for Expressing Iterative Lazy Algorithms
   - https://srfi.schemers.org/srfi-45/srfi-45.html

 * 遅延評価 (Gauche ユーザリファレンス)
   - https://practical-scheme.net/gauche/man/gauche-refj/Chi-Yan-Ping-Jia-.html

## 手続き

 * delay expression -> (Promise a)
   - 任意の式を受け取り, (Promise a) 型のプロミスを返す.

 * lazy (Promise a) -> (Promise a)
   - (Promise a) 型の式を受け取り, (Promise a) 型のプロミスを返す.

 * force (Promise a) -> a
   - (Promise a) 型のプロミスを受け取り, a の値を返す.
   - a の値が計算済みの場合は計算済みの値を返す.
   - a の値が計算済みでない場合は a の値を計算し, その値を返す.

 * eager expression -> (Promise a)
   - 型 a の式を受け取り, (Promise a) 型のプロミスを返す.
   - expression は先行評価される.
   - 遅延評価する必要はないが, プロミスを受け取る手続きに渡す場合に使用する.

## 簡約ルール

[SRFI-45 Primitives for Expressing Iterative Lazy Algorithms](https://srfi.schemers.org/srfi-45/srfi-45.html) より引用:

> (force (delay expression)) -> expression
> (force (lazy  expression)) -> (force expression)
> (force (eager value))      -> value

## lazy の出現場所

[遅延評価 (Gauche ユーザリファレンス)](https://practical-scheme.net/gauche/man/gauche-refj/Chi-Yan-Ping-Jia-.html) より引用:

> Schemeでは静的な型付けをしないので、この使い分けを強制することができません。
> 文脈にしたがってプログラマが適切に選択する必要があります。
> 一般的にはlazyは遅延アルゴリズムを表現している関数本体全体を囲む場合 にのみ出現します。

