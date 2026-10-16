#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/uke
KERNEL_PATH := $(DEVICE_PATH)-kernel

# Dolby
TARGET_PROVIDES_DOLBY_DAX := true

# Inherit from the common OEM chipset makefile.
$(call inherit-product, device/xiaomi/sm8635-common/common.mk)

# Dolby DAX
PRODUCT_COPY_FILES += \
    vendor/xiaomi/uke/proprietary/odm/etc/dolby/dax-default.xml:$(TARGET_COPY_OUT_VENDOR)/etc/dolby/dax-default.xml \
    vendor/xiaomi/uke/proprietary/odm/etc/dolby/dax-default-spatializer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/dolby/dax-default-spatializer.xml

# The source-built AGM only looks in /vendor/etc/acdbdata/<sound card>, so
# install the tablet's tuned (Forte) calibration where it expects it instead
# of the generic Qualcomm MTP reference data.
PRODUCT_COPY_FILES += \
    vendor/xiaomi/uke/proprietary/odm/etc/acdbdata/Forte/Forte_acdb_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/cliffs_mtp/MTP_cliffs_acdb_cal.acdb \
    vendor/xiaomi/uke/proprietary/odm/etc/acdbdata/Forte/Forte_workspaceFileXml.qwsp:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/cliffs_mtp/MTP_cliffs_workspaceFileXml.qwsp

# The source-built PAL reads its mixer paths and resource manager config from
# /vendor/etc/audio/sku_<sku>, while Xiaomi ships them in /odm.
#
# Xiaomi's PAL also layers mixer_paths_overlay_static.xml and
# mixer_paths_overlay_dynamic.xml over the common mixer paths; the source-built
# PAL does not, so the tablet's real mic (SoundWire) and speaker routing was
# never applied and the mics recorded silence. The common file below is those
# overlays pre-merged (see configs/audio/merge_mixer_overlay.py).
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/audio/mixer_paths_cliffs_mtp.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_cliffs/mixer_paths_cliffs_mtp.xml \
    vendor/xiaomi/sm8635-common/proprietary/odm/etc/audio/sku_cliffs/mixer_paths_overlay_dynamic.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_cliffs/mixer_paths_overlay_dynamic.xml \
    vendor/xiaomi/uke/proprietary/odm/etc/audio/sku_cliffs/mixer_paths_overlay_static.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_cliffs/mixer_paths_overlay_static.xml \
    $(DEVICE_PATH)/configs/audio/resourcemanager_cliffs_mtp.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_cliffs/resourcemanager_cliffs_mtp.xml

# Kernel Manager
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/ax_kernel_manager.xml:$(TARGET_COPY_OUT_VENDOR)/etc/ax_kernel_manager.xml

# The NT36532 has no flash: nt36532_touch downloads its firmware at probe.
# Recovery doesn't mount /odm, so ship the firmware in its ramdisk.
PRODUCT_COPY_FILES += \
    $(foreach panel,csot tm, \
        vendor/xiaomi/uke/proprietary/odm/firmware/novatek_nt36532_o82_fw_$(panel).bin:$(TARGET_COPY_OUT_RECOVERY)/root/lib/firmware/novatek_nt36532_o82_fw_$(panel).bin)

# ...and then needs the THP daemon's configs and models to report events.
# Recovery's /odm/firmware is a dangling symlink to /vendor/odm/firmware.
PRODUCT_COPY_FILES += \
    $(foreach file,o82_nova_thp_config.ini o82_nova_tm_thp_config.ini film_model.tflite glove_model.tflite palm_check.tflite water_check.tflite, \
        vendor/xiaomi/uke/proprietary/odm/firmware/$(file):$(TARGET_COPY_OUT_RECOVERY)/root/vendor/odm/firmware/$(file))

# Overlays
PRODUCT_PACKAGES += \
    FrameworksResUke \
    SettingsProviderResUke

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit the proprietary files
$(call inherit-product, vendor/xiaomi/uke/uke-vendor.mk)
