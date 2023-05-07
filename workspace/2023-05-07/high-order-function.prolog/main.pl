
main :-
    range(1, 10, Xs),

    format("values:~n"),
    foreach(member(X, Xs), format("~w ", [X])), nl,

    format("odd values:~n"),
    foreach(find(X, Xs, odd), format("~w ", [X])), nl,

    format("even values:~n"),
    foreach(find(X, Xs, even), format("~w ", [X])), nl,

    halt.

%
% 整数 X が奇数であることを判定する.
%
odd(X) :-
    X mod 2 =:= 1.

%
% 整数 X が偶数であることを判定する.
%
even(X) :-
    X mod 2 =:= 0.

%
% range(Min, Max, Xs)
%
% Min 以上 Max 以下の整数からなるリスト Xs を生成する.
%
range(Min, Max, []) :-
    Min > Max.

range(Min, Max, [X|Xs]) :-
    Min =< Max,
    is(X, Min),
    is(NextMin, Min + 1),
    range(NextMin, Max, Xs).

%
% find(X, Xs, Predicate)
%
% リスト Xs のうち Predicate(X) を満たす X を検索する.
%
find(X, [Head|Tail], Predicate) :-
    find(X, Head, Tail, Predicate).

find(X, X, _, Predicate) :-
    call(Predicate, X).

find(X, _, [Head|Tail], Predicate) :-
    find(X, Head, Tail, Predicate).

