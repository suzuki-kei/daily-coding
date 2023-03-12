
fn main()
{
    for i in 0..20 {
        println!("factorial({}) = {}", i, factorial(i));
    }
}

fn factorial(n: i32) -> i32
{
    let mut a = 0;
    let mut b = 1;

    for _ in 0..n {
        b = a + b;
        a = b - a;
    }

    a
}

