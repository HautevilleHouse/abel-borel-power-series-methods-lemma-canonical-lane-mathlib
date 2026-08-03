import AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean.AbelBorelPowerSeriesProof

/-!
# Abel Borel Power Series Methods Lemma: Evidence Terms

This module exposes the proof terms carried by each analytic certificate for
the Abel-Borel power series methods lemma. The route is term-level: every
analytic field has a named Lean term, and those terms project into the
Abel-Borel route closure.
-/

namespace AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean

universe u

/-! ## Abel Summation -/

structure AbelSummationPackage where
  coefficientType : Type u
  series : ℕ → coefficientType
  evaluationPoint : coefficientType
  abelSummable : Prop
  abelSumValue : coefficientType
  abelTheoremStatement : Prop

structure AbelSummationCertificate (P : AbelSummationPackage) where
  abelSummableProof : P.abelSummable
  abelTheoremProof : P.abelTheoremStatement

structure AbelSummationClosed (P : AbelSummationPackage) where
  abelSummable : P.abelSummable
  abelTheorem : P.abelTheoremStatement

structure AbelSummationEvidenceTerms {P : AbelSummationPackage}
    (C : AbelSummationCertificate P) where
  abelSummable : C.abelSummableProof
  abelTheorem : C.abelTheoremProof
  closed : AbelSummationClosed P

def abel_summation_closed_from_evidence {P : AbelSummationPackage}
    (C : AbelSummationCertificate P) : AbelSummationClosed P :=
  { abelSummable := C.abelSummableProof
    abelTheorem := C.abelTheoremProof }

def AbelSummationCertificate.evidenceTerms {P : AbelSummationPackage}
    (C : AbelSummationCertificate P) : AbelSummationEvidenceTerms C :=
  { abelSummable := C.abelSummableProof
    abelTheorem := C.abelTheoremProof
    closed := abel_summation_closed_from_evidence C }

/-! ## Borel Summation -/

structure BorelSummationPackage where
  coefficientType : Type u
  series : ℕ → coefficientType
  evaluationPoint : coefficientType
  borelSummable : Prop
  borelSumValue : coefficientType
  borelTheoremStatement : Prop

structure BorelSummationCertificate (P : BorelSummationPackage) where
  borelSummableProof : P.borelSummable
  borelTheoremProof : P.borelTheoremStatement

structure BorelSummationClosed (P : BorelSummationPackage) where
  borelSummable : P.borelSummable
  borelTheorem : P.borelTheoremStatement

structure BorelSummationEvidenceTerms {P : BorelSummationPackage}
    (C : BorelSummationCertificate P) where
  borelSummable : C.borelSummableProof
  borelTheorem : C.borelTheoremProof
  closed : BorelSummationClosed P

def borel_summation_closed_from_evidence {P : BorelSummationPackage}
    (C : BorelSummationCertificate P) : BorelSummationClosed P :=
  { borelSummable := C.borelSummableProof
    borelTheorem := C.borelTheoremProof }

def BorelSummationCertificate.evidenceTerms {P : BorelSummationPackage}
    (C : BorelSummationCertificate P) : BorelSummationEvidenceTerms C :=
  { borelSummable := C.borelSummableProof
    borelTheorem := C.borelTheoremProof
    closed := borel_summation_closed_from_evidence C }

/-! ## Abel-Borel Bridge Lemma -/

structure AbelBorelBridgePackage where
  abelSummation : AbelSummationPackage
  borelSummation : BorelSummationPackage
  abelBorelAgreement : Prop
  analyticContinuationMatches : Prop

structure AbelBorelBridgeCertificate (P : AbelBorelBridgePackage) where
  abelSummable : P.abelSummation.abelSummable
  borelSummable : P.borelSummation.borelSummable
  abelBorelAgreementProof : P.abelBorelAgreement
  analyticContinuationMatchesProof : P.analyticContinuationMatches

structure AbelBorelBridgeClosed (P : AbelBorelBridgePackage) where
  abelSummable : P.abelSummation.abelSummable
  borelSummable : P.borelSummation.borelSummable
  abelBorelAgreement : P.abelBorelAgreement
  analyticContinuationMatches : P.analyticContinuationMatches

structure AbelBorelBridgeEvidenceTerms {P : AbelBorelBridgePackage}
    (C : AbelBorelBridgeCertificate P) where
  abelSummable : C.abelSummable
  borelSummable : C.borelSummable
  abelBorelAgreement : C.abelBorelAgreementProof
  analyticContinuationMatches : C.analyticContinuationMatchesProof
  closed : AbelBorelBridgeClosed P

def abel_borel_bridge_closed_from_evidence {P : AbelBorelBridgePackage}
    (C : AbelBorelBridgeCertificate P) : AbelBorelBridgeClosed P :=
  { abelSummable := C.abelSummable
    borelSummable := C.borelSummable
    abelBorelAgreement := C.abelBorelAgreementProof
    analyticContinuationMatches := C.analyticContinuationMatchesProof }

def AbelBorelBridgeCertificate.evidenceTerms {P : AbelBorelBridgePackage}
    (C : AbelBorelBridgeCertificate P) : AbelBorelBridgeEvidenceTerms C :=
  { abelSummable := C.abelSummable
    borelSummable := C.borelSummable
    abelBorelAgreement := C.abelBorelAgreementProof
    analyticContinuationMatches := C.analyticContinuationMatchesProof
    closed := abel_borel_bridge_closed_from_evidence C }

end AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean