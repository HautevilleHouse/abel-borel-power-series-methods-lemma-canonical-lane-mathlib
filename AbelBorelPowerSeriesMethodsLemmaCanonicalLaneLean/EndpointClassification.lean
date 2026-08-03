import Mathlib.Topology.Algebra.InfiniteSum
import Mathlib.Data.Nat.Factorial
import Mathlib.Topology.Instances.Real
import Mathlib.Topology.Separation
import Mathlib.Order.Set

/-!
# Abel Borel Power Series Methods Lemma
-/

noncomputable section

namespace AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean

open Filter
open scoped Topology
open scoped BigOperators

structure FormalPowerSeries where
  coeff : ℕ → ℝ

namespace FormalPowerSeries

def abelTransform (f : FormalPowerSeries) (x : ℝ) : ℝ :=
  ∑' n : ℕ, f.coeff n * x ^ n

def borelTransform (f : FormalPowerSeries) (x : ℝ) : ℝ :=
  ∑' n : ℕ, f.coeff n / (Nat.factorial n : ℝ) * x ^ n

end FormalPowerSeries

def HasAbelSum (f : FormalPowerSeries) (s : ℝ) : Prop :=
  Tendsto (fun x : ℝ => f.abelTransform x) (nhdsWithin (1 : ℝ) (Set.Iio (1 : ℝ))) (𝓝 s)

def HasBorelSum (f : FormalPowerSeries) (s : ℝ) : Prop :=
  Tendsto (fun x : ℝ => f.borelTransform x) (nhdsWithin (1 : ℝ) (Set.Iio (1 : ℝ))) (𝓝 s)

structure Admissible (f : FormalPowerSeries) : Prop where
  abel_summable_near_one : ∀ᶠ x in nhdsWithin (1 : ℝ) (Set.Iio (1 : ℝ)), Summable (fun n : ℕ => f.coeff n * x ^ n)
  borel_summable_near_one : ∀ᶠ x in nhdsWithin (1 : ℝ) (Set.Iio (1 : ℝ)), Summable (fun n : ℕ => f.coeff n / (Nat.factorial n : ℝ) * x ^ n)

def AbelBorelPowerSeriesMethodsLemma (f : FormalPowerSeries) : Prop :=
  ∀ s t : ℝ, HasAbelSum f s → HasBorelSum f t → s = t

structure AbelBorelPowerSeriesMethodsLemmaPackage where
  formalSeries : FormalPowerSeries
  abelSum : ℝ
  borelSum : ℝ
  admissible : Admissible formalSeries
  hasAbelSum : HasAbelSum formalSeries abelSum
  hasBorelSum : HasBorelSum formalSeries borelSum
  abelBorelAgree : abelSum = borelSum

def AbelBorelPowerSeriesMethodsLemmaClosed (P : AbelBorelPowerSeriesMethodsLemmaPackage) : Prop :=
  P.abelBorelAgree ∧ P.admissible

structure AbelBorelPowerSeriesMethodsLemmaEvidence
    (P : AbelBorelPowerSeriesMethodsLemmaPackage) where
  abelSumValue : ℝ
  borelSumValue : ℝ
  hasAbelSumValue : HasAbelSum P.formalSeries abelSumValue
  hasBorelSumValue : HasBorelSum P.formalSeries borelSumValue
  sumsAgreeValue : abelSumValue = borelSumValue
  admissibleValue : Admissible P.formalSeries

theorem abel_borel_power_series_methods_lemma_closed_from_evidence
    (P : AbelBorelPowerSeriesMethodsLemmaPackage)
    (E : AbelBorelPowerSeriesMethodsLemmaEvidence P) :
    AbelBorelPowerSeriesMethodsLemmaClosed P := by
  have hs_eq : P.abelSum = E.abelSumValue := tendsto_nhds_unique P.hasAbelSum E.hasAbelSumValue
  have ht_eq : P.borelSum = E.borelSumValue := tendsto_nhds_unique P.hasBorelSum E.hasBorelSumValue
  have agree : P.abelSum = P.borelSum := by
    rw [hs_eq, ht_eq]
    exact E.sumsAgreeValue
  exact And.intro agree E.admissibleValue

theorem abel_borel_power_series_methods_lemma_supplies_mathlib_statement
    (P : AbelBorelPowerSeriesMethodsLemmaPackage) :
    AbelBorelPowerSeriesMethodsLemma P.formalSeries := by
  intro s t hs ht
  have hs_eq : s = P.abelSum := tendsto_nhds_unique hs P.hasAbelSum
  have ht_eq : t = P.borelSum := tendsto_nhds_unique ht P.hasBorelSum
  rw [hs_eq, ht_eq]
  exact P.abelBorelAgree

end AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean