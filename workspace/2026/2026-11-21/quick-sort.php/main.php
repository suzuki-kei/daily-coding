<?php

function main(): void
{
    demonstrate('partition 2-way', 'partition_2way');
    demonstrate('partition 3-way', 'partition_3way');
}

function demonstrate(string $label, callable $partition): void
{
    printf("==== %s\n", $label);

    $array = generate_random_values(20, 10, 99);
    print_array($array);
    quick_sort($array, $partition);
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

function quick_sort(array &$array, callable $partition): void
{
    quick_sort_range($array, 0, count($array), $partition);
}

function quick_sort_range(array &$array, int $begin, int $end, callable $partition): void
{
    while ($begin < $end - 1)
    {
        $middle = $partition($array, $begin, $end);
        $n_left = $middle['begin'] - $begin;
        $n_right = $end - $middle['end'];

        if ($n_left < $n_right)
        {
            quick_sort_range($array, $begin, $middle['begin'], $partition);
            $begin = $middle['end'];
        }
        else
        {
            quick_sort_range($array, $middle['end'], $end, $partition);
            $end = $middle['begin'];
        }
    }
}

function partition_2way(array &$array, int $begin, int $end): array
{
    $increasing_index = $begin;
    $decreasing_index = $end - 1;
    $pivot = $array[mt_rand($begin, $end - 1)];

    while ($increasing_index <= $decreasing_index)
    {
        while ($array[$increasing_index] < $pivot)
            $increasing_index++;

        while ($array[$decreasing_index] > $pivot)
            $decreasing_index--;

        if ($increasing_index <= $decreasing_index)
            swap($array[$increasing_index++], $array[$decreasing_index--]);
    }

    return [
        'begin' => $decreasing_index + 1,
        'end' => $increasing_index,
    ];
}

function partition_3way(array &$array, int $begin, int $end): array
{
    $i = $begin;
    $less_end = $begin;
    $greater_begin = $end;
    $pivot = $array[mt_rand($begin, $end - 1)];

    while ($i < $greater_begin)
        if ($array[$i] < $pivot)
            swap($array[$less_end++], $array[$i++]);
        else if ($array[$i] > $pivot)
            swap($array[$i], $array[--$greater_begin]);
        else
            $i++;

    return [
        'begin' => $less_end,
        'end' => $greater_begin,
    ];
}

function swap(mixed &$value1, mixed &$value2): void
{
    [$value1, $value2] = [$value2, $value1];
}

main();

