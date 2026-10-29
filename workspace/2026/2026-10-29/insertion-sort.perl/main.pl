use strict;
use warnings;
use List::Util qw(all);

sub main
{
    my $aref = generate_random_values(20, 10, 100);
    print_array($aref);
    insertion_sort($aref);
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

sub insertion_sort
{
    my ($aref) = @_;

    for (my $end = 1; $end < scalar @$aref; $end++) {
        my $i = $end;
        my $value = $aref->[$end];

        while (1 <= $i && $value < $aref->[$i - 1]) {
            $aref->[$i] = $aref->[$i - 1];
            $i--;
        }

        $aref->[$i] = $value;
    }
}

unless (caller) {
    main();
}

