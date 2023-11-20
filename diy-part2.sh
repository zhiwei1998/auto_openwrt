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
sed -i 's/192.168.1.1/10.10.2.1/g' package/base-files/files/bin/config_generate
#sed -i 's/192.168/10.10/g' package/base-files/files/bin/config_generate

# Add date version
#export DATE_VERSION=$(date +'%Y-%m-%d-%H%M')
#sed -i "s/%C/%C (${DATE_VERSION})/g" package/base-files/files/etc/openwrt_release

# 加入编译者信息
sed -i "s/OpenWrt /zhiwei1998 build $(TZ=UTC-8 date "+%Y-%m-%d-%H:%M") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings

# theme
sed -i "s/bootstrap/argon/g" feeds/luci/collections/luci/Makefile

# 超频1100
cp $GITHUB_WORKSPACE/102-mt7621-fix-cpu-clk-add-clkdev.patch target/linux/ramips/patches-5.4/

# n2n v2.8
#rm -rf package/lean/n2n_v2
#cp -rf $GITHUB_WORKSPACE/n2n_v2/* package/lean/

# 修改nezha配置文件
[ -s "feeds/nezha/luci-app-nezha/root/etc/init.d/nezha-agent" ] && sed -i 's/"${secret}"/"${secret}" --skip-conn --skip-procs/g' feeds/nezha/luci-app-nezha/root/etc/init.d/nezha-agent

# 更换8812au驱动
#svn co https://github.com/immortalwrt/immortalwrt/branches/master/package/kernel/rtl8812au-ac package/rtl8812au-ac

# 删除lede自带的mosdns
rm -rf "feeds/luci/applications/luci-app-mosdns"
rm -rf "feeds/packages/net/mosdns"

./scripts/feeds update -a
./scripts/feeds install -a
