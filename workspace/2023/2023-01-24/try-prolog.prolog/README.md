# try-prolog

プログラムを実行すると, クエリを受け付ける対話モードになる.

    gprolog --consult-file main.pl
    | ?-

apple は red であるか, というクエリを実行する.

    | ?- red(apple).

結果は yes.

    yes

orange は red であるか.

    | ?- red(orange).

結果は no.

    no

tomato は red なので結果は yes.

    | ?- red(tomato).

    yes

red なのは何かを問い合わせる.
ここで X は変数 (変数は大文字で始まる).

    | ?- red(X).

X は apple であるという結果を得ることができる.

    X = apple ?

`;` を入力すると次の答えを得ることができる.

    X = apple ? ;

次の答えとして tomato を得ることができる.

    X = tomato

それ以上の答えはないので yes と表示される.

    yes

