# vendor_a02

This repository includes a POSIX-shell vendor generator framework for the Samsung Galaxy A02 vendor tree.

## Layout

- scripts/: generator and validation scripts
- templates/: reusable file templates
- docs/: usage and troubleshooting documentation
- .github/workflows/: automation workflows

## Supported workflows

- repo-generator.yml: detect repository, generate files, validate, commit, and push
- vendor-validator.yml: run shellcheck and validation
- repo-inspector.yml: inspect repository metadata and blob inventory
- repo-clean.yml: clean temporary artifacts

## Usage

Run the generator locally:

```bash
bash scripts/detect_repo.sh
bash scripts/scan_blobs.sh
bash scripts/generate_android_bp.sh
bash scripts/generate_android_mk.sh
bash scripts/generate_android_products.sh
bash scripts/generate_boardconfig_vendor.sh
bash scripts/generate_vendor_mk.sh
bash scripts/generate_propfiles.sh
bash scripts/generate_packages.sh
bash scripts/normalize_copyfiles.sh
bash scripts/sort_modules.sh
bash scripts/remove_duplicates.sh
bash scripts/validate_vendor.sh
```