<?php

function main(): void
{
    print_sequence('factorials', 'factorial', 1, 10);
    print_sequence('fibonacci numbers', 'fibonacci', 0, 20);
    print_sequence('fizz buzz values', 'fizz_buzz', 1, 100);
}

function print_sequence(string $label, callable $f, int $min, int $max): void
{
    $values = array_map($f, range($min, $max));
    $formatted = implode(' ', $values);

    echo "{$label}:\n";
    echo "{$formatted}\n";
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
    $flag = ($n % 3 == 0 ? 0b01 : 0b00)
          | ($n % 5 == 0 ? 0b10 : 0b00);

    return match($flag)
    {
        0b00 => strval($n),
        0b01 => 'Fizz',
        0b10 => 'Buzz',
        0b11 => 'FizzBuzz',
    };
}

main();

