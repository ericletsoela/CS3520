# Step 5 - B-type and J-type instruction decoding

The encodings below are calculated for uncompressed RV32IM instructions. Check both words in Ripes before submission. These local branch and jump offsets do not depend on earlier pseudo-instruction expansions. Use uncompressed RV32IM instructions.

## B-type: `blt t0,t1,done` in exercise 2

In `ex2-sum-to-n/solution.s`, the target `done` is four 4-byte instructions forward from `blt`: `add`, `addi`, `beq`, then `done`. Offset = +16 bytes. `t0=x5`, `t1=x6`, `funct3=100` (signed less-than), opcode `1100011`.

| Field | Value |
| --- | --- |
| `imm[12]` [31] | `0` |
| `imm[10:5]` [30:25] | `000000` |
| `rs2` [24:20] | `00110` |
| `rs1` [19:15] | `00101` |
| `funct3` [14:12] | `100` |
| `imm[4:1]` [11:8] | `1000` |
| `imm[11]` [7] | `0` |
| opcode [6:0] | `1100011` |

Word: `00000000011000101100100001100011` = **0x0062C863**. Reassemble the scattered immediate as `0|0|000000|1000|0` = 16, then add it to the branch's own PC.

## J-type: `jal x0,factorial_loop` in exercise 4

The jump at the end of the factorial loop goes back three instructions to
`factorial_loop`. Its PC-relative offset is -12 bytes. This is a real J-type
instruction, so its encoding does not depend on earlier `la` or `lw label`
expansions. `x0` discards the link address because this jump is not a call.

| Field | Value |
| --- | --- |
| `imm[20]` [31] | `1` |
| `imm[10:1]` [30:21] | `1111111010` |
| `imm[11]` [20] | `1` |
| `imm[19:12]` [19:12] | `11111111` |
| `rd` [11:7] | `00000` |
| opcode [6:0] | `1101111` |

Word: `11111111010111111111000001101111` = **0xFF5FF06F**.
The sign-extended immediate is -12, so the target is the jump's PC minus 12.
Confirm this word in Ripes with 32-bit RV32IM instructions.

Both formats move immediate bits into otherwise available positions while keeping `rs1`, `rs2`, `rd` and opcode positions consistent across formats. The low offset bit is implicit zero because branch/jump offsets are aligned in halfwords; arranging rather than shifting the bits reduces immediate-selection wiring in hardware. Reference: [RISC-V unprivileged ISA, RV32I instruction formats](https://docs.riscv.org/reference/isa/v20260120/unpriv/rv32.html).
