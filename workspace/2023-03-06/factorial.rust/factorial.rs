
fn main()
{
    for n in 1..=10 {
        println!("factorial({}) = {}", n, factorial(n));
    }
}

fn factorial(n: i32) -> i32
{
    if n == 0 {
        1
    } else {
        n * factorial(n - 1)
    }
}

