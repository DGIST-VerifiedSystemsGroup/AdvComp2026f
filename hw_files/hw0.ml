(* hw0 — OCaml warm-up
   ------------------------------------------------------------------
   Not graded. Solutions are published alongside this file; try each
   problem before looking.

   Every function below returns a dummy value. Replace it with your
   implementation. Running the file prints what each of your functions
   produced, next to what it should have produced.

   An unfinished file prints warnings about unused variables. Ignore
   them; they go away as you fill things in.
   ------------------------------------------------------------------ *)

(* ------------------------------------------------------------------ *)
(* 1. Recursion                                                       *)
(* ------------------------------------------------------------------ *)

(* 1-1. sum_to : int -> int
   Return 0 + 1 + ... + n. For n <= 0, return 0.

     sum_to 5    = 15
     sum_to 1    = 1
     sum_to 0    = 0
     sum_to (-3) = 0                                                  *)

let rec sum_to n = 0 (* TODO *)

(* 1-2. fib : int -> int
   The n-th Fibonacci number, with fib 0 = 0 and fib 1 = 1. You may
   assume n >= 0. Do not worry about efficiency.

     fib 0  = 0
     fib 1  = 1
     fib 10 = 55                                                      *)

let rec fib n = 0 (* TODO *)

(* ------------------------------------------------------------------ *)
(* 2. Lists                                                           *)
(* ------------------------------------------------------------------ *)

(* 2-1. length : 'a list -> int
   The number of elements in a list. Write it yourself — do not call
   List.length.

     length [1; 2; 3] = 3
     length []        = 0

   Note the type: it works on a list of anything. You do not write the
   'a; OCaml infers it.                                               *)

let rec length l = 0 (* TODO *)

(* 2-2. nth : 'a list -> int -> 'a option
   The element at index n, counting from 0. Return None if n is out of
   range, including when n is negative.

     nth ['a'; 'b'; 'c'] 1    = Some 'b'
     nth ['a'; 'b'; 'c'] 5    = None
     nth ['a'; 'b'; 'c'] (-1) = None

   OCaml has no null. A function that may fail to produce a value says
   so in its type, and the caller has to handle both cases.           *)

let rec nth l n = None (* TODO *)

(* ------------------------------------------------------------------ *)
(* 3. Higher-order functions                                          *)
(* ------------------------------------------------------------------ *)

(* 3-1. map : ('a -> 'b) -> 'a list -> 'b list
   Apply f to every element, keeping the order.

     map (fun x -> x * 2) [1; 2; 3] = [2; 4; 6]
     map string_of_int    [1; 2; 3] = ["1"; "2"; "3"]

   The second example returns a list of a different type from the
   input. That is what 'a and 'b being distinct means.                *)

let rec map f l = [] (* TODO *)

(* 3-2. fold_left : ('a -> 'b -> 'a) -> 'a -> 'b list -> 'a
   Combine the elements left to right, carrying an accumulator.
   fold_left f acc [x; y; z] should compute f (f (f acc x) y) z.

     fold_left ( + ) 0 [1; 2; 3] = 6
     fold_left ( - ) 0 [1; 2; 3] = -6

   Work through the second example by hand before writing any code.   *)

let rec fold_left f acc l = acc (* TODO *)

(* 3-3. Define each of the following using your fold_left, in one line
   and with no recursion of its own.

     sum     [1; 2; 3; 4] = 10
     length' [1; 2; 3]    = 3
     rev     [1; 2; 3]    = [3; 2; 1]

   length' should behave exactly like your 2-1. rev is the interesting
   one: nothing in fold_left reverses anything, so find where the
   reversal comes from.                                               *)

let sum l = 0 (* TODO *)
let length' l = 0 (* TODO *)
let rev l = [] (* TODO *)

(* ------------------------------------------------------------------ *)
(* 4. Algebraic data types                                            *)
(* ------------------------------------------------------------------ *)

(* A binary tree. A tree is either empty, or a node holding a value and
   two subtrees. This declaration is given to you.                    *)

type 'a tree =
  | Leaf
  | Node of 'a tree * 'a * 'a tree

(* The examples below use

     let t = Node (Node (Leaf, 1, Leaf), 2, Node (Leaf, 3, Leaf))

   which is the tree

             2
            / \
           1   3                                                      *)

(* 4-1. size : 'a tree -> int
   The number of Node constructors in the tree.

     size t    = 3
     size Leaf = 0                                                    *)

let rec size t = 0 (* TODO *)

(* 4-2. depth : 'a tree -> int
   The length of the longest path from the root down to a Leaf.

     depth t    = 2
     depth Leaf = 0                                                   *)

let rec depth t = 0 (* TODO *)

(* 4-3. to_list : 'a tree -> 'a list
   All values in the tree, in in-order: everything in the left subtree,
   then the node's own value, then the right subtree.

     to_list t = [1; 2; 3]

   The list append operator is @ .

   When you are done, compare the shape of your three tree functions
   against the shape of the type declaration above. Each has one branch
   per constructor, and recurses exactly where the type recurses. This
   is not a coincidence, and it is how you will work through an AST for
   the rest of the course.                                            *)

let rec to_list t = [] (* TODO *)

(* ------------------------------------------------------------------ *)
(* Checks                                                             *)
(*                                                                    *)
(* Run this file and compare each line against what it should be.     *)
(* show_int_list and show_char_option are given to you so that lists  *)
(* and options can be printed. You do not need to read them.          *)
(* ------------------------------------------------------------------ *)

let show_int_list l = "[" ^ String.concat "; " (List.map string_of_int l) ^ "]"

let show_char_option o =
  match o with
  | None -> "None"
  | Some c -> "Some '" ^ String.make 1 c ^ "'"

let () =
  let t = Node (Node (Leaf, 1, Leaf), 2, Node (Leaf, 3, Leaf)) in
  let abc = [ 'a'; 'b'; 'c' ] in
  print_newline ();

  print_string "sum_to 5   -> ";
  print_int (sum_to 5);
  print_endline "   (expect 15)";

  print_string "fib 10     -> ";
  print_int (fib 10);
  print_endline "   (expect 55)";

  print_string "length     -> ";
  print_int (length [ 1; 2; 3 ]);
  print_endline "   (expect 3)";

  print_string "nth 1      -> ";
  print_string (show_char_option (nth abc 1));
  print_endline "   (expect Some 'b')";

  print_string "nth 5      -> ";
  print_string (show_char_option (nth abc 5));
  print_endline "   (expect None)";

  print_string "map        -> ";
  print_string (show_int_list (map (fun x -> x * 2) [ 1; 2; 3 ]));
  print_endline "   (expect [2; 4; 6])";

  print_string "fold_left  -> ";
  print_int (fold_left ( - ) 0 [ 1; 2; 3 ]);
  print_endline "   (expect -6)";

  print_string "sum        -> ";
  print_int (sum [ 1; 2; 3; 4 ]);
  print_endline "   (expect 10)";

  print_string "length'    -> ";
  print_int (length' [ 1; 2; 3 ]);
  print_endline "   (expect 3)";

  print_string "rev        -> ";
  print_string (show_int_list (rev [ 1; 2; 3 ]));
  print_endline "   (expect [3; 2; 1])";

  print_string "size       -> ";
  print_int (size t);
  print_endline "   (expect 3)";

  print_string "depth      -> ";
  print_int (depth t);
  print_endline "   (expect 2)";

  print_string "to_list    -> ";
  print_string (show_int_list (to_list t));
  print_endline "   (expect [1; 2; 3])";

  print_newline ()
