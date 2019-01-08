#import <UIKit/UIKit.h>
@interface JobProviderCellheyJObs : UICollectionViewCell
@property(nonatomic,retain) IBOutlet UIImageView *iconImage;
@property(nonatomic,retain) IBOutlet UILabel *lbljobname,*lblcompanyname;
@property(nonatomic,retain) IBOutlet UILabel *lbldate,*lbldesignation,*lbladdress;
@property(nonatomic,retain) IBOutlet UIButton *btntotaljob,*btndeletejob;
@end
