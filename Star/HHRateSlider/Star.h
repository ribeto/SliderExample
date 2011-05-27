//
//  Star.h
//  Star
//
//  Created by Hristo Hristov on 5/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface Star : NSObject {
    
}

+ (CAShapeLayer*)starLayerInSize:(CGSize)size andFillColor:(UIColor*)fillColor;

@end
