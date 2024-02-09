
main :-
    demonstration1,
    demonstration2,
    halt.

commit(incompatible_changed, "commit 1").
commit(incompatible_changed, "commit 2").
commit(compatible_added, "commit 3").
commit(compatible_added, "commit 4").
commit(compatible_fixed, "commit 5").
commit(compatible_fixed, "commit 6").

demonstration1 :-
    format("==== bump version~n"),
    semver(Version, 1, 2, 3),
    findall(commit(Type, Message), commit(Type, Message), Commits),
    semver_print_changes(Version, Commits).

demonstration2 :-
    format("==== compare version~n"),
    semver(Version, 1, 2, 3),
    semver_bump_compare_print(Version, semver_bump_major),
    semver_bump_compare_print(Version, semver_bump_minor),
    semver_bump_compare_print(Version, semver_bump_patch).

semver_print_changes(_, []).

semver_print_changes(Version, [Commit|Commits]) :-
    commit(Commit, Type, Message),
    semver_bump_version(BumpedVersion, Version, Commit),
    format("~w -> ~w - ~w(~w)~n", [Version, BumpedVersion, Type, Message]),
    semver_print_changes(BumpedVersion, Commits).

semver_bump_compare_print(Version, BumpVersion) :-
    call(BumpVersion, BumpedVersion, Version),
    semver_compare_print(BumpedVersion, BumpedVersion),
    semver_compare_print(BumpedVersion, Version),
    semver_compare_print(Version, BumpedVersion).

semver_compare_print(Version1, Version2) :-
    semver_compare(Compared, Version1, Version2),
    format("semver_compare(~w, ~w, ~w).~n", [Compared, Version1, Version2]).

