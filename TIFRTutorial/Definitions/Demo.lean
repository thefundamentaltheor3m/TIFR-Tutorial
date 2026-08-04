/-
Copyright (c) 2026 Sidharth Hariharan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Sidharth Hariharan
-/
module

public import Mathlib

@[expose] public section

namespace MyGroup

section as_structure

end as_structure

section as_prop

end as_prop

end MyGroup

#check Group
#check Subgroup
#check Set

section subgroups

def myEvensSubset : Set ℤ := fun x ↦ 2 ∣ x

lemma myEvensSubset_eq : myEvensSubset = {x : ℤ | 2 ∣ x} := rfl

def myEvens : AddSubgroup ℤ where
  carrier := {x : ℤ | 2 ∣ x}
  add_mem' := sorry
  neg_mem' := sorry
  zero_mem' := sorry

example : 2 ∈ myEvensSubset := by
  rw [myEvensSubset_eq, Set.mem_setOf]

example : 2 ∈ myEvens := by
  simp [myEvens]

example : 3 ∈ myEvensSubset := by sorry

end subgroups
