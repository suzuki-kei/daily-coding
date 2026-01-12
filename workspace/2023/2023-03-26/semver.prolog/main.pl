
main :-
    demonstration1,
    demonstration2,
    halt.

demonstration1 :-
    write_ln("==== demonstration1"),

    semver(Version, 1, 2, 3),
    format("Version = ~w~n", Version),

    bumped_major(Version1, Version),
    format("bumped_major(~w) = ~w~n", [Version, Version1]),

    bumped_minor(Version2, Version),
    format("bumped_minor(~w) = ~w~n", [Version, Version2]),

    bumped_patch(Version3, Version),
    format("bumped_patch(~w) = ~w~n", [Version, Version3]),

    true.

demonstration2 :-
    write_ln("==== demonstration2"),

    semver(Version_0_0_0, 0, 0, 0),
    compare_semver(Version_0_0_0, Version_0_0_0),

    semver(Version_1_0_0, 1, 0, 0),
    semver(Version_2_0_0, 2, 0, 0),
    compare_semver(Version_1_0_0, Version_2_0_0),

    semver(Version_0_1_0, 0, 1, 0),
    semver(Version_0_2_0, 0, 2, 0),
    compare_semver(Version_0_1_0, Version_0_2_0),

    semver(Version_0_0_1, 0, 0, 1),
    semver(Version_0_0_2, 0, 0, 2),
    compare_semver(Version_0_0_1, Version_0_0_2),

    true.

compare_semver(Version1, Version2) :-
    semver_compare(Compared1, Version1, Version1),
    format("semver_compare(~w, ~w, ~w)~n", [Compared1, Version1, Version1]),
    semver_compare(Compared2, Version1, Version2),
    format("semver_compare(~w, ~w, ~w)~n", [Compared2, Version1, Version2]),
    semver_compare(Compared3, Version2, Version1),
    format("semver_compare(~w, ~w, ~w)~n", [Compared3, Version2, Version1]).

