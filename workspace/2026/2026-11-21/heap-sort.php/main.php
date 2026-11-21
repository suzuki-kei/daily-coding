<?php

function main(): void
{
    $array = generate_random_values(20, 10, 99);
    print_array($array);
    heap_sort($array);
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

function heap_sort(array &$array): void
{
    heap_build($array);
    heap_pop_all($array);
}

function heap_build(array &$array): void
{
    for ($i = intdiv(count($array), 2) - 1; 0 <= $i; $i--)
        heap_shift_down($array, count($array), $i);
}

function heap_pop_all(array &$array): void
{
    for ($n = count($array); 1 < $n; $n--)
        heap_pop($array, $n);
}

function heap_pop(array &$array, int $n): void
{
    swap($array[$n - 1], $array[0]);
    heap_shift_down($array, $n - 1, 0);
}

function heap_shift_down(array &$array, int $n, int $i): void
{
    while ($i * 2 + 1 < $n)
    {
        $maximum_index = $i;
        $left_index = $i * 2 + 1;
        $right_index = $i * 2 + 2;

        if ($left_index < $n && $array[$left_index] > $array[$maximum_index])
            $maximum_index = $left_index;

        if ($right_index < $n && $array[$right_index] > $array[$maximum_index])
            $maximum_index = $right_index;

        if ($i == $maximum_index)
            break;

        swap($array[$i], $array[$maximum_index]);
        $i = $maximum_index;
    }
}

function swap(mixed &$value1, mixed &$value2): void
{
    [$value1, $value2] = [$value2, $value1];
}

main();

