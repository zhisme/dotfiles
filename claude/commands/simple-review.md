---
description: Review a PR/MR yourself in one pass, post findings with gh/glab, reply with the link only
argument-hint: <PR/MR url or number>
---

Review this PR/MR and post the findings to it:
$ARGUMENTS

RULES
- Do it yourself in this session. Do not spawn subagents. Do not run /review,
  /code-review, or any other review skill or command.
- Read-only on code: never edit, commit, push, approve, or request changes.
- Use `gh` for github.com, `glab` for anything else (GitLab). If the argument
  is a bare number, use the current repo's remote to decide.

STEPS
1. Fetch metadata and the diff (`gh pr view` + `gh pr diff`, or
   `glab mr view` + `glab mr diff`). Note the head SHA.
2. Read the connected code, not only the diff: callers of changed functions,
   tests, config, migrations the change touches.
3. Look for real caveats: bugs, unhandled errors and edge cases, nil/empty
   inputs, races, security holes, data loss, breaking changes for callers,
   missing or happy-path-only tests. Skip style nits and taste.
4. Verify each finding against the code before keeping it. Drop anything you
   can't point to a concrete failure scenario for.
5. Post:
   - One inline comment per finding, anchored to the exact line in the diff.
     GitHub: a single review via
     `gh api repos/{owner}/{repo}/pulls/{n}/reviews` with `event: COMMENT`
     and a `comments` array. GitLab: one discussion per finding via
     `glab api projects/:id/merge_requests/:iid/discussions` with a `position`
     (base_sha, start_sha, head_sha from the MR's diff_refs).
   - If a finding can't be anchored to a diff line, put it in one general
     comment instead.
   - If there are no findings, post one short comment saying so.
   - Comment style: terse, one finding per comment, what breaks and when.
     No praise, no summary of the PR.
6. Confirm the comments exist by listing them back from the API.

OUTPUT
Reply with only the link(s) to the posted review/comments and the count
posted. No summary of findings in chat. If posting failed, show the command
and the error.
