git checkout -b develop
vim dev1.md
vim dev2.md
git add .
git commit -m "dev_comm1"
git push --set-upstream origin develop
git checkout -b feature_branch/feature1
vim feature1.1.md
vim feature1.2.md
git add .
git commit -m "feature1"
git checkout develop
git merge feature_branch/feature1
git branch -d feature_branch/feature1
git checkout main
git merge develop -m "0.1.0"
git add .
git push

new feature

# diamond 2