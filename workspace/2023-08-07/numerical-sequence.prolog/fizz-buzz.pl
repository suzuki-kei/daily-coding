
fizz_buzz(N, Fn) :-
    N mod 15 =:= 0 ->
        Fn = "FizzBuzz";
    N mod 5 =:= 0 ->
        Fn = "Buzz";
    N mod 3 =:= 0 ->
        Fn = "Fizz";
    otherwise -> 
        number_string(N, Fn).

