
fn main()
{
    try_vector()
}

fn try_vector()
{
    let mut values: Vec<i32> = Vec::new();

    for i in 0..10 {
        values.push(i);
    }
    print(&values);

    println!("==== rotate");
    print(&values);
    for _ in 0..values.len() {
        rotate(&mut values);
        print(&values);
    }

    println!("==== reverse");
    print(&values);
    reverse(&mut values);
    print(&values);
    reverse(&mut values);
    print(&values);
}

fn print(values: &Vec<i32>)
{
    let mut delimiter = "";

    for x in values {
        print!("{}{}", delimiter, x);
        delimiter = " ";
    }
    println!();
}

fn reverse(values: &mut Vec<i32>)
{
    let min = 0;
    let max = values.len() / 2;

    for i in min..=max {
        swap(values, i, values.len() - i - 1);
    }
}

fn rotate(values: &mut Vec<i32>)
{
    for i in 1..values.len() {
        swap(values, i, i - 1);
    }
}

fn swap(values: &mut Vec<i32>, index1: usize, index2: usize)
{
    let value1 = values[index1];
    values[index1] = values[index2];
    values[index2] = value1;
}

