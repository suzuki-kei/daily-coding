
main(_) ->
    Xs = generate_random_values(20),
    print_list(Xs),
    Lower = hd(Xs) - 1,
    Upper = lists:last(Xs) + 1,
    lists:foreach(
        fun (Target) ->
            Index = binary_search(Xs, Target),
            io:format("target=~w, index=~w~n", [Target, Index])
        end,
        lists:seq(Lower, Upper)).

generate_random_values(N) ->
    generate_random_values(N, 9, []).

generate_random_values(0, _Offset, Xs) ->
    lists:reverse(Xs);
generate_random_values(N, Offset, Xs) ->
    X = rand:uniform(5) + 1 + Offset,
    generate_random_values(N - 1, X, [X | Xs]).

print_list(Xs) ->
    Formatted = lists:concat(lists:join(" ", lists:map(fun integer_to_list/1, Xs))),
    io:format("~s~n", [Formatted]).

binary_search(Xs, Target) ->
    binary_search(Xs, Target, 1, length(Xs)).

binary_search(_Xs, _Target, Lower, Upper)
    when Lower > Upper ->
        -1;
binary_search(Xs, Target, Lower, Upper) ->
    CenterIndex = (Lower + Upper) div 2,
    CenterValue = lists:nth(CenterIndex, Xs),
    if
        Target < CenterValue ->
            binary_search(Xs, Target, Lower, CenterIndex - 1);
        Target > CenterValue ->
            binary_search(Xs, Target, CenterIndex + 1, Upper);
        true ->
            CenterIndex
    end.
 
