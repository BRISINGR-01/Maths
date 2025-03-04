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
