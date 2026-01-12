
main :-
    demonstration1,
    demonstration2,
    demonstration3,
    halt.

demonstration1 :-
    format("==== bump version~n"),
    semver(Version, 1, 2, 3),
    semver_bump_print(Version, semver_bump_major),
    semver_bump_print(Version, semver_bump_minor),
    semver_bump_print(Version, semver_bump_patch).

demonstration2 :-
    format("==== bump versions ~n"),
    semver(Version, 1, 2, 3),
    findall(commit(Type, Message), commit(Type, Message), Commits),
    semver_print_version_histories(Version, Commits).

demonstration3 :-
    format("==== compare version~n"),
    semver(Version, 1, 2, 3),
    semver_bump_compare_print(Version, semver_bump_major),
    semver_bump_compare_print(Version, semver_bump_minor),
    semver_bump_compare_print(Version, semver_bump_patch).

commit(compatible_fixed, "commit 1").
commit(compatible_added, "commit 2").
commit(incompatible_changed, "commit 3").
commit(incompatible_changed, "commit 4").
commit(compatible_added, "commit 5").
commit(compatible_fixed, "commit 6").

semver_print_version_histories(_, []).

semver_print_version_histories(Version, [Commit|Commits]) :-
    semver_bump_version(BumpedVersion, Version, Commit),
    commit(Commit, Type, Message),
    format("~w -> ~w - ~w(~w)~n", [Version, BumpedVersion, Type, Message]),
    semver_print_version_histories(BumpedVersion, Commits).

semver_print(Version) :-
    format("~w.~n", [Version]).

semver_bump_print(Version, BumpVersion) :-
    call(BumpVersion, BumpedVersion, Version),
    format("~w(~w, ~w).~n", [BumpVersion, BumpedVersion, Version]).

semver_bump_compare_print(Version, BumpVersion) :-
    call(BumpVersion, BumpedVersion, Version),
    semver_compare_print(BumpedVersion, Version),
    semver_compare_print(Version, BumpedVersion),
    semver_compare_print(BumpedVersion, BumpedVersion).

semver_compare_print(Version1, Version2) :-
    semver_compare(Compared, Version1, Version2),
    format("semver_compare(~w, ~w, ~w).~n", [Compared, Version1, Version2]).

