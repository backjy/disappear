//
//  TopScoreLayer.m
//  disappear
//
//  Created by CpyShine on 13-6-7.
//  Copyright 2013年 CpyShine. All rights reserved.
//

#import "TopScoreLayer.h"

#import "TableLayer.h"
#import "DataController.h"
#import "DotPlayingScnen.h"

@implementation TopScoreLayer

+(CCScene *)scene{
    CCScene * scene = [CCScene node];
    
    TopScoreLayer * layer = [TopScoreLayer node];
    
    [scene addChild:layer];
    [layer startAnimationDisplay];
    return scene;
}

- (id)init
{
    self = [super initWithColor:ccc4(100, 100, 100, 255)];
    if (self) {
        CGSize s= [CCDirector sharedDirector].winSize;
        
        [self setAnchorPoint:ccp(0, 0)];
        m_logoLabel = [CCLabelTTF labelWithString:@"FUCK SHIT" fontName:@"Arial" fontSize:32];
        [m_logoLabel setColor:ccc3(0, 0, 0)];
        [m_logoLabel setPosition:ccp(s.width/2, s.height - 50)];
        [self addChild:m_logoLabel];
        
//        CCSprite * levelSprite
        CCSprite * thisRound = [CCSprite spriteWithFile:@"Images/thisRoundScore.png"];
        [thisRound setPosition:ccp(60, s.height-130)];
        [self addChild:thisRound];
        m_thisRound = [CCLabelTTF labelWithString:@"" fontName:@"Arial" fontSize:18];
        [m_thisRound setColor:ccc3(0, 0, 0)];
        [m_thisRound setPosition:ccp(40, 10)];
        [thisRound addChild:m_thisRound];
        
        
        CCSprite * highScore = [CCSprite spriteWithFile:@"Images/HighScore.png"];
        [highScore setPosition:ccp(s.width/2, s.height-130)];
        [self addChild:highScore];
        m_highScore = [CCLabelTTF labelWithString:@"" fontName:@"Arial" fontSize:18];
        [m_highScore setColor:ccc3(0, 0, 0)];
        [m_highScore setPosition:ccp(40, 10)];
        [highScore addChild:m_highScore];
        
        CCSprite * goldSprite = [CCSprite spriteWithFile:@"Images/gold.png"];
        [goldSprite setPosition:ccp(s.width-60, s.height-130)];
        [self addChild:goldSprite];
        m_goldlabel = [CCLabelTTF labelWithString:@"" fontName:@"Arial" fontSize:18];
        [m_goldlabel setColor:ccc3(0, 0, 0)];
        [m_goldlabel setPosition:ccp(40, 10)];
        [goldSprite addChild:m_goldlabel];
        
        
        CCSprite * timerSprite = [CCSprite spriteWithFile:@"Images/timerb.png"];
        [timerSprite setAnchorPoint:ccp(0, 0)];
        [timerSprite setPosition:ccp(20, s.height - 200)];
        [self addChild:timerSprite];
        m_expProgress = [CCProgressTimer progressWithSprite:[CCSprite spriteWithFile:@"Images/timer.png"]];
        [m_expProgress setAnchorPoint:ccp(0,0)];
        [m_expProgress setType:kCCProgressTimerTypeBar];
        [m_expProgress setMidpoint:ccp(0, 0)];
        [m_expProgress setBarChangeRate:ccp(1,0)];
        [m_expProgress setPosition:ccp(3.5, 4.0)];
        [timerSprite addChild:m_expProgress];
        [m_expProgress setPercentage:60];
        
        
        m_levelLabel = [CCLabelTTF labelWithString:@"level:" fontName:@"Arial" fontSize:18];
        [m_levelLabel setAnchorPoint:ccp(0, 0.5)];
        [m_levelLabel setColor:ccc3(0, 0, 0)];
        [m_levelLabel setPosition:ccp(5, 20)];
        [timerSprite addChild:m_levelLabel];
        
        m_tableLayer =  [TableLayer node];
        [m_tableLayer setPosition:ccp(60, s.height/6)];
        [self addChild:m_tableLayer];
        
        
        m_imageItem = [CCMenuItemImage itemWithTarget:self selector:@selector(imageItemPressed)];
        
        CCMenu *menu = [CCMenu menuWithItems:m_imageItem, nil];
        [m_imageItem setPosition:ccp(0, -s.height/2+30)];
        [self addChild:menu];
        
        [self setVisible:false];
        
        [self setTouchMode:kCCTouchesOneByOne];
        [self setTouchEnabled:false];
    }
    return self;
}

-(void)startAnimationDisplay:(NSInteger)score{
    
    m_imageButtonResponseType = true;//play again
    
    [self setVisible:true];
    CGSize s = [CCDirector sharedDirector].winSize;
    [self stopAllActions];
    [self setPosition:ccp(s.width, 0 )];
    
    CCMoveTo  * moveTo = [CCMoveTo actionWithDuration:0.2 position:ccp(0, 0)];
    
    CCCallBlock * callB = [CCCallBlock actionWithBlock:^{
        [self loadAnimation:score :[[DataController getSharedDataController] readPlayerDefaultProperty]];
    }];
    
    [self runAction:[CCSequence actionOne:moveTo two:callB]];
    
    
    CCTexture2D * texture = [[CCTextureCache sharedTextureCache] addImage:@"Images/TopPlayingNow.png"];
    //    [m_imageItem setNormalImage:texture];
    CCSpriteFrame *frame = [CCSpriteFrame frameWithTexture:texture rect:CGRectMake(0, 0, texture.contentSize.width, texture.contentSize.height)];
    [m_imageItem setNormalSpriteFrame:frame];
    
    
    [self setTouchEnabled:true];
}


-(void)startAnimationDisplay{
    m_imageButtonResponseType = false;//return back
    [self setVisible:true];
    [self loadAnimation:0 :[[DataController getSharedDataController] readPlayerDefaultProperty]];
    
    CCTexture2D * texture = [[CCTextureCache sharedTextureCache] addImage:@"Images/TopExit.png"];
//    [m_imageItem setNormalImage:texture];
    CCSpriteFrame *frame = [CCSpriteFrame frameWithTexture:texture rect:CGRectMake(0, 0, texture.contentSize.width, texture.contentSize.height)];
    [m_imageItem setNormalSpriteFrame:frame];
    
    [self setTouchEnabled:true];
}

-(void) imageItemPressed{
    
    if (m_imageButtonResponseType) {
        
        CCScene * playingScene = [DotPlayingScnen scene];
        
        [[CCDirector sharedDirector] replaceScene:[CCTransitionMoveInR transitionWithDuration:0.2 scene:playingScene]];
    }else{
        [[CCDirector sharedDirector]popScene];
    }
}


-(void) loadAnimation:(NSInteger)score :(NSArray*) array{
    
    NSInteger level = 1;
    NSInteger gold = 1;
    long int exp = 0;
    NSInteger high = [[DataController getSharedDataController] getHighScore];
    
    if (array) {
        NSNumber * l = [array objectAtIndex:0];
        NSNumber * g = [array objectAtIndex:1];
        NSNumber * e = [array objectAtIndex:2];
        
        level = l.integerValue;
        gold = g.integerValue;
        exp = e.longValue;
    }
    
    [m_levelLabel setString:[NSString stringWithFormat:@"level:%d",level]];
    [m_goldlabel setString:[NSString stringWithFormat:@"%d",gold]];
    [m_thisRound setString:[NSString stringWithFormat:@"%d",score]];
    
    [m_highScore setString:[NSString stringWithFormat:@"%d",high]];
    
    if (m_imageButtonResponseType) {
        [m_thisRound setString:[NSString stringWithFormat:@"%d",score]];
    }else{
        [m_thisRound setString:@"--"];
    }
    
    [m_tableLayer loadLoaclLayer:1];
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    
    if (!self.visible) {
        return false;
    }
    
    CGPoint touchLocation = [touch locationInView: [touch view]];
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    
    m_touchStartLocation = [self convertToNodeSpace:touchLocation];
    
    m_canTriggerAction = true;
    
    return true;
}

-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
    
    if (!m_canTriggerAction) {
        return;
    }
    
    CGPoint touchLocation = [touch locationInView: [touch view]];
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    
    CGPoint local = [self convertToNodeSpace:touchLocation];
    
    CGFloat distance = ccpDistance(local, m_touchStartLocation);
    
    if (distance>=20) {
        m_canTriggerAction = false;
        
        if (m_touchStartLocation.x < local.x) {
            [m_tableLayer leftPageMove:200];
        }else{
            [m_tableLayer rightPageMove:200];
        }
    }
}

//-(void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event{
//    NSLog(@"toch cancel!");
//}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
//    NSLog(@"TOUCH END!");
    
    if (m_canTriggerAction) {
        return;
    }
    
    CGPoint touchLocation = [touch locationInView: [touch view]];
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    
    CGPoint local = [self convertToNodeSpace:touchLocation];
    
    CGFloat distance = ccpDistance(local, m_touchStartLocation);
    
    if (distance>=5) {
        m_canTriggerAction = false;
        
        if (m_touchStartLocation.x < local.x) {
            [m_tableLayer leftPageMove:200];
        }else{
            [m_tableLayer rightPageMove:200];
        }
    }

}

-(void)onExit{
    [super onExit];
    [self setTouchEnabled:false];
}

@end
