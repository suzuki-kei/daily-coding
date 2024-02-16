
fn main()
{
    for i in 0..=32 {
        println!("bit_count({:>2}) = {}", i, bit_count(i));
    }
}

fn bit_count(x: i32) -> i32
{
    let mut x = x;
    x = (x & 0x55555555) + ((x >>  1) & 0x55555555);
    x = (x & 0x33333333) + ((x >>  2) & 0x33333333);
    x = (x & 0x0F0F0F0F) + ((x >>  4) & 0x0F0F0F0F);
    x = (x & 0x00FF00FF) + ((x >>  8) & 0x00FF00FF);
    x = (x & 0x0000FFFF) + ((x >> 16) & 0x0000FFFF);
    x
}

