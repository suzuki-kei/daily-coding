use strict;
use warnings;
use List::Util qw(all);

sub main
{
    demonstration('partition 2-way', \&partition_2way);
    demonstration('partition 3-way', \&partition_3way);
}

sub demonstration
{
    my ($label, $partition) = @_;
    print "==== ${label}\n";

    my $aref = generate_random_values(10, 99, 20);
    print_array($aref);
    quick_sort($aref, $partition);
    print_array($aref);
}

sub generate_random_values
{
    my ($min, $max, $n) = @_;
    my @array = map { random_range($min, $max) } (1 .. $n);
    return [@array];
}

sub random_range
{
    my ($min, $max) = @_;
    return int(rand($max - $min + 1)) + $min;
}

sub print_array
{
    my ($aref) = @_;

    if (is_sorted($aref)) {
        print join(' ', @$aref), " (sorted)\n";
    } else {
        print join(' ', @$aref), " (not sorted)\n";
    }
}

sub is_sorted
{
    my ($aref) = @_;
    my $n = scalar @$aref;
    return all { $aref->[$_] <= $aref->[$_ + 1] } (0 .. $n - 2);
}

sub quick_sort
{
    my ($aref, $partition) = @_;
    my $n = scalar @$aref;
    quick_sort_range($aref, 0, $n - 1, $partition);
}

sub quick_sort_range
{
    my ($aref, $first, $last, $partition) = @_;

    while ($first < $last) {
        my %result = $partition->($aref, $first, $last);
        my $n_left = $result{left_last} - $first + 1;
        my $n_right = $last - $result{right_first} + 1;

        if ($n_left <= $n_right) {
            quick_sort_range($aref, $first, $result{left_last}, $partition);
            $first = $result{right_first};
        }
        else {
            quick_sort_range($aref, $result{right_first}, $last, $partition);
            $last = $result{left_last};
        }
    }
}

sub partition_2way
{
    my ($aref, $first, $last) = @_;
    my $increment_index = $first;
    my $decrement_index = $last;
    my $pivot = $aref->[random_range($first, $last)];

    while ($increment_index <= $decrement_index) {
        while ($aref->[$increment_index] < $pivot) {
            $increment_index++;
        }
        while ($aref->[$decrement_index] > $pivot) {
            $decrement_index--;
        }
        if ($increment_index <= $decrement_index) {
            swap($aref, $increment_index++, $decrement_index--);
        }
    }

    return (
        left_last => $decrement_index,
        right_first => $increment_index,
    );
}

sub partition_3way
{
    my ($aref, $first, $last) = @_;
    my $less_end = $first;
    my $increment_index = $first;
    my $decrement_index = $last;
    my $pivot = $aref->[random_range($first, $last)];

    while ($increment_index <= $decrement_index) {
        if ($aref->[$increment_index] < $pivot) {
            swap($aref, $less_end++, $increment_index++);
        }
        elsif ($aref->[$increment_index] > $pivot) {
            swap($aref, $increment_index, $decrement_index--);
        }
        else {
            $increment_index++;
        }
    }

    return (
        left_last => $less_end - 1,
        right_first => $increment_index,
    );
}

sub swap
{
    my ($aref, $index1, $index2) = @_;
    ($aref->[$index1], $aref->[$index2]) = ($aref->[$index2], $aref->[$index1]);
}

unless (caller) {
    main();
}

