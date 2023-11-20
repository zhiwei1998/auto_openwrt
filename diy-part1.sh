#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >>feeds.conf.default
echo 'src-git small https://github.com/kenzok8/small' >>feeds.conf.default
echo 'src-git nezha https://github.com/Erope/openwrt_nezha' >>feeds.conf.default


#git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter

#rm -rf package/lean/luci-theme-argon
#git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon

#git clone https://github.com/sirpdboy/luci-app-advanced package/lean/luci-app-advanced

# n2n v2.8
#rm -rf package/lean/n2n_v2
#cp -rf $GITHUB_WORKSPACE/n2n_v2 package/lean/

# 删除lede自带的mosdns
rm -rf "feeds/luci/applications/luci-app-mosdns"
rm -rf "feeds/packages/net/mosdns"
