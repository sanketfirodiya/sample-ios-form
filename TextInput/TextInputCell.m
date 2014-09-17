//
//  TextInputCell.m
//  SampleForm
//
//  Created by Firodiya, Sanket on 9/16/14.
//  Copyright (c) 2014 webawesome. All rights reserved.
//

#import "TextInputCell.h"

#define kHIGHLIGHT_INSET_WIDTH 8.0
#define kHIGHLIGHT_INSET_ANIMATION_TIME 0.4
#define kGLOBAL_TINT_COLOR_PLACEHOLDER [UIColor colorWithRed:0.000 green:0.486 blue:0.753 alpha:0.40]

@implementation TextInputCell

#pragma mark - Init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setPlaceHolderText:(NSString *)placeHolderText {
    if (_placeHolderText == nil) {
        _placeHolderText = placeHolderText;
    }
    self.uiTextField.placeholder = placeHolderText;
}

#pragma mark - UITextField delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self emphasizeTextField:textField];
    
    [self highLightView:self.uiPaddingView];
    [self highLightView:self.uiSubtitleLabel];
    [self highLightView:self.uiTextField];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.text.length == 0) {
        [self deemphasizeTextField:textField];
    }
    
    [self unHighLightView:self.uiPaddingView];
    [self unHighLightView:self.uiSubtitleLabel];
    [self unHighLightView:self.uiTextField];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]) {
        [self.delegate selectNextCell]; // SKUITextFieldCellProtocol
        return NO;
    } else if (self.uiTextField.text.length == 0 && string.length == 1) {
        [UIView animateWithDuration:kHIGHLIGHT_INSET_ANIMATION_TIME animations:^{
            self.uiSubtitleLabel.text = self.placeHolderText;
            self.uiSubtitleLabel.hidden = FALSE;
        }];
        
    } else if (self.uiTextField.text.length == 1 && string.length == 0){
        self.uiSubtitleLabel.text = @"";
        self.uiSubtitleLabel.hidden = TRUE;
        [self deemphasizeTextField:textField];
    }
    
    return YES;
}


#pragma mark - Public method

- (void)selectTextField {
    self.uiTextField.userInteractionEnabled = YES;
    [self.uiTextField becomeFirstResponder];
}

#pragma mark - Helpers

- (void)emphasizeTextField:(UITextField *)textField {
    NSString *placeHolderText = textField.placeholder;
    
    [UIView animateWithDuration:kHIGHLIGHT_INSET_ANIMATION_TIME animations:^{
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHolderText attributes:@{NSForegroundColorAttributeName: kGLOBAL_TINT_COLOR_PLACEHOLDER}];
    }];
}

- (void)deemphasizeTextField:(UITextField *)textField {
    NSString *placeHolderText = textField.placeholder;
    
    [UIView animateWithDuration:kHIGHLIGHT_INSET_ANIMATION_TIME animations:^{
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHolderText attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    }];
}

- (void)highLightView:(UIView *)view {
    CGRect frame = view.frame;
    frame.origin.x = frame.origin.x + kHIGHLIGHT_INSET_WIDTH;
    [UIView animateWithDuration:kHIGHLIGHT_INSET_ANIMATION_TIME animations:^{
        view.frame = frame;
    }];
}

- (void)unHighLightView:(UIView *)view {
    CGRect frame = view.frame;
    frame.origin.x = frame.origin.x - kHIGHLIGHT_INSET_WIDTH;
    [UIView animateWithDuration:kHIGHLIGHT_INSET_ANIMATION_TIME animations:^{
        view.frame = frame;
    }];
}

@end