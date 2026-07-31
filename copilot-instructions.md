# Target Project Context

## Overview
Project ini bertujuan untuk merapikan, mengonfigurasi, dan membangun **Vendor Tree** khusus untuk perbaikan / porting **crDroid Official Android 11 (LineageOS 18.1 base)** pada perangkat **Samsung Galaxy A02 (a02)**.

## Technical Specifications
- **Device Model:** Samsung Galaxy A02 (SM-A022F / a02)
- **Architecture:** ARM 32-bit (`armeabi-v7a` / `armv7-a-neon`)
- **Target OS:** Android 11 (Red Velvet Cake / API level 30 / VNDK 30)
- **Base Tree:** crDroid Android 11 / LineageOS 18.1
- **Focus Areas:**
  - Menata struktur folder `vendor/samsung/a02`
  - Menyusun file `Android.mk`, `Android.bp`, `a02-vendor.mk`, dan `BoardConfigVendor.mk`
  - Memastikan seluruh blobs/proprietary library di `proprietary/lib/` dan `proprietary/bin/` bertipe **ELF 32-bit ARM**
  - Mengonfigurasi VINTF manifest (`vendor/etc/vintf/manifest.xml`) agar HAL Binder kompatibel dengan Android 11
  - Memperbaiki kompatibilitas SELinux policy & VNDK fallback jika memakai blobs legacy

## Copilot Guidelines
Saat saya meminta bantuan atau pembuatan kode/script:
1. Utamakan sintaks Android Build System untuk Android 11 (AOSP / LineageOS 18.1).
2. Jangan pernah menyarankan binary atau library 64-bit (`lib64`), karena target arsitektur murni 32-bit (`armeabi-v7a`).
3. Selalu sertakan penjelas singkat mengenai letak file dan fungsionalitas script yang dibuat.