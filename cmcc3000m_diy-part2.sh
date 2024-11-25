#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/10.10.3.1/g' package/base-files/files/bin/config_generate


# 更新golang 版本
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 23.x feeds/packages/lang/golang

# drop mosdns and v2ray-geodata packages that come with the source
find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
find ./ | grep Makefile | grep mosdns | xargs rm -f

git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata




# Replace luci-app-ssr-plus & Depends
Replace_package="xray-core xray-plugin v2ray-core v2ray-plugin hysteria ipt2socks microsocks redsocks2 chinadns-ng dns2socks dns2tcp naiveproxy simple-obfs tcping tuic-client luci-app-ssr-plus"
./scripts/feeds uninstall ${Replace_package}
./scripts/feeds install -f -p helloworld ${Replace_package}



# 加入编译者信息
#sed -i "s/OpenWrt /zhiwei1998 build $(TZ=UTC-8 date "+%Y-%m-%d-%H:%M") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings

# theme
#sed -i "s/bootstrap/argon/g" feeds/luci/collections/luci/Makefile


# n2n v2.8
#rm -rf package/lean/n2n_v2
#cp -rf $GITHUB_WORKSPACE/n2n_v2/* package/lean/

# 修改nezha配置文件
[ -s "feeds/nezha/luci-app-nezha/root/etc/init.d/nezha-agent" ] && sed -i 's/"${secret}"/"${secret}" --skip-conn --skip-procs/g' feeds/nezha/luci-app-nezha/root/etc/init.d/nezha-agent

# 更换8812au驱动
#svn co https://github.com/immortalwrt/immortalwrt/branches/master/package/kernel/rtl8812au-ac package/rtl8812au-ac



#./scripts/feeds update -a
#./scripts/feeds install -a

#sed -i 's#GO_PKG_TARGET_VARS.*# #g' feeds/packages/utils/v2dat/Makefile
