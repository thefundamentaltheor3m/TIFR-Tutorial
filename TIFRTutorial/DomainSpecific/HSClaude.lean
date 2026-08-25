/-
Copyright (c) 2026 Sidharth Hariharan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Sidharth Hariharan
-/
module

public import Mathlib

@[expose] public section

/-!
# Prompt

Give me a Lean statement and proof that the harmonic series does not converge.
-/

open Filter Topology

/-- The partial sums `∑_{i < n} 1 / (i + 1)` of the harmonic series tend to infinity. -/
theorem tendsto_harmonic_partialSums_atTop :
    Tendsto (fun n : ℕ => ∑ i ∈ Finset.range n, (1 / (i + 1) : ℝ)) atTop atTop :=
  Real.tendsto_sum_range_one_div_nat_succ_atTop

/-- **The harmonic series does not converge**: there is no real number `L` to which the
partial sums `∑_{i < n} 1 / (i + 1)` converge. -/
theorem harmonic_series_not_convergent :
    ¬∃ L : ℝ, Tendsto (fun n : ℕ => ∑ i ∈ Finset.range n, (1 / (i + 1) : ℝ)) atTop (𝓝 L) := by
  rintro ⟨L, hL⟩
  exact not_tendsto_atTop_of_tendsto_nhds hL tendsto_harmonic_partialSums_atTop

/-- The harmonic series `∑ 1 / n` is not summable, mathlib's idiom for convergence of series. -/
theorem harmonic_series_not_summable : ¬Summable (fun n : ℕ => (1 / n : ℝ)) :=
  Real.not_summable_one_div_natCast
