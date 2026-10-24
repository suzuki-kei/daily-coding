
function main(): void
{
    for (let n = 0; n <= 32; n++)
        console.log(`bitCount(${String(n).padStart(2)}) = ${bitCount(n)}`)
}

function bitCount(n: number): number
{
    n = (n & 0x55555555) + ((n >>  1) & 0x55555555);
    n = (n & 0x33333333) + ((n >>  2) & 0x33333333);
    n = (n & 0x0F0F0F0F) + ((n >>  4) & 0x0F0F0F0F);
    n = (n & 0x00FF00FF) + ((n >>  8) & 0x00FF00FF);
    n = (n & 0x0000FFFF) + ((n >> 16) & 0x0000FFFF);
    return n
}

main()

