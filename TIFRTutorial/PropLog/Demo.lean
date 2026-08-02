/-
Copyright (c) 2026 Sidharth Hariharan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Sidharth Hariharan
-/
module

@[expose] public section

variable (P Q R S T : Prop)

section basic

/-
We're going to work on this section live, as a way of demonstrating how to write both statements
and proofs.
-/

end basic

section connectives

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

end connectives
