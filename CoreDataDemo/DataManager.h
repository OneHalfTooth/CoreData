//
//  DataManager.h
//  CoreDataDemo
//
//  Created by 马少洋 on 16/5/12.
//  Copyright © 2016年 马少洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

+ (instancetype)manager;


//增删查改
- (BOOL)instertModel:(NSString *)name;
- (NSArray *)fetchModel:(NSString *)name;
- (BOOL)upDataModel:(NSString *)name;
- (BOOL)deteleModel:(NSString *)name;

@end
