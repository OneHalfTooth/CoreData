//
//  ViewController.m
//  CoreDataDemo
//
//  Created by 马少洋 on 16/5/12.
//  Copyright © 2016年 马少洋. All rights reserved.
//

#import "ViewController.h"
#import "DataManager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *add;
@property (weak, nonatomic) IBOutlet UITextField *dele;
@property (weak, nonatomic) IBOutlet UITextField *fetch;
@property (weak, nonatomic) IBOutlet UITextField *update;

@end

@implementation ViewController


- (IBAction)addButtonDidCliked:(id)sender {
    BOOL rel = [[DataManager manager] instertModel:self.add.text];
    if (!rel) {
        NSLog(@"存储失败");
    }
}

- (IBAction)deleButtonDidCliked:(id)sender {
    BOOL rel = [[DataManager manager]deteleModel:self.dele.text];
    if (!rel) {
        NSLog(@"删除失败");
    }
}

- (IBAction)fetchButtonDidCliked:(id)sender {
    if (self.fetch.text.length == 0) {
        NSArray * array = [[DataManager manager]fetchModel:nil];
    }else{
        NSArray * array = [[DataManager manager]fetchModel:self.fetch.text];
    }
}

- (IBAction)updataButtonDidCliked:(id)sender {
    BOOL rel = [[DataManager manager]upDataModel:self.update.text];
    if (!rel) {
        NSLog(@"更新失败");
    }
}













- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
