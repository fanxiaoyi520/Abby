//
//  ABChatViewController.m
//  UniversalApp
//
//  Created by Baypac on 2022/1/18.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "ABChatViewController.h"

@interface ABChatViewController ()

@end

@implementation ABChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"0xF7F7F7"];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

@end
