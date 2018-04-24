#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "QMChatViewController.h"
#import "NSString+QM.h"
#import "UIColor+QM.h"
#import "UIImage+QM.h"
#import "UIView+QM.h"
#import "QMKeyboardController.h"
#import "QMChatCollectionViewDataSource.h"
#import "QMChatCollectionViewDelegateFlowLayout.h"
#import "QMChatAttachmentCell.h"
#import "QMChatAttachmentIncomingCell.h"
#import "QMChatAttachmentOutgoingCell.h"
#import "QMChatCell.h"
#import "QMChatContactRequestCell.h"
#import "QMChatIncomingCell.h"
#import "QMChatNotificationCell.h"
#import "QMChatOutgoingCell.h"
#import "QMChatCellLayoutAttributes.h"
#import "QMChatCollectionViewFlowLayout.h"
#import "QMCollectionViewFlowLayoutInvalidationContext.h"
#import "QMChatCollectionView.h"
#import "QMInputToolbar.h"
#import "QMToolbarContentView.h"
#import "QMPlaceHolderTextView.h"
#import "QMChatActionsHandler.h"
#import "QMChatContainerView.h"
#import "QMLoadEarlierHeaderView.h"
#import "QMTypingIndicatorFooterView.h"

FOUNDATION_EXPORT double QMChatViewControllerVersionNumber;
FOUNDATION_EXPORT const unsigned char QMChatViewControllerVersionString[];

