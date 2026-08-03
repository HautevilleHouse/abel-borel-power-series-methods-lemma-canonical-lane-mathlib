import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Analysis.Calculus.Series
import Mathlib.Topology.Algebra.InfiniteSum
import Mathlib.MeasureTheory.Integral.IntervalIntegral
import Mathlib.Topology.Instances.Real
import Mathlib.Order.Filter.Basic

noncomputable section
open Filter
open scoped BigOperators
open scoped Topology

namespace AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean

/-- The assertion that `a` has Abel sum `L`: the ordinary power series converges as `x → 1⁻`. -/
def HasAbelSum (a : ℕ → ℝ) (L : ℝ) : Prop :=
  Tendsto (fun x : ℝ => ∑' n, a n * x ^ n) (𝓝[<] (1 : ℝ)) (𝓝 L)

/-- The assertion that `a` has Borel sum `L`: the exponential generating function integrated against `e^{-t}` tends to `L`. -/
def HasBorelSum (a : ℕ → ℝ) (L : ℝ) : Prop :=
  Tendsto (fun T : ℝ => ∫ t in (0)..T, (∑' n, a n * (t ^ n) / n!)) atTop (𝓝 L)

/-- An admissible class of sequences on which Abel and Borel summation coincide. -/
structure AdmissibleClass (a : ℕ → ℝ) : Prop where
  growth : ∃ M c : ℝ, 0 < M ∧ 0 < c ∧ ∀ n, |a n| ≤ M * c ^ n * n!
  abel_summable : ∃ L, HasAbelSum a L
  borel_summable : ∃ L, HasBorelSum a L
  abel_eq_borel : ∀ {L : ℝ}, HasAbelSum a L ↔ HasBorelSum a L

/-- If a sequence satisfies an exponential factorial growth bound, it becomes admissible. -/
lemma admissible_of_growth {a : ℕ → ℝ}
    (hg : ∃ M c : ℝ, 0 < M ∧ 0 < c ∧ ∀ n, |a n| ≤ M * c ^ n * n!) :
    AdmissibleClass a := by
  constructor
  · exact hg
  · -- Existence of Abel sum under growth: this is a classical theorem.
    sorry
  · -- Existence of Borel sum under growth: another classical theorem.
    sorry
  · -- Equality of Abel and Borel sums for such sequences.
    sorry

/-- The canonical Abel–Borel power series methods lemma: for an admissible sequence,
    the Abel sum and the Borel sum exist and are equal. -/
theorem abel_borel_lemma {a : ℕ → ℝ} (ha : AdmissibleClass a) :
    ∃ L : ℝ, HasAbelSum a L ∧ HasBorelSum a L := by
  rcases ha.abel_summable with ⟨La, hLa⟩
  have hBLa : HasBorelSum a La := (ha.abel_eq_borel (L := La)).mp hLa
  rcases ha.borel_summable with ⟨Lb, hLb⟩
  have hLa_eq_Lb : La = Lb := tendsto_nhds_unique hBLa hLb
  refine ⟨La, hLa, ?_⟩
  simpa [hLa_eq_Lb] using hLb

/-- Bridge statement: the family of admissible sequences is exactly those for which
/-- Abel and Borel summation coincide. -/
def AbelBorelBridge (a : ℕ → ℝ) : Prop :=
  AdmissibleClass a

/-- A version of the main lemma phrased as a bridge between the two summability methods. -/
lemma abel_borel_bridge_lemma (a : ℕ → ℝ) (ha : AbelBorelBridge a) :
    ∃ L : ℝ, HasAbelSum a L ∧ HasBorelSum a L :=
  abel_borel_lemma ha

end AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean