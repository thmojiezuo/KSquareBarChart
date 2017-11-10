//
//  KSquareBar.m
//  KSquareBarChart
//
//  Created by tenghu on 2017/11/10.
//  Copyright © 2017年 tenghu. All rights reserved.
//

#import "KSquareBar.h"

#define BarTextFont  9
#define BarAnimationDuration 1.0
#define TextAnimationDuration 2.0

#define RGB(r,g,b)[UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]

static CABasicAnimation* fadeAnimation(){
    CABasicAnimation* fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    fadeAnimation.toValue = [NSNumber numberWithFloat:1.0];
    fadeAnimation.duration = TextAnimationDuration;
    return fadeAnimation;
}


@interface KSquareBar ()

@property (nonatomic, strong)CAShapeLayer *backgroundLayer; //背景层
@property (nonatomic, strong)UIBezierPath *backgroundPath; //背景赛贝尔路径
@property (nonatomic, strong)CAShapeLayer *barLayer; //柱状层
@property (nonatomic, strong)UIBezierPath *barPath; //柱状赛贝尔路径
@property (nonatomic, strong)CATextLayer *textLayer; //数值文字显示层
@property (nonatomic, assign)CGFloat barWidth;

@end

@implementation KSquareBar

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        
        _barLayer = [CAShapeLayer new];
       
        [self.layer addSublayer:_barLayer];
        _barLayer.strokeColor = [UIColor whiteColor].CGColor;
      //  _barLayer.lineCap = kCALineCapSquare;
        //  _barLayer.lineJoin = kCALineJoinRound;
        _barLayer.frame = self.bounds;
        self.barWidth = self.bounds.size.width;
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (_textLayer) {
        
        _textLayer.position = CGPointMake(self.bounds.size.width/2 , _backgroundLayer? -BarTextFont:self.bounds.size.height*(1-_barProgress)-BarTextFont);
    }
    if (_displayAnimated) {
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = BarAnimationDuration;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnimation.fromValue = @0.0f;
        pathAnimation.toValue = @1.0f;
        [_barLayer addAnimation:pathAnimation forKey:nil];
        
        if (_textLayer) {
            CABasicAnimation *fade = fadeAnimation();
            [self.textLayer addAnimation:fade forKey:nil];
        }
    }
    
}

// 设置百分百（显示动画）
- (void)setProgress{
    
    if (_barProgress == 0.0) {
        return;
    }
    
    _barPath = [UIBezierPath bezierPath];
    
    _barLayer.strokeEnd = 1.0;
    [_barPath moveToPoint:CGPointMake(self.bounds.origin.x+self.bounds.size.width/2, self.bounds.size.height)];
    [_barPath addLineToPoint:CGPointMake(self.bounds.origin.x+self.bounds.size.width/2, (self.bounds.size.height)*(1-_barProgress))];
    
    _barLayer.path = _barPath.CGPath;
    
}

- (void)setDisplayAnimated:(BOOL)displayAnimated{
    _displayAnimated = displayAnimated;
}
//设置柱子的宽度
- (void)setBarWidth:(CGFloat)barWidth{
    _barWidth = barWidth;
    _barLayer.lineWidth = _barWidth;
    [self setProgress];
}

//设置背景色
- (void)setBackgroundColor:(UIColor *)backgroundColor{
    if (backgroundColor && ![backgroundColor isEqual:[UIColor clearColor]]) {
        self.backgroundLayer.strokeColor = backgroundColor.CGColor;
    }
}

//设置柱子颜色
- (void)setBarColor:(UIColor *)barColor{
    _barLayer.strokeColor = barColor.CGColor;
}


//设置柱子进度
- (void)setBarProgress:(float)progress{
    _barProgress = progress;
    [self setProgress];
}

- (CATextLayer *)textLayer{
    if (!_textLayer) {
        _textLayer = [CATextLayer layer];
        
        _textLayer.foregroundColor = RGB(174, 126, 80).CGColor;
        _textLayer.fontSize = 7.5;
        _textLayer.alignmentMode = kCAAlignmentCenter;
        _textLayer.contentsScale = [[UIScreen mainScreen] scale];
        CGRect bounds = _barLayer.bounds;
        bounds.size.height = BarTextFont;
        bounds.size.width *= 8;
        _textLayer.bounds = bounds;
        
        [self.layer addSublayer:_textLayer];
        
        
    }
    return _textLayer;
}

- (CAShapeLayer *)backgroundLayer{
    if (!_backgroundLayer) {
        _backgroundLayer = [CAShapeLayer new];
        [self.layer insertSublayer:_backgroundLayer below:_barLayer];
        _backgroundLayer.frame = self.bounds;
        _backgroundLayer.lineWidth = _barWidth;
        _backgroundPath = [UIBezierPath bezierPath];
        [_backgroundPath moveToPoint:CGPointMake(self.bounds.origin.x+self.bounds.size.width/2, self.bounds.size.height)];
        [_backgroundPath addLineToPoint:CGPointMake(self.bounds.origin.x+self.bounds.size.width/2, self.bounds.origin.y)];
        [_backgroundPath setLineWidth:_barWidth];
        [_backgroundPath setLineCapStyle:kCGLineCapSquare];
        _backgroundLayer.path = _backgroundPath.CGPath;
        
        
    }
    return _backgroundLayer;
}
//设置数值
- (void)setBarText:(NSString*)text{
    self.textLayer.string = text;
}

-(void)dealloc{
    
    _backgroundLayer = nil; //背景层
    _backgroundPath = nil; //背景赛贝尔路径
    _barLayer = nil; //柱状层
    _barPath = nil; //柱状赛贝尔路径
    _textLayer = nil; //数值文字显示层
    
    
}



@end
