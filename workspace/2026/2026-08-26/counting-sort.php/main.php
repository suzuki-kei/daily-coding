<?php

function main(): void
{
    $min = 0;
    $max = 9;
    $array = generate_random_values($min, $max, 20);
    print_array($array);
    counting_sort($array, $min, $max);
    print_array($array);
}

function generate_random_values(int $min, int $max, int $n): array
{
    return array_map(
        fn() => random_int($min, $max),
        range(1, $n));
}

function print_array(array $array): void
{
    $s = implode(' ', $array);

    if (is_sorted($array))
        echo "{$s} (sorted)\n";
    else
        echo "{$s} (not sorted)\n";
}

function is_sorted(array $array): bool
{
    return array_all(
        range(0, count($array) - 2),
        fn($i) => $array[$i] <= $array[$i + 1]);
}

function counting_sort(array &$array, int $min, int $max): void
{
    $n_counts = $max - $min + 1;
    $counts = array_fill(0, $n_counts, 0);

    foreach ($array as $x)
        $counts[$x - $min]++;

    $i_array = 0;

    foreach (range($min, $max) as $value)
        for ($i = 0; $i < $counts[$value - $min]; $i++)
            $array[$i_array++] = $value;
}

main();

