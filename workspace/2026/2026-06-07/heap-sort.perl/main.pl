use strict;
use warnings;
use List::Util qw(all);

sub main
{
    my $values_ref = generate_random_values(20);
    print_array($values_ref);
    heap_sort($values_ref);
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

sub heap_sort
{
    my ($values_ref) = @_;
    my $n = scalar @$values_ref;

    make_heap($values_ref, $n);

    for (my $i = $n - 1; $i >= 1; $i--) {
        swap($values_ref, $i, 0);
        shift_down($values_ref, $i, 0);
    }
}

sub make_heap
{
    my ($values_ref, $n) = @_;

    for (my $i = int($n / 2) - 1; $i >= 0; $i--) {
        shift_down($values_ref, $n, $i);
    }
}

sub shift_down
{
    my ($values_ref, $n, $i) = @_;

    while ($i * 2 + 1 < $n) {
        my $left_index = $i * 2 + 1;
        my $right_index = $i * 2 + 2;
        my $maximum_index = $i;

        if ($left_index < $n && $values_ref->[$left_index] > $values_ref->[$maximum_index]) {
            $maximum_index = $left_index;
        }

        if ($right_index < $n && $values_ref->[$right_index] > $values_ref->[$maximum_index]) {
            $maximum_index = $right_index;
        }

        if ($i == $maximum_index) {
            last;
        }

        swap($values_ref, $i, $maximum_index);
        $i = $maximum_index;
    }
}

sub swap
{
    my ($values_ref, $index1, $index2) = @_;
    ($values_ref->[$index1], $values_ref->[$index2]) = ($values_ref->[$index2], $values_ref->[$index1]);
}

if ($0 eq __FILE__) {
    main();
}

