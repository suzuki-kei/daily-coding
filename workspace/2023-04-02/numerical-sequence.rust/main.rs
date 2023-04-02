
fn main()
{
    show_factorials(10);
    show_fibonacci(20);
    show_fizzbuzz_values(100);
}

fn factorial(n: i32) -> i32
{
    match n {
        0 => 1,
        _ => n * factorial(n - 1),
    }
}

fn show_factorials(n: i32)
{
    println!("factorials: ");
    for n in 0..=n {
        print!("{} ", factorial(n));
    }
    println!();
}

fn fibonacci(n: i32) -> i32
{
    match n {
        0 => 0,
        1 => 1,
        _ => fibonacci(n - 1) + fibonacci(n - 2),
    }
}

fn show_fibonacci(n: i32)
{
    println!("fibonacci numbers:");
    for n in 0..=n {
        print!("{} ", fibonacci(n));
    }
    println!();
}

fn fizzbuzz(n: i32) -> String
{
    if n % 15 == 0 {
        "FizzBuzz".to_string()
    } else if n % 5 == 0 {
        "Buzz".to_string()
    } else if n % 3 == 0 {
        "Fizz".to_string()
    } else {
        n.to_string()
    }
}

fn show_fizzbuzz_values(n: i32)
{
    println!("FizzBuzz values:");
    for n in 1..=n {
        print!("{} ", fizzbuzz(n));
    }
    println!();
}

