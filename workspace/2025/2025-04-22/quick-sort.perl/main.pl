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
    my ($n) = @_;
    return map { int(rand(90)) + 10 } (1 .. $n);
}

sub print_list
{
    my ($values_ref) = @_;

    if (is_sorted($values_ref)) {
        print join(' ', @$values_ref), " (sorted)\n";
    } else {
        print join(' ', @$values_ref), " (not sorted)\n";
    }
}

sub is_sorted
{
    my ($values_ref) = @_;

    for (my $i = 0; $i < (scalar @$values_ref) - 1; $i++) {
        if ($values_ref->[$i] > $values_ref->[$i + 1]) {
            return 0;
        }
    }
    return 1;
}

sub quick_sort
{
    my ($values_ref, $lower, $upper) = @_;
    $lower //= 0;
    $upper //= (scalar @$values_ref) - 1;

    my $increment_index = $lower;
    my $decrement_index = $upper;
    my $pivot = random_select_range($values_ref, $lower, $upper);

    while ($increment_index <= $decrement_index) {
        while ($values_ref->[$increment_index] < $pivot) {
            $increment_index++;
        }
        while ($values_ref->[$decrement_index] > $pivot) {
            $decrement_index--;
        }
        if ($increment_index <= $decrement_index) {
            swap($values_ref, $increment_index++, $decrement_index--);
        }
    }

    if ($lower < $decrement_index) {
        quick_sort($values_ref, $lower, $decrement_index);
    }
    if ($increment_index < $upper) {
        quick_sort($values_ref, $increment_index, $upper);
    }
}

sub random_select_range
{
    my ($values_ref, $lower, $upper) = @_;
    return $values_ref->[int(rand($upper - $lower + 1)) + $lower];
}

sub swap
{
    my ($values_ref, $index1, $index2) = @_;
    ($values_ref->[$index1], $values_ref->[$index2]) = ($values_ref->[$index2], $values_ref->[$index1]);
}

main();

