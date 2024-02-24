use strict;
use warnings;

sub main
{
    print_sequence('factorials', \&factorial, 1, 10);
    print_sequence('fibonacci numbers', \&fibonacci, 0, 20);
    print_sequence('fizz buzz values', \&fizz_buzz, 1, 100);
}

sub print_sequence
{
    my ($description, $f, $min, $max) = @_;
    my @values = map { $f->($_) } $min .. $max;
    my $string = join ' ', @values;

    print "${description}:\n";
    print "${string}\n";
}

sub factorial
{
    my $n = shift;

    if ($n == 0) {
        return 1;
    }
    return $n * factorial($n - 1);
}

sub fibonacci
{
    my $n = shift;

    if ($n == 0) {
        return 0;
    }
    if ($n == 1) {
        return 1;
    }
    return fibonacci($n - 1) + fibonacci($n - 2);
}

sub fizz_buzz
{
    my $n = shift;

    if ($n % 15 == 0) {
        return 'FizzBuzz';
    }
    if ($n % 5 == 0) {
        return 'Buzz';
    }
    if ($n % 3 == 0) {
        return 'Fizz';
    }
    return $n;
}

main;

