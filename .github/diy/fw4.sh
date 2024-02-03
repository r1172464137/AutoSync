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
git clone --depth 1 https://github.com/immortalwrt/homeproxy
svn export https://github.com/x-wrt/com.x-wrt/trunk/luci-app-fakemesh

sed -i \
-e 's?include \.\./\.\./\(lang\|devel\)?include $(TOPDIR)/feeds/packages/\1?' \
-e 's?\.\./\.\./luci.mk?$(TOPDIR)/feeds/luci/luci.mk?' \
*/Makefile
#rm -rf adguardhome/patches
rm -rf ./*/.git ./*/.gitattributes ./*/.svn ./*/.github ./*/.gitignore create_acl_for_luci.err create_acl_for_luci.ok create_acl_for_luci.warn
#find . -type f -name Makefile -exec sed -i 's/PKG_BUILD_FLAGS:=no-mips16/PKG_USE_MIPS16:=0/g' {} +
#sed -i '59s/.*/local port=luci.sys.exec("awk \x27\/^dns:\/ {found_dns=1} found_dns \x26\x26 \/\^ port:\/ {print $2; exit}\x27 "..configpath.." 2>nul")/' luci-app-adguardhome/luasrc/model/cbi/AdGuardHome/base.lua
exit 0
