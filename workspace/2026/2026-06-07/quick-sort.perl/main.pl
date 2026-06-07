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

    my $values_ref = generate_random_values(20);
    print_array($values_ref);
    quick_sort($values_ref, $partition);
    print_array($values_ref);
}

sub generate_random_values
{
    my ($n) = @_;
    return [map { random_range(10, 99) } (1 .. $n)];
}

sub random_range
{
    my ($min, $max) = @_;
    return int(rand($max - $min + 1)) + $min;
}

sub print_array
{
    my ($values_ref) = @_;

    if (is_sorted($values_ref)) {
        printf "%s (sorted)\n", join(' ', @$values_ref);
    } else {
        printf "%s (not sorted)\n", join(' ', @$values_ref);
    }
}

sub is_sorted
{
    my ($values_ref) = @_;
    my $n = scalar @$values_ref;

    return all {
        $values_ref->[$_] <= $values_ref->[$_ + 1]
    } (0 .. $n - 2);
}

sub quick_sort
{
    my ($values_ref, $partition) = @_;
    my $n = scalar @$values_ref;

    quick_sort_range($values_ref, 0, $n - 1, $partition);
}

sub quick_sort_range
{
    my ($values_ref, $lower, $upper, $partition) = @_;
    return if $lower >= $upper;

    my $result = $partition->($values_ref, $lower, $upper);
    quick_sort_range($values_ref, $lower, $result->{left_upper}, $partition);
    quick_sort_range($values_ref, $result->{right_lower}, $upper, $partition);
}

sub partition_2way
{
    my ($values_ref, $lower, $upper) = @_;
    my $increment_index = $lower;
    my $decrement_index = $upper;
    my $pivot = $values_ref->[random_range($lower, $upper)];

    while ($increment_index <= $decrement_index) {
        while ($values_ref->[$increment_index] < $pivot) {
            $increment_index++;
        }
        while ($values_ref->[$decrement_index] > $pivot) {
            $decrement_index--;
        }
        if ($increment_index <= $decrement_index) {
            swap($values_ref, $increment_index++, $decrement_index--);
        }
    }

    return {
        left_upper => $decrement_index,
        right_lower => $increment_index,
    };
}

sub partition_3way
{
    my ($values_ref, $lower, $upper) = @_;
    my $less_end = $lower;
    my $increment_index = $lower;
    my $decrement_index = $upper;
    my $pivot = $values_ref->[random_range($lower, $upper)];

    while ($increment_index <= $decrement_index) {
        if ($values_ref->[$increment_index] < $pivot) {
            swap($values_ref, $less_end++, $increment_index++);
        } elsif ($values_ref->[$increment_index] > $pivot) {
            swap($values_ref, $increment_index, $decrement_index--);
        } else {
            $increment_index++;
        }
    }

    return {
        left_upper => $less_end - 1,
        right_lower => $increment_index,
    };
}

sub swap
{
    my ($values_ref, $index1, $index2) = @_;
    ($values_ref->[$index1], $values_ref->[$index2]) = ($values_ref->[$index2], $values_ref->[$index1]);
}

if ($0 eq __FILE__) {
    main();
}

