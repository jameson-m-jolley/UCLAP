# Contributing to UCLAP

> **Note:** This file was AI-generated and vetted by the author, in line with
> the AI-assistance-only policy set out below. The design and the Uiua code it
> references remain human-authored.

Thanks for your interest in contributing! Please read this file before opening
a PR. It keeps the project healthy and consistent.

## Code of Conduct

Be respectful and constructive. Harassment, trolling, or dismissive behavior is
not tolerated. Everyone is expected to cooperate regardless of experience level.

## AI Assistance Policy (Read First)

This project follows an **AI-assistance-only** policy. **No vibecoding.**

- AI tools (assistants, co-pilots, generators) may be used as **assistants** to
  help you write, review, explain, or debug code.
- **No unvetted AI output may land in the codebase.** Every line that originates
  from an AI must be reviewed, understood, and approved by a human before being
  committed.
- **AI-generated code must carry a comment naming the model that produced it**
  (for example `# generated with <model name>`). Human-written code does not
  need such a comment. This makes every AI contribution auditable.
- **Doc-string provenance block.** When AI assists with a doc comment, the doc
  string must end with a `>provence:` attribution block naming both origins,
  for example:

  ```
  # ApplyColor takes
  #
  # 1. `color` - an ANSI escape sequence (a string)
  # 2. `text` - a string to wrap in color
  #
  # >provence:
  # >>documentation generated with `opencode (model: laguna-s-2.1-free)`
  #
  # >>code generated with `human`
  ApplyColor ← (˜⊂ Reset ⊂)
  ```

  - `>>documentation` names what produced the doc comment.
  - `>>code` names what produced the binding itself (`human` when hand-written).
  - Place the `>provence:` block at the **bottom** of the doc string. A doc
    comment that reads as AI-authored and lacks this block (or leaves
    `>>code` attributed to AI when it was hand-written) is unvetted AI output.
- Any PR whose content the author cannot fully explain, test, and defend will be
  rejected.
- **Violating this policy, or attempting to hide AI-generated code as your own,
  results in a permanent ban from this codebase.** A ban means you will never be
  able to submit a pull request against this project again.

Read the existing code, understand it, and be able to walk someone through your
changes. If a PR is described as "trust me, the model said it works," it fails
review and will result in a permanent ban from this codebase — meaning you will
never be able to submit a PR again.

## Understanding the Strict AI Policy

Why is the policy so strict? Because an AI that writes code you do not
understand is not saving you time — it is producing debt you cannot pay off,
test, or explain to the next contributor.

This project values people, **correct code**, and **integrity** — not the
software equivalent of a quick fix and a white lie. Every function in `main.ua`
was designed and written by a person who can reason about the token types, the
tokenizer regex, and how the legacy `key=value` parser behaves. AI output that
skips that step quietly breaks the project for everyone else.

A few mental models that help it stick:

- **AI is a reviewer, not an author.** It is strongest at spotting bugs,
  suggesting alternatives, and explaining unfamiliar behavior. When it becomes
  the author, it defeats the point of the policy.
- **You are accountable for every merge.** Ship a change, be able to explain
  it end to end. That is the unit of transparency this project runs on.
- **Model comments are a feature, not a confession.** Naming the model in a
  comment is not admitting weakness. It is how a codebase stays transparent
  about where every line came from.
- **Respect other people's time.** PRs take time — yours to write and theirs to
  read. What is disrespectful is pushing **unchecked** code and then being
  unable to answer questions about it. If you open a PR, you owe the reviewer
  prompt, honest answers to every line you touched. Not knowing something is
  fine — nobody knows everything. But if your answer to "why does this work?"
  is "the AI said so," you can take a hike. That is not an answer, it is a way
  of admitting you never understood the change, and it disqualifies you from
  committing to this codebase.

If you are not sure whether something counts as "vibecoding," ask: would I be
able to tell a maintainer plainly which lines I wrote and which a model wrote?
If not, it stays out.


## Who Gets to Commit

This is real, working code — UCLAP was written and tested by hand, carefully,
over time. Changing it is not a chore to grab for résumé points or a sandbox for
unsupervised tooling. It is a responsibility.

We trust honest people. Concretely, that means people who can tell you plainly,
for every line they touch: what it does, why, and — if a model helped — which
model. That honesty is the whole basis for trusting anyone with a commit here.

We do not trust people who have no business changing this code: contributors who
cannot explain their own diff, who pass off generated work as their own, or who
treat a project someone else took care to make work as a playground. If you
cannot stand behind the change, not only as correct but as honestly yours to
make, then this codebase is not the place for it.

If you are honest, careful, and you genuinely understand the code, you are very
welcome here. If you are none of those things, stay out of a codebase that
someone worked hard to make work.

## Getting Started

1. Fork the repo and clone your fork.
2. Create a branch for your work:

   ```bash
   git checkout -b feature/your-feature
   ```

3. Make your changes, focused on a single logical unit.

## Development Workflow

1. **Understand the module layout before editing.** The code is organized into
   Uiua modules — `tools` (color helpers), `core` (lexer/parser), and `legacy`
   (basic `key=value` parser).
2. **Make small, focused changes.** Prefer several small PRs over one large one.
3. **Write or update tests.** There is a test file under `tests/` and examples
   under `examples/`. Add a test that exercises your change.
4. **Run the tests**:

   > **TODO:** `uiua run` doesn't run the `┌─╴test` blocks (no output) —
   > use `uiua test tests/tokenize.ua`. (noted by opencode/big-pickle)

   ```bash
   uiua run tests/tokenize.ua
   ```

5. **Vet the change yourself.** Re-read your diff, confirm you understand every
   line, and confirm the behavior is intentional.

## Test-Driven Development

This project recommends **test-driven development (TDD)**: write the test
first, see it fail, then write the code that makes it pass.

The existing `tests/tokenize.ua` shows the pattern — assertions are written
with `˙⍤` and print whether they pass:

> **TODO:** `uiua run` doesn't run the tests (no output) — use
> `uiua test tests/tokenize.ua`. (noted by opencode/big-pickle)

```bash
uiua run tests/tokenize.ua
```

Why TDD is a good fit specifically for Uiua:

- **It grows your program backward.** A Uiua program is built out of tiny
  primitives composed into boxes and rows. If you start with the shape of the
  input and the shape of the output, the composition in the middle almost
  designs itself. TDD forces you to pin down that input/output shape first.
- **It catches the "it's just symbols" trap.** Uiua is dense, and it is easy to
  read a chain of glyphs and believe it is correct even though the stack shape
  is off. A failing test won't let you rationalize it away — it forces you to
  actually trace the stack.
- **It chases the bug while the context is fresh.** If you write the code first
  and it misbehaves, you debug a black box and design. If you write the test
  first, you are already expecting a specific shape, so the failure tells you
  exactly where your model of the problem was wrong.
- **It keeps humans honest, which is this project's whole policy.** A test says
  what the code should do in a form anyone can run. An AI contribution that is
  tested is far easier to vet than one that is merely described.

So: red, green, refactor — and if a change is made, a failing test should have
existed first to demonstrate exactly what the change fixes.

## Coding Conventions

- Follow the existing style and idioms in `main.ua` and the tests.
- Uiua is an array language: prefer idiomatic array/boxed operations over
  verbose imperative-style workarounds.
- Add comments where a transformation is non-obvious.
- Do not introduce external dependencies unless absolutely necessary (the
  tokenizer deliberately avoids them).

## Commit Messages

Write clear, imperative-style commit messages that describe **why**:

```
Add MatchToken to the core lexer
```

Separate formatting-only or whitespace changes from behavior changes.

## Pull Request Checklist

Before submitting a PR, confirm:

- [ ] It addresses a single concern
- [ ] Tests pass (`uiua run tests/tokenize.ua`) — TODO: use `uiua test tests/tokenize.ua`; `uiua run` doesn't run the test blocks (noted by opencode/big-pickle)
- [ ] New behavior is covered by a test
- [ ] The change follows existing conventions
- [ ] You can fully explain and defend every part of the change
- [ ] No unvetted AI-generated code is included

## License

By contributing, you agree that your contributions are licensed under the same
terms as the project.