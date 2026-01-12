<?php

function main(): void
{
    demonstration('partition 2-way', 'partition_2way');
    demonstration('partition 3-way', 'partition_3way');
}

function demonstration(string $label, callable $partition): void
{
    echo "==== {$label}\n";
    $values = generate_random_values(20);
    print_array($values);
    quick_sort($values, $partition);
    print_array($values);
}

function generate_random_values(int $n): array
{
    $values = [];

    for ($i = 0; $i < $n; $i++)
        $values[] = mt_rand(10, 99);

    return $values;
}

function print_array(array $values): void
{
    if (is_sorted($values))
        echo implode(' ', $values), " (sorted)\n";
    else
        echo implode(' ', $values), " (not sorted)\n";
}

function is_sorted(array $values): bool
{
    for ($i = 0; $i < count($values) - 1; $i++)
        if ($values[$i] > $values[$i + 1])
            return false;

    return true;
}

function quick_sort(array &$values, callable $partition): void
{
    if (count($values) <= 1)
        return;

    quick_sort_range($values, 0, count($values) - 1, $partition);
}

function quick_sort_range(array &$values, int $lower, int $upper, callable $partition): void
{
    if ($lower >= $upper)
        return;

    $result = $partition($values, $lower, $upper);
    quick_sort_range($values, $lower, $result['left_upper'], $partition);
    quick_sort_range($values, $result['right_lower'], $upper, $partition);
}

function partition_2way(array &$values, int $lower, int $upper): array
{
    $increment_index = $lower;
    $decrement_index = $upper;
    $pivot = random_select($values, $lower, $upper);

    while ($increment_index <= $decrement_index)
    {
        while ($values[$increment_index] < $pivot)
            $increment_index++;
        while ($values[$decrement_index] > $pivot)
            $decrement_index--;
        if ($increment_index <= $decrement_index)
            swap($values, $increment_index++, $decrement_index--);
    }

    return [
        'left_upper'  => $decrement_index,
        'right_lower' => $increment_index,
    ];
}

function partition_3way(array &$values, int $lower, int $upper): array
{
    $less_end = $lower;
    $increment_index = $lower;
    $decrement_index = $upper;
    $pivot = random_select($values, $lower, $upper);

    while ($increment_index <= $decrement_index)
    {
        if ($values[$increment_index] < $pivot)
            swap($values, $less_end++, $increment_index++);
        else if ($values[$increment_index] > $pivot)
            swap($values, $increment_index, $decrement_index--);
        else
            $increment_index++;
    }

    return [
        'left_upper'  => $less_end - 1,
        'right_lower' => $increment_index,
    ];
}

function random_select(array $values, int $lower, int $upper): int
{
    return $values[mt_rand($lower, $upper)];
}

function swap(array &$values, int $index1, int $index2): void
{
    [$values[$index1], $values[$index2]] = [$values[$index2], $values[$index1]];
}

main();

