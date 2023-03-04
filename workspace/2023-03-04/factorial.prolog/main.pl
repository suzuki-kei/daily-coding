
main :-
    main(0, 10),
    halt.

main(Min, Max) :-
    Min > Max.

main(Min, Max) :-
    Min =< Max,
    main(Min),
    is(NextMin, Min + 1),
    main(NextMin, Max).

main(N) :-
    factorial(N, Fn),
    write('factorial('),
    write(N),
    write(') = '),
    write(Fn),
    nl.

