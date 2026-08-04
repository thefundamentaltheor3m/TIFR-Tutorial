/-
Copyright (c) 2026 Sidharth Hariharan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Sidharth Hariharan
-/
module

public import Mathlib

@[expose] public section

section as_structure

structure MyGroup where
  carrier : Type*
  mul : carrier → carrier → carrier
  inv : carrier → carrier
  id : carrier
  mul_assoc : ∀ x y z : carrier, mul (mul x y) z = mul x (mul y z)
  mul_id : ∀ x : carrier, mul x id = x
  id_mul : ∀ x : carrier, mul id x = x
  mul_inv : ∀ x : carrier, mul x (inv x) = id
  inv_mul : ∀ x : carrier, mul (inv x) x = id

structure MyCommGroup extends MyGroup where
  mul_comm : ∀ x y : carrier, mul x y = mul y x

namespace MyGroup

instance instNonempty (G : MyGroup) : Nonempty G.carrier := ⟨G.id⟩

def MyIntegers : MyCommGroup where
  carrier := ℤ
  mul := Int.add
  inv := Int.neg
  id := 0
  mul_assoc := sorry
  mul_id := sorry
  id_mul := sorry
  mul_inv := sorry
  inv_mul := sorry
  mul_comm := sorry

#check MyCommGroup.toMyGroup

instance instMyIntegersNonempty : Nonempty (MyIntegers.carrier) :=
  instNonempty MyIntegers.toMyGroup

end MyGroup

end as_structure

section as_prop

end as_prop

#check Group
#check Subgroup
#check Set

#check TopologicalSpace
#check MetricSpace

-- variable (X : Type*) [MetricSpace X]

-- #synth TopologicalSpace X

-- variable (k : Type*) [NormedField k] [SeminormedAddCommGroup X] [NormedSpace k X]

-- example : Nonempty X := sorry

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

variable (E F : Type)

def IsRadial [Norm E] (f : E → F) : Prop := f.FactorsThrough (‖·‖ : E → ℝ)

-- variable [inst1 : Norm E] [inst2 : Norm E]

-- example : @IsRadial E E inst2 (id (α := E)) := by
--   have otherOne : @IsRadial E E inst1 id := sorry
--   exact otherOne
--   sorry

instance instZ5Group : AddGroup (ZMod 5) where
  neg_add_cancel := by simp
