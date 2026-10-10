# ch7-fill gate — round 1 resolutions

Findings: `audits/ch7-fill-findings.md` (external cross-vendor auditor, over
`audits/ch7-fill-bundle.md` at `0c22ae33`, SHA-256
`00be8b1d71cf1e9512438c2b5ddfdf0987753c09e70ef4249b0636f61593e4b2`).

**Round result: 0 blockers, 0 majors, 2 minors, 2 notes → the fill gate CLOSES
on round 1** per `workflow.md` (gate closes on zero blockers/majors; minors and
notes are swept or adopted below). No formal statement was changed by any
resolution: every edit is comment-only, mechanically verified (comment-stripped
bytes identical) and re-elaborated green
(`EmitIterEmbed`/`EmitIterBody`/`PolyTimeBlockLoop`/`PClosure`/`PolyTimeModel`).

| # | Severity | Resolution |
|---|---|---|
| 1 | minor | **Swept.** `PolyTimeBlockLoop.lean` module summary no longer attributes `xorD` to the abandoned one-pass counter program; it now names the emit-iteration construction and records why the counter-program route was wrong (cannot pair bits across the encoding separator). |
| 2 | minor | **Swept (documentation option).** `EmitIterEmbed.lean`'s header and `Main results` no longer advertise `Turing.control_step`/`control_step'`; a note records that the control-step lemmas are `private` helpers of `EmitIterBody.lean`. The pack's scope row and the drift attestation's `EmitIterEmbed` row corrected to match. No export/move: nothing outside `EmitIterBody` consumes them, so the public API stays as delivered and audited. |
| 3 | note | **Adopted.** The `PClosure.lean` block-closure section comment now states the totalization explicitly: the three `mem_P_of_block*` sets are total extensions through the default projections (malformed words decided via their `([], [])` decode, not rejected); exact `anyVerifier`/`majorityVerifier`/`shiftOrVerifier` agreement is on encoded inputs, which is all `polyTimeModel` consumes; every `V`-query is a re-encoded valid pair, so nothing depends on `V` off valid encodings. Statements kept, as the auditor directs. |
| 4 | note | **Adopted.** `polyTimeComputable_emitIter` and `FinTM.exists_emitIterTM` docstrings now state that the envelope hypothesis covers *all* iterates, with the auditor's `g s = s ++ [false]` example of a naturally scheduled computation it excludes, and record the possible future scheduled-orbit generalization. The explicit hypothesis is preserved. |

Also corrected per the report's reconciliation: the pack's `Classes.lean` line
count (1,266 → 1,329; the stale pre-documentation-sweep number — the lint log
and the plan's closure row already carried 1,329).

**Dispositions the round leaves with the maintainer** (the auditor explicitly
made no maintainer-reserved decision): the `Classes.lean` split (proposed:
counting layer out, names/statements/imports preserved, affected tree
rechecked) remains open for the maintainer; the audit does not require it for
fidelity of the fill additions.

**Porting note** (`Shilun-Allan-Li:complexity/arora-barak-ch3-4`, which merged
this campaign at `0c22ae33`): the two branches' `PClosure.lean` differ
comment-only in the `lenEq_mem_P`/`lenLe_mem_P` docstrings — the **merged branch
carries the longer P0-round-1 finding-5 malformed-word documentation**, while
this fork branch still carries the shorter pre-P0 forms (an earlier revision of
this paragraph stated that direction backwards; corrected during the port, which
caught it). Port this sweep as its own delta (`9a90e7d~1..9a90e7d`), preserving
the merged branch's longer docstrings; no formal drift either way.
