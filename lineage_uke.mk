#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

# Inherit some common LineageOS stuff.
$(call inherit-product, vendor/lineage/config/common_full_tablet_wifionly.mk)

# Inherit from device makefile.
$(call inherit-product, device/xiaomi/uke/device.mk)

PRODUCT_DEVICE := uke
PRODUCT_BRAND := Xiaomi
PRODUCT_NAME := lineage_uke
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_MODEL := 2410CRP4CG

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="missi-user 15 AQ3A.240801.002 OS2.0.201.0.VOZMIXM release-keys" \
    BuildFingerprint=Xiaomi/uke_global/uke:14/UKQ1.240624.001/OS2.0.201.0.VOZMIXM:user/release-keys
