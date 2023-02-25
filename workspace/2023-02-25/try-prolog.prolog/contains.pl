
%
% contains(X, [1, 2, 3]).
%
contains(X, [X|_]) :-
    true.
contains(X, [_|Y]) :-
    contains(X, Y).

