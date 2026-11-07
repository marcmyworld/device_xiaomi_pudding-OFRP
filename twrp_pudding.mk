#
# Copyright (C) 2026 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/pudding

# Inherit from device.mk configuration
$(call inherit-product, $(DEVICE_PATH)/device.mk)

## Device identifier
PRODUCT_DEVICE := pudding
PRODUCT_NAME := twrp_pudding
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := Xiaomi 17
PRODUCT_MANUFACTURER := Xiaomi
