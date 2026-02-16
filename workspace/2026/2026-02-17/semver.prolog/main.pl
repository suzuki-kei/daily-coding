
main :-
    demonstration1,
    demonstration2,
    demonstration3,
    demonstration4,
    halt.

commit(incompatible_change, "commit 1").
commit(incompatible_change, "commit 2").
commit(compatible_add, "commit 3").
commit(compatible_add, "commit 4").
commit(compatible_fix, "commit 5").
commit(compatible_fix, "commit 6").

demonstration1 :-
    format("==== commits~n"),
    findall(commit(Type, Message), commit(Type, Message), Commits),
    foreach(member(Commit, Commits), format("~w.~n", [Commit])).

demonstration2 :-
    format("==== changes~n"),
    semver(Version, 1, 2, 3),
    findall(commit(Type, Message), commit(Type, Message), Commits),
    semver_changes(Version, Commits, Changes),
    foreach(member(Change, Changes), format("~w.~n", [Change])).

demonstration3 :-
    format("==== bump versions~n"),
    semver(Version, 1, 2, 3),
    findall(commit(Type, Message), commit(Type, Message), Commits),
    semver_bump_versions(Version, Commits, BumpedVersion),
    format("semver_bump_versions(~w, ~w, ~w).~n", [Version, Commits, BumpedVersion]).

demonstration4 :-
    format("==== compare version~n"),
    semver(Version, 1, 2, 3),
    semver_bump_compare_print(Version, semver_bump_major),
    semver_bump_compare_print(Version, semver_bump_minor),
    semver_bump_compare_print(Version, semver_bump_patch).

semver_bump_compare_print(Version, BumpVersion) :-
    call(BumpVersion, Version, BumpedVersion),
    semver_compare_print(BumpedVersion, BumpedVersion),
    semver_compare_print(BumpedVersion, Version),
    semver_compare_print(Version, BumpedVersion).

semver_compare_print(Version1, Version2) :-
    semver_compare(Version1, Version2, Compared),
    format("semver_compare(~w, ~w, ~w).~n", [Version1, Version2, Compared]).

