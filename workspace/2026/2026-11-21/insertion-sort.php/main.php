<?php

function main(): void
{
    $array = generate_random_values(20, 10, 99);
    print_array($array);
    insertion_sort($array);
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

function insertion_sort(array &$array): void
{
    for ($end = 1; $end < count($array); $end++)
    {
        $i = $end;
        $value = $array[$end];

        while (1 <= $i && $value < $array[$i - 1])
        {
            $array[$i] = $array[$i - 1];
            $i--;
        }

        $array[$i] = $value;
    }
}

main();

