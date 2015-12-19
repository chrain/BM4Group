//
//  ViewController.m
//  BM4GroupExample
//
//  Created by 陈宇 on 15/12/19.
//  Copyright © 2015年 陈宇. All rights reserved.
//

#import "ViewController.h"
#import "BM4Group.h"

@interface ViewController ()
@property (nonatomic, strong) BMSpinnerView *spinnerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.spinnerView = [BMSpinnerView new];
    self.spinnerView.datas = [@"周日 周一 周二 周三 周四 周五 周六" componentsSeparatedByString:@" "];
    
    NSString *name = nil;
    NSParameterAssert(![name isExist]);
    name = (id)kCFNull; //如果NSString为NSNull依旧返回NO
    NSParameterAssert(![name isExist]);
    name = @"       ";
    NSParameterAssert(![name isExist]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonAction:(id)sender {
    
    //    [self.spinnerView showBelowWith:sender];
    
    [BMUtils callWithPhoneNumber:@"13041235055"];
}

@end
