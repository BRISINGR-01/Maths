fn main() {
    println!("{}", is_even(1));
    println!("{}", is_even(2));
}

// standard function
fn modulo(a: i32, b: i32, c: i32) -> bool {
    a % b == c
}

// partial application
fn is_even(a: i32) -> bool {
    modulo(a, 2, 0)
}

// partial application is a function that "fixes" the argument for another function
// In this case, the second argument of modulo is fixed to 2 and the third argument is fixed to 0

// Partial application: apply a function and pass it a fewer number of parameters than it expects
