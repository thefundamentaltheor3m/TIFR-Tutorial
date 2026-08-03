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
  intro h'
  obtain ⟨h, h2⟩ := h'
  constructor
  · exact h2
  · exact h

example : P ∧ Q → Q ∧ P := by
  intro h
  constructor
  · exact h.right
  · exact h.left

example : P ∧ Q → Q ∧ P := by
  intro ⟨(h : P), (h2 : Q)⟩
  constructor
  · exact h2
  · exact h

example : P ∧ Q → Q ∧ P := by
  rintro ⟨(h : P), (h2 : Q)⟩
  constructor
  · exact h2
  · exact h

example : P ∨ Q → Q ∨ P := by
  -- tauto
  intro (h : P ∨ Q)
  cases h with
  | inl tifr =>
    right
    exact tifr
  | inr iitb =>
    left
    exact iitb

example : P ∨ Q ∨ R → Q ∨ P := by
  intro h
  rcases h with hP | hQ | hR
  · right
    exact hP
  · left
    exact hQ
  · sorry

example : ¬ (P ∨ Q ∨ R → Q ∨ P) := by
  -- push Not
  sorry

example : P ∨ Q ∨ R → Q ∨ P := by -- same as P ∨ (Q ∨ R) → Q ∨ P
  intro h
  cases h with
  | inl tifr =>
    right
    exact tifr
  | inr iit =>
    cases iit with
    | inl iitb =>
      left
      exact iitb
    | inr iitd =>
      sorry

example : (P ∧ Q) ∧ R ↔ P ∧ (Q ∧ R) := by
  constructor
  · sorry
  · sorry

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

section induction_pfs

#check Nat.zero

open Nat

example : 2 = succ (succ 0) := rfl

example : 2 * 3 * 4 = 24 := by
  decide

-- #synth DecidableEq Nat

-- example : 2 * 3 * 4 = 25.0 := by decide

example : 2 * 3 * 4 < 25 := by
  decide

example (x y : ℕ) (hx : x = 2) (hy : y = 3) : x * y = 6 := by
  rw [hx]
  rw [hy]

example (x y : ℕ) (hx : x = 1) (hy : y = 3) : (x + x) * y = 6 := by
  rw [hx, hy]

example (x y : ℕ) (hx : 1 = x) (hy : y = 3) : (x + x) * y = 6 := by
  rw [← hx, hy]

def myProperty (n : ℕ) : Prop := Nat.Prime n

example : Nat.zero = 0 := by simp

#check Nat.zero_eq

example : ∀ n : ℕ, n < n + 37 := by
  -- `simp` also works
  intro n
  rw [lt_add_iff_pos_right]
  positivity

lemma foo1 : ∀ n : ℕ, n < n + 37 := by simp

lemma foo2 (n : ℕ) : n < n + 37 := by simp

lemma foo1_eq_foo2 : foo1 = foo2 := rfl

open Finset

lemma my_sum (n : ℕ) : 2 * ∑ i ∈ range (n + 1), (i : ℕ) = n * (n + 1) := by
  induction n with
  | zero => decide
  | succ n induction_hyp =>
    rw [sum_range_succ, mul_add, induction_hyp]
    ring_nf
    -- stop
    -- calc
    -- _ = 2 * (∑ i ∈ range (n + 1), (i : ℕ) + (n + 1)) := by
    --   congr
    --   rw [sum_range_succ_comm, add_comm]
    -- _ = 2 * ∑ i ∈ range (n + 1), (i : ℕ) + 2 * (n + 1) := by
    --   rw [mul_add]
    -- _ = n * (n + 1) + 2 * (n + 1) := by
    --   rw [ih]
    -- _ = _ := by ring

example (n : ℕ) : 2 * ∑ i ∈ range (n + 1), (i : ℕ) = n * (n + 1) := by
  induction n with
  | zero => decide
  | succ n ih =>
    calc
    _ = 2 * (∑ i ∈ range (n + 1), (i : ℕ) + (n + 1)) := by
      -- congr
      rw [sum_range_succ_comm, add_comm]
    _ = 2 * ∑ i ∈ range (n + 1), (i : ℕ) + 2 * (n + 1) := by
      rw [mul_add]
    _ = n * (n + 1) + 2 * (n + 1) := by
      rw [ih]
    _ = _ := by ring

lemma my_sum' (n : ℕ) : ∑ i ∈ range (n + 1), (i : ℚ) = n * (n + 1) / 2 := by
  rw [eq_div_iff_mul_eq (by norm_num), mul_comm]
  norm_cast
  rw [← my_sum]
  simp

end induction_pfs
