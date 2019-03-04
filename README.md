# Merge Pull Request Action

A GitHub Action that will merge a pending pull request if certain users comment with a `/merge` message. The user issuing the comment must be defined in the workflow.

## Quick Start

Create a `.github/main.workflow` file:

```
workflow "Merge Bot" {
  on = "issue_comment"
  resolves = ["Merge"]
}

action "actor-filter" {
  uses = "actions/bin/filter@master"
  args = ["actor", "your-github-username", "another-github-username"]
}

action "comment-filter" {
  uses = "actions/bin/filter@master"
  args = "issue_comment /merge"
}

action "Merge" {
  needs = ["actor-filter", "comment-filter"]
  uses = "./"
  args = ""
  secrets = [
    "GITHUB_TOKEN"
  ]
}
```

## Why?

You could add additional filters to limit this more, or define the list of users elsewhere. In large projects, sometimes you want to delegate a subset of merge capabilities to users, without giving everyone Admin access. This is a way to allow certain users to merge by comment, without having Admin rights to the repo.
