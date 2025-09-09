#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2025 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    'device/xiaomi/sm8635-common',
    'hardware/qcom-caf/sm8650',
    'vendor/xiaomi/sm8635-common',
]

module = ExtractUtilsModule(
    'muyu',
    'xiaomi',
    namespace_imports=namespace_imports,
)

if __name__ == '__main__':
    utils = ExtractUtils.device_with_common(
        module, 'sm8635-common', module.vendor
    )
    utils.run()
