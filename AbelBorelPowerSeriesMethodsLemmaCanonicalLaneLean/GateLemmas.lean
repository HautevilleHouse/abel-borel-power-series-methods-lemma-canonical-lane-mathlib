import AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean.BridgeLemmas

namespace HautevilleHouse
namespace AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean

/-- The gate is closed when either the endpoint or the remainder record is satisfied. -/
def gateClosed (A : AdmissibleClass) : Prop :=
  A.endpointSatisfied ∨ A.remainderRecorded

theorem gate_from_admissible_class (A : AdmissibleClass) :
    gateClosed A := by
  exact A.gateWitness

end AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean
end HautevilleHouse