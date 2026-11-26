use strict;
use warnings;
use List::Util qw(all);

sub main
{
    demonstrate('partition 2-way', \&partition_2way);
    demonstrate('partition 3-way', \&partition_3way);
}

sub demonstrate
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

sub quick_sort
{
    my ($aref, $partition, $begin, $end) = @_;
    $begin //= 0;
    $end //= scalar @$aref;

    while ($begin < $end - 1) {
        my $middle_href = $partition->($aref, $begin, $end);
        my $n_left = $middle_href->{begin} - $begin;
        my $n_right = $end - $middle_href->{end};

        if ($n_left < $n_right) {
            quick_sort($aref, $partition, $begin, $middle_href->{begin});
            $begin = $middle_href->{end};
        }
        else {
            quick_sort($aref, $partition, $middle_href->{end}, $end);
            $end = $middle_href->{begin};
        }
    }
}

sub partition_2way
{
    my ($aref, $begin, $end) = @_;
    my $increasing_index = $begin;
    my $decreasing_index = $end - 1;
    my $pivot = $aref->[random_range($begin, $end)];

    while ($increasing_index <= $decreasing_index) {
        while ($aref->[$increasing_index] < $pivot) {
            $increasing_index++;
        }
        while ($aref->[$decreasing_index] > $pivot) {
            $decreasing_index--;
        }
        if ($increasing_index <= $decreasing_index) {
            swap($aref->[$increasing_index++], $aref->[$decreasing_index--]);
        }
    }

    {
        begin => $decreasing_index + 1,
        end => $increasing_index,
    };
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
            swap($aref->[$less_end++], $aref->[$i++]);
        }
        elsif ($aref->[$i] > $pivot) {
            swap($aref->[$i], $aref->[--$greater_begin]);
        }
        else {
            $i++;
        }
    }

    {
        begin => $less_end,
        end => $greater_begin,
    };
}

sub swap
{
    ($_[0], $_[1]) = ($_[1], $_[0]);
}

unless (caller) {
    main();
}

