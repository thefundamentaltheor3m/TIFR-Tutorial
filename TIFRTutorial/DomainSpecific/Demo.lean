/-
Copyright (c) 2026 Sidharth Hariharan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Sidharth Hariharan
-/
module

public import Mathlib

@[expose] public section

section filters

#check Filter

open Filter Topology

#check atTop

example {p q : ℕ → Prop} (hp : ∀ᶠ n in atTop, p n) (hq : ∀ᶠ n in atTop, q n) :
    ∀ᶠ n in atTop, p n ∧ q n := by
  filter_upwards [hp, hq]
  aesop

example {x ε : ℝ} (hε : 0 < ε) : ∀ᶠ y in 𝓝 x, |y - x| < ε := by
  exact eventually_abs_sub_lt x hε

example {N : ℕ} : ∀ᶠ n in atTop, N ≤ n := by
  rw [eventually_atTop]
  aesop

example {p q : ℕ → Prop} {N M : ℕ} (hp : ∀ n ≥ N, p n) (hq : ∀ n ≥ M, q n) :
    ∀ᶠ n in atTop, p n ∧ q n := by
  filter_upwards [eventually_ge_atTop N, eventually_ge_atTop M]
  aesop

#check eventually_ge_atTop

example {p q : ℕ → Prop} {N M : ℕ} (hp : ∀ n ≥ N, p n) (hq : ∀ n ≥ M, q n) :
    ∃ N', ∀ n ≥ N', p n ∧ q n := by
  rw [← eventually_atTop]
  filter_upwards [eventually_ge_atTop N, eventually_ge_atTop M]
  aesop

example {f g : ℕ → ℝ} {a b : ℝ} (hf : Tendsto f atTop (𝓝 a)) (hg : Tendsto g atTop (𝓝 b)) :
    Tendsto (fun n ↦ f n + g n) atTop (𝓝 (a + b)) := by
  exact hf.add hg

#check Tendsto.add

end filters

#check SchwartzMap
