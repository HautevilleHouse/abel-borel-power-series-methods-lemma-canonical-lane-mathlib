import Mathlib.Data.Real.Basic
import Mathlib.Topology.Basic

namespace HautevilleHouse
namespace AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean

-- The fundamental object: a formal power series with real coefficients
structure AbelBorelPowerSeries where
  coeff : ℕ → ℝ

-- Abel summability with a specified value
structure AbelSum (f : AbelBorelPowerSeries) where
  value : ℝ
  convergent : Prop

-- Borel summability with a specified value
structure BorelSum (f : AbelBorelPowerSeries) where
  value : ℝ
  convergent : Prop

-- The admissible class of power series for which the Abel-Borel bridge applies
structure AbelBorelAdmissibleClass where
  contains : AbelBorelPowerSeries → Prop
  admissible_condition : Prop

-- The bridge lemma: within an admissible class, Abel and Borel summations agree
def AbelBorelBridgeLemma (C : AbelBorelAdmissibleClass) : Prop :=
  ∀ (f : AbelBorelPowerSeries), C.contains f →
    ∀ (A : AbelSum f) (B : BorelSum f),
      A.convergent → B.convergent → A.value = B.value

-- An admitted object carries the series, the summability witnesses, and the conclusion
structure AbelBorelAdmittedObject where
  f : AbelBorelPowerSeries
  class : AbelBorelAdmissibleClass
  in_class : class.contains f
  abel : AbelSum f
  borel : BorelSum f
  abel_conv : abel.convergent
  borel_conv : borel.convergent
  conclusion : abel.value = borel.value

-- The bridge for a particular admitted object
structure AbelBorelBridge where
  admitted : AbelBorelAdmittedObject
  result : admitted.conclusion

-- The endgame state encapsulates the full bridge and its admissible class
structure AbelBorelEndgameState where
  class : AbelBorelAdmissibleClass
  object : AbelBorelAdmittedObject
  bridge : AbelBorelBridge
  lemma_member : AbelBorelBridgeLemma class

-- A witness predicate: existence of Abel and Borel sums agreeing
def AbelBorelWitness (C : AbelBorelAdmissibleClass) (f : AbelBorelPowerSeries) : Prop :=
  ∃ (A : AbelSum f) (B : BorelSum f),
    C.contains f ∧ A.convergent ∧ B.convergent ∧ A.value = B.value

-- A corollary: the bridge lemma implies all admissible and convergent series are witnessed
def AbelBorelBridgeLemmaImpliesWitness (C : AbelBorelAdmissibleClass) : Prop :=
  AbelBorelBridgeLemma C → ∀ (f : AbelBorelPowerSeries), C.contains f → AbelBorelWitness C f

end AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean
end HautevilleHouse