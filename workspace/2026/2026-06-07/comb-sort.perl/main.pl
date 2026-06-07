use strict;
use warnings;
use List::Util qw(all);

sub main
{
    my $values_ref = generate_random_values(20);
    print_array($values_ref);
    comb_sort($values_ref);
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

sub comb_sort
{
    my ($values_ref) = @_;
    my $n = scalar @$values_ref;
    my $done = 0;
    my $gap_generator = make_gap_generator($n);

    while (!$done) {
        my $gap = $gap_generator->();
        $done = $gap == 1;

        for my $i (0 .. $n - $gap - 1) {
            if ($values_ref->[$i] > $values_ref->[$i + $gap]) {
                swap($values_ref, $i, $i + $gap);
                $done = 0;
            }
        }
    }
}

sub make_gap_generator
{
    my ($n) = @_;
    my $gap = $n;

    return sub {
        $gap = compute_next_gap($gap);
        return $gap;
    };
}

sub compute_next_gap
{
    my ($gap) = @_;
    return 1 if $gap <= 2;
    return 11 if $gap == 9 || $gap == 10;
    return int($gap * 10 / 13);
}

sub swap
{
    my ($values_ref, $index1, $index2) = @_;
    ($values_ref->[$index1], $values_ref->[$index2]) = ($values_ref->[$index2], $values_ref->[$index1]);
}

if ($0 eq __FILE__) {
    main();
}

