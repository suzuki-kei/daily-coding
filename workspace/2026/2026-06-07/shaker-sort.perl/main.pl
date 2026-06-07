use strict;
use warnings;
use List::Util qw(all);

sub main
{
    my $values_ref = generate_random_values(20);
    print_array($values_ref);
    shaker_sort($values_ref);
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

sub shaker_sort
{
    my ($values_ref) = @_;
    my $n = scalar @$values_ref;
    my $lower = 0;
    my $upper = $n - 1;

    while ($lower < $upper) {
        for (my $i = $lower; $i + 1 <= $upper; $i++) {
            if ($values_ref->[$i] > $values_ref->[$i + 1]) {
                swap($values_ref, $i, $i + 1);
            }
        }
        $upper--;

        for (my $i = $upper; $i - 1 >= $lower; $i--) {
            if ($values_ref->[$i] < $values_ref->[$i - 1]) {
                swap($values_ref, $i, $i - 1);
            }
        }
        $lower++;
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

