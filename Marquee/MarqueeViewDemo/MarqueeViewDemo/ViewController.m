//
//  ViewController.m
//  MarqueeViewDemo
//
//  Created by 杨帅 on 2017/8/24.
//  Copyright © 2017年 杨帅. All rights reserved.
//

#import "ViewController.h"
#import "MarqueeView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet MarqueeView *marqueeView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.marqueeView.content = @"准备来一场华丽的冒险！！";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)start:(id)sender {
    [self.marqueeView start];
}

- (IBAction)pause:(id)sender {
    [self.marqueeView pause];
}

- (IBAction)reset:(id)sender {
    [self.marqueeView reset];
}

@end
