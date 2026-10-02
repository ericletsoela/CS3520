# CS3520 Lab 2 - RISC-V control flow and procedures

Each exercise has a C++ model, an RV32IM RISC-V `solution.s`, and short notes. Open each `.s` in Ripes with an RV32IM processor, assemble and run it. The examples use the educational `ecall` convention from `examples/2026/array-max`: `a7=4` prints a zero-terminated string, `a7=1` prints an integer, and `a7=10` exits. Choose a Ripes configuration that supports these calls. `mul` and `rem` in exercises 4 and 5 require the M extension.

| Exercise | Inputs | Expected output |
| --- | --- | --- |
| 1 | 17, 29 | `Larger: 29` |
| 2 | N=10 | `Sum: 55` |
| 3 | 7, 12, -4, 9, 0, 15, 28 | `Even count: 4` |
| 4 | N=5 | `Factorial: 120` |
| 5 | 48, 18 | `GCD: 6` |

`ex5-gcd/recursive.s` is the stretch solution. Unlike iterative `gcd`, it calls itself, so it saves `ra` in a 16-byte aligned frame for each non-base call and restores it after the recursive call. The base case makes no frame. It should print the same result.

## Step 2: worked example (`examples/2026/array-max/`)

The model's input is `{12,45,7,93,28,61,4}` and its output is `Maximum: 93`. At the start of the loop, `s1` holds the largest element seen so far and `t1` is the next index. The loop continues while `i<n`. In assembly, `bge t1,a1,done` branches **out** of the loop, so the exit condition is inverted to `i>=n`.

`li rd,small_number` usually becomes `addi rd,x0,small_number`; a large constant can require `lui` plus `addi`. `mv rd,rs` becomes `addi rd,rs,0`. `la rd,label` normally needs an address-building pair such as `auipc` and `addi` (or `lui` and `addi`, depending on assembler and relocation settings). `ble t4,s1,skip` becomes `bge s1,t4,skip`, with the operand order swapped. Pseudo-instructions make source easier to read and let the assembler select the correct real sequence; check Ripes' assembled instruction list for its exact expansion.

`find_max` writes to `s1`, a callee-saved register, so it stores the caller's value on the stack and restores it. It is a leaf procedure: it never executes another `jal`, so its incoming `ra` stays intact and does not need saving. Its stack pointer temporarily drops by four bytes, matching the supplied course example; the new procedures here use aligned 16-byte frames when a frame is needed.

## Reproduce and submit

Run a C++ model from its folder using `g++ -std=c++17 -Wall -Wextra model.cpp -o model && ./model`. In Ripes, open `solution.s`, assemble, run, then compare the exact printed integer with the table. For Step 5, compare both words in `encoding-analysis.md` with Ripes' machine-code view using uncompressed RV32IM instructions.

Push your verified work to your public fork and submit the repository URL on Thuto.
