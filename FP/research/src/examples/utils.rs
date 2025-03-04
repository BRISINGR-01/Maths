pub fn display(vec: &[i32]) {
    match vec.split_first() {
        Some((&head, tail)) => {
            println!("{}", head);
            display(tail);
        }
        None => (),
    }
}
