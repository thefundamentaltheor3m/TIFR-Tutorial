/-
Copyright (c) 2026 Sidharth Hariharan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Sidharth Hariharan
-/
module

public import Mathlib

@[expose] public section

variable (P Q R S T : Prop)

section basic

/-
We're going to work on this section live, as a way of demonstrating how to write both statements
and proofs.
-/

def my_prop : Prop := Nat.Prime 2

def my_prop2 : Prop := Nat.Prime 57

lemma my_prop_is_true : my_prop := by -- Nat.prime_two
  sorry

lemma my_prop2_is_true : my_prop2 := by
  sorry

lemma basic1 : P → P := fun h ↦ h

example : P → P := by
  intro (h : P)
  exact h

example : P → (Q → P) :=
  -- intro (h : P)
  -- intro h2
  -- exact h
  fun h ↦ (fun _ ↦ h)

example (h : P) (k : P) : h = k := rfl

example (h : P) (k : P) : h ≠ k := by
  -- This is false
  sorry

example : P → (Q → P) := by
  intro h
  intro h2
  exact h

example : ¬ my_prop2 := by
  intro (h : my_prop2)
  sorry

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
