
semver(semver(Major, Minor, Patch), Major, Minor, Patch).

semver_bump_major(semver(BumpedMajor, 0, 0), semver(Major, _, _)) :-
    is(BumpedMajor, Major + 1).

semver_bump_minor(semver(Major, BumpedMinor, 0), semver(Major, Minor, _)) :-
    is(BumpedMinor, Minor + 1).

semver_bump_patch(semver(Major, Minor, BumpedPatch), semver(Major, Minor, Patch)) :-
    is(BumpedPatch, Patch + 1).

semver_compare(0, semver(Major, Minor, Patch), semver(Major, Minor, Patch)).

semver_compare(1, semver(Major1, Minor1, Patch1), semver(Major2, Minor2, Patch2)) :-
    Major1 > Major2;
    Major1 == Major2, Minor1 > Minor2;
    Major1 == Major2, Minor1 == Minor2, Patch1 > Patch2.

semver_compare(-1, semver(Major1, Minor1, Patch1), semver(Major2, Minor2, Patch2)) :-
    Major1 < Major2;
    Major1 == Major2, Minor1 < Minor2;
    Major1 == Major2, Minor1 == Minor2, Patch1 < Patch2.

