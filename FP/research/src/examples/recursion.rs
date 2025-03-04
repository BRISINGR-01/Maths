fn main() {
    factorial(3);
    println!("Factorial of 3 is {}", factorial(3));

    println!("Reverse: {}", reverse_string("hello"));
}

fn factorial(n: i32) -> i32 {
    if n == 1 {
        1
    } else {
        n * factorial(n - 1)
    }
}

fn _sum(n: i32) -> i32 {
    if n == 0 {
        0
    } else {
        1 + _sum(n - 1)
    }
}

fn _sum_list(list: &[i32]) -> i32 {
    match list {
        [] => 0,
        [first, rest @ ..] => first + _sum_list(rest),
    }
}

fn reverse_string(s: &str) -> String {
    match s.chars().next() {
        Some(first) => reverse_string(&s[first.len_utf8()..]) + &first.to_string(),
        None => String::new(), // Base case: empty string returns an empty string
    }
}
