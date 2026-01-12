
main :-
    demonstration1,
    demonstration2,
    halt.

demonstration1 :-
    write_ln('==== semver, bumped_major, bumped_minor, bumped_patch'),

    semver(Version, 1, 2, 3),
    semver(Version, Major, Minor, Patch),
    format('semver(~w, ~w, ~w, ~w).~n', [Version, Major, Minor, Patch]),

    bumped_major(BumpedMajor, Version),
    format('bumped_major(~w, ~w).~n', [BumpedMajor, Version]),

    bumped_minor(BumpedMinor, Version),
    format('bumped_minor(~w, ~w).~n', [BumpedMinor, Version]),

    bumped_patch(BumpedPatch, Version),
    format('bumped_patch(~w, ~w).~n', [BumpedPatch, Version]),

    nl.

demonstration2 :-
    write_ln('==== semver_compare'),

    semver(Version_0_0_0, 0, 0, 0),
    compare_semver(Version_0_0_0, Version_0_0_0),

    semver(Version_1_0_0, 1, 0, 0),
    compare_semver(Version_1_0_0, Version_1_0_0),
    compare_semver(Version_1_0_0, Version_0_0_0),
    compare_semver(Version_0_0_0, Version_1_0_0),

    semver(Version_0_1_0, 0, 1, 0),
    compare_semver(Version_0_1_0, Version_0_1_0),
    compare_semver(Version_0_1_0, Version_0_0_0),
    compare_semver(Version_0_0_0, Version_0_1_0),

    semver(Version_0_0_1, 0, 0, 1),
    compare_semver(Version_0_0_1, Version_0_0_1),
    compare_semver(Version_0_0_1, Version_0_0_0),
    compare_semver(Version_0_0_0, Version_0_0_1),

    nl.

compare_semver(Version1, Version2) :-
    semver_compare(Compared, Version1, Version2),
    format('semver_compare(~w, ~w, ~w).~n', [Compared, Version1, Version2]).

