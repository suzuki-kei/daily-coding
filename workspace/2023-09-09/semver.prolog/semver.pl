
semver(semver(Major, Minor, Patch), Major, Minor, Patch).

semver_bumped_major(BumpedVersion, semver(Major, _, _)) :-
    is(BumpedMajor, Major + 1),
    semver(BumpedVersion, BumpedMajor, 0, 0).

semver_bumped_minor(BumpedVersion, semver(Major, Minor, _)) :-
    is(BumpedMinor, Minor + 1),
    semver(BumpedVersion, Major, BumpedMinor, 0).

semver_bumped_patch(BumpedVersion, semver(Major, Minor, Patch)) :-
    is(BumpedPatch, Patch + 1),
    semver(BumpedVersion, Major, Minor, BumpedPatch).

semver_compare(0, semver(Major, Minor, Patch), semver(Major, Minor, Patch)).

semver_compare(1, semver(Major1, Minor1, Patch1), semver(Major2, Minor2, Patch2)) :-
    (Major1 > Major2);
    (Major1 == Major2, Minor1 > Minor2);
    (Major1 == Major2, Minor1 == Minor2, Patch1 > Patch2).

semver_compare(-1, semver(Major1, Minor1, Patch1), semver(Major2, Minor2, Patch2)) :-
    (Major1 < Major2);
    (Major1 == Major2, Minor1 < Minor2);
    (Major1 == Major2, Minor1 == Minor2, Patch1 < Patch2).

