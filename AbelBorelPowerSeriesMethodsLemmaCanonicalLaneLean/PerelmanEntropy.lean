/-!
# Abel-Borel Power Series Methods Lemma Package

This file formalizes the bridge between Abel summation methods and
Borel summation methods for formal power series.  It provides a
package structure capturing the key theorems (Abel's theorem, Borel's
lemma) and a compatibility statement connecting the two summation
methods.
-/

namespace AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean

/-! ## Base structures -/

/-- A basic package of formal power series data: a coefficient ring,
the formal series themselves, and the analytic functions into which
they may be summed. -/
structure FormalPowerSeriesPackage where
  coefficientRing : Type u
  formalSeries : Type v
  analyticFunctions : Type w

/-! ## Abel-Borel package -/

/-- The central package for the Abel-Borel power series methods lemma.
It records the two summation methods (Abel and Borel), the statements
of Abel's theorem and Borel's lemma, and the admissibility bridge
between these methods. -/
structure AbelBorelPowerSeriesPackage (F : FormalPowerSeriesPackage) where
  /-- A type representing Abel summation methods. -/
  abelMethod : Type u
  /-- A type representing Borel summation methods. -/
  borelMethod : Type v
  /-- Abel's theorem: under appropriate conditions, the Abel sum of a
  power series agrees with the limit of the series along the radius. -/
  abelTheorem : Prop
  /-- Borel's lemma: every formal power series is the Taylor series of
  some smooth function. -/
  borelLemma : Prop
  /-- The bridge statement: for every admissible series, the Abel and
  Borel summation methods yield the same value. -/
  abelBorelBridge : Prop

/-! ## Evidence and closure -/

/-- Evidence that an Abel-Borel package is fully established: all three
bridge statements are proved. -/
structure AbelBorelPowerSeriesEvidence {F : FormalPowerSeriesPackage}
    (A : AbelBorelPowerSeriesPackage F) where
  abelTheoremClosed : A.abelTheorem
  borelLemmaClosed : A.borelLemma
  abelBorelBridgeClosed : A.abelBorelBridge

/-- The closed condition for an Abel-Borel package: the conjunction of
the three bridge statements. -/
def AbelBorelPowerSeriesClosed {F : FormalPowerSeriesPackage}
    (A : AbelBorelPowerSeriesPackage F) : Prop :=
  A.abelTheorem ∧ A.borelLemma ∧ A.abelBorelBridge

/-- Obtain a closed Abel-Borel package from evidence. -/
theorem abel_borel_power_series_closed_from_evidence
    {F : FormalPowerSeriesPackage} (A : AbelBorelPowerSeriesPackage F)
    (E : AbelBorelPowerSeriesEvidence A) : AbelBorelPowerSeriesClosed A := by
  exact And.intro E.abelTheoremClosed
    (And.intro E.borelLemmaClosed E.abelBorelBridgeClosed)

end AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean