
semver(semver(Major, Minor, Patch), Major, Minor, Patch).

semver_compare(Compared, Version1, Version2) :-
    major(Major1, Version1), major(Major2, Version2),
    minor(Minor1, Version1), minor(Minor2, Version2),
    patch(Patch1, Version1), patch(Patch2, Version2),
    (Major1 == Major2, Minor1 == Minor2, Patch1 == Patch2 ->
        is(Compared, 0);
        (Major1 < Major2; Minor1 < Minor2; Patch1 < Patch2 ->
            is(Compared, -1);
            is(Compared, +1))).

semver_equal(SemVer1, SemVer2) :-
    major(Major1, SemVer1), major(Major2, SemVer2),
    minor(Minor1, SemVer1), minor(Minor2, SemVer2),
    patch(Patch1, SemVer1), patch(Patch2, SemVer2),
    Major1 == Major2, Minor1 == Minor2, Patch1 == Patch2.

major(Major, semver(Major, _, _)).
minor(Minor, semver(_, Minor, _)).
patch(Patch, semver(_, _, Patch)).

bump_major(Version, semver(Major, _, _)) :-
    is(BumpedMajor, Major + 1),
    semver(Version, BumpedMajor, 0, 0).

bump_minor(Version, semver(Major, Minor, _)) :-
    is(BumpedMinor, Minor + 1),
    semver(Version, Major, BumpedMinor, 0).

bump_patch(Version, semver(Major, Minor, Patch)) :-
    is(BumpedPatch, Patch + 1),
    semver(Version, Major, Minor, BumpedPatch).

