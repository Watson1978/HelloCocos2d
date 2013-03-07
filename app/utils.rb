# /** Helper macro that creates a CGPoint
#  @return CGPoint
#  @since v0.7.2
#  */
# static inline CGPoint ccp( CGFloat x, CGFloat y )
# {
# 	return CGPointMake(x, y);
# }
# defined in cocos2d/Support/CGPointExtension.h

def RM_ccp(x, y)
  CGPointMake(x, y)
end


# #define UI_USER_INTERFACE_IDIOM() \
#    ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] ? \
#    [[UIDevice currentDevice] userInterfaceIdiom] : \
#    UIUserInterfaceIdiomPhone)

# defined in UIKit (http://developer.apple.com/library/ios/#documentation/uikit/reference/UIKitFunctionReference/Reference/reference.html)

def UI_USER_INTERFACE_IDIOM
  if UIDevice.currentDevice.respondsToSelector("userInterfaceIdiom")
    return UIDevice.currentDevice.userInterfaceIdiom
  else
    UIUserInterfaceIdiomPhone
  end

end

# #define UIInterfaceOrientationIsLandscape(orientation) \
#    ((orientation) == UIInterfaceOrientationLandscapeLeft || \
#    (orientation) == UIInterfaceOrientationLandscapeRight)
def UIInterfaceOrientationIsLandscape(orientation)
  (orientation == UIInterfaceOrientationLandscapeLeft) || (orientation == UIInterfaceOrientationLandscapeRight)
end