//
//  KeyboardViewController.m
//  keyboardExtension
//
//  Created by xuyanlan on 2018/2/22.
//  Copyright © 2018年 xuyanlan. All rights reserved.
//

#import "KeyboardViewController.h"

typedef struct Test
{
    int a;
    int b;
}Test;

@interface KeyboardViewController ()
@property (nonatomic, strong) UIButton *nextKeyboardButton;
@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}
- (void)loadView
{
    UIView *inputView = [[UIView alloc] init];
    UIButton *testCrashButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 70, 40)];
    [testCrashButton setTitle:@"crash" forState:(UIControlStateNormal)];
    [inputView addSubview:testCrashButton];
    [testCrashButton addTarget:self action:@selector(selectorCrash) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *testSingalCrashButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 150, 40)];
    [testSingalCrashButton setTitle:@"crashSingal" forState:(UIControlStateNormal)];
    [inputView addSubview:testSingalCrashButton];
    [testSingalCrashButton addTarget:self action:@selector(selectorCrashSingal) forControlEvents:UIControlEventTouchUpInside];

    self.inputView = inputView;
}
- (void)selectorCrashSingal {
    Test *pTest = {1,2};
    free(pTest);
    pTest->a = 5;
}
- (void)selectorCrash {
    NSArray *arr = [[NSArray alloc] init];
    [arr setValue:@"222" forKey:@"000"];
    NSString *value = arr[8];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Perform custom UI setup here
    self.nextKeyboardButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [self.nextKeyboardButton setTitle:NSLocalizedString(@"Next Keyboard", @"Title for 'Next Keyboard' button") forState:UIControlStateNormal];
    [self.nextKeyboardButton sizeToFit];
    self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.nextKeyboardButton addTarget:self action:@selector(handleInputModeListFromView:withEvent:) forControlEvents:UIControlEventAllTouchEvents];
    
    [self.view addSubview:self.nextKeyboardButton];
    
    [self.nextKeyboardButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.nextKeyboardButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
    [self.nextKeyboardButton setTitleColor:textColor forState:UIControlStateNormal];
}

@end
