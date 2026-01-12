<?php

function main(): void
{
    print_sequence('factorials', 'factorial', 1, 10);
    print_sequence('fibonacci numbers', 'fibonacci', 0, 20);
    print_sequence('fizz buzz values', 'fizz_buzz', 1, 100);
}

function print_sequence(string $description, callable $f, int $min, int $max): void
{
    $values = array_map($f, range($min, $max));
    $string = implode(' ', $values);

    echo "{$description}:\n";
    echo "{$string}\n";
}

function factorial(int $n): int
{
    return factorial_tailrec($n, 1);
}

function factorial_tailrec(int $n, int $fm): int
{
    return match($n)
    {
        0       => $fm,
        default => factorial_tailrec($n - 1, $fm * $n),
    };
}

function fibonacci(int $n): int
{
    return fibonacci_tailrec($n, 0, 1);
}

function fibonacci_tailrec(int $n, int $a, int $b): int
{
    return match($n)
    {
        0       => $a,
        default => fibonacci_tailrec($n - 1, $b, $a + $b),
    };
}

function fizz_buzz(int $n): string
{
    return match(($n % 5 == 0 ? 0b10 : 0b00) | ($n % 3 == 0 ? 0b01 : 0b00))
    {
        0b11 => 'FizzBuzz',
        0b10 => 'Buzz',
        0b01 => 'Fizz',
        0b00 => strval($n),
    };
}

main();

?>

