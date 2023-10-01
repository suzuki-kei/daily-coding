
main :-
    demonstration1,
    demonstration2,
    halt.

demonstration1 :-
    format("==== bump version~n"),

    semver(Version, 1, 2, 3),
    format("version = ~p~n", [Version]),

    semver_bump_major(BumpedMajorVersion, Version),
    format("bump_major(~p) = ~p~n", [Version, BumpedMajorVersion]),

    semver_bump_minor(BumpedMinorVersion, Version),
    format("bump_minor(~p) = ~p~n", [Version, BumpedMinorVersion]),

    semver_bump_patch(BumpedPatchVersion, Version),
    format("bump_patch(~p) = ~p~n", [Version, BumpedPatchVersion]).

demonstration2 :-
    format("==== compare version~n"),

    semver(Version, 1, 2, 3),
    compare_version(Version, Version),

    semver_bump_major(BumpedMajorVersion, Version),
    compare_version(BumpedMajorVersion, Version),
    compare_version(Version, BumpedMajorVersion),

    semver_bump_minor(BumpedMinorVersion, Version),
    compare_version(BumpedMinorVersion, Version),
    compare_version(Version, BumpedMinorVersion),

    semver_bump_patch(BumpedPatchVersion, Version),
    compare_version(BumpedPatchVersion, Version),
    compare_version(Version, BumpedPatchVersion).

compare_version(Version1, Version2) :-
    semver_compare(Compared, Version1, Version2),
    format("compare(~p, ~p) = ~d~n", [Version1, Version2, Compared]).

