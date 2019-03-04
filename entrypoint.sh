#!/bin/bash

set -e

EVENT_FILE=${EVENT_FILE}
if [ -z "$EVENT_FILE" ]; then
  EVENT_FILE="/github/workflow/event.json"
fi

# Get the issue nbyumber from the event
ISSUE_NUMBER=$(cat $EVENT_FILE | jq -r .issue.number)

echo "Issue Number: ${ISSUE_NUMBER}"

# Build the URL to ge the PR
GET_PULLREQUEST_URL=$(cat $EVENT_FILE | jq -r .repository.pulls_url | sed  -e "s/{\/number}/\/$ISSUE_NUMBER/g")

echo "Pull Request URL: ${GET_PULLREQUEST_URL}"

# Fetch the PR data
PULL_DATA=$(curl -s -S -H "Authorization: token $GITHUB_TOKEN" --header "Content-Type: application/json" "$GET_PULLREQUEST_URL")
IS_MERGED=$(echo $PULL_DATA | jq -r .merged )

# Exit if already merged
# if $IS_MERGED; then
#   echo "Pull request is already merged."
#   exit 0
# fi

# We now have a merge URL
MERGE_URL="$GET_PULLREQUEST_URL/merge"
MERGE_RESULT=$(curl -X PUT -s -S -H "Authorization: token $GITHUB_TOKEN" --header "Content-Type: application/json" "$MERGE_URL")
echo $MERGE_RESULT

# Merge


