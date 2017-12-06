author: me
title: ubuntu上安装配置sublime-text
date: 2017-11-26 10:07:50
tags:
    - ubuntu
    - sublime
---

以前不愿意在ubuntu上使用sublime-text,就是因为不能输入中文的问题，当时查了查，也没找到什么靠谱的方法。于是就搁置了，最近，偶然间看到一个解决方法，就试了试，竟然成功了，有可以享受sublime的速度了，所以我就记录一下。([sublime text官网](http://www.sublimetext.com/))
 
## 安装sublime
 
```
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text
```
 
在安装完成之后我们就可以正常使用了，下面解决中文输入的问题。
 
## 解决无法输入中文的问题

### 安装依赖
 
 
```
sudo apt-get install gtk+-2.0
```
 
### 新建文件：sublime_imfix.c
 
```
/*
sublime-imfix.c
Use LD_PRELOAD to interpose some function to fix sublime input method support for linux.
By Cjacker Huang
 
gcc -shared -o libsublime-imfix.so sublime-imfix.c `pkg-config --libs --cflags gtk+-2.0` -fPIC
LD_PRELOAD=./libsublime-imfix.so subl
*/
#include <gtk/gtk.h>
#include <gdk/gdkx.h>
typedef GdkSegment GdkRegionBox;
 
struct _GdkRegion
{
  long size;
  long numRects;
  GdkRegionBox *rects;
  GdkRegionBox extents;
};
 
GtkIMContext *local_context;
 
void
gdk_region_get_clipbox (const GdkRegion *region,
            GdkRectangle    *rectangle)
{
  g_return_if_fail (region != NULL);
  g_return_if_fail (rectangle != NULL);
 
  rectangle->x = region->extents.x1;
  rectangle->y = region->extents.y1;
  rectangle->width = region->extents.x2 - region->extents.x1;
  rectangle->height = region->extents.y2 - region->extents.y1;
  GdkRectangle rect;
  rect.x = rectangle->x;
  rect.y = rectangle->y;
  rect.width = 0;
  rect.height = rectangle->height;
  //The caret width is 2;
  //Maybe sometimes we will make a mistake, but for most of the time, it should be the caret.
  if(rectangle->width == 2 && GTK_IS_IM_CONTEXT(local_context)) {
        gtk_im_context_set_cursor_location(local_context, rectangle);
  }
}
 
//this is needed, for example, if you input something in file dialog and return back the edit area
//context will lost, so here we set it again.
 
static GdkFilterReturn event_filter (GdkXEvent *xevent, GdkEvent *event, gpointer im_context)
{
    XEvent *xev = (XEvent *)xevent;
    if(xev->type == KeyRelease && GTK_IS_IM_CONTEXT(im_context)) {
       GdkWindow * win = g_object_get_data(G_OBJECT(im_context),"window");
       if(GDK_IS_WINDOW(win))
         gtk_im_context_set_client_window(im_context, win);
    }
    return GDK_FILTER_CONTINUE;
}
 
void gtk_im_context_set_client_window (GtkIMContext *context,
          GdkWindow    *window)
{
  GtkIMContextClass *klass;
  g_return_if_fail (GTK_IS_IM_CONTEXT (context));
  klass = GTK_IM_CONTEXT_GET_CLASS (context);
  if (klass->set_client_window)
    klass->set_client_window (context, window);
 
  if(!GDK_IS_WINDOW (window))
    return;
  g_object_set_data(G_OBJECT(context),"window",window);
  int width = gdk_window_get_width(window);
  int height = gdk_window_get_height(window);
  if(width != 0 && height !=0) {
    gtk_im_context_focus_in(context);
    local_context = context;
  }
  gdk_window_add_filter (window, event_filter, context);
}
```
 
### 编译成共享库
 
```
gcc -shared -o libsublime-imfix.so sublime_imfix.c  `pkg-config --libs --cflags gtk+-2.0` -fPIC
```
 
以下命令会打开sublime，查看是否可以输入中文
```
LD_PRELOAD=./libsublime-imfix.so subl
```
 
若可以，执行一下命令
```
sudo mv libsublime-imfix.so /opt/sublime_text/
```
 
### 修改/usr/share/applications/sublime-text.desktop
 
```
sudo vi /usr/share/applications/sublime-text.desktop
```
我在进行这一步时，这个文件是不存在的，直接添加以下代码
 
```
[Desktop Entry]
.........
Exec=env LD_PRELOAD=/opt/sublime_text/libsublime-imfix.so /opt/sublime_text/sublime_text %F
.........
 
[Desktop Action Window]
.........
Exec=env LD_PRELOAD=/opt/sublime_text/libsublime-imfix.so /opt/sublime_text/sublime_text -n
.........
 
[Desktop Action Document]
.........
Exec=env LD_PRELOAD=/opt/sublime_text/libsublime-imfix.so /opt/sublime_text/sublime_text --command new_file
.........
```
 
### 修改 /usr/bin/subl：
将里面的内容替换为如下代码（要用管理员权限）
 
```
 
# !/bin/sh
export LD_PRELOAD=/opt/sublime_text/libsublime-imfix.so
exec /opt/sublime_text/sublime_text "$@"
```
 
### 一些基本配置
在`Preferences - Settings - User`文件中里面加入。
 
```
  "font_face": "Dejavu Sans Mono", //设置字体
  "font_size": 12,  //设置字体大小
  "translate_tabs_to_spaces": true,  //Tab对齐转化为空格对齐，tab_size 控制转化比例
  "tab_size": 4,
  "trim_trailing_white_space_on_save": true, //自动移除行尾多余空格
  "save_on_focus_lost": true,  //窗口失去焦后立即保存文件
  "bold_folder_labels": true, //侧栏文件夹加粗
```
 
## 一些好用的插件
- Package Control
 
    用来安装其它插件，安装方法可以去Package Control查看，注意Sublime Text的版本问题。
- Emmet
 
    前端神器
 
- FileHeader
 
    自动创建文件开头模板，并且会根据最后的保存时间修改更新时间
