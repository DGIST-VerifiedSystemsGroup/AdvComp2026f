# DGIST IC526 Advanced Compilers - 2026 Fall

A graduate course on how compilers work — from source text to machine instructions, and why the
transformations in between preserve what the program means.

The programming assignments run on a single codebase throughout: a compiler for a subset of Rust,
written in OCaml. It lowers to LLVM IR and emits RISC-V assembly.

| | |
| --- | --- |
| **Lectures** | Mon & Wed, 10:30–11:45, E3-113 |
| **Instructor** | Yoonseung Kim · yoonseung.kim@dgist.ac.kr |
| **Office hours** | Mon/Wed 13:00–14:00, E7-L05 by appointment (email me) |
| **Discussion** | [GitHub Issues](../../issues) |

---

## Getting started

Read [Setup.md](helps/Setup.md) and get the toolchain working **before the 2nd lecture**. It takes about an
hour on a clean machine, and every assignment depends on it.

---

## Prerequisites

A data structures course, and a systems programming or computer architecture course — enough that
pointers, registers, and stack frames are familiar rather than new.

No prior experience with OCaml is assumed — week 1 covers what you need. Rust appears only as the
language we compile; the subset is small and introduced as we go.

---

## Course Materials

Slides are posted before each lecture.

Each student will be given a private GitHub repository for the programming assignments.

---

## Assignments (To be confirmed)

You will receive a GitHub invitation to
a private repository for each one — accept it, then push to `main` to submit.

| | Task | Out | Due |
| --- | --- | --- | --- |
| **PA1** | [Stack-machine compiler](hw_files/IC526_HW1_Specification.pdf) | Sep 03 | Sep 13 23:59 |
| **PA2** | Lexer and parser | TBA | TBA |
| **PA3** | Type Checker & IR Generation | TBA | TBA |
| **PA4** | Optimization | TBA | TBA |



**Late policy.** Grading uses your last commit before the cutoff.

| Late by | Penalty |
| --- | --- |
| up to 3 days | −10% |
| 4–7 days | −20% |
| more than 7 days | no credit |

Illness, family emergencies, and anything else outside your control are handled case by case.
Email me — before the deadline if you can, as soon as possible if you cannot.

---

## Grading

| | |
| --- | --- |
| Midterm | 40% |
| Programming Assignments | 20% |
| Project | 30% |
| Attendance & Participation | 10% |

---

## Collaboration

Discuss ideas freely. Write your own code.

**AI assistants.** Allowed, and worth learning to use well. You are responsible for every line
you submit — including explaining it on request.

---

## Reference

- [The LLVM Language Reference](https://llvm.org/docs/LangRef.html)
- [The Rustonomicon](https://doc.rust-lang.org/nomicon/), on ownership and aliasing
- [The RISC-V Instruction Set Manual](https://riscv.org/technical/specifications/)
- [Real World OCaml](https://dev.realworldocaml.org/)

No textbook is required. Slides are self-contained.

---

## Fixing this page

Typos, broken links, wrong dates — open a PR. The correction shows up in the commit log, which
is the point.
