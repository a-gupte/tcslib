/-
Copyright (c) 2026 The TCSlib Authors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: TCSlib Contributors
-/
import Mathlib.Algebra.MvPolynomial.SchwartzZippel

set_option maxHeartbeats 0
set_option relaxedAutoImplicit false
set_option autoImplicit false

/-!
# The Schwartz–Zippel lemma, Arora–Barak form

Arora–Barak's Lemma 7.5, the probabilistic tool behind polynomial identity
testing: a nonzero integer polynomial of total degree at most `d` evaluates
to a nonzero value with probability at least `1 − d/|S|` when its arguments
are drawn independently and uniformly from a finite set of integers `S`.

Mathlib already proves the core inequality
(`MvPolynomial.schwartz_zippel_totalDegree`, over any integral domain, in the
sharp "count the zeros" form); this file only restates it in the book's form,
so the lemma is *reused*, not re-proved.

## Main results (sorry-stubbed)

* `Randomized.schwartz_zippel` — [AB09, Lem 7.5].

## Deviations from the source

* [AB09, Lem 7.5] samples `a₁, …, a_m` "randomly with replacement from `S`"
  and bounds `Pr[p(a₁,…,a_m) ≠ 0] ≥ 1 − d/|S|`.  Uniform sampling with
  replacement of the tuple is the uniform distribution on `S^m`, so the
  probability is the counting ratio `#{a ∈ S^m | p(a) ≠ 0} / |S|^m`; we state
  the bound as that ratio, valued in `ℚ≥0` (with truncated subtraction, which
  makes the statement trivially true — and still correct — when `d ≥ |S|`).
* The book leaves implicit that `p` is not the zero polynomial (otherwise the
  claim fails); `hp` makes this explicit.

## References

* [AB09] S. Arora, B. Barak, *Computational Complexity: A Modern Approach*,
  Cambridge University Press, 2009.
-/

namespace Randomized

open MvPolynomial Finset Fintype

/-- **Schwartz–Zippel lemma** ([AB09, Lem 7.5]).  Let `p(x₁,…,x_m)` be a
nonzero integer polynomial of total degree at most `d` and `S` a nonempty
finite set of integers.  When `a₁,…,a_m` are chosen independently and
uniformly from `S`, then `Pr[p(a₁,…,a_m) ≠ 0] ≥ 1 − d/|S|`, stated as the
counting ratio over all of `S^m`.

**Proof sketch.** The complementary count is
`MvPolynomial.schwartz_zippel_totalDegree`:
`#{a ∈ S^m | p(a) = 0}/|S|^m ≤ totalDegree p/|S| ≤ d/|S|`; subtract from `1`
and split `S^m` into zeros and non-zeros of `p`. -/
theorem schwartz_zippel {m : ℕ} {p : MvPolynomial (Fin m) ℤ} (hp : p ≠ 0)
    {d : ℕ} (hd : p.totalDegree ≤ d) (S : Finset ℤ) (hS : S.Nonempty) :
    (1 : ℚ≥0) - d / S.card ≤
      ({f ∈ piFinset fun _ : Fin m => S | eval f p ≠ 0}.card : ℚ≥0) /
        (S.card ^ m : ℚ≥0) := by
  sorry

end Randomized
