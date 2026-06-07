use strict;
use warnings;
use List::Util qw(all);

sub main
{
    my $values_ref = generate_random_values(20);
    print_array($values_ref);
    insertion_sort($values_ref);
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

sub insertion_sort
{
    my ($values_ref) = @_;
    my $n = scalar @$values_ref;

    for my $i (1 .. $n - 1) {
        insert($values_ref, $i);
    }
}

sub insert
{
    my ($values_ref, $i) = @_;
    my $value = $values_ref->[$i];

    while ($i >= 1 && $value < $values_ref->[$i - 1]) {
        $values_ref->[$i] = $values_ref->[$i - 1];
        $i--;
    }
    $values_ref->[$i] = $value;
}

if ($0 eq __FILE__) {
    main();
}

