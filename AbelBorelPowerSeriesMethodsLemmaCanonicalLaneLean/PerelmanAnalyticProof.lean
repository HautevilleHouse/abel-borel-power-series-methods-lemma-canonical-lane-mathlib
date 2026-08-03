/-
# Abel-Borel Power Series Methods Lemma

This module encodes the admissible-class bridge for Abel and Borel power series
summation methods, following the canonical lane for the Abel-Borel lemma.
-/

namespace HautevilleHouse
namespace AbelBorelPowerSeriesMethodsCanonicalLaneLean

/-- Package of conditions for Abel's power series method. -/
structure AbelMethodPackage where
  abelRegular : Prop
  analyticInSector : Prop
  eulerTransform : Prop

/-- Package of conditions for Borel's power series method. -/
structure BorelMethodPackage where
  borelRegular : Prop
  laplaceRepresentation : Prop
  watsonNevanlinna : Prop

/-- The admissible-class closedness condition for the Abel–Borel bridge. -/
def AbelBorelMethodClosed (A : AbelMethodPackage) (B : BorelMethodPackage) : Prop :=
  A.abelRegular ∧ A.analyticInSector ∧ A.eulerTransform ∧
  B.borelRegular ∧ B.laplaceRepresentation ∧ B.watsonNevanlinna

/-- Evidence that the closedness condition is satisfied. -/
structure AbelBorelBridgeEvidence (A : AbelMethodPackage) (B : BorelMethodPackage) where
  closed : AbelBorelMethodClosed A B

/-- Certificate for the admissible-class bridge between Abel and Borel methods. -/
structure AbelBorelBridgeCertificate {A : AbelMethodPackage} {B : BorelMethodPackage} where
  admissibleClass : Prop
  abelBorelCompatibility : Prop
  tauberianRecovery : Prop
  singularAnalyticGrow : Prop
  admissibleClassClosed : admissibleClass
  abelBorelCompatibilityClosed : abelBorelCompatibility
  tauberianRecoveryClosed : tauberianRecovery
  singularAnalyticGrowClosed : singularAnalyticGrow
  bridgeEvidence : AbelBorelBridgeEvidence A B

/-- Closedness of the Abel–Borel bridge certificate. -/
def AbelBorelBridgeCertificateClosed {A : AbelMethodPackage} {B : BorelMethodPackage}
    (C : AbelBorelBridgeCertificate A B) : Prop :=
  C.admissibleClass ∧
  C.abelBorelCompatibility ∧
  C.tauberianRecovery ∧
  C.singularAnalyticGrow ∧
  AbelBorelMethodClosed A B

/-- The Abel–Borel power series methods lemma: a closed certificate yields the bridge. -/
theorem AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean
    {A : AbelMethodPackage} {B : BorelMethodPackage}
    (C : AbelBorelBridgeCertificate A B) :
    AbelBorelBridgeCertificateClosed C := by
  exact And.intro C.admissibleClassClosed
    (And.intro C.abelBorelCompatibilityClosed
      (And.intro C.tauberianRecoveryClosed
        (And.intro C.singularAnalyticGrowClosed
          C.bridgeEvidence.closed)))

end AbelBorelPowerSeriesMethodsCanonicalLaneLean
end HautevilleHouse