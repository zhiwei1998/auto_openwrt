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


# Add a feed source
echo "src-git helloworld https://github.com/fw876/helloworld.git;master" >> "feeds.conf.default"
#echo 'src-git nezha https://github.com/Erope/openwrt_nezha' >>feeds.conf.default
echo 'src-git nezha https://github.com/zhiwei1998/openwrt_nezha' >>feeds.conf.default




