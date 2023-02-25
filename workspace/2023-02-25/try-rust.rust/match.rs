
fn main()
{
    match_with_enum();
    match_with_option();
    one_two_many();
    if_let();
}

fn match_with_enum()
{
    println!("==== match_with_enum");

    let coins = [
        Coin::Penny,
        Coin::Nickel,
        Coin::Dime,
        Coin::Quater,
    ];
    for coin in coins {
        print_coin_kind(&coin);
    }
}

#[derive(Debug)]
enum Coin
{
    Penny,
    Nickel,
    Dime,
    Quater,
}

fn print_coin_kind(coin: &Coin)
{
    let cents = coin_in_cents(&coin);
    println!("coin is {:?} ({} cent).", coin, cents);
}

fn coin_in_cents(coin: &Coin) -> u32
{
    match coin {
        Coin::Penny  => 1,
        Coin::Nickel => 5,
        Coin::Dime   => 10,
        Coin::Quater => 25,
    }
}

fn match_with_option()
{
    println!("==== match_with_option");

    let xs = [
        Some(123),
        Some(456),
        Some(789),
        None,
    ];
    for x in xs {
        match x {
            None => println!("x is None."),
            Some(x) => println!("x is {}.", x),
        }
    }
}

fn one_two_many()
{
    println!("==== one_two_many");

    for x in 1..=5 {
        match x {
            1 => println!("{} is one", x),
            2 => println!("{} is two", x),
            _ => println!("{} is many", x),
        }
    }
}

fn if_let()
{
    println!("==== if_let");

    let xs = [
        Some(123),
        Some(456),
        Some(789),
        None,
    ];
    for x in xs {
        if let Some(x) = x {
            println!("x = {}", x);
        } else {
            println!("x = None");
        }
    }
}

