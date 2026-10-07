
main(_) ->
    Values = list_to_tuple(selection_without_replacement(20, 10, 99)),
    MinTarget = element(1, Values) - 1,
    MaxTarget = element(tuple_size(Values), Values) + 1,
    lists:foreach(
        fun (Target) ->
            Index = binary_search(Values, Target),
            io:format("target = ~p, index = ~p~n", [Target, Index])
        end,
        lists:seq(MinTarget, MaxTarget)).

selection_without_replacement(N, Min, Max) ->
    X = Min,
    selection_without_replacement(N, Max, X, [], 0).

selection_without_replacement(N, Max, _X, Xs, NSelected)
        when N > Max orelse NSelected == N ->
    lists:reverse(Xs);
selection_without_replacement(N, Max, X, Xs, NSelected) ->
    NRemaining = N - NSelected,
    NCandidatesRemaining = Max - X + 1,
    SelectionProbability = NRemaining / NCandidatesRemaining,
    R = rand:uniform(),
    if
        R < SelectionProbability ->
            selection_without_replacement(N, Max, X + 1, [X | Xs], NSelected + 1);
        true ->
            selection_without_replacement(N, Max, X + 1, Xs, NSelected)
    end.

binary_search(Values, Target) ->
    binary_search(Values, Target, 1, tuple_size(Values)).

binary_search(_Values, _Target, First, Last)
        when First > Last ->
    -1;
binary_search(Values, Target, First, Last) ->
    Center = (First + Last) div 2,
    CenterValue = element(Center, Values),
    if
        Target < CenterValue ->
            binary_search(Values, Target, First, Center - 1);
        Target > CenterValue ->
            binary_search(Values, Target, Center + 1, Last);
        true ->
            Center
    end.

