@interface CustomStatusBar : UIWindow
{
@private
	/// Text information
	UILabel* _statusLabel;
	/// Activity indicator
	UIActivityIndicatorView* _indicator;
}
-(void)showWithStatusMessage:(NSString*)msg;
-(void)hide;

@end