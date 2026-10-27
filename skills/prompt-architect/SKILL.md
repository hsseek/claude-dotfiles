---
name: prompt-architect
description: Generate a ready-to-use prompt for a structured multi-agent debate about an engineering or technical decision. Use when the user wants help turning a problem into a debate prompt with clarifying questions, agent roles, and a final synthesis format.
---

# Prompt Architect

Turn the user's engineering or technical problem into a self-contained prompt
for bold-strategist, skeptic, and practical-engineer. Generate the prompt;
run the debate only if the user also requests execution.

## Clarify the problem

Ask numbered questions (Q1, Q2, Q3...) about missing information that could
materially change the decision. Group them by topic when useful, such as
geometry, loading, materials, constraints, or decision criteria.

For each question, offer one concrete suggested default and its reason:

**Q1.** What operating temperature should the analysis cover?
*Suggested default:* 20–30 °C — assuming an indoor, room-temperature environment.

Ask the user to correct or explicitly accept the proposed defaults, then wait
for their response. Do not treat silence as acceptance. Distinguish supplied
facts, accepted assumptions, and unresolved unknowns in the resulting prompt.
If the user has already supplied enough context, proceed to prompt generation.

## Generate the prompt

Write one complete, copyable prompt for the user's target tool. Include the
populated context and the following instructions inline so it can be used
without access to this conversation. Adapt the domain details to the actual
problem; do not invent dimensions, materials, or competing options.

### Context block

- Objective, options under consideration, and decision criteria.
- Assembly or system description, relevant dimensions, and materials.
- Loads, operating conditions, and environment.
- Constraints and known risks, numbered for reference.
- Supplied facts, accepted assumptions, and consequential unknowns.

### Agent definitions

- **bold-strategist:** Argue decisively for the strongest option and identify
  high-upside improvements.
- **skeptic:** Challenge assumptions and expose failure modes across the options.
- **practical-engineer:** Independently assess feasibility, then synthesize the
  debate into an actionable recommendation.

### Debate format

Instruct the coordinating agent to use actual delegation tools and the named
agent roles where available:

1. Give all three agents the same context, rules, and output requirements.
   Collect their independent first-round findings before sharing peer responses.
2. Give each agent both other agents' complete, attributed first-round findings.
   Require a response to at least one specific peer point, naming the agent and
   point, explaining agreement or disagreement, and stating whether the
   recommendation changes and why.
3. After collecting all second-round responses, give practical-engineer the
   context and all six attributed responses for final synthesis.

Require evidence, explicit assumptions, and relevant calculations to justify
conclusions. If delegation is unavailable or a response fails, report that
limitation and what remains incomplete; do not present simulated responses
as a completed multi-agent debate.

### Agent output format

Each agent's response in each round has exactly three sections:

1. **Core finding:** Two or three sentences stating its position.
2. **Key risks or caveats:** Evidence gaps, assumptions, and failure modes.
3. **Recommended option:** Rationale and, in round two, its response to peers.

### Final synthesis format

Require practical-engineer to produce:

- **Agent Findings Summary:** One short paragraph per agent explaining its
  position and distinctive contribution, preserving material disagreements.
- **Final Verdict:** Name the preferred option clearly when the evidence permits.
  If a decisive unknown prevents a defensible choice, make the recommendation
  conditional and identify the verification needed to resolve it.
- **Rationale:** At most five bullets explaining the decision, recommended
  modifications, and red flags in alternatives. Use a comparison table when
  options differ across several criteria.
- **Remaining Open Questions:** Only unresolved issues that could change the
  recommendation; state what to verify and the consequence of an adverse result.
