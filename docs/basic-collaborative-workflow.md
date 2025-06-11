# Basic Collaborative Workflow

Moner Bondhu practices a preset guideline and workflow for using git and version control systems. The guideline is partially based on Atlassian Gitflow, many naming conventions are borrowed from there however we do not use the GitFlow by heart. Every developer and development activities must adhere to these guidelines.

## How It Works

[![image.png](https://books.monerbondhu.com/uploads/images/gallery/2024-07/scaled-1680-/PhXimage.png)](https://books.monerbondhu.com/uploads/images/gallery/2024-07/PhXimage.png)

Instead of a single main branch, this workflow uses two branches to record the history of the project. The main branch (usually named as "production") stores the official release history, and the develop (usually named as "dev") branch serves as an integration branch for features. It's also convenient to tag all commits in the main branch with a version number.

[![image.png](https://books.monerbondhu.com/uploads/images/gallery/2024-07/scaled-1680-/LsGimage.png)](https://books.monerbondhu.com/uploads/images/gallery/2024-07/LsGimage.png)

Each new feature should reside in its own branch, which can be pushed to the central repository for backup/collaboration. But, instead of branching off of `<span class="hljs-selector-tag">production</span>`, `feature` branches use `dev` as their parent branch. When a feature is complete, it gets merged back into develop. Features should never interact directly with `<span class="hljs-selector-tag">production</span>`.

[![image.png](https://books.monerbondhu.com/uploads/images/gallery/2024-07/scaled-1680-/VTwimage.png)](https://books.monerbondhu.com/uploads/images/gallery/2024-07/VTwimage.png)

Once `develop` has acquired enough features for a release (or a predetermined release date is approaching), you fork a `release` branch (often called `staging`) off of `develop`. Creating this branch starts the next release cycle, so no new features can be added after this point—only bug fixes, documentation generation, and other release-oriented tasks should go in this branch. Once it's ready to ship, the `release` branch gets merged into `<span class="hljs-selector-tag">main</span>` and tagged with a version number. In addition, it should be merged back into `develop`, which may have progressed since the release was initiated.

Using a dedicated branch to prepare releases makes it possible for one team to polish the current release while another team continues working on features for the next release. It also creates well-defined phases of development (e.g., it's easy to say, “This week we're preparing for version 4.0,” and to actually see it in the structure of the repository).

Once the release is ready to ship, it will get merged it into `production` and `dev`, then the `release` branch will be deleted. It’s important to merge back into `develop` because critical updates may have been added to the `release` branch and they need to be accessible to new features.

[![image.png](https://books.monerbondhu.com/uploads/images/gallery/2024-07/scaled-1680-/WR9image.png)](https://books.monerbondhu.com/uploads/images/gallery/2024-07/WR9image.png)

Maintenance or “hotfix” branches are used to quickly patch production releases. Hotfix branches are a lot like release branches and feature branches except they're based on main instead of develop. This is the only branch that should fork directly off of main. As soon as the fix is complete, it should be merged into both main and develop (or the current release branch), and main should be tagged with an updated version number.

Having a dedicated line of development for bug fixes lets our team address issues without interrupting the rest of the workflow or waiting for the next release cycle. You can think of maintenance branches as ad hoc release branches that work directly with main.

## Workflow

<p class="callout danger">It is mandatory for tech developers to use and adhere to this workflow to keep development consistent. The gitflow workflow allows for safety and precautions, high efficiency and good habits of code reviews. It is also strictly prohibited to directly push code to production branch, as we have CI/CD pipelines for automatic builds and deployments, and manually pushing to production may disrupt the pipeline.</p>

1. Clone an existing repository
2. Create and switch to `development` branch from `production` if not already there. 
    1. If you switched to an existing development, run a git pull to sync your local repository to the remote.
3. Create and switch to a `feature` branch from the `development`branch. 
    1. The feature branch should be named as `FEATURE_keywords_here` where keyword is a word related to the feature you are working on. For example. `FEATURE_newsletter` or `FEATURE_i8n_phone_numbers`
4. Make changes to code
5. Add, Commit and Push feature branch to remote
6. Create a Pull Request to development branch and merge with development
7. Once merged, delete the feature branch
8. Once enough features are merged into development, Create a Release branch 
    1. Release branches should be named as `RC_VERSION-NUMBER` like `RC_24.2.0`or `RC_24.3.1`
    2. VERSION-NUMBER is a consistent number used in our codes and APIs as well. It is consisted of 3 Digits.
    3. The first two digit represent the suffix of the current year (24 if the RC is to be released in 2024)
    4. The second digit is a major version number, ranging from 0 to any positive number. This number is incremented by 1 when major features are added or changed and decided on by the team.
    5. The third digit is a minor version number, ranging from 0 to any positive number. This is always incremented by 1 every release unless the major is incremented. If Major version number is incremented, minor version number will be reset to 0.
9. When the Release branch is done, merge it with `production` and `development`
10. If an issue in production is detected a `hotfix` branch is created from production
11. Once hotfix is complete, it is merged with production and development

## Continuous Integration and Development

It is standard practice in our servers to have CI/CD Pipelines set up with GitHub. This means that whenever new code is pushed to production branch, automated codes are run to host this code to our production servers and overwrite the currently running code and run other basic scripts. Currently, we use GitHub CI/CD to listen for changes on production branch, and when there are writes, test and package the code to AWS CodeDeploy. AWS CodeDeploy tries to deploy the new code to the EC2 servers. It also uses secrets from AWS SecretsManager. If a deployment fails, CodeDeploy is also configured to automatically rollback to the last working production branch. Further information about CI/CD Pipelines and set ups will be added.

## Code Reviews

Before a Release Candidate is merged into production, it must go through code approval by at least 1 person other than the person who wrote majority of the features. Code review comments must be addressed before the Release can be merged to production.