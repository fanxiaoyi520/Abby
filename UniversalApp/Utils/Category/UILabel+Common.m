//
//  UILabel+Common.m
//  teamwork
//
//  Created by 张俊彬 on 2020/8/26.
//  Copyright © 2020 Zhengzhou Yutong Bus Co.,Ltd. All rights reserved.
//
#define SuppressPerformSelectorLeakWarning(Stuff) \
    do { \
        _Pragma("clang diagnostic push") \
        _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
        Stuff; \
        _Pragma("clang diagnostic pop") \
    } while (0)

#import "UILabel+Common.h"
#import <objc/runtime.h>

@implementation UILabel (Common)
static const void *autoWrapKey  = &autoWrapKey;
static const void *textConfigureKey  = &textConfigureKey;
// MARK: method
+ (void)load {
    Method setText = class_getInstanceMethod([UILabel class], @selector(setText:));
    Method setTextSelf = class_getInstanceMethod([self class], @selector(setTextHooked:));
    
    SEL sel = sel_registerName("setTextOriginal:");
    IMP setTextImp = method_getImplementation(setText);
    class_addMethod([UILabel class], sel, setTextImp, method_getTypeEncoding(setText));
    IMP setTextSelfImp = method_getImplementation(setTextSelf);
    class_replaceMethod([UILabel class], @selector(setText:), setTextSelfImp, method_getTypeEncoding(setText));
}

- (void)setTextHooked:(NSString *)string {
    SEL sel = sel_registerName("setTextOriginal:");
    SuppressPerformSelectorLeakWarning(
        [self performSelector:sel withObject:string];
    );
    if (string && self.isAutoWrap) {
        [self setIsAutoWrap:YES];
    }
}

// MARK: set & get
- (void)setIsAutoWrap:(BOOL)isAutoWrap {
    objc_setAssociatedObject(self, autoWrapKey, @(isAutoWrap), OBJC_ASSOCIATION_ASSIGN);
    if (isAutoWrap && self.text) {
        self.numberOfLines = 0;
        [self setAttributeConfigure:nil];
    }
}

- (BOOL)isAutoWrap {
    return [objc_getAssociatedObject(self, autoWrapKey) boolValue];
}

- (void)setTextConfigure:(TextConfigure *)textConfigure {
    objc_setAssociatedObject(self, textConfigureKey, textConfigure, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (textConfigure && self.isAutoWrap)
        [self setAttributeConfigure:textConfigure];
}

- (TextConfigure *)textConfigure {
    return objc_getAssociatedObject(self, textConfigureKey);
}

// MARK: public
-(void)jaf_setLinspace:(CGFloat)linspace{
    NSMutableAttributedString *detailAttributedString =
    [[NSMutableAttributedString alloc] initWithString:self.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:linspace];
    [detailAttributedString addAttribute:NSParagraphStyleAttributeName
                                   value:paragraphStyle
                                   range:NSMakeRange(0, [self.text length])];
    self.attributedText = detailAttributedString;
}

- (CGFloat)getTextWidth {
    NSMutableDictionary *textDict = [self getConfigure:self.textConfigure];
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDict context:nil].size;
    return size.width;
}

- (CGFloat)getTextHeight {
    NSMutableDictionary *textDict = [self getConfigure:self.textConfigure];
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDict context:nil].size;
    return size.height;
}

// MARK: private
- (void)setAttributeConfigure:(nullable TextConfigure *)textConfigure  {
    if (!self.isAutoWrap) return;
    NSMutableDictionary *textDict = [self getConfigure:textConfigure];
    self.attributedText = [[NSAttributedString alloc] initWithString:self.text attributes:textDict];
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDict context:nil].size;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, size.height);
}

- (NSMutableDictionary *)getConfigure:(nullable TextConfigure *)textConfigure {
    NSMutableDictionary *textDict = [NSMutableDictionary dictionary];
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];

    if (textConfigure) {
        if (textConfigure.lineSpaing > 0)
            paraStyle.lineSpacing = textConfigure.lineSpaing;
        if (textConfigure.wordSpaing > 0)
            textDict[NSKernAttributeName] = @(textConfigure.wordSpaing);
    }
    paraStyle.firstLineHeadIndent = 0;
    textDict[NSParagraphStyleAttributeName] = paraStyle;
    textDict[NSFontAttributeName] = self.font;
    return textDict;
}
@end

@implementation TextConfigure

+ (TextConfigure *)shareTextConfigure {
    TextConfigure *textConfigure = [[TextConfigure alloc] init];
    return textConfigure;
}
@end
