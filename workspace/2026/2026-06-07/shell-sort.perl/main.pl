use strict;
use warnings;
use List::Util qw(all);

sub main
{
    my $values_ref = generate_random_values(20);
    print_array($values_ref);
    shell_sort($values_ref);
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

sub shell_sort
{
    my ($values_ref) = @_;
    my $n = scalar @$values_ref;
    my $hop_generator = make_hop_generator($n);

    while (defined(my $hop = $hop_generator->())) {
        for my $i ($hop .. $n - 1) {
            insert($values_ref, $i, $hop);
        }
    }
}

sub make_hop_generator
{
    my ($n) = @_;
    my $hop = 1;

    while ($hop * 3 + 1 < $n) {
        $hop = $hop * 3 + 1;
    }

    return sub {
        return undef if $hop <= 0;
        my $current_hop = $hop;
        $hop = int($hop / 3);
        return $current_hop;
    }
}

sub insert
{
    my ($values_ref, $i, $hop) = @_;
    my $value = $values_ref->[$i];

    while ($i >= $hop && $value < $values_ref->[$i - $hop]) {
        $values_ref->[$i] = $values_ref->[$i - $hop];
        $i -= $hop;
    }
    $values_ref->[$i] = $value;
}

if ($0 eq __FILE__) {
    main();
}

