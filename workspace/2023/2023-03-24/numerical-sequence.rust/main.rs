
fn main()
{
    println!("factorial:");
    for n in 1..=10 {
        print!("{} ", factorial(n));
    }
    println!();

    println!("fibonacci:");
    for n in 1..=20 {
        print!("{} ", fibonacci(n));
    }
    println!();

    println!("FizzBuzz:");
    for n in 1..=100 {
        print!("{} ", fizzbuzz(n));
    }
    println!();
}

fn factorial(n: i32) -> i32
{
    match n {
        0 => 1,
        _ => n * factorial(n - 1),
    }
}

fn fibonacci(n: i32) -> i32
{
    match n {
        0 => 0,
        1 => 1,
        _ => fibonacci(n - 1) + fibonacci(n - 2),
    }
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

