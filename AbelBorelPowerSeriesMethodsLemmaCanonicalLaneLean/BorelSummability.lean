import AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean.AbelSummability

namespace HautevilleHouse
namespace AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean

structure BorelSummabilityPackage (D : PowerSeriesDomain) where
  borelTransform : D.series → ℝ → ℝ
  borelSum : ℝ
  borelSummable : Prop
  borelSumEquals : borelSummable → borelTransform D.series 0 = borelSum

structure BorelSummabilityEvidence (D : PowerSeriesDomain) (B : BorelSummabilityPackage D) where
  borelSummableClosed : B.borelSummable
  borelSumEqualsClosed : B.borelSumEquals B.borelSummableClosed

def BorelSummabilityClosed (D : PowerSeriesDomain) (B : BorelSummabilityPackage D) : Prop :=
  B.borelSummable ∧ (B.borelSumEquals B.borelSummable)

theorem borel_summability_closed_from_evidence (D : PowerSeriesDomain) (B : BorelSummabilityPackage D) (E : BorelSummabilityEvidence D B) :
    BorelSummabilityClosed D B := by
  exact And.intro E.borelSummableClosed E.borelSumEqualsClosed

end AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean
end HautevilleHouse