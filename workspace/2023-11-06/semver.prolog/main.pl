
main :-
    demonstration1,
    demonstration2,
    halt.

demonstration1 :-
    format("==== bump version~n"),
    semver(Version, 1, 2, 3),
    print_version("Version", Version),
    print_bumped_version(semver_bump_major, Version),
    print_bumped_version(semver_bump_minor, Version),
    print_bumped_version(semver_bump_patch, Version).

print_version(Name, Version) :-
    format("~s = ~w~n", [Name, Version]).

print_bumped_version(BumpVersion, Version) :-
    call(BumpVersion, BumpedVersion, Version),
    format("~w(~w, ~w)~n", [BumpVersion, BumpedVersion, Version]).

demonstration2 :-
    format("==== compare version~n"),
    semver(Version, 1, 2, 3),
    print_version_comparison_result(Version, Version),
    print_version_comparison_result_after_bump_version(Version, semver_bump_major),
    print_version_comparison_result_after_bump_version(Version, semver_bump_minor),
    print_version_comparison_result_after_bump_version(Version, semver_bump_patch).

print_version_comparison_result(Version1, Version2) :-
    semver_compare(Compared, Version1, Version2),
    format("semver_compare(~w, ~w, ~w)~n", [Compared, Version1, Version2]).

print_version_comparison_result_after_bump_version(Version, BumpVersion) :-
    call(BumpVersion, BumpedVersion, Version),
    print_version_comparison_result(Version, BumpedVersion),
    print_version_comparison_result(BumpedVersion, Version).

