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
•Show of CG t

