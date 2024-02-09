
semver(semver(Major, Minor, Patch), Major, Minor, Patch).

commit(commit(Type, Message), Type, Message).

semver_bump_major(semver(BumpedMajor, 0, 0), semver(Major, _, _)) :-
    is(BumpedMajor, Major + 1).

semver_bump_minor(semver(Major, BumpedMinor, 0), semver(Major, Minor, _)) :-
    is(BumpedMinor, Minor + 1).

semver_bump_patch(semver(Major, Minor, BumpedPatch), semver(Major, Minor, Patch)) :-
    is(BumpedPatch, Patch + 1).

semver_bump_version(BumpedVersion, Version, commit(incompatible_changed, _)) :-
    semver_bump_major(BumpedVersion, Version).

semver_bump_version(BumpedVersion, Version, commit(compatible_added, _)) :-
    semver_bump_minor(BumpedVersion, Version).

semver_bump_version(BumpedVersion, Version, commit(compatible_fixed, _)) :-
    semver_bump_patch(BumpedVersion, Version).

semver_bump_versions(semver(_, _, _), semver(_, _, _), []).

semver_bump_versions(BumpedVersion, Version, [Commit|Commits]) :-
    semver_bump_version(NextVersion, Version, Commit),
    semver_bump_versions(BumpedVersion, NextVersion, Commits).

semver_compare(0, semver(Major, Minor, Patch), semver(Major, Minor, Patch)).

semver_compare(1, semver(Major1, Minor1, Patch1), semver(Major2, Minor2, Patch2)) :-
    Major1 > Major2;
    Major1 == Major2, Minor1 > Minor2;
    Major1 == Major2, Minor1 == Minor2, Patch1 > Patch2.

semver_compare(-1, semver(Major1, Minor1, Patch1), semver(Major2, Minor2, Patch2)) :-
    Major1 < Major2;
    Major1 == Major2, Minor1 < Minor2;
    Major1 == Major2, Minor1 == Minor2, Patch1 < Patch2.

