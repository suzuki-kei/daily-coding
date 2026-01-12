<?php

function main(): void
{
    $values = generate_random_values(20);
    print_array($values);
    quick_sort($values);
    print_array($values);
}

function generate_random_values(int $n): array
{
    $values = [];

    for ($i = 0; $i < $n; $i++)
        $values[] = mt_rand(10, 99);

    return $values;
}

function print_array(array &$values): void
{
    if (is_sorted($values))
        echo implode(' ', $values), " (sorted)\n";
    else
        echo implode(' ', $values), " (not sorted)\n";
}

function is_sorted(array &$values): bool
{
    for ($i = 0; $i < count($values) - 1; $i++)
        if ($values[$i] > $values[$i + 1])
            return false;

    return true;
}

function quick_sort(array &$values): void
{
    quick_sort_range($values, 0, count($values) - 1);
}

function quick_sort_range(array &$values, int $lower, int $upper): void
{
    $increment_index = $lower;
    $decrement_index = $upper;
    $pivot = $values[mt_rand($lower, $upper)];

    while ($increment_index <= $decrement_index)
    {
        while ($values[$increment_index] < $pivot)
            $increment_index++;
        while ($values[$decrement_index] > $pivot)
            $decrement_index--;
        if ($increment_index <= $decrement_index)
            swap($values, $increment_index++, $decrement_index--);
    }

    if ($lower < $decrement_index)
        quick_sort_range($values, $lower, $decrement_index);
    if ($increment_index < $upper)
        quick_sort_range($values, $increment_index, $upper);
}

function swap(array &$values, int $index1, int $index2): void
{
    [$values[$index1], $values[$index2]] = [$values[$index2], $values[$index1]];
}

main();

?>

