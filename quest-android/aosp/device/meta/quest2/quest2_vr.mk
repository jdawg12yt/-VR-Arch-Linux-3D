$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product-if-exists, vendor/meta/quest2/quest2-vendor.mk)
$(call inherit-product, device/meta/quest2/device.mk)

PRODUCT_NAME := quest2_vr
PRODUCT_DEVICE := quest2
PRODUCT_BRAND := Meta
PRODUCT_MODEL := Quest 2 VR Port Scaffold
PRODUCT_MANUFACTURER := Meta
