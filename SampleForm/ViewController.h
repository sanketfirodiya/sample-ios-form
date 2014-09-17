//
//  ViewController.h
//  SampleForm
//
//  Created by Firodiya, Sanket on 9/16/14.
//  Copyright (c) 2014 webawesome. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextInputCell.h"

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, TextInputCellProtocol>
@property (weak, nonatomic) IBOutlet UITableView *uiTableView;

@end
