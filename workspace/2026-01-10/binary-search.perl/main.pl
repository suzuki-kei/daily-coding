use strict;
use warnings;

sub main
{
    my $values_ref = generate_random_ascending_values(20);
    print join(' ', @$values_ref), "\n";

    my $lower = $values_ref->[0] - 1;
    my $upper = $values_ref->[-1] + 1;

    for my $target ($lower .. $upper) {
        my $index = binary_search($values_ref, $target);
        print "target=${target}, index=${index}\n";
    }
}

sub generate_random_ascending_values
{
    my ($n) = @_;
    my @values = ();

    for my $i (1 .. $n) {
        my $offset = ($values[-1] || 9) + 1;
        push(@values, int(rand() * 5) + $offset);
    }

    return \@values;
}

sub binary_search
{
    my ($values_ref, $target, $lower, $upper) = @_;

    $lower //= 0;
    $upper //= scalar(@$values_ref) - 1;
    return -1 if $lower > $upper;

    my $center = int(($lower + $upper) / 2);
    return $center if $target == $values_ref->[$center];

    if ($target < $values_ref->[$center]) {
        return binary_search($values_ref, $target, $lower, $center - 1);
    } else {
        return binary_search($values_ref, $target, $center + 1, $upper);
    }
}

main();

