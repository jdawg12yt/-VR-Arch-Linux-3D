# Quest 2 device makefile placeholder.

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.quest2.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.quest2.rc

PRODUCT_PACKAGES += \
    vr_launcher_stub

# Keep the initial scaffold conservative.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.surface_flinger.has_wide_color_display=true
