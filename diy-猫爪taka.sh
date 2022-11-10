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

#版本号
sed -i 's/1.0.0/1.0.2/g' $CURRENT_DIR/$DIR/app/build.gradle
#关于
sed -i 's/ android:text="@string/mn_about"/ android:text="关于\\n1.0.2"/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_model.xml
#主界面
#cp $CURRENT_DIR/DIY/taka旧主界面.xml $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_user.xml
#cp $CURRENT_DIR/DIY/activity_home_top界面.xml $CURRENT_DIR/$DIR/app/src/main/res/layout/activity_home.xml
sed -i 's/MM月dd日/yyyy年 MM月 dd日/g' $CURRENT_DIR/$DIR/app/src/main/res/values-zh/strings.xml
sed -i 's/dd MMM/dd MMM yyyy/g' $CURRENT_DIR/$DIR/app/src/main/res/values/strings.xml

#首页多排
sed -i 's/800/570/g'  $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/HomeActivity.java
sed -i 's/getContext(), 3/getContext(), 2/g'  $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/HomeActivity.java

#共存
sed -i 's/com.github.tvbox.osc/com.tvbox.watson.taka/g' $CURRENT_DIR/$DIR/app/build.gradle
#自定义epg
cp $CURRENT_DIR/DIY/epg_data.json $CURRENT_DIR/$DIR/app/src/main/assets/epg_data.json

#名称修改
sed -i 's/TVBox/TVBoxPy/g' $CURRENT_DIR/$DIR/app/src/main/res/values-zh/strings.xml
sed -i 's/TVBox/TVBoxPy/g' $CURRENT_DIR/$DIR/app/src/main/res/values/strings.xml
#图标修改
#mv $CURRENT_DIR/DIY/app_icon.png $CURRENT_DIR/$DIR/app/src/main/res/drawable/app_icon.png
#背景修改
#cp $CURRENT_DIR/DIY/背景1.png $CURRENT_DIR/$DIR/app/src/main/res/drawable/app_bg.png


echo 'DIY end'
