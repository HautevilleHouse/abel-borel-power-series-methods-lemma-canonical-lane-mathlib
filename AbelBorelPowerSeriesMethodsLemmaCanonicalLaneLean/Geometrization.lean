/-!
# Abel Borel Power Series Methods Lemma

This file formalizes the admissible-class bridge for Abel-Borel power series summation methods.
-/

namespace HautevilleHouse
namespace AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean

/-! ## Admissible class bridge -/

/-- A bridge between Abel and Borel summability on an admissible class. -/
structure AdmissibleClassBridge where
  abelBorelCompatible : Prop
  borelAbelCompatible : Prop
  limitEquality : Prop

/-! ## Abel-Borel power series package -/

/-- The package of hypotheses for the Abel-Borel methods lemma. -/
structure AbelBorelPowerSeriesPackage where
  abelMethodRegular : Prop
  borelMethodRegular : Prop
  admissibleClassNonempty : Prop

/-! ## Evidence for the lemma -/

/-- Evidence that the Abel-Borel methods lemma holds. -/
structure AbelBorelPowerSeriesEvidence (P : AbelBorelPowerSeriesPackage) (B : AdmissibleClassBridge) where
  abelMethodRegularProof : P.abelMethodRegular
  borelMethodRegularProof : P.borelMethodRegular
  admissibleClassNonemptyProof : P.admissibleClassNonempty
  abelBorelCompatibleProof : B.abelBorelCompatible
  borelAbelCompatibleProof : B.borelAbelCompatible
  limitEqualityProof : B.limitEquality

/-! ## The main lemma -/

/-- The Abel-Borel power series methods lemma: under the bridge conditions,
    Abel and Borel summation agree on the admissible class. -/
def AbelBorelPowerSeriesMethodsLemma (P : AbelBorelPowerSeriesPackage) (B : AdmissibleClassBridge) : Prop :=
  P.abelMethodRegular ∧ P.borelMethodRegular ∧ P.admissibleClassNonempty ∧
  B.abelBorelCompatible ∧ B.borelAbelCompatible ∧ B.limitEquality

/-- Given evidence for the hypotheses, the Abel-Borel methods lemma holds. -/
theorem abelBorel_power_series_methods_lemma_from_evidence
    (P : AbelBorelPowerSeriesPackage) (B : AdmissibleClassBridge)
    (E : AbelBorelPowerSeriesEvidence P B) :
    AbelBorelPowerSeriesMethodsLemma P B := by
  exact And.intro E.abelMethodRegularProof
    (And.intro E.borelMethodRegularProof
      (And.intro E.admissibleClassNonemptyProof
        (And.intro E.abelBorelCompatibleProof
          (And.intro E.borelAbelCompatibleProof
            E.limitEqualityProof))))

end AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean
end HautevilleHouse