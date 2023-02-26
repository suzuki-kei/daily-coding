
main :-
    demonstration_compare,
    demonstration_bump_version,
    halt.

demonstration_compare :-
    demonstration_compare(semver(1, 2, 3), semver(1, 2, 3)),
    demonstration_compare(semver(1, 2, 3), semver(1, 2, 2)),
    demonstration_compare(semver(1, 2, 3), semver(1, 2, 4)).

demonstration_compare(Version1, Version2) :-
    semver_compare(Compared, Version1, Version2),
    write('semver_compare('),
    write(Version1),
    write(', '),
    write(Version2),
    write(') = '),
    write(Compared),
    nl.

demonstration_bump_version :-
    semver(Version, 1, 2, 3),
    write('Version = '), write_ln(Version),

    bump_patch(BumpedPatchVersion, Version),
    write('bump_patch(Version) = '), write_ln(BumpedPatchVersion),

    bump_minor(BumpedMinorVersion, Version),
    write('bump_minor(Version) = '), write_ln(BumpedMinorVersion),

    bump_major(BumpedMajorVersion, Version),
    write('bump_major(Version) = '), write_ln(BumpedMajorVersion).

