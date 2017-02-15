//
//  ViewController.m
//  RunTime实践
//
//  Created by dbjyz on 15/11/10.
//  Copyright © 2015年 dbjyz. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import "UserModel.h"
#import <objc/Object.h>
@interface ViewController ()
@property(strong, nonatomic)NSString * userNameStr;
@property(strong, nonatomic)UILabel * userLabel;
@property(strong, nonatomic)UIImageView * imageView;
@property(strong, nonatomic)UserModel * userModel;

//runtime:常用来方法缓存，数据归档（model赋值），在系统类中添加属性和对象等。
@end

//首先定义一个全局变量，用它的地址作为关联对象的key
static char associatedObjectKey;

static char associatedObjectKey2;

@implementation ViewController

//我们写的代码在程序运行过程中都会被转化成runtime的C代码执行，例如[target doSomething];会被转化成objc_msgSend(target, @selector(doSomething));。//注意：这里的target指的是对象，例如self等

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test];
    [self addProperty];
    [self cusTomM];
    
}



-(void)cusTomM{

    NSLog(@"我是个方法");
}


/**
 *  现在你准备用一个系统的类，但是系统的类并不能满足你的需求，你需要额外添加一个属性。
 这种情况的一般解决办法就是继承。
 但是，只增加一个属性，就去继承一个类，总是觉得太麻烦类。
 这个时候，runtime的关联属性就发挥它的作用了。
 
            不仅可以添加属性，还可以添加任何对象
 */

-(void)addProperty{
    
    //此句解析
    //objc_setAssociatedObject(给谁添加就是谁的对象, 关联对象的key, 要添加的属性, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    //设置关联对象
    objc_setAssociatedObject(self, &associatedObjectKey, @"要添加的属性", OBJC_ASSOCIATION_RETAIN_NONATOMIC); //获取关联对象
    
    NSString *string = objc_getAssociatedObject(self, &associatedObjectKey);
    
    NSLog(@"AssociatedObject = %@", string);

    
    
    //添加对象
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 400, 300)];
    label.backgroundColor = [UIColor redColor];
    
    objc_setAssociatedObject(self, &associatedObjectKey2,label, OBJC_ASSOCIATION_RETAIN_NONATOMIC); //获取关联对象
    
    UILabel *ceshi = objc_getAssociatedObject(self, &associatedObjectKey2);
    ceshi.text = string;
    [self.view addSubview:ceshi];
    
}




/**
 *  runtime获取属性、方法、变量、协议
 */
-(void)test{
    unsigned int count;
    //获取属性列表//利用这个属性可以实现给Model类赋值
    objc_property_t * propertyList = class_copyPropertyList([self class], &count);
    for (unsigned int i=0; i<count; i++) {
        const char * propertyname = property_getName(propertyList[i]);
        NSLog(@"property----="">%@", [NSString stringWithUTF8String:propertyname]);
    }
    
    //获取方法列表//查看方法调用的顺序，因为可以动态的调整方法执行的书序
    Method *methodList = class_copyMethodList([self class], &count);
    for (unsigned int i; i<count; i++) {
        Method method = methodList[i];
        NSLog(@"method----="">%@", NSStringFromSelector(method_getName(method)));
    }
    
    
    //获取成员变量列表
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (unsigned int i; i<count; i++) {
        Ivar myivar = ivarList[i];
        const char *ivarname = ivar_getName(myivar);                 NSLog(@"ivar----="">%@", [NSString stringWithUTF8String:ivarname]);
    }
    //获取协议列表
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
    for (unsigned int i; i<count; i++) {
        Protocol *myprotocal = protocolList[i];
        const char *protocolname = protocol_getName(myprotocal);         NSLog(@"protocol----="">%@", [NSString stringWithUTF8String:protocolname]);
    }
    
}


/**
 *  runtime拦截调用
 *
 *  @param BOOL 返回状态
 *
 *  @return 返回状态
 */

//当你调用一个不存在的类方法的时候，会调用这个方法，默认返回NO，你可以加上自己的处理然后返回YES。
+ (BOOL)resolveClassMethod:(SEL)sel{
    return NO;
}

//和第一个方法相似，只不过处理的是实例方法
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    return NO;
    
}

//将你调用的不存在的方法重定向到一个其他声明了这个方法的类，只需要你返回一个有这个方法的target。
- (id)forwardingTargetForSelector:(SEL)aSelector{
    NSLog(@"AAAAA");
    return @"OK";
}

//是将你调用的不存在的方法打包成NSInvocation传给你。做完你自己的处理后，调用invokeWithTarget:方法让某个target触发这个方法
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    NSLog(@"AAAAA");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
