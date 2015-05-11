//
//  FirstViewController.m
//  ARTransitionAnimatorDemo
//
//  Created by August on 15/5/11.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor orangeColor];
}
- (IBAction)dismissed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
