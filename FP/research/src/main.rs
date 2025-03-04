use std::vec;

mod merge_sort;

fn main() {
    let res = merge_sort::merge_sort(vec![
        1, 52, 3, 3, 52, 35, 25, 2, 5, 6, 45, 8, 9, 2, 100, -42, 88, 62, -6, 0, -0,
    ]);

    println!(
        "{}",
        res.iter()
            .map(|x| x.to_string())
            .collect::<Vec<String>>()
            .join(",")
    );
}
