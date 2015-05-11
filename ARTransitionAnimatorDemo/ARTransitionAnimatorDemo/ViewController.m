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

    self.animations = @[@"push",@"present"];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - UITableViewDataSource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.animations.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.animations[indexPath.row];
    return cell;
}

#pragma mark - UITabbleViewDelegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            self.transitionAnimator = [[ARTransitionAnimator alloc] init];
            self.transitionAnimator.behindViewScale = 0.8;
            self.navigationController.delegate = self.transitionAnimator;
            
            UIViewController *viewController = [[UIViewController alloc] init];
            viewController.view.backgroundColor = [UIColor redColor];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 1:
        {
            self.transitionAnimator = [[ARTransitionAnimator alloc] init];
            self.transitionAnimator.behindViewScale = 0.8;
            self.transitionAnimator.modalInsets = UIEdgeInsetsMake(20, 20, 20, 20);
            self.transitionAnimator.touchBackgroudDismissEnabled = YES;
            
            FirstViewController *viewController = [[FirstViewController alloc] init];
            viewController.view.backgroundColor = [UIColor redColor];
            viewController.modalPresentationStyle = UIModalPresentationCustom;
            viewController.transitioningDelegate = self.transitionAnimator;
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
    
        default:
            break;
    }
}

#pragma mark - ///

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
