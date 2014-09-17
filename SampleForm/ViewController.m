//
//  ViewController.m
//  SampleForm
//
//  Created by Firodiya, Sanket on 9/16/14.
//  Copyright (c) 2014 webawesome. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    NSIndexPath *selectedIndexPath;
}

#define kCellIdentifier @"TextInputCell"
#define kNumberOfRowsInSection 5

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Sample Input Form";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(doneTapped)];
    self.uiTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 1.0)];
	UINib *nib = [UINib nibWithNibName:kCellIdentifier bundle:nil];
    [self.uiTableView registerNib:nib forCellReuseIdentifier:kCellIdentifier];
    [self registerForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)doneTapped {
    [self.view endEditing:YES];
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedIndexPath = indexPath;
    TextInputCell *cell = (TextInputCell *)[self.uiTableView cellForRowAtIndexPath:indexPath];
    [cell selectTextField];
}

#pragma mark - SKUITextFieldCellProtocol methods

- (void)selectNextCell {
    if (selectedIndexPath.row < kNumberOfRowsInSection-1) {
        [self.uiTableView deselectRowAtIndexPath:[self.uiTableView indexPathForSelectedRow] animated:YES];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectedIndexPath.row + 1 inSection:0];
        [self tableView:self.uiTableView didSelectRowAtIndexPath:indexPath];
        [self.uiTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    } else {
        [self.view endEditing:YES];
    }
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kNumberOfRowsInSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TextInputCell *cell = [self.uiTableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    cell.delegate = self;
    if (indexPath.row == 0) {
        cell.placeHolderText = @"First Name";
    } else if (indexPath.row == 1) {
        cell.placeHolderText = @"Last Name";
    } else if (indexPath.row == 2) {
        cell.placeHolderText = @"Email";
    } else if (indexPath.row == 3) {
        cell.placeHolderText = @"Phone #";
    } else if (indexPath.row == 4) {
        cell.placeHolderText = @"Zip";
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

#pragma mark - UIKeyboard Notifications

- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeShown:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillBeShown:(NSNotification*)aNotification {
    CGSize keyboardSize = [[[aNotification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets;
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        contentInsets = UIEdgeInsetsMake(64.0, 0.0, (keyboardSize.height), 0.0);
    } else {
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.width), 0.0);
    }
    
    self.uiTableView.contentInset = contentInsets;
    self.uiTableView.scrollIndicatorInsets = contentInsets;
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    self.uiTableView.contentInset = UIEdgeInsetsMake(64.0, 0.0, 0.0, 0.0);
    self.uiTableView.scrollIndicatorInsets = UIEdgeInsetsMake(64.0, 0.0, 0.0, 0.0);
}

@end
