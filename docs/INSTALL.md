# Installation

1. Ensure the repository contains the vendor tree under vendor_a02/samsung/a02/proprietary.
2. Make the scripts executable:

```bash
chmod +x scripts/*.sh
```

3. Run the generator pipeline:

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
