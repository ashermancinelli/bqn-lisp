⟨StrEq, SplitGroups, nl, alnum, alpha, syms, digits, t⟩⇐

StrEq ← {((≠𝕨)=(≠𝕩)) ? (∧´(𝕩=𝕨)) ; 0}

nl←10+@

alnum ← ∾"0aA"+⟜↕¨10‿26‿26
alpha ← ∾"aA"+⟜↕¨26‿26
digits ← 0⊑"0"+¨<↕10
syms ← "=+-_""'*&^%$#@!~`,./<>?;:[]{}\|"
SplitGroups ← (¬-˜⊢×·+`»⊸>)⊸⊔
t←{lp‿rp‿id‿num⇐↕4}