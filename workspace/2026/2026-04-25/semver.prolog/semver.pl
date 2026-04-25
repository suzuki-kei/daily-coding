
%%
%% semver(?Version, ?Major, ?Minor, ?Patch).
%%
semver(semver(Major, Minor, Patch), Major, Minor, Patch).

%%
%% change(?Change, ?Version, ?Commit, ?BumpedVersion).
%%
change(change(Version, Commit, BumpedVersion), Version, Commit, BumpedVersion).

%%
%% semver_changes(+Version, +Commits, -Changes).
%%
semver_changes(semver(_, _, _), [], []).

semver_changes(Version, [Commit|Commits], [Change|Changes]) :-
    semver_bump_version(Version, Commit, BumpedVersion),
    change(Change, Version, Commit, BumpedVersion),
    semver_changes(BumpedVersion, Commits, Changes).
%%
%% semver_bump_major(+Version, -BumpedVersion).
%%
semver_bump_major(semver(Major, _, _), semver(BumpedMajor, 0, 0)) :-
    BumpedMajor is Major + 1.

%%
%% semver_bump_minor(+Version, -BumpedVersion).
%%
semver_bump_minor(semver(Major, Minor, _), semver(Major, BumpedMinor, 0)) :-
    BumpedMinor is Minor + 1.

%%
%% semver_bump_patch(+Version, -BumpedVersion).
%%
semver_bump_patch(semver(Major, Minor, Patch), semver(Major, Minor, BumpedPatch)) :-
    BumpedPatch is Patch + 1.

%%
%% semver_bump_version(+Version, +Commit, -BumpedVersion).
%%
semver_bump_version(Version, commit(incompatible_change, _), BumpedVersion) :-
    semver_bump_major(Version, BumpedVersion).

semver_bump_version(Version, commit(compatible_add, _), BumpedVersion) :-
    semver_bump_minor(Version, BumpedVersion).

semver_bump_version(Version, commit(compatible_fix, _), BumpedVersion) :-
    semver_bump_patch(Version, BumpedVersion).

%%
%% semver_bump_versions(+Version, +Commits, -BumpedVersion).
%%
semver_bump_versions(semver(Major, Minor, Patch), [], semver(Major, Minor, Patch)).

semver_bump_versions(Version, [Commit|Commits], BumpedVersion) :-
    semver_bump_version(Version, Commit, NextVersion),
    semver_bump_versions(NextVersion, Commits, BumpedVersion).

%%
%% semver_compare(+Version1, +Version2, -Compared).
%%
semver_compare(semver(Major, Minor, Patch), semver(Major, Minor, Patch), 0).

semver_compare(semver(Major1, Minor1, Patch1), semver(Major2, Minor2, Patch2), 1) :-
    Major1 > Major2;
    Major1 == Major2, Minor1 > Minor2;
    Major1 == Major2, Minor1 == Minor2, Patch1 > Patch2.

semver_compare(semver(Major1, Minor1, Patch1), semver(Major2, Minor2, Patch2), -1) :-
    Major1 < Major2;
    Major1 == Major2, Minor1 < Minor2;
    Major1 == Major2, Minor1 == Minor2, Patch1 < Patch2.

