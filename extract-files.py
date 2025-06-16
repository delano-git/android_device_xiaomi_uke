#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2025 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    'device/xiaomi/sm8635-common',
    'hardware/qcom-caf/sm8650',
    'vendor/xiaomi/sm8635-common',
]

blob_fixups: blob_fixups_user_type = {
    (
        'odm/etc/camera/enhance_motiontuning.xml',
        'odm/etc/camera/motiontuning.xml',
        'odm/etc/camera/night_motiontuning.xml'
    ): blob_fixup()
        .regex_replace('xml=version', 'xml version'),
    (
        'odm/lib64/libAncHumanVideoBokehV4.so',
        'odm/lib64/libanc_single_rt_bokeh.so',
    ): blob_fixup()
        .clear_symbol_version('AHardwareBuffer_allocate')
        .clear_symbol_version('AHardwareBuffer_describe')
        .clear_symbol_version('AHardwareBuffer_lock')
        .clear_symbol_version('AHardwareBuffer_release')
        .clear_symbol_version('AHardwareBuffer_unlock'),
    (
        'odm/lib64/camera/com.qti.actuator.o82_ofilm_ov13b10_cn3927v_wide_i_actuator.so',
        'odm/lib64/camera/com.qti.eeprom.o82_aac_ov08d10_gt24p64e_front_i_eeprom.so',
        'odm/lib64/camera/com.qti.eeprom.o82_ofilm_ov13b10_bl24sa64_wide_i_eeprom.so',
        'odm/lib64/camera/com.qti.sensor.o82_aac_ov08d10_front_i.so',
        'odm/lib64/camera/com.qti.sensor.o82_ofilm_ov13b10_wide_i.so',
        'odm/lib64/camera/components/com.jigan.node.videobokeh.so',
        'odm/lib64/camera/components/com.mi.node.aiasd.so',
        'odm/lib64/camera/components/com.mi.node.rearvideo.so',
        'odm/lib64/camera/components/com.mi.node.videonight.so',
        'odm/lib64/camera/libchxlogicalcameratable.so',
        'vendor/lib64/camera/components/com.mi.node.dlengine.so',
        'vendor/lib64/camera/components/com.mi.node.mawsaliency.so',
        'vendor/lib64/camera/components/com.mi.node.videobokeh.so',
        'vendor/lib64/camera/components/com.mi.node.videofilter.so',
        'vendor/lib64/camera/components/com.qti.hwcfg.bps.so',
        'vendor/lib64/camera/components/com.qti.hwcfg.ife.so',
        'vendor/lib64/camera/components/com.qti.hwcfg.ipe.so',
        'vendor/lib64/camera/components/com.qti.node.aon.so',
        'vendor/lib64/camera/components/com.qti.node.depth.so',
        'vendor/lib64/camera/components/com.qti.node.depthprovider.so',
        'vendor/lib64/camera/components/com.qti.node.dewarp.so',
        'vendor/lib64/camera/components/com.qti.node.eisv2.so',
        'vendor/lib64/camera/components/com.qti.node.eisv3.so',
        'vendor/lib64/camera/components/com.qti.node.evadepth.so',
        'vendor/lib64/camera/components/com.qti.node.gme.so',
        'vendor/lib64/camera/components/com.qti.node.gyrornn.so',
        'vendor/lib64/camera/components/com.qti.node.hdr10pgen.so',
        'vendor/lib64/camera/components/com.qti.node.hdr10phist.so',
        'vendor/lib64/camera/components/com.qti.node.itofpreprocess.so',
        'vendor/lib64/camera/components/com.qti.node.ml.so',
        'vendor/lib64/camera/components/com.qti.node.mlinference.so',
        'vendor/lib64/camera/components/com.qti.node.pixelstats.so',
        'vendor/lib64/camera/components/com.qti.node.seg.so',
        'vendor/lib64/camera/components/com.qti.node.swec.so',
        'vendor/lib64/camera/components/com.qti.node.swregistration.so',
        'vendor/lib64/camera/components/com.qti.stats.cnndriver.so',
        'vendor/lib64/camera/components/libcamxevainterface.so',
        'vendor/lib64/camera/components/libdepthmapwrapper_itof.so',
        'vendor/lib64/camera/components/libdepthmapwrapper_secure.so',
        'vendor/lib64/hw/camera.qcom.sm8650.so',
        'vendor/lib64/hw/camera.qcom.so',
        'vendor/lib64/hw/com.qti.chi.offline.so',
        'vendor/lib64/hw/com.qti.chi.override.so',
    ): blob_fixup()
        .replace_needed('android.hardware.graphics.allocator-V1-ndk.so', 'android.hardware.graphics.allocator-V2-ndk.so'),
    'vendor/lib64/libar-pal.so': blob_fixup()
        .replace_needed('libaudioroute.so', 'libaudioroute-v34.so'),
}

module = ExtractUtilsModule(
    'uke',
    'xiaomi',
    blob_fixups=blob_fixups,
    namespace_imports=namespace_imports,
    add_firmware_proprietary_file=True,
)

if __name__ == '__main__':
    utils = ExtractUtils.device_with_common(
        module, 'sm8635-common', module.vendor
    )
    utils.run()
