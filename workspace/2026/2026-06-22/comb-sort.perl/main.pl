use strict;
use warnings;
use List::Util qw(all);

sub main
{
    my $aref = generate_random_values(20);
    print_array($aref);
    comb_sort($aref);
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

sub comb_sort
{
    my ($aref) = @_;
    my $n = scalar @$aref;
    my $gap = $n;
    my $swapped = 0;

    do {
        $gap = compute_next_gap($gap);
        $swapped = 0;

        for my $i (0 .. $n - $gap - 1) {
            if ($aref->[$i] > $aref->[$i + $gap]) {
                swap($aref, $i, $i + $gap);
                $swapped = 1;
            }
        }
    } while ($gap > 1 || $swapped);
}

sub compute_next_gap
{
    my ($gap) = @_;

    return 1 if $gap <= 2;
    return 11 if 13 <= $gap && $gap <= 15;
    return int($gap * 10 / 13);
}

sub swap
{
    my ($aref, $index1, $index2) = @_;
    ($aref->[$index1], $aref->[$index2]) = ($aref->[$index2], $aref->[$index1]);
}

main() unless caller;

