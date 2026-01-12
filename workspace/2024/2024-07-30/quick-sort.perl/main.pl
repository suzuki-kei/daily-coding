use strict;
use warnings;

sub main
{
    my @values = generate_random_values(20);
    print_list(\@values);
    quick_sort(\@values);
    print_list(\@values);
}

sub generate_random_values
{
    my $n = shift;
    return map { int(rand() * 90 + 10) } 1 .. $n;
}

sub print_list
{
    my $values_ref = shift;

    if (is_sorted($values_ref)) {
        print "@$values_ref (sorted)\n";
    } else {
        print "@$values_ref (not sorted)\n";
    }
}

sub is_sorted
{
    my $values_ref = shift;
    my $n = scalar @$values_ref;

    for my $i (0 .. $n - 2) {
        if (@$values_ref[$i] > @$values_ref[$i + 1]) {
            return 0;
        }
    }
    return 1;
}

sub quick_sort
{
    my $values_ref = shift;
    my $n = scalar @$values_ref;
    quick_sort_range($values_ref, 0, $n - 1);
}

sub quick_sort_range
{
    my ($values_ref, $lower, $upper) = @_;
    my $lower_index = $lower;
    my $upper_index = $upper;
    my $pivot = @$values_ref[int(($lower + $upper) / 2)];

    while ($lower_index <= $upper_index) {
        while (@$values_ref[$lower_index] < $pivot) {
            $lower_index++;
        }
        while (@$values_ref[$upper_index] > $pivot) {
            $upper_index--;
        }
        if ($lower_index <= $upper_index) {
            swap(@$values_ref[$lower_index++], @$values_ref[$upper_index--]);
        }
    }

    if ($lower < $upper_index) {
        quick_sort_range($values_ref, $lower, $upper_index);
    }
    if ($lower_index < $upper) {
        quick_sort_range($values_ref, $lower_index, $upper);
    }
}

sub swap
{
    ($_[0], $_[1]) = ($_[1], $_[0]);
}

main();

