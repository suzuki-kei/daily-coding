
main :-
    demonstration1,
    demonstration2,
    halt.

demonstration1 :-
    write_ln('==== semver, major, minor, patch'),

    semver(Version, 1, 2, 3),
    format('version = ~w~n', Version),

    bump_major(BumpedMajor, Version),
    format('bump_major(~w) = ~w~n', [Version, BumpedMajor]),

    bump_minor(BumpedMinor, Version),
    format('bump_minor(~w) = ~w~n', [Version, BumpedMinor]),

    bump_patch(BumpedPatch, Version),
    format('bump_patch(~w) = ~w~n', [Version, BumpedPatch]),

    nl.

demonstration2 :-
    write_ln('==== semver_compare'),

    semver(Version_0_0_0, 0, 0, 0),
    compare_version(Version_0_0_0, Version_0_0_0),

    semver(Version_0_0_1, 0, 0, 1),
    compare_version(Version_0_0_1, Version_0_0_1),
    compare_version(Version_0_0_1, Version_0_0_0),
    compare_version(Version_0_0_0, Version_0_0_1),

    semver(Version_0_1_0, 0, 1, 0),
    compare_version(Version_0_1_0, Version_0_1_0),
    compare_version(Version_0_1_0, Version_0_0_0),
    compare_version(Version_0_0_0, Version_0_1_0),

    semver(Version_1_0_0, 1, 0, 0),
    compare_version(Version_1_0_0, Version_1_0_0),
    compare_version(Version_1_0_0, Version_0_0_0),
    compare_version(Version_0_0_0, Version_1_0_0),

    nl.

compare_version(Version1, Version2) :-
    semver_compare(Compared, Version1, Version2),
    format('semver_compare(~w, ~w) = ~w~n', [Version1, Version2, Compared]).

