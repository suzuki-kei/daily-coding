
main(_) ->
    Xs = generate_random_values(20),
    io:format("~w.~n", [Xs]).

generate_random_values(N) ->
    GenerateRandomValues = fun
        Self(0, Xs) -> Xs;
        Self(M, Xs) -> Self(M - 1, [rand:uniform(90) + 10 | Xs])
    end,
    GenerateRandomValues(N, []).

