//
//  ViewController.m
//  ARTransitionAnimatorDemo
//
//  Created by August on 15/5/11.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ViewController.h"
#import "ARTransitionAnimator.h"
#import "FirstViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *animations;

@property (nonatomic, strong) ARTransitionAnimator *transitionAnimator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.animations = @[@[@"push : Material style",
                          @"push let to right: Material style",
                          @"push right to left: Material style",
                          @"push bottom to top: Material style",
                          @"push top to bottom: Material style"],
                        @[@"present : Material style",
                          @"present let to right: Material style",
                          @"present right to left: Material style",
                          @"present bottom to top: Material style",
                          @"present top to bottom: Material style"]];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - UITableViewDataSource methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.animations.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.animations[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.animations[indexPath.section][indexPath.row];
    return cell;
}

#pragma mark - UITabbleViewDelegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.transitionAnimator = [[ARTransitionAnimator alloc] init];
    
    switch (indexPath.row) {
        case 0:
        {
            self.transitionAnimator.transitionStyle = ARTransitionStyleMaterial;
        }
            break;
        case 1:
        {
            self.transitionAnimator.transitionStyle = ARTransitionStyleMaterial|ARTransitionStyleLeftToRight;
        }
            break;
        case 2:
        {
            self.transitionAnimator.transitionStyle = ARTransitionStyleMaterial|ARTransitionStyleRightToLeft;
        }
            break;

        case 3:
        {
            self.transitionAnimator.transitionStyle = ARTransitionStyleMaterial|ARTransitionStyleBottomToTop;
        }
            break;
        case 4:
        {
            self.transitionAnimator.transitionStyle = ARTransitionStyleMaterial|ARTransitionStyleTopToBottom;
        }
            break;

        default:
            break;
    }
    
    FirstViewController *viewController = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
    if (indexPath.section == 0) {
        self.navigationController.delegate = self.transitionAnimator;
        [self.navigationController pushViewController:viewController animated:YES];
    }else{
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:viewController];
        navigation.modalPresentationStyle = UIModalPresentationCustom;
        navigation.transitioningDelegate = self.transitionAnimator;
        [self presentViewController:navigation animated:YES completion:nil];
    
    }
}

#pragma mark - ///

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
