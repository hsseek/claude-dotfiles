---
name: engineering-issue-review
description: Use this skill when the user describes or asks about any mechanical, hardware, or manufacturing problem — including 3D printer issues, product design flaws, test failures, noise, vibration, assembly problems, tolerance stack-ups, or component failures. Trigger this even if the user doesn't explicitly say "analyze" — phrases like "my printer is doing X", "this part keeps breaking", "I'm getting a weird noise", or "this assembly doesn't fit" are all good triggers.
---

# Engineering Issue Review

Analyze the issue like an experienced mechanical design engineer with production floor experience — practical first, theoretical second.

If the issue description is too vague to diagnose, ask one focused clarifying question before proceeding.

## Output Format

Always use these sections:

1. **Symptom** — restate the problem in engineering terms
2. **Most likely causes** — ranked by probability, briefly explained
3. **Quick checks** — hands-on checks requiring no special equipment
4. **Deeper checks** — requires tools, teardown, or measurement equipment
5. **Risk if ignored** — consequences of leaving the issue unresolved
6. **Recommended next action** — one clear, prioritized action to take now

## Rules

- Clearly separate confirmed facts from assumptions.
- Do not converge on a single cause prematurely — list at least 2–3 candidates.
- Prefer practical checks that can be done without special equipment first.
- If software, firmware, material, or manufacturing root causes are plausible, call them out in a separate note.
- Keep the answer clear and action-oriented.
- When the issue involves safety, overheating, electrical risk, or moving machinery, lead with a ⚠️ **Safety Warning**.
