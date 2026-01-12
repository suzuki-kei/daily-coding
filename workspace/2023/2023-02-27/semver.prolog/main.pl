
main :-
    example_bump_version,
    example_compare_version,
    halt.

example_bump_version :-
    write_ln('==== example_bump_version'),

    semver(Version, 1, 2, 3),
    write('Version = '), write_ln(Version),

    bump_major(VersionBumpedMajor, Version),
    write('bump_major(Version) = '), write_ln(VersionBumpedMajor),

    bump_minor(VersionBumpedMinor, Version),
    write('bump_minor(Version) = '), write_ln(VersionBumpedMinor),

    bump_patch(VersionBumpedPatch, Version),
    write('bump_patch(Version) = '), write_ln(VersionBumpedPatch).

example_compare_version :-
    write_ln('==== example_compare_version'),
    write_ln_compared_semver(semver(1, 2, 3), semver(1, 2, 3)),

    write_ln_compared_semver(semver(1, 1, 1), semver(1, 1, 0)),
    write_ln_compared_semver(semver(1, 1, 1), semver(1, 0, 1)),
    write_ln_compared_semver(semver(1, 1, 1), semver(0, 1, 1)),

    write_ln_compared_semver(semver(1, 1, 1), semver(1, 1, 2)),
    write_ln_compared_semver(semver(1, 1, 1), semver(1, 2, 1)),
    write_ln_compared_semver(semver(1, 1, 1), semver(2, 1, 1)).

write_ln_compared_semver(Version1, Version2) :-
    semver_compare(Compared, Version1, Version2),
    write('semver_compare('),
    write(Version1),
    write(', '),
    write(Version2),
    write(') = '),
    write(Compared),
    nl.

