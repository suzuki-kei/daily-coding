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
    my ($n, $value_begin, $value_end) = @_;
    [ map { random_range($value_begin, $value_end) } (1..$n) ];
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
    my $n = scalar @$aref;
    all { $aref->[$_] <= $aref->[$_ + 1] } (0 .. $n - 2);
}

sub insertion_sort
{
    my ($aref) = @_;
    my $n = scalar @$aref;

    for (my $end = 1; $end < $n; $end++) {
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

