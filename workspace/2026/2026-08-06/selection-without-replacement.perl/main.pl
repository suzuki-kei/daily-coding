use strict;
use warnings;

sub main
{
    my @values = selection_without_replacement(10, 99, 20);
    print join(' ', @values), "\n";
}

sub selection_without_replacement
{
    my ($min, $max, $n) = @_;
    die unless $n <= $max - $min + 1;

    my @values = ();

    for my $value ($min .. $max) {
        my $numerator = $n - scalar(@values);
        my $denominator = $max - $value + 1;
        my $r = rand();

        if ($r < $numerator / $denominator) {
            push @values, $value;
        }
    }

    return @values;
}

main();

