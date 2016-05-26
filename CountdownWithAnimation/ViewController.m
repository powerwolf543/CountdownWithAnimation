//
//  ViewController.m
//  CountdownWithAnimation
//
//  Created by NixonShih on 2016/5/26.
//  Copyright © 2016年 NixonShih. All rights reserved.
//

#import "ViewController.h"

#define kSecond 10

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;

@end

@implementation ViewController
{
    NSInteger countdownTimeNum;
    BOOL isAnimation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _secondLabel.text = @"";
}

- (void)countdownAnimationWithLabel:(UILabel*)label {
    label.transform = CGAffineTransformIdentity;
    label.text = [NSString stringWithFormat:@"%ld",(long)countdownTimeNum];
    label.alpha = 1;
    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        label.alpha = 0;
        label.transform = CGAffineTransformScale(label.transform, 0.1, 0.1);
    } completion:^(BOOL finished) {
        if (!(countdownTimeNum <= 1) && isAnimation) {
            countdownTimeNum -= 1;
            [self countdownAnimationWithLabel:label];
        }
    }];
}

- (IBAction)startCountdown:(id)sender {
    if (isAnimation) {
        isAnimation = false;
        [_secondLabel.layer removeAllAnimations];
        _secondLabel.text = @"";
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
        countdownTimeNum = kSecond;
        _secondLabel.text = [NSString stringWithFormat:@"%ld",(long)countdownTimeNum];
        isAnimation = true;
        [self countdownAnimationWithLabel:_secondLabel];
    });

}

@end
