import <print>;

auto factorial(int n) -> int;

auto main() -> int
{
    std::println("Hello, World!");

    for (auto i = 0; i <= 10; i++)
        std::println("factorial({}) = {}", i, factorial(i));
}

auto factorial(int n) -> int
{
    if (n == 0)
        return 1;
    return n * factorial(n - 1);
}

