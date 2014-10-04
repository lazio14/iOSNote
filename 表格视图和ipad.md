# 表格视图和ipad
* 将一个应用改成iphone和ipad通用的时候，需要重新设置ipad(或iphone)的stroyboard。
* 请确保有一个controller勾选上了“Is Initial View Controller”，否则没有入口视图，
* 将iphone应用适配成ipad步骤：
1 选中storyboard文件，假设名字为MainStoryboard.storyboard
2 File--->duplicate，将文件命名为MainStoryboard_ipad.storyboard
3 在plist文件中添加两项，Main storyboard file base name (iPhone)和Main storyboard file base name (iPad)，其值分别对应1和2的两个storyboard
4 右键MainStoryboard_ipad.storyboard，open as ---> source code，找到targetRuntime，将其修改为targetRuntime="iOS.CocoaTouch.iPad"
5 最后一步，选中项目-----> targets----->summary(不是bulid settings页)，将devices改为universal