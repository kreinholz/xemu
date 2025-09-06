--- ui/xui/misc.hh.orig	2025-08-20 18:40:12 UTC
+++ ui/xui/misc.hh
@@ -24,9 +24,7 @@
 #include "common.hh"
 #include "xemu-hud.h"
 
-extern "C" {
-#include <noc_file_dialog.h>
-}
+#include "../thirdparty/noc_file_dialog/noc_file_dialog.h"
 
 static inline const char *PausedFileOpen(int flags, const char *filters,
                                          const char *default_path,
