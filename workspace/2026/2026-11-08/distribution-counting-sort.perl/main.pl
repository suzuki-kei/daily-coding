use strict;
use warnings;
use List::Util qw(all);

sub main
{
    my $value_begin = 0;
    my $value_end = 10;
    my $aref = generate_random_values(20, $value_begin, $value_end);
    print_array($aref);
    distribution_counting_sort($aref, $value_begin, $value_end);
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

sub distribution_counting_sort
{
    my ($aref, $value_begin, $value_end) = @_;
    my $n = scalar @$aref;
    my $n_counts = $value_end - $value_begin;
    my @counts = (0) x $n_counts;
    my @buffer = (undef) x $n;

    for (my $i = 0; $i < $n; $i++) {
        $counts[$aref->[$i] - $value_begin]++;
    }

    for (my $i = 1; $i < $n_counts; $i++) {
        $counts[$i] += $counts[$i - 1];
    }

    for (my $i = $n - 1; 0 <= $i; $i--) {
        $buffer[--$counts[$aref->[$i] - $value_begin]] = $aref->[$i];
    }

    @$aref = @buffer;
}

unless (caller) {
    main();
}

