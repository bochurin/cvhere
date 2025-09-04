GitHub Actions for VS Code
The GitHub Actions extension lets you manage your workflows, view the workflow run history, and helps with authoring workflows.

Features
Manage workflows and runs
Manage your workflows and runs without leaving your editor.
Keep track of your CI builds and deployments.
Investigate failures and view logs.
View workflow runs and logs

Workflow authoring
Be more confident when authoring and modifying workflows. Find errors before committing workflows with:

Syntax highlighting for workflows and GitHub Actions Expressions makes it clear where values are inserted at execution time:

Syntax highlighting

Integrated documentation for the workflow schema, expression functions, and even event payloads:

Tooltip showing description for a pull_request payload

Validation and code completion for the YAML schema and GitHub Actions Expressions. Get instant validation and code completion for the workflow schema, expression functions, event payloads, and job or step outputs:

Validation for YAML keys and expressions

Smart validation and code completion for actions and reusable workflows: the extension automatically parses parameters, inputs, and outputs for referenced actions and called reusable workflows for code-completion and validation.

Video showing workflow validation and auto-completion

Getting started
Install the extension from the Marketplace.
Sign in with your GitHub account and when prompted allow GitHub Actions access to your GitHub account.
Open a GitHub repository.
You will be able to utilize the syntax features in Workflow files, and you can find the GitHub Actions icon on the left navigation to manage your Workflows.
Supported Features
Manage your workflows and runs
Edit workflows (syntax highlighting, auto-completion, hovering, and validation)
Keep track of your CI builds and deployments
Investigate failures and view logs
Modify settings like Environments, Secrets, and Variables
Unfortunately, at this time we are not able to support the extension with remote repositories (including github.dev and vscode.dev), so please use the extension with locally downloaded GitHub repositories for the best experience. Please check back here for updates in the future!

We have enabled experimental functionality to support GitHub Enterprise Server, but this feature is an experimental beta and currently unsupported. To try this out, enable the use-enterprise setting to authenticate with your GitHub Enterprise Server Authentication Provider settings Use-enterprise setting checkbox

We currently do not have the capability to support Operating System (OS) certificates or enterprise proxies (we plan to support pulling from the VS Code proxy settings), but we have plans for it in the future and it is on our backlog!

Contributing
See CONTRIBUTING.md. A description of the architecture of the extension can be found here.

License
This project is licensed under the terms of the MIT open source license. Please refer to MIT for the full terms.

Runtime Status
Activation
Activated by workspaceContains:**/.github/workflows/** event: 1ms

Activation Events
onView:workflows
onView:settings
workspaceContains:**/.github/workflows/**

Commands
ID Title Keyboard Shortcuts Menu Contexts
github-actions.explorer.current-branch.refresh

Refresh current branch

commandPalette view/title

github-actions.explorer.openRun

Open workflow run

github-actions.explorer.openWorkflowFile

Open workflow

view/item/context

github-actions.explorer.refresh

Refresh

commandPalette view/title

github-actions.explorer.triggerRun

Trigger workflow

editor/title view/item/context

github-actions.settings.secret.add

Add new secret

view/item/context

github-actions.settings.secret.copy

Copy secret name

view/item/context

github-actions.settings.secret.delete

Delete secret

view/item/context

github-actions.settings.secret.update

Update secret

view/item/context

github-actions.settings.secrets.manage

Add new secret

github-actions.settings.variable.add

Add new variable

view/item/context

github-actions.settings.variable.copy-name

Copy variable name

view/item/context

github-actions.settings.variable.copy-value

Copy variable value

view/item/context

github-actions.settings.variable.delete

Delete variable

view/item/context

github-actions.settings.variable.update

Update variable

view/item/context

github-actions.sign-in

Sign in to GitHub

github-actions.step.logs

View step logs

view/item/context

github-actions.workflow.logs

View job logs

view/item/context

github-actions.workflow.pin

Pin workflow

view/item/context

github-actions.workflow.run.cancel

Cancel workflow run

view/item/context

github-actions.workflow.run.open

Open workflow run

view/item/context

github-actions.workflow.run.rerun

Rerun workflow run

view/item/context

github-actions.workflow.unpin

Unpin workflow

view/item/context

Programming Languages
ID Name File Extensions Grammar Snippets
github-actions-workflow

GitHub Actions Workflow

✔︎

—

Settings
ID Description Default
github-actions.remote-name

The name of the repository's git remote that points to GitHub

"origin"
github-actions.use-enterprise

If this is set to true, use the auth provider for the GitHub Enterprise URL configured in github-enterprise.uri

false
github-actions.workflows.pinned.refresh.enabled

Auto-refresh pinned workflows. Note: this uses polling and counts against your GitHub API rate limit

false
github-actions.workflows.pinned.refresh.interval

Time to wait between calls to update pinned workflows in seconds

30
github-actions.workflows.pinned.workflows

Workflows to show in the status bar, identified by their paths

[]

View Containers
ID Title Where
github-actions

GitHub Actions

activitybar

Views
ID Name Where
github-actions.current-branch

Current Branch

github-actions

github-actions.empty-view

github-actions

github-actions.settings

Settings

github-actions

github-actions.workflows

Workflows

github-actions
