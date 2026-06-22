use strict;
use warnings;
use List::Util qw(all);

sub main
{
    my $aref = generate_random_values(20);
    print_array($aref);
    bubble_sort($aref);
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

sub bubble_sort
{
    my ($aref) = @_;
    my $n = scalar @$aref;

    for (my $end = $n; $end >= 2; $end--) {
        for (my $i = 0; $i + 1 < $end; $i++) {
            if ($aref->[$i] > $aref->[$i + 1]) {
                swap($aref, $i, $i + 1);
            }
        }
    }
}

sub swap
{
    my ($aref, $index1, $index2) = @_;
    ($aref->[$index1], $aref->[$index2]) = ($aref->[$index2], $aref->[$index1]);
}

main() unless caller;

