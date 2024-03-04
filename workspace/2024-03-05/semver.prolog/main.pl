
main :-
    demonstration1,
    demonstration2,
    demonstration3,
    demonstration4,
    halt.

commit(incompatible_changed, "commit 1").
commit(incompatible_changed, "commit 2").
commit(compatible_added, "commit 3").
commit(compatible_added, "commit 4").
commit(compatible_fixed, "commit 5").
commit(compatible_fixed, "commit 6").

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
    format("==== bump version~n"),
    semver(Version, 1, 2, 3),
    findall(commit(Type, Message), commit(Type, Message), Commits),
    semver_bump_version(BumpedVersion, Version, Commits),
    format("semver_bump_version(~w, ~w, ~w).~n", [BumpedVersion, Version, Commits]).

demonstration4 :-
    format("==== compare version~n"),
    semver(Version, 1, 2, 3),
    semver_bump_compare_print(Version, semver_bump_major),
    semver_bump_compare_print(Version, semver_bump_minor),
    semver_bump_compare_print(Version, semver_bump_patch).

semver_bump_compare_print(Version, BumpVersion) :-
    call(BumpVersion, BumpedVersion, Version),
    semver_compare_print(BumpedVersion, BumpedVersion),
    semver_compare_print(BumpedVersion, Version),
    semver_compare_print(Version, BumpedVersion).

semver_compare_print(Version1, Version2) :-
    semver_compare(Compared, Version1, Version2),
    format("semver_compare(~w, ~w, ~w).~n", [Compared, Version1, Version2]).

