//
//  MutableLayer.m
//  disappear
//
//  Created by CpyShine on 13-6-19.
//  Copyright 2013年 CpyShine. All rights reserved.
//

#import "MutableLayer.h"
#import "CycleBallSprite.h"

@implementation MutableLayer

- (id)init
{
    self = [super initWithColor:ccc4(0, 0, 0, 255)];
    if (self) {
        [self setAnchorPoint:ccp(0, 0)];
        for (int i = 0; i<16; i++) {
            CycleBallSprite * sprite = [CycleBallSprite node];
            [self addChild:sprite];
            sprite.visible = false;
        }
        radiues = 40;
        centerPos = ccp(self.contentSize.width/2, self.contentSize.height/2);
        m_started = false;
        m_angle = 1.0f;
        m_timeCtrl = 5.0;
        m_r = 0;
    }
    return self;
}

-(void) startAnimation{
    
    CGPoint lPos = ccp(centerPos.x-radiues, centerPos.y);
    CGPoint rPos = ccp(centerPos.x+radiues, centerPos.y);
    
    for (int i=0; i<8; i++) {
        CycleBallSprite * cs = (CycleBallSprite*)[self.children objectAtIndex:i];
        if (cs) {
            cs.visible = true;
            [cs setPosition:ccp(-radiues, lPos.y)];
            CCActionInterval * wait = [CCActionInterval actionWithDuration:i*0.38];
            CCMoveTo * moveTo = [CCMoveTo actionWithDuration:1.0 position:lPos];
            CCCallBlock * block = [CCCallBlock actionWithBlock:^{
                [cs startCycleMove:centerPos :180];
            }];
            [cs runAction:[CCSequence actions:wait, moveTo, block, nil]];
        }
    }
    for (int i=0; i<8; i++) {
        CycleBallSprite * cs = (CycleBallSprite*)[self.children objectAtIndex:i+8];
        if (cs) {
            cs.visible = true;
            [cs setPosition:ccp(self.contentSize.width+radiues, rPos.y)];
            CCActionInterval * wait = [CCActionInterval actionWithDuration:i*0.38];
            CCMoveTo * moveTo = [CCMoveTo actionWithDuration:1.0 position:rPos];
            CCCallBlock * block = [CCCallBlock actionWithBlock:^{
                [cs startCycleMove:centerPos :0];
            }];
            [cs runAction:[CCSequence actions:wait, moveTo, block, nil]];
        }
    }
    [self scheduleUpdate];
    [self schedule:@selector(controller:)];
}

-(void) controller:(ccTime)delta{
    if (!m_started) {
        m_timeCtrl = 0;
        return;
    }
    m_timeCtrl += delta;
    if (m_timeCtrl>5.0) {
        m_angle = (arc4random()%10 + 21)/10;
        int x = arc4random()%2;
        x -= 1;
        x = (x==0)?1:x;
        m_angle *= x;
        m_r = x;
        m_timeCtrl = 0;
    }
    radiues += m_r/10;
    if(radiues<40.0){
        radiues = 40.0;
    }
    if(radiues>80.0){
        radiues = 80.0;
    }
}

-(void)update:(ccTime)delta{
    for (int i=0; i<16; i++) {
        CycleBallSprite * cs = (CycleBallSprite*)[self.children objectAtIndex:i];
        if (cs) {
            if (cs.canRo) {
                if (!m_started) {
                    m_started = true;
                }
                cs.angle += m_angle;
                cs.position = ccp( centerPos.x + cosf(cs.angle/180 * M_PI)*radiues,
                                    centerPos.y + sinf(cs.angle/ 180 * M_PI)*radiues);
            }
        }
    }
}

@end
