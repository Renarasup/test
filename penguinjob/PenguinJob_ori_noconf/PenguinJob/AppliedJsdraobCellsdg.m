#import "AppliedJsdraobCellsdg.h"
@implementation AppliedJsdraobCellsdg
@synthesize iconImage;
@synthesize lblusername,lbluserphone,lbluseremail,lbluseraddress;
@synthesize btnemail,btnphone;
@synthesize btnshowresume;
- (void)awakeFromNib
{
    [super awakeFromNib];
}
- (void)drawRect:(CGRect)rect
{
    self.layer.cornerRadius = 5.0f;
    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,0);
    self.layer.shadowRadius = 2.0f;
    self.layer.shadowOpacity = 2;
    self.layer.masksToBounds = NO;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.layer.bounds cornerRadius:self.layer.cornerRadius].CGPath;
}
@end
