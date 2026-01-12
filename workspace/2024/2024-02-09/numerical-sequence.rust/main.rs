
fn main()
{
    print_sequence("factorials", factorial, 1, 10);
    print_sequence("fibonacci numbers", fibonacci, 0, 20);
    print_sequence("fizz buzz values", fizz_buzz, 1, 100);
}

fn print_sequence<T>(description: &str, f: fn(i32) -> T, min: i32, max: i32)
    where T: std::fmt::Display
{
    let values = (min..=max).map(f);
    let string = values.map(|x| x.to_string()).collect::<Vec<String>>().join(" ");

    println!("{}:", description);
    println!("{}", string);
}

fn factorial(n: i32) -> i32
{
    factorial_tailrec(n, 1)
}

fn factorial_tailrec(n: i32, accumulated: i32) -> i32
{
    match n
    {
        0 => accumulated,
        _ => factorial_tailrec(n - 1, n * accumulated),
    }
}

fn fibonacci(n: i32) -> i32
{
    fibonacci_tailrec(0, 1, n)
}

fn fibonacci_tailrec(a: i32, b: i32, n: i32) -> i32
{
    match n
    {
        0 => a,
        _ => fibonacci_tailrec(b, a + b, n - 1),
    }
}

fn fizz_buzz(n: i32) -> String
{
    match (n % 5, n % 3)
    {
        (0, 0) => "FizzBuzz".to_string(),
        (0, _) => "Buzz".to_string(),
        (_, 0) => "Fizz".to_string(),
        (_, _) => n.to_string(),
    }
}

