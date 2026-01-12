\ -----------------------------------------------------------------------------
\
\ (1) gforth の組み込みワード s+ を使う方法
\
\ -----------------------------------------------------------------------------

s" Hello, " s" World!" s+

type s\" \n" type



\ -----------------------------------------------------------------------------
\
\ (2) 以下で紹介されている方法
\ https://stackoverflow.com/questions/22360976/stack-underflow-on-multiple-string-concatenations-using-gforth
\
\  * pad ( -- c-addr )
\    中間処理用のデータを保存するための一時領域のアドレスを返す.
\    詳細: https://forth-standard.org/standard/core/PAD
\
\  * place ( c-addr1 u c-addr2 -- )
\    c-addr1 から u 文字を c-addr2 にコピーする.
\    詳細: https://forth-standard.org/proposals/place-place
\
\  * +place ( c-addr1 u1 c-addr2 -- )
\    c-addr1 から u1 文字を c-addr2 の末尾に連結する.
\    詳細: https://forth-standard.org/proposals/place-place
\
\  * count ( c-addr1 -- c-addr2 u )
\    c-addr1 の文字列指定 (アドレスと文字列長) を返す.
\    詳細: https://forth-standard.org/standard/core/COUNT
\
\ -----------------------------------------------------------------------------

\ "Hello, " を一時領域にコピーする.
s" Hello, " pad place

\ "World!" を一次領域の末尾に連結する.
\ NOTE: pad は前回の呼び出しと同じ値を返す.
s" World!" pad +place

\ 一時領域から文字列のアドレスと文字列長を取得する.
pad count

type s\" \n" type

