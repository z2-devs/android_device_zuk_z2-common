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

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.audio.pro.xml:system/etc/permissions/android.hardware.audio.pro.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:system/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:system/etc/permissions/android.hardware.camera.raw.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:system/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.ambient_temperature.xml:system/etc/permissions/android.hardware.sensor.ambient_temperature.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.hifi_sensors.xml:system/etc/permissions/android.hardware.sensor.hifi_sensors.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.relative_humidity.xml:system/etc/permissions/android.hardware.sensor.relative_humidity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:system/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:system/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-0.xml:system/etc/permissions/android.hardware.vulkan.level.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_0_3.xml:system/etc/permissions/android.hardware.vulkan.version.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.software.midi.xml:system/etc/permissions/android.software.midi.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml

PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# Device was launched with M
PRODUCT_PROPERTY_OVERRIDES += \
    ro.product.first_api_level=23

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
    device/zuk/mustang/audio_platform_info_i2s.xml:system/etc/audio_platform_info_i2s.xml \
    device/zuk/mustang/sound_trigger_mixer_paths.xml:system/etc/sound_trigger_mixer_paths.xml \
    device/zuk/mustang/sound_trigger_mixer_paths_wcd9330.xml:system/etc/sound_trigger_mixer_paths_wcd9330.xml \
    device/zuk/mustang/sound_trigger_platform_info.xml:system/etc/sound_trigger_platform_info.xml \
    device/zuk/mustang/audio_platform_info.xml:system/etc/audio_platform_info.xml

# Listen configuration file
PRODUCT_COPY_FILES += \
    device/zuk/mustang/listen_platform_info.xml:system/etc/listen_platform_info.xml

# Sec_Configration
PRODUCT_COPY_FILES += \
    device/zuk/mustang/sec_config:system/etc/sec_config

# Ramdisk
PRODUCT_PACKAGES += \
    fstab.qcom \
    init.qcom.power.rc \
    init.qcom.rc \
    init.qcom.sh \
    init.qcom.usb.sh \
    init.target.rc \
    ueventd.qcom.rc

# Fingerprint
PRODUCT_PACKAGES += \
    fingerprint.msm8996 \
    fingerprintd

# Browser
PRODUCT_PACKAGES += \
    Gello

# Sensors
PRODUCT_PACKAGES += \
    sensors.msm8996

# Camera
PRODUCT_PACKAGES += \
    Snap \
    camera.msm8996

# Power
PRODUCT_PACKAGES += \
    power.msm8996

# Lights
PRODUCT_PACKAGES += \
    lights.msm8996

# GPS
PRODUCT_PACKAGES += \
    gps.msm8996 \
    libcurl

# Doze
PRODUCT_PACKAGES += \
    ZukDoze

#ANT+ stack
PRODUCT_PACKAGES += \
    AntHalService \
    libantradio \
    antradio_app \
    libvolumelistener

# WLAN driver configuration files
PRODUCT_COPY_FILES += \
    device/zuk/mustang/WCNSS_cfg.dat:system/etc/firmware/wlan/qca_cld/WCNSS_cfg.dat \
    device/zuk/mustang/WCNSS_qcom_cfg.ini:system/etc/wifi/WCNSS_qcom_cfg.ini

# Wifi
PRODUCT_PACKAGES += \
    wpa_supplicant_overlay.conf \
    p2p_supplicant_overlay.conf

PRODUCT_COPY_FILES += \
    device/zuk/mustang/wifi/hostapd.accept:system/etc/hostapd/hostapd.accept \
    device/zuk/mustang/wifi/hostapd.conf:system/etc/hostapd/hostapd_default.conf \
    device/zuk/mustang/wifi/hostapd.deny:system/etc/hostapd/hostapd.deny \

# Sensor HAL conf file
PRODUCT_COPY_FILES += \
    device/zuk/mustang/sensors/hals.conf:system/etc/sensors/hals.conf

# MSM IRQ Balancer configuration file
PRODUCT_COPY_FILES += \
    device/zuk/mustang/msm_irqbalance.conf:system/vendor/etc/msm_irqbalance.conf

# Keylayout
PRODUCT_PACKAGES += \
    gpio-keys.kl \
    qpnp_pon.kl \
    synaptics_dsx.kl

$(call inherit-product, vendor/zuk/mustang/mustang-vendor.mk)
