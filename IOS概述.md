#ios概述
* xxx.h文件是public的api，而xxx.m则是private的api以及所有接口的实现。
* .h文件中要指明父类 @interface
* NSObject是所有类的根本，一切都是从NSObject继承的。
* 在实现的文件中（.m）@implementiton后面不需要指明父类
* 类属性前，需要有关键字 @property
* 所有**指针属性**要么是(strong)要么是（weak），这关乎到object c的内存管理。
* 当堆中有一块内存，有多个strong指针指向时，就不会释放。当这块内存的引用计数为0时，这块内存会立即释放。
* 当一个指针是weak时，它指向一块内存，如果不再有strong指针指向这块内存时，weak指针就会自动设为nil。
* oc中，我们可以给nil指针发消息。
* 可以给property的getter setter方法重命名
 	