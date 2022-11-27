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


#画中画
cp $CURRENT_DIR/DIY/AndroidManifest.xml $CURRENT_DIR/$DIR/app/src/main/AndroidManifest.xml
cp $CURRENT_DIR/DIY/HawkConfig.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/util/HawkConfig.java
#设置界面
mv $CURRENT_DIR/DIY/HomeActivity自定义.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/HomeActivity.java
cp $CURRENT_DIR/DIY/ModelSettingFragment自定义.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/fragment/ModelSettingFragment.java

//设置界面修改
cp $CURRENT_DIR/DIY/fragment_model.xml $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_model.xml

#sed -i 's/关于/关于\\n1.3.0/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_model.xml
#sed -i 's/1.0.0 /1.2.8/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_model.xml
sed -i 's/版本/版本\\n1.3.1/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_model.xml

#版本号
sed -i 's/1.0.0/1.3.1/g' $CURRENT_DIR/$DIR/app/build.gradle

#共存
sed -i 's/com.github.tvbox.osc/com.tvbox.q/g' $CURRENT_DIR/$DIR/app/build.gradle



#名称修改
sed -i 's/TVBox/影视Box/g' $CURRENT_DIR/$DIR/app/src/main/res/values/strings.xml

//主界面修改
cp $CURRENT_DIR/DIY/fragment_user自定义.xml $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_user.xml
cp $CURRENT_DIR/DIY/UserFragment自定义.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/fragment/UserFragment.java

//增加存储
mv $CURRENT_DIR/DIY/icon_drive.xml $CURRENT_DIR/$DIR/app/src/main/res/drawable/icon_drive.xml
sed -i 's/tvDrive"/ tvDrive" android:visibility="gone"/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_user.xml
#mv $CURRENT_DIR/DIY/DetailActivity.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/DetailActivity.java

//增加版本 更新说明
mv $CURRENT_DIR/DIY/VersionDialog.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/dialog/VersionDialog.java
mv $CURRENT_DIR/DIY/dialog_version.xml $CURRENT_DIR/$DIR/app/src/main/res/layout/dialog_version.xml
sed -i 's/6666/部分UI修改/g'   $CURRENT_DIR/$DIR/app/src/main/res/layout/dialog_version.xml



//关于说明
cp $CURRENT_DIR/DIY/dialog_about_关于.xml $CURRENT_DIR/$DIR/app/src/main/res/layout/dialog_about.xml 
#sed -i 's/epgApi"/epgApi" android:visibility="gone"/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_model.xml


#播放界面修改
#mv $CURRENT_DIR/DIY/vod_ffwd.xml  $CURRENT_DIR/$DIR/app/src/main/res/drawable/vod_ffwd.xml
#mv $CURRENT_DIR/DIY/vod_play.xml  $CURRENT_DIR/$DIR/app/src/main/res/drawable/vod_play.xml

mv $CURRENT_DIR/DIY/play_mobile_center_shape.xml  $CURRENT_DIR/$DIR/app/src/main/res/drawable/play_mobile_center_shape.xml
mv $CURRENT_DIR/DIY/shape_dialog_top_bg.xml  $CURRENT_DIR/$DIR/app/src/main/res/drawable/shape_dialog_top_bg.xml
cp $CURRENT_DIR/DIY/misc.xml  $CURRENT_DIR/$DIR/.idea/misc.xml
cp $CURRENT_DIR/DIY/player_vod_control_view.xml  $CURRENT_DIR/$DIR/app/src/main/res/layout/player_vod_control_view.xml
cp $CURRENT_DIR/DIY/player_live_control_view.xml  $CURRENT_DIR/$DIR/app/src/main/res/layout/player_live_control_view.xml
cp $CURRENT_DIR/DIY/icon_vodcontroller_unlock.xml  $CURRENT_DIR/$DIR/app/src/main/res/drawable/icon_vodcontroller_unlock.xml

sed -i 's/"上一集"/ "上集"/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/player_vod_control_view.xml
sed -i 's/"下一集"/ "下集"/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/player_vod_control_view.xml
sed -i 's/片头片尾//' $CURRENT_DIR/$DIR/app/src/main/res/layout/player_vod_control_view.xml

#播放界面增加完结时间
cp $CURRENT_DIR/DIY/VodController.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/player/controller/VodController.java

#更改播放背景
#进度条
sed -i 's/color_353744/color_1890FF/g' $CURRENT_DIR/$DIR/app/src/main/res/drawable/shape_player_control_vod_seek.xml

#sed -i 's/color_66000000/color_FFFFFF/g' $CURRENT_DIR/$DIR/app/src/main/res/drawable/box_controller_top_bg.xml
#圆点
#sed -i 's/color_1890FF/color_FFFFFF/g' $CURRENT_DIR/$DIR/app/src/main/res/drawable/shape_player_control_vod_seek_thumb_press.xml

#增加听书嗅探
sed -i 's/|mp4|/|mp4|mp3|m4a|p2p|/'g $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/util/DefaultConfig.java

//设置界面选择文字修改
sed -i 's/站点推荐/推荐/g' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/fragment/ModelSettingFragment.java
sed -i 's/观看历史/历史/g' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/fragment/ModelSettingFragment.java
sed -i 's/豆瓣热播/豆瓣/g' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/fragment/ModelSettingFragment.java
sed -i 's/文字列表/文字/g' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/fragment/ModelSettingFragment.java
sed -i 's/缩略图/图片/g' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/fragment/ModelSettingFragment.java
sed -i 's/已开启/开启/g' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/fragment/ModelSettingFragment.java
sed -i 's/已关闭/关闭/g' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/fragment/ModelSettingFragment.java
sed -i 's/系统自带/系统/g' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/fragment/ModelSettingFragment.java
sed -i 's/硬解码/硬解/g' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/bean/LivePlayerManager.java
sed -i 's/硬解码/软解/g' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/bean/LivePlayerManager.java
//设置界面文字修改
sed -i 's/IJK解码方式/解码方式/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_model.xml
sed -i 's/搜索附近TVBox/搜索附近/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_model.xml
sed -i 's/数据备份还原/备份还原/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_model.xml
sed -i 's/关于/软件说明/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_model.xml
sed -i 's/播放器/播放方式/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_model.xml
sed -i 's/版本/版本更新/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_model.xml
sed -i 's/嗅探Webview/嗅探方式/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_model.xml
sed -i 's/换张壁纸/更换壁纸/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_model.xml
sed -i 's/画中画/显画中画/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_model.xml
//删除播放器
sed -i 's/播放器//g' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/util/PlayerHelper.java

//按键背景颜色
#sed -i 's/color_808080_95/color_FFFFFF/g' $CURRENT_DIR/$DIR/app/src/main/res/drawable/shape_dialog_bg_main.xml

#增加参数
sed -i '/android:layout_width="@dimen/vs_560"/a'  $CURRENT_DIR/$DIR/app/src/main/res/values/dimens.xml   
#设置进度条消失时间
sed -i 's/6000/5000/g'  $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/player/controller/VodController.java

# 默认设置
cp $CURRENT_DIR/DIY/App.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/base/App.java  

#自定义epg
cp $CURRENT_DIR/DIY/epg_data.json $CURRENT_DIR/$DIR/app/src/main/assets/epg_data.json

#增加颜色
cp $CURRENT_DIR/DIY/colors自定义.xml $CURRENT_DIR/$DIR/app/src/main/res/values/colors.xml



#图标修改
cp $CURRENT_DIR/DIY/原版透明.png $CURRENT_DIR/$DIR/app/src/main/res/drawable-hdpi/app_icon.png
cp $CURRENT_DIR/DIY/原版透明.png $CURRENT_DIR/$DIR/app/src/main/res/drawable-xhdpi/app_icon.png
cp $CURRENT_DIR/DIY/原版透明.png $CURRENT_DIR/$DIR/app/src/main/res/drawable-xxhdpi/app_icon.png
mv $CURRENT_DIR/DIY/原版透明.png $CURRENT_DIR/$DIR/app/src/main/res/drawable-xxxhdpi/app_icon.png

#背景修改
cp $CURRENT_DIR/DIY/背景1.png $CURRENT_DIR/$DIR/app/src/main/res/drawable/app_bg.png


#首页排版边框
sed -i 's/vs_30/vs_15/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/dialog_select.xml
#首页多排
#sed -i 's/sites.size()/60/sites.size()/10/g'  $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/HomeActivity.java
sed -i 's/380+200/300+140/g'  $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/HomeActivity.java
sed -i 's/spanCount+1/spanCount/g'  $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/HomeActivity.java



#主界面文字修改
#sed -i 's/ts_40/ts_30/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_user.xml
#图标大小
#sed -i 's/vs_50/vs_40/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_user.xml  
#sed -i 's/vs_100/vs_80/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_user.xml
#sed -i 's/0.75/1/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_user.xml
sed -i 's/color_CCFFFFFF/color_FFFFFF_85/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_user.xml
#主界面首页文字修改
sed -i 's/color_BBFFFFFF/color_FFFFFF/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/item_home_sort.xml
sed -i 's/color_BBFFFFFF/color_FFFFFF/g' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/HomeActivity.java


#添加详情页播放列表宽度自适
#sed -i '/import me.jessyan.autosize.utils.AutoSizeUtils;/a\import android.graphics.Rect;\nimport android.graphics.Paint;\nimport android.text.TextPaint;\nimport androidx.annotation.NonNull;\nimport android.graphics.Typeface;\nimport androidx.recyclerview.widget.RecyclerView;' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/DetailActivity.java
#sed -i '/private View seriesFlagFocus = null;/a\    private V7GridLayoutManager mGridViewLayoutMgr = null;' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/DetailActivity.java
sed -i 's/mGridView.setLayoutManager(new V7GridLayoutManager(this.mContext, isBaseOnWidth() ? 6 : 7));/mGridView.setHasFixedSize(false);\n        this.mGridViewLayoutMgr = new V7GridLayoutManager(this.mContext, isBaseOnWidth() ? 6 : 7);\n        mGridView.setLayoutManager(this.mGridViewLayoutMgr);\n/g' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/DetailActivity.java
#sed -i '/seriesAdapter.setNewData(vodInfo.seriesMap.get(vodInfo.playFlag));/i\        Paint pFont = new Paint();\n        Rect rect = new Rect();\n        List<VodInfo.VodSeries> list = vodInfo.seriesMap.get(vodInfo.playFlag);\n        int w = 1;\n        for(int i =0; i < list.size(); ++i){\n            String name = list.get(i).name;\n            pFont.getTextBounds(name, 0, name.length(), rect);\n            if(w < rect.width()){\n                w = rect.width();\n            }\n        }\n        w += 32;\n        int screenWidth = getWindowManager().getDefaultDisplay().getWidth()\/3;\n        int offset = screenWidth\/w;\n        if(offset <=1) offset =1;\n        if(offset > 6) offset =6;\n        this.mGridViewLayoutMgr.setSpanCount(offset);\n' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/DetailActivity.java
sed -i 's/FrameLayout/LinearLayout/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/item_series.xml
sed -i 's/width=\"wrap_content\"/width=\"match_parent\"/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/item_series.xml
sed -i 's/@dimen\/vs_190/match_parent/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/item_series.xml


#添加PY支持
wget --no-check-certificate -qO- "https://raw.githubusercontent.com/UndCover/PyramidStore/main/aar/pyramid-1011.aar" -O $CURRENT_DIR/$DIR/app/libs/pyramid.aar
sed -i "/thunder.jar/a\    implementation files('libs@pyramid.aar')" $CURRENT_DIR/$DIR/app/build.gradle
sed -i 's#@#\\#g' $CURRENT_DIR/$DIR/app/build.gradle
sed -i 's#pyramid#\\pyramid#g' $CURRENT_DIR/$DIR/app/build.gradle
echo "" >>$CURRENT_DIR/$DIR/app/proguard-rules.pro
echo "" >>$CURRENT_DIR/$DIR/app/proguard-rules.pro
echo "#添加PY支持" >>$CURRENT_DIR/$DIR/app/proguard-rules.pro
echo "-keep public class com.undcover.freedom.pyramid.** { *; }" >>$CURRENT_DIR/$DIR/app/proguard-rules.pro
echo "-dontwarn com.undcover.freedom.pyramid.**" >>$CURRENT_DIR/$DIR/app/proguard-rules.pro
echo "-keep public class com.chaquo.python.** { *; }" >>$CURRENT_DIR/$DIR/app/proguard-rules.pro
echo "-dontwarn com.chaquo.python.**" >>$CURRENT_DIR/$DIR/app/proguard-rules.pro
sed -i '/import com.orhanobut.hawk.Hawk;/a\import com.undcover.freedom.pyramid.PythonLoader;' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/base/App.java
sed -i '/import com.orhanobut.hawk.Hawk;/a\import com.github.catvod.crawler.SpiderNull;' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/base/App.java
sed -i '/PlayerHelper.init/a\        PythonLoader.getInstance().setApplication(this);' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/base/App.java
sed -i '/import android.util.Base64;/a\import com.github.catvod.crawler.SpiderNull;' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/api/ApiConfig.java
sed -i '/import android.util.Base64;/a\import com.undcover.freedom.pyramid.PythonLoader;' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/api/ApiConfig.java
sed -i '/private void parseJson(String apiUrl, String jsonStr)/a\        PythonLoader.getInstance().setConfig(jsonStr);' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/api/ApiConfig.java
sed -i '/public Spider getCSP(SourceBean sourceBean)/a\        if (sourceBean.getApi().startsWith(\"py_\")) {\n        try {\n            return PythonLoader.getInstance().getSpider(sourceBean.getKey(), sourceBean.getExt());\n        } catch (Exception e) {\n            e.printStackTrace();\n            return new SpiderNull();\n        }\n    }' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/api/ApiConfig.java
sed -i '/public Object\[\] proxyLoca/a\    try {\n        if(param.containsKey(\"api\")){\n            String doStr = param.get(\"do\").toString();\n            if(doStr.equals(\"ck\"))\n                return PythonLoader.getInstance().proxyLocal(\"\",\"\",param);\n            SourceBean sourceBean = ApiConfig.get().getSource(doStr);\n            return PythonLoader.getInstance().proxyLocal(sourceBean.getKey(),sourceBean.getExt(),param);\n        }else{\n            String doStr = param.get(\"do\").toString();\n            if(doStr.equals(\"live\")) return PythonLoader.getInstance().proxyLocal(\"\",\"\",param);\n        }\n    } catch (Exception e) {\n        e.printStackTrace();\n    }\n' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/api/ApiConfig.java


#替换影魔版IJK库

cp $CURRENT_DIR/JMK/libijkffmpeg.so $CURRENT_DIR/$DIR/player/src/main/jniLibs/armeabi-v7a/libijkffmpeg.so
cp $CURRENT_DIR/JMK/libijksdl.so $CURRENT_DIR/$DIR/player/src/main/jniLibs/armeabi-v7a/libijksdl.so
cp $CURRENT_DIR/JMK/libplayer.so $CURRENT_DIR/$DIR/player/src/main/jniLibs/armeabi-v7a/libplayer.so
sed -i '/libLoader.loadLibrary(\"player\"); /i\try {\n libLoader.loadLibrary(\"ijkffmpeg\");\n libLoader.loadLibrary(\"ijksdl\");\n } catch (Throwable throwable) {\n\n }' $CURRENT_DIR/$DIR/player/src/main/java/tv/danmaku/ijk/media/player/IjkMediaPlayer.java


echo 'DIY end'
