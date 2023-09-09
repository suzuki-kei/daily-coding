
main :-
    demonstration1,
    demonstration2,
    halt.

demonstration1 :-
    format("==== bump version\n"),

    semver(Version, 1, 2, 3),
    format("version = ~p~n", [Version]),

    semver_bumped_major(BumpedMajorVersion, Version),
    format("semver_bumped_major(~p) = ~p~n", [Version, BumpedMajorVersion]),

    semver_bumped_minor(BumpedMinorVersion, Version),
    format("semver_bumped_minor(~p) = ~p~n", [Version, BumpedMinorVersion]),

    semver_bumped_patch(BumpedPatchVersion, Version),
    format("semver_bumped_patch(~p) = ~p~n", [Version, BumpedPatchVersion]),

    true.

demonstration2 :-
    format("==== compare version\n"),

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
    compare_version(BumpedPatchVersion, Version),

    true.

compare_version(Version1, Version2) :-
    semver_compare(Compared, Version1, Version2),
    format("semver_compare(~p, ~p) = ~p~n", [Version1, Version2, Compared]).

