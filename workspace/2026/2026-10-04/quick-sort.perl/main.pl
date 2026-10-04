use strict;
use warnings;
use List::Util qw(all);

sub main
{
    demonstration('partition 2-way', \&partition_2way);
    demonstration('partition 3-way', \&partition_3way);
}

sub demonstration
{
    my ($label, $partition) = @_;
    print "==== ${label}\n";

    my $aref = generate_random_values(20, 10, 100);
    print_array($aref);
    quick_sort($aref, $partition);
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

sub quick_sort
{
    my ($aref, $partition, $begin, $end) = @_;
    $begin //= 0;
    $end //= scalar(@$aref);

    while ($begin < $end) {
        my %result = $partition->($aref, $begin, $end);
        my $n_left = $result{middle_begin} - $begin;
        my $n_right = $end - $result{middle_end};

        if ($n_left <= $n_right) {
            quick_sort($aref, $partition, $begin, $result{middle_begin});
            $begin = $result{middle_end};
        }
        else {
            quick_sort($aref, $partition, $result{middle_end}, $end);
            $end = $result{middle_begin};
        }
    }
}

sub partition_2way
{
    my ($aref, $begin, $end) = @_;
    my $increment_index = $begin;
    my $decrement_index = $end - 1;
    my $pivot = $aref->[random_range($begin, $end)];

    while ($increment_index <= $decrement_index) {
        while ($aref->[$increment_index] < $pivot) {
            $increment_index++;
        }

        while ($aref->[$decrement_index] > $pivot) {
            $decrement_index--;
        }

        if ($increment_index <= $decrement_index) {
            swap(\$aref->[$increment_index++], \$aref->[$decrement_index--]);
        }
    }

    return (
        middle_begin => $decrement_index + 1,
        middle_end => $increment_index,
    );
}

sub partition_3way
{
    my ($aref, $begin, $end) = @_;
    my $i = $begin;
    my $less_end = $begin;
    my $greater_begin = $end;
    my $pivot = $aref->[random_range($begin, $end)];

    while ($i < $greater_begin) {
        if ($aref->[$i] < $pivot) {
            swap(\$aref->[$less_end++], \$aref->[$i++]);
        }
        elsif ($aref->[$i] > $pivot) {
            swap(\$aref->[$i], \$aref->[--$greater_begin]);
        }
        else {
            $i++;
        }
    }

    return (
        middle_begin => $less_end,
        middle_end => $greater_begin,
    );
}

sub swap
{
    my ($ref1, $ref2) = @_;

    ($$ref1, $$ref2) = ($$ref2, $$ref1);
}

unless (caller) {
    main();
}

