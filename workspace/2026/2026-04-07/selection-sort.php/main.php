<?php

function main(): void
{
    $array = generate_random_values(20);
    print_array($array);
    selection_sort($array);
    print_array($array);
}

function generate_random_values(int $n): array
{
    $random = fn($_) => mt_rand(10, 99);
    return array_map($random, range(1, $n));
}

function print_array(array $array): void
{
    if (is_sorted($array))
        echo implode(' ', $array), " (sorted)\n";
    else
        echo implode(' ', $array), " (not sorted)\n";
}

function is_sorted(array $array): bool
{
    for ($i = 0; $i < count($array) - 1; $i++)
        if ($array[$i] > $array[$i + 1])
            return false;

    return true;
}

function selection_sort(array &$array): void
{
    for ($begin = 0; $begin < count($array) - 1; $begin++)
    {
        $minimum_index = $begin;

        for ($i = $begin + 1; $i < count($array); $i++)
            if ($array[$i] < $array[$minimum_index])
                $minimum_index = $i;

        swap($array, $begin, $minimum_index);
    }
}

function swap(array &$array, int $index1, int $index2): void
{
    [$array[$index1], $array[$index2]] = [$array[$index2], $array[$index1]];
}

main();

