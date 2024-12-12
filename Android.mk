#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),muyu)
include $(call all-makefiles-under,$(LOCAL_PATH))

include $(CLEAR_VARS)

PREBUILT_KERNEL_MODULES_SYSTEM_DLKM := $(TARGET_OUT_SYSTEM_DLKM)/lib/modules/6.1.118-android14-11-ga3b9c44908dd-ab13320413
$(PREBUILT_KERNEL_MODULES_SYSTEM_DLKM):
	@mkdir -p $(PREBUILT_KERNEL_MODULES_SYSTEM_DLKM)
	@cp -r $(KERNEL_PATH)/modules/system/* $(PREBUILT_KERNEL_MODULES_SYSTEM_DLKM)

ALL_DEFAULT_INSTALLED_MODULES += $(PREBUILT_KERNEL_MODULES_SYSTEM_DLKM)

endif
