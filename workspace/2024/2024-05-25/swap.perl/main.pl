
sub main
{
    my @xs = (1, 2, 3, 4, 5);
    print join(' ', @xs), "\n";
    swap(@xs[0], @xs[2]);
    print join(' ', @xs), "\n";
}

sub swap
{
    ($_[0], $_[1]) = ($_[1], $_[0]);
}

main();

