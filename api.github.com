{
  "current_user_url": "https://api.github.com/user",
  "current_user_authorizations_html_url": "https://github.com/settings/connections/applications{/client_id}",
  "authorizations_url": "https://api.github.com/authorizations",
  "code_search_url": "https://api.github.com/search/code?q={query}{&page,per_page,sort,order}",
  "commit_search_url": "https://api.github.com/search/commits?q={query}{&page,per_page,sort,order}",
  "emails_url": "https://api.github.com/user/emails",
  "emojis_url": "https://api.github.com/emojis",
  "events_url": "https://api.github.com/events",
  "feeds_url": "https://api.github.com/feeds",
  "followers_url": "https://api.github.com/user/followers",
  "following_url": "https://api.github.com/user/following{/target}",
  "gists_url": "https://api.github.com/gists{/gist_id}",
  "hub_url": "https://api.github.com/hub",
  "issue_search_url": "https://api.github.com/search/issues?q={query}{&page,per_page,sort,order}",
  "issues_url": "https://api.github.com/issues",
  "keys_url": "https://api.github.com/user/keys",
  "label_search_url": "https://api.github.com/search/labels?q={query}&repository_id={repository_id}{&page,per_page}",
  "notifications_url": "https://api.github.com/notifications",
  "organization_url": "https://api.github.com/orgs/{org}",
  "organization_repositories_url": "https://api.github.com/orgs/{org}/repos{?type,page,per_page,sort}",
  "organization_teams_url": "https://api.github.com/orgs/{org}/teams",
  "public_gists_url": "https://api.github.com/gists/public",
  "rate_limit_url": "https://api.github.com/rate_limit",
  "repository_url": "https://api.github.com/repos/{owner}/{repo}",
  "repository_search_url": "https://api.github.com/search/repositories?q={query}{&page,per_page,sort,order}",
  "current_user_repositories_url": "https://api.github.com/user/repos{?type,page,per_page,sort}",
  "starred_url": "https://api.github.com/user/starred{/owner}{/repo}",
  "starred_gists_url": "https://api.github.com/gists/starred",
  "topic_search_url": "https://api.github.com/search/topics?q={query}{&page,per_page}",
  "user_url": "https://api.github.com/users/{user}",
  "user_organizations_url": "https://api.github.com/user/orgs",
  "user_repositories_url": "https://api.github.com/users/{user}/repos{?type,page,per_page,sort}",
  "user_search_url": "https://api.github.com/search/users?q={query}{&page,per_page,sort,order}"
}

1. retrieves information about user:
  curl https://api.github.com/users/<USER-NAME>
  So, to list all public repos from a user, send a GET request to https://api.github.com/users/<USER-NAME>/repos, replacing <USER-NAME> with the actual user from whom you want to retrieve the repositories.

2. listing all public repositories belonging to a given user:
  curl https://api.github.com/users/<USER-NAME>/repos
  So, to list all public repos from a user, send a GET request to https://api.github.com/users/<USER-NAME>/repos, replacing <USER-NAME> with the actual user from whom you want to retrieve the repositories.

3. list all public repositories belonging to an given organization:
  https://api.github.com/orgs/<ORGANIZATION-NAME>/repos
  For instance, to list repositories belonging to the Node.js organization, you'd do this:
  curl https://api.github.com/orgs/nodejs/repos

4. list repositories for the authenticated user:
  curl https://api.github.com/user/repos
  As you can see, it didn't work. The message says quite clearly that we need authentication. you'll first need an authentication token.
  Use the following template, replacing username with your user name and token with the value of the personal access token you just generated:
  curl -u username:token https://api.github.com/user/repos

5. list repositories using GitHub's search API:
  The search API allows you to search for all kinds of GitHub artifacts using a versatile search syntax that allows for ordering, filtering, paging, and more.
  Let's see an example:
  curl https://api.github.com/search/repositories?q=octokit+language:csharp
  The request above searches for repositories that contain "octokit" somewhere in their information and whose language is C#. 
