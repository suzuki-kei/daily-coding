
main :-
    demonstration1,
    demonstration2,
    halt.

demonstration1 :-
    writeln("==== bump version"),

    semver(Version, 1, 2, 3),
    format("version = ~w~n", [Version]),

    semver_bumped_major(BumpedMajorVersion, Version),
    format("bumped_major(~w) = ~w~n", [Version, BumpedMajorVersion]),

    semver_bumped_minor(BumpedMinorVersion, Version),
    format("bumped_minor(~w) = ~w~n", [Version, BumpedMinorVersion]),

    semver_bumped_patch(BumpedPatchVersion, Version),
    format("bumped_patch(~w) = ~w~n", [Version, BumpedPatchVersion]).

demonstration2 :-
    writeln("==== compare version"),

    semver(Version, 1, 2, 3),
    compare_version(Version, Version),

    semver_bumped_major(BumpedMajorVersion, Version),
    compare_version(Version, BumpedMajorVersion),
    compare_version(BumpedMajorVersion, Version),

    semver_bumped_minor(BumpedMinorVersion, Version),
    compare_version(Version, BumpedMinorVersion),
    compare_version(BumpedMinorVersion, Version),

    semver_bumped_patch(BumpedPatchVersion, Version),
    compare_version(Version, BumpedPatchVersion),
    compare_version(BumpedPatchVersion, Version).

compare_version(Version1, Version2) :-
    semver_compare(Compared, Version1, Version2),
    format("semver_compare(~w, ~w) = ~w~n", [Version1, Version2, Compared]).

