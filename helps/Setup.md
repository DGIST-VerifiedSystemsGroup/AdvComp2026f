# Environment Setup

Drafted with an AI assistant and tested on Ubuntu 24.04 (WSL2).

The compiler in this course is built on top of:

- **OCaml 5.1** — implementation language
- **dune** — build system
- **Menhir** — LR(1) parser generator
- **LLVM 18 OCaml bindings** — IR & Code generation

> **Windows users:** work inside **WSL2**. The Linux instructions below apply as-is.

---

## 1. System dependencies

The OCaml bindings link against the **system LLVM 18 installation**, so this must come before opam.

**Ubuntu / WSL2**

```bash
sudo apt update
sudo apt install -y build-essential m4 unzip bubblewrap \
                    cmake pkg-config libffi-dev \
                    llvm-18-dev
```

**macOS (Homebrew)**

```bash
brew install cmake pkg-config libffi llvm@18
```

### Expose the right `llvm-config`

opam must find the **version 18** `llvm-config`, not whatever else is on your system.

**Ubuntu / WSL2**

```bash
export PATH=/usr/lib/llvm-18/bin:$PATH
```

**macOS**

```bash
export PATH="$(brew --prefix llvm@18)/bin:$PATH"
```

Verify:

```bash
llvm-config --version    # must print 18.x.x
```

Add this line to your `~/.bashrc` or `~/.zshrc` so it persists across shells. The same
directory also provides `llc`, which you will need in section 6.

---

## 2. Install opam

```bash
bash -c "sh <(curl -fsSL https://opam.ocaml.org/install.sh)"
```

Initialize it:

```bash
opam init          # answer yes when asked to modify your shell config
eval $(opam env)
```

Verify:

```bash
opam --version     # 2.1 or later
```

---

## 3. Create a dedicated switch

Keep the course toolchain isolated from your global environment.

```bash
opam switch create compilers 5.1.1     # "compilers" is the switch name — pick anything
eval $(opam env --switch=compilers)     # activates the switch in this shell
```

The `eval` line affects the current shell only. Run it again in every new terminal, or add it to
your `~/.bashrc` (`~/.zshrc`) to make it automatic.

Verify:

```bash
ocaml -version     # 5.1.1
opam switch list   # "compilers" marked with →
```

Every later step assumes this switch is active.

---

## 4. Install packages

```bash
opam install -y \
  dune \
  menhir \
  llvm.18-shared \
  ocaml-lsp-server \
  ocamlformat \
  utop
```

| Package | Purpose |
| --- | --- |
| `dune` | build system |
| `menhir` | parser generation |
| `llvm` | IR generation (version pin is required) |
| `ocaml-lsp-server` | editor completion and type hints |
| `ocamlformat` | code formatting |
| `utop` | interactive REPL |

---

## 5. Verify the installation

```bash
dune --version
menhir --version
```

Confirm the LLVM bindings actually link, by building a throwaway project:

```bash
mkdir -p /tmp/check && cd /tmp/check

cat > dune-project <<'EOF'
(lang dune 3.0)
EOF

cat > dune <<'EOF'
(executable (name t) (libraries llvm))
EOF

cat > t.ml <<'EOF'
let () =
  let c = Llvm.create_context () in
  let m = Llvm.create_module c "t" in
  print_string (Llvm.string_of_llmodule m)
EOF

dune exec ./t.exe
```

Success looks like `ModuleID = 't'` on stdout.

---

## 6. RISC-V execution (optional)

```bash
sudo apt install -y gcc-riscv64-linux-gnu qemu-user
```

### Toolchain smoke test

```bash
cat > out.s <<'EOF'
    .text
    .globl main
main:
    addi sp, sp, -16
    sd   ra, 8(sp)

    li   a0, 42

    ld   ra, 8(sp)
    addi sp, sp, 16
    ret
EOF

riscv64-linux-gnu-gcc -static out.s -o out
qemu-riscv64 out
echo $?          # 42
```

### From LLVM IR

This is the path the course compiler actually takes.

```bash
cat > t.ll <<'EOF'
define i32 @main() {
entry:
  %a = add i32 40, 2
  ret i32 %a
}
EOF

llc -mtriple=riscv64-unknown-linux-gnu \
    -mattr=+m,+a,+f,+d,+c \
    -target-abi=lp64d \
    t.ll -o out.s

riscv64-linux-gnu-gcc -static out.s -o out
qemu-riscv64 out
echo $?          # 42
```

---

## Troubleshooting

**`conf-llvm` fails to install**
`llvm-config --version` is not reporting 18. Recheck your `PATH`.

**`Unbound module Llvm`**
You are in a different switch. Run `eval $(opam env)` and retry.

**`No implementations provided for the following modules: Llvm`**
This is a *link* error, not a missing package — the archive was never handed to the linker.
Build through dune (section 5) rather than invoking `ocamlfind` by hand; dune orders the link
line for you. To inspect what findlib resolves:

```bash
ocamlfind query -format "%(archive)" -predicates native llvm
```

**`ilp32d/lp64d ABI can't be used when d extension isn't supported`**
`llc` and `gcc` disagree on the target. See section 6 — add `-mattr=+m,+a,+f,+d,+c` and
`-target-abi=lp64d` to the `llc` invocation.

**`qemu-riscv64: Could not open ...: No such file or directory`**
You linked dynamically. Add `-static`.

**Builds are very slow**
Raise the parallelism: `opam install -j4 ...`

**Start over from scratch**

```bash
opam switch remove compilers
```
