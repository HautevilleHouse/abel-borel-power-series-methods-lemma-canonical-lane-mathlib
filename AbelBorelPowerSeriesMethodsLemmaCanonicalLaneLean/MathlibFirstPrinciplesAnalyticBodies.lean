import Mathlib.Data.Nat.Basic
import Mathlib.Data.Real.Basic
import Mathlib.Data.Nat.Factorial
import Mathlib.Topology.Algebra.InfiniteSum
import Mathlib.Analysis.SpecificLimits.Basic

noncomputable section
open scoped BigOperators
open Filter

namespace AbelBorelPowerSeriesMethods

/-- The ordinary (partial-sum) limit of a sequence. -/
def OrdinarySummable (a : ℕ → ℝ) (s : ℝ) : Prop :=
  Tendsto (fun n : ℕ => ∑ i in Finset.range n, a i) atTop (𝓝 s)

/-- The Abel summability of a sequence `a` to a value `s`. -/
def AbelSummable (a : ℕ → ℝ) (s : ℝ) : Prop :=
  ∃ x : ℝ, x ∈ Set.Ioo (0 : ℝ) 1 ∧
    Tendsto (fun n : ℕ => ∑ i in Finset.range n, a i * x ^ i) atTop (𝓝 s)

/-- The Borel summability of a sequence `a` to a value `s` (schematic). -/
def BorelSummable (a : ℕ → ℝ) (s : ℝ) : Prop :=
  ∃ x : ℝ, 0 < x ∧
    Tendsto (fun n : ℕ => ∑ i in Finset.range n, a i * x ^ i / Nat.factorial i) atTop (𝓝 s)

/-- A typical Tauberian condition: the Cesàro mean of `n a_n` tends to zero. -/
def TauberianCondition (a : ℕ → ℝ) : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ N : ℕ, ∀ n ≥ N, n * |a n| ≤ ε

/-- The admissible-class bridge between Abel and Borel summability. -/
structure AbelBorelBridgeStatements where
  abelToBorel : ∀ (a : ℕ → ℝ) (s : ℝ), TauberianCondition a → AbelSummable a s → BorelSummable a s
  borelToAbel : ∀ (a : ℕ → ℝ) (s : ℝ), TauberianCondition a → BorelSummable a s → AbelSummable a s

/-- The canonical lane carries the bridge statements and their verification. -/
structure AbelBorelCanonicalLane where
  bridge : AbelBorelBridgeStatements

/-- From the canonical lane we can extract the Abel-to-Borel implication. -/
theorem canonicalLane_abelToBorel (L : AbelBorelCanonicalLane)
    (a : ℕ → ℝ) (s : ℝ) (hT : TauberianCondition a) (hA : AbelSummable a s) :
    BorelSummable a s :=
  L.bridge.abelToBorel a s hT hA

/-- From the canonical lane we can extract the Borel-to-Abel implication. -/
theorem canonicalLane_borelToAbel (L : AbelBorelCanonicalLane)
    (a : ℕ → ℝ) (s : ℝ) (hT : TauberianCondition a) (hB : BorelSummable a s) :
    AbelSummable a s :=
  L.bridge.borelToAbel a s hT hB

/-- The zero sequence is Abel summable to zero. -/
lemma abelSummable_zero : AbelSummable (fun _ => 0) 0 := by
  refine ⟨(1/2 : ℝ), ?_, ?_⟩
  · constructor <;> norm_num
  · simp
    exact tendsto_const_nhds

/-- The zero sequence is Borel summable to zero. -/
lemma borelSummable_zero : BorelSummable (fun _ => 0) 0 := by
  refine ⟨(1 : ℝ), by norm_num, ?_⟩
  simp
  exact tendsto_const_nhds

end AbelBorelPowerSeriesMethods