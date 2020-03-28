# hp-chromebook-x360-14
专门存放HP Chromebook X360 14各种图省事的配置信息以便日后万一瞎折腾出错且备份丢失时可以快速重新配置。

## 解决Linux软件的声音问题
>参考链接：https://www.reddit.com/r/Crostini/comments/blywee/pixelbook_stable_74_no_audio/

非root用户下输入以下命令解决：
```bash
systemctl --user start cros-pulse-config
systemctl --user enable cros-pulse-config
/usr/bin/pacmd load-module module-alsa-sink tsched=0 device=hw:0,0
```

## 更换crostini字体
>巨硬瘟屎官方字体备份，用于别的系统直接套用(删掉了msgothic.ttc文件，这个文件在crostini下会导致vscode中文字体显示异常)

#### 适用环境

这个东西理论上linux通用(Debian/Ubuntu系直接用，红帽系可能要稍微改一下用法)，我是使用在crostini中（chromeos的linux子系统，debian10魔改版），可以大幅改善文泉驿和思源黑体这俩linux知名中文字体在crostini安装的软件上中文显示过于模糊的问题，理论上chromeos也可以使用，但chromeos的显示效果还行就懒得改了

#### 用法
>请在非root用户下操作

```bash
cd ~
git clone https://github.com/mylovesaber/hp-chromebook-x360-14.git
cd hp-chromebook-x360-14
sudo cp -r macrohard-fonts /usr/share/fonts/
sudo chmod -R 755 /usr/share/fonts/macrohard-fonts
sudo fc-cache -f
```
最后重新打开linux软件即可发现中文字体默认变成巨硬雅黑了，除了中文字体有点肥以外也没什么太大问题，比宋体偏细但颜色偏淡的观感稍微好点，这个字体库全部使用的话，默认巨硬雅黑会把宋体和等宽字体效果全部覆盖，英文字体不知道是什么字体但观感还可以
