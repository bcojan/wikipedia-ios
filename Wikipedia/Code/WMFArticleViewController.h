@import UIKit;
#import "WMFAnalyticsLogging.h"
#import "MWKArticle.h"
#import "WebViewController.h"
#import "WMFTableOfContentsDisplay.h"

@class MWKDataStore;

@class WMFShareFunnel;
@class WMFArticleViewController;
@class WMFArticleDataStore;

NS_ASSUME_NONNULL_BEGIN

@protocol WMFArticleViewControllerDelegate <NSObject>

- (void)articleController:(WMFArticleViewController *)controller didUpdateArticleLoadProgress:(CGFloat)progress animated:(BOOL)animated;

- (void)articleControllerDidLoadArticle:(WMFArticleViewController *)controller;

- (void)articleControllerDidFailToLoadArticle:(WMFArticleViewController *)controller;

@end

@protocol WMFArticlePreviewingActionsDelegate <NSObject>

- (void)readMoreArticlePreviewActionSelectedWithArticleController:(WMFArticleViewController *)articleController;

- (void)shareArticlePreviewActionSelectedWithArticleController:(WMFArticleViewController *)articleController
                                       shareActivityController:(UIActivityViewController *)shareActivityController;

- (void)viewOnMapArticlePreviewActionSelectedWithArticleController:(WMFArticleViewController *)articleController;

@end

/**
 *  View controller responsible for displaying article content.
 */
@interface WMFArticleViewController : UIViewController <WMFAnalyticsContextProviding, WMFAnalyticsContentTypeProviding, WMFAnalyticsViewNameProviding, WMFWebViewControllerDelegate>

- (instancetype)initWithArticleURL:(NSURL *)url
                         dataStore:(MWKDataStore *)dataStore
                      previewStore:(WMFArticleDataStore *)previewStore;

@property (nonatomic, strong, readonly) NSURL *articleURL;
@property (nonatomic, strong, readonly) MWKDataStore *dataStore;
@property (nonatomic, strong, readonly) WMFArticleDataStore *previewStore;

@property (nonatomic, strong, nullable) dispatch_block_t articleLoadCompletion;

@property (nonatomic, strong, readonly, nullable) MWKArticle *article;

@property (nonatomic, weak) id<WMFArticleViewControllerDelegate> delegate;

@property (nonatomic) WMFTableOfContentsDisplayMode tableOfContentsDisplayMode;
@property (nonatomic) WMFTableOfContentsDisplaySide tableOfContentsDisplaySide;
@property (nonatomic) WMFTableOfContentsDisplayState tableOfContentsDisplayState;
@property (nonatomic, getter=isUpdateTableOfContentsSectionOnScrollEnabled) BOOL updateTableOfContentsSectionOnScrollEnabled;

@property (nonatomic, strong, nullable) MWKSection *currentSection;               //doesn't actually update the view, only here for access from Swift category
@property (nonatomic, strong, nullable) MWKSection *sectionToRestoreScrollOffset; //doesn't actually update the view, only here for access from Swift category
@property (nonatomic) NSInteger currentFooterIndex;                               //doesn't actually update the view, only here for access from Swift category
@property (nonatomic) NSInteger footerIndexToRestoreScrollOffset;                 //doesn't actually update the view, only here for access from Swift category

@property (nonatomic, getter=isSavingOpenArticleTitleEnabled) BOOL savingOpenArticleTitleEnabled;
@property (nonatomic, getter=isAddingArticleToHistoryListEnabled) BOOL addingArticleToHistoryListEnabled;
@property (nonatomic, getter=isPeekingAllowed) BOOL peekingAllowed;

@property (weak, nonatomic, nullable) id<WMFArticlePreviewingActionsDelegate> articlePreviewingActionsDelegate;

- (UIButton *)titleButton;

@end

@interface WMFArticleViewController (WMFBrowserViewControllerInterface)

@property (strong, nonatomic, nullable, readonly) WMFShareFunnel *shareFunnel;

- (BOOL)canRefresh;
- (BOOL)canShare;
- (BOOL)hasLanguages;
- (BOOL)hasTableOfContents;
- (BOOL)hasReadMore;
- (BOOL)hasAboutThisArticle;

- (void)fetchArticleIfNeeded;

- (void)shareArticleWhenReady;

@end

@interface WMFArticleViewController (WMFSubclasses)

@property (nonatomic, strong, readonly) UIBarButtonItem *saveToolbarItem;
@property (nonatomic, strong, readonly) UIBarButtonItem *languagesToolbarItem;
@property (nonatomic, strong, readonly) UIBarButtonItem *shareToolbarItem;
@property (nonatomic, strong, readonly) UIBarButtonItem *fontSizeToolbarItem;
@property (nonatomic, strong, readonly) UIBarButtonItem *showTableOfContentsToolbarItem;
@property (nonatomic, strong, readonly) UIBarButtonItem *hideTableOfContentsToolbarItem;

- (NSArray<UIBarButtonItem *> *)articleToolBarItems;

- (void)updateToolbarItemEnabledState;

@end

NS_ASSUME_NONNULL_END
