### How to Use GitHub Actions

GitHub Actions is configured to automatically **build and run tests for each OCaml assignment whenever a new commit is pushed** to the repository. Students do not need to manually execute the CI workflow if workflows are added in the individual repository. After a commit is pushed, the workflow status will appear on the right side of the corresponding commit. A yellow indicator means that the workflow is currently running, a green check mark means that the build and tests have passed successfully, and a red cross indicates that an error occurred during the build or test process.

Students can click the workflow status or open the **Actions** tab of the repository to view detailed results. Each assignment directory, such as `pa1`, `pa2`, and `pa3`, is detected automatically and checked independently. If a workflow fails, the corresponding job can be opened to inspect the build or test logs. This allows students to cross-check whether code that works on their local machine also works correctly in the common CI environment.

If the workflow needs to be added manually, create the file `.github/workflows/OCaml.yml` in the repository root and add the following configuration:

```yaml
name: OCaml Build & Test

on:
  push:
  pull_request:

jobs:
  discover:
    name: Discover assignments
    runs-on: ubuntu-latest

    outputs:
      projects: ${{ steps.find-projects.outputs.projects }}
      has_projects: ${{ steps.find-projects.outputs.has_projects }}

    steps:
      - name: Checkout repository
        uses: actions/checkout@v6

      - name: Find pa projects
        id: find-projects
        shell: bash
        run: |
          projects=()

          for dir in pa*/; do
            [ -d "$dir" ] || continue

            name="${dir%/}"

            if [[ "$name" =~ ^pa[0-9]+$ ]] && [[ -f "$name/dune-project" ]]; then
              projects+=("$name")
            fi
          done

          # Natural sort: pa1, pa2, ..., pa10
          if [ ${#projects[@]} -gt 0 ]; then
            mapfile -t projects < <(printf '%s\n' "${projects[@]}" | sort -V)
          fi

          projects_json=$(
            printf '%s\n' "${projects[@]}" |
            jq -R -s -c 'split("\n") | map(select(length > 0))'
          )

          echo "projects=$projects_json" >> "$GITHUB_OUTPUT"

          if [ ${#projects[@]} -gt 0 ]; then
            echo "has_projects=true" >> "$GITHUB_OUTPUT"
          else
            echo "has_projects=false" >> "$GITHUB_OUTPUT"
          fi

          echo "Detected projects: $projects_json"

  build-and-test:
    name: ${{ matrix.project }}
    needs: discover

    if: needs.discover.outputs.has_projects == 'true'

    strategy:
      fail-fast: false
      matrix:
        project: ${{ fromJSON(needs.discover.outputs.projects) }}

    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v6

      - name: Set up OCaml
        uses: ocaml/setup-ocaml@v3
        with:
          ocaml-compiler: "5.1.1"

      - name: Install Dune
        run: opam install dune

      - name: Build
        working-directory: ${{ matrix.project }}
        run: opam exec -- dune build

      - name: Test
        working-directory: ${{ matrix.project }}
        run: opam exec -- dune runtest
```

The workflow automatically detects directories named `pa1`, `pa2`, `pa3`, and so on, as long as they contain a `dune-project` file. Therefore, newly added assignments are automatically included in the CI process without modifying the workflow file.
