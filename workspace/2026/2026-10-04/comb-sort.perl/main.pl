use strict;
use warnings;
use List::Util qw(all);

sub main
{
    my $aref = generate_random_values(20, 10, 100);
    print_array($aref);
    comb_sort($aref);
    print_array($aref);
}

sub generate_random_values
{
    my ($n, $begin, $end) = @_;

    return [ map { random_range($begin, $end) } (1 .. $n) ];
}

sub random_range
{
    my ($begin, $end) = @_;

    return int(rand($end - $begin)) + $begin;
}

sub print_array
{
    my ($aref) = @_;

    if (is_sorted($aref)) {
        print join(' ', @$aref), " (sorted)\n";
    }
    else {
        print join(' ', @$aref), " (not sorted)\n";
    }
}

sub is_sorted
{
    my ($aref) = @_;
    my $n = scalar @$aref;

    return all { $aref->[$_] <= $aref->[$_ + 1] } (0 .. $n - 2);
}

sub comb_sort
{
    my ($aref) = @_;
    my $n = scalar @$aref;
    my $gap = $n;
    my $swapped = 0;

    do {
        $gap = to_next_gap($gap);
        $swapped = 0;

        for (my $i = 0; $i + $gap < $n; $i++) {
            if ($aref->[$i] > $aref->[$i + $gap]) {
                swap(\$aref->[$i], \$aref->[$i + $gap]);
                $swapped = 1;
            }
        }
    }
    while ($gap > 1 || $swapped);
}

sub to_next_gap
{
    my ($gap) = @_;

    return 1 if $gap <= 2;
    return 11 if 13 <= $gap && $gap <= 15;
    return int($gap * 10 / 13);
}

sub swap
{
    my ($ref1, $ref2) = @_;

    ($$ref1, $$ref2) = ($$ref2, $$ref1);
}

unless (caller) {
    main();
}

