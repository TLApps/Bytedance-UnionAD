//
//  BUDExpressBannerViewController.m
//  BUDemo
//
//  Created by xxx on 2019/5/15.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDExpressBannerViewController.h"
#import "BUDMacros.h"
#import "BUDSlotID.h"
#import <BUAdSDK/BUNativeExpressBannerView.h>
#import <BUAdSDK/BUAdSDK.h>
#import "BUDSelectedView.h"
#import "NSString+LocalizedString.h"
#import "AppDelegate.h"

@interface BUDExpressBannerViewController ()<BUNativeExpressBannerViewDelegate>
@property(nonatomic, strong) BUDSelectedView *selectedView;
@property(nonatomic, strong) BUNativeExpressBannerView *bannerView;
@property (nonatomic, strong) UISwitch *isCarouselSwitch;

@property(nonatomic, copy) NSString *currentID;
@property(nonatomic, copy) NSDictionary *sizeDcit;
@end

@implementation BUDExpressBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.sizeDcit = @{
                          express_banner_ID         :  [NSValue valueWithCGSize:CGSizeMake(300, 45)],
                          express_banner_ID_60090   :  [NSValue valueWithCGSize:CGSizeMake(300, 45)],
                          express_banner_ID_640100  :  [NSValue valueWithCGSize:CGSizeMake(320, 50)],
                          express_banner_ID_600150  :  [NSValue valueWithCGSize:CGSizeMake(300, 75)],
                          express_banner_ID_690388  :  [NSValue valueWithCGSize:CGSizeMake(345, 194)],
                          express_banner_ID_600260  :  [NSValue valueWithCGSize:CGSizeMake(300, 130)],
                          express_banner_ID_600300  :  [NSValue valueWithCGSize:CGSizeMake(300, 150)],
                          express_banner_ID_600400_both  :  [NSValue valueWithCGSize:CGSizeMake(300, 200)],
                          express_banner_ID_600500_both  :  [NSValue valueWithCGSize:CGSizeMake(300, 250)],
                          };

    
    BUDSelcetedItem *item1 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":express_banner_ID_60090,@"title":@"600*90"}];
    BUDSelcetedItem *item2 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":express_banner_ID_640100,@"title":@"640*100"}];
    BUDSelcetedItem *item3 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":express_banner_ID_600150,@"title":@"600*150"}];
    BUDSelcetedItem *item4 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":express_banner_ID_690388,@"title":@"690*388"}];
    BUDSelcetedItem *item5 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":express_banner_ID_600260,@"title":@"600*260"}];
    BUDSelcetedItem *item6 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":express_banner_ID_600300,@"title":@"600*300"}];
    BUDSelcetedItem *item7 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":express_banner_ID_600400_both,@"title":@"600*400-both"}];
    BUDSelcetedItem *item8 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":express_banner_ID_600500_both,@"title":@"600*500-both"}];
    NSArray *titlesAndIDS = @[@[item1,item2,item3],@[item4,item5,item6],@[item7,item8]];

    __weak typeof(self) weakself = self;
    self.selectedView = [[BUDSelectedView alloc] initWithAdName:@"Express Banner" SelectedTitlesAndIDS:titlesAndIDS loadAdAction:^(NSString * _Nullable slotId) {
        __strong typeof(self) strongself = weakself;
        [strongself loadBannerWithSlotID:slotId];
    } showAdAction:^{
        __strong typeof(self) strongself = weakself;
        [strongself showBanner];
    }];
    [self.view addSubview:self.selectedView];
    self.selectedView.promptStatus = BUDPromptStatusDefault;
    
    //是否使用轮播banner的开关
    UILabel *carouselLabel = [[UILabel alloc] initWithFrame:CGRectMake(22, self.selectedView.bottom+20, 100, 30)];
    carouselLabel.text = [NSString localizedStringForKey:IsCarousel];
    carouselLabel.textColor = [UIColor blackColor];
    carouselLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:carouselLabel];
    
    self.isCarouselSwitch = [[UISwitch alloc] init];
    self.isCarouselSwitch.onTintColor = mainColor;
    self.isCarouselSwitch.frame = CGRectMake(120, self.selectedView.bottom+20, 51, 31);
    [self.view addSubview:self.isCarouselSwitch];
}

/***important:
 广告加载成功的时候，会立即渲染WKWebView。
 如果想预加载的话，建议一次最多预加载三个广告，如果超过3个会很大概率导致WKWebview渲染失败。
 */
- (void)loadBannerWithSlotID:(NSString *)slotID {
    [self.bannerView removeFromSuperview];
    
    UIWindow *window = nil;
    if ([[UIApplication sharedApplication].delegate respondsToSelector:@selector(window)]) {
        window = [[UIApplication sharedApplication].delegate window];
    }
    if (![window isKindOfClass:[UIView class]]) {
        window = [UIApplication sharedApplication].keyWindow;
    }
    if (!window) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    CGFloat bottom = 0.0;
    if (@available(iOS 11.0, *)) {
        bottom = window.safeAreaInsets.bottom;
    } else {
        // Fallback on earlier versions
    }
    
    NSValue *sizeValue = [self.sizeDcit objectForKey:slotID];
    CGSize size = [sizeValue CGSizeValue];
// important: 升级的用户请注意，初始化方法去掉了imgSize参数
    if (self.isCarouselSwitch.on) {
        self.bannerView = [[BUNativeExpressBannerView alloc] initWithSlotID:slotID rootViewController:self adSize:size interval:30];
    } else {
        self.bannerView = [[BUNativeExpressBannerView alloc] initWithSlotID:slotID rootViewController:self adSize:size];
    }
    self.bannerView.frame = CGRectMake((self.view.width-size.width)/2.0, self.view.height-size.height-bottom, size.width, size.height);
    self.bannerView.delegate = self;
    [self.bannerView loadAdData];
    self.selectedView.promptStatus = BUDPromptStatusLoading;
}

- (void)showBanner {
    [self.view addSubview:self.bannerView];
    self.selectedView.promptStatus = BUDPromptStatusDefault;
}

#pragma BUNativeExpressBannerViewDelegate
- (void)nativeExpressBannerAdViewDidLoad:(BUNativeExpressBannerView *)bannerAdView {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView didLoadFailWithError:(NSError *)error {
    self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"error:%@", error]];
}

- (void)nativeExpressBannerAdViewRenderSuccess:(BUNativeExpressBannerView *)bannerAdView {
    self.selectedView.promptStatus = BUDPromptStatusAdLoaded;
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressBannerAdViewRenderFail:(BUNativeExpressBannerView *)bannerAdView error:(NSError *)error {
    self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"error:%@", error]];
}

- (void)nativeExpressBannerAdViewWillBecomVisible:(BUNativeExpressBannerView *)bannerAdView {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressBannerAdViewDidClick:(BUNativeExpressBannerView *)bannerAdView {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterwords {
    [UIView animateWithDuration:0.25 animations:^{
        bannerAdView.alpha = 0;
    } completion:^(BOOL finished) {
        [bannerAdView removeFromSuperview];
        self.bannerView = nil;
    }];
    self.selectedView.promptStatus = BUDPromptStatusDefault;
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressBannerAdViewDidCloseOtherController:(BUNativeExpressBannerView *)bannerAdView interactionType:(BUInteractionType)interactionType {
    NSString *str;
    if (interactionType == BUInteractionTypePage) {
        str = @"ladingpage";
    } else if (interactionType == BUInteractionTypeVideoAdDetail) {
        str = @"videoDetail";
    } else {
        str = @"appstoreInApp";
    }
    [self pbud_logWithSEL:_cmd msg:str];
}
- (void)pbud_logWithSEL:(SEL)sel msg:(NSString *)msg {
    BUD_Log(@"SDKDemoDelegate BUNativeExpressBannerView In VC (%@) extraMsg:%@", NSStringFromSelector(sel), msg);
}

@end
