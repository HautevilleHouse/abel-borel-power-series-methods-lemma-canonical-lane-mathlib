import AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean.GateLemmas

namespace HautevilleHouse
namespace AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean

/-- The constrained Abel-Borel closure: bridge and gate both closed. -/
def ConstrainedAbelBorelClosure (A : AdmissibleClass) : Prop :=
  bridgeClosed A ∧ gateClosed A

theorem constrained_abel_borel_endgame (A : AdmissibleClass) :
    ConstrainedAbelBorelClosure A := by
  exact And.intro (bridge_from_admissible_class A) (gate_from_admissible_class A)

end AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean
end HautevilleHouse