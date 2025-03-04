fn main() {
    println!("{}", modulo(1, 2, 0));
    println!("{}", currying_mod(1)(2)(0));
}

// standard function
fn modulo(a: i32, b: i32, c: i32) -> bool {
    a % b == c
}

// currying
fn currying_mod(a: i32) -> impl Fn(i32) -> Box<dyn Fn(i32) -> bool> {
    move |b: i32| Box::new(move |c| modulo(a, b, c))
}

// Currying is the process of transforming a function that takes multiple arguments into a
// series of functions, each taking one argument at a time.

// function that takes n arguments = function that takes 1 argument and returns a function that takes n-1 arguments
