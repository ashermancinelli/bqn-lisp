#! /home/amancinelli/CBQN/BQN

⟨fe⟩⇐

⟨nl, alnum, alpha, syms, digits, t⟩←•Import "util.bqn"

# Front end namespace
fe ← {
  toks ⇐ ⟨⟩
  src ← @ # source text
  DumpToks ⇐ {𝕊:
    •Out "
============================================
            Dump of Token Table
============================================
"
    il ← 2
    In←{' '¨↕𝕩}
    (1⊸⊑)◶⟨
      {𝕊:•Out (In il)∾"("⋄il+↩2}, # lparen
      {𝕊:il-↩2⋄•Out (In il)∾")"}, # rparen
      {•Out (In il)∾"id: "∾(•Fmt 2⊑𝕩)}, # ID
      {•Out (In il)∾"num: "∾(•Fmt 2⊑𝕩)}, # number
    ⟩¨toks
  }
  Tokenize ⇐ {𝕊:

      s ← src ↩ 𝕩
      lpm ← '(' = s
      rpm ← ')' = s
      ws ← ' ' = s

      "parens not balanced" ! 0=+´(lpm-rpm)

      l‿r ← 1↓⊔(lpm∨(2×rpm)) # get indices for left/right parens
      l↩{𝕩‿t.lp}¨l⋄r↩{𝕩‿t.rp}¨r
      toks ↩ l∾r

      # Find IDs and numbers, break into index-value pairs
      alnumm ← ∊⟜(syms∾alnum) s
      alnumStrings ← alnumm ((¬-˜⊢×·+`»⊸>)⊸⊔) s
      alnumStarts ← 1⊑⊔{𝕊0‿1:1;0}¨<˘2↕0∾alnumm

      # Convert to real IDs and numeric literals. If the first value of the id/numlit
      # is a digit, assume the whole thing is a digit. we'll do error checking later.
      indexTypeValueTuples ← {𝕊i‿v:
        i‿((⊑(alpha∾syms)∊˜⊑v)⊑⟨t.num,t.id⟩)‿v
      }¨<˘⍉alnumStarts≍alnumStrings

      toks ∾↩ indexTypeValueTuples

      # Sort according to source location
      toks ↩ (⊑¨toks)⍋⊸⊏toks
  }
}
