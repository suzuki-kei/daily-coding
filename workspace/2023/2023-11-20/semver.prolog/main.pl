
main :-
    demonstration1,
    demonstration2,
    halt.

demonstration1 :-
    format("==== bump version~n"),
    semver(Version, 1, 2, 3),
    print_bumped_version(Version, semver_bump_major),
    print_bumped_version(Version, semver_bump_minor),
    print_bumped_version(Version, semver_bump_patch).

demonstration2 :-
    format("==== compare version~n"),
    semver(Version, 1, 2, 3),
    print_comparison_result(Version, Version),
    print_comparison_result_after_bump_version(Version, semver_bump_major),
    print_comparison_result_after_bump_version(Version, semver_bump_minor),
    print_comparison_result_after_bump_version(Version, semver_bump_patch).

print_bumped_version(Version, BumpVersion) :-
    call(BumpVersion, BumpedVersion, Version),
    format("~w(~w, ~w).~n", [BumpVersion, BumpedVersion, Version]).

print_comparison_result(Version1, Version2) :-
    semver_compare(Compared, Version1, Version2),
    format("semver_compare(~w, ~w, ~w).~n", [Compared, Version1, Version2]).

print_comparison_result_after_bump_version(Version, BumpVersion) :-
    call(BumpVersion, BumpedVersion, Version),
    print_comparison_result(Version, BumpedVersion),
    print_comparison_result(BumpedVersion, Version).

