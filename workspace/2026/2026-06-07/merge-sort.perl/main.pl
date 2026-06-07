use strict;
use warnings;
use List::Util qw(all min);

sub main
{
    my $values_ref = generate_random_values(20);
    print_array($values_ref);
    merge_sort($values_ref);
    print_array($values_ref);
}

sub generate_random_values
{
    my ($n) = @_;
    return [map { random_range(10, 99) } (1 .. $n)];
}

sub random_range
{
    my ($min, $max) = @_;
    return int(rand($max - $min + 1)) + $min;
}

sub print_array
{
    my ($values_ref) = @_;

    if (is_sorted($values_ref)) {
        printf "%s (sorted)\n", join(' ', @$values_ref);
    } else {
        printf "%s (not sorted)\n", join(' ', @$values_ref);
    }
}

sub is_sorted
{
    my ($values_ref) = @_;
    my $n = scalar @$values_ref;

    return all {
        $values_ref->[$_] <= $values_ref->[$_ + 1]
    } (0 .. $n - 2);
}

sub merge_sort
{
    my ($values_ref) = @_;
    my $n = scalar @$values_ref;
    my @buffer = 0 .. $n - 1;
    my $input = $values_ref;
    my $output = \@buffer;

    for (my $chunk_size = 1; $chunk_size < $n; $chunk_size *= 2) {
        for (my $i = 0; $i < $n; $i += $chunk_size * 2) {
            merge(
                $output,
                $i,
                $input,
                $i,
                min($n, $i + $chunk_size),
                min($n, $i + $chunk_size),
                min($n, $i + $chunk_size * 2));
        }
        ($input, $output) = ($output, $input);
    }

    if ($values_ref == $output) {
        for my $i (0 .. $n - 1) {
            $values_ref->[$i] = $buffer[$i];
        }
    }
}

sub merge
{
    my ($output, $output_index, $input, $begin1, $end1, $begin2, $end2) = @_;

    while ($begin1 != $end1 && $begin2 != $end2) {
        if ($input->[$begin1] <= $input->[$begin2]) {
            $output->[$output_index++] = $input->[$begin1++];
        } else {
            $output->[$output_index++] = $input->[$begin2++];
        }
    }

    while ($begin1 != $end1) {
        $output->[$output_index++] = $input->[$begin1++];
    }

    while ($begin2 != $end2) {
        $output->[$output_index++] = $input->[$begin2++];
    }
}

if ($0 eq __FILE__) {
    main();
}

