use strict;
use warnings;

sub main
{
    my @values = generate_random_values(20);
    print_values(\@values);
    quick_sort(\@values);
    print_values(\@values);
}

sub generate_random_values
{
    my $n = shift;
    return map { int(rand(90) + 10) } (1..$n);
}

sub print_values
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

    for (my $i = 0; $i < scalar(@$values_ref) - 1; $i++) {
        if (@$values_ref[$i] > @$values_ref[$i + 1]) {
            return 0;
        }
    }
    return 1;
}

sub quick_sort
{
    my $values_ref = shift;
    quick_sort_range($values_ref, 0, scalar(@$values_ref) - 1);
}

sub quick_sort_range
{
    my ($values_ref, $lower, $upper) = @_;
    my $increment_index = $lower;
    my $decrement_index = $upper;
    my $pivot = random_select($values_ref, $lower, $upper);

    while ($increment_index <= $decrement_index) {
        while (@$values_ref[$increment_index] < $pivot) {
            $increment_index++;
        }
        while (@$values_ref[$decrement_index] > $pivot) {
            $decrement_index--;
        }
        if ($increment_index <= $decrement_index) {
            swap(@$values_ref[$increment_index++], @$values_ref[$decrement_index--]);
        }
    }

    if ($lower < $decrement_index) {
        quick_sort_range($values_ref, $lower, $decrement_index);
    }
    if ($increment_index < $upper) {
        quick_sort_range($values_ref, $increment_index, $upper);
    }
}

sub random_select
{
    my ($values_ref, $lower, $upper) = @_;
    my $n = int(rand($upper - $lower + 1)) + $lower;
    return @$values_ref[$n];
}

sub swap
{
    ($_[0], $_[1]) = ($_[1], $_[0]);
}

main();

