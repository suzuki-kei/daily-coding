use strict;
use warnings;
use List::Util qw(all);

sub main
{
    my $xs_ref = generate_random_values(20);
    print_list($xs_ref);
    quick_sort($xs_ref);
    print_list($xs_ref);
}

sub generate_random_values
{
    my ($n) = @_;
    my @xs = map {int(rand(90)) + 10} (1 .. $n);
    return \@xs;
}

sub print_list
{
    my ($xs_ref) = @_;
    my $formatted = join(' ', @$xs_ref);
    my $sorted = is_sorted($xs_ref) ? 'sorted' : 'not sorted';
    print "${formatted} (${sorted})\n";
}

sub is_sorted
{
    my ($xs_ref) = @_;
    my $n = scalar @$xs_ref;
    return all {$xs_ref->[$_] <= $xs_ref->[$_ + 1]} (0 .. $n - 2);
}

sub quick_sort
{
    my ($xs_ref, $lower, $upper) = @_;
    $lower //= 0;
    $upper //= (scalar @$xs_ref) - 1;

    my $increment_index = $lower;
    my $decrement_index = $upper;
    my $pivot = random_select($xs_ref, $lower, $upper);

    while ($increment_index <= $decrement_index) {
        while ($xs_ref->[$increment_index] < $pivot) {
            $increment_index++;
        }
        while ($xs_ref->[$decrement_index] > $pivot) {
            $decrement_index--;
        }
        if ($increment_index <= $decrement_index) {
            swap($xs_ref, $increment_index++, $decrement_index--);
        }
    }

    if ($lower < $decrement_index) {
        quick_sort($xs_ref, $lower, $decrement_index);
    }
    if ($increment_index < $upper) {
        quick_sort($xs_ref, $increment_index, $upper);
    }
}

sub random_select
{
    my ($xs_ref, $lower, $upper) = @_;
    return $xs_ref->[int(rand($upper - $lower + 1)) + $lower];
}

sub swap
{
    my ($xs_ref, $index1, $index2) = @_;
    @{$xs_ref}[$index1, $index2] = @{$xs_ref}[$index2, $index1];
}

if ($0 eq __FILE__)
{
    main();
}

