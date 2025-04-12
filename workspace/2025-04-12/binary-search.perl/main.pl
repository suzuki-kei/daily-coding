use strict;
use warnings;

sub main
{
    my @values = generate_random_ascending_values(20);
    print join(' ', @values), "\n";

    my $lower = $values[0] - 1;
    my $upper = $values[-1] + 1;

    foreach my $target ($lower .. $upper) {
        my $index = binary_search(\@values, $target);
        print "target=${target}, index=${index}\n";
    }
}

sub generate_random_ascending_values
{
    my ($n) = @_;
    my $value = 9;
    my @values = ();

    foreach my $i (1 .. $n) {
        $value += int(rand(5)) + 1;
        push(@values, $value);
    }

    return @values;
}

sub binary_search
{
    my ($values_ref, $target, $lower, $upper) = @_;
    $lower //= 0;
    $upper //= (scalar @$values_ref) - 1;

    return -1 if $lower > $upper;

    my $center = int(($lower + $upper) / 2);
    return $center if $target == @$values_ref[$center];

    if ($target < @$values_ref[$center]) {
        return binary_search($values_ref, $target, $lower, $center - 1);
    } else {
        return binary_search($values_ref, $target, $center + 1, $upper);
    }
}

main();

