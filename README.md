# ARTransitionAnimator
ARTransitionAnimator is a simple class which custom UIViewController transition animation.

# demo Gifs

<img src="https://github.com/AugustRush/ARTransitionAnimator/blob/master/gif/ani1.gif" width="320">
<img src="https://github.com/AugustRush/ARTransitionAnimator/blob/master/gif/ani2.gif" width="320">
<img src="https://github.com/AugustRush/ARTransitionAnimator/blob/master/gif/ani3.gif" width="320">
<img src="https://github.com/AugustRush/ARTransitionAnimator/blob/master/gif/ani4.gif" width="320">
<img src="https://github.com/AugustRush/ARTransitionAnimator/blob/master/gif/ani5.gif" width="320">
<img src="https://github.com/AugustRush/ARTransitionAnimator/blob/master/gif/ani6.gif" width="320">

# Usage

```
 self.transitionAnimator = [[ARTransitionAnimator alloc] init];
 self.transitionAnimator.transitionDuration = 0.6;
 self.transitionAnimator.transitionStyle = ARTransitionStyleMaterial|ARTransitionStyleLeftToRight;

 FirstViewController *viewController = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
 self.navigationController.delegate = self.transitionAnimator; // set delegate
 [self.navigationController pushViewController:viewController animated:YES];

 ```

 # Install

 pod 'ARTransitionAnimator', :git => 'https://github.com/AugustRush/ARTransitionAnimator.git'

 # TO DO

 * add more animations

 * Improve the show of animation

 现在的版本只是写了很少的一部分，有很多的地方需要改进，由于最近项目上时间比较紧，耽搁了一些开源代码的进度，希望大家可以一起不断的完善这些代码。可以到我的github主页'https://github.com/AugustRush' fork 我的其他开源代码，帮助我不断的完善和改进。
