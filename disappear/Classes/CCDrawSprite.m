//
//  CCDrawSprite.m
//  disappear
//
//  Created by CpyShine on 13-5-30.
//  Copyright 2013年 CpyShine. All rights reserved.
//

#import "CCDrawSprite.h"

#include "config.h"


@implementation CCDrawSprite

@synthesize m_x;
@synthesize m_y;
@synthesize m_color;

- (id)init
{
    self = [super init];
    if (self) {
        
        [self setAnchorPoint:ccp(0.5, 0.5)];
        
        
        [self setPosition:ccp(0, 0)];
        
        [self calcColor];
    }
    return self;
}

-(CGPoint) calcPos:(NSInteger)x y:(NSInteger) y{
    
    CGFloat width = [self anchorPoint].x * m_w + x * m_w;
    CGFloat height = [self anchorPoint].y * m_h + y * m_h;
    return ccp(width, height);
}

-(void) calcColor{
    int type = arc4random()%TOTAL_TYPE;
    switch (type) {
        case 0:
            m_color = ccc4fBlue;
            break;
        case 1:
            m_color = ccc4fGreen;
            break;
        case 2:
            m_color = ccc4fOrange;
            break;
        case 3:
            m_color = ccc4fPurple;
            break;
        case 4:
            m_color = ccc4fRed;
            break;
            
        default:
            
            m_color = ccc4fRed;
            break;
    }
}

-(void)spawnAtX:(NSInteger)x Y:(NSInteger)y Width:(CGFloat)w Height:(CGFloat)h{
    
    m_disappear = YES;
    
    m_x = x;
    m_y = y;
    
    m_w = w;
    m_h = h;
    
    [self setContentSize:CGSizeMake(DRAWSPRITE_RADIUES, DRAWSPRITE_RADIUES)];
    
    [self drawDot:self.position radius:DRAWSPRITE_RADIUES color:m_color];
}

-(void) spawnDropdown{
    
    CGSize size = [CCDirector sharedDirector].winSize;
    CGFloat wd = [self anchorPoint].x * m_w + m_x * m_w;
    
    [self setPosition:ccp(wd, size.height)];
    
    CGPoint pos = [self calcPos:m_x y:m_y];
    
    CCActionInterval * wait = [CCActionInterval actionWithDuration:m_y*SPAWN_DROPDOWN_TIME/5];
    
    CCMoveTo * moveto = [CCMoveTo actionWithDuration:SPAWN_DROPDOWN_TIME position:pos];
    
    CCJumpTo * jump = [CCJumpTo actionWithDuration:SPAWN_JUMP_TIME position:pos height:30 jumps:3];
    
    CCCallBlockO * callB = [CCCallBlockO actionWithBlock:^(id object) {
        m_disappear = NO;
        self.visible = YES;
    } object:self];
    
    CCSequence * seq = [CCSequence actions:wait,moveto,jump,callB, nil];
    
    [self runAction:seq];
}

-(void)resetPropertyA:(NSInteger)x Y:(NSInteger)y{
    
    m_x = x;
    m_y = y;
}

-(void)resetDropdown{
    
    m_disappear = YES;
    
    CGPoint pos = [self calcPos:m_x y:m_y];
    
    CCMoveTo *moveto = [CCMoveTo actionWithDuration:RESET_DROPDOWN_TIME position:pos];
    
    CCJumpTo * jump = [CCJumpTo actionWithDuration:RESET_JUMP_TIME position:pos height:15 jumps:RESET_JUMP_TIMES];
    
    CCCallBlockO * callB = [CCCallBlockO actionWithBlock:^(id object) {
        m_disappear = NO;
    } object:self];
    
    CCSequence * seq = [CCSequence actions:moveto, jump, callB, nil];
    
    [self runAction:seq];
}

-(BOOL)positionInContent:(CGPoint)pos{
    
    return  CGRectContainsPoint(self.boundingBox, pos);
}

-(BOOL)selectedType:(ccColor4F)colorType{
    
    if (m_disappear || !ccc4FEqual(colorType, m_color)) {
        return NO;
    }
    
    [self setScale:1.0];
    CCScaleBy * scaleBy = [CCScaleBy actionWithDuration:0.2 scale:2.0];
    CCSequence * seq = [CCSequence actionOne:scaleBy two:[scaleBy reverse]];
    
    [self runAction:seq];
    
    return YES;
}

-(void)disappear:(bool)callf{
    
    CCScaleBy * scaleBy = [CCScaleBy actionWithDuration:0.1 scale:1.5];
    CCScaleBy * scaleBy2 = [CCScaleBy actionWithDuration:0.2 scale:0];
    CCSequence * seq = NULL;
    
    if (callf) {
        CCCallBlockO * callfu  = [CCCallBlockO actionWithBlock:^(id object) {
            
        } object:self];
        seq = [CCSequence actions:scaleBy,scaleBy2,callfu, nil];
    }else{
        seq = [CCSequence actions:scaleBy,scaleBy2, nil];
    }
    
    [self runAction:seq];
}

-(void)randpos{
    
    CGPoint pos = ccp(arc4random()%320, arc4random()%480);
    
    [self setPosition:pos];
    
    CCLOG(@"%f,%f",pos.x,pos.y);
}

@end
