use strict;
use warnings;

sub main
{
    my ($a, $b) = (1, 2);
    print "$a $b\n";
    swap($a, $b);
    print "$a $b\n";

    my @xs = (1, 2, 3, 4, 5);
    print "@xs\n";
    swap(@xs[0], @xs[2]);
    print "@xs\n";
}

sub swap
{
    ($_[0], $_[1]) = ($_[1], $_[0]);
}

main();

