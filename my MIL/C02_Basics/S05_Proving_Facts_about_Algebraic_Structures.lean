import MIL.Common
import Mathlib.Topology.MetricSpace.Basic

section
variable {α : Type*} [PartialOrder α]
variable (x y z : α)

#check x ≤ y
#check (le_refl x : x ≤ x)
#check (le_trans : x ≤ y → y ≤ z → x ≤ z)
#check (le_antisymm : x ≤ y → y ≤ x → x = y)


#check x < y
#check (lt_irrefl x : ¬x < x)
#check (lt_trans : x < y → y < z → x < z)
#check (lt_of_le_of_lt : x ≤ y → y < z → x < z)
#check (lt_of_lt_of_le : x < y → y ≤ z → x < z)

example : x < y ↔ x ≤ y ∧ x ≠ y :=
  lt_iff_le_and_ne

end

section
variable {α : Type*} [Lattice α]
variable (x y z : α)

#check x ⊓ y
#check (inf_le_left : x ⊓ y ≤ x)
#check (inf_le_right : x ⊓ y ≤ y)
#check (le_inf : z ≤ x → z ≤ y → z ≤ x ⊓ y)
#check x ⊔ y
#check (le_sup_left : x ≤ x ⊔ y)
#check (le_sup_right : y ≤ x ⊔ y)
#check (sup_le : x ≤ z → y ≤ z → x ⊔ y ≤ z)

example : x ⊓ y = y ⊓ x := by
  sorry

example : x ⊓ y ⊓ z = x ⊓ (y ⊓ z) := by
  sorry

example : x ⊔ y = y ⊔ x := by
  sorry

example : x ⊔ y ⊔ z = x ⊔ (y ⊔ z) := by
  -- exact sup_assoc
  apply le_antisymm
  apply sup_le
  apply sup_le
  apply le_sup_left
  calc
    y ≤ y ⊔ z := by exact le_sup_left
    _ ≤ x ⊔ (y ⊔ z) := by exact le_sup_right
  calc
    z ≤ y ⊔ z := by exact le_sup_right
    _ ≤ x ⊔ (y ⊔ z) := by exact le_sup_right
  apply sup_le
  calc
    x ≤ x ⊔ y := by exact le_sup_left
    _ ≤ x ⊔ y ⊔ z := by exact le_sup_left
  apply sup_le
  calc
    y ≤ x ⊔ y := by exact le_sup_right
    _ ≤ x ⊔ y ⊔ z := by exact le_sup_left
  exact le_sup_right

theorem absorb1 : x ⊓ (x ⊔ y) = x := by
  -- exact inf_sup_self
  apply le_antisymm
  apply inf_le_left
  refine le_inf_iff.mpr ?_
  apply And.intro
  rfl
  apply le_sup_left


theorem absorb2 : x ⊔ x ⊓ y = x := by
  exact sup_inf_self
end

section
variable {α : Type*} [DistribLattice α]
variable (x y z : α)

#check (inf_sup_left : x ⊓ (y ⊔ z) = x ⊓ y ⊔ x ⊓ z)
#check (inf_sup_right : (x ⊔ y) ⊓ z = x ⊓ z ⊔ y ⊓ z)
#check (sup_inf_left : x ⊔ y ⊓ z = (x ⊔ y) ⊓ (x ⊔ z))
#check (sup_inf_right : x ⊓ y ⊔ z = (x ⊔ z) ⊓ (y ⊔ z))
end

section
variable {α : Type*} [Lattice α]
variable (a b c : α)

example (h : ∀ x y z : α, x ⊓ (y ⊔ z) = x ⊓ y ⊔ x ⊓ z) : a ⊔ b ⊓ c = (a ⊔ b) ⊓ (a ⊔ c) := by
  sorry


example (h : ∀ x y z : α, x ⊔ y ⊓ z = (x ⊔ y) ⊓ (x ⊔ z)) : a ⊓ (b ⊔ c) = a ⊓ b ⊔ a ⊓ c := by
  sorry

end

section
variable {R : Type*} [StrictOrderedRing R]
variable (a b c : R)

#check (add_le_add_left : a ≤ b → ∀ c, c + a ≤ c + b)
#check (mul_pos : 0 < a → 0 < b → 0 < a * b)

#check (mul_nonneg : 0 ≤ a → 0 ≤ b → 0 ≤ a * b)

example (h : a ≤ b) : 0 ≤ b - a := by
  -- exact sub_nonneg.mpr h
  rw [← add_left_neg a]
  rw [sub_eq_neg_add]
  apply add_le_add_left h

example (h: 0 ≤ b - a) : a ≤ b := by
  exact sub_nonneg.mp h

example (h : a ≤ b) (h' : 0 ≤ c) : a * c ≤ b * c := by
  -- exact mul_le_mul_of_nonneg_right h h'
  sorry

end

section
variable {X : Type*} [MetricSpace X]
variable (x y z : X)

#check (dist_self x : dist x x = 0)
#check (dist_comm x y : dist x y = dist y x)
#check (dist_triangle x y z : dist x z ≤ dist x y + dist y z)

example (x y : X) : 0 ≤ dist x y := by
  have h : 0 ≤ dist x y + dist y x := by
    rw [← dist_self x]
    apply dist_triangle
  rw [dist_comm y x] at h
  linarith

end
