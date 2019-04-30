//
//  LYEmoticonModel.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/4.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYEmoticonModel.h"

@implementation LYEmoticonModel

- (void)setBundleName:(NSString *)bundleName{
    _bundleName = bundleName;
    
    if (self.bundleImageName.length && self.bundleName.length) {
        self.emoticonImage = [UIImage imageWithContentsOfFile:LYLOADBUDLEIMAGE(self.bundleName, self.bundleImageName)];
        self.paddingSourceUrl = [self.bundleName stringByAppendingString:self.bundleImageName];
    }
}

- (void)setBundleImageName:(NSString *)bundleImageName{
    _bundleImageName = bundleImageName;
    
    if (self.bundleImageName.length && self.bundleName.length) {
        self.emoticonImage = [UIImage imageWithContentsOfFile:LYLOADBUDLEIMAGE(self.bundleName, self.bundleImageName)];
        
        self.paddingSourceUrl = [self.bundleName stringByAppendingString:self.bundleImageName];
    }
}




@end
