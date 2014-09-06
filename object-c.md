#object-c
* 在工程中新建类时，建议xcode中的分组要和文件的物理地址一致。比如新建一个Model类，放入Model的Group中，也需要把这些类文件放入到Model德文件夹中。
* 设计类时，可以考虑一下别人会怎么使用我提供的api，以此来驱动类的设计。
* 在头文件中定义成readonly的属性，可以在.m文件中，定义成私有可写(rewrite)。这样，这个属性对外是只读的，而在内部可写。
* oc中的类成员没有protect，所以类的初始化器一定要为public。
* oc中，定义常量有两种方式：#define 以及 static int