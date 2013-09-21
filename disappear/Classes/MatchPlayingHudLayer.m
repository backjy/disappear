//
//  MatchPlayingHudLayer.m
//  disappear
//
//  Created by CpyShine on 13-6-20.
//  Copyright 2013年 CpyShine. All rights reserved.
//

#import "MatchPlayingHudLayer.h"
#import "MutablePlayerScene.h"
#import "DownStateLayer.h"
#import "NetWorkHandle.h"


@implementation MatchPlayingHudLayer

- (id)init
{
    self = [super init];
    if (self) {
        [self setAnchorPoint:CGPointZero];
        
        m_downStateLayer = [DownStateLayer node];
        [self addChild:m_downStateLayer];
        self.visible = false;
        
        CGSize s =[CCDirector sharedDirector].winSize;
        
        selfName = [CCLabelTTF labelWithString:@"Name:You" fontName:@"Arial" fontSize:12];
        [selfName setColor:ccc3(0, 0, 0)];
        [selfName setPosition:ccp(40, s.height - 50)];
        [self addChild:selfName];
        pointLabel = [CCLabelTTF labelWithString:@"Score:0" fontName:@"Arial" fontSize:12];
        [pointLabel setColor:ccc3(0, 0,0)];
        [pointLabel setPosition:ccp(150, s.height - 50)];
        [self addChild:pointLabel];
        timeLabel = [CCLabelTTF labelWithString:@"Time:60" fontName:@"Arial" fontSize:12];
        [timeLabel setColor:ccc3(0, 0,0)];
        [timeLabel setPosition:ccp(250, s.height - 50)];
        [self addChild:timeLabel];
        
        oppNameLabel = [CCLabelTTF labelWithString:@"OppName:" fontName:@"Arial" fontSize:12];
        [oppNameLabel setColor:ccc3(0, 0,0)];
        [oppNameLabel setPosition:ccp(40, s.height - 90)];
        [self addChild:oppNameLabel];
        oppPoints = [CCLabelTTF labelWithString:@"OppPoint:0" fontName:@"Arial" fontSize:12];
        [oppPoints setColor:ccc3(0, 0,0)];
        [oppPoints setPosition:ccp(150, s.height - 90)];
        [self addChild:oppPoints];
    }
    return self;
}

-(void)startAnimation:(NSString *)oppname{
    self.visible = true;
    [m_downStateLayer startAnimationDisplay];
    if (oppNameLabel) {
        [oppNameLabel setString:[NSString stringWithFormat:@"OppName:%@",oppname]];
    }
}

-(void)playerUseSkill:(PLAYERTOOLTYPE)skillTpye{
    if (self.parent) {
        MutablePlayerScene * sc = (MutablePlayerScene*)self.parent;
        if (sc) {
            [sc playerUsedToolDisappear:skillTpye];
        }
    }
}

-(void)resetPoint:(NSInteger)point{
    
    if (pointLabel) {
        [pointLabel setString:[NSString stringWithFormat:@"Point:%d",point]];
    }
}

-(void)resetTimeString:(CGFloat)times{
    NSInteger t = (NSInteger)times;
    if (timeLabel) {
        [timeLabel setString:[NSString stringWithFormat:@"Time:%d",t]];
    }
}


-(void) sendMessage:(NSInteger)point{
    [[NetWorkHandle getSharedNetWork] sendCurrentPoint:self point:point];
}

-(void) reveiveMessage:(NSDictionary*)infoDic Error:(NSDictionary*) errorMsg{
   
}

-(void) gameOverMssage:(NSDictionary*)infoDic Error:(NSDictionary*) errorMsg{
}

-(void)gameOver:(NSInteger)point{
    [[NetWorkHandle getSharedNetWork] sendGameOver:self point:0];
}

-(void)onExit{
    [super onExit];
    [[NetWorkHandle getSharedNetWork] cancellationSendPoint];
    [[NetWorkHandle getSharedNetWork] cancellationGameOver];
}

@end
