
main :-
    demonstration1,
    demonstration2,
    demonstration3,
    demonstration4,
    demonstration5,
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
    forall(member(Commit, Commits), format("~w.~n", [Commit])).

demonstration2 :-
    format("==== changes~n"),
    semver(Version, 1, 2, 3),
    findall(commit(Type, Message), commit(Type, Message), Commits),
    semver_changes(Version, Commits, Changes),
    forall(member(Change, Changes), format("~w.~n", [Change])).

demonstration3 :-
    format("==== bump version~n"),
    semver(Version, 1, 2, 3),
    semver_bump_major(Version, MajorBumpedVersion),
    format("semver_bump_major(~w, ~w).~n", [Version, MajorBumpedVersion]),
    semver_bump_minor(Version, MinorBumpedVersion),
    format("semver_bump_minor(~w, ~w).~n", [Version, MinorBumpedVersion]),
    semver_bump_patch(Version, PatchBumpedVersion),
    format("semver_bump_patch(~w, ~w).~n", [Version, PatchBumpedVersion]).

demonstration4 :-
    format("==== bump versions~n"),
    semver(Version, 1, 2, 3),
    findall(commit(Type, Message), commit(Type, Message), Commits),
    semver_bump_versions(Version, Commits, BumpedVersion),
    format("semver_bump_versions(~w, ~w, ~w).~n", [Version, Commits, BumpedVersion]).

demonstration5 :-
    format("==== compare version~n"),
    semver(Version, 1, 2, 3),
    forall(
        member(BumpVersion, [
            semver_bump_major,
            semver_bump_minor,
            semver_bump_patch]),
        semver_bump_compare_print(Version, BumpVersion)).

semver_bump_compare_print(Version, BumpVersion) :-
    call(BumpVersion, Version, BumpedVersion),
    semver_compare_print(BumpedVersion, BumpedVersion),
    semver_compare_print(BumpedVersion, Version),
    semver_compare_print(Version, BumpedVersion).

semver_compare_print(Version1, Version2) :-
    semver_compare(Version1, Version2, Compared),
    format("semver_compare(~w, ~w, ~w).~n", [Version1, Version2, Compared]).

