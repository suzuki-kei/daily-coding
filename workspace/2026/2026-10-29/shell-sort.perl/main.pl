use strict;
use warnings;
use List::Util qw(all);

sub main
{
    my $aref = generate_random_values(20, 10, 100);
    print_array($aref);
    shell_sort($aref);
    print_array($aref);
}

sub generate_random_values
{
    my ($n, $begin, $end) = @_;
    [ map { random_range($begin, $end) } (1 .. $n) ];
}

sub random_range
{
    my ($begin, $end) = @_;
    int(rand($end - $begin)) + $begin;
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
    all { $aref->[$_] <= $aref->[$_ + 1] } (0 .. scalar(@$aref) - 2);
}

sub shell_sort
{
    my ($aref) = @_;

    for (my $gap = to_initial_gap(scalar @$aref); 1 <= $gap; $gap = int($gap / 3)) {
        for (my $end = $gap; $end < scalar @$aref; $end++) {
            my $i = $end;
            my $value = $aref->[$end];

            while ($gap <= $i && $value < $aref->[$i - $gap]) {
                $aref->[$i] = $aref->[$i - $gap];
                $i -= $gap;
            }

            $aref->[$i] = $value;
        }
    }
}

sub to_initial_gap
{
    my ($n) = @_;
    my $gap = 1;

    while ($gap * 3 + 1 < $n) {
        $gap = $gap * 3 + 1;
    }

    $gap;
}

unless (caller) {
    main();
}

