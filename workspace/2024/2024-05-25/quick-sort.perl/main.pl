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
    return map { int(rand(90) + 10) } 1..$n;
}

sub print_list
{
    my $values = shift;

    if (is_sorted($values)) {
        print join(' ', @$values), " (sorted)\n";
    } else {
        print join(' ', @$values), " (not sorted)\n";
    }
}

sub is_sorted
{
    my $values = shift;

    for my $i (0 .. scalar @$values - 2) {
        if (@$values[$i] > @$values[$i + 1]) {
            return 0;
        }
    }
    return 1;
}

sub quick_sort
{
    my $values = shift;
    quick_sort_range($values, 0, scalar @$values - 1);
}

sub quick_sort_range
{
    my ($values, $lower, $upper) = @_;
    my $lower_index = $lower;
    my $upper_index = $upper;
    my $pivot = @$values[int(($lower + $upper) / 2)];

    while ($lower_index <= $upper_index) {
        while (@$values[$lower_index] < $pivot) {
            $lower_index++;
        }
        while (@$values[$upper_index] > $pivot) {
            $upper_index--;
        }
        if ($lower_index <= $upper_index) {
            swap(@$values[$lower_index++], @$values[$upper_index--]);
        }
    }

    if ($lower < $upper_index) {
        quick_sort_range($values, $lower, $upper_index);
    }
    if ($lower_index < $upper) {
        quick_sort_range($values, $lower_index, $upper);
    }
}

sub swap
{
    ($_[0], $_[1]) = ($_[1], $_[0]);
}

main();

