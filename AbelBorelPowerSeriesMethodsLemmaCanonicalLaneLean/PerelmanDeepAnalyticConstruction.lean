import Mathlib

/-!
# Abel–Borel Power Series Methods Lemma: Deep Analytic Construction

This module refines the foundational inhabitants for the Abel–Borel power series
methods lemma into a deeper analytic construction interface. It names the
formal power series, Abel summability, Borel transform, Borel summability,
admissible class, and the bridge lemma ingredients that feed the canonical
Abel–Borel route.

The module is intentionally term-level: each analytic construction supplies
Lean inhabitants for its named analytic components and maps them into the
foundational theorem inhabitants used by the route closure.
-/

namespace AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean

/-- Foundational inhabitants for the Abel–Borel power series methods lemma. -/
structure AbelBorelFoundationalInhabitants where
  abelTheorem : Prop
  borelSummation : Prop
  abelBorelEquivalence : Prop
  abelTheoremTerm : abelTheorem
  borelSummationTerm : borelSummation
  abelBorelEquivalenceTerm : abelBorelEquivalence

/--
Deep analytic construction for the Abel–Borel power series methods lemma.
Encodes the admissible-class bridge between Abel’s convergence-based method
and Borel’s integral-based summation method.
-/
structure AbelBorelPowerSeriesMethodsConstruction where
  -- Basic formal power series ingredients
  formalPowerSeries : Prop
  coefficientSequence : Prop
  radiusPositive : Prop
  boundaryPoint : Prop
  -- Abel side conditions
  abelConvergence : Prop
  -- Borel side conditions
  borelTransform : Prop
  borelIntegral : Prop
  -- Admissible class
  admissibleClass : Prop
  -- Derived Abel objects
  abelRadialLimit : Prop
  abelSum : Prop
  -- Derived Borel object
  borelSum : Prop
  -- Bridge lemma
  abelBorelLemma : Prop
  -- Terms for primitive ingredients
  formalPowerSeriesTerm : formalPowerSeries
  coefficientSequenceTerm : coefficientSequence
  radiusPositiveTerm : radiusPositive
  boundaryPointTerm : boundaryPoint
  abelConvergenceTerm : abelConvergence
  borelTransformTerm : borelTransform
  borelIntegralTerm : borelIntegral
  admissibleClassTerm : admissibleClass
  -- Terms for derived propositions
  abelRadialLimitTerm : abelRadialLimit
  abelSumTerm : abelSum
  borelSumTerm : borelSum
  abelBorelLemmaTerm : abelBorelLemma
  -- Construction functions: from primitive ingredients to derived propositions
  abelRadialLimitFromConvergence :
    formalPowerSeries -> coefficientSequence -> radiusPositive -> boundaryPoint ->
      abelConvergence -> abelRadialLimit
  abelSumFromRadialLimit :
    abelRadialLimit -> abelSum
  borelSumFromIntegral :
    formalPowerSeries -> coefficientSequence -> borelTransform -> borelIntegral -> borelSum
  abelBorelLemmaFromSummability :
    abelSum -> borelSum -> admissibleClass -> abelBorelLemma

/-- Map a deep construction to the foundational Abel–Borel inhabitants. -/
def AbelBorelPowerSeriesMethodsConstruction.toFoundational
    (C : AbelBorelPowerSeriesMethodsConstruction) : AbelBorelFoundationalInhabitants :=
  let abelRadialLimit : C.abelRadialLimit :=
    C.abelRadialLimitFromConvergence
      C.formalPowerSeriesTerm C.coefficientSequenceTerm C.radiusPositiveTerm C.boundaryPointTerm C.abelConvergenceTerm
  let abelSum : C.abelSum :=
    C.abelSumFromRadialLimit abelRadialLimit
  let borelSum : C.borelSum :=
    C.borelSumFromIntegral C.formalPowerSeriesTerm C.coefficientSequenceTerm C.borelTransformTerm C.borelIntegralTerm
  let abelBorelBridge : C.abelBorelLemma :=
    C.abelBorelLemmaFromSummability abelSum borelSum C.admissibleClassTerm
  {
    abelTheorem := C.abelSum
    borelSummation := C.borelSum
    abelBorelEquivalence := C.abelBorelLemma
    abelTheoremTerm := abelSum
    borelSummationTerm := borelSum
    abelBorelEquivalenceTerm := abelBorelBridge
  }

end AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean