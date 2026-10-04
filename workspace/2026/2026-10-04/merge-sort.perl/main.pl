use strict;
use warnings;
use List::Util qw(all min);

sub main
{
    my $aref = generate_random_values(20, 10, 100);
    print_array($aref);
    merge_sort($aref);
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

sub merge_sort
{
    my ($aref) = @_;
    my $n = scalar @$aref;
    my @buffer = @$aref;
    my $input_aref = $aref;
    my $output_aref = \@buffer;

    for (my $chunk_size = 1; $chunk_size < $n; $chunk_size *= 2) {
        for (my $i = 0; $i < $n; $i += $chunk_size * 2) {
            merge(
                $output_aref,
                $i,
                $input_aref,
                $i,
                min($n, $i + $chunk_size),
                min($n, $i + $chunk_size),
                min($n, $i + $chunk_size * 2));
        }

        ($input_aref, $output_aref) = ($output_aref, $input_aref);
    }

    if ($aref == $output_aref) {
        for (my $i = 0; $i < $n; $i++) {
            $aref->[$i] = $buffer[$i];
        }
    }
}

sub merge
{
    my ($output_aref, $output_index, $input_aref, $begin1, $end1, $begin2, $end2) = @_;

    while ($begin1 < $end1 && $begin2 < $end2) {
        if ($input_aref->[$begin1] <= $input_aref->[$begin2]) {
            $output_aref->[$output_index++] = $input_aref->[$begin1++];
        }
        else {
            $output_aref->[$output_index++] = $input_aref->[$begin2++];
        }
    }

    while ($begin1 < $end1) {
        $output_aref->[$output_index++] = $input_aref->[$begin1++];
    }

    while ($begin2 < $end2) {
        $output_aref->[$output_index++] = $input_aref->[$begin2++];
    }
}

unless (caller) {
    main();
}

