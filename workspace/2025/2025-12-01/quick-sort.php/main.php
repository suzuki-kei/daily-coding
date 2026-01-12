<?php

function main(): void
{
    demonstration('partition 2-way', 'partition_2way');
    demonstration('partition 3-way', 'partition_3way');
}

function demonstration(string $label, callable $partition): void
{
    echo "==== {$label}\n";

    $array = generate_random_values(20);
    print_array($array);
    quick_sort($array, $partition);
    print_array($array);
}

function generate_random_values(int $n): array
{
    $array = [];

    for ($i = 0; $i < $n; $i++)
        $array[] = mt_rand(10, 99);

    return $array;
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

function quick_sort(array &$array, callable $partition): void
{
    if (count($array) <= 1)
        return;

    quick_sort_range($array, 0, count($array) - 1, $partition);
}

function quick_sort_range(array &$array, int $lower, int $upper, callable $partition): void
{
    if ($lower >= $upper)
        return;

    $result = $partition($array, $lower, $upper);
    quick_sort_range($array, $lower, $result['left_upper'], $partition);
    quick_sort_range($array, $result['right_lower'], $upper, $partition);
}

function partition_2way(array &$array, int $lower, int $upper): array
{
    $increment_index = $lower;
    $decrement_index = $upper;
    $pivot = random_select($array, $lower, $upper);

    while ($increment_index <= $decrement_index)
    {
        while ($array[$increment_index] < $pivot)
            $increment_index++;
        while ($array[$decrement_index] > $pivot)
            $decrement_index--;
        if ($increment_index <= $decrement_index)
            swap($array, $increment_index++, $decrement_index--);
    }

    return [
        'left_upper'  => $decrement_index,
        'right_lower' => $increment_index,
    ];
}

function partition_3way(array &$array, int $lower, int $upper): array
{
    $less_end = $lower;
    $increment_index = $lower;
    $decrement_index = $upper;
    $pivot = random_select($array, $lower, $upper);

    while ($increment_index <= $decrement_index)
    {
        if ($array[$increment_index] < $pivot)
            swap($array, $less_end++, $increment_index++);
        else if ($array[$increment_index] > $pivot)
            swap($array, $increment_index, $decrement_index--);
        else
            $increment_index++;
    }

    return [
        'left_upper'  => $less_end - 1,
        'right_lower' => $increment_index,
    ];
}

function random_select(array $array, int $lower, int $upper): int
{
    return $array[mt_rand($lower, $upper)];
}

function swap(array &$array, int $index1, int $index2): void
{
    [$array[$index1], $array[$index2]] = [$array[$index2], $array[$index1]];
}

main();

