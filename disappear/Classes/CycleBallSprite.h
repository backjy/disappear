//
//  CycleBallSprite.h
//  disappear
//
//  Created by CpyShine on 13-6-19.
//  Copyright 2013年 CpyShine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CycleBallSprite : CCSprite {
}

@property(readonly) BOOL canRo;
@property(readwrite) CGFloat angle;

-(void)startCycleMove:(CGPoint)cp :(CGFloat)ag;

@end
