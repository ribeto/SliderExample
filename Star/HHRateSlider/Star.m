//
//  Star.m
//  Star
//
//  Created by Hristo Hristov on 5/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Star.h"


@implementation Star

////////////////////////////////////////////////////////
//
//         /\
//      --    --
//      \      / 
//       / / \ \
////////////////////////////////////////////////////////

CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};

// calcuate point coordinates on the cicumference on a circle
CGPoint vertexCoordinates(CGPoint center, CGFloat radius, CGFloat degrees) {
  
  float x = center.x + radius * cosf( DegreesToRadians(degrees) );
  float y = center.y + radius * sinf( DegreesToRadians(degrees) );
  
  return CGPointMake( x, y );
}

+ (CAShapeLayer*)starLayerInSize:(CGSize)size andFillColor:(UIColor*)fillColor {
  
  CAShapeLayer* layer = [[CAShapeLayer alloc] init];
  [layer setBounds:CGRectMake(0,0,size.width,size.height)];
  
  // the side of a square in which a circle is inscribed
  // that we'll draw the star in.  The vertecies of the star
  // lie on the circumfarence of that circle
  float squareSide = size.width <= size.height ? size.width : size.height;
  
  // radius of the circle on which the star's vertecies lie
  float radius = squareSide / 2.0;
  
  CGPoint center = CGPointMake( size.width / 2.0, size.height / 2.0 );
  
  int counter = 0;
  
  CGAffineTransform t = CGAffineTransformMakeRotation(M_PI);
  t = CGAffineTransformTranslate(t, -size.width, -size.height);
  
  [layer setAffineTransform:t];
  
  NSArray* degreesArray = [NSArray arrayWithObjects:
                       [NSNumber numberWithInt:18],
                       [NSNumber numberWithInt:162],
                       [NSNumber numberWithInt:306],
                       [NSNumber numberWithInt:90],
                       [NSNumber numberWithInt:234],
                       nil];
  
  UIBezierPath* path = [UIBezierPath bezierPath];
  
  
  CGFloat degrees = [[degreesArray objectAtIndex:0] floatValue];
  CGPoint fromVertex = vertexCoordinates(center, radius, degrees);
  [path moveToPoint:fromVertex];
  
  do {
    
     ++counter;
    
    degrees = [[degreesArray objectAtIndex:counter%5] floatValue];
    
    CGPoint toVertex = vertexCoordinates(center, radius, degrees);
    
    [path addLineToPoint:toVertex];
    
  } while ( counter < 5 );

  
  [layer setPath:path.CGPath];
  
  [layer setLineCap:kCALineCapRound];
  [layer setMasksToBounds:NO];
  [layer setFillColor:fillColor.CGColor];
  
  
  return [layer autorelease];
}

@end
