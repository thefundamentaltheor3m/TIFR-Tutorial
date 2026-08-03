/-
Copyright (c) 2026 Sidharth Hariharan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Sidharth Hariharan
-/
module

public import Mathlib

@[expose] public section

set_option linter.unusedVariables false

/-!
# A Tour of Some Useful Tactics

Each section below is devoted to a single tactic. The `example`s that come with a proof are there
for you to read, run and play with; the ones that end in `sorry` are for you to solve.

The mathematical content is deliberately kept as simple as possible: almost everything below is
about natural numbers, lists or sets. The point is to get used to the tactics, not to prove
anything deep.

A few things worth remembering while you work through this file:
* hovering over a tactic or a lemma name in VS Code shows its documentation;
* placing your cursor inside a proof shows you the remaining goals in the infoview;
* `exact?` searches the library for a lemma that closes the current goal, and `apply?` for one
  that makes progress on it.
-/

section rw_tactic

/-!
## `rw`

`rw [h]` ("rewrite") replaces every occurrence of the left-hand side of the equation (or iff) `h`
in the goal by its right-hand side. Some useful variations:
* `rw [← h]` rewrites right-to-left instead;
* `rw [h₁, h₂]` performs several rewrites, one after the other;
* `rw [h] at h'` rewrites in the hypothesis `h'` instead of in the goal.

After each rewrite, `rw` tries to close the goal with `rfl`, which is why the proofs below often
end as soon as the last rewrite has happened.
-/

-- Rewriting with `hab` turns the goal `a = c` into `b = c`; rewriting with `hbc` then closes it.
example (a b c : ℕ) (hab : a = b) (hbc : b = c) : a = c := by
  rw [hab, hbc]

-- Rewriting happens underneath functions too.
example (f : ℕ → ℕ) (x y : ℕ) (h : x = y) : f x = f y := by
  rw [h]

-- One can rewrite with a lemma from the library, not just with a local hypothesis.
example (n : ℕ) : n + 0 = n := by
  rw [Nat.add_zero]

-- `←` rewrites in the other direction: here, `b` gets replaced by `a + 1`.
example (a b : ℕ) (h : a + 1 = b) : b = a + 1 := by
  rw [← h]

-- Rewriting in a hypothesis, with `at`.
example (a b : ℕ) (h : a = b) (h' : a + a = 4) : b + b = 4 := by
  rw [h] at h'
  exact h'

/-! ### Exercises -/

example (a b : ℕ) (h : a = b) : a * a = b * b := by
  sorry

-- Hint: `Nat.add_comm` (or, in fact, `add_comm`) is the lemma you are looking for.
example (m n : ℕ) : m + n = n + m := by
  sorry

example (f : ℕ → ℕ) (h : ∀ n, f n = n + 1) : f (f 0) = 2 := by
  sorry

end rw_tactic

section simp_tactic

/-!
## `simp`

`simp` ("simplify") repeatedly rewrites the goal with the lemmas that the library has tagged
`@[simp]`, in the hope of turning it into something trivially true. Variations:
* `simp [h₁, h₂]` uses `h₁` and `h₂` in addition to the default simp set;
* `simp at h` simplifies the hypothesis `h`, and `simp_all` simplifies everything in sight;
* `simp?` reports the list of lemmas that were actually used, which is an excellent way of
  learning the names of library lemmas.

`simp` is *not* magic: it only knows the lemmas it has been given, so a failure usually means you
need to supply an extra lemma yourself.
-/

example (n : ℕ) : n + 0 = n := by
  simp

example (a b : ℕ) (h : a = 0) : a + b = b := by
  simp [h]

example (l : List ℕ) : (l ++ []).length = l.length := by
  simp

example {α : Type*} (s : Set α) : s ∩ ∅ = ∅ := by
  simp

-- Simplifying a hypothesis rather than the goal.
example (n : ℕ) (h : n + 0 = 5) : n = 5 := by
  simp at h
  exact h

/-! ### Exercises -/

example (n : ℕ) : n * 1 + 0 = n := by
  sorry

example {α : Type*} (s : Set α) : s ∪ ∅ = s := by
  sorry

example (l : List ℕ) : l.reverse.reverse = l := by
  sorry

end simp_tactic

section induction_tactic

/-!
## `induction`

To prove a statement about every natural number `n`, write
```
induction n with
| zero => ...
| succ k ih => ...
```
The first branch asks you to prove the statement for `0`, and the second asks you to prove it for
`k + 1`, giving you the induction hypothesis `ih` for `k`.

The same tactic works for any inductive type: for a list the two cases are called `nil` and
`cons` instead.
-/

-- Proving `List.append_nil` by hand, by induction on the list.
example (l : List ℕ) : l ++ [] = l := by
  induction l with
  | nil => rfl
  | cons a t ih => rw [List.cons_append, ih]

-- The sum of the first `n` odd numbers is `n ^ 2`.
example (n : ℕ) : (∑ i ∈ Finset.range n, (2 * i + 1)) = n ^ 2 := by
  induction n with
  | zero => simp
  | succ k ih =>
    rw [Finset.sum_range_succ, ih]
    ring

/-! ### Exercises -/

-- Hint: `Finset.sum_range_succ` peels off the last term of a sum over `Finset.range (n + 1)`.
example (n : ℕ) : 2 * (∑ i ∈ Finset.range (n + 1), i) = n * (n + 1) := by
  sorry

example (n : ℕ) : (∑ i ∈ Finset.range n, (2 : ℕ) ^ i) + 1 = 2 ^ n := by
  sorry

example (l : List ℕ) : (l.map (fun x ↦ x + 1)).sum = l.sum + l.length := by
  sorry

end induction_tactic

section grind_tactic

/-!
## `grind`

`grind` is a recent and rather powerful automation tactic. It combines case analysis, congruence
closure (reasoning about equalities and about the functions applied to them) and linear
arithmetic over `ℕ` and `ℤ`. It is often the quickest way of discharging a goal that is
"obviously true" but tedious to prove by hand.

When `grind` fails, it prints the state it got stuck in, which is usually informative.
-/

example (a b c : ℕ) (hab : a ≤ b) (hbc : b ≤ c) : a ≤ c := by
  grind

example (x y : ℕ) (h : 2 * x + 1 = 2 * y + 1) : x = y := by
  grind

-- Congruence: `grind` knows that equal arguments give equal values.
example (f : ℕ → ℕ) (a b : ℕ) (h : a = b) : f a + 1 = f b + 1 := by
  grind

-- Case analysis together with arithmetic.
example (n : ℕ) (h₁ : n < 3) (h₂ : n ≠ 0) (h₃ : n ≠ 1) : n = 2 := by
  grind

/-! ### Exercises -/

example (a b : ℕ) (h : a + b = 0) : a = 0 ∧ b = 0 := by
  sorry

example (x y z : ℕ) (hxy : x = y) (hyz : y = z) : x + z = 2 * y := by
  sorry

example (n : ℕ) (h : 2 * n = 10) : n = 5 := by
  sorry

end grind_tactic

section aesop_tactic

/-!
## `aesop`

`aesop` ("Automated Extensible Search for Obvious Proofs") searches for a proof by combining
`simp` with a collection of safe introduction and elimination rules, the local hypotheses, and
anything the library has tagged `@[aesop]`. It is particularly good at the kind of goal about
logic, sets and subsets whose proof is entirely routine.

`aesop?` prints the proof it found, so you can read it and, more often than not, shorten it.
-/

example (P Q : Prop) (hp : P) (hq : Q) : P ∧ Q := by
  aesop

example (P Q : Prop) (h : P ∧ Q) : Q ∧ P := by
  aesop

example {α : Type*} (s t : Set α) : s ∩ t ⊆ s ∪ t := by
  aesop

example {α : Type*} (s t : Set α) (x : α) (hx : x ∈ s) : x ∈ s ∪ t := by
  aesop

/-! ### Exercises -/

example {α : Type*} (s t : Set α) : s ∩ t ⊆ s := by
  sorry

example {α : Type*} (s t u : Set α) (hst : s ⊆ t) (htu : t ⊆ u) : s ⊆ u := by
  sorry

example (P Q R : Prop) (hpq : P → Q) (hqr : Q → R) : P → R := by
  sorry

end aesop_tactic

section use_tactic

/-!
## `use`

`use x` supplies the witness `x` for a goal of the form `∃ y, P y`. Having done so, it tries to
close what remains with `rfl`, `assumption` and a few other cheap tactics, so `use x` very often
finishes the proof all by itself. When it does not, you are left with the goal `P x` to prove.

Several witnesses can be given at once: `use x, y`.
-/

example : ∃ n : ℕ, n + 3 = 5 := by
  use 2

example (x : ℕ) : ∃ y : ℕ, y * y = x * x := by
  use x

example {α : Type*} (s : Set α) (x : α) (hx : x ∈ s) : ∃ y, y ∈ s := by
  use x

-- Two witnesses at once.
example : ∃ m n : ℕ, m + n = 7 := by
  use 3, 4

-- Here `use` cannot finish on its own, and leaves us with the goal `a + b = 3 * b`.
example (a b : ℕ) (h : a = 2 * b) : ∃ c : ℕ, a + b = 3 * c := by
  use b
  omega

/-! ### Exercises -/

example : ∃ n : ℕ, n * n = 49 := by
  sorry

example : ∃ n : ℕ, 5 < n ∧ n < 8 := by
  sorry

example (f : ℕ → ℕ) (h : ∀ n, f n = 0) : ∃ n : ℕ, f n + 1 = 1 := by
  sorry

end use_tactic

section calc_tactic

/-!
## `calc`

`calc` lets you write a chain of (in)equalities one step at a time, much as you would on paper.
Each step comes with its own proof, and the underscore `_` stands for the right-hand side of the
previous step.

The steps need not all use the same relation: `calc` knows how to compose `=`, `≤` and `<`, and
the relation of the whole chain is the strongest one it can justify.
-/

example (a b : ℕ) (hab : a = b + 1) (hb : b = 2) : a = 3 :=
  calc a = b + 1 := hab
    _ = 2 + 1 := by rw [hb]
    _ = 3 := by norm_num

example (a b c d : ℕ) (hab : a ≤ b) (hbc : b ≤ c) (hcd : c ≤ d) : a ≤ d :=
  calc a ≤ b := hab
    _ ≤ c := hbc
    _ ≤ d := hcd

-- Mixing `<` and `≤` gives a strict inequality.
example (a b c : ℕ) (hab : a < b) (hbc : b ≤ c) : a < c :=
  calc a < b := hab
    _ ≤ c := hbc

-- A `calc` block is a term, so it can equally well be used inside a tactic proof.
example (x y : ℕ) (h : x = y) : x + 1 ≤ y + 2 := by
  calc x + 1 = y + 1 := by rw [h]
    _ ≤ y + 2 := by omega

/-! ### Exercises

Each of these can be proved in one line by `omega`. Please resist the temptation, and write out
a `calc` chain instead! -/

example (a b : ℕ) (h : a = 2 * b) : a + b = 3 * b := by
  sorry

example (x y z : ℕ) (hxy : x ≤ y) (hyz : y < z) : x < z + 1 := by
  sorry

example (n : ℕ) (h : n ≤ 5) : n + 3 ≤ 10 := by
  sorry

end calc_tactic
