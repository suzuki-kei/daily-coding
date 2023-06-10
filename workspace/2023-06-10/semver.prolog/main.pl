
main :-
    demonstration1,
    demonstration2,
    halt.

demonstration1 :-
    writeln("==== bump version"),

    semver(Version, 1, 2, 3),
    format("version = ~w~n", [Version]),

    semver_bumped_major(Version1, Version),
    format("bumped_major(~w) = ~w~n", [Version, Version1]),

    semver_bumped_minor(Version2, Version),
    format("bumped_minor(~w) = ~w~n", [Version, Version2]),

    semver_bumped_patch(Version3, Version),
    format("bumped_patch(~w) = ~w~n", [Version, Version3]).

demonstration2 :-
    writeln("==== compare version"),

    semver(Version, 1, 2, 3),
    compare_version(Version, Version),

    semver_bumped_major(Version1, Version),
    compare_version(Version, Version1),
    compare_version(Version1, Version),

    semver_bumped_minor(Version2, Version),
    compare_version(Version, Version2),
    compare_version(Version2, Version),

    semver_bumped_patch(Version3, Version),
    compare_version(Version, Version3),
    compare_version(Version3, Version).

compare_version(Version1, Version2) :-
    semver_compare(Compared, Version1, Version2),
    format("compare(~w, ~w) = ~w~n", [Version1, Version2, Compared]).

