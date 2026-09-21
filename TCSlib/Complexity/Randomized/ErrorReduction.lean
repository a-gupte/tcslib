/-
Copyright (c) 2026 The TCSlib Authors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: TCSlib Contributors
-/
import Mathlib.Probability.ProbabilityMassFunction.Constructions
import Mathlib.MeasureTheory.Constructions.Pi
import Mathlib.Analysis.SpecialFunctions.Exp

set_option maxHeartbeats 0
set_option relaxedAutoImplicit false
set_option autoImplicit false

/-!
# Error reduction by repetition: the Chernoff core

The probabilistic heart of Arora–Barak's error-reduction theorem
([AB09, Thm 7.10]): run `k` independent trials of a decision procedure that
is correct with probability `p ≥ 1/2 + ε` and take the majority; the
probability that the majority is wrong is exponentially small in `k`.

This file states the machine-independent core over i.i.d. Bernoulli random
variables: the Chernoff-type concentration bound [AB09, Cor 7.11] and the
majority-vote error bound instantiating [AB09, Thm 7.10]'s calculation.
Wrapping these into statements about `BPP`-style verifier classes is Tier B
work and lives elsewhere.

## Main results (sorry-stubbed)

* `Randomized.iid_bernoulli_avg_concentration` — [AB09, Cor 7.11].
* `Randomized.majority_error_le` — the calculation proving [AB09, Thm 7.10].

## Deviations from the source

* [AB09, Cor 7.11] is stated for abstract i.i.d. Boolean random variables
  `X₁,…,X_k` with `Pr[Xᵢ = 1] = p`; we realize them concretely as the product
  measure of `k` Bernoulli(`p`) distributions on `Fin k → Bool`, which is the
  same joint distribution.
* [AB09, Thm 7.10] is stated for polynomial-time PTMs, with
  `p = 1/2 + |x|^{−c}`, `k = 8|x|^{2d+c}` runs, and final bound `2^{−|x|^d}`;
  `majority_error_le` is its probabilistic content with `ε` in place of
  `|x|^{−c}`: plugging `δ = ε/2` into Cor 7.11 bounds the majority error by
  `e^{−(δ²/4)pk} = e^{−ε²pk/16}`, which for the book's parameters is at most
  `2^{−|x|^d}`.  The book's displayed intermediate step normalizes the sum by
  `1/n` where `1/k` is meant; we state it with `1/k`.

## References

* [AB09] S. Arora, B. Barak, *Computational Complexity: A Modern Approach*,
  Cambridge University Press, 2009.
-/

namespace Randomized

open MeasureTheory
open scoped NNReal ENNReal

/-- The joint distribution of `k` independent Bernoulli(`p`) trials, as a
measure on `Fin k → Bool`.  [AB09, Cor 7.11: "independent identically
distributed Boolean random variables"] -/
noncomputable def iidBernoulli (k : ℕ) (p : ℝ≥0) (hp : p ≤ 1) :
    Measure (Fin k → Bool) :=
  Measure.pi fun _ => (PMF.bernoulli p hp).toMeasure

/-- The number of successes among the `k` trials `ω`, as a real number. -/
def successCount {k : ℕ} (ω : Fin k → Bool) : ℝ :=
  ∑ i, if ω i then (1 : ℝ) else 0

/-- **Chernoff bound for i.i.d. Boolean trials** ([AB09, Cor 7.11]).
Let `X₁,…,X_k` be i.i.d. Boolean random variables with `Pr[Xᵢ = 1] = p`, and
`δ ∈ (0,1)`.  Then `Pr[|(1/k)Σᵢ Xᵢ − p| > δ] < e^{−(δ²/4)·p·k}`.

**Proof sketch.** The general Chernoff bound ([AB09, Thm A.18]; in Mathlib,
Hoeffding-type bounds for sub-Gaussian sums, `measure_sum_ge_le_of_iIndepFun`)
applied to the centered variables `Xᵢ − p` on each tail, with the
sub-Gaussian/variance parameter coming from `Xᵢ ∈ {0,1}` and mean `p`. -/
theorem iid_bernoulli_avg_concentration {p : ℝ≥0} (hp : p ≤ 1) {k : ℕ}
    (hk : 0 < k) {δ : ℝ} (hδ0 : 0 < δ) (hδ1 : δ < 1) :
    iidBernoulli k p hp {ω | δ < |successCount ω / k - (p : ℝ)|} <
      ENNReal.ofReal (Real.exp (-(δ ^ 2 / 4) * (p : ℝ) * k)) := by
  sorry

/-- **Majority-vote error reduction, Chernoff core** (the calculation proving
[AB09, Thm 7.10]).  If each of `k` i.i.d. trials succeeds with probability
`p ≥ 1/2 + ε`, the probability that at most half the trials succeed — i.e.
that the majority vote errs — is at most `e^{−ε²·p·k/16}`.

For [AB09, Thm 7.10]'s parameters `ε = |x|^{−c}`, `k = 8|x|^{2d+c}`, this is
at most `2^{−|x|^d}`.

**Proof sketch.** If at most half the trials succeed then
`(1/k)Σᵢ Xᵢ ≤ 1/2 ≤ p − ε/2`, so `|(1/k)Σᵢ Xᵢ − p| ≥ ε/2`; apply
Cor 7.11 with `δ = ε/2` (the boundary case `|·| = δ` is absorbed into the
non-strict bound). -/
theorem majority_error_le {p : ℝ≥0} (hp : p ≤ 1) {ε : ℝ} (hε : 0 < ε)
    (hpε : 1 / 2 + ε ≤ (p : ℝ)) {k : ℕ} (hk : 0 < k) :
    iidBernoulli k p hp {ω | 2 * successCount ω ≤ k} ≤
      ENNReal.ofReal (Real.exp (-(ε ^ 2 * (p : ℝ) * k) / 16)) := by
  sorry

end Randomized
