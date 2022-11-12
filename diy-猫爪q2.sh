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

#taka版本替换q2
cp $CURRENT_DIR/DIY/strings.xml $CURRENT_DIR/$DIR/app/src/main/res/values/strings.xml

#版本号
sed -i 's/1.0.0/1.1.9/g' $CURRENT_DIR/$DIR/app/build.gradle

#设置界面
cp $CURRENT_DIR/DIY/PlayActivity.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/PlayActivity.java
cp $CURRENT_DIR/DIY/LivePlayActivity.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/LivePlayActivity.java
cp $CURRENT_DIR/DIY/DetailActivity.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/DetailActivity.java

cp $CURRENT_DIR/DIY/AndroidManifest.xml $CURRENT_DIR/$DIR/app/src/main/AndroidManifest.xml
cp $CURRENT_DIR/DIY/HomeActivity.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/HomeActivity.java
cp $CURRENT_DIR/DIY/HawkConfig.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/util/HawkConfig.java
cp $CURRENT_DIR/DIY/ModelSettingFragment.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/fragment/ModelSettingFragment.java

cp $CURRENT_DIR/DIY/dialog_about_关于.xml $CURRENT_DIR/$DIR/app/src/main/res/layout/dialog_about.xml 
sed -i 's/epgApi"/epgApi" android:visibility="gone"/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_model.xml
#sed -i 's/关于/关于\\n1.1.9/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_model.xml
cp $CURRENT_DIR/DIY/fragment_model.xml $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_model.xml
sed -i 's/1.0.0 /1.2.0/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_model.xml

//按键背景颜色
sed -i 's/color_808080_95/color_FFFFFF/g' $CURRENT_DIR/$DIR/app/src/main/res/drawable/shape_dialog_bg_main.xml

#增加参数
sed -i '/android:layout_width="@dimen/vs_560"/a'  $CURRENT_DIR/$DIR/app/src/main/res/values/dimens.xml   
#设置进度条消失时间
sed -i 's/6000/5000/g'  $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/player/controller/VodController.java

#首页多排
#sed -i 's/800/570/g'  $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/HomeActivity.java
sed -i 's/dialog.getContext(), 380+200/dialog.getContext(), 280+300/g'  $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/HomeActivity.java

# 默认设置
#cp $CURRENT_DIR/DIY/App.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/base/App.java  

#播放界面修改
sed -i 's/"上一集"/ "上集"/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/player_vod_control_view.xml
sed -i 's/"下一集"/ "下集"/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/player_vod_control_view.xml
sed -i 's/片头片尾//' $CURRENT_DIR/$DIR/app/src/main/res/layout/player_vod_control_view.xml

#共存
sed -i 's/com.github.tvbox.osc/com.tvbox.watson2/g' $CURRENT_DIR/$DIR/app/build.gradle

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
sed -i 's/color_BBFFFFFF/color_FFFFFF/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/item_home_sort.xml
sed -i 's/color_BBFFFFFF/color_FFFFFF/g' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/HomeActivity.java



echo 'DIY end'
