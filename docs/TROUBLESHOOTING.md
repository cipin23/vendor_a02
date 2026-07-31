# Troubleshooting

## Shell syntax error

Run shellcheck against the scripts:

```bash
shellcheck scripts/*.sh
```

## Missing generated files

Re-run the generation pipeline and inspect the output of the validation step:

```bash
bash scripts/validate_vendor.sh
```

## Repository detection issues

Ensure the repository contains a vendor tree with a proprietary directory and an Android.mk file.
