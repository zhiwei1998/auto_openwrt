
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
sed -i 's/192.168.1.1/10.10.2.100/g' package/base-files/files/bin/config_generate
#sed -i 's/192.168/10.10/g' package/base-files/files/bin/config_generate

# Add date version
export DATE_VERSION=$(date +'%Y-%m-%d-%H%M')
sed -i "s/%C/%C (${DATE_VERSION})/g" package/base-files/files/etc/openwrt_release

# theme
sed -i "s/bootstrap/argon/g" feeds/luci/collections/luci/Makefile

# n2n v2.8
#rm -rf package/lean/n2n_v2
#cp -rf $GITHUB_WORKSPACE/n2n_v2/* package/lean/

# 修改nezha配置文件
#[ -s "feeds/nezha/luci-app-nezha/root/etc/init.d/nezha-agent" ] && sed -i 's/"${secret}"/"${secret}" --skip-conn --skip-procs/g' feeds/nezha/luci-app-nezha/root/etc/init.d/nezha-agent

