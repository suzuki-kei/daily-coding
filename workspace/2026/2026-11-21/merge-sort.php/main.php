<?php

function main(): void
{
    $array = generate_random_values(20, 10, 99);
    print_array($array);
    merge_sort($array);
    print_array($array);
}

function generate_random_values(int $n, int $min, int $max): array
{
    return array_map(
        fn() => mt_rand($min, $max),
        sequence(0, $n));
}

function print_array(array $array): void
{
    if (is_sorted($array))
        printf("%s (sorted)\n", implode(' ', $array));
    else
        printf("%s (not sorted)\n", implode(' ', $array));
}

function is_sorted(array $array): bool
{
    return array_all(
        sequence(0, count($array) - 1),
        fn($i) => $array[$i] <= $array[$i + 1]);
}

function sequence(int $begin, int $end): array
{
    if ($begin >= $end)
        return [];

    return range($begin, $end - 1);
}

function merge_sort(array &$array): void
{
    $buffer = array_fill(0, count($array), 0);
    $input = &$array;
    $output = &$buffer;

    for ($chunk_size = 1; $chunk_size < count($array); $chunk_size *= 2)
    {
        for ($i = 0; $i < count($array); $i += $chunk_size * 2)
            merge(
                $output,
                $i,
                $input,
                $i,
                min(count($array), $i + $chunk_size),
                min(count($array), $i + $chunk_size),
                min(count($array), $i + $chunk_size * 2));

        [$input, $output] = [&$output, &$input];
    }

    $array = $input;
}

function merge(array &$output, int $output_index, array $input, int $begin1, int $end1, int $begin2, int $end2): void
{
    while ($begin1 < $end1 && $begin2 < $end2)
        if ($input[$begin1] <= $input[$begin2])
            $output[$output_index++] = $input[$begin1++];
        else
            $output[$output_index++] = $input[$begin2++];

    while ($begin1 < $end1)
        $output[$output_index++] = $input[$begin1++];

    while ($begin2 < $end2)
        $output[$output_index++] = $input[$begin2++];
}

main();

