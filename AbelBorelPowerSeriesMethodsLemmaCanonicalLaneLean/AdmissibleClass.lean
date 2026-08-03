import Mathlib.Data.Real.Basic

/-!
# Admissible Class for Abel Borel Power Series Methods Lemma

This module defines the admitted object for the Abel-Borel power series bridge:
a power series with Abel and Borel summability properties, and the witness that
the two methods agree under the admissible class.
-/

namespace HautevilleHouse
namespace AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean

/-- A power series object with coefficients and Abel/Borel data. -/
structure PowerSeriesObject where
  coefficient : Nat -> ℝ
  abelSummable : Prop
  borelSummable : Prop
  abelLimit : ℝ
  borelLimit : ℝ

/-- The bridge statement for a power series: both methods summable to the same limit. -/
def AbelBorelBridgeEstablished (f : PowerSeriesObject) : Prop :=
  f.abelSummable ∧ f.borelSummable ∧ f.abelLimit = f.borelLimit

/-- The admitted object: a power series together with a proof of the bridge statement. -/
structure PowerSeriesAdmittedObject where
  series : PowerSeriesObject
  abelRegular : Prop
  borelRegular : Prop
  conclusion : AbelBorelBridgeEstablished series

/-- Projection from an admitted object to the closed bridge witness. -/
def PowerSeriesWitnessClosed (O : PowerSeriesAdmittedObject) : Prop :=
  AbelBorelBridgeEstablished O.series

structure AdmissibleClass where
  object : PowerSeriesAdmittedObject
  endpointSatisfied : Prop
  remainderRecorded : Prop
  gateWitness : endpointSatisfied ∨ remainderRecorded

def admittedClosure (A : AdmissibleClass) : Prop :=
  PowerSeriesWitnessClosed A.object ∧ (A.endpointSatisfied ∨ A.remainderRecorded)

end AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean
end HautevilleHouse