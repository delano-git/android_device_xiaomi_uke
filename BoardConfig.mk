#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Include the common OEM chipset BoardConfig.
include device/xiaomi/sm8635-common/BoardConfigCommon.mk

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := uke

# Kernel: built from source (kernel/xiaomi/sm8635, 'uke' branch)
TARGET_KERNEL_SOURCE := kernel/xiaomi/sm8635
TARGET_KERNEL_VERSION := 6.1
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_NO_GCC := true
TARGET_KERNEL_CLANG_VERSION := r547379
TARGET_KERNEL_CONFIG := \
    gki_defconfig \
    vendor/pineapple_GKI.config \
    vendor/uke_GKI.config

# DTB / DTBO
BOARD_USES_QCOM_MERGE_DTBS_SCRIPT := true
TARGET_NEEDS_DTBOIMAGE := true

# Kernel modules
TARGET_KERNEL_EXT_MODULE_ROOT := kernel/xiaomi/sm8635-modules
TARGET_KERNEL_EXT_MODULES := \
    qcom/opensource/audio-kernel \
    qcom/opensource/bt-kernel \
    qcom/opensource/camera-kernel \
    qcom/opensource/display-drivers/msm \
    qcom/opensource/dsp-kernel \
    qcom/opensource/eva-kernel \
    qcom/opensource/fingerprint \
    qcom/opensource/graphics-kernel \
    qcom/opensource/mmrm-driver \
    qcom/opensource/securemsm-kernel \
    qcom/opensource/spu-kernel \
    qcom/opensource/synx-kernel \
    xiaomi-touch/p82 \
    qcom/opensource/video-driver \
    qcom/opensource/mm-drivers/sync_fence \
    qcom/opensource/mm-drivers/msm_ext_display \
    qcom/opensource/mm-drivers/hw_fence \
    qcom/opensource/mm-sys-kernel/ubwcp \
    qcom/opensource/wlan/platform \
    qcom/opensource/wlan/qcacld-3.0/.qca6750 \
    qcom/opensource/dataipa/drivers/platform/msm \
    qcom/opensource/datarmnet/core \
    qcom/opensource/datarmnet-ext/aps \
    qcom/opensource/datarmnet-ext/mem \
    qcom/opensource/datarmnet-ext/offload \
    qcom/opensource/datarmnet-ext/perf \
    qcom/opensource/datarmnet-ext/perf_tether \
    qcom/opensource/datarmnet-ext/sch \
    qcom/opensource/datarmnet-ext/shs \
    qcom/opensource/datarmnet-ext/wlan \
    nxp/opensource/driver \
    xiaomi-modules

DLKM_MODULES_PATH := $(DEVICE_PATH)/configs/kernel/vendor
RAMDISK_MODULES_PATH := $(DEVICE_PATH)/configs/kernel/ramdisk

BOARD_VENDOR_KERNEL_MODULES_LOAD := $(shell cat $(DLKM_MODULES_PATH)/modules.load)
BOARD_VENDOR_KERNEL_MODULES_BLOCKLIST_FILE := $(DLKM_MODULES_PATH)/modules.blocklist

BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(shell cat $(RAMDISK_MODULES_PATH)/modules.load)
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(shell cat $(RAMDISK_MODULES_PATH)/modules.load.recovery)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_BLOCKLIST_FILE := $(RAMDISK_MODULES_PATH)/modules.blocklist

# The vendor ramdisk has to carry the first-stage modules for both the normal
# and the recovery (fastbootd) boot, so install the union of the load lists.
BOOT_KERNEL_MODULES := $(sort \
    $(BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD) \
    $(BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD))
TARGET_AUTO_COLLECT_KERNEL_MODULE_DEPS := true

# Properties
TARGET_ODM_PROP += $(DEVICE_PATH)/configs/properties/odm.prop
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/configs/properties/system.prop

WITH_DEXPREOPT_ART_BOOT_IMG_ONLY := true

# Inherit the proprietary files
include vendor/xiaomi/uke/BoardConfigVendor.mk
