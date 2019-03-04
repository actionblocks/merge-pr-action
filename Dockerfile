FROM actionblocks/debian:jessie-slim

LABEL "com.github.actions.name"="Merge Pull Request Action"
LABEL "com.github.actions.description"="A step to merge a pull request using the GitHub API"
LABEL "com.github.actions.icon"="git-merge"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/actionblocks/merge-pr-action"
LABEL "homepage"="http://github.com/actionblocks/merge-pr-action"

# ENV ACTIONBLOCKS_PUBLISHTOKEN ""
# ENV ACTIONBLOCKS_ENTRYPOINT "/action/entrypoint.sh"

RUN apt-get update -y && \
    apt-get install --no-install-recommends -y jq curl ca-certificates && \
    rm -rf /var/lib/apt/lists/*

ADD entrypoint.sh /action/entrypoint.sh

ENTRYPOINT ["/action/entrypoint.sh"]
