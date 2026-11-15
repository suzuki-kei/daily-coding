use strict;
use warnings;
use List::Util qw(all);

sub main
{
    my $begin_value = 0;
    my $end_value = 10;
    my $aref = generate_random_values(20, $begin_value, $end_value);
    print_array($aref);
    counting_sort($aref, $begin_value, $end_value);
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
    my $n = scalar @$aref;
    all { $aref->[$_] <= $aref->[$_ + 1] } (0 .. $n - 2);
}

sub counting_sort
{
    my ($aref, $begin_value, $end_value) = @_;
    my $n = scalar @$aref;
    my $n_counts = $end_value - $begin_value;
    my @counts = (0) x $n_counts;

    for (my $i = 0; $i < $n; $i++) {
        $counts[$aref->[$i] - $begin_value]++;
    }

    my $output_index = 0;

    for (my $counts_index = 0; $counts_index < $n_counts; $counts_index++) {
        for (my $i = 0; $i < $counts[$counts_index]; $i++) {
            $aref->[$output_index++] = $counts_index + $begin_value;
        }
    }
}

unless (caller) {
    main();
}

