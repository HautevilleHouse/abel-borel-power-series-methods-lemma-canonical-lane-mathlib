import AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean.AdmissibleClass

namespace HautevilleHouse
namespace AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean

structure PowerSeriesDomain where
  series : ℕ → ℝ
  radius : ℝ
  analyticAtZero : Prop

structure AbelBorelAdmittedObject where
  domain : PowerSeriesDomain
  convergence : Prop
  abelSummable : Prop
  borelSummable : Prop
  tauberianCondition : Prop
  conclusion : convergence → (abelSummable ∨ borelSummable) → tauberianCondition → (abelSummable ∧ borelSummable)

def AbelBorelWitnessClosed (O : AbelBorelAdmittedObject) : Prop :=
  O.conclusion O.convergence (Or.inl O.abelSummable) O.tauberianCondition

end AbelBorelPowerSeriesMethodsLemmaCanonicalLaneLean
end HautevilleHouse