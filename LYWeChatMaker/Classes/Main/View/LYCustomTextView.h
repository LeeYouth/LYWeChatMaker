//
//  LYCustomTextView.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/21.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LTextView,LYCustomTextView;

NS_ASSUME_NONNULL_BEGIN

@protocol LYTextViewDelegate <NSObject>
@optional
- (void)textViewDidEndEditing:(LYCustomTextView *)textView;
@end



@interface LYCustomTextView : UITextView

/*
 RECOMMEND INITIALIZTION:
 Frame:CGRectMake(85, 100, 150, 155) defaultText:@"LIFE IS\nBUT A\nDREAM"];
 */
- (id)initWithFrame:(CGRect)frame
        defaultText:(NSString *)text
               font:(UIFont *)font
              color:(UIColor *)color
            minSize:(CGSize)minSize;

// property setting
@property (nonatomic, assign) id<LYTextViewDelegate> delegate;

// read only
@property (nonatomic, retain, readonly) LTextView *textView;
@property (nonatomic, assign, readonly) BOOL isEditting;

- (void)showTextViewBox;

@end


@interface LTextView : UITextView

@end

NS_ASSUME_NONNULL_END
