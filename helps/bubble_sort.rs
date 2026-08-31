fn bubble_sort(arr: &mut [i32; 5]) {
    let mut i: usize = 0;
    while i < 5 {
        let mut j: usize = 0;
        while j < 4 {
            if (*arr)[j] > (*arr)[j + 1] {
                let tmp: i32 = (*arr)[j];
                (*arr)[j] = (*arr)[j + 1];
                (*arr)[j + 1] = tmp;
            }
            j = j + 1;
        }
        i = i + 1;
    }
}

fn main() {
    let mut a: [i32; 5] = [5, 3, 8, 1, 2];
    bubble_sort(&mut a);
    println!("{}", a[0]);
    println!("{}", a[4]);
}
