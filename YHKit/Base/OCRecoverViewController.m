//
//  OCRecoverViewController.m
//  YHKit
//
//  Created by 毛云河 on 2020/5/27.
//  Copyright © 2020 小河. All rights reserved.
//

#import "OCRecoverViewController.h"

@interface OCRecoverViewController ()

@property (nonatomic, strong) UINavigationController *storedNavigationController;
@property (nonatomic, assign) BOOL storedNavigationBarIsTranslucent;
@property (nonatomic, assign) UIBarStyle storedNavigationBarBarStyle;
@property (nonatomic, strong) UIColor *storedNavigationBarBarTintColor;
@property (nonatomic, strong) UIColor *storedNavigationBarTintColor;

@property (nonatomic, strong) UIImage *storedNavigationBarShadowImage;
@property (nonatomic, strong) UIImage *storedNavigationBarBackgroundImage;

@property (nonatomic, strong) CATransition *transition;

@end

@implementation OCRecoverViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        /*说明extendedLayoutIncludesOpaqueBars属性
        不设置的话，有的时候tableView上方导航设为透明的时候即translucent属性为Yes，
        然后tableview滑动设置导航为不透明的时候即translucent属性为NO的时候会出现跳动
        */
        self.extendedLayoutIncludesOpaqueBars = YES;//设置扩展布局包括不透明条
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.extendedLayoutIncludesOpaqueBars = YES;//设置扩展布局包括不透明条
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)updateTitle:(nullable NSAttributedString *)attributedText {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self storeDefaultNavigationBarStyle];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self recoverStoredNavigationBarStyle];
}

- (void)storeDefaultNavigationBarStyle {
    self.storedNavigationController = self.navigationController;
    if (self.navigationController == nil) {
        return;
    }
    
    if (self.storedNavigationBarBarTintColor == nil ||
        self.storedNavigationBarTintColor == nil ||
        self.storedNavigationBarShadowImage == nil ||
        self.storedNavigationBarBackgroundImage == nil) {
        self.storedNavigationBarIsTranslucent = self.navigationController.navigationBar.isTranslucent;
        self.storedNavigationBarBarStyle = self.navigationController.navigationBar.barStyle;
        self.storedNavigationBarBarTintColor = self.navigationController.navigationBar.barTintColor;
        self.storedNavigationBarTintColor = self.navigationController.navigationBar.tintColor;
        self.storedNavigationBarBackgroundImage = [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
        self.storedNavigationBarShadowImage = self.navigationController.navigationBar.shadowImage;
    }
}

- (void)recoverStoredNavigationBarStyle {
    if (self.navigationController == nil) {
        return;
    }
    if (self.navigationController.isBeingDismissed) {
        return;
    }
    
    self.navigationController.navigationBar.translucent = self.storedNavigationBarIsTranslucent;
    self.navigationController.navigationBar.barStyle = self.storedNavigationBarBarStyle;
    self.navigationController.navigationBar.barTintColor = self.storedNavigationBarBarTintColor;
    self.navigationController.navigationBar.tintColor = self.storedNavigationBarTintColor;
    self.navigationController.navigationBar.shadowImage = self.storedNavigationBarShadowImage;
    [self.navigationController.navigationBar setBackgroundImage:self.storedNavigationBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
}

#pragma mark - Getter

- (CATransition *)transition {
    if (_transition == nil) {
        _transition = [[CATransition alloc] init];
        _transition.type = kCATransitionFade;
        _transition.duration = 0.25;
    }
    return _transition;
}

@end
