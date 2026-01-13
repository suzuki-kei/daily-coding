
fn main()
{
    for i in 0..=32 {
        println!("bit_count({:>2}) = {}", i, bit_count(i))
    }
}

fn bit_count(mut n: u32) -> i32
{
    n = (n & 0x55555555) + ((n >>  1) & 0x55555555);
    n = (n & 0x33333333) + ((n >>  2) & 0x33333333);
    n = (n & 0x0F0F0F0F) + ((n >>  4) & 0x0F0F0F0F);
    n = (n & 0x00FF00FF) + ((n >>  8) & 0x00FF00FF);
    n = (n & 0x0000FFFF) + ((n >> 16) & 0x0000FFFF);
    n as i32
}

