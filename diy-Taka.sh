#!/bin/bash

#获取目录
CURRENT_DIR=$(cd $(dirname $0); pwd)
num=$(find $CURRENT_DIR -name gradlew  | awk -F"/" '{print NF-1}'| head -1)
DIR=$(find $CURRENT_DIR -name gradlew  | cut -d \/ -f$num | head -1)
cd $DIR
#签名
signingConfigs='ICAgIHNpZ25pbmdDb25maWdzIHtcCiAgICAgICAgaWYgKHByb2plY3QuaGFzUHJvcGVydHkoIlJFTEVBU0VfU1RPUkVfRklMRSIpKSB7XAogICAgICAgICAgICBteUNvbmZpZyB7XAogICAgICAgICAgICAgICAgc3RvcmVGaWxlIGZpbGUoUkVMRUFTRV9TVE9SRV9GSUxFKVwKICAgICAgICAgICAgICAgIHN0b3JlUGFzc3dvcmQgUkVMRUFTRV9TVE9SRV9QQVNTV09SRFwKICAgICAgICAgICAgICAgIGtleUFsaWFzIFJFTEVBU0VfS0VZX0FMSUFTXAogICAgICAgICAgICAgICAga2V5UGFzc3dvcmQgUkVMRUFTRV9LRVlfUEFTU1dPUkRcCiAgICAgICAgICAgICAgICB2MVNpZ25pbmdFbmFibGVkIHRydWVcCiAgICAgICAgICAgICAgICB2MlNpZ25pbmdFbmFibGVkIHRydWVcCiAgICAgICAgICAgICAgICBlbmFibGVWM1NpZ25pbmcgPSB0cnVlXAogICAgICAgICAgICAgICAgZW5hYmxlVjRTaWduaW5nID0gdHJ1ZVwKICAgICAgICAgICAgfVwKICAgICAgICB9XAogICAgfVwKXA=='
signingConfig='ICAgICAgICAgICAgaWYgKHByb2plY3QuaGFzUHJvcGVydHkoIlJFTEVBU0VfU1RPUkVfRklMRSIpKSB7XAogICAgICAgICAgICAgICAgc2lnbmluZ0NvbmZpZyBzaWduaW5nQ29uZmlncy5teUNvbmZpZ1wKICAgICAgICAgICAgfVwK'
signingConfigs="$(echo "$signingConfigs" |base64 -d )"
signingConfig="$(echo "$signingConfig" |base64 -d )"
sed -i -e "/defaultConfig {/i\\$signingConfigs " -e "/debug {/a\\$signingConfig " -e "/release {/a\\$signingConfig " $CURRENT_DIR/$DIR/app/build.gradle
cp -f $CURRENT_DIR/DIY/TVBoxOSC.jks $CURRENT_DIR/$DIR/app/TVBoxOSC.jks
cp -f $CURRENT_DIR/DIY/TVBoxOSC.jks $CURRENT_DIR/$DIR/TVBoxOSC.jks
echo "" >>$CURRENT_DIR/$DIR/gradle.properties
echo "RELEASE_STORE_FILE=./TVBoxOSC.jks" >>$CURRENT_DIR/$DIR/gradle.properties
echo "RELEASE_KEY_ALIAS=TVBoxOSC" >>$CURRENT_DIR/$DIR/gradle.properties
echo "RELEASE_STORE_PASSWORD=TVBoxOSC" >>$CURRENT_DIR/$DIR/gradle.properties
echo "RELEASE_KEY_PASSWORD=TVBoxOSC" >>$CURRENT_DIR/$DIR/gradle.properties
#xwalk修复
#sed -i 's/download.01.org\/crosswalk\/releases\/crosswalk\/android\/maven2/raw.githubusercontent.com\/lm317379829\/TVBoxDIY\/main/g' $CURRENT_DIR/$DIR/build.gradle

#版本号
sed -i 's/1.0.0/1.0.1/g' $CURRENT_DIR/$DIR/app/build.gradle

#增加参数
#sed -i '/android:layout_width="@dimen/vs_560"/a'  $CURRENT_DIR/$DIR/app/src/main/res/values/dimens.xml   
#其他
sed -i 's/6000/600/g'  $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/player/controller/VodController.java

# 默认设置
sed -i 's/HawkConfig.HOME_REC, 2/HawkConfig.HOME_REC, 2/g'  $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/base/App.java 

#主界面
cp $CURRENT_DIR/DIY/taka旧主界面.xml $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_user.xml
cp $CURRENT_DIR/DIY/activity_home_top界面.xml $CURRENT_DIR/$DIR/app/src/main/res/layout/activity_home.xml
sed -i 's/MM月dd日/yyyy年 MM月 dd日/g' $CURRENT_DIR/$DIR/app/src/main/res/values-zh/strings.xml
sed -i 's/dd MMM/dd MMM yyyy/g' $CURRENT_DIR/$DIR/app/src/main/res/values/strings.xml

#sed -i 's/@color/\"color_FFFFFF_80"/ "#FFFFFFFF"/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_use
#sed -i 's/"4dp"/""/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/activity_home.xml
#sed -i 's/"right|center_vertical"/"center_horizontal"/' $CURRENT_DIR/$DIR/app/src/main/res/layout/activity_home.xml
#sed -i 's/"09:30 PM"/"00:00"/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/player_vod_control_view.xml
#sed -i 's/@dimen/ts_24/40dp/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_user.xml
#sed -i 's/@color/"color_FFFFFF_80"/ "#FFFFFFFF"/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_user.xml
#sed -i 's/@color/"color_FFFFFF_80"/ "#FFFFFFFF"/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/item_setting_menu.xml
#sed -i 's/@color/"color_FFFFFF_70"/ "#FFFFFFFF"/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/item_home_sort.xml
#sed -i 's/EE hh:mm aa/EE hh:mm/g' $CURRENT_DIR/$DIR/app/src/main/res/values-zh/strings.xml
#sed -i 's/EE hh:mm aa/EE hh:mm/g' $CURRENT_DIR/$DIR/app/src/main/res/values/strings.xml
#共存
sed -i 's/com.github.tvbox.osc/com.tvbox.taka.py/g' $CURRENT_DIR/$DIR/app/build.gradle
#自定义epg
cp $CURRENT_DIR/DIY/epg_data.json $CURRENT_DIR/$DIR/app/src/main/assets/epg_data.json

#名称修改
sed -i 's/TVBox/TVBoxPy/g' $CURRENT_DIR/$DIR/app/src/main/res/values-zh/strings.xml
sed -i 's/TVBox/TVBoxPy/g' $CURRENT_DIR/$DIR/app/src/main/res/values/strings.xml
#图标修改
#mv $CURRENT_DIR/DIY/app_icon.png $CURRENT_DIR/$DIR/app/src/main/res/drawable/app_icon.png
#背景修改
cp $CURRENT_DIR/DIY/背景1.png $CURRENT_DIR/$DIR/app/src/main/res/drawable/app_bg.png


echo 'DIY end'
