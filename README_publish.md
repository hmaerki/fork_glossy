# Publish changes

## Links

* repository to publish to: https://github.com/typst/packages/tree/main/packages/preview/glossy

* doc: https://github.com/typst/packages/blob/main/docs/README.md

Example PR from glossy:

- [v0.9.0](https://github.com/typst/packages/pull/3323)
- [v0.8.0](https://github.com/typst/packages/pull/2122)

## Prepare to push upstream

1. Make these commands run without error

    ```bash
    # Format files in place
    typstyle -i .

    # Testrunner
    tt run --no-fail-fast
    ```

2. Update changelog in `README.md`

3. Update version in `typst.toml`

4. Commit to `main`

5. Manage branches

   a. If `submitted-upstream` has commits not in `main`, merge `submitted-upstream` into `main`.

   b. Merge `main` into `submitted-upstream`.
      Both should now point to the same commit.

   c. Create version tag.

   d. Create PR from `submitted-upstream` to https://github.com/typst/packages

6. If PR was merged and `submitted-upstream` has commits not in `main`, merge `submitted-upstream` into `main`.
