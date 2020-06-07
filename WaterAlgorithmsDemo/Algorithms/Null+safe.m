//
//  Null+safe.m
//  WaterAlgorithmsDemo
//
//  Created by 唐崇 on 2020/6/7.
//  Copyright © 2020 xuyanlan. All rights reserved.
//

#import "Null+safe.h"
@implementation NSNull (safe)
#define pLog
#define JsonObjects @[@"",@0,@{},@[]]
- (id)forwardingTargetForSelector:(SEL)aSelector {
    for (id jsonObj in JsonObjects) {
        if ([jsonObj respondsToSelector:aSelector]) {
#ifdef pLog
            NSLog(@"NULL 了！这个对象应该是_%@",[jsonObj class]);
#endif
            return jsonObj;
        }
    }
    return [super forwardingTargetForSelector:aSelector];
}
@end
