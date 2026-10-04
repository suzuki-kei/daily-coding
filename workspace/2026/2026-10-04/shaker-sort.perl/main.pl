use strict;
use warnings;
use List::Util qw(all);

sub main
{
    my $aref = generate_random_values(20, 10, 100);
    print_array($aref);
    shaker_sort($aref);
    print_array($aref);
}

sub generate_random_values
{
    my ($n, $begin, $end) = @_;

    return [ map { random_range($begin, $end) } (1 .. $n) ];
}

sub random_range
{
    my ($begin, $end) = @_;

    return int(rand($end - $begin)) + $begin;
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
    my $n = scalar @$aref;

    return all { $aref->[$_] <= $aref->[$_ + 1] } (0 .. $n - 2);
}

sub shaker_sort
{
    my ($aref) = @_;
    my $first = 0;
    my $last = scalar(@$aref) - 1;

    while ($first < $last) {
        for (my $i = $first; $i + 1 <= $last; $i++) {
            if ($aref->[$i] > $aref->[$i + 1]) {
                swap(\$aref->[$i], \$aref->[$i + 1]);
            }
        }
        $last--;

        for (my $i = $last; $i - 1 >= $first; $i--) {
            if ($aref->[$i] < $aref->[$i - 1]) {
                swap(\$aref->[$i], \$aref->[$i - 1]);
            }
        }
        $first++;
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

