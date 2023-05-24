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

References:
1. https://docs.github.com/en/rest?apiVersion=2022-11-28
2. https://docs.github.com/zh/rest?apiVersion=2022-11-28
3. https://www.softwaretestinghelp.com/github-rest-api-tutorial

REST APIs (Representational State Transfer) primarily use HTTP requests to do the following.

GET – Retrieve the resource
PUT/PATCH – Update resource
POST – Create a resource
DELETE – Delete resource

Useage:
1. retrieves information about user:
  curl https://api.github.com/users/<USER-NAME>
  So, to list all public repos from a user, send a GET request to https://api.github.com/users/<USER-NAME>/repos, replacing <USER-NAME> with the actual user from whom you want to retrieve the repositories.

2. listing all public repositories belonging to a given user:
  curl https://api.github.com/users/<USER-NAME>/repos
  So, to list all public repos from a user, send a GET request to https://api.github.com/users/<USER-NAME>/repos, replacing <USER-NAME> with the actual user from whom you want to retrieve the repositories.

3. listing all public repositories belonging to an given organization:
  https://api.github.com/orgs/<ORGANIZATION-NAME>/repos
  For instance, to list repositories belonging to the Node.js organization, you'd do this:
  curl https://api.github.com/orgs/nodejs/repos

4. listing repositories for the authenticated user:
  curl https://api.github.com/user/repos
  As you can see, it didn't work. The message says quite clearly that we need authentication. you'll first need an authentication token.
  Use the following template, replacing username with your user name and token with the value of the personal access token you just generated:
  curl -u username:token https://api.github.com/user/repos
  Let's see an example:
  curl -u gooditzhu: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 https://api.github.com/user/repos

5. listing repositories using GitHub's search API:
  The search API allows you to search for all kinds of GitHub artifacts using a versatile search syntax that allows for ordering, filtering, paging, and more.
  
  Let's see an example:
  curl https://api.github.com/search/repositories?q=octokit+language:csharp
  The request above searches for repositories that contain "octokit" somewhere in their information and whose language is C#. 

  Let's see another example:
  curl https://api.github.com/search/repositories?q=node+in:name+language:javascript&sort=stars&order=desc
  The request above performs a search that looks for repositories with the word "node" in their names and whose language is JavaScript. The results are to be sorted by the number of stars in descending order.
  
6. listing repositories using a wrapper Library written for your favorite programming language:
  TODO

Repository
The REST API’s examples shown here are run on the Windows machine. This section will showcase some of the GitHub Repository operations.

#1) To list Public Repositories for a user, run the following command in a single line.
curl -X GET -u <UserName>:<Generated-Token> https://api.github.com/users/<user-name>/repos | grep -w clone_url

#2) To list Public Repositories under an organization.
curl -X GET -u <UserName>:<Generated-Token> https://api.github.com/orgs/<Org-Name>/repos | grep -w clone_url

#3) Create a Personal Repository.
curl -X POST -u <UserName>:<Generated-Token> https://api.github.com/user/repos -d "{\"name\": \"Demo_Repo\"}”
In the above command name is a parameter. Let’s look at some other parameters that can be used while creating personal user repositories.

curl -X POST -u <UserName>:<Generated-Token> https://api.github.com/user/repos -d "{\"name\": \"Demo_Repo\",\"description\": \"This is first repo through API\",\"homepage\": \"https://github.com\",\"public\": \"true\",\"has_issues\": \"true\",\"has_projects\": \"true\",\"has_wiki\": \"true\"}"
In the above command, name, description, homepage, public, has_projects, has_wiki are all parameters that take a string value and are enclosed in \". Also note that there is a SPACE between : and \

For Example, public parameter makes the repo public. The command also enables issues, projects, wikis to be created.

#4) Rename the Repository.
curl -X POST -u <UserName>:<Generated-Token> -X PATCH -d "{\"name\": \"<NewRepoName>\"}" https://api.github.com/repos/<user-name>/<OldRepoName>, or:
curl -u <UserName>:<Generated-Token> -X PATCH -d "{\"name\": \"<NewRepoName>\"}" https://api.github.com/repos/<user-name>/<OldRepoName>

#5) Update the has_wiki parameter in the repository and set the value to false.
curl -u <UserName>:<Generated-Token> -X PATCH -d "{\"has_wiki\": \"false\"}" https://api.github.com/repos/user-name/<reponame>

#6) Delete the Repository.
curl -X DELETE -u <UserName>:<Generated-Token> https://api.github.com/repos/<user-name>/<reponame>

#7) Create a Repository in an Organization.
curl -X POST -u <UserName>:<Generated-Token> https://api.github.com/orgs/<Enter-Org-name>/repos"{\"name\": \"Demo_Repo_In_Org\",\"description\": \"This is first repo in org through API\",\"homepage\": \"https://github.com\",\"public\": \"true\",\"has_issues\": \"true\",\"has_projects\": \"true\",\"has_wiki\": \"true\"}"

#8) List Forks for a Repository.
curl -X GET -u <UserName>:<Generated-Token>https://api.github.com/repos/<user-name>/<User-Repo>/forks | grep -w html_url

The above command will list the URL to browse the forked repo. The same can be seen under the user repository and ‘Insights TAB =>Forks’.
curl -X GET -u <UserName>:<Generated-Token>https://api.github.com/repos/<user-name>/<User-Repo>/forks | grep -w clone_url

The above command will list the URL to clone the forked repo.

#9) Fork a Repository in the organization.
curl -X POST -u <UserName>:<Generated-Token> -d "{\"organization\": \"<Org-Name-To-Fork>\"}" https://api.github.com/repos/<user-name>/<repo-name>/forks

Further Reading => Have you tried these File Upload API Solutions?

Collaborators
#1) List Collaborators for a Repository.
curl -X GET -u <UserName>:<Generated-Token>https://api.github.com/repos/<user-name>/<repo-name>/collaborators | grep -w login

#2) Check if a user is in the Collaborator list.
curl -X GET -u <UserName>:<Generated-Token>https://api.github.com/repos/<user-name>/<repo-name>/collaborators/<user-name-to-check>

If the user is a part of collaborator, then there is no content displayed as output else the following message is displayed.
{
“message”: “<user-name>is not a user”,
“documentation_url”: “https://developer.github.com/v3/repos/collaborators/#get”
}

#3) Check user’s Permission.
curl -X GET -u <UserName>:<Generated-Token>https://api.github.com/repos/<user-name>/<repo-name>/collaborators/<user-name-to-check–for-permission>/permission| grep -w permission

#4) Add user as Collaborator to the Repository.
curl -X PUT -u <UserName>:<Generated-Token>https://api.github.com/repos/<user-name>/<repo-name-to-add-collaborator>/collaborators/<user-name-to-add-as-collaborator>

Post this, the invitee will need to accept the invitation to join as collaborator. If a user is already added as collaborator, then no content is displayed else the output is displayed.

#5) Removing user as Collaborator.
curl -X DELETE -u <UserName>:<Generated-Token>https://api.github.com/repos/<user-name>/<repo-name-to-remove-collaborator>/collaborators/<user-name-to-remove>

No content is displayed once the command is run successfully.

Organization
Note: Creating Organizations is not provided by GitHub API.

#1) List all organization accounts for a user.
curl -X GET -u <UserName>:<Generated-Token>https://api.github.com/repos/user/orgs | grep -w login

#2) Update an Organization.
curl -X PATCH -u <UserName>:<Generated-Token>-d “{\”name\”: \”TeamVN\”,\”billing_email\”: \”vniranjan72@outlook.com\”,\”email\”: \”vniranjan72@outlook.com\”,\”location\”:\”Bangalore\”,\”\”description\”: \”Updating the organization details\”}”https://api.github.com/orgs/<Org-Name>

Branches
#1) List branches in a user repository. The command will list all the branches in a repository.
curl -X GET -u <UserName>:<Generated-Token>https://api.github.com/repos/<user-name>/<repo-name>/branches | grep -w name

#2) List all protected branches in a user repository.
curl -X GET -u <UserName>:<Generated-Token>https://api.github.com/repos/<user-name>/<repo-name>/branches?protected=true | grep -w name

#3) List all un-protected branches in a user repository
curl -X GET -u <UserName>:<Generated-Token>https://api.github.com/repos/<user-name>/<repo-name>/branches?protected=false | grep -w name

#4) Remove Branch Protection.
curl -X DELETE -u <UserName>:<Generated-Token>https://api.github.com/repos/<user-name>/<repo-name>/branches/master/protection

Pull Requests
#1) List Pull requests.
curl -X GET -u <UserName>:<Generated-Token>https://api.github.com/repos/<user-name>/<repo-name>/pulls?state=open | grep -w title

Options for the state parameter are Open, Closed, All.

#2) Create a Pull request.
curl -X POST -u <UserName>:<Generated-Token>-d “{\”title\”:\”Great feature added\”,\”body\”: \”Please pull the great change made in to master branch\”,\”head\”: \”feature\”,\”base\”: \”master\”}” https://api.github.com/repos/<user-name>/<repo-name>/pulls
