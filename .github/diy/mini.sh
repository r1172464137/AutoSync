#!/bin/bash
function git_sparse_clone() {
branch="$1" rurl="$2" localdir="$3" && shift 3
git clone -b $branch --depth 1 --filter=blob:none --sparse $rurl $localdir
cd $localdir
git sparse-checkout init --cone
git sparse-checkout set $@
mv -n $@ ../
cd ..
rm -rf $localdir
}

function mvdir() {
mv -n `find $1/* -maxdepth 0 -type d` ./
rm -rf $1
}
git clone --depth 1 https://github.com/gdy666/luci-app-lucky
git clone --depth 1 -b openwrt-18.06 https://github.com/tty228/luci-app-wechatpush
git clone --depth 1 https://github.com/sirpdboy/luci-app-advanced
git clone --depth 1 https://github.com/sbwml/luci-app-mosdns openwrt-mos && mv -n openwrt-mos/{*mosdns,v2dat} ./; rm -rf openwrt-mos
git clone --depth 1 https://github.com/kiddin9/openwrt-packages && mv -n openwrt-packages/{*adguardhome,luci-app-fileassistant,} ./ ; rm -rf openwrt-packages
git clone --depth 1 https://github.com/jerrykuku/lua-maxminddb
git clone --depth 1 -b master https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic
git clone --depth 1 https://github.com/ophub/luci-app-amlogic amlogic && mv -n amlogic/luci-app-amlogic ./;rm -rf amlogic
git clone --depth 1 https://github.com/sbwml/luci-app-alist openwrt-alist && mv -n openwrt-alist/*alist ./ ; rm -rf openwrt-alist
git clone --depth 1 https://github.com/lisaac/luci-app-dockerman && mv -n luci-app-dockerman/applications/luci-app-dockerman ./ ; rm -rf sirpdboy-package
git clone --depth 1 https://github.com/vernesong/OpenClash && mv -n OpenClash/luci-app-openclash ./; rm -rf OpenClash
git clone --depth 1 https://github.com/kenzok8/wall && mv -n wall/UnblockNeteaseMusic wall/gost wall/smartdns wall/filebrowser ./ ; rm -rf wall
svn export https://github.com/immortalwrt/luci/branches/openwrt-18.06-k5.4/applications/luci-app-filebrowser
svn export https://github.com/coolsnowwolf/luci/trunk/libs/luci-lib-ipkg
git clone --depth 1 -b main https://github.com/xiaorouji/openwrt-passwall passwall1 && mv -n passwall1/luci-app-passwall  ./; rm -rf passwall1
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall2 passwall2 && mv -n passwall2/luci-app-passwall2 ./;rm -rf passwall2
svn export https://github.com/xiaorouji/openwrt-passwall-packages/trunk/sing-box

sed -i \
-e 's?include \.\./\.\./\(lang\|devel\)?include $(TOPDIR)/feeds/packages/\1?' \
-e 's?2. Clash For OpenWRT?3. Applications?' \
-e 's?\.\./\.\./luci.mk?$(TOPDIR)/feeds/luci/luci.mk?' \
-e 's/ca-certificates/ca-bundle/' \
*/Makefile

sed -i 's/luci-lib-ipkg/luci-base/g' luci-app-store/Makefile
sed -i 's/+dockerd/+dockerd +cgroupfs-mount/' luci-app-docker*/Makefile
sed -i '$i /etc/init.d/dockerd restart &' luci-app-docker*/root/etc/uci-defaults/*
sed -i 's/+libcap /+libcap +libcap-bin /' luci-app-openclash/Makefile
#sed -i 's/\(+luci-compat\)/\1 +luci-theme-argon/' luci-app-argon-config/Makefile
#sed -i 's/\(+luci-compat\)/\1 +luci-theme-design/' luci-theme-design-config/Makefile
#sed -i 's/\(+luci-compat\)/\1 +luci-theme-argone/' luci-app-argone-config/Makefile
#sed -i -e 's/nas/services/g' -e 's/NAS/Services/g' $(grep -rl 'nas\|NAS' luci-app-fileassistant)
#sed -i '65,73d' adguardhome/Makefile
rm -rf ./*/.git ./*/.gitattributes ./*/.svn ./*/.github ./*/.gitignore create_acl_for_luci.err create_acl_for_luci.ok create_acl_for_luci.warn

sed -i \
-e 's?include \.\./\.\./\(lang\|devel\)?include $(TOPDIR)/feeds/packages/\1?' \
-e 's?\.\./\.\./luci.mk?$(TOPDIR)/feeds/luci/luci.mk?' \
*/Makefile
#rm -rf adguardhome/patches
rm -rf ./*/.git ./*/.gitattributes ./*/.svn ./*/.github ./*/.gitignore
#find . -type f -name Makefile -exec sed -i 's/PKG_BUILD_FLAGS:=no-mips16/PKG_USE_MIPS16:=0/g' {} +
#sed -i '59s/.*/local port=luci.sys.exec("awk \x27\/^dns:\/ {found_dns=1} found_dns \x26\x26 \/\^ port:\/ {print $2; exit}\x27 "..configpath.." 2>nul")/' luci-app-adguardhome/luasrc/model/cbi/AdGuardHome/base.lua
exit 0

