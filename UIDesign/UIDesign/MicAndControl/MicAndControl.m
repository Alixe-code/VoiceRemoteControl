//
//  MicAndControl.m
//  VoiceRemoteControl
//
//  Created by 刘俊 on 14-7-15.
//  Copyright (c) 2014年 yunzhisheng. All rights reserved.
//

#import "MicAndControl.h"

#define PLAY_BTN 100
#define LAST_BTN 101
#define NEXT_BTN 102

@implementation MicAndControl

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }
    return self;
}

-(void)initWidget
{
    //图片规格 {{0, 0}, {139, 139}}
    image1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,
                                                          micBac.frame.size.width,
                                                          micBac.frame.size.height)];
    image1.transform = CGAffineTransformMakeScale(0.38, 0.38);
    image1.alpha=0;
    image1.image = [UIImage imageNamed:@"voice1"];
    
    image2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,
                                                          micBac.frame.size.width,
                                                          micBac.frame.size.height)];
    image2.transform = CGAffineTransformMakeScale(0.38, 0.38);
    image2.alpha=0;
    image2.image = [UIImage imageNamed:@"voice2"];
    
    image3 = [[UIImageView alloc]initWithFrame:CGRectMake(33, 33,
                                                          micBac.frame.size.width - 66,
                                                          micBac.frame.size.height - 66)];
    image3.transform = CGAffineTransformMakeScale(0.38, 0.38);
    image3.alpha=0;
    image3.image = [UIImage imageNamed:@"playBtn_bac"];
    
    image4 = [[UIImageView alloc]initWithFrame:CGRectMake(30, 30,
                                                          micBac.frame.size.width-60,
                                                          micBac.frame.size.height-60)];
    image4.transform = CGAffineTransformMakeScale(0.38, 0.38);
    image4.alpha=0;
    //image4.image = [UIImage imageNamed:@"mic_normal"];
    
    micBtn.frame = CGRectMake(0, 0,
                              micBac.frame.size.width,
                              micBac.frame.size.height);
    micBtn.frame = [micBtn convertRect:micBtn.frame fromView:micBac];
    micBtn.transform = CGAffineTransformMakeScale(0.38, 0.38);
    micBtn.alpha=0;
    micBtn.delegate = self;
    
    [self addPlayerView];
    
    [self micAppear];
    
    [self switchBtn_Up];
    
    show = YES;
}

-(void)switchBtn_Up
{
    [UIView animateWithDuration:0.2 animations:^{
        
        CGRect frame = switchBtn.frame;
        frame.origin.y -= 5;
        [switchBtn setFrame:frame];
        [switchBtn setImage:[UIImage imageNamed:@"switch_h"] forState:UIControlStateNormal];
        
    } completion:^(BOOL finished) {
        
        
        
    }];
}


-(IBAction)btnSwitch
{
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame = switchBtn.frame;
        frame.origin.y += 5;
        [switchBtn setFrame:frame];
        [switchBtn setImage:[UIImage imageNamed:@"switch_n"] forState:UIControlStateNormal];
        
    } completion:^(BOOL finished) {
        
        [UIView animateKeyframesWithDuration:0.3
                                       delay:0.2
                                     options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
                                         
                                         CGRect frame = switchBtn.frame;
                                         frame.origin.y -= 5;
                                         [switchBtn setFrame:frame];
                                         
                                     } completion:^(BOOL finished) {
                                         [switchBtn setImage:[UIImage imageNamed:@"switch_h"] forState:UIControlStateNormal];
                                     }];
        
    }];
    
    if (show)
    {
        [self micDisappear];
        
        if ([self.delegate respondsToSelector:@selector(modeDidSwitch:)])
        {
            [self.delegate modeDidSwitch:NoticeLabelTouch];
        }
    }
    else
    {
        [self playerBtnDisappear];
        
        if ([self.delegate respondsToSelector:@selector(modeDidSwitch:)])
        {
            [self.delegate modeDidSwitch:NoticeLabelMusicCtl];
        }
    }
    
    show = !show;
}

-(IBAction)talkStart:(UIButton *)sender
{
    NSLog(@"--talkStart");
    
    [self showTalkingConditionView:TalkingStart];
}

-(IBAction)talkCancle:(UIButton *)sender
{
    NSLog(@"--talkCancle");
    
    [self showTalkingConditionView:TalkingCancle];
}

-(IBAction)talkStop:(UIButton *)sender
{
    NSLog(@"--talkStop");
    
    [self showTalkingConditionView:TalkingEnd];
}

-(void)addPlayerView
{
    playerBac = [[UIView alloc]initWithFrame:CGRectMake(10, 10,
                                                        micBac.frame.size.width-20,
                                                        micBac.frame.size.height-20)];
    playerBac.transform = CGAffineTransformMakeRotation(3.14);
    playerBac.alpha = 0;
    
    playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [playBtn setFrame:CGRectMake((playerBac.frame.size.width-75)/2,
                                 (playerBac.frame.size.height-75)/2,
                                 75,
                                 75)];
    [playBtn addTarget:self action:@selector(playBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    playBtn.tag = PLAY_BTN;
    [playBtn setImage:[UIImage imageNamed:@"play_n.png"] forState:UIControlStateNormal];
    [playBtn setImage:[UIImage imageNamed:@"play_h.png"] forState:UIControlStateHighlighted];
    [playerBac addSubview:playBtn];
    btnIcon = [[UIImageView alloc]initWithFrame:CGRectMake((playBtn.frame.size.width-21)/2,
                                                           (playBtn.frame.size.height-21)/2, 21, 21)];
    btnIcon.image = [UIImage imageNamed:@"pause.png"];
    btnIcon.backgroundColor = [UIColor clearColor];
    [playBtn addSubview:btnIcon];
    
    lastBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [lastBtn setImage:[UIImage imageNamed:@"last_n.png"] forState:UIControlStateNormal];
    [lastBtn setImage:[UIImage imageNamed:@"last_h.png"] forState:UIControlStateHighlighted];
    [lastBtn setFrame:CGRectMake(3, (playerBac.frame.size.height-20)/2, 20, 20)];
    //lastBtn.backgroundColor = [UIColor whiteColor];
    [lastBtn addTarget:self action:@selector(playBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    lastBtn.tag = LAST_BTN;
    [playerBac addSubview:lastBtn];
    
    nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setImage:[UIImage imageNamed:@"next_n.png"] forState:UIControlStateNormal];
    [nextBtn setImage:[UIImage imageNamed:@"next_h.png"] forState:UIControlStateHighlighted];
    [nextBtn setFrame:CGRectMake(playerBac.frame.size.width - 23, (playerBac.frame.size.height-20)/2, 20, 20)];
    //nextBtn.backgroundColor = [UIColor whiteColor];
    [nextBtn addTarget:self action:@selector(playBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    nextBtn.tag = NEXT_BTN;
    [playerBac addSubview:nextBtn];
    
    pause = NO;
}

-(void)showTalkingConditionView:(TalkingConditionType)type
{
    if (talkingView==nil)
    {
        talkingView = [[UIView alloc]initWithFrame:self.window.frame];
//        talkingView.backgroundColor = [UIColor greenColor];
//        talkingView.alpha = 0.7;
        
        //音量显示
        UIImage *frameImage = [UIImage imageNamed:@"volume1"];
        volumeView  = [[UIImageView alloc]initWithFrame:CGRectMake((talkingView.frame.size.width - frameImage.size.width)/2,
                                                                   talkingView.frame.size.height - frameImage.size.height-28,
                                                                   frameImage.size.width,
                                                                   frameImage.size.height)];
        [volumeView setImage:frameImage];
        [talkingView addSubview:volumeView];
        
        UIImage *talkIcon = [UIImage imageNamed:@"talkLoading"];
        UIImage *pop = [UIImage imageNamed:@"pop"];
        
        UIImageView *talkIconView = [[UIImageView alloc]initWithImage:talkIcon];
        talkIconView.center = CGPointMake(self.window.frame.size.width/2,
                                          self.window.frame.size.height/2-20);
        UIImageView *popView = [[UIImageView alloc]initWithImage:pop];
        popView.center = CGPointMake(self.window.frame.size.width/2,
                                     self.window.frame.size.height/2-20);
        
        [talkingView addSubview:popView];
        [talkingView addSubview:talkIconView];
        
        UILabel *talkingTitle = [[UILabel alloc]initWithFrame:CGRectMake((popView.frame.size.width - 140)/2, 10, 140, 30)];
        talkingTitle.text = @"正在录入，松开发送";
        talkingTitle.textColor = [UIColor whiteColor];
        talkingTitle.font = [UIFont systemFontOfSize:15];
        talkingTitle.textAlignment = 1;
        [popView addSubview:talkingTitle];
        
        talkingLabel = [[UILabel alloc]initWithFrame:CGRectMake((popView.frame.size.width - 140)/2, 100, 140, 30)];
        talkingLabel.textColor = [UIColor whiteColor];
        talkingLabel.font = [UIFont systemFontOfSize:15];
        talkingLabel.textAlignment = 1;
        [popView addSubview:talkingLabel];
    }
    
    switch (type)
    {
        case TalkingStart:
        {
            talkingLabel.text = @"手指上滑取消";
            [self.window addSubview:talkingView];
        }
            break;
            
        case TalkingLoading:
        {
            talkingLabel.text = @"手指上滑取消";
        }
            break;
            
        case TalkingWillCancle:
        {
            talkingLabel.text = @"松开手指，取消发送";
        }
            break;
            
        case TalkingEnd:
        {
            [talkingView removeFromSuperview];
        }
            break;
            
        case TalkingCancle:
        {
            [talkingView removeFromSuperview];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark micBtn Delegate

-(void)micBtnTouchStart
{
    [self showTalkingConditionView:TalkingStart];
}

-(void)micBtnToucnEnd
{
    [self showTalkingConditionView:TalkingEnd];
    NSLog(@"micBtnToucnEnd");
}

-(void)micBtnTouchWillCancle
{
    [self showTalkingConditionView:TalkingWillCancle];
    NSLog(@"micBtnTouchWillCancle");
}

-(void)micBtnTouchLoading
{
    [self showTalkingConditionView:TalkingLoading];
    NSLog(@"micBtnTouchLoading");
}

-(void)micBtnTouchCancle
{
    [self showTalkingConditionView:TalkingCancle];
    
    NSLog(@"micBtnTouchCancle");
}

#pragma mark micbtn

-(void)micAppear
{
    [micBac addSubview:image1];
    [UIView animateWithDuration:0.3 animations:^{
        
        image1.alpha=1;
        image1.transform = CGAffineTransformMakeScale(1, 1);
        
    } completion:^(BOOL finished) {
        
        [micBac addSubview:image2];
        [UIView animateWithDuration:0.2 animations:^{
            
            image2.alpha=1;
            image2.transform = CGAffineTransformMakeScale(1, 1);
            
        } completion:^(BOOL finished) {
            
            [self addSubview:micBtn];
            [UIView animateWithDuration:0.2 animations:^{
                
                micBtn.alpha=1;
                micBtn.transform = CGAffineTransformMakeScale(1, 1);
                
            } completion:^(BOOL finished) {
                
            }];
        }];
    }];
}

-(void)micDisappear
{
    [UIView animateWithDuration:0.2 animations:^{
        
        micBtn.alpha = 0;
        micBtn.transform = CGAffineTransformMakeScale(0.38, 0.38);
        
    } completion:^(BOOL finished) {
        
        [micBtn removeFromSuperview];

        [UIView animateWithDuration:0.3 animations:^{
            
            image2.transform = CGAffineTransformMakeScale(0.38, 0.38);
            image2.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            [image2 removeFromSuperview];
            
            [UIView animateWithDuration:0.2 animations:^{
                
                image1.alpha = 0;
                image1.transform = CGAffineTransformMakeScale(0.38, 0.38);
                
            } completion:^(BOOL finished) {
                
                [image1 removeFromSuperview];
                [self playerBtnAppear];
                
            }];
        }];
    }];
}

#pragma mark playerBtn

-(void)swtichBacView:(BOOL)appear
{
    if (appear)
    {
        CGRect lastFrame = [playerBac convertRect:lastBtn.frame toView:self];
        [lastBtn setFrame:lastFrame];
        [lastBtn removeFromSuperview];
        [self addSubview:lastBtn];
        
        CGRect nextFrame = [playerBac convertRect:nextBtn.frame toView:self];
        [nextBtn setFrame:nextFrame];
        [nextBtn removeFromSuperview];
        [self addSubview:nextBtn];
        
        CGRect playFrame = [playerBac convertRect:playBtn.frame toView:self];
        [playBtn setFrame:playFrame];
        [playBtn removeFromSuperview];
        [self addSubview:playBtn];
    }
    else
    {
        CGRect lastFrame = [self convertRect:lastBtn.frame toView:playerBac];
        [lastBtn setFrame:lastFrame];
        [lastBtn removeFromSuperview];
        [playerBac addSubview:lastBtn];
        
        CGRect nextFrame = [self convertRect:nextBtn.frame toView:playerBac];
        [nextBtn setFrame:nextFrame];
        [nextBtn removeFromSuperview];
        [playerBac addSubview:nextBtn];
        
        CGRect playFrame = [self convertRect:playBtn.frame toView:playerBac];
        [playBtn setFrame:playFrame];
        [playBtn removeFromSuperview];
        [playerBac addSubview:playBtn];
    }
}

-(void)playerBtnAppear
{
    [micBac addSubview:image1];
    [UIView animateWithDuration:0.2 animations:^{
        
        image1.alpha=1;
        image1.transform = CGAffineTransformMakeScale(1, 1);
        
    } completion:^(BOOL finished) {
        
        [micBac addSubview:image3];
        [UIView animateWithDuration:0.2 animations:^{
            
            image3.alpha=1;
            image3.transform = CGAffineTransformMakeScale(1, 1);
            
        } completion:^(BOOL finished) {
            
            [micBac addSubview:playerBac];
            [UIView animateWithDuration:0.3 animations:^{
                
                playerBac.alpha=1;
                playerBac.transform = CGAffineTransformMakeRotation(0);
                
            } completion:^(BOOL finished)
            {
                [self swtichBacView:YES];
            }];
        }];
    }];
}

-(void)playerBtnDisappear
{
    [self swtichBacView:NO];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        playerBac.alpha = 0;
        playerBac.transform = CGAffineTransformMakeRotation(M_PI);
        
    } completion:^(BOOL finished) {
        
        [playerBac removeFromSuperview];
        [UIView animateWithDuration:0.2 animations:^{
            
            image3.alpha = 0;
            image3.transform = CGAffineTransformMakeScale(0.38, 0.38);
            
        } completion:^(BOOL finished) {
            
            [image3 removeFromSuperview];
            
            [UIView animateWithDuration:0.2 animations:^{
                
                image1.alpha = 0;
                image1.transform = CGAffineTransformMakeScale(0.38, 0.38);
                
            } completion:^(BOOL finished) {
                
                [image1 removeFromSuperview];
                
                [self micAppear];
            }];
        }];
    }];
}

-(void)playBtnPressed:(UIButton *)sender
{
    MusicBtnType type;
    if (sender.tag == PLAY_BTN)
    {
        if (!pause)
        {
            btnIcon.image = [UIImage imageNamed:@"play.png"];
            type = MusicPause;
        }
        else
        {
            btnIcon.image = [UIImage imageNamed:@"pause.png"];
            type = MusicPlay;
        }
        
        pause = !pause;
    }
    else if (sender.tag == LAST_BTN)
    {
        type = MusicLast;
    }
    else if (sender.tag == NEXT_BTN)
    {
        type = MusicNext;
    }
    else
    {
        type = MusicPlay;
    }
    
    if ([self.delegate respondsToSelector:@selector(didTouchedMusicButton:)])
    {
        [self.delegate didTouchedMusicButton:type];
    }
}

#pragma mark - Event Handle

-(IBAction)returnBtn
{
    NSLog(@"returnBtn");
}

-(IBAction)homeBtn
{
    NSLog(@"homeBtn");
}

-(IBAction)infoBtn
{
    NSLog(@"infoBtn");
}

-(IBAction)showBtn
{
    NSLog(@"showBtn");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
