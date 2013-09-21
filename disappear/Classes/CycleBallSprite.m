//
//  CycleBallSprite.m
//  disappear
//
//  Created by CpyShine on 13-6-19.
//  Copyright 2013年 CpyShine. All rights reserved.
//

#import "CycleBallSprite.h"


@implementation CycleBallSprite

@synthesize canRo;
@synthesize angle;

- (id)init
{
    self = [super initWithFile:@"Images/ball.png"];
    if (self) {
        canRo = false;
        self.scale = 0.5;
    }
    return self;
}

-(void)startCycleMove:(CGPoint)cp :(CGFloat)ag{
    
    canRo  = true;
    angle = ag;
}
@end
