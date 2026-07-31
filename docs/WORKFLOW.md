# Workflow guide

## repo-generator.yml

This workflow checks out the repository, detects the vendor tree, runs the generator pipeline, validates the outputs, and then commits and pushes the changes.

## vendor-validator.yml

This workflow installs shellcheck and validates that all shell scripts are syntactically correct and that the generated vendor files exist.

## repo-inspector.yml

This workflow inspects the repository and produces a blob inventory for review.

## repo-clean.yml

This workflow deletes temporary files generated during the pipeline.
