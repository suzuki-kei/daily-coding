
fn main()
{
    let home = IpAddr {
        kind: IpAddrKind::V4,
        address: String::from("127.0.0.1"),
    };
    print_ip_addr(&home);

    let loopback = IpAddr {
        kind: IpAddrKind::V6,
        address: String::from("::1"),
    };
    print_ip_addr(&loopback);

    let home = IpAddr2::V4(String::from("127.0.0.1"));
    print_ip_addr2(&home);

    let loopback = IpAddr2::V6(String::from("::1"));
    print_ip_addr2(&loopback);
}

fn print_ip_addr(ip_addr: &IpAddr)
{
    println!("{:?}", ip_addr);
    println!("kind={:?}, address={}", ip_addr.kind, ip_addr.address);
    println!("");
}

fn print_ip_addr2(ip_addr: &IpAddr2)
{
    println!("{:?}", ip_addr);
    println!("");
}

#[derive(Debug)]
enum IpAddrKind
{
    V4,
    V6,
}

#[derive(Debug)]
struct IpAddr
{
    kind: IpAddrKind,
    address: String,
}

#[derive(Debug)]
enum IpAddr2
{
    V4(String),
    V6(String),
}

