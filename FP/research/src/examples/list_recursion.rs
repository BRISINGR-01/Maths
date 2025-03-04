fn main() {
    let numbers = vec![1, 2, 3, 4, 5];
    println!("Sum: {}", sum(&numbers)); // Output: 15
}

fn sum(vec: &[i32]) -> i32 {
    match vec.split_first() {
        Some((&head, tail)) => head + sum(tail),
        None => 0,
    }
}
