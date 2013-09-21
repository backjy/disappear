//
//  CCDrawSprite.h
//  disappear
//
//  Created by CpyShine on 13-5-30.
//  Copyright 2013年 CpyShine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CCDrawSprite : CCDrawNode {
    int m_w;
    int m_h;
    
    BOOL m_disappear;
}

@property(nonatomic,readonly) NSInteger m_x;
@property(nonatomic,readonly) NSInteger m_y;
@property(nonatomic,readonly) ccColor4F m_color;

-(void) spawnAtX:(NSInteger)x Y:(NSInteger)y Width:(CGFloat)w Height:(CGFloat) h;

-(void) spawnDropdown;

-(void) resetPropertyA:(NSInteger)x Y:(NSInteger)y;

-(void) resetDropdown;

-(BOOL) positionInContent:(CGPoint) pos;

-(BOOL) selectedType:(ccColor4F) colorType;

-(void) disappear:(bool) callf;

-(void)randpos;

@end
