use strict;
use warnings;
use List::Util qw(all);

sub main
{
    my $value_begin = 0;
    my $value_end = 10;
    my $aref = generate_random_values(20, $value_begin, $value_end);
    print_array($aref);
    counting_sort($aref, $value_begin, $value_end);
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

sub counting_sort
{
    my ($aref, $value_begin, $value_end) = @_;
    my $n = scalar @$aref;
    my $n_counts = $value_end - $value_begin;
    my @counts = (0) x $n_counts;

    for (my $i = 0; $i < $n; $i++) {
        $counts[$aref->[$i] - $value_begin]++;
    }

    my $i_output = 0;

    for (my $i_counts = 0; $i_counts < $n_counts; $i_counts++) {
        for (my $i = 0; $i < $counts[$i_counts]; $i++) {
            $aref->[$i_output++] = $i_counts + $value_begin;
        }
    }
}

unless (caller) {
    main();
}

