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
git clone --depth 1 https://github.com/gngpp/luci-theme-design
git clone --depth 1 https://github.com/gngpp/luci-app-design-config
git clone --depth 1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon
git clone --depth 1 -b 18.06 https://github.com/jerrykuku/luci-app-argon-config
git clone --depth 1 https://github.com/sirpdboy/luci-theme-opentopd
git clone --depth 1 https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom ifit && mv -n ifit/luci-theme-infinityfreedom ./;rm -rf ifit
git clone --depth 1 https://github.com/kenzok8/litte && mv -n litte/luci-theme-atmaterial_new litte/luci-theme-tomato ./ ; rm -rf litte


sed -i \
-e 's?include \.\./\.\./\(lang\|devel\)?include $(TOPDIR)/feeds/packages/\1?' \
-e 's?\.\./\.\./luci.mk?$(TOPDIR)/feeds/luci/luci.mk?' \
*/Makefile

rm -rf ./*/.git ./*/.gitattributes ./*/.svn ./*/.github ./*/.gitignore create_acl_for_luci.err create_acl_for_luci.ok create_acl_for_luci.warn
#find . -type f -name Makefile -exec sed -i 's/PKG_BUILD_FLAGS:=no-mips16/PKG_USE_MIPS16:=0/g' {} +
exit 0
