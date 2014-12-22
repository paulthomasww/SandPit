//
//  ViewController.m
//  SandPit
//
//  Created by Paul Thomas on 19/12/2014.
//  Copyright (c) 2014 ThomasWW. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIButton *button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect frame = CGRectMake(20.0f, 20.0f, 200.0f, 20.0f);
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.backgroundColor = [UIColor clearColor];
    [self.button setFrame:frame];
    [self.button setTitle:@"Click me!" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(labelTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)labelTap:(id) sender {
    
    NSString *title = @"Default title";
    if ([sender isKindOfClass:[UIButton class]]){
        UIButton *button = (UIButton *)sender;
        title = button.titleLabel.text;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:@"Do you really want to do that?" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    
    [alert show];
}

@end
