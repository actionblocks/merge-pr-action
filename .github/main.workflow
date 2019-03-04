workflow "Merge Bot" {
  on = "issue_comment"
  resolves = ["Merge"]
}

action "actor-filter" {
  uses = "actions/bin/filter@master"
  args = ["actor", "mojombo", "defunkt", "pjhyett", "schacon"]
}

action "comment-filter" {
  uses = "actions/bin/filter@master"
  args = "issue_comment /merge"
}

action "Merge" {
  needs = ["actor-filter", "comment-filter"]
  uses = "./"
  args = ""
}
