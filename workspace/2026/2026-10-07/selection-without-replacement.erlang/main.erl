
main(_) ->
    Xs = selection_without_replacement(20, 10, 99),
    io:format("~s~n", [lists:concat(lists:join(" ", Xs))]),
    ok.

selection_without_replacement(N, Min, Max) ->
    selection_without_replacement(N, Min, Max, Min, []).

selection_without_replacement(N, _Min, Max, _X, Xs)
        when N > Max orelse length(Xs) == N ->
    lists:reverse(Xs);
selection_without_replacement(N, Min, Max, X, Xs) ->
    NRemaining = N - length(Xs),
    NCandidatesRemaining = Max - X + 1,
    SelectionProbability = NRemaining / NCandidatesRemaining,
    R = rand:uniform(),
    if
        R < SelectionProbability ->
            selection_without_replacement(N, Min, Max, X + 1, [X | Xs]);
        true ->
            selection_without_replacement(N, Min, Max, X + 1, Xs)
    end.

