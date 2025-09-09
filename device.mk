#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/muyu

# Inherit from the common OEM chipset makefile.
$(call inherit-product, device/xiaomi/sm8635-common/common.mk)

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit the proprietary files
$(call inherit-product, vendor/xiaomi/muyu/muyu-vendor.mk)
