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
#sed -i 's/1.0.0/1.1.6/g' $CURRENT_DIR/$DIR/app/build.gradle

#设置界面
#cp $CURRENT_DIR/DIY/fragment_model.xml $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_model.xml 
#sed -i 's/关于/关于                                                                   1.1.6/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_model.xml

#增加参数
#sed -i '/android:layout_width="@dimen/vs_560"/a'  $CURRENT_DIR/$DIR/app/src/main/res/values/dimens.xml   
#其他
#sed -i 's/6000/15000/g'  $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/player/controller/VodController.java



# 默认设置
cp $CURRENT_DIR/DIY/App.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/base/App.java  

#taka版本替换q2
cp $CURRENT_DIR/DIY/strings.xml $CURRENT_DIR/$DIR/app/src/main/res/values/strings.xml

#主界面
#sed -i 's/ts_40/ts_34/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_user.xml
#sed -i 's/"@color/color_CCFFFFFF"/ "#FFFFFFFF"/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_user.xml
#cp $CURRENT_DIR/DIY/fragment_user.xml $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_user.xml

#共存
sed -i 's/com.github.tvbox.osc/com.tvbox.q2.py/g' $CURRENT_DIR/$DIR/app/build.gradle

#自定义epg
cp $CURRENT_DIR/DIY/epg_data.json $CURRENT_DIR/$DIR/app/src/main/assets/epg_data.json

#名称修改
sed -i 's/TVBox/TVBoxPy/g' $CURRENT_DIR/$DIR/app/src/main/res/values-zh/strings.xml
sed -i 's/TVBox/TVBoxPy/g' $CURRENT_DIR/$DIR/app/src/main/res/values/strings.xml
#图标修改
#mv $CURRENT_DIR/DIY/app_icon.png $CURRENT_DIR/$DIR/app/src/main/res/drawable/app_icon.png
#背景修改
cp $CURRENT_DIR/DIY/背景1.png $CURRENT_DIR/$DIR/app/src/main/res/drawable/app_bg.png

#取消选集全屏
sed -i 's/if (showPreview \&\& !fullWindows) toggleFullPreview/\/\/if (showPreview \&\& !fullWindows) toggleFullPreview/g' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/DetailActivity.java
#缩略图清晰度修改
#sed -i 's/mContext, 400/mContext, 500/g' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/DetailActivity.java
#sed -i 's/mContext, 300/mContext, 400/g' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/DetailActivity.java
#sed -i 's/mContext, 400/mContext, 500/g' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/adapter/GridAdapter.java
#sed -i 's/mContext, 300/mContext, 400/g' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/adapter/GridAdapter.java
#sed -i 's/mContext, 400/mContext, 500/g' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/adapter/HistoryAdapter.java
#sed -i 's/mContext, 300/mContext, 400/g' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/adapter/HistoryAdapter.java
#添加详情页播放列表宽度自适
#sed -i '/import me.jessyan.autosize.utils.AutoSizeUtils;/a\import android.graphics.Rect;\nimport android.graphics.Paint;\nimport android.text.TextPaint;\nimport androidx.annotation.NonNull;\nimport android.graphics.Typeface;\nimport androidx.recyclerview.widget.RecyclerView;' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/DetailActivity.java
#sed -i '/private View seriesFlagFocus = null;/a\    private V7GridLayoutManager mGridViewLayoutMgr = null;' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/DetailActivity.java
#sed -i 's/mGridView.setLayoutManager(new V7GridLayoutManager(this.mContext, isBaseOnWidth() ? 6 : 7));/mGridView.setHasFixedSize(false);\n        this.mGridViewLayoutMgr = new V7GridLayoutManager(this.mContext, isBaseOnWidth() ? 6 : 7);\n        mGridView.setLayoutManager(this.mGridViewLayoutMgr);\n/g' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/DetailActivity.java
#sed -i '/seriesAdapter.setNewData(vodInfo.seriesMap.get(vodInfo.playFlag));/i\        Paint pFont = new Paint();\n        Rect rect = new Rect();\n        List<VodInfo.VodSeries> list = vodInfo.seriesMap.get(vodInfo.playFlag);\n        int w = 1;\n        for(int i =0; i < list.size(); ++i){\n            String name = list.get(i).name;\n            pFont.getTextBounds(name, 0, name.length(), rect);\n            if(w < rect.width()){\n                w = rect.width();\n            }\n        }\n        w += 32;\n        int screenWidth = getWindowManager().getDefaultDisplay().getWidth()\/3;\n        int offset = screenWidth\/w;\n        if(offset <=1) offset =1;\n        if(offset > 6) offset =6;\n        this.mGridViewLayoutMgr.setSpanCount(offset);\n' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/DetailActivity.java
#sed -i 's/FrameLayout/LinearLayout/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/item_series.xml
#sed -i 's/width=\"wrap_content\"/width=\"match_parent\"/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/item_series.xml
#sed -i 's/@dimen\/vs_190/match_parent/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/item_series.xml

echo 'DIY end'
