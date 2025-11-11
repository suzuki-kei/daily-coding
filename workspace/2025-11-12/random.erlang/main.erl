
main(_) ->
    Xs = generate_random_values(20),
    Formatted = lists:concat(lists:join(" ", Xs)),
    io:format("~s.~n", [Formatted]).

generate_random_values(N) ->
    generate_random_values(N, []).
generate_random_values(0, Xs) ->
    Xs;
generate_random_values(N, Xs) ->
    X = rand:uniform(90) + 10,
    generate_random_values(N - 1, [X | Xs]).

