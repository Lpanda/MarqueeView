//
//  MarqueeView.m
//  Marquee
//
//  Created by 杨帅 on 2017/8/24.
//  Copyright © 2017年 杨帅. All rights reserved.
//

#import "MarqueeView.h"

@interface MarqueeView ()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (strong, nonatomic) NSTimer *mainTimer;

@property (strong, nonatomic) UIView *marqueeContentView;

@end

@implementation MarqueeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initItems];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initItems];
    }
    return self;
}

- (void)initItems {
    self.steps = 0.3f;
    self.frequency = 0.01f;
    [self addSubview:self.marqueeContentView];
}

# pragma mark -
# pragma mark Get&Set
- (UIView *)marqueeContentView {
    if (!_marqueeContentView) {
        _marqueeContentView = [[[NSBundle mainBundle] loadNibNamed:@"MarqueeView"
                                                             owner:self options:nil] firstObject];
        _marqueeContentView.backgroundColor = self.backgroundColor;
    }
    return _marqueeContentView;
}

- (NSTimer *)mainTimer {
    if (!_mainTimer) {
        __weak MarqueeView *weakSelf = self;
        _mainTimer = [NSTimer scheduledTimerWithTimeInterval:self.frequency
                                                     repeats:YES
                                                       block:^(NSTimer * _Nonnull timer){
            [weakSelf refreshLabelFrame];
        }];
        [[NSRunLoop currentRunLoop] addTimer:_mainTimer forMode:NSRunLoopCommonModes];
    }
    return _mainTimer;
}

- (void)setContent:(NSString *)content {
    [self reset];
    
    _content = content;
    _contentLabel.text = content;
    [_contentLabel sizeToFit];
}

# pragma mark -
# pragma mark Timer

- (void)start {
    [self startWithContent:self.content];
}

- (void)startWithContent:(NSString *)content {
    if (!content || content.length <= 0) {
        return;
    }
    
    [self pause];
    
    if (![self.contentLabel.text isEqualToString:content]) {
        self.content = content;
        [self changeContentLabelFrameToStartPoint];
    }
    [self.mainTimer fire];
}

- (void)refreshLabelFrame {
    CGFloat orignX = _contentLabel.frame.origin.x;
    orignX -= self.steps;
    [self setContentLabelFrameX:orignX];
    
    if (CGRectGetMaxX(_contentLabel.frame) <= 0) {
        [self changeContentLabelFrameToStartPoint];
    }
}

- (void)pause {
    [self.mainTimer invalidate];
    self.mainTimer = nil;
}

- (void)reset {
    [self pause];
    [self resetContentLabelCenter];
    [self resetContentLabelFrame];
}

# pragma mark -
# pragma mark Custom Methods

- (void)resetContentLabelCenter {
    CGPoint center = _contentLabel.center;
    center.y = self.frame.size.height / 2;
    _contentLabel.center = center;
}

- (void)resetContentLabelFrame {
    CGFloat orignX = 0.0;
    [self setContentLabelFrameX:orignX];
}

- (void)changeContentLabelFrameToStartPoint {
    CGFloat orignX = self.frame.size.width;
    [self setContentLabelFrameX:orignX];
}

- (void)setContentLabelFrameX:(CGFloat)orignX {
    CGRect newFrame = _contentLabel.frame;
    newFrame.origin.x = orignX;
    _contentLabel.frame = newFrame;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self resetContentLabelCenter];
}

# pragma mark -
# pragma mark Dealloc

-(void)dealloc {
    [self pause];
}

@end
