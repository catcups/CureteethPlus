//
//  MSPlaceHolderTextView.m
//  MSUnified
//
//  Created by William on 12/22/15.
//  Copyright © 2015 max. All rights reserved.
//

#import "MSPlaceHolderTextView.h"

@implementation MSPlaceHolderTextView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.tintColor = KMainColor;
        [self setTextContainerInset:UIEdgeInsetsMake(12, 5, 0, 0)];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:nil];

    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.tintColor = KMainColor;
        [self setTextContainerInset:UIEdgeInsetsMake(12, 5, 0, 0)];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    if( [[self placeholder] length] > 0 )
    {
        if (_placeHolderLabel == nil )
        {
            _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,0,self.bounds.size.width - 16,CGRectGetHeight(self.bounds))];
            _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            _placeHolderLabel.numberOfLines = 0;
            _placeHolderLabel.font = self.font;
            _placeHolderLabel.textAlignment = NSTextAlignmentLeft;
            _placeHolderLabel.backgroundColor = [UIColor clearColor];
            _placeHolderLabel.textColor = [UIColor lightGrayColor];
            _placeHolderLabel.alpha = 0;
            _placeHolderLabel.tag = 999;
            [self addSubview:_placeHolderLabel];
        }
        _placeHolderLabel.text = self.placeholder;
//        [_placeHolderLabel sizeToFit];
        [self sendSubviewToBack:_placeHolderLabel];
    }
    
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 )
    {
        [self.placeHolderLabel setAlpha:1];
    }
}

- (void)textBeginEditing:(NSNotification *)notification{
    if (self.idelegate &&[self.delegate respondsToSelector:@selector(textViewBeginEdit:)]) {
        [self.idelegate textViewBeginEdit:self];
    }
}
- (void)textDidChange:(NSNotification *)notificatiom {
    if (self.idelegate &&[self.delegate respondsToSelector:@selector(textViewDidChange:)]) {
        [self.idelegate textViewDidChange:self];
    }
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
