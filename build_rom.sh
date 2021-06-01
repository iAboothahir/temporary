# sync rom
repo init -u https://github.com/StatiXOS/android_manifest.git -b 11 --depth=1 --no-repo-verify -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/cArN4gEisDeD/local_manifest --depth=1 -b StatiX .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# patches
cd external/selinux
curl -LO https://github.com/PixelExperience/external_selinux/commit/9d6ebe89430ffe0aeeb156f572b2a810f9dc98cc.patch
patch -p1 < *.patch
cd ../..

# build rom 
source build/envsetup.sh
lunch statix_RMX1941-userdebug  
brunch statix_RMX1941-userdebug 

# upload rom
rclone copy out/target/product/RMX1941/*UNOFFICIAL*.zip cirrus:RMX1941 -P
