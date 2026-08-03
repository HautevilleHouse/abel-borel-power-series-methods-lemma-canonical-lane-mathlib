import AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean.AdmissibleClass

namespace HautevilleHouse
namespace AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean

/-- The bridge is closed when the Abel-Borel agreement witness is available. -/
def bridgeClosed (A : AdmissibleClass) : Prop :=
  PowerSeriesWitnessClosed A.object

theorem bridge_from_admissible_class (A : AdmissibleClass) :
    bridgeClosed A := by
  exact A.object.conclusion

end AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean
end HautevilleHouse