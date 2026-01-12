<?php

function main(): void
{
    $values = generate_random_values(20);
    echo implode(' ', $values), "\n";
}

function generate_random_values(int $n): array
{
    $values = [];

    for ($i = 0; $i < $n; $i++)
        $values[] = mt_rand(10, 99);

    return $values;
}

main();

?>

