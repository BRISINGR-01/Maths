mod utils;

fn main() {
    utils::display(&(0..10).map(add(10)).collect::<Vec<i32>>());

    let wrapper = wrap_with(" ** ");
    println!("{}", wrapper("string"));

    custom_print("Hello", &wrap_with(" ** "));
    custom_print("Hello", |text| format!("{}{}", "Text: ", text));
}

fn wrap_with(string: &str) -> impl Fn(&str) -> String + '_ {
    move |text| format!("{}{}{}", string, text, string)
}

fn add(a: i32) -> impl Fn(i32) -> i32 {
    move |b| a + b
}

fn custom_print<F>(text: &str, wrapper: F)
where
    F: Fn(&str) -> String,
{
    println!("{}", wrapper(text));
}

// A Higher-Order Function (HOF) is a function that either:

// Takes one or more functions as arguments, or
// Returns a function as its result.
