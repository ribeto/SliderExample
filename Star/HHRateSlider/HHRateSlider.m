//
//  HHRateSlider.m
//
//  Created by Hristo Hristov on 5/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HHRateSlider.h"
#import "Star.h"

@implementation HHRateSlider

@synthesize rating = rating_;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      
      // Initialization code
      totalWidth_ = frame.size.width;
      float shapeSide = frame.size.width / 5.0f;
      CGSize starSize = CGSizeMake(shapeSide,shapeSide);
      
      CALayer* fillLayer = [CALayer layer];
      [fillLayer setFrame:CGRectMake(0, 0, 0, frame.size.height)];
      [fillLayer setMasksToBounds:YES];
      
      // disable animation of the bounds property of the layer
      NSMutableDictionary* actions = [[NSMutableDictionary alloc] init];
      [actions setObject:[NSNull null] forKey:@"bounds"];
      [actions setObject:[NSNull null] forKey:@"position"];
      [fillLayer setActions:actions];
      [actions release];
      
      
      for( int i=0; i < 5; i++) {
        
        CAShapeLayer* star = [Star starLayerInSize:starSize andFillColor:[UIColor darkGrayColor]];
        [star setFrame:CGRectMake(i*starSize.width, 0, starSize.width, starSize.height)];
        [[self layer] addSublayer:star];
        
        CAShapeLayer* filledStar = [Star starLayerInSize:starSize andFillColor:[UIColor blueColor]];
        [filledStar setFrame:CGRectMake(i*starSize.width, 0, starSize.width, starSize.height)];
        [fillLayer addSublayer:filledStar];
      }
      
      [[self layer]  addSublayer:fillLayer];
      fillLayer_ = fillLayer;
    }
    return self;
}


- (void)sendValueChanged:(float)newValue {
  rating_ = newValue;
  
  [self sendActionsForControlEvents:UIControlEventValueChanged];
}

////////////////////////////////////////////////////////
#pragma mark - Handling touches

- (void)processTouchForLocation:(CGPoint)location {
  
  CALayer* fillLayer = fillLayer_;
  
  CGRect fillRect = [fillLayer frame];
  
  // update location x to be in 1/2 shape increments instead
  // of continuous
  float increment = totalWidth_ / 10.0f;
  
  float newlocation = ceilf( location.x / increment )*increment;
  
  // take care of the case where we want nothing selected
  if( newlocation == increment && location.x < increment / 2.0 ) {
    newlocation = 0.0;
  }
  
  if( newlocation != fillRect.size.width ) {
  
    [fillLayer setFrame:CGRectMake(fillRect.origin.x, 
                                   fillRect.origin.y, 
                                   newlocation, 
                                   fillRect.size.height)];
    
    [self sendValueChanged:newlocation / totalWidth_ * 5.0];
  }
  
}


- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
  [super beginTrackingWithTouch:touch withEvent:event];
  
  return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
  [super continueTrackingWithTouch:touch withEvent:event];
  
  CGPoint location = [touch locationInView:self];
  
  [self processTouchForLocation:location];
  
  return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
  [super endTrackingWithTouch:touch withEvent:event];
  
  CGPoint location = [touch locationInView:self];
  
  [self processTouchForLocation:location];
  
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
  [super cancelTrackingWithEvent:event];
}


////////////////////////////////////////////////////////

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [super dealloc];
}

@end
