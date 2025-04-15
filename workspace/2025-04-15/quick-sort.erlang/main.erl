
main(_) ->
    Xs = generate_random_values(20),
    print_list(Xs),
    SortedXs = quick_sort(Xs),
    print_list(SortedXs).

generate_random_value() ->
    rand:uniform(90) + 9.

generate_random_values(N) ->
    generate_random_values(N, []).

generate_random_values(0, Xs) ->
    Xs;
generate_random_values(N, Xs) ->
    generate_random_values(N - 1, [generate_random_value() | Xs]).

print_list(Xs) ->
    Formatted = list_to_string(" ", Xs),
    case is_sorted(Xs) of
        true  -> io:format("~s (sorted)\n", [Formatted]);
        false -> io:format("~s (not sorted)\n", [Formatted])
    end.

list_to_string(Separator, Xs) ->
    lists:concat(lists:join(Separator, Xs)).

is_sorted([]) ->
    true;
is_sorted([_]) ->
    true;
is_sorted([X1, X2 | Xs]) ->
    X1 =< X2 andalso is_sorted([X2 | Xs]).

quick_sort([]) ->
    [];
quick_sort([X | Xs]) ->
    {LessXs, EqualXs, GreaterXs} = partition(X, [X | Xs]),
    quick_sort(LessXs) ++ EqualXs ++ quick_sort(GreaterXs).

partition(Pivot, Xs) ->
    partition(Pivot, Xs, [], [], []).
partition(_Pivot, [], LessXs, EqualXs, GreaterXs) ->
    {LessXs, EqualXs, GreaterXs};
partition(Pivot, [X | Xs], LessXs, EqualXs, GreaterXs) when X < Pivot ->
    partition(Pivot, Xs, [X | LessXs], EqualXs, GreaterXs);
partition(Pivot, [X | Xs], LessXs, EqualXs, GreaterXs) when X =:= Pivot ->
    partition(Pivot, Xs, LessXs, [X | EqualXs], GreaterXs);
partition(Pivot, [X | Xs], LessXs, EqualXs, GreaterXs) when X > Pivot ->
    partition(Pivot, Xs, LessXs, EqualXs, [X | GreaterXs]).

