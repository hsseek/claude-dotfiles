---
name: orca-agent-prompt
description: Turn an abstract goal into a ready-to-paste OpenCode coordinator prompt for Orca orchestration, with numbered Plan questions, difficulty-based model assignments, and Build execution with elevated permissions. Execute only when requested.
---

# Orca agent prompt

Generate one self-contained prompt addressed to OpenCode as coordinator. Orca is the orchestrator: it manages Runs, tasks, worker dispatch, dependencies, and lifecycle. OpenCode clarifies the goal, decomposes work, assigns models, supervises workers through Orca, and checks results. Worker agents perform bounded subtasks through verified backends, including advanced hosted models and cheaper hosted or local models.

Default to prompt generation. A request for a prompt does not authorize launching agents or changing runtime configuration. A short, abstract goal is valid input; the generated prompt must turn it into actionable work through OpenCode's Plan phase.

## Prepare the prompt

Respect the user's skill-permission and Git instructions. Read applicable AGENTS.md and relevant workspace configuration before asking for facts they already contain. Treat historical notes as context, not current runtime facts. Do not restore deleted files or change project configuration during discovery.

Capture the goal faithfully, known constraints, and existing answers. Ask the current user only about gaps that prevent producing the right coordinator prompt; put project discovery and detailed requirement questions into the generated Plan phase. Do not require the user to complete the entire planning interview before receiving the prompt. Label preliminary subtasks and unknowns explicitly; never invent requirements, paths, model IDs, or approvals.

Read [references/personal-environment.md](references/personal-environment.md) when targeting the user's xps9560 hybrid environment. Include relevant constraints explicitly in the output; do not require the receiving coordinator to have this skill or the original conversation.

## Plan phase: discover the requirements

The generated prompt must instruct OpenCode to begin in Plan mode and perform read-only discovery. No implementation workers, repository edits, or Run execution during Plan. Verify the installed Orca guide, execution host/workspace, available backends/models, and supported permission controls without mutating configuration.

Ask numbered questions in small, coherent rounds. Each question must include a suggested default answer, a short reason the decision matters, and alternatives when useful. Keep numbering stable across rounds so the user can answer by number. Example: “1. Who will use this? Default: only you. This determines whether accounts and shared access are needed.” Defaults are proposals, never silently accepted facts. Let the user accept all defaults explicitly or override individual answers. An unanswered question or elapsed time is not acceptance.

Use questions to surface decisions the user may not know are relevant: intended users and workflows, success criteria, deliverables, existing systems/data, constraints, exclusions, execution host, cost/provider limits, and acceptance checks. Ask only relevant questions and skip facts already established. Explain tradeoffs in plain language. Incorporate answers, identify contradictions, and ask focused follow-ups until consequential gaps are resolved. Present provisional subtasks to make implications concrete, then refine them from the answers.

Before Build, show a concise resolved plan with deliverables, task ownership/dependencies, exact model IDs and rationale, cost/resource limits, checks, and permission scope. Once the user's answers resolve the plan, proceed without a separate “approve the plan” question. Respect an explicit request to remain in Plan. If switching modes requires a UI action, tell the user exactly what is needed; do not claim the mode changed or execute Build actions while Plan restrictions remain active.

## Assign work by difficulty and cost

Use the smallest useful team and the least expensive verified model capable of meeting each task's acceptance criteria. Judge ambiguity, reasoning depth, context size, integration risk, and cost of mistakes, not only task length.

- Advanced models: difficult reasoning, architecture, ambiguous debugging, complex implementation, and consequential integration/review. GPT-6-Astra is an example of the desired capability tier, not a guaranteed model ID or backend.
- Cheaper hosted models: well-specified implementation, bounded refactoring, and focused test work when their capabilities suffice. DeepSeek is an example family, not a fixed catalog entry.
- Small local models: narrow mechanical edits, extraction, or simple checks with compact context and independently verifiable outputs. Ollama is a serving backend; choose an actual available model ID.

Distinguish backend, provider, model ID, and reasoning setting. Resolve exact IDs and supported controls from the current catalog/installed guide before dispatch. Do not assume ChatGPT subscription access implies an API model or that a model name implies free service. Unknown pricing, unavailable required models, or missing cost limits are Plan questions. Do not silently substitute a paid provider. Keep the OpenCode coordinator's own model selection explicit and verified.

Partition work into independent waves and real dependencies. Give each editable file/directory one owner per wave and designate the integration owner for shared changes. Workers must preserve others' edits. For non-code work, assign artifact and decision ownership. Final integration checks depend on completed implementation. Add independent review only when it materially improves confidence; do not force parallelism.

For every task include ID, purpose, difficulty/routing rationale, backend and exact model ID, target/change, necessary read context, editable ownership and do-not-touch boundaries, dependencies, observable acceptance, and completion evidence. Keep worker briefs self-contained and small enough for the assigned model. Workers report consequential unknowns to OpenCode, which consolidates numbered user questions instead of inventing answers.

## Build phase: permissions and execution

The generated prompt must request the broadest supported execution permissions for the coordinator and workers within the resolved task scope. Configure these through verified session/dispatch controls before launching work, so routine edits, commands, and checks do not repeatedly ask for permission. Inspect the effective settings for each backend; permission inheritance must not be assumed. Scope changes to the task/session rather than weakening unrelated global settings.

Prompt text cannot grant operating-system, sandbox, or platform permissions. Preserve mandatory platform approvals, and require confirmation for destructive or external actions. Do not commit or push without an explicit user request. If elevation requires a platform approval or launch setting, surface that concrete prerequisite together before dispatch where possible. Do not bypass restrictions or claim workers will never prompt. Reuse existing authorization within its scope instead of repeatedly requesting it.

Load the installed version-matched Orca orchestration guide and discover supported commands/flags. Create a fresh Run for the objective and dispatch through Orca's supported orchestration worker-start flow. Manually opening tabs or generic subagent tools does not satisfy Orca orchestration. Preserve the returned Run, Task, and Dispatch IDs. For Mobile supervision in the user's hybrid setup, the coordinator and Run must be on xps9560; resolve missing server setup before dispatch.

Unless the user changes these limits during Plan, use one attempt per task, no automatic retries, paid fallback, or recursive delegation. Include these limits in the resolved plan. A failed acceptance check is a reported failure, not permission to disguise a retry as a new task. Ask a focused question when a failure needs a new attempt, different model, extra spending, or changed scope; do not reopen settled decisions.

Follow live worker preambles and Orca's supervision/settlement rules. Process worker questions and completion reports before acknowledging deliveries; verify artifacts and acceptance evidence, settle tasks, then release workers. Report uncertainty without inventing success or killing unverified processes. Finish with task outcomes, files/artifacts, check evidence, Run ID, blockers, and worker cleanup/retention state. Do not claim Mobile supervision was tested unless observed.

## Output contract

Return one ready-to-paste fenced prompt, with at most a brief rationale outside it. Address OpenCode as “you” and include:

1. The user's goal, known context, constraints, and the Orca/OpenCode/worker roles.
2. Explicit Plan and Build instructions, numbered question/default format, and the transition rule above.
3. Provisional decomposition where possible, followed by instructions to resolve it into a task table and self-contained worker briefs after the interview. Exact model IDs may remain marked as unresolved in this initial prompt but must be verified before dispatch.
4. Model routing, host/resource/cost constraints, ownership, dependencies, acceptance criteria, and permission behavior.
5. Version-matched Orca discovery, execution, supervision, completion, and failure handling.

Keep the prompt proportional to the goal and portable. Include necessary constraints rather than references to unavailable conversation history. Never hard-code historical Run/Task/Dispatch/terminal IDs or guess unsupported CLI flags. The output must be usable from a one-sentence goal without pretending that requirements are already settled.

## Optional execution

Execute only when the user explicitly requests it. First produce the concrete coordinator prompt, then follow [references/execution.md](references/execution.md). Use the same Plan questions, resolved-plan transition, and Build permission boundary. Do not launch a sample Run merely to test this skill.
