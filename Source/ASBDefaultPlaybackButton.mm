//
//  ASDefaultPlaybackButton.mm
//  Texture
//
//  Copyright (c) Facebook, Inc. and its affiliates.  All rights reserved.
//  Changes after 4/13/2017 are: Copyright (c) Pinterest, Inc.  All rights reserved.
//  Licensed under Apache 2.0: http://www.apache.org/licenses/LICENSE-2.0
//

#import <AsyncDisplayKit/ASBDefaultPlaybackButton.h>
#import <AsyncDisplayKit/_ASDisplayLayer.h>

@interface ASBDefaultPlaybackButton()
{
  ASBDefaultPlaybackButtonType _buttonType;
}
@end

@implementation ASBDefaultPlaybackButton
- (instancetype)init
{
  if (!(self = [super init])) {
    return nil;
  }

  self.opaque = NO;

  return self;
}

- (void)setButtonType:(ASBDefaultPlaybackButtonType)buttonType
{
  ASBDefaultPlaybackButtonType oldType = _buttonType;
  _buttonType = buttonType;

  if (oldType != _buttonType) {
    [self setNeedsDisplay];
  }
}

- (nullable NSDictionary *)drawParametersForAsyncLayer:(_ASDisplayLayer *)layer
{
  return @{
    @"buttonType" : @(self.buttonType),
    @"color" : self.tintColor
  };
}

+ (void)drawRect:(CGRect)bounds withParameters:(NSDictionary *)parameters isCancelled:(asdisplaynode_iscancelled_block_t)isCancelledBlock isRasterizing:(BOOL)isRasterizing
{
  ASBDefaultPlaybackButtonType buttonType = (ASBDefaultPlaybackButtonType)[parameters[@"buttonType"] intValue];
  UIColor *color = parameters[@"color"];

  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  UIBezierPath* bezierPath = [UIBezierPath bezierPath];
  if (buttonType == ASDefaultPlaybackButtonTypePlay) {
    [bezierPath moveToPoint: CGPointMake(0, 0)];
    [bezierPath addLineToPoint: CGPointMake(0, bounds.size.height)];
    [bezierPath addLineToPoint: CGPointMake(bounds.size.width, bounds.size.height/2)];
    [bezierPath addLineToPoint: CGPointMake(0, 0)];
    [bezierPath closePath];
  } else if (buttonType == ASDefaultPlaybackButtonTypePause) {
    CGFloat pauseSingleLineWidth = bounds.size.width / 3.0;
    [bezierPath moveToPoint: CGPointMake(0, bounds.size.height)];
    [bezierPath addLineToPoint: CGPointMake(pauseSingleLineWidth, bounds.size.height)];
    [bezierPath addLineToPoint: CGPointMake(pauseSingleLineWidth, 0)];
    [bezierPath addLineToPoint: CGPointMake(0, 0)];
    [bezierPath addLineToPoint: CGPointMake(0, bounds.size.height)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(pauseSingleLineWidth * 2, 0)];
    [bezierPath addLineToPoint: CGPointMake(pauseSingleLineWidth * 2, bounds.size.height)];
    [bezierPath addLineToPoint: CGPointMake(bounds.size.width, bounds.size.height)];
    [bezierPath addLineToPoint: CGPointMake(bounds.size.width, 0)];
    [bezierPath addLineToPoint: CGPointMake(pauseSingleLineWidth * 2, 0)];
    [bezierPath closePath];
  }

  [color setFill];
  [bezierPath fill];

  CGContextRestoreGState(context);
}
@end
