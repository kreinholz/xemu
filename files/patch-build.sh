--- build.sh.orig	2025-09-06 23:47:31 UTC
+++ build.sh
@@ -12,14 +12,14 @@ package_windows() {
     rm -rf dist
     mkdir -p dist
     cp build/qemu-system-i386w.exe dist/xemu.exe
-    python3 "${project_source_dir}/get_deps.py" dist/xemu.exe dist
+    python3.11 "${project_source_dir}/get_deps.py" dist/xemu.exe dist
 }
 
 package_wincross() {
     rm -rf dist
     mkdir -p dist
     cp build/qemu-system-i386w.exe dist/xemu.exe
-    python3 ./scripts/gen-license.py --platform windows > dist/LICENSE.txt
+    python3.11 ./scripts/gen-license.py --platform windows > dist/LICENSE.txt
 }
 
 package_macos() {
@@ -76,17 +76,17 @@ package_macos() {
     plutil -replace CFBundleVersion            -string "${xemu_version}" dist/xemu.app/Contents/Info.plist
 
     codesign --force --deep --preserve-metadata=entitlements,requirements,flags,runtime --sign - "${exe_path}"
-    python3 ./scripts/gen-license.py --version-file=macos-libs/$target_arch/INSTALLED > dist/LICENSE.txt
+    python3.11 ./scripts/gen-license.py --version-file=macos-libs/$target_arch/INSTALLED > dist/LICENSE.txt
 }
 
-package_linux() {
+package_freebsd() {
     rm -rf dist
     mkdir -p dist
     cp build/qemu-system-i386 dist/xemu
     if test -e "${project_source_dir}/XEMU_LICENSE"; then
       cp "${project_source_dir}/XEMU_LICENSE" dist/LICENSE.txt
     else
-      python3 ./scripts/gen-license.py > dist/LICENSE.txt
+      python3.11 ./scripts/gen-license.py > dist/LICENSE.txt
     fi
 }
 
@@ -193,11 +193,11 @@ case "$platform" in # Adjust compilation options based
 }
 
 case "$platform" in # Adjust compilation options based on platform
-    Linux)
-        echo 'Compiling for Linux...'
+    FreeBSD)
+        echo 'Compiling for FreeBSD...'
         sys_cflags='-Wno-error=redundant-decls'
         opts="$opts --disable-werror"
-        postbuild='package_linux'
+        postbuild='package_freebsd'
         ;;
     Darwin)
         echo "Compiling for MacOS for $target_arch..."
@@ -216,7 +216,7 @@ case "$platform" in # Adjust compilation options based
           exit 1
         fi
 
-        python3 ./scripts/download-macos-libs.py ${target_arch}
+        python3.11 ./scripts/download-macos-libs.py ${target_arch}
         lib_prefix=${PWD}/macos-libs/${target_arch}/opt/local
         export CFLAGS="${CFLAGS} \
                        -arch ${target_arch} \
@@ -269,6 +269,6 @@ set -x # Print commands from now on
     ${opts} \
     "$@"
 
-time make -j"${job_count}" ${target} 2>&1 | tee build.log
+time gmake -j"${job_count}" ${target} 2>&1 | tee build.log
 
 "${postbuild}" # call post build functions
