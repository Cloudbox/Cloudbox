## Contributing

Guide below will explain the process of submitting a pull request (PR).

1. Fork it.

1. Clone your forked project:

   ```
   git clone http://github.com/<your_github_username>/cloudbox
   ```

1. Create a feature branch off of the **develop** branch:

   ```
   git checkout -b 'feature/my-new-feature' develop
   ```

1. Keep up to date with latest **develop** branch changes:

   ```
   git pull --rebase upstream develop
   ```

1. Commit your changes:

   ```
   git commit -am 'Added some feature'
   ```

1. Push commits to the feature branch:

   ```
   git push origin feature/my-new-feature
   ```

1. Submit feature branch as a PR to _our_ **develop** branch.
