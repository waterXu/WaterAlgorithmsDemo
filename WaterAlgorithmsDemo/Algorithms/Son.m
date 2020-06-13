//
//  Son.m
//  WaterAlgorithmsDemo
//
//  Created by 唐崇 on 2020/6/7.
//  Copyright © 2020 xuyanlan. All rights reserved.
//

#import "Son.h"
#import <objc/runtime.h>

@implementation Son
+ (void)load {
//    simple_swizzle(self, @selector(work), @selector(son_work));
    best_Swizzle(self, @selector(work), @selector(son_work));
    NSLog(@"-----> load");
}

BOOL simple_swizzle(Class cls, SEL oriSel, SEL ovrriSel) {
    Method oriM = class_getInstanceMethod(cls, oriSel);
    Method ovrriM = class_getInstanceMethod(cls, ovrriSel);
    method_exchangeImplementations(oriM, ovrriM);
    return YES;
}

BOOL best_Swizzle(Class cls, SEL oriSel, SEL ovrriSel){
    
    Method oriM = class_getInstanceMethod(cls, oriSel);
    Method ovrriM = class_getInstanceMethod(cls, ovrriSel);
    //给类先添加一个方法，如果已经存在则会返回 no
    BOOL didAddMethod = class_addMethod(cls, oriSel, method_getImplementation(ovrriM), method_getTypeEncoding(ovrriM));
    if (didAddMethod) {
        class_replaceMethod(cls, ovrriSel, method_getImplementation(oriM), method_getTypeEncoding(oriM));
    }else{
        method_exchangeImplementations(oriM, ovrriM);
    }
    
    return YES;
}
- (void)son_work {
    [self son_work];
    NSLog(@"----> son nowork");
}
- (void)work {
//    [self son_work];
    NSLog(@"----> son work");
}
static char testVarKey;
- (void)setTestVar:(NSString *)testVar {
    objc_setAssociatedObject(self, &testVarKey, testVar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)testVar {
   return  objc_getAssociatedObject(self, &testVarKey);
}
@end
