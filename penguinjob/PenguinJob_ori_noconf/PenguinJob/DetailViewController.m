#import "DetailViewController.h"
@interface DetailViewController ()
@end
@implementation DetailViewController
@synthesize lblheadername;
@synthesize DetailArray,ApplyArray;
@synthesize scrollView;
@synthesize myView1,myView2;
@synthesize iconImage;
@synthesize lbljobname,lblcompanyname,lblvacancy;
@synthesize lbldate,lbldesignation,lbladdress;
@synthesize btnphone,btnemail,btnwebsite;
@synthesize imgVacancy,imgDate,imgDesignation;
@synthesize imgPhone,imgEmail,imgWebsite,imgAddress;
@synthesize lblline;
@synthesize btnapply,btnsave;
@synthesize feedbackMsg;
@synthesize txtDesc,lbllineDesc;
@synthesize txtSkill,lbllineSkill,lblSkill;
@synthesize txtSalary,lbllineSalary,lblSalary;
@synthesize txtQualification,lblQualification;
@synthesize btnshare;
- (void)viewDidLoad
{
    [super viewDidLoad];
    DetailArray = [[NSMutableArray alloc] init];
    [self getJobDetailasNow];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.myView1.layer.borderWidth = 0.5;
    self.myView1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.myView1.layer.cornerRadius = 5.0f;
    self.myView1.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.myView1.layer.shadowOffset = CGSizeMake(0,0);
    self.myView1.layer.shadowRadius = 1.0f;
    self.myView1.layer.shadowOpacity = 1;
    self.myView1.layer.masksToBounds = NO;
    self.myView1.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.myView1.bounds cornerRadius:self.myView1.layer.cornerRadius].CGPath;
    self.myView2.layer.borderWidth = 0.5;
    self.myView2.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.myView2.layer.cornerRadius = 5.0f;
    self.myView2.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.myView2.layer.shadowOffset = CGSizeMake(0,0);
    self.myView2.layer.shadowRadius = 1.0f;
    self.myView2.layer.shadowOpacity = 1;
    self.myView2.layer.masksToBounds = NO;
    self.myView2.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.myView2.bounds cornerRadius:self.myView2.layer.cornerRadius].CGPath;
    iconImage.layer.borderWidth = 0.3f;
    iconImage.layer.borderColor = [UIColor grayColor].CGColor;
    iconImage.layer.cornerRadius = 1.0f;
    iconImage.clipsToBounds = YES;
    btnapply.layer.cornerRadius = 5.0f;
    btnapply.layer.shadowColor = [UIColor grayColor].CGColor;
    btnapply.layer.shadowOffset = CGSizeMake(0,0);
    btnapply.layer.shadowRadius = 2.0f;
    btnapply.layer.shadowOpacity = 2;
    btnapply.layer.masksToBounds = NO;
    btnapply.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:btnapply.layer.bounds cornerRadius:btnapply.layer.cornerRadius].CGPath;
    btnsave.layer.cornerRadius = 5.0f;
    btnsave.layer.shadowColor = [UIColor blackColor].CGColor;
    btnsave.layer.shadowOffset = CGSizeMake(0,0);
    btnsave.layer.shadowRadius = 2.0f;
    btnsave.layer.shadowOpacity = 2;
    btnsave.layer.masksToBounds = NO;
    btnsave.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:btnsave.layer.bounds cornerRadius:btnsave.layer.cornerRadius].CGPath;
}
-(void)getJobDetailasNow
{
    [self checkInternetConnection];
    if (internetStatus == 0)
    {
        [self startSpinner];
        [self Networkfailure];
    }
    else
    {
        [self startSpinner];
        NSString *jobID = [[NSUserDefaults standardUserDefaults] valueForKey:@"JOB_ID"];
        NSString *str = [NSString stringWithFormat:@"%@api.php?job_id=%@",[CommonUtils getBaseURL],jobID];
        NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSLog(@"Job Detail API URL : %@",encodedString);
        [self getJobDetailasNowData:encodedString];
    }
}
-(void)getJobDetailasNowData:(NSString *)requesturl
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:requesturl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"Job Detail Response Data : %@",responseObject);
         NSDictionary *errordict = (NSDictionary *)responseObject;
         NSArray *storeArr = [errordict[@"JOBS_APP"] mutableCopy];
         for (int i=0; i<storeArr.count; i++)
         {
             NSDictionary *storeDict = [storeArr objectAtIndex:i];
             [DetailArray addObject:storeDict];
         }
         NSLog(@"DetailArray Count : %lu",(unsigned long)DetailArray.count);
         NSString *jobid = [[DetailArray valueForKey:@"id"] componentsJoinedByString:@","];
         EGODatabase *db = [EGODatabase databaseWithPath:[[CommonUtils ShareInstance] getDBPath]];
         NSString *selectQuery = [NSString stringWithFormat:@"SELECT * FROM Favourite WHERE jobid='%@'",jobid];
         EGODatabaseResult *result = [db executeQuery:selectQuery];
         if (result.rows.count > 0) {
             [btnsave setTitle:@"  ALREADY SAVED" forState:UIControlStateNormal];
         } else {
             [btnsave setTitle:@"  SAVE THIS JOB" forState:UIControlStateNormal];
         }
         [self setDataIntoScrollAndplay];
         [self stopSpinner];
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         [KSToastView ks_showToast:[CommonUtils ServerErrorMsg] duration:5.0f];
     }];
}
-(void)setDataIntoScrollAndplay
{
    lblheadername.text = [[DetailArray valueForKey:@"job_name"] componentsJoinedByString:@","];
    NSString *str = [[DetailArray valueForKey:@"job_image_thumb"] componentsJoinedByString:@","];
    NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *ImageUrl = [NSURL URLWithString:encodedString];
    UIImage *imagea = [UIImage imageNamed:@"placeholder"];
    [iconImage sd_setImageWithURL:ImageUrl placeholderImage:imagea];
    NSString *jobName = [[DetailArray valueForKey:@"job_name"] componentsJoinedByString:@","];
    CGSize maximumLabelSize = CGSizeMake(FLT_MIN, FLT_MAX);
    CGRect textRect = [jobName boundingRectWithSize:maximumLabelSize
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:[UIFont fontWithName:@"OpenSans-Semibold" size:14.0f]}
                                         context:nil];
    CGSize expectedLabelSize = textRect.size;
    CGRect newFrame = lbljobname.frame;
    newFrame.size.height = expectedLabelSize.height;
    lbljobname.frame = newFrame;
    lbljobname.numberOfLines = 0;
    lbljobname.text = jobName;
    [lbljobname sizeToFit];
    NSString *companyName = [[DetailArray valueForKey:@"job_company_name"] componentsJoinedByString:@","];
    CGSize maximumLabelSize1 = CGSizeMake(FLT_MIN, FLT_MAX);
    CGRect textRect1 = [jobName boundingRectWithSize:maximumLabelSize1
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName:[UIFont fontWithName:@"OpenSans-Semibold" size:14.0f]}
                                            context:nil];
    CGSize expectedLabelSize1 = textRect1.size;
    CGRect newFrame1 = lblcompanyname.frame;
    newFrame1.size.height = expectedLabelSize1.height;
    lblcompanyname.frame = newFrame1;
    lblcompanyname.numberOfLines = 0;
    lblcompanyname.text = companyName;
    [lblcompanyname sizeToFit];
    CGFloat lbljobnamehieght = [self getLabelHeightForFDisplay:lbljobname];
    [lblcompanyname setFrame:CGRectMake(77, lbljobnamehieght+7, self.myView1.frame.size.width-86, 30)];
    CGFloat lblcompanynamehieght = [self getLabelHeightForFDisplay:lblcompanyname];
    NSInteger jobNamelineCount = 0;
    CGSize textSize = CGSizeMake(lbljobname.frame.size.width, MAXFLOAT);
    long rHeight = lroundf([lbljobname sizeThatFits:textSize].height);
    long charSize = lroundf(lbljobname.font.lineHeight);
    jobNamelineCount = rHeight/charSize;
    NSLog(@"Job Name lines: %li",(long)jobNamelineCount);
    NSInteger companyNamelineCount = 0;
    CGSize textSize1 = CGSizeMake(lblcompanyname.frame.size.width, MAXFLOAT);
    long rHeight1 = lroundf([lblcompanyname sizeThatFits:textSize1].height);
    long charSize1 = lroundf(lblcompanyname.font.lineHeight);
    companyNamelineCount = rHeight1/charSize1;
    NSLog(@"Company Name lines: %li",(long)companyNamelineCount);
    lblvacancy.text = [NSString stringWithFormat:@"Vacancy :- %@",[[DetailArray valueForKey:@"job_vacancy"] componentsJoinedByString:@","]];
    lbldate.text = [NSString stringWithFormat:@"Date Posted :- %@",[[DetailArray valueForKey:@"job_date"] componentsJoinedByString:@","]];
    lbldesignation.text = [NSString stringWithFormat:@"Designation :- %@",[[DetailArray valueForKey:@"job_designation"] componentsJoinedByString:@","]];
    [btnphone setTitle:[NSString stringWithFormat:@"Phone :- %@",[[DetailArray valueForKey:@"job_phone_number"] componentsJoinedByString:@","]] forState:UIControlStateNormal];
    [btnemail setTitle:[NSString stringWithFormat:@"Email :- %@",[[DetailArray valueForKey:@"job_mail"] componentsJoinedByString:@","]] forState:UIControlStateNormal];
    [btnwebsite setTitle:[NSString stringWithFormat:@"Website :- %@",[[DetailArray valueForKey:@"job_company_website"] componentsJoinedByString:@","]] forState:UIControlStateNormal];
    NSString *address = [[DetailArray valueForKey:@"job_address"] componentsJoinedByString:@","];
    CGSize maximumLabelSize3 = CGSizeMake(FLT_MIN, FLT_MAX);
    CGRect textRect3 = [address boundingRectWithSize:maximumLabelSize3
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName:[UIFont fontWithName:@"OpenSans-Semibold" size:14.0f]}
                                             context:nil];
    CGSize expectedLabelSize3 = textRect3.size;
    CGRect newFrame3 = lbladdress.frame;
    newFrame3.size.height = expectedLabelSize3.height;
    lbladdress.frame = newFrame3;
    lbladdress.numberOfLines = 0;
    lbladdress.text = address;
    [lbladdress sizeToFit];
    CGFloat lbladdresshieght = [self getLabelHeightForFDisplay:lbladdress];
    if (jobNamelineCount==1 && companyNamelineCount==1) {
        NSLog(@"1 Line Data Only");
        [lbladdress setFrame:CGRectMake(30, 260, self.myView1.frame.size.width-45, lbladdresshieght)];
        [lblline setFrame:CGRectMake(7, 260+lbladdresshieght+7, self.myView1.frame.size.width-14, 1)];
        [btnapply setFrame:CGRectMake(7, 260+lbladdresshieght+7+10, 110, 35)];
        [btnsave setFrame:CGRectMake(132, 260+lbladdresshieght+7+10, 140, 35)];
        [myView1 setFrame:CGRectMake(10, 10, myView1.frame.size.width, 260+lbladdresshieght+7+10+35+10)];
        txtDesc.backgroundColor = [UIColor clearColor];
        NSString *htmldesc = [[DetailArray valueForKey:@"job_desc"] componentsJoinedByString:@","];
        NSAttributedString *attributeddesc = [[NSAttributedString alloc] initWithData:[htmldesc dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        NSMutableAttributedString *descString = [[NSMutableAttributedString alloc] initWithAttributedString:attributeddesc];
        NSRange rangeDesc = (NSRange){0,[descString length]};
        [descString enumerateAttribute:NSFontAttributeName inRange:rangeDesc options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id value, NSRange range, BOOL *stop) {
            [descString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"OpenSans-Semibold" size:14.0f] range:rangeDesc];
            [descString addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range];
        }];
        [txtDesc setScrollEnabled:NO];
        txtDesc.textColor = [UIColor darkGrayColor];
        txtDesc.attributedText = descString;
        [txtDesc setScrollEnabled:YES];
        CGRect frame = txtDesc.frame;
        frame.size.height = txtDesc.contentSize.height;
        txtDesc.frame = frame;
        CGFloat descHieght = frame.size.height;
        [lbllineDesc setFrame:CGRectMake(10, descHieght+10+30, self.myView2.frame.size.width-20, 1)];
        [lblSkill setFrame:CGRectMake(10, descHieght+18+30, 75, 30)];
        txtSkill.backgroundColor = [UIColor clearColor];
        NSString *htmlSkill = [[DetailArray valueForKey:@"job_skill"] componentsJoinedByString:@","];
        NSAttributedString *attributedSkill = [[NSAttributedString alloc] initWithData:[htmlSkill dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        NSMutableAttributedString *skillString = [[NSMutableAttributedString alloc] initWithAttributedString:attributedSkill];
        NSRange rangeSkill = (NSRange){0,[skillString length]};
        [skillString enumerateAttribute:NSFontAttributeName inRange:rangeSkill options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id value, NSRange range, BOOL *stop) {
            [skillString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"OpenSans-Semibold" size:14.0f] range:rangeSkill];
            [skillString addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range];
        }];
        [txtSkill setScrollEnabled:NO];
        txtSkill.textColor = [UIColor darkGrayColor];
        txtSkill.attributedText = skillString;
        [txtSkill setScrollEnabled:YES];
        CGRect frameSkill = txtSkill.frame;
        frameSkill.size.height = txtSkill.contentSize.height;
        txtSkill.frame = frameSkill;
        CGFloat skillHieght = frameSkill.size.height;
        [txtSkill setFrame:CGRectMake(5, descHieght+18+28+30, myView2.frame.size.width-10, skillHieght)];
        [lbllineSkill setFrame:CGRectMake(10, descHieght+18+28+skillHieght+10+30, self.myView2.frame.size.width-20, 1)];
        [lblSalary setFrame:CGRectMake(10, descHieght+18+28+skillHieght+10+10+30, 75, 30)];
        txtSalary.backgroundColor = [UIColor clearColor];
        NSString *htmlSalary = [[DetailArray valueForKey:@"job_salary"] componentsJoinedByString:@","];
        NSAttributedString *attributedSalary = [[NSAttributedString alloc] initWithData:[htmlSalary dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        NSMutableAttributedString *salaryString = [[NSMutableAttributedString alloc] initWithAttributedString:attributedSalary];
        NSRange rangeSalary = (NSRange){0,[salaryString length]};
        [salaryString enumerateAttribute:NSFontAttributeName inRange:rangeSalary options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id value, NSRange range, BOOL *stop) {
            [salaryString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"OpenSans-Semibold" size:14.0f] range:rangeSalary];
            [salaryString addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range];
        }];
        [txtSalary setScrollEnabled:NO];
        txtSalary.textColor = [UIColor darkGrayColor];
        txtSalary.attributedText = salaryString;
        [txtSalary setScrollEnabled:YES];
        CGRect frameSalary = txtSalary.frame;
        frameSalary.size.height = txtSalary.contentSize.height;
        txtSalary.frame = frameSalary;
        CGFloat salaryHieght = frameSalary.size.height;
        [txtSalary setFrame:CGRectMake(5, descHieght+18+28+skillHieght+18+28+30, myView2.frame.size.width-10, salaryHieght)];
        [lbllineSalary setFrame:CGRectMake(10, descHieght+18+28+skillHieght+10+salaryHieght+10+33+30, self.myView2.frame.size.width-20, 1)];
        [lblQualification setFrame:CGRectMake(10, descHieght+18+28+skillHieght+10+10+salaryHieght+10+10+25+30, 150, 30)];
        txtQualification.backgroundColor = [UIColor clearColor];
        NSString *htmlQualification = [[DetailArray valueForKey:@"job_qualification"] componentsJoinedByString:@","];
        NSAttributedString *attributedQualification = [[NSAttributedString alloc] initWithData:[htmlQualification dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        NSMutableAttributedString *qualificationString = [[NSMutableAttributedString alloc] initWithAttributedString:attributedQualification];
        NSRange rangeQualification = (NSRange){0,[qualificationString length]};
        [qualificationString enumerateAttribute:NSFontAttributeName inRange:rangeQualification options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id value, NSRange range, BOOL *stop) {
            [qualificationString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"OpenSans-Semibold" size:14.0f] range:rangeQualification];
            [qualificationString addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range];
        }];
        [txtQualification setScrollEnabled:NO];
        txtQualification.textColor = [UIColor darkGrayColor];
        txtQualification.attributedText = qualificationString;
        [txtQualification setScrollEnabled:YES];
        CGRect frameQualification = txtQualification.frame;
        frameQualification.size.height = txtQualification.contentSize.height;
        txtQualification.frame = frameQualification;
        CGFloat qualificationHieght = frameQualification.size.height;
        [txtQualification setFrame:CGRectMake(5, descHieght+18+28+skillHieght+18+28+salaryHieght+18+28+30, myView2.frame.size.width-10, qualificationHieght)];
        [myView2 setFrame:CGRectMake(10, myView1.frame.size.height+22, myView2.frame.size.width, descHieght+70+skillHieght+30+salaryHieght+30+15+qualificationHieght+30)];
        [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, descHieght+18+28+skillHieght+18+28+salaryHieght+18+28+qualificationHieght+18+28+30+myView1.frame.size.height)];
    } else {
        [imgVacancy setFrame:CGRectMake(7, lbljobnamehieght+6+lblcompanynamehieght+6+5, 18, 20)];
        [lblvacancy setFrame:CGRectMake(30, lbljobnamehieght+lblcompanynamehieght+9+5, self.myView1.frame.size.width-86, 25)];
        [imgDate setFrame:CGRectMake(3, lbljobnamehieght+lblcompanynamehieght+7+25+10, 25, 25)];
        [lbldate setFrame:CGRectMake(30, lbljobnamehieght+lblcompanynamehieght+7+25+10, self.myView1.frame.size.width-86, 25)];
        [imgDesignation setFrame:CGRectMake(3, lbljobnamehieght+lblcompanynamehieght+7+25+10+28, 25, 25)];
        [lbldesignation setFrame:CGRectMake(30, lbljobnamehieght+lblcompanynamehieght+7+25+10+28, self.myView1.frame.size.width-86, 25)];
        [imgPhone setFrame:CGRectMake(3, lbljobnamehieght+lblcompanynamehieght+7+25+10+28+28, 25, 25)];
        [btnphone setFrame:CGRectMake(30, lbljobnamehieght+lblcompanynamehieght+7+25+10+28+28, self.myView1.frame.size.width-86, 25)];
        [imgEmail setFrame:CGRectMake(3, lbljobnamehieght+lblcompanynamehieght+7+25+10+28+28+28, 25, 25)];
        [btnemail setFrame:CGRectMake(30, lbljobnamehieght+lblcompanynamehieght+7+25+10+28+28+28, self.myView1.frame.size.width-86, 25)];
        [imgWebsite setFrame:CGRectMake(3, lbljobnamehieght+lblcompanynamehieght+7+25+10+28+28+28+28, 25, 25)];
        [btnwebsite setFrame:CGRectMake(30, lbljobnamehieght+lblcompanynamehieght+7+25+10+28+28+28+28, self.myView1.frame.size.width-86, 25)];
        [imgAddress setFrame:CGRectMake(3, lbljobnamehieght+lblcompanynamehieght+7+25+10+28+28+28+28+28, 25, 25)];
        [lbladdress setFrame:CGRectMake(30, lbljobnamehieght+lblcompanynamehieght+7+25+10+28+28+28+28+28, self.myView1.frame.size.width-86, lbladdresshieght)];
        [lblline setFrame:CGRectMake(7, lbljobnamehieght+lblcompanynamehieght+7+25+10+28+28+28+28+28+lbladdresshieght+10, self.myView1.frame.size.width-14, 1)];
        [btnapply setFrame:CGRectMake(7, lbljobnamehieght+lblcompanynamehieght+7+25+10+28+28+28+28+28+lbladdresshieght+10+10, 110, 35)];
        [btnsave setFrame:CGRectMake(132, lbljobnamehieght+lblcompanynamehieght+7+25+10+28+28+28+28+28+lbladdresshieght+10+10, 140, 35)];
        [myView1 setFrame:CGRectMake(10, 10, myView1.frame.size.width, lbljobnamehieght+lblcompanynamehieght+7+25+10+28+28+28+28+28+lbladdresshieght+10+10+35+10)];
        txtDesc.backgroundColor = [UIColor clearColor];
        NSString *htmldesc = [[DetailArray valueForKey:@"job_desc"] componentsJoinedByString:@","];
        NSAttributedString *attributeddesc = [[NSAttributedString alloc] initWithData:[htmldesc dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        NSMutableAttributedString *descString = [[NSMutableAttributedString alloc] initWithAttributedString:attributeddesc];
        NSRange rangeDesc = (NSRange){0,[descString length]};
        [descString enumerateAttribute:NSFontAttributeName inRange:rangeDesc options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id value, NSRange range, BOOL *stop) {
            [descString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"OpenSans-Semibold" size:14.0f] range:rangeDesc];
            [descString addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range];
        }];
        [txtDesc setScrollEnabled:NO];
        txtDesc.textColor = [UIColor darkGrayColor];
        txtDesc.attributedText = descString;
        [txtDesc setScrollEnabled:YES];
        CGRect frame = txtDesc.frame;
        frame.size.height = txtDesc.contentSize.height;
        txtDesc.frame = frame;
        CGFloat descHieght = frame.size.height;
        [lbllineDesc setFrame:CGRectMake(10, descHieght+10, self.myView2.frame.size.width-20, 1)];
        [lblSkill setFrame:CGRectMake(10, descHieght+18, 75, 30)];
        txtSkill.backgroundColor = [UIColor clearColor];
        NSString *htmlSkill = [[DetailArray valueForKey:@"job_skill"] componentsJoinedByString:@","];
        NSAttributedString *attributedSkill = [[NSAttributedString alloc] initWithData:[htmlSkill dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        NSMutableAttributedString *skillString = [[NSMutableAttributedString alloc] initWithAttributedString:attributedSkill];
        NSRange rangeSkill = (NSRange){0,[skillString length]};
        [skillString enumerateAttribute:NSFontAttributeName inRange:rangeSkill options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id value, NSRange range, BOOL *stop) {
            [skillString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"OpenSans-Semibold" size:14.0f] range:rangeSkill];
            [skillString addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range];
        }];
        [txtSkill setScrollEnabled:NO];
        txtSkill.textColor = [UIColor darkGrayColor];
        txtSkill.attributedText = skillString;
        [txtSkill setScrollEnabled:YES];
        CGRect frameSkill = txtSkill.frame;
        frameSkill.size.height = txtSkill.contentSize.height;
        txtSkill.frame = frameSkill;
        CGFloat skillHieght = frameSkill.size.height;
        [txtSkill setFrame:CGRectMake(5, descHieght+18+28, myView2.frame.size.width-10, skillHieght)];
        [lbllineSkill setFrame:CGRectMake(10, descHieght+18+28+skillHieght+10, self.myView2.frame.size.width-20, 1)];
        [lblSalary setFrame:CGRectMake(10, descHieght+18+28+skillHieght+10+10, 75, 30)];
        txtSalary.backgroundColor = [UIColor clearColor];
        NSString *htmlSalary = [[DetailArray valueForKey:@"job_salary"] componentsJoinedByString:@","];
        NSAttributedString *attributedSalary = [[NSAttributedString alloc] initWithData:[htmlSalary dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        NSMutableAttributedString *salaryString = [[NSMutableAttributedString alloc] initWithAttributedString:attributedSalary];
        NSRange rangeSalary = (NSRange){0,[salaryString length]};
        [salaryString enumerateAttribute:NSFontAttributeName inRange:rangeSalary options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id value, NSRange range, BOOL *stop) {
            [salaryString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"OpenSans-Semibold" size:14.0f] range:rangeSalary];
            [salaryString addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range];
        }];
        [txtSalary setScrollEnabled:NO];
        txtSalary.textColor = [UIColor darkGrayColor];
        txtSalary.attributedText = salaryString;
        [txtSalary setScrollEnabled:YES];
        CGRect frameSalary = txtSalary.frame;
        frameSalary.size.height = txtSalary.contentSize.height;
        txtSalary.frame = frameSalary;
        CGFloat salaryHieght = frameSalary.size.height;
        [txtSalary setFrame:CGRectMake(5, descHieght+18+28+skillHieght+18+28, myView2.frame.size.width-10, salaryHieght)];
        [lbllineSalary setFrame:CGRectMake(10, descHieght+18+28+skillHieght+10+salaryHieght+10+33, self.myView2.frame.size.width-20, 1)];
        [lblQualification setFrame:CGRectMake(10, descHieght+18+28+skillHieght+10+10+salaryHieght+10+10+25, 150, 30)];
        txtQualification.backgroundColor = [UIColor clearColor];
        NSString *htmlQualification = [[DetailArray valueForKey:@"job_qualification"] componentsJoinedByString:@","];
        NSAttributedString *attributedQualification = [[NSAttributedString alloc] initWithData:[htmlQualification dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        NSMutableAttributedString *qualificationString = [[NSMutableAttributedString alloc] initWithAttributedString:attributedQualification];
        NSRange rangeQualification = (NSRange){0,[qualificationString length]};
        [qualificationString enumerateAttribute:NSFontAttributeName inRange:rangeQualification options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id value, NSRange range, BOOL *stop) {
            [qualificationString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"OpenSans-Semibold" size:14.0f] range:rangeQualification];
            [qualificationString addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range];
        }];
        [txtQualification setScrollEnabled:NO];
        txtQualification.textColor = [UIColor darkGrayColor];
        txtQualification.attributedText = qualificationString;
        [txtQualification setScrollEnabled:YES];
        CGRect frameQualification = txtQualification.frame;
        frameQualification.size.height = txtQualification.contentSize.height;
        txtQualification.frame = frameQualification;
        CGFloat qualificationHieght = frameQualification.size.height;
        [txtQualification setFrame:CGRectMake(5, descHieght+18+28+skillHieght+18+28+salaryHieght+18+28, myView2.frame.size.width-10, qualificationHieght)];
        [myView2 setFrame:CGRectMake(10, myView1.frame.size.height+22, myView2.frame.size.width, descHieght+70+skillHieght+30+salaryHieght+30+15+qualificationHieght)];
        [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, descHieght+18+28+skillHieght+18+28+salaryHieght+18+28+qualificationHieght+18+28+myView1.frame.size.height)];
    }
}
- (CGFloat)getLabelHeightForFDisplay:(UILabel *)label
{
    CGSize constraint = CGSizeMake(label.frame.size.width, CGFLOAT_MAX);
    CGSize size;
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [label.text boundingRectWithSize:constraint
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:label.font}
                                                  context:context].size;
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    return size.height;
}
-(IBAction)OnPhoneClicknvcnChangefd:(id)sender
{
    NSString *strphoneno = [[DetailArray valueForKey:@"job_phone_number"] componentsJoinedByString:@","];
    NSString *phoneNumber = [@"tel://" stringByAppendingString:strphoneno];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}
-(IBAction)OnEmaseilClickChangease:(id)sender
{
//    if ([MFMailComposeViewController canSendMail])
//    {
//        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
//        picker.mailComposeDelegate = self;
//        [picker setSubject:@"HeyJobs"];
//        NSString *stremail = [[DetailArray valueForKey:@"job_mail"] componentsJoinedByString:@","];
//        NSArray *toRecipients = [NSArray arrayWithObject:stremail];
//        [picker setToRecipients:toRecipients];
//        NSString *emailBody = @"Please write text here...";
//        [picker setMessageBody:emailBody isHTML:NO];
//        [self presentViewController:picker animated:YES completion:NULL];
//    } else {
//        self.feedbackMsg.hidden = NO;
//        self.feedbackMsg.text = @"Device not configured to send mail.";
//    }
}
- (void)mailComposeControllerSend:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    self.feedbackMsg.hidden = NO;
    switch (result)
    {
        case MFMailComposeResultCancelled:
            self.feedbackMsg.text = @"Result: Mail sending canceled";
            break;
        case MFMailComposeResultSaved:
            self.feedbackMsg.text = @"Result: Mail saved";
            break;
        case MFMailComposeResultSent:
            self.feedbackMsg.text = @"Result: Mail sent";
            break;
        case MFMailComposeResultFailed:
            self.feedbackMsg.text = @"Result: Mail sending failed";
            break;
        default:
            self.feedbackMsg.text = @"Result: Mail not sent";
            break;
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(IBAction)OnWebsiteClickChange:(id)sender
{
    NSString *website = [[DetailArray valueForKey:@"job_company_website"] componentsJoinedByString:@","];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:website]];
}
-(IBAction)OnApplyClickaseg:(id)sender
{
    BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"LOGIN"];
    if (isLogin) {
        ApplyArray = [[NSMutableArray alloc] init];
        NSArray *LoginArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"LoginArray"];
        NSString *userID = [[LoginArray valueForKey:@"user_id"] componentsJoinedByString:@","];
        NSString *jobID = [[DetailArray valueForKey:@"id"] componentsJoinedByString:@","];
        [self getApplyJobaasesf:userID JobId:jobID];
    } else {
        [KSToastView ks_showToast:[CommonUtils UserLoginMessage] duration:5.0f];
    }
}
-(void)getApplyJobaasesf:(NSString *)userId JobId:(NSString *)jobId
{
    [self checkInternetConnection];
    if (internetStatus == 0)
    {
        [self startSpinner];
        [self Networkfailure];
    }
    else
    {
        [self startSpinner];
        NSString *str = [NSString stringWithFormat:@"%@apply_job_api.php?user_id=%@&job_id=%@",[CommonUtils getBaseURL],userId,jobId];
        NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSLog(@"Apply Job API URL : %@",encodedString);
        [self getApplyJobaasesfDataWErd:encodedString];
    }
}
-(void)getApplyJobaasesfDataWErd:(NSString *)requesturl
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:requesturl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"Apply Job Response Data : %@",responseObject);
         NSDictionary *errordict = (NSDictionary *)responseObject;
         NSArray *storeArr = [errordict[@"JOBS_APP"] mutableCopy];
         for (int i=0; i<storeArr.count; i++)
         {
             NSDictionary *storeDict = [storeArr objectAtIndex:i];
             [ApplyArray addObject:storeDict];
         }
         NSLog(@"ApplyArray Count : %lu",(unsigned long)ApplyArray.count);
         NSString *msg = [[ApplyArray valueForKey:@"msg"] componentsJoinedByString:@","];
         [KSToastView ks_showToast:msg duration:5.0f];
         [self stopSpinner];
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         [KSToastView ks_showToast:[CommonUtils ServerErrorMsg] duration:5.0f];
     }];
}
-(IBAction)OnSaveClickDataadse:(id)sender
{
    NSString *cat_id = [[DetailArray valueForKey:@"cat_id"] componentsJoinedByString:@","];
    NSString *category_image = [[DetailArray valueForKey:@"category_image"] componentsJoinedByString:@","];
    NSString *category_image_thumb = [[DetailArray valueForKey:@"category_image_thumb"] componentsJoinedByString:@","];
    NSString *category_name = [[DetailArray valueForKey:@"category_name"] componentsJoinedByString:@","];
    NSString *cid = [[DetailArray valueForKey:@"cid"] componentsJoinedByString:@","];
    NSString *jobid = [[DetailArray valueForKey:@"id"] componentsJoinedByString:@","];
    NSString *job_address = [[DetailArray valueForKey:@"job_address"] componentsJoinedByString:@","];
    NSString *job_company_name = [[DetailArray valueForKey:@"job_company_name"] componentsJoinedByString:@","];
    NSString *job_company_website = [[DetailArray valueForKey:@"job_company_website"] componentsJoinedByString:@","];
    NSString *job_date = [[DetailArray valueForKey:@"job_date"] componentsJoinedByString:@","];
    NSString *job_desc = [[DetailArray valueForKey:@"job_desc"] componentsJoinedByString:@","];
    NSString *job_designation = [[DetailArray valueForKey:@"job_designation"] componentsJoinedByString:@","];
    NSString *job_image = [[DetailArray valueForKey:@"job_image"] componentsJoinedByString:@","];
    NSString *job_image_thumb = [[DetailArray valueForKey:@"job_image_thumb"] componentsJoinedByString:@","];
    NSString *job_mail = [[DetailArray valueForKey:@"job_mail"] componentsJoinedByString:@","];
    NSString *job_name = [[DetailArray valueForKey:@"job_name"] componentsJoinedByString:@","];
    NSString *job_phone_number = [[DetailArray valueForKey:@"job_phone_number"] componentsJoinedByString:@","];
    NSString *job_qualification = [[DetailArray valueForKey:@"job_qualification"] componentsJoinedByString:@","];
    NSString *job_salary = [[DetailArray valueForKey:@"job_salary"] componentsJoinedByString:@","];
    NSString *job_skill = [[DetailArray valueForKey:@"job_skill"] componentsJoinedByString:@","];
    NSString *job_vacancy = [[DetailArray valueForKey:@"job_vacancy"] componentsJoinedByString:@","];
    EGODatabase *db = [EGODatabase databaseWithPath:[[CommonUtils ShareInstance] getDBPath]];
    NSString *selectQuery = [NSString stringWithFormat:@"SELECT * FROM Favourite WHERE jobid='%@'",jobid];
    EGODatabaseResult *result = [db executeQuery:selectQuery];
    if (result.rows.count > 0)
    {
        EGODatabase *db = [EGODatabase databaseWithPath:[[CommonUtils ShareInstance] getDBPath]];
        NSString *deletequery=[NSString stringWithFormat:@"DELETE from Favourite WHERE jobid='%@'",jobid];
        [db executeQuery:deletequery];
        [KSToastView ks_showToast:@"Job has been removed" duration:3.0f];
        [btnsave setTitle:@"  SAVE THIS JOB" forState:UIControlStateNormal];
    } else {
        EGODatabase *db = [EGODatabase databaseWithPath:[[CommonUtils ShareInstance] getDBPath]];
        NSString *insertquy = [NSString stringWithFormat:@"INSERT INTO Favourite(cat_id,category_image,category_image_thumb,category_name,cid,jobid,job_address,job_company_name,job_company_website,job_date,job_desc,job_designation,job_image,job_image_thumb,job_mail,job_name,job_phone_number,job_qualification,job_salary,job_skill,job_vacancy) VALUES('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",cat_id,category_image,category_image_thumb,category_name,cid,jobid,job_address,job_company_name,job_company_website,job_date,job_desc,job_designation,job_image,job_image_thumb,job_mail,job_name,job_phone_number,job_qualification,job_salary,job_skill,job_vacancy];
        [db executeQuery:insertquy];
        [KSToastView ks_showToast:@"Job has been saved" duration:3.0f];
        [btnsave setTitle:@"  ALREADY SAVED" forState:UIControlStateNormal];
    }
}
-(IBAction)OnSHeyhareClickNow:(id)sender
{
    NSString *jobName = [[DetailArray valueForKey:@"job_name"] componentsJoinedByString:@","];
    NSString *companyName = [NSString stringWithFormat:@"Company Name :- %@",[[DetailArray valueForKey:@"job_company_name"] componentsJoinedByString:@","]];
    NSString *designation = [NSString stringWithFormat:@"Designation :- %@",[[DetailArray valueForKey:@"job_designation"] componentsJoinedByString:@","]];
    NSString *phone = [NSString stringWithFormat:@"Phone :- %@",[[DetailArray valueForKey:@"job_phone_number"] componentsJoinedByString:@","]];
    NSString *email = [NSString stringWithFormat:@"Email :- %@",[[DetailArray valueForKey:@"job_mail"] componentsJoinedByString:@","]];
    NSString *website = [NSString stringWithFormat:@"Website :- %@",[[DetailArray valueForKey:@"job_company_website"] componentsJoinedByString:@","]];
    NSString *address = [NSString stringWithFormat:@"Address :- %@ \n",[[DetailArray valueForKey:@"job_address"] componentsJoinedByString:@","]];
    NSString *shareAppLink = [NSString stringWithFormat:@"Download Application Here, \n %@",[CommonUtils getShareAppUrl]];
    NSArray *objectsToShare = @[jobName,companyName,designation,phone,email,website,address,shareAppLink];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                   UIActivityTypePrint,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo];
    activityVC.excludedActivityTypes = excludeActivities;
    CGFloat result = [[UIScreen mainScreen] bounds].size.height;
    if (result == 1024) {
        activityVC.modalPresentationStyle = UIModalPresentationPopover;
        activityVC.popoverPresentationController.sourceView = btnshare;
        [self presentViewController:activityVC animated:YES completion:nil];
    } else {
        [self presentViewController:activityVC animated:YES completion:nil];
    }
}
-(void)checkInternetConnection
{
    internetReachable = [Reachability reachabilityForInternetConnection];
    internetStatus = [internetReachable currentReachabilityStatus];
}
-(void)Networkfailure
{
    [KSToastView ks_showToast:[CommonUtils InternetConnectionErrorMsg] duration:5.0f];
    [SVProgressHUD dismiss];
    self.view.userInteractionEnabled = YES;
}
-(void)startSpinner
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    self.view.userInteractionEnabled = NO;
}
-(void)stopSpinner
{
    [SVProgressHUD dismiss];
    self.view.userInteractionEnabled = YES;
}
-(IBAction)OnBackClickDone:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
