
main :-
    demonstration1,
    demonstration2,
    halt.

demonstration1 :-
    writeln("==== bump version"),

    semver(Version, 1, 2, 3),
    format("version = ~w~n", [Version]),

    bump_major(BumpedMajorVersion, Version),
    format("bump_major(~w) = ~w~n", [Version, BumpedMajorVersion]),

    bump_minor(BumpedMinorVersion, Version),
    format("bump_minor(~w) = ~w~n", [Version, BumpedMinorVersion]),

    bump_patch(BumpedPatchVersion, Version),
    format("bump_patch(~w) = ~w~n", [Version, BumpedPatchVersion]),

    true.

demonstration2 :-
    writeln("==== compare version"),

    semver(Version_1_1_1, 1, 1, 1),
    compare_semver(Version_1_1_1, Version_1_1_1),

    semver(Version_1_1_0, 1, 1, 0),
    compare_semver(Version_1_1_1, Version_1_1_0),
    compare_semver(Version_1_1_0, Version_1_1_1),

    semver(Version_1_0_1, 1, 0, 1),
    compare_semver(Version_1_1_1, Version_1_0_1),
    compare_semver(Version_1_0_1, Version_1_1_1),

    semver(Version_0_1_1, 0, 1, 1),
    compare_semver(Version_1_1_1, Version_0_1_1),
    compare_semver(Version_0_1_1, Version_1_1_1),

    true.

compare_semver(Version1, Version2) :-
    semver_compare(Compared, Version1, Version2),
    format("semver_compare(~w, ~w) = ~w~n", [Version1, Version2, Compared]).

