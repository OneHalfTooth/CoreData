//
//  NSArray+Tools.m
//  CoreDataDemo
//
//  Created by 马少洋 on 16/5/13.
//  Copyright © 2016年 马少洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@implementation NSArray (Safe)

+ (void)load {
    Method originalMethod = class_getClassMethod(self, @selector(arrayWithObjects:count:));
    Method swizzledMethod = class_getClassMethod(self, @selector(customArrayWithObjects:count:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

+ (instancetype)customArrayWithObjects:(const id [])objects count:(NSUInteger)cnt {
    id nObjects[cnt];
    int i=0, j=0;
    for (; i<cnt && j<cnt; i++) {
        if (objects[i]) {
            nObjects[j] = objects[i];
            j++;
        }
    }

    return [self customArrayWithObjects:nObjects count:j];
}

@end
