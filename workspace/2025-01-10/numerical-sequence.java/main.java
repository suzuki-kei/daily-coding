import java.util.function.IntFunction;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;

class Application
{

    public static void main(String[] arguments)
    {
        printSequence("factorials", Application::factorial, 1, 10);
        printSequence("fibonacci numbers", Application::fibonacci, 0, 20);
        printSequence("fizz buzz values", Application::fizzBuzz, 1, 100);
    }

    private static <T> void printSequence(String description, IntFunction<T> f, int min, int max)
    {
        Stream<T> values = IntStream.rangeClosed(min, max).mapToObj(f);
        String formatted = values.map(String::valueOf).collect(Collectors.joining(" "));
        System.out.printf("%s:\n%s\n", description, formatted);
    }

    private static int factorial(int n)
    {
        return factorial(n, 1);
    }

    private static int factorial(int n, int accumulated)
    {
        return switch(n)
        {
            case 0  -> accumulated;
            default -> factorial(n - 1, accumulated * n);
        };
    }

    private static int fibonacci(int n)
    {
        return fibonacci(n, 0, 1);
    }

    private static int fibonacci(int n, int a, int b)
    {
        return switch(n)
        {
            case 0  -> a;
            default -> fibonacci(n - 1, b, a + b);
        };
    }

    private static String fizzBuzz(int n)
    {
        return switch((n % 5 == 0 ? 0b10 : 0b00) + (n % 3 == 0 ? 0b01 : 0b00))
        {
            case 0b11 -> "FizzBuzz";
            case 0b10 -> "Buzz";
            case 0b01 -> "Fizz";
            default   -> String.valueOf(n);
        };
    }

}

