<?php

function main(): void
{
    $array = generate_random_values(20, 10, 99);
    print_array($array);
    selection_sort($array);
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

function selection_sort(array &$array): void
{
    for ($begin = 0; $begin + 1 < count($array); $begin++)
    {
        $minimum_index = $begin;

        for ($i = $begin + 1; $i < count($array); $i++)
            if ($array[$i] < $array[$minimum_index])
                $minimum_index = $i;

        swap($array[$begin], $array[$minimum_index]);
    }
}

function swap(mixed &$value1, mixed &$value2): void
{
    [$value1, $value2] = [$value2, $value1];
}

main();

