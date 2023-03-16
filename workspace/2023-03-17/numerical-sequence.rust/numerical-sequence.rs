
fn main()
{
    print!("factorial: ");
    for i in 1..10 {
        print!("{} ", factorial(i));
    }
    println!("");

    print!("fibonacci: ");
    for i in 1..20 {
        print!("{} ", fibonacci(i));
    }
    println!("");
}

fn factorial(n: i32) -> i32
{
    match n {
        0 => 1,
        _ => n * factorial(n - 1)
    }
}

fn fibonacci(n: i32) -> i32
{
    match n {
        0 => 0,
        1 => 1,
        _ => fibonacci(n - 1) + fibonacci(n - 2)
    }
}

