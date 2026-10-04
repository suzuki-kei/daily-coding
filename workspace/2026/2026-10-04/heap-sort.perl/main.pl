use strict;
use warnings;
use List::Util qw(all);

sub main
{
    my $aref = generate_random_values(20, 10, 100);
    print_array($aref);
    heap_sort($aref);
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

sub heap_sort
{
    my ($aref) = @_;

    heap_build($aref);
    heap_pop_all($aref);
}

sub heap_build
{
    my ($aref) = @_;
    my $n = scalar @$aref;

    for (my $i = int($n / 2) - 1; $i >= 0; $i--) {
        heap_shift_down($aref, $n, $i);
    }
}

sub heap_pop_all
{
    my ($aref) = @_;
    my $n = scalar @$aref;

    for (my $i = $n - 1; $i >= 1; $i--) {
        swap(\$aref->[$i], \$aref->[0]);
        heap_shift_down($aref, $i, 0);
    }
}

sub heap_shift_down
{
    my ($aref, $n, $i) = @_;

    while ($i * 2 + 1 < $n) {
        my $maximum_index = $i;
        my $left_index = $i * 2 + 1;
        my $right_index = $i * 2 + 2;

        if ($left_index < $n && $aref->[$left_index] > $aref->[$maximum_index]) {
            $maximum_index = $left_index;
        }

        if ($right_index < $n && $aref->[$right_index] > $aref->[$maximum_index]) {
            $maximum_index = $right_index;
        }

        if ($i == $maximum_index) {
            last;
        }

        swap(\$aref->[$i], \$aref->[$maximum_index]);
        $i = $maximum_index;
    }
}

sub swap
{
    my ($ref1, $ref2) = @_;

    ($$ref1, $$ref2) = ($$ref2, $$ref1);
}

unless (caller) {
    main();
}

