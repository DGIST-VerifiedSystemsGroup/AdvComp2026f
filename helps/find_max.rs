fn find_max(arr: &[i32; 5]) -> i32 {
    let mut max: i32 = (*arr)[0];
    let mut i: usize = 1;
    while i < 5 {
        if (*arr)[i] > max {
            max = (*arr)[i];
        }
        i = i + 1;
    }
    return max;
}

fn main() {
    let a: [i32; 5] = [3, 7, 2, 9, 4];
    let m: i32 = find_max(&a);
    println!("{}", m);
}
