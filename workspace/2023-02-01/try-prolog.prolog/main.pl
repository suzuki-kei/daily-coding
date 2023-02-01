
human(socrates).
human(taro).
human(jiro).
human(hanako).

die(X) :- human(X).

member(X, [X, _]).
member(X, [_, Y]) :- member(X, Y).

