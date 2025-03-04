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

Each value in Rust has a single owner. When the owner goes out of scope, the value is dropped:

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

Borrowing lets us use data temporarily without taking ownership, which keeps our code safe and efficient. This is a big deal in functional programming, where we try to avoid side effects and prefer immutable data. Instead of making copies, borrowing allows us to reuse values efficiently, making function composition and recursion more practical.

```rust
fn main() {
    let s2 = String::from("World");
    let s3 = &s2;
    println!("{}", s3); // s2 is still valid
}
```

In FP, avoiding unnecessary mutations makes code easier to reason about and safer for concurrency. Borrowing helps with this by allowing functions to operate on data without changing or duplicating it. Rust enforces strict borrowing rules, so we can’t accidentally introduce bugs by modifying shared state, making our programs more predictable and reliable.

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

Similarly to Elm, we can also do list recursion in Rust in a very similar way. Let's say we want to sum all elements of a list

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

This will funnel nicely into our next topic that is familiar to us -> the Maybe type.

## Optional Values

Rust provides `Option<T>` and `Result<T, E>` types to handle absence of values and errors safely:

```rust
fn reverse_string(s: &str) -> String {
    match s.chars().next() {
        Some(first) => reverse_string(&s[first.len_utf8()..]) + &first.to_string(),
        None => String::new(),
    }
}
```

Using `Result<T, E>`:

```rust
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

Folding (also known as reduce) is a powerful functional programming technique that processes a collection of values and accumulates them into a single result. Rust provides `fold` for left-associative folding and `rfold` for right-associative folding.

```rust
let sum: i32 = (1..=10).fold(0, |acc, num| acc + num);
println!("Sum: {}", sum);
```

Here, `fold` takes an initial accumulator (`0`) and a closure that adds each number in the range. This is commonly used for operations like computing sums, finding maximum values, or transforming data.

A more advanced example using `rfold`:

```rust
let reversed: String = "hello".chars().rfold(String::new(), |mut acc, c| {
    acc.push(c);
    acc
});
println!("Reversed: {}", reversed); // Output: "olleh"
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

This technique is useful when we want to create specialized versions of more generic functions, making code more reusable and readable.

## Higher Order Function

A Higher-Order Function (HOF) is a function that either:

- Takes one or more functions as arguments
- Returns a function as its result.

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
