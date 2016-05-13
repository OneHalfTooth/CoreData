//
//  NSMutableDictionary+Tools.m
//  CoreDataDemo
//
//  Created by 马少洋 on 16/5/13.
//  Copyright © 2016年 马少洋. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@implementation NSMutableDictionary (Safe)

+(void)load{
    Method methodSetObjSuperScript = class_getInstanceMethod(self, @selector(setObject:forKeyedSubscript:));
    Method methodSetObjScript = class_getInstanceMethod(self, @selector(customSetObject:forKeyedSubscript:));
    method_exchangeImplementations(methodSetObjSuperScript, methodSetObjScript);

    Class dictCls = NSClassFromString(@"__NSDictionaryM");
    Method methodSetObjSuper = class_getInstanceMethod(dictCls, NSSelectorFromString(@"setObject:forKey:"));
    Method methodSetObj = class_getInstanceMethod(dictCls, @selector(customSetObject:forKey:));
    method_exchangeImplementations(methodSetObj, methodSetObjSuper);

    Method methodSuperRemoveKey = class_getInstanceMethod(dictCls, @selector(removeObjectForKey:));
    Method methodRemoveKey = class_getInstanceMethod(dictCls, @selector(customRemoveObjectForKey:));
    method_exchangeImplementations(methodRemoveKey, methodSuperRemoveKey);

}
-(void)customRemoveObjectForKey:(id)aKey{
    if (aKey) {
        [self customRemoveObjectForKey:aKey];
    }else{
        NSLog(@"remove了一个空，key为%@",aKey);
    }
}
-(void)customSetObject:(id)obj forKeyedSubscript:(id<NSCopying>)key{
    if (obj) {
        [self customSetObject:obj forKeyedSubscript:key];
    }else{
        NSLog(@"setObject了一个空，key为%@",key);
    }
}
-(void)customSetObject:(id)anObject forKey:(id<NSCopying>)aKey{
    if (anObject) {
        [self customSetObject:anObject forKey:aKey];
    }else{
        NSLog(@"setObject了一个空，key为%@",aKey);
    }
}

@end
