use strict;
use warnings;
use List::Util qw(all);

sub main
{
    my $aref = generate_random_values(20, 10, 100);
    print_array($aref);
    bubble_sort($aref);
    print_array($aref);
}

sub generate_random_values
{
    my ($n, $begin, $end) = @_;
    [ map { random_range($begin, $end) } (1 .. $n) ];
}

sub random_range
{
    my ($begin, $end) = @_;
    int(rand($end - $begin)) + $begin;
}

sub print_array
{
    my ($aref) = @_;

    if (is_sorted($aref)) {
        print join(' ', @$aref), " (sorted)\n";
    }
    else {
        print join(' ', @$aref), " (not sorted)\n";
    }
}

sub is_sorted
{
    my ($aref) = @_;
    all { $aref->[$_] <= $aref->[$_ + 1] } (0 .. scalar(@$aref) - 2);
}

sub bubble_sort
{
    my ($aref) = @_;

    for (my $end = scalar @$aref; 1 < $end; $end--) {
        for (my $i = 0; $i + 1 < $end; $i++) {
            if ($aref->[$i] > $aref->[$i + 1]) {
                swap(\$aref->[$i], \$aref->[$i + 1]);
            }
        }
    }
}

sub swap
{
    my ($ref1, $ref2) = @_;
    ($$ref1, $$ref2) = ($$ref2, $$ref1);
}

unless (caller) {
    main();
}

