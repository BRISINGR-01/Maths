fn main() {
    let sum = (1..=10).fold(0, |acc, num| acc + num);
    println!("{sum:?}");
}
