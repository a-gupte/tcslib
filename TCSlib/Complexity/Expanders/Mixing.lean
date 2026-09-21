/-
Copyright (c) 2026 The TCSlib Authors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: TCSlib Contributors
-/
import TCSlib.Complexity.Expanders.Basic

set_option maxHeartbeats 0
set_option relaxedAutoImplicit false
set_option autoImplicit false

/-!
# The Expander Mixing Lemma

Arora–Barak's Lemma 7.37: in an `(n,d,λ)`-graph, the number of edges between
any two vertex sets `S` and `T` deviates from its "random-graph" expectation
`(d/n)|S||T|` by at most `λd√(|S||T|)`.

## Main results (sorry-stubbed)

* `Expander.inner_indicator_mulVec_le` — the normalized form
  `|𝐬ᵀA𝐭 − |S||T|/n| ≤ λ√(|S||T|)`, which is [AB09, Lem 7.37, eq. (2)].

## Deviation from the source

[AB09, Lem 7.37] is stated for the edge count `E(S,T)` of an `(n,d,λ)`-graph;
its proof immediately reduces to the equivalent normalized statement (2) about
the normalized adjacency matrix, `|𝐬A𝐭 − |S||T|/n| ≤ λ√(|S||T|)`, which no
longer mentions the degree.  We formalize (2) for an arbitrary symmetric
stochastic matrix with `λ(A) ≤ λ`; the book's form is recovered by
multiplying through by `d`, since `|E(S,T)| = d·𝐬ᵀA(G)𝐭` for the normalized
adjacency matrix of a `d`-regular multigraph (with edges counted with
multiplicity, and, as in the book's convention for `E(S,S̄)`-style counts,
orientation-sensitively).

## References

* [AB09] S. Arora, B. Barak, *Computational Complexity: A Modern Approach*,
  Cambridge University Press, 2009.
-/

namespace Expander

open Matrix Finset

variable {n : ℕ}

/-- The indicator vector `𝐬 ∈ ℝⁿ` of a finite set `S` of vertices:
`𝐬ᵢ = 1` if `i ∈ S` and `𝐬ᵢ = 0` otherwise.  [AB09, proof of Lem 7.37] -/
noncomputable def indicator (S : Finset (Fin n)) : EuclideanSpace ℝ (Fin n) :=
  (WithLp.equiv 2 (Fin n → ℝ)).symm fun i => if i ∈ S then 1 else 0

/-- **Expander Mixing Lemma**, normalized form.  For a symmetric stochastic
`A` with `λ(A) ≤ λ` and vertex sets `S, T`,

`|⟨𝐬, A𝐭⟩ − |S||T|/n| ≤ λ·√(|S||T|)`,

where `𝐬, 𝐭` are the indicator vectors of `S, T`.  For the normalized
adjacency matrix of a `d`-regular multigraph, `d·⟨𝐬, A𝐭⟩` is the number of
edges `|E(S,T)|`, so multiplying through by `d` gives the book's statement
`| |E(S,T)| − (d/n)|S||T| | ≤ λd√(|S||T|)`.  [AB09, Lem 7.37, via eq. (2)]

**Proof sketch.** By Lemma 7.40 (`Expander.exists_decomposition`), write
`A = (1−λ)J + λC` with `J` the all-`1/n` matrix and `‖C‖ ≤ 1`.  Then
`⟨𝐬, A𝐭⟩ = (1−λ)⟨𝐬, J𝐭⟩ + λ⟨𝐬, C𝐭⟩`.  The first term is `(1−λ)|S||T|/n`
since `⟨𝐬, J𝐭⟩ = |S||T|/n`; the second is at most `λ√(|S||T|)` in absolute
value by Cauchy–Schwarz and `‖C‖ ≤ 1`, since `‖𝐬‖₂ = √|S|` and
`‖𝐭‖₂ = √|T|`.  Combining, the deviation of `⟨𝐬, A𝐭⟩` from `|S||T|/n` is at
most `λ|S||T|/n + λ√(|S||T|) − λ|S||T|/n`; more precisely both bounds
`⟨𝐬,A𝐭⟩ ≤ |S||T|/n + λ√(|S||T|)` and `⟨𝐬,A𝐭⟩ ≥ |S||T|/n − λ√(|S||T|)`
follow, using `|S||T|/n ≤ √(|S||T|)` for the lower one. -/
theorem inner_indicator_mulVec_le {A : Matrix (Fin n) (Fin n) ℝ}
    (hA : IsSymmStochastic A) {lam : ℝ} (hlam : lambda A ≤ lam)
    (S T : Finset (Fin n)) :
    |inner ℝ (indicator S) (toCLM A (indicator T)) -
        (S.card * T.card : ℝ) / n| ≤
      lam * Real.sqrt (S.card * T.card) := by
  sorry

end Expander
