//
//  TextInputCell.h
//  SampleForm
//
//  Created by Firodiya, Sanket on 9/16/14.
//  Copyright (c) 2014 webawesome. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TextInputCellProtocol <NSObject>
- (void)selectNextCell;
@end

@interface TextInputCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *uiTextField;
@property (weak, nonatomic) IBOutlet UILabel *uiSubtitleLabel;
@property (weak, nonatomic) IBOutlet UIView *uiPaddingView;
@property (weak, nonatomic) id <TextInputCellProtocol> delegate;
@property (strong, nonatomic) NSString *placeHolderText;
- (void)selectTextField;
@end
