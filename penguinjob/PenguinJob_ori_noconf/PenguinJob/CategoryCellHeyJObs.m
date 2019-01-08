#import "CategoryCellHeyJObs.h"
@implementation CategoryCellHeyJObs
@synthesize iconImageView;
@synthesize lblcatname;
- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)drawRect:(CGRect)rect
{
    self.layer.cornerRadius = 5.0f;
    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,0);
    self.layer.shadowRadius = 1.0f;
    self.layer.shadowOpacity = 1;
    self.layer.masksToBounds = NO;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.layer.bounds cornerRadius:self.layer.cornerRadius].CGPath;
}
@end
