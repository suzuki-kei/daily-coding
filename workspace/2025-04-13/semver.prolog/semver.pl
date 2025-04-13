
semver(semver(Major, Minor, Patch), Major, Minor, Patch).

change(change(Commit, Version), Commit, Version).

semver_changes(semver(_, _, _), [], []) :-
    true.
semver_changes(Version, [Commit|Commits], [Change|Changes]) :-
    semver_bump_version(Version, Commit, BumpedVersion),
    change(Change, Commit, BumpedVersion),
    semver_changes(BumpedVersion, Commits, Changes).

semver_bump_version(semver(Major, Minor, Patch), [], semver(Major, Minor, Patch)) :-
    true.
semver_bump_version(Version, [Commit|Commits], BumpedVersion) :-
    semver_bump_version(Version, Commit, NextVersion),
    semver_bump_version(NextVersion, Commits, BumpedVersion).

semver_bump_version(Version, commit(incompatible_change, _), BumpedVersion) :-
    semver_bump_major(Version, BumpedVersion).
semver_bump_version(Version, commit(compatible_add, _), BumpedVersion) :-
    semver_bump_minor(Version, BumpedVersion).
semver_bump_version(Version, commit(compatible_fix, _), BumpedVersion) :-
    semver_bump_patch(Version, BumpedVersion).

semver_bump_major(semver(Major, _, _), semver(BumpedMajor, 0, 0)) :-
    is(BumpedMajor, Major + 1).

semver_bump_minor(semver(Major, Minor, _), semver(Major, BumpedMinor, 0)) :-
    is(BumpedMinor, Minor + 1).

semver_bump_patch(semver(Major, Minor, Patch), semver(Major, Minor, BumpedPatch)) :-
    is(BumpedPatch, Patch + 1).

semver_compare(semver(Major, Minor, Patch), semver(Major, Minor, Patch), 0) :-
    true.
semver_compare(semver(Major1, Minor1, Patch1), semver(Major2, Minor2, Patch2), 1) :-
    Major1 > Major2;
    Major1 == Major2, Minor1 > Minor2;
    Major1 == Major2, Minor1 == Minor2, Patch1 > Patch2.
semver_compare(semver(Major1, Minor1, Patch1), semver(Major2, Minor2, Patch2), -1) :-
    Major1 < Major2;
    Major1 == Major2, Minor1 < Minor2;
    Major1 == Major2, Minor1 == Minor2, Patch1 < Patch2.

