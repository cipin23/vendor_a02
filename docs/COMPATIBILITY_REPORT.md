# Compatibility report

## Target
- crDroid Android 11 (R)
- 32-bit only
- Samsung Galaxy A02 (SM-A022F)

## Adjustments applied
- Generated Android.bp entries as `cc_prebuilt_library_shared` modules for ELF 32-bit shared objects only.
- Generated `PRODUCT_COPY_FILES` entries from the proprietary blob tree using vendor-style paths.
- Generated `PRODUCT_PACKAGES` entries for the discovered shared-library modules.
- Aligned `BoardConfigVendor.mk` with a 32-bit ARM Android 11 target profile.
- Aligned `AndroidProducts.mk` with a standard `a02-userdebug` lunch target.

## Verification
- ShellCheck passed for all scripts.
- The full generator and validation pipeline completed successfully.
- Validation output: `Validation succeeded.`

## Result
- Android.bp modules: 539
- Product copyfile entries: 927
- Product package entries: 539
