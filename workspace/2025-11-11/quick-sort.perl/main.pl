use strict;
use warnings;

sub main
{
    demonstration('partition 2-way', \&partition_2way);
    demonstration('partition 3-way', \&partition_3way);
}

sub demonstration
{
    my ($label, $partition) = @_;
    my $array_ref = generate_random_values(20);

    print "==== ${label}\n";
    print_array($array_ref);
    quick_sort($array_ref, $partition);
    print_array($array_ref);
}

sub generate_random_values
{
    my ($n) = @_;

    return [map int(rand(90)) + 10, (1 .. $n)];
}

sub print_array
{
    my ($array_ref) = @_;

    if (is_sorted($array_ref))
    {
        print join(' ', @$array_ref), " (sorted)\n";
    }
    else
    {
        print join(' ', @$array_ref), " (not sorted)\n";
    }
}

sub is_sorted
{
    my ($array_ref) = @_;

    for my $i (0 .. $#$array_ref - 1)
    {
        if ($array_ref->[$i] > $array_ref->[$i + 1])
        {
            return 0;
        }
    }

    return 1;
}

sub quick_sort
{
    my ($array_ref, $partition) = @_;

    quick_sort_range($array_ref, 0, scalar @$array_ref - 1, $partition);
}

sub quick_sort_range
{
    my ($array_ref, $lower, $upper, $partition) = @_;

    if ($lower >= $upper)
    {
        return;
    }

    my $result = $partition->($array_ref, $lower, $upper);
    quick_sort_range($array_ref, $lower, $result->{left_upper}, $partition);
    quick_sort_range($array_ref, $result->{right_lower}, $upper, $partition);
}

sub partition_2way
{
    my ($array_ref, $lower, $upper) = @_;
    my $increment_index = $lower;
    my $decrement_index = $upper;
    my $pivot = random_select($array_ref, $lower, $upper);

    while ($increment_index <= $decrement_index)
    {
        while ($array_ref->[$increment_index] < $pivot)
        {
            $increment_index++;
        }
        while ($array_ref->[$decrement_index] > $pivot)
        {
            $decrement_index--;
        }
        if ($increment_index <= $decrement_index)
        {
            swap($array_ref, $increment_index++, $decrement_index--);
        }
    }

    return
    {
        left_upper  => $decrement_index,
        right_lower => $increment_index,
    };
}

sub partition_3way
{
    my ($array_ref, $lower, $upper) = @_;
    my $less_end = $lower;
    my $increment_index = $lower;
    my $decrement_index = $upper;
    my $pivot = random_select($array_ref, $lower, $upper);

    while ($increment_index <= $decrement_index)
    {
        if ($array_ref->[$increment_index] < $pivot)
        {
            swap($array_ref, $less_end++, $increment_index++);
        }
        elsif ($array_ref->[$increment_index] > $pivot)
        {
            swap($array_ref, $increment_index, $decrement_index--);
        }
        else
        {
            $increment_index++;
        }
    }

    return
    {
        left_upper  => $less_end - 1,
        right_lower => $increment_index,
    };
}

sub random_select
{
    my ($array_ref, $lower, $upper) = @_;

    return $array_ref->[int(rand($upper - $lower + 1)) + $lower];
}

sub swap
{
    my ($array_ref, $index1, $index2) = @_;

    ($array_ref->[$index1], $array_ref->[$index2]) =
        ($array_ref->[$index2], $array_ref->[$index1]);
}

if ($0 eq __FILE__)
{
    main();
}

