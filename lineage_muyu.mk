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
$(call inherit-product, device/xiaomi/muyu/device.mk)

PRODUCT_DEVICE := muyu
PRODUCT_BRAND := Xiaomi
PRODUCT_NAME := lineage_muyu
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_MODEL := 24091RPADG

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="missi-user 15 AQ3A.240801.002 OS2.0.200.0.VOYMIXM release-keys" \
    BuildFingerprint=Xiaomi/muyu_global/muyu:14/UKQ1.240624.001/OS2.0.200.0.VOYMIXM:user/release-keys
