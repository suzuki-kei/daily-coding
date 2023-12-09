
main :-
    demonstration1,
    demonstration2,
    halt.

demonstration1 :-
    format("==== bump version~n"),
    semver(Version, 1, 2, 3),
    format("version = ~w~n", [Version]),
    semver_bump_print(Version, semver_bump_major),
    semver_bump_print(Version, semver_bump_minor),
    semver_bump_print(Version, semver_bump_patch).

semver_bump_print(Version, BumpVersion) :-
    call(BumpVersion, BumpedVersion, Version),
    format("~w(~w) = ~w~n", [BumpVersion, Version, BumpedVersion]).

demonstration2 :-
    format("==== compare version~n"),
    semver(Version, 1, 2, 3),
    semver_bump_compare_print(Version, semver_bump_major),
    semver_bump_compare_print(Version, semver_bump_minor),
    semver_bump_compare_print(Version, semver_bump_patch).

semver_compare_print(Version1, Version2) :-
    semver_compare(Compared, Version1, Version2),
    format("semver_compare(~w, ~w) = ~w~n", [Version1, Version2, Compared]).

semver_bump_compare_print(Version, BumpVersion) :-
    call(BumpVersion, BumpedVersion, Version),
    semver_compare_print(Version, Version),
    semver_compare_print(BumpedVersion, Version),
    semver_compare_print(Version, BumpedVersion).

