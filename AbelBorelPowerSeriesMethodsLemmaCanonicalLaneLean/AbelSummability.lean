import AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean.PowerSeriesDomain

namespace HautevilleHouse
namespace AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean

structure AbelSummabilityPackage (D : PowerSeriesDomain) where
  abelMean : D.series → ℝ
  abelLimit : ℝ
  abelSummable : Prop
  abelSumEquals : abelSummable → abelMean D.series = abelLimit

structure AbelSummabilityEvidence (D : PowerSeriesDomain) (A : AbelSummabilityPackage D) where
  abelSummableClosed : A.abelSummable
  abelSumEqualsClosed : A.abelSumEquals A.abelSummableClosed

def AbelSummabilityClosed (D : PowerSeriesDomain) (A : AbelSummabilityPackage D) : Prop :=
  A.abelSummable ∧ (A.abelSumEquals A.abelSummable)

theorem abel_summability_closed_from_evidence (D : PowerSeriesDomain) (A : AbelSummabilityPackage D) (E : AbelSummabilityEvidence D A) :
    AbelSummabilityClosed D A := by
  exact And.intro E.abelSummableClosed E.abelSumEqualsClosed

end AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean
end HautevilleHouse