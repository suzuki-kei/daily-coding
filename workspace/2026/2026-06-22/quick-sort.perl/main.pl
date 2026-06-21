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

    my $aref = generate_random_values(20);
    print_array($aref);
    quick_sort($aref, $partition);
    print_array($aref);
}

sub generate_random_values
{
    my ($n) = @_;
    my @values = map { random_range(10, 99) } (1 .. $n);
    return [@values];
}

sub random_range
{
    my ($min, $max) = @_;
    return int(rand($max - $min + 1)) + $min;
}

sub print_array
{
    my ($aref) = @_;
    my $formatted = join(' ', @$aref);
    my $sorted_label = is_sorted($aref) ? 'sorted' : 'not sorted';
    print "${formatted} (${sorted_label})\n";
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
    my ($aref, $lower, $upper, $partition) = @_;

    while ($lower < $upper) {
        my ($left_upper, $right_lower) = $partition->($aref, $lower, $upper);
        my $left_size = $left_upper - $lower + 1;
        my $right_size = $upper - $right_lower + 1;

        if ($left_size <= $right_size) {
            quick_sort_range($aref, $lower, $left_upper, $partition);
            $lower = $right_lower;
        }
        else {
            quick_sort_range($aref, $right_lower, $upper, $partition);
            $upper = $left_upper;
        }
    }
}

sub partition_2way
{
    my ($aref, $lower, $upper) = @_;
    my $increment_index = $lower;
    my $decrement_index = $upper;
    my $pivot = $aref->[random_range($lower, $upper)];

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

    return ($decrement_index, $increment_index);
}

sub partition_3way
{
    my ($aref, $lower, $upper) = @_;
    my $less_end = $lower;
    my $increment_index = $lower;
    my $decrement_index = $upper;
    my $pivot = $aref->[random_range($lower, $upper)];

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

    return ($less_end - 1, $increment_index);
}

sub swap
{
    my ($aref, $index1, $index2) = @_;
    ($aref->[$index1], $aref->[$index2]) = ($aref->[$index2], $aref->[$index1]);
}

main() unless caller;

