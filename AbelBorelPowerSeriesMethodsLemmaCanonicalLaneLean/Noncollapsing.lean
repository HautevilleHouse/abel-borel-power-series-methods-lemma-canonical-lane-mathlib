/-!
# Noncollapsing Package for Abel–Borel Power Series Methods Lemma

This file encodes the admissible-class bridge for the Abel–Borel power series methods lemma.
-/

namespace HautevilleHouse
namespace AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean

/-- The core objects of Abel–Borel power series methods. -/
structure AbelBorelPowerSeriesMethodsPackage where
  admissibleClass : Prop
  abelMethod : Prop
  borelMethod : Prop
  bridgeLemma : Prop

/-- A noncollapsing package: all essential components are present and compatible. -/
structure NoncollapsingPackage (P : AbelBorelPowerSeriesMethodsPackage) where
  admissibleClassClosed : P.admissibleClass
  abelMethodClosed : P.abelMethod
  borelMethodClosed : P.borelMethod
  bridgeLemmaClosed : P.bridgeLemma

/-- Evidence that a noncollapsing package is actually closed. -/
structure NoncollapsingEvidence {P : AbelBorelPowerSeriesMethodsPackage}
    (N : NoncollapsingPackage P) where
  admissibleClassClosed : N.admissibleClassClosed
  abelMethodClosed : N.abelMethodClosed
  borelMethodClosed : N.borelMethodClosed
  bridgeLemmaClosed : N.bridgeLemmaClosed

/-- The unified closure condition for the Abel–Borel bridge. -/
def NoncollapsingClosed {P : AbelBorelPowerSeriesMethodsPackage}
    (N : NoncollapsingPackage P) : Prop :=
  N.admissibleClassClosed ∧ N.abelMethodClosed ∧ N.borelMethodClosed ∧ N.bridgeLemmaClosed

/-- If evidence exists for every component, the noncollapsing package is closed. -/
theorem noncollapsing_closed_from_evidence
    {P : AbelBorelPowerSeriesMethodsPackage}
    (N : NoncollapsingPackage P) (E : NoncollapsingEvidence N) :
    NoncollapsingClosed N := by
  exact And.intro E.admissibleClassClosed
    (And.intro E.abelMethodClosed
      (And.intro E.borelMethodClosed E.bridgeLemmaClosed))

/-- The Abel–Borel bridge theorem: under an admissible class, the Abel and Borel methods agree. -/
theorem abel_borel_bridge
    {P : AbelBorelPowerSeriesMethodsPackage}
    (N : NoncollapsingPackage P) (h : NoncollapsingClosed N) :
    P.bridgeLemma := by
  exact h.2.2.2

end AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean
end HautevilleHouse