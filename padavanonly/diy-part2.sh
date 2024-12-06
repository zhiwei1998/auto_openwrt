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
sed -i 's/192.168.6.1/10.10.2.1/g' package/base-files/files/bin/config_generate

# 添加编译日期标识
sed -i "s/(\(luciversion || ''\))/(\1) + (' \/ zhiwei1998 build $(TZ=UTC-8 date "+%Y-%m-%d-%H:%M")')/g" $(find ./feeds/luci/modules/luci-mod-status/ -type f -name "10_system.js")

# 修改immortalwrt.lan关联IP
sed -i "s/192\.168\.[0-9]*\.[0-9]*/10.10.2.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")


# 更新golang 版本
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 23.x feeds/packages/lang/golang

# drop mosdns and v2ray-geodata packages that come with the source
find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
find ./ | grep Makefile | grep mosdns | xargs rm -f

#git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/zhiwei1998/luci-app-mosdns -b v5.3.1 package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata



# Replace luci-app-ssr-plus & Depends
Replace_package="xray-core xray-plugin v2ray-core v2ray-plugin hysteria ipt2socks microsocks redsocks2 chinadns-ng dns2socks dns2tcp naiveproxy simple-obfs tcping tuic-client luci-app-ssr-plus"
./scripts/feeds uninstall ${Replace_package}
./scripts/feeds install -f -p helloworld ${Replace_package}




# theme
#sed -i "s/bootstrap/argon/g" feeds/luci/collections/luci/Makefile


# n2n v2.8
#rm -rf package/lean/n2n_v2
#cp -rf $GITHUB_WORKSPACE/n2n_v2/* package/lean/

# 修改nezha配置文件,关闭自动更新，强制更新
[ -s "feeds/nezha/luci-app-nezha/root/etc/init.d/nezha-agent" ] && sed -i 's/"${secret}"/"${secret}" --disable-auto-update --disable-command-execute --disable-force-update/g' feeds/nezha/luci-app-nezha/root/etc/init.d/nezha-agent

# 修改mwan3 放行ipv6
sed -i 's/ip6tables -t mangle -w/\/bin\/true/g' feeds/packages/net/mwan3/files/lib/mwan3/mwan3.sh

#./scripts/feeds update -a
#./scripts/feeds install -a

