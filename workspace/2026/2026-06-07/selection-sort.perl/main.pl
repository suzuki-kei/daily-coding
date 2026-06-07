use strict;
use warnings;
use List::Util qw(all);

sub main
{
    my $values_ref = generate_random_values(20);
    print_array($values_ref);
    selection_sort($values_ref);
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

sub selection_sort
{
    my ($values_ref) = @_;
    my $n = scalar @$values_ref;

    for my $begin (0 .. $n - 2) {
        my $minimum_index = $begin;

        for my $i ($begin + 1 .. $n - 1) {
            if ($values_ref->[$i] < $values_ref->[$minimum_index]) {
                $minimum_index = $i;
            }
        }

        swap($values_ref, $begin, $minimum_index);
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

