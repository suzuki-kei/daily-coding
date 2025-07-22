use rand::Rng;

fn main()
{
    let mut values = [0; 20];

    set_random_values(&mut values);
    print_array(&values);
    quick_sort(&mut values);
    print_array(&values);
}

fn set_random_values<const N: usize>(values: &mut [i32; N])
{
    let mut rng = rand::rng();

    for i in 0..N {
        values[i] = rng.random_range(10..=90);
    }
}

fn print_array<const N: usize>(values: &[i32; N])
{
    let mut separator = "";

    for value in values {
        print!("{}{}", separator, value);
        separator = " ";
    }

    if is_sorted(values) {
        println!(" (sorted)");
    } else {
        println!(" (not sorted)");
    }
}

fn is_sorted<const N: usize>(values: &[i32; N]) -> bool
{
    values.windows(2).all(|slice| slice[0] <= slice[1])
}

fn quick_sort<const N: usize>(values: &mut [i32; N])
{
    quick_sort_range(values, 0, (N - 1).try_into().unwrap());
}

fn quick_sort_range<const N: usize>(values: &mut [i32; N], lower: i32, upper: i32)
{
    let mut increment_index = lower;
    let mut decrement_index = upper;
    let mut rng = rand::rng();
    let pivot = values[rng.random_range(lower..=upper) as usize];

    while increment_index <= decrement_index {

        while values[increment_index as usize] < pivot {
            increment_index += 1;
        }
        while values[decrement_index as usize] > pivot {
            decrement_index -= 1;
        }
        if increment_index <= decrement_index {
            values.swap(increment_index as usize, decrement_index as usize);
            increment_index += 1;
            decrement_index -= 1;
        }
    }

    if lower < decrement_index {
        quick_sort_range(values, lower, decrement_index);
    }
    if increment_index < upper {
        quick_sort_range(values, increment_index, upper);
    }
}

