#
# Copyright 2016 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This contains the module build definitions for the hardware-specific
# components for this device.
#
# As much as possible, those components should be built unconditionally,
# with device-specific names to avoid collisions, to avoid device-specific
# bitrot and build breakages. Building a component unconditionally does
# *not* include it on all devices, so it is safe even with hardware-specific
# components.

DEVICE_PACKAGE_OVERLAYS := device/zuk/mustang/overlay
TARGET_ENABLE_QC_AV_ENHANCEMENTS := true
BOARD_HAVE_QCOM_FM := true
TARGET_USES_NQ_NFC := false

#QTIC flag
-include $(QCPATH)/common/config/qtic-config.mk

# copy customized media_profiles and media_codecs xmls for msm8996
ifeq ($(TARGET_ENABLE_QC_AV_ENHANCEMENTS), true)
PRODUCT_COPY_FILES += device/zuk/mustang/media_profiles.xml:system/etc/media_profiles.xml \
                      device/zuk/mustang/media_codecs.xml:system/etc/media_codecs.xml \
                      device/zuk/mustang/media_codecs_performance.xml:system/etc/media_codecs_performance.xml
endif  #TARGET_ENABLE_QC_AV_ENHANCEMENTS

PRODUCT_COPY_FILES += device/zuk/mustang/whitelistedapps.xml:system/etc/whitelistedapps.xml

# Override heap growth limit due to high display density on device
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapgrowthlimit=256m
$(call inherit-product, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk)
$(call inherit-product, device/qcom/common/common64.mk)

PRODUCT_NAME := msm8996
PRODUCT_DEVICE := msm8996
PRODUCT_BRAND := Android
PRODUCT_MODEL := MSM8996 for arm64

PRODUCT_BOOT_JARS += tcmiface

ifneq ($(strip $(QCPATH)),)
PRODUCT_BOOT_JARS += WfdCommon
PRODUCT_BOOT_JARS += com.qti.dpmframework
PRODUCT_BOOT_JARS += dpmapi
endif

ifeq ($(strip $(BOARD_HAVE_QCOM_FM)),true)
PRODUCT_BOOT_JARS += qcom.fmradio
endif #BOARD_HAVE_QCOM_FM
PRODUCT_BOOT_JARS += qcmediaplayer

#Android EGL implementation
PRODUCT_PACKAGES += libGLES_android

# Audio configuration file
ifeq ($(TARGET_USES_AOSP), true)
PRODUCT_COPY_FILES += \
    device/qcom/common/media/audio_policy.conf:system/etc/audio_policy.conf
else
PRODUCT_COPY_FILES += \
    device/zuk/mustang/audio_policy.conf:system/etc/audio_policy.conf
endif

PRODUCT_COPY_FILES += \
    device/zuk/mustang/audio_output_policy.conf:system/vendor/etc/audio_output_policy.conf \
    device/zuk/mustang/audio_effects.conf:system/vendor/etc/audio_effects.conf \
    device/zuk/mustang/mixer_paths.xml:system/etc/mixer_paths.xml \
    device/zuk/mustang/mixer_paths_tasha.xml:system/etc/mixer_paths_tasha.xml \
    device/zuk/mustang/mixer_paths_tasha_z2_row.xml:system/etc/mixer_paths_tasha_z2_row.xml \
    device/zuk/mustang/mixer_paths_dtp.xml:system/etc/mixer_paths_dtp.xml \
    device/zuk/mustang/mixer_paths_i2s.xml:system/etc/mixer_paths_i2s.xml \
    device/zuk/mustang/aanc_tuning_mixer.txt:system/etc/aanc_tuning_mixer.txt \
    device/zuk/mustang/audio_platform_info_i2s.xml:system/etc/audio_platform_info_i2s.xml \
    device/zuk/mustang/sound_trigger_mixer_paths.xml:system/etc/sound_trigger_mixer_paths.xml \
    device/zuk/mustang/sound_trigger_mixer_paths_wcd9330.xml:system/etc/sound_trigger_mixer_paths_wcd9330.xml \
    device/zuk/mustang/sound_trigger_platform_info.xml:system/etc/sound_trigger_platform_info.xml \
    device/zuk/mustang/audio_platform_info.xml:system/etc/audio_platform_info.xml

# Listen configuration file
PRODUCT_COPY_FILES += \
    device/zuk/mustang/listen_platform_info.xml:system/etc/listen_platform_info.xml

# WLAN driver configuration files
PRODUCT_COPY_FILES += \
    device/zuk/mustang/WCNSS_cfg.dat:system/etc/firmware/wlan/qca_cld/WCNSS_cfg.dat \
    device/zuk/mustang/WCNSS_qcom_cfg.ini:system/etc/wifi/WCNSS_qcom_cfg.ini

# Wifi
PRODUCT_PACKAGES += \
    wpa_supplicant_overlay.conf \
    p2p_supplicant_overlay.conf

# Sensor HAL conf file
PRODUCT_COPY_FILES += \
    device/zuk/mustang/sensors/hals.conf:system/etc/sensors/hals.conf
