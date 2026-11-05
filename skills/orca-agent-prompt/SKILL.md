---
name: orca-agent-prompt
description: Turn a task or objective into a ready-to-paste Orca coordinator prompt with agent assignments, model selection, ownership, dependencies, and acceptance criteria. Optionally execute the approved plan through Orca Runs and workers when requested.
---

# Orca agent prompt

Produce a self-contained coordinator prompt for the user's actual objective. Default to prompt generation; execute only when the user requests execution. A request to write a prompt does not authorize launching agents.

## Establish the task

Respect the current user's skill-permission and Git instructions. Read applicable AGENTS.md and relevant workspace Markdown/configuration before asking for information they already contain. Treat old handoffs as historical evidence, not current runtime facts. Do not restore deleted files or change project configuration as part of discovery.

Clarify consequential gaps before finalizing assignments: desired outcome, repository or folder, host, deliverables, constraints, acceptance criteria, and execution intent. Ask concise grouped questions; do not invent missing requirements, file paths, model IDs, or approvals. If discovery is unavailable, provide clearly marked unresolved fields in a draft and require resolution before dispatch.

Read [references/personal-environment.md](references/personal-environment.md) when using the user's xps9560 hybrid environment. Do not impose its hardware limits on unrelated environments.

## Design the assignments

Use the smallest useful team. Assign bounded mechanical work or focused tests to a capable small local model; assign complex implementation, integration, and coordination to a stronger verified model. Explain each assignment briefly. Do not add a review agent unless independent review helps assess the result. Do not force parallelism when work is inherently sequential.

Identify independent waves and actual dependencies. Tests may be drafted alongside implementation when their interface is agreed, but final integration checks must wait for implementation. Give each editable file or directory one owner per wave; designate an integration owner for shared changes. Workers must preserve other contributors' edits. For non-code tasks, define artifact and decision ownership instead.

For every task include ID, role, agent backend, exact verified model ID (or an explicit unresolved field), target, change, read context, editable ownership, do-not-touch boundaries, dependencies, observable acceptance, and completion evidence. Keep worker specs self-contained and small enough for the assigned model.

Use these defaults unless the user explicitly changes them: show the plan and exact model IDs before dispatch; one attempt per task; no automatic retries, paid fallback, recursive delegation, commits, or pushes. A failed acceptance check is a reported failure, not permission to disguise a retry as a new task. Explicit user authorization can change a default, but must be reflected in the plan.

## Return the prompt

Return one ready-to-paste prompt in a fenced block, preceded only by material unresolved questions or a brief assignment rationale. Write to the coordinator as “you.” Include:

1. Objective, concrete deliverables, scope boundaries, and definition of done.
2. Project/workspace, execution host, coordinator backend/model, and verification requirements. For Mobile supervision in this user's setup, require the coordinator and new Run on xps9560. If the project exists only on the laptop, stop for server setup; do not remotely launch workers from a laptop-owned Run.
3. A compact task table with exact model IDs, ownership, dependencies, and acceptance criteria, followed by self-contained worker specs.
4. A gate requiring the coordinator to present the resolved plan, models, host, ownership, tests, and needed permissions before dispatch, then wait for approval. Reuse approval already given for that exact plan; material changes need approval.
5. Execution instructions: load the installed version-matched Orca orchestration guide; verify host and workspace; create a fresh Run for the objective and launch tasks through `orchestration worker-start`. Opening tabs manually or using generic subagent tools does not satisfy this request. Preserve the Run, Task, and Dispatch IDs returned by Orca.
6. Supervision and completion: follow live injected worker preambles, process questions and completion reports before acknowledging deliveries, validate actual artifacts and acceptance evidence, settle tasks, and release workers only after accepted settlement. Report uncertainty without inventing success or killing unverified processes.
7. A final report naming each task's outcome, files/artifacts, test evidence, Run ID, blockers, and worker cleanup or retention state. Do not claim Mobile supervision was tested unless actually observed.

Prompts must remain portable: include the necessary constraints explicitly instead of requiring the receiving coordinator to have this skill or the original conversation. Do not hard-code old runtime, Run, Task, Dispatch, or terminal IDs. Describe runtime discovery rather than guessing unsupported CLI flags.

## Optional execution

When execution is requested, first produce the concrete prompt and plan, then follow [references/execution.md](references/execution.md). Honor the approval gate before dispatch. Do not launch a sample Run merely to test this skill.
