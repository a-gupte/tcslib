/-
Copyright (c) 2026 The TCSlib Authors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: TCSlib Contributors
-/
import TCSlib.Complexity.Randomized.SchwartzZippel
import TCSlib.Complexity.Randomized.ErrorReduction

/-!
# Randomized Computation

Model-free results from Arora–Barak Chapter 7 (Randomized Computation): the
probabilistic tools that the chapter's complexity-class theorems are built
on.  Verifier-style definitions of the classes `BPP`/`RP`/`coRP`/`ZPP` and
the theorems about them are planned as a separate layer on top of this one.

## Contents

- `Randomized.SchwartzZippel`: the Schwartz–Zippel lemma in Arora–Barak's
  form ([AB09, Lem 7.5]), restated from Mathlib's
  `MvPolynomial.schwartz_zippel_totalDegree`.
- `Randomized.ErrorReduction`: the Chernoff bound for i.i.d. Boolean trials
  ([AB09, Cor 7.11]) and the majority-vote error bound that is the
  calculation inside the error-reduction theorem ([AB09, Thm 7.10]).

## References

* [AB09] S. Arora, B. Barak, *Computational Complexity: A Modern Approach*,
  Cambridge University Press, 2009.
-/
