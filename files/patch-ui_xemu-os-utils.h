--- ui/xemu-os-utils.h.orig	2025-09-05 20:04:53 UTC
+++ ui/xemu-os-utils.h
@@ -43,6 +43,8 @@ static inline const char *xemu_get_os_platform(void)
     platform_name = "Windows";
 #elif defined(__APPLE__)
     platform_name = "macOS";
+#elif defined(__FreeBSD__)
+    platform_name = "FreeBSD";
 #else
     platform_name = "Unknown";
 #endif
