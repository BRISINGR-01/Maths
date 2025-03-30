# Research by Kaloyan Stoykov and Aleksandar Popov

## Introduction

Rust is a high-performance, memory-safe language that enforces safety through its "borrow checker" instead of a garbage collector. It draws heavily from functional programming (FP), embracing immutability, higher-order functions, and pattern matching. While Rust also supports object-oriented features like structs, enums, and traits, its FP aspects are key to its design.

Originally a personal project by Graydon Hoare in 2006, Rust was later sponsored by Mozilla in 2009 and had its first stable release in May 2015. It excels in systems programming, offering both speed and memory safety compared to C and C++.

## Immutability

Rust variables are immutable by default, ensuring safer code. Mutability must be explicitly declared:

```rust
fn main() {
    let mut x = 100;
    println!("x is: {x}");
    x = 20;
    println!("x is: {x}");
}
```

### Constants

Constants are always immutable and require explicit types:

```rust
const PLANETS: u32 = 8;
```

### Shadowing

Shadowing allows reusing variable names by redefining them:

```rust
fn main() {
    let x = 5;
    let x = x + 1;
    {
        let x = x * 2;
        println!("Inner x: {x}");
    }
    println!("Outer x: {x}");
}
```

## Ownership and Borrowing

Each value in Rust has a single owner.

```rust
fn take_ownership(s: String) {
    println!("{}", s);
}

fn main() {
    let s1 = String::from("Hello");
    take_ownership(s1); // s1 is now invalid
}
```

### Borrowing and Functional Programming

Borrowing lets us use data temporarily without taking ownership. This prevents side effects.

```rust
fn main() {
    let s2 = String::from("World");
    let s3 = &s2;
    println!("{}", s3); // s2 is still valid
}
```

## Recursion

Rust supports recursion and pattern matching for FP-style list processing:

```rust
fn fibonacci(n: u32) -> u32 {
    match n {
        0 => 0,
        1 => 1,
        _ => fibonacci(n - 1) + fibonacci(n - 2),
    }
}
```

### List Recursion / Pattern Matching

```rust
fn sum(list: &[i32]) -> i32 {
 match list {
  // Our Base Case
  [] => 0,
  // rest @ .. means match the rest of the slice to the variable rest.
  [first, rest @ ..] => first + sum(rest),
 }
}

// V2
fn sum(list: &[i32]) -> i32 {
    match list.split_first() {
        Some((&head, tail)) => head + sum(tail),
        None => 0,
    }
}
```

## Optional Values

Rust provides `Option<T>` and `Result<T, E>` types to handle absence of values and errors safely:

```rust
fn reverse_string(s: &str) -> String {
    match s.chars().next() {
        Some(first) => reverse_string(&s[first.len_utf8()..]) + &first.to_string(),
        None => String::new(),
    }
}

match reverse_string(input) {
    Ok(reversed) => println!("Reversed: {}", reversed),
    Err(err) => println!("Error: {}", err),
}
```

## Lambdas

Rust supports concise lambda syntax:

```rust
let add_one = |n| n + 1;
let numbers: Vec<_> = (0..10).map(add_one).collect();
```

## Fold

```rust
(1..10).fold(0, |acc, num| acc + num);

"hello".chars().rfold(String::new(), |mut acc, c| {
    acc.push(c);
    acc
});
```

## Currying and Partial Application

### Currying

Currying is the process of transforming a function that takes multiple arguments into a series of functions that each take a single argument. Rust doesn't support currying natively but can simulate it with closures:

```rust
fn modulo(a: i32) -> impl Fn(i32) -> impl Fn(i32) -> bool {
    move |b| move |c| a % b == c
}

let mod_2 = modulo(2);
let is_even = mod_2(0);

println!("{}", is_even(4)); // true, same as modulo(2)(0)(4)
println!("{}", is_even(3)); // false
```

### Partial Application

Partial application is when we "fix" some arguments of a function and return another function with fewer parameters. While Rust doesn't have direct syntax for this, we can achieve it using closures:

```rust
fn modulo(a: i32, b: i32, c: i32) -> bool {
    a % b == c
}

fn is_even(a: i32) -> bool {
    modulo(a, 2, 0)
}

println!("{}", is_even(2)); // true
println!("{}", is_even(3)); // false
```

## Higher Order Function

A Higher-Order Function (HOF) is a function that either:

- Takes one or more functions as arguments

```rust
(0..10).map(add(10)).collect::<Vec<i32>>();

let wrapper = wrap_with(" ** ");
println!("{}", wrapper("string"));

custom_print("Hello", &wrap_with(" ** "));
custom_print("Hello", |text| format!("{}{}", "Text: ", text));

// Returns function
fn wrap_with(string: &str) -> impl Fn(&str) -> String + '_ {
  move |text| format!("{}{}{}", string, text, string)
}


// Returns function
fn add(a: i32) -> impl Fn(i32) -> i32 {
  move |b| a + b
}

// Takes function
fn custom_print<F>(text: &str, wrapper: F) where F: Fn(&str) -> String {
  println!("{}", wrapper(text));
}
```

```rust
pub fn merge_sort<T: Ord + Copy>(list: Vec<T>) -> Vec<T> {
    match list.as_slice() {
        [_] => list,
        list => merge(
            merge_sort(list[..list.len() / 2].to_vec()),
            merge_sort(list[list.len() / 2..].to_vec()),
        ),
    }
}

fn merge<'a, T: Ord + Copy>(left: Vec<T>, right: Vec<T>) -> Vec<T> {
    match left.split_first() {
        None => right,
        Some((head_left, tail_left)) => match right.split_first() {
            None => left,
            Some((head_right, tail_right)) => {
                if *head_left < *head_right {
                    combine(vec![*head_left], merge(tail_left.to_vec(), right))
                } else {
                    combine(vec![*head_right], merge(left, tail_right.to_vec()))
                }
            }
        },
    }
}
fn combine<T: Ord + Clone>(left: Vec<T>, right: Vec<T>) -> Vec<T> {
    left.iter().chain(right.iter()).cloned().collect()
}
```
