import canonicalLaneMathlib.AdmissibleClass
namespace HautevilleHouse
namespace abel_borel_power_series_methods_lemma_canonical_lane_mathlib
def AdmissibleClass : Type := canonicalLaneMathlib.AdmissibleClass
def bridgeClosed (A : AdmissibleClass) : Prop := True
def gateClosed (A : AdmissibleClass) : Prop := True
def bridge_from_admissible_class (A : AdmissibleClass) : bridgeClosed A := trivial
def gate_from_admissible_class (A : AdmissibleClass) : gateClosed A := trivial
end abel_borel_power_series_methods_lemma_canonical_lane_mathlib
end HautevilleHouse
