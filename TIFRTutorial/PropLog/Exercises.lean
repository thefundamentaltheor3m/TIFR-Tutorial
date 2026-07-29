/-
Copyright (c) 2026 Sidharth Hariharan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Sidharth Hariharan
-/
module

@[expose] public section

set_option linter.unusedVariables false

variable (P Q R S T : Prop)



/-
The following exercises are borrowed (with permission) from Bhavik Mehta's 2026 course
"Formalising Mathematics" taught at Imperial College London.

The full repository can be found at https://github.com/b-mehta/formalising-mathematics-notes/.

The exercises below were authored by Bhavik Mehta and Kevin Buzzard.
-/

example : (P → R) → (S → Q) → (R → T) → (Q → R) → S → T := by
  sorry

example : (P → Q) → ((P → Q) → P) → Q := by
  sorry

example : ((P → Q) → R) → ((Q → R) → P) → ((R → P) → Q) → P := by
  sorry

example : ((Q → P) → P) → (Q → R) → (R → P) → P := by
  sorry

example : (((P → Q) → Q) → Q) → P → Q := by
  sorry

example :
    (((P → Q → Q) → (P → Q) → Q) → R) →
      ((((P → P) → Q) → P → P → Q) → R) → (((P → P → Q) → (P → P) → Q) → R) → R := by
  sorry

/-- The following is the Boss Level of Function World in Emily Riehl's "Reintroduction to Proofs"
game. To play the game, visit https://adam.math.hhu.de/#/g/emilyriehl/reintroductiontoproofs. -/
example : ((((P → Q) → Q) → Q) → Q) → (P → Q) → Q := by
  sorry

example : P ∧ Q → Q ∧ P := by
  sorry

example : P ∨ Q → Q ∨ P := by
  sorry

example : (P ∧ Q) ∧ R ↔ P ∧ (Q ∧ R) := by
  sorry

example : (P ∧ Q → R) ↔ (P → Q → R) := by
  sorry

example : P ∨ Q → (P → R) → (Q → R) → R := by
  sorry

example : P ∧ (Q ∨ R) ↔ (P ∧ Q) ∨ (P ∧ R) := by
  sorry

example : ¬(P ∧ ¬P) := by
  sorry

example : P → ¬¬P := by
  sorry

example : (P → Q) → ¬Q → ¬P := by
  sorry

example : (P ↔ Q) → (Q ↔ R) → (P ↔ R) := by
  sorry
