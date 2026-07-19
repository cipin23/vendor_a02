LOCAL_PATH := $(call my-dir)
ifeq ($(TARGET_DEVICE),a02)
include $(LOCAL_PATH)/a02-vendor.mk
endif
