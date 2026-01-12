
fn main()
{
    fizz_buzz(100);
}

fn fizz_buzz(n: i32)
{
    for i in 1..=n {
        println!("{}", fizz_buzz_value(i));
    } 
}

fn fizz_buzz_value(n: i32) -> String
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

