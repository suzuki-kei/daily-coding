use strict;
use warnings;
use List::Util qw(all);

sub main
{
    my $aref = generate_random_values(20, 10, 100);
    print_array($aref);
    selection_sort($aref);
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

sub selection_sort
{
    my ($aref) = @_;

    for (my $begin = 0; $begin + 1 < scalar @$aref; $begin++) {
        my $minimum_index = $begin;

        for (my $i = $begin + 1; $i < scalar @$aref; $i++) {
            if ($aref->[$i] < $aref->[$minimum_index]) {
                $minimum_index = $i;
            }
        }

        swap(\$aref->[$begin], \$aref->[$minimum_index]);
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

