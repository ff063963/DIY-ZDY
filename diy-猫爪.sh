#!/bin/bash

#获取目录
CURRENT_DIR=$(cd $(dirname $0); pwd)
num=$(find $CURRENT_DIR -name gradlew  | awk -F"/" '{print NF-1}')
DIR=$(find $CURRENT_DIR -name gradlew  | cut -d \/ -f$num)
cd $CURRENT_DIR/$DIR

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


#版本号
sed -i 's/1.0.0/1.1.7/g' $CURRENT_DIR/$DIR/app/build.gradle


#设置界面
cp $CURRENT_DIR/DIY/fragment_model.xml $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_model.xml 
sed -i 's/关于/关于                                                                   1.1.7/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_model.xml

#增加参数
sed -i '/android:layout_width="@dimen/vs_560"/a'  $CURRENT_DIR/$DIR/app/src/main/res/values/dimens.xml   
#设置进度条消失时间
sed -i 's/6000/7000/g'  $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/player/controller/VodController.java

# 播放界面
#cp $CURRENT_DIR/DIY/player_vod_control_view.xml $CURRENT_DIR/$DIR/app/src/main/res/layout/player_vod_control_view.xml 

# 默认设置
cp $CURRENT_DIR/DIY/App.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/base/App.java  

#taka版本替换q2
cp $CURRENT_DIR/DIY/strings.xml $CURRENT_DIR/$DIR/app/src/main/res/values/strings.xml

#主界面
#sed -i 's/ts_40/ts_34/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_user.xml
#sed -i 's/"@color/color_CCFFFFFF"/ "#FFFFFFFF"/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_user.xml
#cp $CURRENT_DIR/DIY/fragment_user.xml $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_user.xml

#播放界面修改

sed -i 's/"上一集"/ "上集"/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/player_vod_control_view.xml
sed -i 's/"下一集"/ "下集"/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/player_vod_control_view.xml
sed -i 's/片头片尾//' $CURRENT_DIR/$DIR/app/src/main/res/layout/player_vod_control_view.xml

#共存
#sed -i 's/com.github.tvbox.osc/com.tvbox.q2.py/g' $CURRENT_DIR/$DIR/app/build.gradle

#自定义epg
cp $CURRENT_DIR/DIY/epg_data.json $CURRENT_DIR/$DIR/app/src/main/assets/epg_data.json

#名称修改
sed -i 's/TVBox/TVBoxPy/g' $CURRENT_DIR/$DIR/app/src/main/res/values/strings.xml

#图标修改
cp $CURRENT_DIR/DIY/原版透明.png $CURRENT_DIR/$DIR/app/src/main/res/drawable-hdpi/app_icon.png
cp $CURRENT_DIR/DIY/原版透明.png $CURRENT_DIR/$DIR/app/src/main/res/drawable-xhdpi/app_icon.png
cp $CURRENT_DIR/DIY/原版透明.png $CURRENT_DIR/$DIR/app/src/main/res/drawable-xxhdpi/app_icon.png
mv $CURRENT_DIR/DIY/原版透明.png $CURRENT_DIR/$DIR/app/src/main/res/drawable-xxxhdpi/app_icon.png

#背景修改
cp $CURRENT_DIR/DIY/背景1.png $CURRENT_DIR/$DIR/app/src/main/res/drawable/app_bg.png

#主界面历史文字颜色修改
#sed -i 's/color_CCFFFFFF/color_FFFFFF/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_user.xml

#主界面首页文字颜色修改
cp $CURRENT_DIR/DIY/多排首页.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/HomeActivity.java
sed -i 's/color_BBFFFFFF/color_FFFFFF/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/item_home_sort.xml
sed -i 's/color_BBFFFFFF/color_FFFFFF/g' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/HomeActivity.java
#增加听书嗅探
#cp $CURRENT_DIR/DIY/libplayer.so $CURRENT_DIR/$DIR/player/src/main/jniLibs/armeabi-v7a/libplayer.so
#sed -i 's/|mp4|/|mp4|mp3|m4a|p2p|/'g $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/util/DefaultConfig.java

#FongMi的jar支持
echo "" >>$CURRENT_DIR/$DIR/app/proguard-rules.pro
echo "-keep class com.google.gson.**{*;}" >>$CURRENT_DIR/$DIR/app/proguard-rules.pro

echo 'DIY end'
