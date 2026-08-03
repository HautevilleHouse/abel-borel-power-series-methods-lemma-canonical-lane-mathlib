import Mathlib.Data.Real.Basic
import Mathlib.Topology.Basic

/-!
# Abel Borel Power Series Methods Lemma Package

This file contains the canonical bridge structures and statements
for the Abel-Borel power series methods lemma.
-/

namespace HautevilleHouse
namespace AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean

/--
The main package collecting the key properties involved in the
Abel-Borel power series methods lemma.
-/
structure AbelBorelPowerSeriesPackage where
  abelSummable : Prop
  borelSummable : Prop
  admissibleClass : Prop
  growthCondition : Prop
  uniqueness : Prop

/--
Evidence that a given package is closed under the Abel-Borel bridge.
-/
structure AbelBorelPowerSeriesEvidence (C : AbelBorelPowerSeriesPackage) where
  abelSummableClosed : C.abelSummable
  borelSummableClosed : C.borelSummable
  admissibleClassClosed : C.admissibleClass
  growthConditionClosed : C.growthCondition
  uniquenessClosed : C.uniqueness

/--
The closure condition for a package, as a conjunction of all its fields.
-/
def AbelBorelPowerSeriesClosed (C : AbelBorelPowerSeriesPackage) : Prop :=
  C.abelSummable ∧ C.borelSummable ∧ C.admissibleClass ∧
  C.growthCondition ∧ C.uniqueness

/--
Construct the closed condition from explicit evidence.
-/
theorem abel_borel_power_series_closed_from_evidence
    (C : AbelBorelPowerSeriesPackage) (E : AbelBorelPowerSeriesEvidence C) :
    AbelBorelPowerSeriesClosed C := by
  exact And.intro E.abelSummableClosed
    (And.intro E.borelSummableClosed
      (And.intro E.admissibleClassClosed
        (And.intro E.growthConditionClosed E.uniquenessClosed)))

/--
Bridge structure connecting Abel and Borel summability to the admissible class.
-/
structure AbelBorelBridge (C : AbelBorelPowerSeriesPackage) where
  abelToAdmissible : C.abelSummable → C.admissibleClass
  borelToAdmissible : C.borelSummable → C.admissibleClass
  growthToUniqueness : C.growthCondition → C.uniqueness

/--
If both Abel and Borel summability hold, and the bridge exists,
then the admissible class is inhabited.
-/
theorem admissible_class_from_abel_borel
    {C : AbelBorelPowerSeriesPackage} (B : AbelBorelBridge C)
    (ha : C.abelSummable) (hb : C.borelSummable) : C.admissibleClass := by
  exact B.abelToAdmissible ha

/--
Uniqueness follows from the growth condition via the bridge.
-/
theorem uniqueness_from_growth
    {C : AbelBorelPowerSeriesPackage} (B : AbelBorelBridge C)
    (hg : C.growthCondition) : C.uniqueness := by
  exact B.growthToUniqueness hg

end AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean
end HautevilleHouse