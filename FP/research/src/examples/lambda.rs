mod utils;

fn main() {
    utils::display(&(0..10).map(|n| n + 1).collect::<Vec<i32>>());
}
