"
============================================
             Tree Generation
============================================
"

⟨t, SplitGroups⟩←•Import "util.bqn"
⟨tree⟩⇐

Parens ← 1⊸⊑◶1‿¯1‿0‿0

GroupStmts ← {𝕊toks:
  m←0»+`0=+`Parens¨toks
  m⊔toks
}

# A statement is a top-level notion which contains some number of
# expressions.
stmts ← ⟨⟩
exprs ← ⟨⟩

NestingLvl ← {1»+`Parens¨𝕩}
DropLast ← 1⊸↓⌾⌽

# Pretty nasty way to do this... stringify the tokens and use the l/rparen tokens
# as literal ⟨ and ⟩ to make a tree structure, and use •BQN to evaluate it.
NestArgs ← {
  F1←{(•Fmt 𝕩)∾","}
  F←{"⟨"∾(F1¨𝕩)∾"⟩,"}
  argv ← "⟨"∾(∾´∾´ (1⊸⊑)◶"⟨"‿"⟩,"‿F‿F ¨𝕩)∾"⟩"
  •BQN argv
}

i←0
AddStmt ← {𝕊stmt:
  •Out "adding statement "∾(•Fmt i+↩1)
  "empty parens is not a valid expression" ! 2≠≠stmt
  NumLit←(1⊸⊑)◶⟨⊢, ⊢, ⊢, {𝕊i‿t‿v:i‿t‿(•BQN v)}⟩
  stmt ↩ NumLit¨stmt # replace numlits with BQN numbers (instead of strings)
  nest ← NestingLvl stmt
  funcIs ← 0»0=1⊑¨stmt
  NestArgs stmt
}


Tree ← {𝕊toks:
  slist ← GroupStmts toks
  ⊑¨AddStmt¨slist
}
