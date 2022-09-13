#! /home/amancinelli/CBQN/BQN

"

BQN Lisp-MLIR Compiler
============================================

    Usage:
      ./c.bqn <path to lisp file> <path to output file>

============================================
" ! 2=≠•args

s←•file.Chars 0⊑•args
of←1⊑•args

⟨fe⟩←•Import "fe.bqn"
⟨tree⟩←•Import "t.bqn"
⟨cg⟩←•Import "cg.bqn"

fe.Tokenize s
fe.DumpToks@

toks ← fe.toks
•Out "
============================================
          Tokenized Syntax Tree
============================================
"
•Show t←Tree toks

Compile ← {
  cc ← ⟨
    "mlir-opt",
    "--pass-pipeline=func.func(tosa-infer-shapes, tosa-to-linalg-named, tosa-to-linalg, canonicalize, arith-expand, canonicalize)",
    "--func-bufferize",
    "--pass-pipeline=func.func(canonicalize, convert-linalg-to-affine-loops, affine-loop-fusion, lower-affine, finalizing-bufferize, buffer-deallocation, convert-scf-to-cf, convert-math-to-llvm)",
    "--convert-arith-to-llvm",
    "--convert-vector-to-llvm",
    "--convert-cf-to-llvm",
    "--convert-memref-to-llvm",
    "--convert-func-to-llvm",
    "--canonicalize",
    "--reconcile-unrealized-casts",
    "--canonicalize",
    "--llvm-legalize-for-export",
    𝕩
  ⟩
  r‿o‿e ← •Sh cc
  •Out 0⊸=◶{𝕊:"Error occured: "∾e}‿{𝕊:"compilation succeeded"}r
}

mlir ← of∾".mlir"
•Show mlir CG t
of Compile mlir

