# Execute an approved coordinator prompt

Execution means supervised Orca coordination. Use the installed orchestration skill if available, subject to the user's skill permissions. Its version-matched runtime guide is authoritative for commands and lifecycle behavior.

Resolve the CLI once: use `ORCA_CLI_COMMAND` if set; otherwise `orca-dev` in a dev session exposing `ORCA_DEV_REPO_ROOT`; otherwise `orca-ide` on Linux outside an Orca-managed terminal; otherwise `orca`. Never invoke bare `orca` on unmanaged Linux, where it may be the GNOME screen reader. Reuse the selected executable; if it fails, report the exact error rather than switching builds.

Load `<selected executable> skills get orchestration` before runtime actions. Load its coordinator-loop reference for model selection/DAG work, placement-and-remote reference for server placement, and recovery-and-cleanup reference only if needed. Resolve unknown flags with installed help. If the guide is unavailable, perform only supported read-only discovery and report the missing capability; do not invent commands. A runtime_access_denied error requires sandbox escalation, not a runtime restart.

Verify project location, host, cwd, current model catalog, allowed providers/cost, and available resources. Present the concrete plan and exact models. Wait for the required approval before creating/dispatching the planned work. Do not treat silence or elapsed time as approval. If the host is wrong, stop for the correct server session/setup rather than changing placement semantics.

Create the Run through `orchestration run-create`; create tasks/attempts through `orchestration worker-start` using the installed guide's supported model and workspace arguments. Use explicit task dependencies where needed. Keep returned IDs and receipts, and start the independent approved wave before waiting. A failed start may leave resources: inspect its receipt; do not relaunch under the one-attempt policy.

Supervise through Orca's mailbox and worker records. Follow the guide's acknowledgment and settlement rules, including matching completion to the active Dispatch and checking acceptance artifacts. Timeout, missing output, and lost contact do not prove exit. Do not retry, abandon, stop, or release solely because observations are unavailable. Workers must follow their injected preamble for heartbeat, check, ask, and worker_done commands and outcome fields.

After accepted settlement, release each worker, or record explicit authorized retention/reuse according to the guide. Investigate uncertain cleanup through the receipt's recovery instructions; do not force-close terminals. Finish when all expected attempts have explicit outcomes and cleanup decisions, or report a concrete blocker with the unresolved lifecycle state. Report Run/Task/Dispatch IDs and evidence without claiming unobserved execution or Mobile behavior.
