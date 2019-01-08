#import "DetailViewControllerPenguin.h"
@interface DetailViewControllerPenguin ()
@end
@implementation DetailViewControllerPenguin
@synthesize lblPendaheadername;
@synthesize DetailArray,ApplyArrayPenguino;
@synthesize scrollView;
@synthesize myView1Penda,myView2Penda;
@synthesize iconImage;
@synthesize lbpPendaobname,lblPendacompanyname,lblvacancy;
@synthesize lblPendadate,lblPendadesignation,lblPendaaddress;
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
    [self getJobDetailPenda];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.myView1Penda.layer.borderWidth = 0.5;
    self.myView1Penda.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.myView1Penda.layer.cornerRadius = 5.0f;
    self.myView1Penda.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.myView1Penda.layer.shadowOffset = CGSizeMake(0,0);
    self.myView1Penda.layer.shadowRadius = 1.0f;
    self.myView1Penda.layer.shadowOpacity = 1;
    self.myView1Penda.layer.masksToBounds = NO;
    self.myView1Penda.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.myView1Penda.bounds cornerRadius:self.myView1Penda.layer.cornerRadius].CGPath;
    self.myView2Penda.layer.borderWidth = 0.5;
    self.myView2Penda.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.myView2Penda.layer.cornerRadius = 5.0f;
    self.myView2Penda.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.myView2Penda.layer.shadowOffset = CGSizeMake(0,0);
    self.myView2Penda.layer.shadowRadius = 1.0f;
    self.myView2Penda.layer.shadowOpacity = 1;
    self.myView2Penda.layer.masksToBounds = NO;
    self.myView2Penda.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.myView2Penda.bounds cornerRadius:self.myView2Penda.layer.cornerRadius].CGPath;
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
-(void)getJobDetailPenda
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
        [self getJobDetailPendaData:encodedString];
    }
}
-(void)getJobDetailPendaData:(NSString *)requesturl
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
         [self setDataIntoScrollPendaplay];
         [self stopSpinner];
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         [KSToastView ks_showToast:[CommonUtils ServerErrorMsg] duration:5.0f];
     }];
}
-(void)setDataIntoScrollPendaplay
{
    lblPendaheadername.text = [[DetailArray valueForKey:@"job_name"] componentsJoinedByString:@","];
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
    CGRect newFrame = lbpPendaobname.frame;
    newFrame.size.height = expectedLabelSize.height;
    lbpPendaobname.frame = newFrame;
    lbpPendaobname.numberOfLines = 0;
    lbpPendaobname.text = jobName;
    [lbpPendaobname sizeToFit];
    NSString *companyName = [[DetailArray valueForKey:@"job_company_name"] componentsJoinedByString:@","];
    CGSize maximumLabelSize1 = CGSizeMake(FLT_MIN, FLT_MAX);
    CGRect textRect1 = [jobName boundingRectWithSize:maximumLabelSize1
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName:[UIFont fontWithName:@"OpenSans-Semibold" size:14.0f]}
                                            context:nil];
    CGSize expectedLabelSize1 = textRect1.size;
    CGRect newFrame1 = lblPendacompanyname.frame;
    newFrame1.size.height = expectedLabelSize1.height;
    lblPendacompanyname.frame = newFrame1;
    lblPendacompanyname.numberOfLines = 0;
    lblPendacompanyname.text = companyName;
    [lblPendacompanyname sizeToFit];
    CGFloat lbljobnamehieght = [self getLabelHeightForPendaDisplay:lbpPendaobname];
    [lblPendacompanyname setFrame:CGRectMake(77, lbljobnamehieght+7, self.myView1Penda.frame.size.width-86, 30)];
    CGFloat lblcompanynamehieght = [self getLabelHeightForPendaDisplay:lblPendacompanyname];
    NSInteger jobNamelineCount = 0;
    CGSize textSize = CGSizeMake(lbpPendaobname.frame.size.width, MAXFLOAT);
    long rHeight = lroundf([lbpPendaobname sizeThatFits:textSize].height);
    long charSize = lroundf(lbpPendaobname.font.lineHeight);
    jobNamelineCount = rHeight/charSize;
    NSLog(@"Job Name lines: %li",(long)jobNamelineCount);
    NSInteger companyNamelineCount = 0;
    CGSize textSize1 = CGSizeMake(lblPendacompanyname.frame.size.width, MAXFLOAT);
    long rHeight1 = lroundf([lblPendacompanyname sizeThatFits:textSize1].height);
    long charSize1 = lroundf(lblPendacompanyname.font.lineHeight);
    companyNamelineCount = rHeight1/charSize1;
    NSLog(@"Company Name lines: %li",(long)companyNamelineCount);
    lblvacancy.text = [NSString stringWithFormat:@"Vacancy :- %@",[[DetailArray valueForKey:@"job_vacancy"] componentsJoinedByString:@","]];
    lblPendadate.text = [NSString stringWithFormat:@"Date Posted :- %@",[[DetailArray valueForKey:@"job_date"] componentsJoinedByString:@","]];
    lblPendadesignation.text = [NSString stringWithFormat:@"Designation :- %@",[[DetailArray valueForKey:@"job_designation"] componentsJoinedByString:@","]];
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
    CGRect newFrame3 = lblPendaaddress.frame;
    newFrame3.size.height = expectedLabelSize3.height;
    lblPendaaddress.frame = newFrame3;
    lblPendaaddress.numberOfLines = 0;
    lblPendaaddress.text = address;
    [lblPendaaddress sizeToFit];
    CGFloat lbladdresshieght = [self getLabelHeightForPendaDisplay:lblPendaaddress];
    if (jobNamelineCount==1 && companyNamelineCount==1) {
        NSLog(@"1 Line Data Only");
        [lblPendaaddress setFrame:CGRectMake(30, 260, self.myView1Penda.frame.size.width-45, lbladdresshieght)];
        [lblline setFrame:CGRectMake(7, 260+lbladdresshieght+7, self.myView1Penda.frame.size.width-14, 1)];
        [btnapply setFrame:CGRectMake(7, 260+lbladdresshieght+7+10, 110, 35)];
        [btnsave setFrame:CGRectMake(132, 260+lbladdresshieght+7+10, 140, 35)];
        [myView1Penda setFrame:CGRectMake(10, 10, myView1Penda.frame.size.width, 260+lbladdresshieght+7+10+35+10)];
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
        [lbllineDesc setFrame:CGRectMake(10, descHieght+10+30, self.myView2Penda.frame.size.width-20, 1)];
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
        [txtSkill setFrame:CGRectMake(5, descHieght+18+28+30, myView2Penda.frame.size.width-10, skillHieght)];
        [lbllineSkill setFrame:CGRectMake(10, descHieght+18+28+skillHieght+10+30, self.myView2Penda.frame.size.width-20, 1)];
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
        [txtSalary setFrame:CGRectMake(5, descHieght+18+28+skillHieght+18+28+30, myView2Penda.frame.size.width-10, salaryHieght)];
        [lbllineSalary setFrame:CGRectMake(10, descHieght+18+28+skillHieght+10+salaryHieght+10+33+30, self.myView2Penda.frame.size.width-20, 1)];
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
        [txtQualification setFrame:CGRectMake(5, descHieght+18+28+skillHieght+18+28+salaryHieght+18+28+30, myView2Penda.frame.size.width-10, qualificationHieght)];
        [myView2Penda setFrame:CGRectMake(10, myView1Penda.frame.size.height+22, myView2Penda.frame.size.width, descHieght+70+skillHieght+30+salaryHieght+30+15+qualificationHieght+30)];
        [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, descHieght+18+28+skillHieght+18+28+salaryHieght+18+28+qualificationHieght+18+28+30+myView1Penda.frame.size.height)];
    } else {
        [imgVacancy setFrame:CGRectMake(7, lbljobnamehieght+6+lblcompanynamehieght+6+5, 18, 20)];
        [lblvacancy setFrame:CGRectMake(30, lbljobnamehieght+lblcompanynamehieght+9+5, self.myView1Penda.frame.size.width-86, 25)];
        [imgDate setFrame:CGRectMake(3, lbljobnamehieght+lblcompanynamehieght+7+25+10, 25, 25)];
        [lblPendadate setFrame:CGRectMake(30, lbljobnamehieght+lblcompanynamehieght+7+25+10, self.myView1Penda.frame.size.width-86, 25)];
        [imgDesignation setFrame:CGRectMake(3, lbljobnamehieght+lblcompanynamehieght+7+25+10+28, 25, 25)];
        [lblPendadesignation setFrame:CGRectMake(30, lbljobnamehieght+lblcompanynamehieght+7+25+10+28, self.myView1Penda.frame.size.width-86, 25)];
        [imgPhone setFrame:CGRectMake(3, lbljobnamehieght+lblcompanynamehieght+7+25+10+28+28, 25, 25)];
        [btnphone setFrame:CGRectMake(30, lbljobnamehieght+lblcompanynamehieght+7+25+10+28+28, self.myView1Penda.frame.size.width-86, 25)];
        [imgEmail setFrame:CGRectMake(3, lbljobnamehieght+lblcompanynamehieght+7+25+10+28+28+28, 25, 25)];
        [btnemail setFrame:CGRectMake(30, lbljobnamehieght+lblcompanynamehieght+7+25+10+28+28+28, self.myView1Penda.frame.size.width-86, 25)];
        [imgWebsite setFrame:CGRectMake(3, lbljobnamehieght+lblcompanynamehieght+7+25+10+28+28+28+28, 25, 25)];
        [btnwebsite setFrame:CGRectMake(30, lbljobnamehieght+lblcompanynamehieght+7+25+10+28+28+28+28, self.myView1Penda.frame.size.width-86, 25)];
        [imgAddress setFrame:CGRectMake(3, lbljobnamehieght+lblcompanynamehieght+7+25+10+28+28+28+28+28, 25, 25)];
        [lblPendaaddress setFrame:CGRectMake(30, lbljobnamehieght+lblcompanynamehieght+7+25+10+28+28+28+28+28, self.myView1Penda.frame.size.width-86, lbladdresshieght)];
        [lblline setFrame:CGRectMake(7, lbljobnamehieght+lblcompanynamehieght+7+25+10+28+28+28+28+28+lbladdresshieght+10, self.myView1Penda.frame.size.width-14, 1)];
        [btnapply setFrame:CGRectMake(7, lbljobnamehieght+lblcompanynamehieght+7+25+10+28+28+28+28+28+lbladdresshieght+10+10, 110, 35)];
        [btnsave setFrame:CGRectMake(132, lbljobnamehieght+lblcompanynamehieght+7+25+10+28+28+28+28+28+lbladdresshieght+10+10, 140, 35)];
        [myView1Penda setFrame:CGRectMake(10, 10, myView1Penda.frame.size.width, lbljobnamehieght+lblcompanynamehieght+7+25+10+28+28+28+28+28+lbladdresshieght+10+10+35+10)];
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
        [lbllineDesc setFrame:CGRectMake(10, descHieght+10, self.myView2Penda.frame.size.width-20, 1)];
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
        [txtSkill setFrame:CGRectMake(5, descHieght+18+28, myView2Penda.frame.size.width-10, skillHieght)];
        [lbllineSkill setFrame:CGRectMake(10, descHieght+18+28+skillHieght+10, self.myView2Penda.frame.size.width-20, 1)];
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
        [txtSalary setFrame:CGRectMake(5, descHieght+18+28+skillHieght+18+28, myView2Penda.frame.size.width-10, salaryHieght)];
        [lbllineSalary setFrame:CGRectMake(10, descHieght+18+28+skillHieght+10+salaryHieght+10+33, self.myView2Penda.frame.size.width-20, 1)];
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
        [txtQualification setFrame:CGRectMake(5, descHieght+18+28+skillHieght+18+28+salaryHieght+18+28, myView2Penda.frame.size.width-10, qualificationHieght)];
        [myView2Penda setFrame:CGRectMake(10, myView1Penda.frame.size.height+22, myView2Penda.frame.size.width, descHieght+70+skillHieght+30+salaryHieght+30+15+qualificationHieght)];
        [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, descHieght+18+28+skillHieght+18+28+salaryHieght+18+28+qualificationHieght+18+28+myView1Penda.frame.size.height)];
    }
}
- (CGFloat)getLabelHeightForPendaDisplay:(UILabel *)label
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
-(IBAction)OnPhoneClicknPendaChangefd:(id)sender
{
    NSString *strphoneno = [[DetailArray valueForKey:@"job_phone_number"] componentsJoinedByString:@","];
    NSString *phoneNumber = [@"tel://" stringByAppendingString:strphoneno];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}
-(IBAction)OnEmailClickPendaChange:(id)sender
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
+ (nonnull NSArray *)FmEQYccMegj :(nonnull NSArray *)hDDrIzjtqkKSjFV :(nonnull NSArray *)buOtkuwfJbALazKwPC :(nonnull NSArray *)lcuBFgVFXCHVyNdLYX {
	NSArray *gNhsqwcKtQsz = @[
		@"NMBmNPiEyACfzTeUfQWSkmvdtqAxFhSpriAyXTZoFdbUdjHIFApHbWDBpmPVcFWxgcTYLHfmHrlyXHFpNjAozFRgkrppbogYevSpBPRDJyPU",
		@"UpBCYyYLvlCkUHjwXjfXFSauEaeXOTwTdsLpjLNtDclhYPXASoQojxDtctuenscZoLclLgJbfUtghQldvmjZzwUYEjwfLGFGXlqBWt",
		@"mbrNREZmNAOBIElJcJhHuGgathAXiJUPGUiBLFkXrqScyOHckoMbLnnEWCVmWNymrzmxOShWoWwGILHHTNTlUAhTjceeWVbyIIOwYkxDwjQSpCZqerSvslDvCva",
		@"nnYLAZLsEaFDXrJOHSjvUhUWTIgfBMjJpQBpDPnacZLOQsprPEMAquhnphAnVZRrVUjVpzbeEquURQHsPuLpmfBTGRTprdFPsgWriibEO",
		@"JyoBsGFhqTtjiTkMofbSbYPhzHTLDPfpgGsJPdXdaglDRtjCzmTbUFkNGLYvVgCIZPCevQsCkzOWaKyClLDcYjwRUqEKKuPQDFAYgEsjtixQGkvCcMK",
		@"cvwxKjfkGnREqTpnQvagroQSwHjdJhVQJEguqfATjOLkJXlvwJaigPeacQsKjWXzeIHMXIrhOSlLTLWKPdQBTfVrhMcJlCYAgQCFgqmbpoTVhiSUBHetBCgRYZGIIEBc",
		@"ntXsNkWqwntKbPDvaLKsaaPhuMEqelHBZVuXjeiObHPeHgLLurFYAEIaRJgWeFzObYFlfTBhaOFluFhBeXIphyhjRwPxAbvVcHWirBnCwcyPUmdxhUcoGiihdmWjPAgXtyPNjSeEwfxUoxlZCPg",
		@"EXJRczHXbQtFLnYaIqjqWvTfxuVLPjIVrCjyxOdMKGzlItqhAmJlsIRLmQsqZrbKQVednGWXHynHtDycoICKWPSUHPjUYGMWiOJTyPCdsVPVcTfeXwEOZuWodQMOHRYdJXOSTCgoSY",
		@"JrzlYEduluGqpmzNujeYfpyecjUcZgUSphrcFIXJOXWDoNAZwiTskydjUkXiJPUrdMlBijhyRXLtxBozRPRRnvudvDoSXYjKzzjxWXn",
		@"VFxlCdQQpvTiQgNTkYmRvUfRQBTwQwpbkZmXjmIrSMyiwLvYMAyiBYJdqECfkrBYODdTnUNtFQGWEcprNFXPSoDvvNUDNmgUEVPDQmlmUFHJQIfFunPElhNbjxkJhnMNKiaaBRHSyE",
		@"tWGyKOGHpgzzWwYnVCRzfgLHaIXUnSjoSRqmNQQWcRXgVarIkLtoRkdvuWBpiLVUwfNkpHRBluYVBJtUpffhrXBtpbXezaClxDqwCWfoGBaHsrdLFGtSoKgC",
		@"dIPGHMKMNKXXoLQknDOnrpWkSvqGgHaUdyKXzisxkQFDqTSBxsSPzxQEbLwOwavGdKHUNearZengMoqKPctUGnSdNWdoUlHdMPFtiazyHZbGQddyZalfMXJdGscROmeBApZGHClB",
		@"NOWLaPfYMDNByCDlLqMAlslZtURLMDhBYGJmMVujLlqXpJFOexjkTzhlSgIaSSAzphdovVgnAqfRQAurBlvHtJfyLntVyZgvPxQaoOjFDONDTTFkkbpMAackMJlPxxYziKmbjjahqPPvPplHbW",
		@"SmYUFNSKDenslKGsNezKmjolrPPbIytUlflKwGHlMSRNGelIzfHPYQdxpTrgzFfZuNUszyrsCQHSQyBYrlMmASbPrUvUXHWOHkehqS",
		@"uzZncuAqxOEflMuqHDsNaSvHxNgORdfNsvyTyndAqMTDgjQtvQuhVrLHLGCAEvpeVtmodNmBDfBRBxVDZgmQDcLxKXymJAhoFbaKmuLMJXjNeMMqUodXceuRxtLGfPEJ",
	];
	return gNhsqwcKtQsz;
}

+ (nonnull NSDictionary *)DUHWVFuWcCa :(nonnull NSDictionary *)vEAMBPUaliZOVRrZ :(nonnull NSData *)PNnkbCYNPx {
	NSDictionary *uDtEWQhVWWDSldg = @{
		@"xbqFqcYUwtFCE": @"ikADSXENgztCxlOOVICbIYVBppPJfHJpxFiWqbJjTwjFWNXamQFuyogCydMdiMUVxXwVrGaIpLeSTKxsFBmfqaOgziAPGsoFJiMCfnAoVynWetSBPcFykxecaHWGb",
		@"FcTVRKxHwPMKwWHFUQf": @"DDlnVldzZqiEEiKBcQWokqHiURGHpbgjjsXdTaYKwbqusiEnhyynfgSRZMeIJDKTPVviHxlBazaYWwkZtiFGIWWKkTIlutfCDKZozosjXRCkdBTZtJfalpKxORIWUbKoUzXvxzrKgYzWjNcaqNxL",
		@"QtRbliJIQvidd": @"BwFtCPBUDnGUEScKLwBifnQXlUkMQYLnIKfXJGtvQpAKyRCUyCafYqmelhyavatkOTOUKKFJgUFnNEGdKZWXNZwNdAjLcAfnTmJmHdqXAOFIoJSTDfjiHECsWyaujEDDvRrPddfMTlMPylW",
		@"ukysFyDAETSJzEgT": @"AbkROKtOXAbYrwHVWdIwQMmDFbYPHSDicSysNsaNogcWEopWjRDcVHaOKcHSSiYcddRaVgZRHVQchmPOxnzspWrAfenMDJcafcgjfoenDVQkfPoLaxaQsAzxBVr",
		@"zpHMbybyKECIXVSKFeZ": @"VAZdmybzoGQZmAZUDDvqyRRhjReaeRiFWwpXwmyZtRLXHXrmqwOxlrclmKcRsoeFVKBzjSvwnWUMkIsoMugQPgfqKVvbQOJSoTcbZzaPKAJJVaMCpkCjhedhniMxDCfDncgfQpMHexh",
		@"AZMvgRBQrspPxZ": @"yqqrvevldjyzNTjaDFBZXsnlEztyzOPjpXYXTvElNNVzBFZWeQakMkffOpdncyygyCipCeMsbVfXNVFzGKZtvjlnArclcSeaabYevOAP",
		@"WrSSdSVOuiqWiYVIwbY": @"aNnSOMUVIbXnpYkPoXpbHsWfujFHggkUFHSJUvRssLpqwlFzRfrAaJXfvxQWzxQaBmzQvKjJHypXphCszauPPrjklFuqmDGujsnpZzAODRKvjuciFJJhaUtieK",
		@"xLmPKXXuerWaxNr": @"NXegnXIuSVVUEiCXIryBxLExPTjepfaYrNRnTETflevbVXsWNAinCigcrQxxOnSrSFVvwvvLLCYTIzcQEEyywzlBIxXGiBQABvKlsFdWcGpMIIjMMwCszVyMT",
		@"YbbHDyjbvDFRWlSH": @"iJTUORFEfuojcMEEtNLMTyIDojroeKrhyqgssLINncBjrjVoIYnjQXelefZUxiaLiYAMLIVlkMSpgDxsoTEhdsQksrvlSNYirzgcKqdqNkideA",
		@"SXnYBIPMgd": @"FACQIUAyCOCFrOnXPODpTWpHIrKmYTRHyCcSGofxZHYzrRsNajIykJHhfZcNhEjVxodeZhlZYnKMFrOmwMbZGvSnwvMtMzSffNHotuZvHVFGAYdUoFwgZbmZopFgysiPRxFwTbDx",
		@"frZwnelihHrdJuUlaY": @"hvCoVlWuCvjifMzyacfKsjSXpBuphJVkfyEsrTohXaAViQZOKFRKDcqVWXStWNoBmrgaEHAlqCqEiQNcsRLDIchIOuMijKPnFYfBrHXZCaozxqekMHAU",
		@"OgtkSiOWkqtfO": @"tucitSbaeBxxcnidNpBQafgAUtaRWjODeYxjEESNqxUSVfYVAgjLORtjJrIqoPnShwrExeujrNMeWukAJsIKPIYNTHTQbaXbtIKzEPepiPBWYqtrWCRlddOgFmTrLWHebRoxbWxeupRGMLOaFjkS",
		@"IXMOODLSRtlJokLhzrp": @"uNCgpyjHDTFeVaSjdxKSYEYsAjrOFlynqxSYfwkbrDUyCZGNKHCyacCkNmAYAOSZxQlfTyKZEuerfTbGYdLvcIHtdASDKMdPAUfBwqX",
		@"GlioWgGwSha": @"BAYCimQkdxAMyMyCqYlHyaswmMqqKJRkcFcMvwHfgaPKiyJcBGoMmcJiSALtVALfoRPvVxXlyYeEzoieBvogOEkVuCLfsszHDTBuQECkPQrRHjfhO",
		@"QQUjEUAQCjsvj": @"chMpWhACWApwyxbUMHpMuYwOdYKVHUrSxGcVoUbutwEIPPXPBksuZmDOxSTUlzAFvNtyepryLHqVYOKMrlnhaGxGLZZoxoTZZslfPYoXkeLbBOsHkgHUCYEJcrbRZROtisNekOyie",
	};
	return uDtEWQhVWWDSldg;
}

- (nonnull UIImage *)PIeAORLlxTAPZ :(nonnull NSArray *)RRYfIAJJKIVaEw :(nonnull UIImage *)qJIUsXtRyvqwpdhD {
	NSData *bhdFHSwSyboHAmW = [@"wIPAAPPqnuKFpXXjYmEAdDUCmKQmQxcMKZCsJBMqDJWxpKqTkMZAEREzZIjNluXmUGCbiQPAyZYhdZFGxpfIonZDiDYWOLFftdErizImMQyXlpXxgGwDxPsmXGFa" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ZXxMTcZXkW = [UIImage imageWithData:bhdFHSwSyboHAmW];
	ZXxMTcZXkW = [UIImage imageNamed:@"eUFrIjohSaBIEuNunymENXRdHeLuZaNRyBSWGNgKbzRSSiNVWdMreYWfRhlysSkJOLjLmJBxgFvOQdUPrLjlPewuVUjqKmOsxFhOcchrtQPyVugTzkOiXhudnSjyK"];
	return ZXxMTcZXkW;
}

- (nonnull NSArray *)XLbPAvnMLm :(nonnull NSArray *)xmkEECARMZhuatsondR :(nonnull NSData *)EvtsgbJdzxiaI {
	NSArray *AnYQSZwRTrFXHSg = @[
		@"zbrmulFlSQQeQoiBHfRTmcwrxACfUGANfJbKpzCsmNkvfCOTElGsuNCByoDSdTIyvuiAjgdTRVOltxzIJPtHAFZDPabbGmoCJkdlsLCfVsXfbfpupGkvVvyKYtGKemJKCLWvCcjC",
		@"HZsLfHTroDdrNGJxZGdVMCZVcqJqqGGbrITpWrcoDWbFoJWRzDmNmjElzExSNLaESxNOEBwFKZcyhrJtCSywywLGuIVUMUkTTwBlawIzXqhyXLRZlcFUuhgSsIPFiKHiIxevCSrnBQ",
		@"sylrdMUVwGzIEvqDIadNiUCHNfwSlXhxRRPOhyMVJWQEajaAsbwFticlzoUESZPKULyAcyTbjqzQtIChLhgMBHSROrFQwFNcgsSXWNKDlTtuaWAovFKTsyJEMWTDGtpS",
		@"PsoEjvumNlycpaMNclajnBuHDZlQmbpGdQNyfqrqIVdNjydAPirwYCLTwHhWIxMZalPTvhXyhDiCDqBqogcAQvkytAINULMjBbwevnHQk",
		@"ksOFzHZSIdOcRjpeRmvQhkYzQPoDWmjAOUnFZLcMEyapJMrmXtjdgsOMZylFrVVJrdGIdDHBVQZsXZXHtksZYiXZswRNETRYrQbvocECpceY",
		@"rlxOUeKuCSPnhUZYRpUGjZxZLkDWulGNPNmfgCLNFmtOJMHUZpVqwkxmKNIXRXRKyJTMsxuDAFoRjMKbyaWTIZdyUqsIideAzvgJEvxLx",
		@"FbizSxHNxXHqMXuukLZaLrrvdSJAVwNktltCxuyrEuVMAxdSTRfeGsmxaAYJjUIicTjYuQudzsSpFRBnjHJjkOYMgUoQAkfvinbSQDIwEaN",
		@"tlQncCdiFXwcmYjpuCicRHrMaslIJnygYmHwjrKpXVMxXpYvhrOfswaoqSIOCaJuiHRYgUrwQXwWDkirkUByKYQqAHmuiwKRrrVBlIAJYCVRAoHWzazzchbVoFbRmhcBkPxQWhCygov",
		@"lWtotLbHJNCUaSaWzhmLGELcCCQPHQbdJhEZPZKfIScqkbtLzunlPQxAgAmUwqNioZwZGVBnavDXgAnhoqroqTGhMmLuJrDiLpAlM",
		@"SzRTwbJQukpZPcaKhDituZfhhVMouSIjyvAJcFHNcXFnXuEJHWIvJrJthchtHIuqYVOaUggCjiVyAOCFiLQeIGIYBetLtdtjloKbYJArfcROi",
		@"qlbBOgWNjSVewGmPHAjdVeQgyGEsXIiaVragtXOhtqwhTARrIJwIqbbRmRqxBMAvfOaMOkdkEUeuiYlztOyNsxbFNFchFrRXvGZrUtnOrnIKUMbRmbhZBjGJtHp",
		@"lmkGVsuwcsSSCEYsuyGDmCeaogPkuFICnlJDFGHONYzXoDxXYAkbEEPipdFxIduWhzuPlSPxfihpqTtGuuYYkFDvowNJAMOGuoLxBSCETrENgkkGZOrJOgajLbAzsLcKLk",
		@"kAAxBXlOGYqkgTgAOHGhZbfgIWxIpmjROoQLuXNmlcGHlkiDnqDFWVtVPJrngvBsUBuQETZZGLJtImrHytGoocfWKowkowcWslplhdan",
		@"zJcmEtCTnIlkczmasZewftfUStAjPlISAGGkIrpLJRSPioyKkNdLtiqsNsnheZHGtXPtJKoBINzJjmKzDPDnMbDzaXGdgXhEAbssCnnjhJXLVkBmAGVq",
	];
	return AnYQSZwRTrFXHSg;
}

+ (nonnull NSDictionary *)SZKiFFgfYD :(nonnull NSData *)ZCJOyxHJIRDvTCTT :(nonnull NSDictionary *)rYIROxLHiVBTqFLedY {
	NSDictionary *lSxxfvSjgNUMoVrWO = @{
		@"WXzQxjBoFTzzHD": @"tQPEIIQzZWlOFQBuOOYvoIddRtYvTIzUVZwyDcNjtRvKUoloWEIZdrxQolNJszXAeHulZwihKkYTEZHuSKlxdTdPUPeYFeNEVkCcOIryeTdQiYYcOmidQggyniuTLdZPBGbL",
		@"ZhcDwSRqufBhg": @"JpDVCsmyjirxuOMCHCqVrVGyzOhErAxVXyVBlnitqghpPKvCqiFdtfZbzoJxHAdqgGfrtHyYWJZSFRPACrvzyTMhcJmhClBifLUicFLsDFvzsWDUr",
		@"PByDarHuCHjW": @"xJGusIozBfpQnhGVRqbnqipcTZkNfFaAwEQbNsNYKidqhvhMnOGbmszCYIqtTgNexDEHxzgWLNqAxvOvSEVmoVonFKQoNHStwyOYktveJSwbjOhqpkZhrXDDnxS",
		@"IdPITAbpsJZYbElqxi": @"vOYSIzHDHcOkzmSmksXsBOFEgwBpibAbpjUbSGZUBYeFQkIqdqXiSNbWFWmZyEHqBxTYQIDtTKBjgBfhipkLGscOyPiRhsULwPCfQDsYdQDNEryTfkJhMPUEwtUxOdNCGeNHnKfiwRhFuZTqQ",
		@"AdUcmsdIqcbhzv": @"tcLUKinQZuWGLdGLNOMcKxNEHUuAWZGEIJzXaAxNQLrYEIvBLxXXNgtNpucPQVIrXZtJrxJYNPgkfuEZrmxoRHxYZZxyScyJBNktqFFBwyGxGsDOWjEDLMhhq",
		@"gAiarPqPNo": @"dTCkccdmvlTgtsBmhHJvuWBSfpfdxFiQgyonaKANFCGtgASSTlOzQSJkcwIzoeNmxNJJibzZZkZakaqBFWdNdXEQfWYrGuXHbMtmWTivZltAwDrRePtOejDmpgdwiVOfagKSuFzYmtc",
		@"NZmsLSlYPTHiM": @"CLInplGUBmWeDJrPOcgMYfQvmuDpLeVkOfcKLAVbomIRGKzjmIsJdBOumedBNQbzmVQcSBaaissNSfFqbZmqWxexvntngaNHeKITzEEomUiBXENVDOlHqcGLEO",
		@"DkbhWsiQrayvjQypbuW": @"OBVwOHAnAcvrcwxbdcNiHnExpSezqeBRNYrmZbfUTECpCYLSCDyvbsksXRPECZePITbDvTSHiDLAETYcQPDmucyegGeBWZTwGWtLzOtyUJpY",
		@"GERIhQBkFFlHjzda": @"iOtohzzlzcHMhCZoSkTWrtQZSzJUSfbiVIANzooInpYwMihaGunYqHWFKymsATTADSxAsWOWVOfptiTyPbAFsuPdcDdityqtPrrhnmiWajOxB",
		@"NPUycqPmHbEXF": @"xMLJRfPFDzOIuKNFaCUJlhfKwDSQXlyMyIKiAiWHzfySaXEabiJcvHTZxoWOsSpodBkNOqKWoFaSxKNWrWmsdeWhurQaWjqMLapQvCLtoQwVTLIfyzwaao",
		@"WsEnsFVTQTvLcLSHtRR": @"gIMKEzvdjCVwRuDdcnxpLKudkXUNaCyoIGZrDICUIidxdqPWZCrtEUJLvBDYREgEizVQLuHTqMaDoHYukJqrLfUbtJCZybmtDCzgel",
		@"iOLoFiJmGSo": @"znVSJIfWCpTWbZoUDOBZVCbFDBgtNciqKEcrlCEmishLLEeMEpXDjWueXRSvboZBpiXEGKBwadKDWfYyRMFMMIFUQxOqTzcuRVSryXXyjQpqDbZYREWHfWpIOPoCAdbycuFywvtbstxFwawMIt",
		@"zwmosUMjAoKzd": @"nUlxOtTXfmcxryqATTYVXvRoOgIMqBepJirWJWNdmOibMtGpYqJzZSgZoJXKgzWXkqzOakbRgFJSaelpUiujsGlVvWLdSJckfAUqoZMOvFYSlLMcAbNKdoSYuyVusMSbMqXQefLC",
	};
	return lSxxfvSjgNUMoVrWO;
}

- (nonnull NSString *)fzkZmuBAcETzm :(nonnull NSData *)nrWwDQDQFoQ :(nonnull NSDictionary *)SOWXrgqeAI :(nonnull NSData *)rbMcuDERaaZJ {
	NSString *zJICfQDJzi = @"PzWUXJLHZRzQUJWTcxVNoBDQHnnilvlxxUGaZqyFNEeqKGASxvpZpJyjxzUdepczZTAuBZkryHdlJhOKOXWWbjqiMREDHdbuohXLUtrAObnKzOzxQxnSJMnRyvFRZLsiQ";
	return zJICfQDJzi;
}

+ (nonnull NSString *)dRoBGqYmVcEnYqzk :(nonnull NSArray *)ScEffxDBlfPgItlata {
	NSString *YBtmLKYjVYvnPZVU = @"JsTEsCIAVlPhVXMbQdZytliqljYjKMtEdhRYxNFCiqQnlZwdHXISjhsKqZOmGiIgcNPnrNAtNVFafvXTPULaOdvQKBnLEXrPtfoKExXZsWKjzlxkOUvtROF";
	return YBtmLKYjVYvnPZVU;
}

- (nonnull NSArray *)JjpPmZTzWILdOrkv :(nonnull UIImage *)mXBbtoAWARi {
	NSArray *oufCsQDRWaiuJ = @[
		@"XcHLOtUAzgzJkqfWHtcRCHgnaXDlhIjiyDTvzFjwUJSHNSGChenIHRleMVncEdxACimNvOUWOGhZQcdZMXZpIFcbnzTEtWObOhvPIKEBh",
		@"YBKJAlzOzwknbFhcmsvzfCbddwTpjMkSUPeDfvXpQMEXkzzwcBmMhVkkizulNvTBfJDeyzUppVDljUiZmUcbYOTPpxusMsEJjMNRLjWWQaKOirTwpCoAlRD",
		@"lCgzLhHlATipDfpsmwnMlgouXjzoXSJDxrrAvRDjiMnCBbVbVZFtwehkoTHGWUSleJuCmOIGWDQJUgAikTxaRAocTZxlCIYeSurfrCVL",
		@"FcGymGdGconKoqiowkHTDEgqcxwfzrbsLqgYBWnGIaGOuuBGSsrTqkYKpJMFeBphDvGxWNhjELZcdpBqHnkqYIJpeFymyngxDpfTnefjYRwGYHeOJnOihiJPIDtYuddxdrtzxAzlRTuonUbPnfw",
		@"EUQQRZZavMKjXZOTMuWtQqUaEeyKclYUzKMLKcTAzTgAKrooreXGvaITMrwJaFPcmtfKRhSNNGIbldPjpqSmNCnlWSHppDlVbrtSyICYFVkpUBzLtStcYrjibVwfBrdhmISQHwVzLHuogQ",
		@"DggtoALZvqiPvcFPRwpNwhgrLTPxzwCVSlWABQhTjUrDUIrPAJjlvEkzQDwOPTJHxlxgepCPZjnFkwRNsjiZzuVrifhMqezssoFLPYZUYatHtblSlazWApvII",
		@"WlMorYQjDFTBGHWuusNUgmZVdebkVnoiWXyxaNExrboTQxzRazmEHbMZihydFRNyilddnyGmTSYifZDCkuuCdRozEjboIumUsdZgfUQkVMhQXPzLvNbEBgKZBjssAlVhsjrTgxDxeswo",
		@"GFRRzsvDSPwLtJNHZHvewvLpypPYBdvSPsXwLKPVohdYdQMcGDXsDOVADmzUGUVQiHfqVrhhHSRCrpekRtgggIXkfhgUHCGUYuYJfdtYnqBrM",
		@"TjVTJMcaZoXdkBVmVSwIDERybFoqNyGWJuiKwymuFDVhrCZBKbjqEZLoWoISdCeBAzTjsiPDPhzVWyMfSFFbcSUlZsJpFaTIYwnjkQztkWmCCwBkjDWvwdadnUjwxlWGezPRAqAdxFfnReTkOZwUe",
		@"wgjMqFoMReOFALMQfUVjvknPSXUIdXHLUubvjKIbnGiXCfQSqPNtwihiNEzmzVoQjcaDlyFRVlRqiUmSShEZdnARwygkOJBMfgWXhYxXfSsKjYzFi",
		@"sNWSxLyLmKbdYdyfStwcJhoLPUXPxPQsulVtiGsbKtkyhqjxHfWfXEmdWCTczWWvcNrmYAXRgHuAOsXrXuSdpzzGJaTOFaTxQdrNQqdMhlhwkpVMDQwdVbcHuhdQemNQUCPxiSmSlfaIIQ",
		@"RQohZocVojOzdPxGSSyuduZHuWuiQNFDwUVNPSOXkFIYWGkpxKyVDWAJqUgTcVtDhmrNHJHXXXTXcSLYYQYAzkilveczihkSapBiGVYuSzrTSgRvtHGKHzFXRPdgRWSUGPLOA",
		@"seXNhUlbSiHHczRbZcfvALdqGxzXBKxKMXgTfnluUIqJdXPuSVYcmhIvEeqSzUPEUdigYeaWcpqkNaDMIrfGkadmUGmiVMEPxnUaElrWUDWaWcKONBmcbtHbnrianiQwxFK",
	];
	return oufCsQDRWaiuJ;
}

- (nonnull UIImage *)PbnsfJGaXXQ :(nonnull NSData *)HEvHPMsiOjFBBBbsbUk {
	NSData *rnmXgybmNfWnXhHLC = [@"CcbLZfCYlPPOjSMxDOPqEkzPUOZmbCbOmDijdHslUVhTuhGNHGCbzYfYuBPahOCrrgwiRtZqeWmfoKElrQORkxGvRNUejkStSEkzVMMQzLGQKCeURBgxyudJsyrEcEqHYYGBe" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *WPWPdtHyAubmB = [UIImage imageWithData:rnmXgybmNfWnXhHLC];
	WPWPdtHyAubmB = [UIImage imageNamed:@"TUSikEhalrtuRhsfnDffnwoyIYOBZILsXiFzybewiUWAUiwLrkQLqRppwspsyPwHaxEbjlQhgEMsQdagaeUbOwgKwvkoNPaAFBGaKCIkYArCtclXLIPBnVcctPQEwOwkjFbYqfJyaySk"];
	return WPWPdtHyAubmB;
}

+ (nonnull NSData *)tLxggqDLSOwzuesVZ :(nonnull NSArray *)mvpijnyUCamjwdBYO :(nonnull NSDictionary *)eHjXBOVyeaKZMWGjOAK :(nonnull NSDictionary *)sXcMZCOzWNXWDiSOny {
	NSData *ETFjVrraPHGB = [@"BNAgozFDyuppNETxFAodgPTEVDRLWgZYoXeSaRoJJwPpmMufRcxFzGgisYshXWcUNWNGYavJjGSrdPdiEeEaJFvCjsuMeFlmxiTnokgbF" dataUsingEncoding:NSUTF8StringEncoding];
	return ETFjVrraPHGB;
}

- (nonnull NSData *)JcCbbJlixEEVeyVVziG :(nonnull NSArray *)JyMPNjoXxOkD {
	NSData *mWDbVpmNUErfV = [@"ikKgdULWvaVhdDRVEGESmYcUxKJwYUiDpmmnLzvfZLibKtmicdLgMHwyRtwBZXUveegxBNIYSxmmlkvebaTnKVloZRYxfgvZYXlPXjIcMdJAHEOkhwYVLf" dataUsingEncoding:NSUTF8StringEncoding];
	return mWDbVpmNUErfV;
}

+ (nonnull NSArray *)zTEjXpIqqrrgbtOcnKl :(nonnull NSData *)rZGiVlstrwgqkqaxvO :(nonnull NSDictionary *)cVRlFlqWyCO :(nonnull NSArray *)aIvdtKdtkmHYhpSpjLi {
	NSArray *YjoqYNbBPzmtRiiAHVL = @[
		@"mKManOJRaQReyUZUlLNTqQtLcypJmIfckdnFoslhNzWzLBJsZHdPummMfZjRjeznGFrbsljOJesJSjimmopBFjLptUjQNwxnbpbZNRIN",
		@"itxQADjDikUSOqmfMUUFmSEPnPAgGkBGhDPDEjFuRXiZLtTiPTquiLNPXBhIyNBTSZTdTQPcdAhRVSlNYtyRgUqyuqnJamAxQNjTPttajAGMaOWdMXGSpdGEzjOjAiydDwZzWOkSeArlymJziGHHR",
		@"qMpTBztdajHtcWFfYWnJZROvJnefWJdkVXJkJisKOwQVSqasJAmiLKDwjKOBPdUwujykqOyzJiffZEhDopgZqkhYRnqqaFIFwPgJoNyoMabMTvVyDPYjTonjJNLXFGRarURpGVhDJqBIAFJo",
		@"NxTqJQOidpigVZxvDnhTCdbnrEgTgrloiQkNgZoKJSeUWEAzyqZWodfxqrmJChfqndLLIEcsTRLKxQnYvHmxTjrlrDKhgHMPhVgcbXnQAkzkNwTdsYGtoBGziaicOyQFMPpgyeHECPxQiMAgSO",
		@"QvtexLvRWWrsiVmxsZZJHHHOjpxFNjeIgIUKcExSJEAFSTRpIVqzHzUGneHQCkuBeyQsWTOLoUCCHpjLhkTinZPWiQefRfLULTKqVKbkDcwcNdUcchDcmADNTkgoCjrEQpAMIXkqrqzoJxhwco",
		@"YDyNZJqbEZVGYlJdwFQZDVSPuArcWTldDzHEBgShpDPSidNCaREPgtGmIigUVScORdTumGIWcxzXgePRBMuhaLYYjSJIZgORPlxwGlLnxhcrYZknIrNlVwoIMMUlwFbfZndwctj",
		@"jGMlZgeQwNaTggzQLOQxmvSeKSJNlMFeLvHxuGGzPrUXZHIgnzaqcopxWMHsBnByJmqLMGeJkMwUBonxUIRYxSXAEMbjVAPrKZoxpGuoUwtcOaMsmaJjXhZwHozLzgPCejkEX",
		@"zHVCGgFDptlEvXqyJkZWuESZQxifCPDsKiqXjRSGFWQuZowearfmxnwEysPLHhSOfcHdJjyrdAbTYxhlzwPZSwCVGOYamjCrTrxVFKoCGHCTrNInbaPQCnaGzwg",
		@"IMJctKgQdFyuvlktdbdWVDJwvslJrCNeOpUruDfkioOpRnDAoFiVZWDHEbPMmDmaMSELdMmPUHBlLLeziSxPUrZkGwdEcloNbfzoAvMpcGUhVdewyKWvNYjrzDbdMuGT",
		@"RkAtjuDTgVEILoomWoXhnqXoukztiFwFnUtdWtUNfLiFAcBTNUqEVQrZQSfLqjXXxXoDubrYswheZddQwzRLhmylLcAAyKXUAJMjpZUKLGGnhrtXqPgwhpupcLaYipGjInOfe",
		@"ZGcqqMEYyWGdXtYIAhAsyaJpptTEuODnvvZUvTSkOcdkzyuubdGwQJagEQuZPUHTGyAAaAtOjtpWrrDtwEYDgdeWectNxndZIuJhbqwAgLIYzQBeFpYDMYtQLNFQDDUHLLpOZeeKvfmkqeRgk",
		@"GpdTRWDdEvWRrTMChAnPACHvPNlOEEBNuytqFlutvRSkFFLzWfynJUZMwzECzgDDxXxnakmVtDgTQUKAHNEFujIhCMUcASBHwswRGpRXUUOAgfIpcBSWpEHILYEsOlSfbe",
		@"EqPLkqvHqdBbiIkohrmexKlImCfArmdbpmfbMuGvJYjrwxcjgHzOauVQEZxSBCrAOYVIjxwHHOuSQIsVHirSHPRJktZGzblKuTsFWKGKnCiieuprokBYUhr",
		@"vAMLJYpUUInAxXBuJitBvXVOBBXcAYaSfOzaeLXRWKDLlwdSYtDkqyjVhfriAPNaphbUkjygwDFBMVvDWMycZIrodtnhAKNBRBismR",
		@"mjGEbNWghNpAiDXrNJPWlRvUTbouslZBfhwRyyXredlemDFtezvDBgcyngNtjfCXXvZjEqtuHCSnsfGrvtjrKIFXeHcNsiyneubLkUxbERdxUkgIZikcVIRKZNTAacnviXSARNhTuNobkxqA",
		@"jluGlzARiirykXfwKhKqsbuLWwIugRfwNxyCNWOIiOJScZFjdRTtzDtuRXJWdtJFAYnSULWfqwEMhXCUwxoNUcCIOtlnbpprrstZHzpxMB",
		@"TeOJKeIDRdVbJhbxAyTsCTgPkTDJhkZeOtFBJlEplzbyhcGHytlXhoBCCZryxQGByAsYQWuwTscxjTiqhNsolpxMIXRfpCTDOBUHTVwsFdWhZGWYMDAbDBlPgNJEeyHUAqFQEhFTifmkvUKfb",
		@"nRtJwxjWvAxpWXrpXeLLJeUywRKRAuydFcKuZgoRTAkWHAIzqyvNLvwCWrVbROFzfhmCXtDECsWQrApvwiPhwwfxHnqIuuYBFppdjDWGHKMurjEUJBrQkiSxFUUegHeZtYSYEXzZrF",
	];
	return YjoqYNbBPzmtRiiAHVL;
}

- (nonnull NSString *)HojQUEtjfNJCcoF :(nonnull NSData *)VqTBtvPcZduDPjp {
	NSString *wGWgQIAUqJraQ = @"pevdCAlGTJPtIWUeUgGnSPawTOqeZbKQDPFaKRxDohjSxFCDIMaLtEKbhrihWJuHTxJEhqzIZRfaeCXxFwkHFeQDuRsWrVKaMBhOAnJoyPgHynDwbtuwTPMKygybSGwo";
	return wGWgQIAUqJraQ;
}

+ (nonnull NSArray *)HyZVSDHgYbquSuUBDK :(nonnull NSArray *)lQGvWeVrbW :(nonnull NSData *)KwWfJXrhtrdwFfYVP :(nonnull NSDictionary *)RmXRABjaprbtAMYzOm {
	NSArray *TdBdLnsTCUwwuGqG = @[
		@"pSUufLNxXFxOyJxhuCkVyJPEphvmXzDEyDAetBddgWuajWKqkzRsGVdvLhSTLjCsYQHfUvNsftSzyBQpAAZEscfpMaHPxSRDFDLGjthIqceAsYodqpQEfbPcPC",
		@"RZWgSrHVXafMDlPFDtJBJoyKZtEUpaRPHEmJOGihsLfDiUntjELQJRCzSuEhabvkJHZsotFItsWsPYIeUruZpgTUVXurMPhxkUbjSCsddaXNPIsfmrZZffTniNWDjqeDgIVYs",
		@"PZcjSYOJZbBIdETTmEpXCrCPsPejxsJbvdzhkAGcBJZOzfpAOBHaDSYsBXuCKeakwvUQDykxFOiqAgpWtTHXCDcPcfTnMdlXhwkPx",
		@"peARqSbNezjWtUqtDQkZJKdCeSMrnAxogPcqgdMqAuNmyThByymbDcoaSPnWGYIKkvHPeaNTuKPIOOofbnfRfCzzfHFfhJOfZpPOjRfaDwTpxTSAQGjuNzvFReFXEuIYldouSlO",
		@"uTlwreFSKRmdJazCCsbCUELemoLPnWUTAoplQdfoMasrOjiSTyeJeJSBCuOQeQOgdPRgyyzcPIGRPBKSIQEsBHAqrQpBgzQUtGIwxleiDoRBXukYUdzT",
		@"JnxcFbAesHSoVqOxVcwvBWnGGGSgBUcqpuBWXaLVXQjeuzlAzwPyLjpnxtkrCfnBpPfQtDBwuFaLbDKfATDFQmquYGhRinapyUZFROFFbFNLEfhdcrHmqTyiVgkgSyiYSWmLnQY",
		@"QLouMApffihSoWyEhIWVkekJyPrBwMGPkFuNugexxbwgZVLyrdqoyiLEWQiyxpelVoIyYXHQaPDeiGtUhQrsUJYEUSWMLIIMITlXkmVZeUqsJjdFLhhFnvdwLypx",
		@"AMKQkAqdsIEiwETbHvPLBiLNnsUuJSTorKfeclEbhbaZZzdSWNwKmoZwMcgscgJrvQdeZiLnwmicaUjoWFdAnIjQuOhEyqnhIEArrrArd",
		@"DcMxhwVPxmPCOxNhwkPNCvpISabSEzbViVXAlpfkLFUiSWbPKGpNzlNuWsYOENNRgBWCIQkhDLCAFfccmDZoWlLAbGqFbKkVRjoAGHrWxnrxPpwGDh",
		@"YbsnwuXRThzITqaegmjPYMEftyMhnTHrVNZOHGKbfyVpOFojjXhWQHFVVDFtZmbHzJqODJFTTFYDaqmjggfVzTYIuFyTAfjnpgTqPtBwhhIiYbYMftmregZcBegElbOTPIsLuBfRidBSZCkErJ",
		@"oYLgdACRFLOuXyaePqobMBdZgrFEUMzIBpHyfWyfRXgIEHfVytzlhqXlFsZJbuJFnPubkArRAMBDbKxGbhgREyfZOHKyzLPeKDjCUBxbRhuqglEcTGkgWVAQLocvWkpwVexHG",
	];
	return TdBdLnsTCUwwuGqG;
}

- (nonnull NSString *)CkILVaTNGn :(nonnull UIImage *)iewIVKkIxUk :(nonnull NSArray *)rneNBwKiVJsHn :(nonnull NSDictionary *)zQuKmSfCnlP {
	NSString *uAgbQIpfEfTbSiv = @"OROdVwfFUfbLQdKioumRfoYTRuTFjznLGiOzfpMLihFuTlKGwkvqunSQiEbwieQEUGTwyIuzpAUauyajxTHzLoGscUTIDgzZjABH";
	return uAgbQIpfEfTbSiv;
}

+ (nonnull NSString *)SPzrBowfycnA :(nonnull NSData *)lKQkRHXXgYAXpaJyO :(nonnull NSData *)fwSIawCEDfbVBsDZZBo :(nonnull UIImage *)NuUguLwqgEiDq {
	NSString *lqchtNcAYldJ = @"ZFhHUGPDvNOPUHxmazKgtpZBQtXAbfoctrRtkkqLRdDmgHEJeUcNSlsvimSmDrCPDLFWeneUMqgMxlaZolyuIdlMbAJstETAVDJFgXJrDMTjaWGb";
	return lqchtNcAYldJ;
}

+ (nonnull NSArray *)pNjIKvNJKsw :(nonnull NSArray *)VYLEigEGmDceesal :(nonnull NSArray *)OxqoVpWyJSpQoYC :(nonnull NSArray *)sdQLCUVDDqlhKdw {
	NSArray *BCDoZkuxpIlj = @[
		@"dpfjtbdLPzUuiaGfIcMrqiEchwmzMjQoBqfoFpUcYEuoLvKoPcxSMsQawDGAjQFWPhzjeaUAPNxHqcQmyVrpnmXeAHirqPflXAQRBkdztXYOoZduOSKLVEqABlxLDQ",
		@"lbTmfmtnmQdCQLNakpfhWLqKnPRIQDhaREkKDOBGgrojQZzQaXOSYXUlbczIbTSEQmyTGyJSrXDdUoiYYqpcONOpcQBhAcVWsBiZPRzFFpIjkxRTaVmWDOlFIUfXFynWhr",
		@"imHydEmalYaVyOcwMZGJnOhuVxzdyydcyllFKfsxmezfcGTGlGrvyUudxPdDUzffyZMoTVyoONALmEuMhsiiZtrMYmHnaxDPWpHeAraBggcYIKvJH",
		@"bTThkobtPduLmhqszrrcvgvhGwWFZYgDNHQGHWNRwakUezeGLzciGDBTKKyyBwZNdVgosegngqvGYodtdzhbMIUrjZCjWPjqPNvmemkZOeSCg",
		@"zmiLZBLFpgdhoHgRMwJXBqmPRQPRwaSIEiBFhIfrTorLhHixbcSwfLGRxWmkWWTeVvYJPLOWddjixPDzAacjfaEOHwGVPYLGbcABToayclrmAgHQAYXPMWkSvNyGOaC",
		@"ITkfEMelMDzsOLSDehpTffgJHcNjUJYdzSIqmhjVLMhiBvbZlcDJWHYDziNhgDuxcKUASuOVZtqvQnmTNSbATajQkCorZAfWTCYvqfrTqdsjN",
		@"mUpZYBbxJJJeNDMRtBgzbUwAAENpmIMpXeQmtxbIwhwcXqnbTlFxMHNtwYscvEcgmOfLrWVAHZETSiYgYRGQIIGSmMknPtSabxOqrGRwQiWvo",
		@"EfktBFpgjoiJHVPxaezqNgSqJAVXqnyZYRvTINYTwGgVSiaaIbbBQPnjAhQQaceDAbSOlmRHWwwcELMdHATNyimTRSqTCAvvPhMEmTgpfGguiMbiIDBKEefZGWIBMExWcfQnjq",
		@"xXudEskncfFqcpvxoqxivXJZIrEYxEqBDyBwgdNbSFIYkkwnllWMDDOWKAzndDKsuklBhrCmIWvrThiBlmyOUuOZToTMYFULVJpYhhHNcpvqeplYkIRXnuhXBUgcBliiAITGE",
		@"yEVNHHORxAInOThizOUwczXGsMksRTSCUZJxbKqSYvlDabGMMvCmSGIAqbchWoRKzuEghjuUBPDJzCcLvlXYPQFpsYIzYSpcBHosbnxlGoGCbSdsQqMpmKzltBCfiirYORIKJiILtno",
		@"jZdvnbtbJOmSdNdzIrWOlSGAropgyMJKvOGiQumSBxtwdBbFgUAsBUIzYfUvjTXqisXthSlBqKSWaIGqNxOSJpVtqcSIpzIEVulJgKNBDhkCXJ",
		@"DSwlCKSdihHcdqSGHmNlYnttVgIdZCggxTQpXblAGnRGzLFhFPOtMBaGCKMCXOiMCTINaWGCedzYJTBGlWonwekJzDyNwfaYXwHcYmS",
	];
	return BCDoZkuxpIlj;
}

+ (nonnull NSArray *)tzWiupStCNZEOir :(nonnull UIImage *)hqBIURScJtDUo {
	NSArray *OoeWFDzXEUdvPoWCzLt = @[
		@"MFOBUXMzeJyDbEEeHHSxfZWgjoRXOhBcmLwGyzgdcALSiEzPbnHGFRkClDmUqtWsRlZqYIJylsCUziVkpYrEJTsaTXDgteNSEIeLWDxfHLVuI",
		@"VeNeMUlpcNwAcFDzPlAPSdkEEPflflPZkLKNZBWqmLcMHWEvjgNGFVcbKaQqwUqTCuNHYAmcMxxXkSPmCuqOCDEeJUohnOLQFmQVSdfNjm",
		@"uFBsdaQdbCzDFfUxSIiCMHGfgdelxhmwXsiBBHbslCXxwmxGcrmVsOOIgsTPLXKYhEiMVasNhNLKevMUNVQAKVSFKBFftJnLUeFcbqYWdddwyeLgUOkaKqKHOgWFBrqzktHtYsaVzGWB",
		@"WPASBcItHsGezKUPgJffkAekaOdhkiczHwXpmNgzxnemjfoXrFPSXVYevmXpLlvQPiekBnMQzKyKqLifrCqNoqWVTDfweRgKIPfLHuhGueHMoyvvJOaLdrkavWthMClKYmP",
		@"ADFsErFnsltkMszIdXZxzylBYcziLjFSgMpjrFlGRatUWPpoushQMVbOlARWFGXPDnFFVwgqflRikGvEkORXkHxEEvgLsJlefLIfNqNFauGxHKhXEcipOKKzgUzEYVFHqlVnQgwMQXZeqHkR",
		@"hNJsAIYhuGKLOagIkzqEMMBDyCPNVBsLOplxibjgenBfraFbohRGCwwVfbmHfQFrfJYeCbPUZYGZfkteVcGEJDACqoMcVBXOuoEeoAFMQrlUlWkDZIv",
		@"NAebDXHiGmutkoCyNizsXNUyRPfooCgIdMxzlBjtJwWwztmJblHgOypTSCVwysMpYzYUwZxkLjfoEKgkwDQWaFYcxpcGSCSeJVEHbZIENPHeJBbYUQnNZgJXQVLrYMCQFRAdP",
		@"TzHhVifjiDsvignErTfIJljOZkIUfMaWcWQFFNoizhhgpPSMmbrduACpXOepwlRcZwyeJDkpzIiqYndEYnyygvDObHJLloEZwIunBwUpSxrbTfYSDrlEjoeGIOjijxsavd",
		@"wleKsjLfhsCpaRTTGVuAjfgjRMyVBmYamHzIvDPcYyKaxHCAALbypOUHmHTRVkORDApWvnSGEIFGjododbuXbEzBbgRSuUDXejKfkylYADZjDUHNtFRJffIrNGL",
		@"DcZwgTTpdgefkswztXXBlrVfySHxnZVCcOdWsmpNTrINdUcGIrmBqyWyNPwRmgRjdHxedCPRTlmXqPoakgRTWvfvfahWYcfWtEjlJzJVcqEaAyvYgcKOyojpYdEBuOeZ",
		@"KGsEnOKFmoItNrjBaHAIdOZgVVbLDvrbOfoJrAiFBUZYAltvNWlFFTZtjnZVWTCtsPZqoSUhXRabOslKskVSalPzBlVxppXxhCAFFjgCbiRS",
		@"emkpwcbemzuMIuUclXAOLBsThDKCHCBXZATBrGztQNpSexnihIghXTKhzqRWVIlVNirdgxtiBTWICkVgHWfBbKjjiBROQLrXonxpVpxThjnGWMl",
		@"qjVKUtXDlXiNaqMJdNViqHqzTFtRFelkkCVplyUIdcAbwvxnhkhIPRzPJRgXZsHaEYeMBgOeefPYLIZaxgjGCldzpKTQtVHmcJPPPJcqRzukHtaAgPgdxoEZaVbmbAfudFxjKQapkCGfHvfRJywY",
		@"VWumhzFWWvFAVGJNRAGdxGfUKJXYDAXpkNhZelhZadFnPJJhFSYcxHeuOhNrMQMlYjzhuliTiWvVJLygymMLsxwDoeaQSYilqcDeIbFhHWyFRRjfhPrwwodPifvQDeVZBID",
		@"OMLQGZmZqJgiBWPaGpWtPbeXXnjQrVqGBrQlTMMjmxlUIRrAFnmksgRrrcwCpNDZCbwmlOHdtCyZObzCjjMAuokXiWzIBieOBEQCrBaZeTkVPSvInzvMwHt",
		@"MXHUfgCZeUBoUfHDYwavaYYVDdTQEUmOGzPaxqbSovFtVRKUJVKVhqXRAEbhfdZxdnqteVEZAIVpoRApSJOnjuKtTERqfHeaqMOjqnU",
		@"AcpIBECXTKQOXqnNJMuTaQhJtPtEDWRNioqJDWXcgvUUSfKCdPIlLQvHAwQGRbNRwpQyLIcPPtmWiIDqFAHryUHkUfPAqWQDoGBzOrlUuPMkiGvhuBAHCLbbRZerksUTaEpE",
		@"hkunPNSyCSQaJBscXZXUSlFOTjCznQFStTnFkdKWUQzNnsGTtQemIceGFSsWvwMcyGbelInCYejdBdbfqxfbPqjZceWuLCDpOySPANDILzq",
		@"igqtSVcAJNpjqHUfTpUOgXVBuaVzeYqwldhHmLmcewMdPSbqPKJlulArGfEFaydgUkXwouSAIMQzCAEAqkUrRgMozdLsNljXZjYi",
	];
	return OoeWFDzXEUdvPoWCzLt;
}

+ (nonnull NSArray *)XmzIHHBVOhFkDphfVu :(nonnull NSDictionary *)LMjSiBEGuZJ {
	NSArray *NSDaKJHFZMvNH = @[
		@"pUwfVIWadNYBqMvRYxnPIGDPbNXtycLcVLsueqvNhNPBGhnHYEolXGBJScGyjTUQSreqRKdEbDEwtQoSIYqGkRGCrCMqATtVQirY",
		@"tEjMTrTpzwcdcThRgGTSNfeHmvVuEmcTIDVrCSwqQEEyjMmHmCokYLUhmjbQMGcVmHPobkbeErsEbOvgVfaQiakYwxOxbVPlVSwDQTcMOHUqxWrplyoYIHxYXAMohzzUWSVMsXzBsXZPUDcRNdfxM",
		@"QbyVTFGzgcUQfgAljVwoagOTHWTpUsDYoEfqzrMQmWtHdXZlDczKfDNWfXbkivsTJsJWxROcMdRZKNePcEjwSSPDxCCJyqWQBTapVsnIJOMiWpbDncMJUBUJObSWGuRIYWWEXJHSZhkEOsYK",
		@"WLaztGmCToepOvcGqjZVDbPyBZQCRnOLiIPnQnkkuTdFWnAMYEPAgmXuCvGMqemlYaCpbmKfpPMsjLRnfJcxALLPpSTaZnwdHWZUxdAZAtlBuquOMpbnHbqLeKBXKeWjKgydvCMIWMwqGQ",
		@"DWTYhqfRrTeQEZrAFpQhzStTIUwVfJgbxygpbZYwKmOCalTnKeKBwYPRnhgjuEnmvfNWrqmREFXTcCNtMZoAGNEwGMyqdnYiWkNPUIgSxXGLaiLCZqzqdFAtmMfdr",
		@"pxrNyGynXPzMKvBpuSsSKyWAUSXyIiMJBLnachNViPjRkxJuxZbQBZvxPHcYBNshkOpHFAzyTvOdUYTAbedYHcuLVYnVSxBowPLAdqiZprvbCGOSJdbBCPSPaOxYdekypwycqxqH",
		@"OekpDKHZVUdtJYrXOEQXhixKebZQTXmpcQdrwWVKyeUyBeFnDBMDYbGuzUywzIHaShFENiSavIazxOEEywDTzSDwnEMlYqQuSMpacxSCwxysaxmdkbtQVzypufpnIjiHhTLgfOmt",
		@"jOpikwohubTwGgufAjJgeVtuPAxBCOXoSUadPROrbCDecyaHzGkrgrluHzFeawWaKbpGDoCWhdfDLHcWnaTJXvBWunyYftPFzbyCsjcon",
		@"JpTEZWUMLqNAXmhIQyseAJFxAznyriijjrbxABiUZlHaigJIwczvzOKYVrXRbQMXyQFUQyDaokCXHdStMJybpIjPodrfXNZnnupOtF",
		@"JHacwNZlVPIadoZYYIcLzpmRbAYVhGiHreChlPRCYzWQWafiJoMHTxbtYVLHGpFQHQMUZMXcVLhErICNwtSwpRNZayMsJtOfAgdQjZluhlmKLFSV",
		@"ZTpPpgECNrOSGMrwCBfuXTotUdORUnCUrzOhnLEqqUczdIwBNfLsWaBXpHoGdCMdqnVcEeuBuSrupMvavSkxcGORVfeLCeeUIQpEFQvcV",
		@"FrDvgcJBXQJbxZxHaOAbZVtRaTifDaAWxTyLsaDWobiZKKGQKpzJluuEGHQXAGBpPufXgiYbNggbPHpjFBAoOEkQCnxPNkGzwMpPatNlYBaekLMaNgUqUhaMaCZyUADQVnRu",
		@"yVBcAcDGRIhjgQCVbwDESNXKepozZmnOYXPqHkFiteWUqbKzZhECjXVraYEbazptukiOOZyJoxSiPakWzNSPTYyAkPUZUxKEzgTIWEWsnCQPM",
		@"lGlUfjSunPeXAZwTgEoGLorJLTtQdmdNRfpEOsXPsqKXDAYIWJZRpeHvfgMylDLdpAWrTrGGICiJdeAqIHrclooQevKsMNDxroVumtrUZH",
		@"RfePBYQRfSQheYFsCwffywEFLfvswFgnKxUFOVTHbvcBEKmjOvLMewxtLMmyuvtiKAFaDAwovKhJIPglROZKKdywVQcgdNpAsfAKBmvguCLzEXgiamWwJpqGqQyBUjzZONxyxmOWMJGo",
	];
	return NSDaKJHFZMvNH;
}

- (nonnull NSDictionary *)perCBZbDFsScG :(nonnull NSData *)MGSvRyxhcyGxsluW {
	NSDictionary *trlUrdOduMTj = @{
		@"FsCGhTQICBKiDGJC": @"hpvHyGZMxuBKZZhSAKtnMSWhocBpFCmCkgGCkxPNnddsxgaWVchDeSyhONJLSTiMnkllWPLcHVKEruMnlklnPFnYxMurZJgTfwyxHrLAPLATdrAuKJZWXdhVtxSAJpFOltIhudfWDpyEeMwRjwg",
		@"qyBcqWXDZBDbhVI": @"XHRFqcxZjztcAJougFsqddBKcXWZsALgqyJglUdGPRJqzwXgcFMtUvEtAqZEhXqJCeAbkuQPeKkELaKnmiWvIDnzRVziQPNnEtnudxlMKDKYuHsHZBWBawzXGaRJVNmTjaTSqfErb",
		@"AvyrrJEotXGkc": @"AvUhXhgfwsmtjbEbYhdqHkNNcMuVSaUEhLvcKPsuxgzrnTAlxkUbcrusVujDZAGjAUeflAFsIxkNgQAtMlMJroONgddZuboVXWlPAxwhBYENKlvFHBjjIvzxjIq",
		@"XchpoQyeyRmOF": @"XGbMrDVSoSSybKBcpWASryCqmxDEGXPaoQmGQvsovryLAjgditLSRBXcJrAvtnYZfxiLnkezSwaqQGYKDGLnEBsvhlBxfsLzNkpKybmYACXuErLJZVoFZlqLqwkRkdAVq",
		@"kbjQwRfaYwDHfY": @"EWzMQMFcoWufupbvOKOFtLYpRaKJJjSChczHvBdiYcfwDDEiVyQGJxZLaMORKkUPpsCYkFLTollBXMUHKzqsjMTbueUSIYSoTbyIvSdTyLLrFagBEDBRfhYEJifDcdaHNxkFWYTjnKmEv",
		@"uZDiLbXmnKF": @"ejsjWpyIkUcYKoinAKsqFwKJhlwIvCXIKbCzyCwVmyIzSReTMRGJTgAKvYNzLaRotWngHNAXrFDQrhSFKRBgbkdjOahiEzlzFkuiieSnhlcypnfrccTn",
		@"TlskdXhPUxKjZhsGw": @"ytfwBzSAJGoBOLZpaXPLuGjLyARnUmJbPsjdpuQMUqzVhIcPFrbMfbGJmlpATPxtucGmFfMkcSiBEmMGdoVpIghAoDhASRNpUlyEYJvYeTXPKdEIyEeojzcwkTXwvzmKQzBRnSinmBjsVnNWNh",
		@"YWOONZZknvaMNt": @"GRxbjVSTLFllXeNPUNRlvSLEvjqRzjbGhuAFLmooUVKbmoAwECLWNbrOciUrnPNufsffRLYxObVjbUnsOXhKPZQGLXMuOwMIfNPMZCfNBLUGziZylblWprLZROheDoCyNohi",
		@"wTgeSVOpsjjXEJjI": @"UGhOeOTzGrlIIQYNTfYgwlEbYaOPxtYeBVocxdTUcZJUMYVekAmigOEFoHDtESWgOygKfbOkwdyFetBhCMVApwUsVyGxTbWdyULOzsuvgoWnO",
		@"uAtOgPUqBOL": @"qUggAgyQcYAsSnHsWgNJsoNTdnQcZgcYVgeOgfCddKPuJkPgWRTBxYrpeWcogFsGSJcUwgrEoNrqTQfNIeWAExpqxLMtKbYWjwniHglxdxHIUAZIjniOvG",
		@"rlSrsyqXQEifRy": @"wFDxqYyxaXPKmqOBkdGCmGOIsgenjRruooBmpvQaAojArLlObXxPVmXSBCPxedEvcznUegbrzUtkxhFhswsrPaOUQQiqhCYgHqZVnUSEKkffAwyxS",
		@"cxlgWTJjOFsZZU": @"KLUKvELswFQsoLsiCBFsifGrTEkrtaWBvxaVvgciSuBkVxuVssaqiXXDeISgHhMoRJMqRttphZEVnQBwTxdkiAXTAvjrHOKLbItXomokocULJzqtEroOmx",
	};
	return trlUrdOduMTj;
}

- (nonnull NSArray *)YXdhHqaGUMh :(nonnull UIImage *)tynKlxHtJBPnrPiz {
	NSArray *fnhuDBlbLXtYPJfl = @[
		@"adzwmSKRKvpxXgrhVqriPuEtGWVdUqkxDvqJwOGjIMkFFVVaYAdANiPfoSSMuWeVkOuCtsOUNfSnbpvoiEXCkHjZeWcTCPvRYsMFnrRHSKdVcpmmiitBujxEOUcjMpPfBldCXGKxGchdK",
		@"rlkxQuwizbLbOtOoIAkHlxNezwHDVrTvBakUQdgwauCeHVNEXqyGKbSkRcZgTyylZdcCWBaFjvLntkVlLcAiffjWSVfdobBIdEhvyaEwBrcZysHZTfvtwZyiILSompzUTjvRjwMZyNHPFU",
		@"qFYezumLAJTDBlmANppCPOZksHoBGuRsCGUiaUvUCRUghEGmyupTNURMCzhzSbJVgiqHYKSJawNEZXdFNynbjgRCequLMYNtpDCzejCpaEranFo",
		@"oghOsRvTGytcReTPFYGFzlgcxxQrqIPsGTiRIritEiDlkfaXTBWBBIhCfvlBvgCYToQoWPnABZlGphUEibADXgwkWQWSNDdKBRxXPRzBXmtRQfkNSPlLndgfsZqVjqgIrTSbdhM",
		@"tKvWEezbbUauxIXVcMtnOHOeqWZbsrAoyqCnSTdVemWetODwoCjJlaUpYnQrSHZAuYvzMojJaLbyYOlAKKLIBtAVECbVFryBHqgnUkcZxcvJrIUfjkCouKyUxaMDqyJlg",
		@"YgtdHNARWArvhWqqLHcKPfPqYbHMDvUVlmYHbreTGIepdJQIPjYdTzlwdFWYobFvRosNAsyXVJHFmIMxZdSEwCDGhptWqyzmJkQcNdKuynXDDtqBzcuxlWFgZJnBhMPvVlWeyfnMqVfYLuKg",
		@"tGtVjPtOHYXOhgJHXYcqDkfRNCnRSdyNaodblLRqdkUptTtMlsnHxfaAkiXihKhztzHOEfZjTDSEdPScjQVOjTlGRGgOoKEWknxDeiIzCMcUvdbiBZaocxDamEjvqfduCwxveoJmOGGaFgT",
		@"NAAqvzXGepGvextykiOjjVazpHNhfqyxYcBjaHjeQFuMFNSBJqZRPCvwglCFmPaRZGvVIOGhtmjyvGhaDmtLkkdZOutedkVGnrVQXNXRWoGZsLRgLibYaB",
		@"RqYNgovwjHThMuAArmhNHbKfYvXEHLpEKBisbbteSxeZgbYzbKmxQOTiLDMuLHUjHgpZaVDmdtGHjslbTOamlxKSJAdYNYiswKhxUvdJXHQkApNiVtOTXcgWAjOsTBhDQrxQTGsp",
		@"TgsCuQXfhbEmDTdkfcVQAXvtdqVZUnEoshbAlJJAwSgPWFUYgUoLxjNDlfImJFuvsiLKpzVpvVpgptNLrkUGHcWbzMMpwATazlrCvSSfzDYzdmS",
	];
	return fnhuDBlbLXtYPJfl;
}

- (nonnull NSString *)vFilqLBrUbapPT :(nonnull NSData *)KKGmyEHZdUuTrq {
	NSString *FfwWMwhQOOQMsKmXpPq = @"EcshdEeBDbCWSLTllcAuyWVOwsrDTBheLJPBHWxypMaROwRaskyvuvywdLnyqIzVMcvGdcryQiUnHfGKqvfxZjdXNwHxTsuPlegoyLxiwoyEspwHmhQajxDrebvBqjZZiaQTeIsQlFpFpEiLgkXMB";
	return FfwWMwhQOOQMsKmXpPq;
}

+ (nonnull NSDictionary *)SQDNiDoiodvQ :(nonnull NSString *)aijwpFGOkNiGh :(nonnull UIImage *)vyegPTEFFlJacrXr :(nonnull NSDictionary *)pYrImipjgSAGqEBK {
	NSDictionary *pFEIIpqzFnUtvyhCb = @{
		@"DaRohAtpBnKLBoe": @"gOnEhyACFjLFgimZOvqigMHJZdLiKbfFHMbnqeqMfjbZXvnmdejbwIxdFDrZHinoCXCbYKPOUKvvIKZOrhdHfNeUODDfkDZXTCWTuenhK",
		@"zvCjqsvkWl": @"dGpampTtYYNcMRSBNRWqFwmruyEAqHbqnffeDqXQUJYnRXCzHqnuJnynPTnRApeOvPTzQcVmSfTZwzxCxvfITvENoaUNBybyndvcXsInXfDHFaVDBxYOacHOPBgWiPqZEvRcAbzBGORYovV",
		@"SltUVDnzXlbjTfS": @"NEeqYCGpqJpPLkPDqfwpSRjeRmVzzgWDHXPhuEqZAejKPCDzNwCLFPjOIIEtNhZBPDEbhyFwyBKnWXoCxdEKNlOrxBGUXyscMFwfropWJrmovFtjTLeCJXLMFvqMqyjZTbf",
		@"qRsgJrcBoqLqllYS": @"PXcWcoomdrBHpiEZyIEDUHALuEbiZyyHHlsosXaNXtIBmXwYlTnZVZLdIDWaHwHrQqozZScWdGgSlierAtxecZQrqutsKvYNaxRKMthZOTUVMzhZ",
		@"BvHYpHOcnED": @"vhdIGPNwugTPczFBERpYpbsAKMNwvxEonXfLGijccvROSEzcZrhVlMmpDzkLxVProiXvTPaIrUMgeZtifDxhtpwYyFGYFRIAcHQHEIVlyxPUcrUoBgGyYTdujHCwoRvpZ",
		@"MPmDdsRltLGPHYKW": @"IvqerdSNBehhtxJJpqYNzJazGnnixyORPDUYEZCOjYTcPTKvUcTXrzaedVCxNHPIzDXUuZJvQueOmdoopwhJOqUUgaVehTxWBbGcLoEHSntlVQqyFNKesiSyRAykKALILiUfTdsbilCql",
		@"mwidtgIAuPRCOcnviMT": @"aMmirLEeiTafjNYUgrcBKcOAwrwOHMEnOvSTChudXwffAeBYSQatbwfQqCWhIWkyhMJRAZHrneCoeKVZWMxUNirecnYQUUsryUdgPbNesGFlTUmKWWH",
		@"EmuURGMekLiVJLPJt": @"XEeOpNKoPVBdthLQfISQIRsWHakRzJdcPWLTwnZrutpTYXPtgafmazvLxshLzzDGqrIxSsRfJnBKckeMJEXeuUaqvMYpoOfrHFgniqzGLmwXVXNBLwMowfcEqmqQpPgIEDpYiAAiQZQZA",
		@"uCoPKiAYixLWs": @"QZIYDkLuAUCFmQpELsElHjidIawNuQjWVDBVeBjyebJAUXLamSdvHqSClmgUudYIQFLPuigEMnvGTxHzKYksQmYldDExkGWWAOnYoiyfgthqbupFguemOAmjoUcMWxyx",
		@"OnJYYTIOIJo": @"NSvGrtCNEyyABJNYXDTTLXjLETyTXNZIRRSvFiEyBLPKJIMDOwAgiTpdLIhutJsJnpKUwlIjVqLuTNZJeaPmOnABOTlMTlVfdWCh",
		@"ulTzMoNnczdX": @"ecWkmGlplXlJiKkKadcKfovtQnyzlxFyWmYvkyVaSSYUJAwrtZgpXnJHlvBfiqlFacLntYFXYFyKzNdWkymBbkSuLOUewmcxkplyHxPfcmuLrUdYgtYvCczaCueaJTZgTlaHREjMfxeIN",
		@"hyZLcXVkfUD": @"PvgJGGBxrrZbiXrSRaqLqLXJbnbgLvMqxnjjUcZYZTNgwjMhIkEHUZuZeHFZXweNTEXfHebZndVBJXSUJeAlusOGEoaBWEUKeBxkRVbPOPro",
		@"LcdsaKXyRDvwvtmN": @"ZOFjDorKrTGfuXdHjdLOasLyipDufvsCgqoeaLiaPSVMomBvpsLFYLSgDbhsNbQkInkgUUkHtkRwUsYansJEtuPBYXvayAvvfFJkkKwhTjhjyqzlUYs",
		@"lTSokDWfRrIrwFhiJ": @"jfpfilymFPZYjhjYAErnTMymvSVsScflPfnnZvFQkRNdKZoVNodvbAZZzYNaBsoyclaTmSNNDlOEZdrSbHCRQQuGskgNoVTuZVSeHvENbYIyAGjjSDbSJuEcJWtaIpxyKRrJnZMkkDzXbgspxlGFu",
		@"GdiTfXmvGcRrsnhADE": @"EWKrBwqQkMuOzFHKRVAtsaLPcnRTzCDymvtMHzKCZjsvrwqWUGFMmLMrVzxIUPCUzDNdthLZhfYEPfUQiOEStRAvNHyHSJKmwAsTPmTrIYLiTHjVAmfvJZpDZIjHfRjWZSqRzqYiaJMNb",
		@"WLABsZBBFBwqeXttCmY": @"qOTKwgkaRvabUPCtZTceAsKUCwgrZswAjMaNAiJgyyxLLMWSHYkOWAwmpQCmOQpFcXuvChoxaochjSnMRDjikNlIKVjgXtfficLEfVnl",
		@"ScCEQmymKjVQBSx": @"ThAdArFrSmRSFtLxyNjctBUcPmIAKbiHfGCqlZXfskoSzfMIDJuXLMWGCFsEdEGdooqUkNzsTmyoCESRPzLaegNmPighxwzyNAbZuRyHocrgbmzASqNStykbVpgShHESSOHoA",
	};
	return pFEIIpqzFnUtvyhCb;
}

- (nonnull NSDictionary *)aMIKCUyEJhphmbSF :(nonnull NSArray *)BPFLezqxjsOITKGom {
	NSDictionary *lyuXazpYlOinaeiW = @{
		@"FZWWCWwXtRHsOTooHcS": @"SzCcHpktuEEeBVmkMHoUqYXUCnQTSjzeDJhIVrUGfMYHgkSGkNtnjyzcjCtGacFAmikXPKDahCKMZSNCJfyBTTkgcoQHQnCRQdGKBQTHgJIdJFBkwCnkEYKzHMMWNgDu",
		@"SxZniqzwLYwnSfdHq": @"HutxcgbPhcaSsqhsYiypSUQbBjaDUrcQHpCTuzixjlruTausQfiTMPcLeGLjZxiCOkBICRmLMuZTFyIXVMUJkDKJraAmxZQYTbpGAAcIGwESczdiKeoKXrWiTrQKcuOkjGPfNsvAMbNq",
		@"pxzcRxLhUPlLcdD": @"nytGtQWNtVkkiQdZYWkZzNpYRNBRnkUGOlYSUwBKkSSIHpFpDpmOBweRmPsOoCqLejuQKDRGGYVDOqJNcqJuuberEMTMBpnOaYXARnsfPFCBkAUIOFbzUfjaRZCNibiWvZ",
		@"OpyiFfblVLmkgMQNmwE": @"NJWNxofXqGsmWDimfXiFukWYxKrLEpNwEMkbORQrDTkUpxnuFgnmFLTQKDHpAGLyhSnUMIfHZmcnotjsBRdYbajvJfzXqVzkfgZeWHzLsVtFVznklR",
		@"RbwFLDRQYZPuKjCmV": @"YTwtYXdFesFUEvcCGMKZKvFklElXRMueihGlsOlTQGyPkxQcNxxBcedSSpWUYLFfHEAhwzOYwtJbZfziSCJfCwhXWLJzEGdLFipApWjdscXFkIjMMDwzCCBN",
		@"hRESvggXsdQE": @"VxHezWzmTcyWyqAzkFUoxgqQiBkcKFjkZRGbIPoUoUFIUsbZBfUIKztRHCfdjkaoQgNGTtFICWrCbDoPmECprYCOwOMKijOhnasDdJfbuwuHbHBEysLrfPvVGPkRnZlESCMnwPtFWZh",
		@"CTdeQJAfCkxOy": @"yZoDcvdcQSLocTFBErmJHEqasYRGwWaqARiUWnMknsZreWmAJsBkiJQshmTcfiYriTPcIhCIcumKDicffiXsUEqeaRhhWjqUyiCxtIPTskjtzmYoIHvqgYNLg",
		@"RiVShrGmOSM": @"XuHVMcBjThEVLUHiASgqYEzBuwHtzATfymTbtgEWpeQPIowOupmtUlcLNLaUFPSIFkXxbgVDZFElcpIudBwMLrEdXBeLaARVtslopmJwZUpPHIDskiyPCmEqYsxQCNgUmYOvOzNXtuGYQkSdzOm",
		@"SgfcItVlERpyzeJI": @"ijERlHJMAzgVJKgsKRVlHZEmLCVrlSlEFqNMdfHOuixGNLNvrcofJrfTzhrTyrfEtaIaXHfTWmZGzuignRfXCuUnGrXryNlqkLHYCIxjcTWnRrbnLIuRpLbyMoRVwIynQHLC",
		@"zXrZibXWGqOCrtEW": @"RhQVtoEjqSrWEgfoPkxQoHlJcNjHXzweWAsuBbDYbqPlEBJhQYSpEoyCRRpjOKOZRStGcVKWasfWODidcAgTsWaCrKpYDZQzXYQk",
		@"MDCrJeUScDtJBIZCfN": @"zXwYQuTLbfrQMuRczSRQrqkZCccTRKknkjcYvxzIjqzUgnyuXUiLJITzNFhWtckULLcMShjdcaUIDkDDTTVzfbjalyLNmIQwdDXEVQPyAfEJbf",
		@"tbXWsSicYZYpzffxb": @"FlwOYuSPkOZZJgByaJXYWfRPrByXMIXyynRhOrzYRvmXYDHZcmFkfLNcLeQHbPvqfoPaRclWCOMVQsCRGmFyMdIBJgGOMnRlAfMF",
		@"dZzLTIyzxWzUDMjFTxh": @"FPLRWCJeDFzrlEOwejhWBnJlXYZngLimsEdvawRYrGfwhmTdNhMMQGQejLZpxFrWxTtnsJnvYwiCGfOcEqwAwXyKwJXIsUXBNjYxnLXUmByqcMRw",
		@"HsGBIughcvm": @"idTyalmrftzWEiBRcRAecjToBiOPdgjZrhDiMjxcDMlwCPWTlwpSYEHTQYfQaijPhYICPtySxjFJYRFQOlrHIWuaIvprorrmxmtexLxDaZeAggExQSXIqVGZQgcPmkp",
		@"oVoAAWlfMGQ": @"oPliWtVTJyROYSjwxBCJCUdSchKFlBwFizsvIYWyHuPQzCBQnOmOZThDNWkWdiNMNGIVoHoxhtMIFDMoMJxzSmqvwSUtmXhoiUiMbNyRVcinJFJEKatr",
		@"ADrIjsqLAMjIhR": @"tQzLMsEKNcUHBlRgsWVjGcezBZyAQkDpsYYkYyTEyTCxxXhmZdwBJbGmsbyJDUzMJTczVfLXgVOsvUUAsWcKmOBkUdYWahskEKFhtwuUeuDHRcJwas",
		@"DyQevOJVSdxlTRDZ": @"PPiogeRSPYsNirdNjQjEBSmtZoVIbYkounQIQknSaaVZxrfFsjOdoBImsySrziubkMXbgjyphVsXPsxoEUcASRxqyQuYbEEWTsAttUkJuOTehAOlJSBfRmHYWzjxsCfnBpQZXm",
		@"oCWoWDQxUJqiBYhG": @"SAXZydCqbxFYhyEjYatwxlXpuokijKZkmydfkuolCDukIAbBVTEkmBNVSqjUfkmPNbioYjsgrvEEgNNdoRwdTGxPQhfqYDgSavOwOgLRNGbibWyepjJT",
		@"ZFccfsgauL": @"JHTXyGkfTFMZHWLOjpflsdXBQxJEouFarXMCGCPbISyDcNdPFYxLeohsTuMnmRLIKahAGHcmHnopjXeRsUrsBOskPhZreSruQoRqLSkzNRHTQJx",
	};
	return lyuXazpYlOinaeiW;
}

+ (nonnull NSArray *)LFIRUdlUrhKsoQGLrm :(nonnull NSData *)OdUpGLOQofwfDdrpfT {
	NSArray *YouJCtTgDniss = @[
		@"QAqqRFesHpiysrEezXTKvViEYjswIUByycyRJJGHdZchOrjkxlEKkpwljoqgQLHjEJOpuaioyEQJYbTSKdAMvdjBRaEhyfxPegyTDedREolgSHaEEHC",
		@"XhwchiRQywSblYbHPzZsxChfFfXvdFZWddtoKcChAnwlWpFCKzbekWlNIufKqrkhkmunnityxftlQXdwZxvZEUallDzrAWtREWfGwhEMNBEBqLjCDiWnCMHNJrVDzNCdgnByZ",
		@"vhfBbJVFMUTZbgEzRJXGRUAntqtXLjPyeVmSNXIoSjgSmAyvlXvebCsZApxhupCFKIZfVAwpgBRTGibCtjoZSYVpwAQUDuZRznASnlvSXOHXTZ",
		@"rPLxKoxqOkcrJHIIbzwWCunXBDmHiocBssiAgGykGDgLhYmktENJfwMkYyTLdzwokWKIIjPNyMVObevmXTjANSZqXdcErFgknBGJsxdrNmKEztikVgDpYfVLsIqSJRrUOhRgF",
		@"bbqaRRBiXwDkocWrOLHrfSeQuPPuzCvOigHqInIdopCjQWbGwWddKMjXTJZDXrGWHwZyxhvFdwTsFViJuIdkaXhAbzdZNQIYRyaNnWSqLgqWzUiXVbFskOmAZkbyjWoZEbQJdNBFPHYgg",
		@"gAMDrekmvGgnxfxCViTRexyRWsASZuQXyqcNLpmEDqRvHiSvRNRaJqmLuKmzbCTwOklfAKEGrtBmaHyAGzfDXNJceerzbOuFbGyeUQXoqSivpROlTIToKjsieUrvQFBYrczHFwlznSS",
		@"bIWaOuMWUueacooXHJKcaszcZVZkhXyPetvrNdJreLIyeEdoKZbMxOCzrLGeslkSPrhNtDNTRheQfYquTBMxllhIQUwdcgGnVZhHXVgLwwBhYTFzxQsuYEkAgLJASdbAtvUEHhKVvlsmTEYfeqvKt",
		@"TklOjjQGxplSlvuabmWQMWcllevePKFwnhZRJYioZylkpkWcHaedTcPDzaCcoiSBoLoQmJbposvNlPpaZjWOIjZkQIQsvSPmWNOeGctkihvsfDlOtiALkAAZxDtSvwQfJFUkPjzbeboxpXFwci",
		@"DrbwVXlsdhPQdagKLcoIbrlXRcjFYUcRbdmpGaKOoOuMwUHKdZzjTDsFAwLlLRPaibOYrlasbowZJvpZTijirUirqOFSjfKILELWMnBBrzRJAwrZIxsgj",
		@"rhpnoTyjhyJklwNVBofpXKtAQGmwnFdtuDcqwLbAAQAGQzYrjQKAKugzvHnFjaTNOmnDPBiIhZRaqqlrphAulBCmATGzBurzwqyZaGKSpaSsjpATOLmNfVyJxIrkcvMaAMTXvCzNbWZWfwXtwAABs",
		@"ZAEPGfyGsXCiHKhMaYzHOPddKqpfAxlYiAgQcYVSZlDVZycCbXTNhwXyTGKSSsrHFCKHdsdDfWfbynatBpcvMLSvtUGssCIMQcgitfReOyWCxPZSFJgibvMYUZFJaOdRdSy",
		@"NKulcoknmwuxVFLsSDKwggGQlLztrEgzuwisSQTOfaFSopuaEcjoVsJXBiiGzFCsVWsdLDDhsFIUeiWiZxUrALXnzwUMaeMxxXaucNnFKPtSPQj",
		@"NyOVdcJCGnksAstbLswvfmBWPEFYdyMnmDuSVHPEyEJSOiSbzIjXOfuGWRTqPFUYbKrdGqVyzsxMVXIRjOPrZyyQEBxihYDZayHTAokvcBYDQAogSPqbeHIQwKcuMLmldDrUEYBIBnCifpFitmtxC",
		@"KuQmbnUHmSODomTrwRGCbtaqwTNCJYbsJgzjVLFxxLNPWmcFFNgkElsvdMSAxOKVmfEelEIOKzgUXOADZiUfNukIRmTZvDLsUljmAxgRkapgUBTXtIHgIYDXqrqlqMgyaWLWTYXyyxnIigJv",
	];
	return YouJCtTgDniss;
}

+ (nonnull NSDictionary *)SnBCKFXEemPtC :(nonnull NSString *)azRSksZcohZwDrBUC {
	NSDictionary *lMPCWvoXaijMyeYW = @{
		@"KhDkWVxnxebhVpUGufa": @"fFXFgXmhrigoDUpavMPOlZeqJavzqNuvuWZQqUsibeNbPxYIEdSuACIgIcvyKNHUoWwHHRjDiNZEoTPNUMpXuhiWFRrOpBEyGgGtoIlpYXtxyMWeAywAiEaUKMUWCPASE",
		@"iUzwJqVDImOaxiJ": @"gGvQaKMlKeQqEdebpdRMZXhhwMQMHNeBVBgvSoKgJDXjWDMswcyukSnhRZNAwtAiQQxUViJsWRWBzrZmcYjyLmJlWpaQWmckCECiXXZYTa",
		@"KRzKvQuSgqtbpkC": @"OhzMZPAclZgQgDDXamrSpgKJbIOSZmSSKEezuVxSPuOlslRDgCthAkCoRPFrrTDnvWjNvtqWdjKXstXsSvEJTvybVOgddEtjauZVhvwVfgyBpKfCmJqbXaqKZrQrkFPKbHpwqmIsFZbBHfshzYe",
		@"QooyPycZlgMeNzOc": @"VMOhVTdrBiJwYNzmScjVUEXJbNHeZGySOnPdMqMvgUWqIggWpIEljQCbKwCfZYEpGdBCItLqRBcuPZyUmGEFaNFaCCyBDKNqoMvGkcQAuywfvMEWtHWUiYjVbXsdvcoOHUitjSUIsJDli",
		@"vwTfxQehCLcCYuUc": @"hjzYOsGqOeHbpLhzGsXBXMaxuLOeTevgIfrMZNTFtvpuuPlHjTvLEWoKPGmiwLflMtrsueGCTnxKhhNduQeDbFPtzHJfijKaQbTmRhqNvQDYlaSiNMvGKty",
		@"xmfSRAWxGMzxswAar": @"MFDzfkaUVwsaQKByjWGkqMGdLvbqzQVVTtTXBWRucsfdTBIqIKemajDgqTiflOwEHOWIamfoducOkLhPCBySksaUSXMlNoWkDAOLHIEyT",
		@"YIPusPsgOCwFFGCX": @"nssARHLaUitRScvFwHWcscaGwJeKTGqOxfIvLvlGZHxOvHISEAssalLhkZpgfbXGQpKhmBekewCWPunVDliWlicWRsBOCqkQkRvubJaQAPNDXfTnyBImHboxTbNBltxdOKDZxwFgHzwvVcFAhN",
		@"aNjGOPPIqFLuBuHJ": @"RLlrrNHEMMIvbCGyQpmfhfvrxjfknbnyCvdmmkTOCPwZfQwqxplgIRDkehCiZwWChIgVSFuxUHnUtJERZrVdLObmvQQCZCOUazcLiRZNDnbymNJXbrZqB",
		@"lFfraLmyqmpnlO": @"KKUzCgyesCeiOZwPxLxkEXZxeTyjUhVVXfBEiHXBqtENRJtklBMEmljJIVhtWCyQSDyHggelOoyybnVGtAVGrUNSYoQOiCONlEqtZGcKhtFovHHlCpvoNXxppPrlMVBqReDttnQUvFGnDzwMrW",
		@"QuOqmxWvcFWMyNzOq": @"TOVZyWSDWztRcmOdsIajOfhRcITWKWfMIVWTqWersotJGAoqBOxvGkwDdfvBNqlPCkJvbbTKLOUBINHLLfTiyPrVlAEiJlrfrXRWhvfFRCnWLNvYbdxqa",
		@"MgSyfDjasNcvEoI": @"oHuIGPpeGgiVgOiCGGdAVpQiilbpeKkohsbcmIVjswLNLZGXnJJPrbkieJVvNrFiqLNeWDWBqzbvhDnidgkjLLIDJhxyTsjweuBYTolQiFvIBfawvyszhMgVnFab",
		@"rcpQZRRqisxyG": @"UAegoCqWVCpjKchpRZpFudKtoRbkizKmXvclCwhMomLVKJHMCWAGzJcJgjHBFRAhdFXkjBFCITsNHwOQghOslcYqiAJYURkiFnCcEzbmkUaiowqRiLcMQmEALEGVODoUKWiwmNQtroKeZy",
		@"kzEauJjfjCxq": @"tNPSmDFPOiDLokSiyKgqmYadHAMtkcnDgbTRXhHSoSKOYyNyKJutjioHDDWhfTOMEbBNRvIDsOZJBtEGLlkUjeZGxgoLnZsrSOqXVxSW",
		@"ygCKiEoCMIpYMMS": @"PJCLrkZSbbTYoPWkhwfbKAKfazkwbpANmvMmnjPHKujiOMHSRbyJlDNzxmoxFxrJqBatYVKSkeBlchvPtUzrAtTqqMrHOKvOPZkwRasRxXmPxGXCpyLyu",
		@"uLDwlsmtUvTE": @"XKIEcjDHWIgdnrELsinMhbCHDfvmyWZRMACUDAnAQMNrnujUJxlrnrydVLfNBmZoYwCRuDOzPGpaYrtyGuVMgaJvzgXAKkiBocyqLGyHpvSajWDpdKaomYVwXjVhmQEhj",
		@"MFtHrLWAnGi": @"DlTICWkdTLQeigrrLblPsyTIcdhmLMFyJFXaswHZOdIrJHQDXoowYTamEQixuyEkXdDIFjThvSbXWSvrpoyJMGgvUUZNdQsSFuNNOGCJBXRGhKvFlsTQPJuxTQUXMRV",
		@"yJkyYBCSCbuHEmMwMW": @"dNZcvPXoksYUbylFUGHOkEnxhkTQQJmBayxttyFpcBIukTJIxxwzVzXQjxWKpCJtMDfeCNVYWXQOpCjzvDRQdcllgGLuLkdrmUZhgfLVPVGUfZdCkukxFNLkrgWdUlSrvWVWcHisAU",
		@"ubUhfJVwAtEOsP": @"NNmmoyUZrswHOkQOYvhVgNifgYicEegEjWLSmOZWHLGNXIkcmlLQWYVqlUcckrwppzqpKqGrXQLsduLtpOkQwrEZGVSjrCxAcKANbhUblzToPBLLbfQYToRVw",
		@"lDholfxQPvnErmhLDwY": @"StnTszVVrjaUslAuibbEZgUFWRwcCvAJCbvJnIfSwAzKVxLGqjkfGGHBhpgPqvhWfrajnBZOJtBYjNWMBKUKFSrIfBnWcbVCIKLKWRLyLjBlHGMJqoKPvddLCPPpI",
	};
	return lMPCWvoXaijMyeYW;
}

- (nonnull NSArray *)sgbkWGQKmRosvSVDhlH :(nonnull NSArray *)JZldqIhjqxfyJOQ :(nonnull NSArray *)JaqxBuhJOPeKztksz {
	NSArray *OmiXAyDNZcx = @[
		@"fZvHNAeClRiYdskswQbBAvZTFbjapehlbQvaauByXFcwAOMlTzGnHwhIETomRAtKNlGAkOaOhSsIceXOvhpGEtLQXvfPSVWLWkubblZk",
		@"ZrtbmsKOzNMDIQiyMwuGgsfhQWVjVbtUTyPQqGueOEnRPbYzZrJyxmmqwrOGYbusFbilINPVcskvwRiIcgIsdrTrBNaMfgNnmxfsqufkyBvqNQCrMJQAVsCBQEuBnGFTDIygb",
		@"DQdmsSFRKonWHjHkgAsDOcxdrfDWQjhjMUZsKOgRXmOdlziyKJOtfKtJoZRqDJiutJIsVXOlPjkdwiGOZzUgRcYUvVmhnTQSqswTbYMNlIW",
		@"yjEXBUouTScXgquuFGeVkwbQIijrIGlQaLFvwjYfouomtJJoUeNNjEGSaQpJnRluAwVsCzruyrtkeOUNaeXPHUBDCOhBSRfTIXFOwNOwqWMQgdxFNt",
		@"CHNAIyIlSewskTADpQEFdceeHNCpBvGqfHrWFOWMLPvAreSKJrpCHDHIzxyCWQtQVWSsTsGPlaXJhFLZWGKAWPHZROLwTjZAHVjKTrkJTKKYwXqHxUosMmqQMyHkQMqzptDJGkhBHZaRvFyBLivGk",
		@"mSZcEzQKsdKOAZsCaFcqvKtpSTSHwOKWFhEuJhJwAWIQSZopmYvLHFoaymZreuBvWsViWBNMMgeDrJdySVqBtGNSriUNptGidHaZaIvwjgEIvQJpyGJxaCFiAaTGnuPbyx",
		@"hgvVhcRwAIgOCwtPrtCHuTyVSBwRyzmaeDUaiYbRCaGhkjvdCCbKMBJTHsrmyYRkBFmlESwfnOMmofXwKAdNXWdlOEvGuxmHiFGkuEGC",
		@"wGIFXnsPGTOnnICAWBXyCYJtSbWSvgbNsoFHRzmVwtiHBDojtILfbxVFlwKBaTTCukoYLjSQWVrVXBLyNYHIFWnjyKvYJjTFUcjITytcqVnnCGPvqDrHgJyrpZMhcpSfrqXNUYAcKK",
		@"PIuBmkuFeQznVlEkPAruyHTIKNXryDNYAOOPpFQKaLBkWnKzXGjcanqJKMizyYoxEEzXgdBvedaDTOBmlpFCXmOEZYTsVveRRbkfGlYRjVJkplqGnNFspWuuZiOcnAKesKktToVMskuMECsyGzP",
		@"xgmRgjBqdoqHJZQfPSIZOUYfGYSJrSytvylgzYWOsqeZrJziiZuGeOLcCAujFhYEoXbLYTXyOenohrTFWwtUgrzsIUTXgLGoTgLLBNFtBtmxuKyWXjtqoxuaJxeGAmQEFPqBkcAjA",
		@"ZkWQPlHgSnwndBXWVYMiNSahlYtDYGrAkpfbzFHshpWRGELdcPWTJPtHmemODHlnYKWGXXHslqqghJYjUetrWwsAMInHfpuAogZkCjhPCro",
		@"QpVzEcwTYckSibiCQIiNRXuBwVSfZIMqXSShfSvdsjpybbLsBJmcEFZETNnXfeyQAVpPCaRJJmiLSQNwDJZxBwECFupwaVUAGjqchDqcCVpbILZSwmutLEKiscvcndrXtwnXXUY",
	];
	return OmiXAyDNZcx;
}

+ (nonnull NSDictionary *)kFCWWyFfmQh :(nonnull NSArray *)WBhMzttLtEXgMuwGmm :(nonnull NSString *)XDLrSePWkzS {
	NSDictionary *ukIZJxxKWYiCaeeefDR = @{
		@"xuREMxuDlngNWyjBtX": @"uXPhGiPyRKBQdOUvPuzxOGKWbPQMqnrKUGITHepQStFzVRYcemjdfPsApaCtUwvUvpgxJCRVicerpDGPkFhlaDqakiUnvOFXAaXnOlGUPqslRLJ",
		@"eufbwRaMpd": @"hiCkogmdrQFabMzcmxYeCdcsqGNEvuWTRWMTcDOerhXmCcLnnAmenoccpRazknYiHxsfIAAAvdivxAUXcbcriayBbVbxFRUySTSWcQzQSAxJCtYHhx",
		@"QboiCUFybIELTHOMaiV": @"QdWUaboqOOSHNIVMFtBfimVwSuRpXoLdwbPRWfwhcXgbaKZMpQZKaqMJKojtbzdlujBllDgwObxaqFEtPGLMuffjEcjFWITmfCgJHvjvTmmQfpOkxUmTmrcbsNqaKixFGZ",
		@"YPbrUQFJKDJecuCut": @"uoRWSCisvjJEXnRepBpJNOrNrIEaalqxpTuRfYvyoRoubVtoYFIqQQInpuUQGpQrkGOTjIlJgCsZwwPSaBMTbOpbpqzompRwyeHvgKMtGRAlTYQXsVycTebirzVXIpm",
		@"XYXSoyFNfnMxAsD": @"ADLXmrVQUWYgKgDxQLrTgEBhqJXxItHrwxVbsxHGTaRnqTyNPmreSmooZntAqAuPOwgByLOfdWAlBYitRrWjsjEXKZynCSjlTHaejGVje",
		@"gpRLutfICJx": @"FwiNgXaBnwBcEUSnVUzFcHFgtndeAtUqXxRaXKeogsrhPUMbqCPTklkQEHEckqkPsbFWANLkKQNvffbRApdVTrVcYrNrYBKraOnqI",
		@"WgJEskmbqpZWYk": @"HSpBnhutQCHWiWdLNPSAhVDTzevJERyGhBrGhkNdFCpWZEuBRsQXeRnBXdqxIVdFxaMJtFZfexamBsFPctfiozuoaOCwpdhwGBXntbEeQnnXpUH",
		@"IpGPdNAAHGnJE": @"VcemvLAPMFQlpHpfToYUmiXZTSaBSiGNxfZSdAQvVZzHjEeOnSRhMFBkCaVhjGFVNNJXcYZyacKqbtGNHjPfemvbfvJgGQHoEuWuuFSLbZCkgsGgPWbkWHXyPeveNPUBgMyImyQ",
		@"lcvEdKxSzSWtbCwUpg": @"WqQEsrWLnvcPQgObpoZcBxaIQQkUATkwPSikXofgVcuesLsBcRCcqGSjiuGGfVlZShCxhweEKdqZBjNwSHCrFKftMjeZSEHcALaxNnXnlAjzZVMsDvyCEkipAKBXfAuVMmut",
		@"KHhNMYNXSgmKkWFNIP": @"imXzpsqMpTtqarDYwqOpkLjEHcVIqsjqlTEzhjQIvtPMVnKvVepKsYQyRHzBFbhvJtIIsamRWAdSYxGsORppnOIQCMleeSyZOCMIWBXvbINEQp",
		@"eCZSGXfavaLJkTvFY": @"CXAsVNkxFIGHDnLkoagDcywWpcNgCMoRCCaooQonfIyIuMXCHwDKvDpYbcpWrxuMdvXVdeRBPEpaJiQPNZvQOgLJGZWSHfLemiHdJDL",
		@"qBSgmjouotBwbX": @"QFkffGAOpjOvCSUQrrteYoBwpjzPNIDOqLjHPaKCsCADUqaOCuZAjDVENMANgrgEPaQdMxCzHxOCMgVdWvSQdBgkYTtZqkRermAqEwKvHkbEELELRuzaTWONANJJuNGZCTu",
		@"tFSZpVqhLlWvTW": @"nujdRxumbqtVUGzMbVLzredaPCzyjwlziCehqptMhVUTEErRutoMDlbPcOPUukXVEWbVXGkBvCWPhUNbRlyJiQNiolITarHxNcesaqCkXaAlqvHcqAyTZumstBsafcWKmHwCTAEmWHFjIg",
		@"DClHkGoqtEW": @"cWAuDlsiWlSzbVoTqEtXvUXUyQeoAINkTfnFqAbCmjsQfZbSxCtSTfHuovruLdDFlBGOzfHVCqhwAIxXXEVBbtfpcKIuszzZemhykOwbGOPGYKkcUgWAcSqkGhKc",
		@"dWqDGyFtqvvyTYJb": @"zlkVvRBCTjtOPgMiczYkeBnjaGbblMGniiWsaRTJJspjdscFyqbYNXOhhnaESDDBKsdVtwiKVAzhPaFSJGSvCQVVhenrRQgwnIFuvITImYYgzzlqIkHInNkiOQhSKsWusyWXnonScm",
		@"EbwBCOKhuaF": @"mcCCCMqVByQONgoEIeQMDaTyUwkeixSUBbsYrqoXodzSmechjTPszLwibxaKWlXPdPczRDkDLligwzbqbITJIaunkAnqyXhAthThEvzGmbSezeIqYKWSRipTLPMouAtBDQgnxjcQgHOfXSICZw",
		@"gwErfdWobhhUSTqmmm": @"usicYoLlEBGlTxXjxibVESBIlSSRNZkiVJhToPELSeCxkzDRXULbFMtDBIwUYbcYHldjQIHaUdFFxSavczzQcyBMynQjyWrwtPMOarXUh",
		@"LTeikTzMbQShzKHaR": @"vaKaOPXaScjGklZMWRhsyeWIPMvxvAnTbGffxMcwDBhaaJGcdBWQacFGJXOsjcZIRsSMSZqNKllirUfzqjGeuKtHxvcbKuOHmJzWjZDQtYCAkyWmTFyhfTImcqzTarlQLc",
	};
	return ukIZJxxKWYiCaeeefDR;
}

- (nonnull NSString *)fkLWiYJqpPamTsrGw :(nonnull NSArray *)TaUDcLUYHuLZ :(nonnull NSDictionary *)wHYfIgvcEX {
	NSString *dMayqFdeuCC = @"hOyOFauptnywAZMlndXmwKDdUKFgfzHDzpHfAqBQMMSDydGkTNdJnWWnHlbtKqegRelyqaRcTnKmXmypmdtQdPLfCvABTilbeZDm";
	return dMayqFdeuCC;
}

- (nonnull NSData *)WiXOzlvTVETGHPaU :(nonnull NSData *)jDixSfoajirMIXBtXx :(nonnull NSData *)rgIuoWswKkPqAHDOpZ {
	NSData *zSgTWNHXtzTlhtmD = [@"IefcjxhnOxYwKDBnWRzQAOtOEUAbaBcDlkLbxGjUxXUiBFYUHVVfaSWDDzzyiOWkWMxOyzzffvlQTTRupDAFqEPiJsqxSxFCpFztsAUZKiRLPtZPLfAFkIoblLCHwqojI" dataUsingEncoding:NSUTF8StringEncoding];
	return zSgTWNHXtzTlhtmD;
}

+ (nonnull UIImage *)VyqZbNntxPPqXIgYH :(nonnull NSDictionary *)FPgztrYZDyABWXRhlNp :(nonnull NSDictionary *)pEvgHSyhBnJwvkLbi {
	NSData *aAylRcjVat = [@"qdNIZjWDHmRZbblceAFaBUZRqeUjElfUbsARywocTstKMeyMAFsWggSlXwNkghaozrmJBrvRmjwmCnzcBVtSmyAJBfXaalXXFbDaftcI" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *qQKoajDSHE = [UIImage imageWithData:aAylRcjVat];
	qQKoajDSHE = [UIImage imageNamed:@"PiYWKmJmveuFDibxFqGiZsciruSbEBMVwlepcslABaZhYZMJbSHWSBFtzPjQJxWCDYqjRxikxAyrEgchbFnMZLGdNYjNwLNBjSHnRDLVMihxSMXnAmyixPzxNpLZtYHMBhsNorrLsodcai"];
	return qQKoajDSHE;
}

+ (nonnull NSData *)gbbvmoZqWqocr :(nonnull NSArray *)JzKhfyRSCEFEGcAV :(nonnull NSDictionary *)bfqeutgGtztz :(nonnull NSData *)PwfRddcNDHVfhnh {
	NSData *wIBejRmAvmWQNcEjm = [@"MPNgSsSPEZjxZIGBgtEzrROsGtTatXLKvXeSkQhqIyCVnyEYWeTjILAhdOqQxbqQgFTvGfkBumWuYsqgaZFpNPNwqTZKMPUMSoMETYiJTUaHABMEwjrehTOXoZGbFuCOezCjeQgElQkoqYdE" dataUsingEncoding:NSUTF8StringEncoding];
	return wIBejRmAvmWQNcEjm;
}

- (nonnull UIImage *)NSkEIyfpbpL :(nonnull NSString *)VDounrfuQudS :(nonnull NSArray *)LgLWKTAHNpXKYADXb :(nonnull NSString *)lzIKpWPAxHNvLs {
	NSData *SqCdPGUmfSq = [@"nHWwMPMzoNKgMvsKtZNzrOJKnIiREVkgzHJIeNKSbeVMEhnDoOIOyeZoHbijELNwoUaFCTvYKvZcwCvAdLdwaJxQZBekJAQzheNqiVXEzEZbjvqZ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *qnMHUQadGgrNBh = [UIImage imageWithData:SqCdPGUmfSq];
	qnMHUQadGgrNBh = [UIImage imageNamed:@"FeCfVeeWxoIRQwfzBJwNjLTZmNCgVGqQpCmBPKaZOBHsGVConJOLqAHpbLkffIjrdIhuDxfdofbJyfEuydEArdayUFHIQKqfFRgjtjKQkdXCTtcZRkPcNNpOxqgMUAXMUlvqKvcNHZhwp"];
	return qnMHUQadGgrNBh;
}

- (nonnull NSData *)FcnFjAwfUApv :(nonnull NSArray *)rBJhXSnTjUCz :(nonnull UIImage *)FJvRwbyhaECFbu {
	NSData *kSZvzsEiaqIpIkUwm = [@"WHbcFokiLKARlzjJFjeiUxBWLEKGhmjZtVsNQFvLpcIkqURwSfjrfnIDhgnFsifnHQIFjkJQVfiVNFpJkgrthuoIQbPtCWZgQcXQuhrOSRcEgYxrshgphlLbpbYjkmWwDCKToRaxjcOVhCFEE" dataUsingEncoding:NSUTF8StringEncoding];
	return kSZvzsEiaqIpIkUwm;
}

- (nonnull UIImage *)wGaVrsAMOPCBkQ :(nonnull NSArray *)xWaYnQxBDtcqO :(nonnull NSArray *)ymllqDUbyZGTQzxmm {
	NSData *KbABEBPBQTNNvgUC = [@"uDIiWeiXuCtzUNbUEudcJaDguZFEJDCuRgZbmzgPJvwPQHcscZTzcHfXUAhJyjYgmLcGfhGBsTTMIjsImKqMdMqsvEmupaibbjJQzWFaldNTmWAMbrzvPGDDcmRoCIQzXEJ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *HzqLuvgOZRvsjtitDG = [UIImage imageWithData:KbABEBPBQTNNvgUC];
	HzqLuvgOZRvsjtitDG = [UIImage imageNamed:@"qlsyaohWopfjOiZwWpsBswiEQqnkprVTSUlWmDkQygNuufFUDiZMijJHTLwhigMheaTnuuQEFtGEoHofDgHtaefzuSOcinVbNCIwkCQnwktVFzzKENzdoldZVuiNoPWygewsullBVz"];
	return HzqLuvgOZRvsjtitDG;
}

- (nonnull UIImage *)sWJBfEJXwqXeuhdkUJ :(nonnull NSString *)OWWUDdHzoulGYWR {
	NSData *UsRvZObbyIGNsjx = [@"XxLVXFryXEkBJEjuTYbzEnkzxznXHKuYxuHmXoYHFbKqeuguQVsWupMlqmddYxZElzjxtOyTgKGXxjrlYCRgRDybFfvFzqwnctqwLPNxOJQpTcUzDReCl" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *PSmqXfTEjOGuyIhHGxD = [UIImage imageWithData:UsRvZObbyIGNsjx];
	PSmqXfTEjOGuyIhHGxD = [UIImage imageNamed:@"GEWxBbBrfDGqNPosqMykrAQmZmuLoUsdZttystwcjFrwkCNLBGzDrVyqIZJdwBgMoblYNaiVjVgApFKTqGvXdjXKtucFTsrcGmtNaxqeOKoLuKcBpXpIQpmEZahVprm"];
	return PSmqXfTEjOGuyIhHGxD;
}

+ (nonnull NSDictionary *)oyjndRNaEmZkhQ :(nonnull NSString *)fxlDQIUkmyY :(nonnull NSString *)rBZbHPglPKCj :(nonnull NSData *)AyJKRAbXSNkEmUjhz {
	NSDictionary *UZcZQoiMhDaxLDj = @{
		@"CXaYuIpJRKkEsvR": @"bYKmpwHOhWDrLOHbQgOOWtQWoOCCQhnAxJyuCsPvrbFYqwCgxfMboyLrkjoRSsuxFOXgSSvFRhEqfMPYFrDuYSZWzCQnGEIXfDBtBNTTthPabUZYILnVuzllZXPG",
		@"EcvWSQmALn": @"OcblrEzhhwPpIUNpxPFvFoFwzJsiymuYmiBzwuqCdFFOEtaPrqrEImgmPOTBtjmCdjprFXFvivtXtqHgqsyyTMxlocBFdQOAxSZBNTitoybpMKJVilK",
		@"OUidusCYiBUasQhr": @"vkFRSULbfydMTZvrumAGEJYMZtkUMjzHgBjtdiYKvjVZJrVORAfZdXNcEFDcfqqISAEuIWDHgtZOQwEDAybjhRrukZsQKVwqpruFPACkZOJJAuEHQzrteduspivV",
		@"jkYLnCwXXxFdSFfJ": @"sHZFFIJHTWWnGdqdXXOvWkGNpFWoMHYlZQThDrhYFOHYWcYbpxJGesBGtcIcUIqvtRkioQWDmEOtBPAEUebhqhuDgeOtbZJsTWAGnf",
		@"PzeDzhBhpxBuytsdMRj": @"kINpzZtqXcBnxzRJjJXrBMcsUiiHCMlTlWQCLuWiUKzrJbvbWaGgUYtebQFWnlfTRtvKEorWAxYLLwLroYwgYUHJBfxLwohHFyazfw",
		@"LXkpZKlZgpVZzmli": @"elhewZhFjtgPKzxWeeTAOfuhqbrNhNVAcqQPitBBsFnHVBXMRqdkbVjynUAnctDazCKEbkQxxczqNPhsxKqkiyalmWWovNjvHPSYYSYpQWgQwjexajWTDbISagSnAbxbRufouohXfVB",
		@"FokBxHttvvbKWq": @"OPqYTukvDLzIroUECyEDMdDNZChRitAnWdzFbJqNHyvdsCZIfrCqUyFruJwOYStwFQAvZWfrukyTfanjUrloWKWxPInNrTHgicoEjhXxvtPXFfKQZTHKTWGkjrfhOr",
		@"lLOcEzYvoo": @"QaWSLJCTlhxnKgUOlqQmtffmrHnNyUQGRZogJvtWAFQoDpCjikNeRtcjasOMSXjgMBWCCRDhqEoDdnnSBbMVeqAMZMHaffCeHEbspSOguJpbDJkjvumVFIPJZHMzhB",
		@"zLHkNrHpfIxMrXFx": @"nbfheMTtwhFBrXptzKRdJvPmFuKkICjRoSXawIQjlCwEbodTTrayRmlznMTjmNMgntPwYEeAEQWanPfUrZYIcAWZrFapOTHhLtZwzkwUTQVCXpAsL",
		@"GKUUdinzPE": @"TcIXnvZtvJlCoUttrmkcPZNmzqUbzQyMFkWswPwbPBurerddMyNlIWMfQuYQpHlIBBHUkDTioLBYxffzoTzhXRytkghdVFxlJJEkVTQQfzgnVPjJtsXJdXgIsumIKMJlvDheolcC",
		@"NTLfLuMOsHDpgOGtvG": @"GTpGYdoVAMWRtbqRuXnztYkuZbjlCrIXXjDDCSisgDGTalpXGmUqrRreCnnuFhjCRVByEEORnLPXuTqbSmqXTgCnwDpeRQPkyODoqZObZRzQpEfHpeaxxFqtUcwxAzNpvANDMJLtSMdYjRKye",
		@"UxbZGARPrPZpBPL": @"wVNUPSbeSEeKKtjkantmIDpYAJtNzlZQnbGMRRHMfLlMrrLCONFCaXeKPVktWVgIlDnaYyTlexwgAWZdrZeolkBMJcTeJojYlWlTwVhEfCpQMoDZYNphhTEuyECmJAMloPiAQcxsvokrrmvhTk",
		@"sQOFXcOIgLybE": @"nlgRbnFlAUjtOnjFqcEzKtmtyHtLMHMvsxouGMZhiyoxWMkUCbRHQXCJvVZMnPEZivpDsvrOvNrqWqjWMCinqtcZZNBwDfZbJbno",
		@"yMigAlqKyJg": @"vLlDGWDLnvPdaSqECwLcWQiPAaSAVMsjJrtNDfmQBhbXXATqQVoaURpuSVqbTPZaZPXXPTHBdKXKrjwHIjwgJVHlnPqLurSSeEiatvOLfhxmsTVOC",
		@"broEINPzMSvflmWzJ": @"aVsBHVfrVjQWZFGXVPrDpyChKbkhoPvnsCyEfrdGXGBvvnNzGolXolzRAKdzVWXqJRpCzIWrYqPJdfobisNAmkDrSIZRcyTZWzmylDCjiUnWIFIfqgJNDrLlutDpbUAOhweGQjWEnxlCak",
		@"RAtnrtUtSqakmbm": @"yTnlonOhCPVqOuVmSdxSCdLfHeLKNetgolBUqWktxkVtnRWoqENqkBxSyaRdowvhwnUsymaLmLTIacvvpMGSZHHubFktDaEXinJvzXGRW",
		@"jlwnduAXRavIQqq": @"dessFmPXwfxyLIVPZEppDVfGkwQZkFusGhFRZocdPzwBbmfmfSQrWoxpoWwJYTSnjXxiCOBuzUauBPDOSUgcWfOHmXwtvEnDiHCFtyOCMlS",
	};
	return UZcZQoiMhDaxLDj;
}

+ (nonnull NSDictionary *)comNipeIeXl :(nonnull UIImage *)tmKmWhesPMcDffI {
	NSDictionary *crTJQmAHBa = @{
		@"CtQNbnpTPWmUb": @"HqKhLNEsqcWSOwsMnHrrqfGdeEtjLrLEfyBcPesCXOuQDsRkpjQiKLlTmXqtPdyeuktRIjaHlqSoHhejMbyxlYMvWNdKbtGOBJViyHzYSEdNchIARQrQLKDqXHfgxRFQEru",
		@"TtoekhqDJaCMfXHQY": @"RvhUlQyQDxGuYHqUtndHwpztHaJCNNCvhkxYKHpVfpzYOkdCiYNtjvRyDIzREUUgwlzWUFnXjJjkvIDVCeXuVkNIjFbJlwjZZGoGRQzGsnoYfeziaWlzBZVirAtjFnumJkGTeFZAVJhPdh",
		@"bRvamuxZAzo": @"sgvGKUhhgcLoWeojUFTvtZoNMikkoAxTMNXhaqhcDvqXAFZALheTbYYdzLYixAEwCRBWyJEZwRcJQjlrcRrmCUUBXlTnfLYHJbdUCLPVrzWrqxCo",
		@"tXxOuKPjGNCVYGOhIvL": @"HjCuErvrxpTAiKCwZfzYlVAJqLhNuqfwGCvtYrxbxUHAXMGLVXKJSeuSKLGHhSuIDkMmvXeTQqcUuwSBaZzcgQEsTvJsvWsQCsbqcMihpLSGOonFfLxdqaZJjnXGYKKoeBoEI",
		@"pDDWBTkttjlpPADfz": @"cZBLAAmjhQMEbSHtSHEIydmjIxRhecdZGenpbCSojxBkSTWhILayilLDNdzvYwmWxthbSpDgebMMKzcpdKAIojupZNkJpfiHlJeHBPfgzixMpiAWJRWHLMfhYnuYZQvPLlzRMCtPt",
		@"KvDtveMLmgzFRJaAkqj": @"pNCmHrZSkeHtsrLlfcomTMLWHdfIOoLbDsGDAsggSMAApMamARTbgbVkQDIIjfMoVYZzOtfFUEkkbNLGwydcMnfArgYjCNHTxqJwuCCelSdRlduJVBAbGakx",
		@"qJfCuYOIpYIyHUhxmM": @"txTIOTAkznHQTjmLAcYRuoXBEyCqPYNKNsiMmslDQLdhIsJngJUaEERumHrbrFANOKCTaSfWBwwyTsvfhEVBdCJrRtzjTmKcWxQeYBKaaHLUHQuuYVHpuSJAAM",
		@"hOeQWXDPdBjCTK": @"mAIQdPneQKPJYXNfZjkgwUuvkvlDtOUpRTrUgrkVwwYLoRHxMeZyrGGaXqsJwSAkbUyLMSONDTrYsFCtPUVFysyUqaLYGyLipPKnZnztAzQTftPCiKrgTCuyYJiQLkqBAAjASuNZiEIcuqjSAhqUb",
		@"nvfokMEBjZ": @"uOKAlHpXACDBjWtllvmxTkMvNgCcoMetgxwOfKaodaZEGfTkRbmQDAfnjeOdvtDJKqhtofbxLFCIYoxsndfLYFmZDIrcflVZKVUdLkgYgilYp",
		@"DoVRcBjIucNBNTAS": @"HwDBkfhFwrhneogrGhesGkvnYQljZyFhpdNeWnaEiGTPJTCnQkXKQaEdMqzTVpwxKJOEumSgyepsKSEMkDVWfIejnQQvVujkGHYaBGdnorJEGtXpHwkkzMFRohzQikCzlUoTsaMiuKvbxu",
		@"uMGkyrzBADZUWwQmcy": @"UJpPocexEssfJJEvWYZYerisUMIwFLIgGixcsFeXkXVwfTfgBIvsGhYbACsueZMEurEjJjqQLyEHjkqFHobwLQdZjGUKLnpCvqKYgFQzZWLbaLXgediRZwQcCNBUTfQSMvDTIRFcOhRwhWsSKW",
		@"utKGyFyBCkv": @"gASCaCgpZZcjlQDOlCcyLxhxQJvMaUOzORnLoNEybaKYBktobBGFzkrqwYaGOFIwCUluFWkwGdpDIlGlViFPWlhaQVIORHInFCtqnLVCtXQqxZOCJfWRTGHfxWAnOeGjGCFpANPgTSI",
		@"mcJnCMyqusrsTo": @"bDnuQxmOjxmfeceGyHFhJWsjeQiyTLtDPBEXaJPEwRbwhCkJTyVzJTDiBPzrwBDGcutSXvcrmdhvsOxtFeKcltlacuAIPLCRgvmNvxMGPArkKKAmTabUSIqSwJJvzwCwgDi",
		@"QppjYytACLYHsrw": @"QYxfeEFYSGuHJDGTFgMPpzJWRnnaSYiJTCwGdKiTwiNZSGWEXbjRdnviXSKXQALohpKQsLwjVYsvbZhagbyRzazdpDOjMAoiLngAiprpFFwYeMyXPrWFiOGIjPUPYjUOTtBpVsqztlenS",
		@"qvdMhzCUcnRJXwe": @"XzJtSFHkFauuWAOunGTYgkpiUVwVsWbTaUSFMjCxShwkYunnFqCBnJZBoVwWBHKXHMJfHIuVecklQIXycgwkVbbqvwtJaCGLlZNIKNbGYGrGjuCJQytzQdB",
		@"hELKffnkaBRCg": @"ozdAmRhBhwXqqrlHhHpSLOlkjSXkjkZFUQsLdREmXrAuchsvihptkDAcXxRMTsbipDxGclSrxfgQaqVcnbPLphSPQtuPgDDbKUjhMqcoohMTyOcncZ",
		@"EsraYvLhPU": @"tEDhJdtmHaFrUWIwBthijIgsNznXfKRrPSSfHqYyxYcKsugZyMDtrlGqQSswIyzmBtZIkdCKwYoZhJiOLsNrvCbchdRPKMdwvtSMOPSpxxGgkBqOkjSLJHU",
	};
	return crTJQmAHBa;
}

- (nonnull UIImage *)OXdNriBWccxGudSGGQ :(nonnull NSString *)ddHKoMHGJzeDcoiU {
	NSData *EVRFNAqBYozX = [@"EKswXbDzpcfTwJUtVtNjmUtKGONsJhAJSJIVzALMuZjRgyXwaOAtaqNLViMeWzEpUMkWoTWWAqhTVZAoEjDyDjdEvaRLAyyacoSrlZtsPthzFhZqsnUaDhLYBjoNqOUleyJWcWmcUAHJ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *yhwTfmcefoQrYhKZv = [UIImage imageWithData:EVRFNAqBYozX];
	yhwTfmcefoQrYhKZv = [UIImage imageNamed:@"WhLGCqrmpvPcpxohTPDjzCWPRQjfgbkCwrdoHzACjMXTmwAiehXILvExgKhxMuOwFncjGhlFOlCIzGZxcpuPNcSVJWCtjvAXYthFaPqSYeZThJtTwNR"];
	return yhwTfmcefoQrYhKZv;
}

- (nonnull NSArray *)qwOvKLcwpnpiOh :(nonnull NSArray *)KseuNLBmPGpUYoR :(nonnull UIImage *)kpKXnfXhfeQOvCIT :(nonnull NSArray *)AvNfknXIiBF {
	NSArray *xAYwmquiqYtbq = @[
		@"BZVJKBfwacjVdNkhdqCztmcJCfqhzaDZuAxWuXNDkurmkABGZMBMsXQzywFkBsGvvwPhvqIckAPraQewTdHEFfFHhGxkWXzOpqLtMXv",
		@"fZYVosSxKSGdsWxkhTXGGMJOhshbDMAdDGbvyUdJJmYnOssTwNqSkMNrhWNcWAmwRqWPzrRyBaZthzdOjFEdLQafqRhoMlnIAqVRkFDhOKNkEImNuUJdxvbIFHSMpMeZ",
		@"nzurjdTmNLFRIHJHpiuywgHPccikljEgCncnEwuoiIVNUoiNTLprQodDQiwRjCjiYRoNpxNUkjlTiUUmHuWHpSwmEPrgKOqFOXDMityPwDqlglaCBzQbx",
		@"YZKaMIAQBzlNzTodusRQImKSAYRZPaKaJORcJNmraJJDqYOYGTMHlMIIbnYqMEfGKADEPQjGHFxUPVcPutWpZogWEpKHrAfHtuDvKGFqEbVHExkjDZwVQCQhJAtWzToFQYNEAznRzjITgldWWt",
		@"nNSpyWxOlOpRHPNwiUXMqGJEeXOuuFlWwfdZDkNObUfZmfOTJhBsOQfODPsscueQnAMzosrwPnUbgvSdTcAOhZluGunbaFoyFshABFxBPBDLBvNMfuOQcKErCzbHZLVCbomtMehS",
		@"hVhLmyDFYIAoaDmqSgLtFHrWLNIGCEcyQUVJEmlOkdUchEdQgmhgQprhcxKutIcByZqOPPqBJjCeByOwtprQhYxInhQOkywtLOxeBOBtQQSnKCChkJVZsnkeuTeTidxbaqQoYPzNyMFLmeVow",
		@"orTafbpklRRFotYYsrDiyUtBDCuZlRhtjvUOvYsXNvAAwjYsGFepHGYKVhfiiWFWcvVxZDmJQYwroBUvLPYyXiksehFLnblkRFyYmODKKMWJnRgZiAdOnUdpZhj",
		@"OitaeRlskgdUmQAxaHpBhtDhxdNXAONPCsSjAjSmcwGDLxvWwmYubjtuWyEEQQxzpxQuyhXZWBtdkqdbQzuuiliofuspgHUqIIdExfhdbakdMwRcjAEs",
		@"XoiPRxQmKzVskXHkHgiNmctrWcaSghExFbYqKmllHbgUQvLAallcYUjiyHQCOsGURerXTmNDGTZMTmxjcOCnyIJihSkVPKqOQEinHtHuaKrrMmfLUsuieiDrPoS",
		@"jvUrjfaqhHjMeOVGXaneQYRZJWupRQhRJODnpXDVggEJTcONgiRHgeHIjNHyiNGBwLqVKWBpqNzBiwzNvvEzFYEOgKGNqLwhnhpgWKNKRDytBjiHOxgQtzgo",
		@"hPpeyPCcocPoghTFAbcslqKnCRKuiirdHtYsnuyjaCpbGsboeVcUTcoIxyZzcTyifGmsjIOBsIfepsdhnSUtZzzCDXBkndJaXlrnPDWoobqdkCyELqbaEWzWZxAdXQolMuipAczrgzePJLSQke",
		@"mRkWgCRuWuzAChbITlkExFxEMFccSvmEERKSLaboTFLPgnvEfrMyltxmbaqwgsWbKuyDRghDNJiuEcInMZfvKwoooblPgITExtxSAYDaRDJ",
		@"VsOdtRrQYNPZEbaasvkySPApnpbRSUymQHCXohyOSZaPZzvOFYoGtXkeHSNGADNmYjIHXWtKKpkqEspCAaYiJtoePcKIEkYlLJYvJwaLSHOStKqpxRBBdhkLow",
		@"JrWMzstCHqOCOczzvCKYTImmCWNyFDdrNgUmGWqzmMHlQvwExdVqIPwvbmJDuPmnZFbapnjmFrpMCcobFOQBMfjnWiDizxksRnxmFhcbsLs",
		@"vTSABbxPfOfTPRLbZkMJLHrAcqLayEbuXGWgiMgDuVawtBZNdrEGSZSRjgyRPgwNqlMmjwtNospIDwIVBeOzJCOUFRefKRlmakjukxMnLG",
		@"pWIEJRKOIrWhTJTmLKLeCVEVWzYeTFVeKCcEmUvSADVtdazsyXNsEWQZmtHPRVgTmMijoUcIXyrNENoNClzLIfuLSVscSuROReuMtICTpCIRvAZDnFeDQvzLJgLlSrCModjxkIyHjxRwZZUDWug",
		@"hsnXeEDsNcdbgAWXltOjfjPyXqYREUIGhAcocgegFCqQtvMlYrhhsEUhtHxgEHHiNEWiNqFMpTVHgCIVFVYqaYuDQvYqagItyBIpMS",
		@"ycSUPHvspJzChrvMerebEiKzUmnkigtYHLpKluBGpPXsPoFGgyQJRHXFUeZOwEuiYOUQNqlEquJGZwHEDUhmwMlDgQWdtsxJKWPBuzCMcVKPDbCbTEPswFIsqM",
		@"jVhvlanAbtGRxllrcyQzFLQvbiObPqTUjIRzWUCnEBYpcLPBIJromeYlRlqjIYvtiamNhVnqqdaGcjLlXZJsobTnjPWRcSPXFZfWNoHQQvCTRpFzriuveMSEKSTCdltQnmUxXIaoJPgRz",
	];
	return xAYwmquiqYtbq;
}

- (nonnull NSDictionary *)wMqoAshakdGSjxJuvfH :(nonnull NSDictionary *)QXIrUIfmxSXTI {
	NSDictionary *LAYEwkqCzQRpv = @{
		@"XncrzonowEnMqzovW": @"LhbbcuyjeNZmhofHzZIbiEAoSmfcdwwjaedEoUegNySqClbqtfEhVFbMaEuwjcEQyQbeQPdJvBkdEiYOCbhoLnQnXEWqIPUsWmaEMGfBagWPEqGZzdBcJuNJ",
		@"mOrjLiHrnrInKv": @"FQXBHmgJMTxJnMARKTYMIvXvtAYCJMrnbqjPLTTLNfTTWhNuaksrGpAgDWiltCmAXwdzgCnFDTNQyYlzslnGLJeGEqPQDYjBTnbsriVLGS",
		@"yqShFySLEYTsZsoZjH": @"WfgPnbsfHIJAPQWnoMLPePJOeKXynqBpyyEBoZJypghsKzaPgcUYgebJqLMpZWndjCTkkDTSxhEzhHsyebUriSulKPPPpAnzzSuTHzvWmVdnjwTSanYQtgkDmYzyBnBJdNhqTSElRi",
		@"EtXwDRjTUDJynWdC": @"mrMIFZbSEljoUskIadsTwOvBkEVvWCDsAqPoeVdlxqTxFoTSegPblHCVaOfhuphPHBKEanBnDAvYavnZwpATsuRpzTIPNSZRtbTvhzpQhzyfVrHBAsZmxJwUekfSNNOYiEXPgYBzbc",
		@"BoiZEdZorkrRKBy": @"UqOtYfgNHnWlnobEsioZRtaMrPQAfaCoBOaOOWehemIUVabSIzhFNAaaMDnUSVxvgfKrTTsWOWevFFMxkaRKnLjQYGcHaBZHIQRFrlJxeSunITKQJLiizzDaYEJnmsaEGAMTONhpYlV",
		@"AcpzMDwbcwxWDBZ": @"HyFzTYRBXgVYzjAWAdzTRWFLBtfoQqItNLnNovojXhhJwBErDYQpqDwsyEAwnIhirXirjWkfuhrMRLSQJUxpbPzXjIHqjVZxtbIQiyvHbhCp",
		@"eOivjDMGUVpD": @"XHojJOTUIBNbDGsEVbuMHewGwyBPIUZfpJooYIZxTzvPAGgZsnYsxsnzeBeFwfTSTKKDBKMhPDtBzKiPpnGCjFCyMUyteEfPzTOohVYhpZmjYIUhHKdjwJGAaWYmIedITgBFaWQBnSUBMEc",
		@"hrWAHQzQzcBh": @"GlmbyHQAnktcRefrTsTxGEDZjYKhipvBPHEvXYOXqOrjXrrXbDCDZXAHocnjMISLOXaDCUXfpEkVVtGsBCQsIOPCAhiiSjDVYBNNfugpUZNL",
		@"mXrXCtXPnzEBOAi": @"lZIOleeturfRXHCpDEtLokDjxtZcfbeNkWQQNaPpZTjolOJOwPaYJSgQTKPvCRroJPEcpQwSAfzpxmhruPMHwGclNJrGJCYbRMwvbYpDiyfRCsaQOrQvLhyImkarKWfJuQr",
		@"IMazzJunfBmtfSu": @"aBKPrtycXTZnZyDxHSmnfATEThRAPMpAlSCKrAhBMcrXkcgqRZkWfyigGCrGRLhHVosQEHpJnkvbVMifyxQWeLjTryEQbPUYlgdoiuxXLDvCOgszvMX",
	};
	return LAYEwkqCzQRpv;
}

- (nonnull NSString *)qxSEbEPVAD :(nonnull NSString *)qVoVGATJTIFEl :(nonnull NSArray *)robJHaTjfCBLstrvFXO :(nonnull NSArray *)MsSdHrOcbYQXHtmL {
	NSString *aqFMnRAmDVfuvV = @"rZyRwwUOjpMrFgAHAwiHffPulwSgfuZIxZaRNklTWpYaVEwfKyONZUjbwCdBufMhdzOPGMCVLxujDtgZrsnzvlfMdMZcGuZVgbeaqhoRyupqxeUlNPqMQNLR";
	return aqFMnRAmDVfuvV;
}

+ (nonnull NSData *)jdKrXvFDzFceOwH :(nonnull NSData *)dTxOVzhOZCPGpdiJOu {
	NSData *HmxieQwiBP = [@"aircGkxMfWpUjTXpCwcWYqNnQYIUaQMSToAFPMqHveulXqOWdVbvKurrsvLwXuAcYMjjKVeeGHpUwMQTAsYqdMahZjVWhLyhBXZXRHAvcjgmrMTcqTGhmbOYnpfTXSpjzIKFZ" dataUsingEncoding:NSUTF8StringEncoding];
	return HmxieQwiBP;
}

- (nonnull UIImage *)osAsIdRttzJKi :(nonnull NSData *)ByJhZASDvfoET {
	NSData *srDABXhjDftcYGxqWlo = [@"bAYBQulxFkqLjrLslRyVDJhNBeyAdxySJGxbcEKZJxzCFVLznYboxVSZdAQopJlSnutmfzfemzCjPBGNeWuALWOLVoVpTmygRceaNsIdGqiLpMWRifubkaDaiwXRdCEcjUzEhknxlrOUiiJGdc" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *qHrKbJlRXicMNfwuHg = [UIImage imageWithData:srDABXhjDftcYGxqWlo];
	qHrKbJlRXicMNfwuHg = [UIImage imageNamed:@"YEIWNPEBKDFGPeMRZkYKQlhDGxSIPiaRmAZOwwmfQGSWMIClRhqovKycNXbQJPHMBddyLpyLbqNZGiDtYBWbPnHjMdAAOibsfeNfXMCSBuTl"];
	return qHrKbJlRXicMNfwuHg;
}

- (nonnull NSString *)ZsiasspssxwftCJ :(nonnull NSData *)qqDXaiXtKXnEVnzUDZS {
	NSString *PgVUJbMdiVKOZmAVV = @"kxlDCQvZRsSqHgJVuYaXuMgisJfSIiwwKMaKJLfOGUatxVzojSOgtRXzVGDECcpAUxfsHBdKOSUxbCgSinIzKErrfufgQmcGWkjOSrnEtqyBxnlphmhoHpZmyEvNaaDGDiKiBOzcITVZ";
	return PgVUJbMdiVKOZmAVV;
}

+ (nonnull NSArray *)lqYUWZzplDqCGO :(nonnull NSString *)vORVrMoxuTVZKcl {
	NSArray *QuJXWSwwSE = @[
		@"GOYZxjPmQYsGenlBihqQpVUYPCQdSbBPPUKFltjaWQEQMOUdYMJfZNWtVLdXQRAiXlJLKLXOYduxYAqgkWSoBjSBlxqBIxYtMoXfZiskrgQozFnNcDQquic",
		@"BGAqpJJdwZcalLbGwNQdkoiroxrFkKtJWBpsHoglEzWLuOjgFjYmPSBmPBMJvwSRfTnCdILLyrYrYBXptSGsQELnqlOASoUzJJVOIdMNSsZqYphEENapbDaBTcOcvzpRnXtxojheWnmQQDJdAdR",
		@"doilqKCArscBtodmHbJVTzHavjTywjJWObHxuSyePJNYTWtOVqSBiDwmWXfVWRXrHKRgoKBihlIzzZtVUahxQtwyfDbzeSgoCVDvjTAmLBkaYNbcZozZXtpDXxnQa",
		@"kJWAGWsdlFKfbClAZdMQcubXdgETPOeYzPbNHxhRYobuSfLaNexlwcAnjAxMNPexstAjkbFcmaZbSrjObxoODKuUpevYCdQbMZtppLrkzMmrChDZHOvANHtSLWckuplPMknGRiheCLOgs",
		@"poOZzpucGbOFVdpfKdcvBJVSEFdypluijonJDCJHyPImFXhCRQlLxRATLPkXDbOYDvlfIawHCHNrLMexOWlWMIikamjRvqfMdFLCmqoqeoFXeVcmB",
		@"wPLEtLBvImmmpMeUmmakYsQKDuwyNWagnxAquYgBelMbkxXOgJuaTUZOTvJZUjhqKGDvocynDFUhftdpxPmsXVARJqWPZNVlMBTBHRYT",
		@"dAMcBwgwvJaSFqjHrMDgcpVyJeJALDIImRFAMLqSEjrgVFjTddUwFzUkVkuBJLvXjNQiPaiZlmcnOfTWrktBfPKjNUUQEFCqntksrBHUgvtFPaaWlJkvqwfPMyXTrMQvKIalaEphHAfaKBCtdXbi",
		@"CvjgiQVXnxmLjfkPExCKqEIMvXZYaKotdqRdsmNmuQXHtQdgopYvJXyniExHazXioPwnRBXWWpDTslnTEuWsGaWJYVnmZYrpusuMOXusiVQ",
		@"plyHNJseUnsfpdSCslrBKtVPgVPegYpfDeZAWnaEiYwadHRtxZlyrJNwGXGNEQIXILaKnyvGiYPdeifUBpGsFJICeDPitSxPhNpRKuNSOZSjniOakrAxdvmQFguetVdGrWvBzYihBvanff",
		@"oDSrPjkBMRcmJeQWFTmivwhKsjTmxptrnxilGqzZArEcZuEFVjroUvQHLgWztEYHqWHAnYOyzQQhtLuvqsWxALUxfgDWyjSXFMghIYqCnyHQlBzlICziXWZNtkBrCPyqDvjRGB",
		@"dnBTnufdJySRofGlvWyhcvfjbjuvycJnJQQxADJGZtGCfHYbepqxYfribtUfNaXJFpCeUgZhGhPPtGyJubqwAHnTCOZXXMfWDijfNIDSneZjcCZy",
		@"njkCHDZJhwcaBBRzxioHyWdNfinbpawcjZPPqbaQTHHuGivHuOpCRhYwEXroKHPTHGuTFOuEPlhTmPiipbqzVhWlNtdCFKPVrznT",
		@"JiwsqpGwxkofRSkGFDFiQCGUiZxRiWCFhcAWMfngoflDGPvWaqIwlufxPjZKjWknOHrloDrkOyepjLecABBcKJYEARNfnICbYIBWMSBNVf",
	];
	return QuJXWSwwSE;
}

- (nonnull NSData *)rvdYldlKDRIAD :(nonnull NSArray *)AjJgnMPbMl :(nonnull NSString *)TikAfYmqAAYbbpC :(nonnull UIImage *)rmZebajhxq {
	NSData *ovuLRAsjGCCFD = [@"PDKNipYdHeuRLCRjBGSEOydtoPyxIshkRxgFGaDeEtrncdpxpzRnnqHOrxSJWzjRCbBIJmDADjMFiHGCEwVupbYeQuFurMUlxPjHiSIOLCjKyvmQSXLBSYyVsgXbEblOKdHhLAMaTeAKd" dataUsingEncoding:NSUTF8StringEncoding];
	return ovuLRAsjGCCFD;
}

+ (nonnull NSData *)wBSiuabDDTbW :(nonnull UIImage *)XgNSxzvZxuje :(nonnull NSData *)PmeJeDvNzUtOx :(nonnull NSData *)DyAicTDDdNk {
	NSData *YVJUKKDcxXNde = [@"igxAySdysOVcXPNGdeBfCacnggAksIMiafthqVybdnnxToJqiXaqMCEWkaHotmgVifWBFfMYuJHnlYkCYxjwdFvavQMRMPiFGRcraXmruoXbfRqBgGtcuufWZVYHuTgnR" dataUsingEncoding:NSUTF8StringEncoding];
	return YVJUKKDcxXNde;
}

- (nonnull NSData *)LtoykAAOQqWay :(nonnull NSDictionary *)LJPxjdswzHDOg :(nonnull UIImage *)EqsUjobHFBG :(nonnull NSDictionary *)zMTbsPoQnPSEcNaig {
	NSData *rNVgHYFmkXqOub = [@"JYfPBHmkCZVwbBFNibHDuWcKGLtCsaYmKTRqwxhXekwdflTRxPbhiaROkXyxEkIgAfmmcERKyVHTQPcPQXpVBNqKdxEwiEpunMrQZphtDOoKH" dataUsingEncoding:NSUTF8StringEncoding];
	return rNVgHYFmkXqOub;
}

- (nonnull NSDictionary *)wNHcSGfypHbc :(nonnull NSData *)DqgqDWmkyweGJ :(nonnull NSDictionary *)yhMUNxeZtSJKREABPg {
	NSDictionary *DVNwrncRYerp = @{
		@"hmGYVICHdCwJr": @"XXqGrYqvbJJrVnqfWHBQxQpkPvRewvsxJfXJuuzBMoipbRFImzBDfrotQMTCHXwMZpWooyuZXlUbjemQculEGCJXkDHhnLwoWPruZpfjAOXwPbsrfSnIBgWYmarttTPwkQWxEgsbKwG",
		@"oJxThtfqpvUi": @"WsuFeGLlSYnsiEbmTZnPDpgnrVLsQqZwNTVppDiPCZVCnOLErdTQVhswzdvcSICagXPcrZrHuZNbPKuszRvFrVXajKWXkXGrRKbOcMgUPpsSWJNbDeFqUtNDXLkJchFluxREADuoW",
		@"NgJkDqztlkpavwri": @"hKpAkpVzwmnnXcqIFIzrPXferuMNUBxFhaeMEmBIfoYrEPySxxXVnrWgRJAMjVwWwDZQUHdHubGzbCqmLJXVDjnzEsKKzFyGARtCdzlRaGTzKPqVmgpbTKlVyaIBCjzpJtTAYqBjRuZSSjvawW",
		@"RXTJOywuKdjukbACV": @"EyfTMDSdcOfyDmCyrIHOtvuKxACBAmMYBsYbLfhoYFyVGEtNPmOADvxnnYrrqxKszFBCdTDuEdkqKzkfYVROdQuKDlPRMzFFyJvGTOPsNaPoBRpSJkUVSSjxejMToRQaWZaIQJNhFSRQYHgmrPwam",
		@"lsZwjfDhVIWSopgrirx": @"YQspSdKEUddzoFOPNxUfCwXqVlycdhzftWusOXuDYDGLjTEbupCocjqlibJJGAoOVDyhNwUcusBfbRkMGiElAuEtpssHsKQmRJXyxJUzIHacfsBMwlullIlNW",
		@"elRnUKVuUQRBWFqAZTz": @"klltRyudsCczXGpCdvPrivthjKUkIVphtRBIXhmqLZoBDdHNtILnlGLsyVOgsUJAnwsZBiIbjkyydUowVDbsdYZTQhIzijeNXrwHLPUJbYjuRVWQUkkOYzbCkirTKzPonmnvAryQbQxosr",
		@"lLVAPwgCMJ": @"FElsdpeFJrxUIWjlwZAxvwFmToAIFmbACGXkhJCKlbGvIXjdVBPmhLyTnDRCAwbWbtMyHABQXrQiHIaGaPGafyPRuCCGxBaZuHRArYOtQgMxssHspYMBVkdbCbAfOMZFDKQNmmxkph",
		@"BDWvfbldTAzrqLEj": @"sTkLrHrFeoIywlgOBMVmcrbOLPyOItzNfRoZNFfrnQUnDzkmHDjVfFZgdUuCElIEWbixRJdXpYkUuckKtmFaDAwEZzByqxGBEvIsRIiAnUsPHfgZAmFNYsXPcwJlrZJJTIR",
		@"jWOndZwzXe": @"UEbnOstNCRnGJpqcpoLIKxovXAxINdVqEhCgnZxfaQyJTxAEgVozdhTzuliqbfTpXxgoYsZQLPqLSOzhJEzzcvLLPqbjRTUfZNyNXVrxRJMCrPxOkZrPfcdRZlWVVHLBK",
		@"qMvrMDwiedhmhxE": @"ESGcuvlTfUVUjHIzTiXPVlAUsEEkYVeHmiAxnjRpZPNDnoNxjefYGcUMEaQVYLQCEOmzhbyNVQDPnMXhkldjDjbFbUJCEkGnfsKhMbcUUjdPXaYk",
		@"PefbpDXsBKOf": @"PXrOmPEFCiyGBGVSOBRxaeasgmwZEJfsypiRhaxelCdJXItfGhZISUhlJwDxqGnKVpZYsFchumsHZjrWFjkpxkeOIPGsvFQKAcXpOxQkEEDggpzcOleHkZNNlx",
		@"DQUsPLUREfUVVS": @"mFzSNceHCOVYiaEmmVRvogUJDtIiZdmesDYHsFiXmCNwssNOKJolODPqCyqYedAtxbWUQvKEhivGQaRbWJrrWMQVrDMnvsNuDDtwwFYnKvCFfenpKtebsoerGWefqnE",
		@"JgSRduFiAN": @"ELMxtNmGfupvcpbOAUZFbJCwtrpuAidxinCvcoJFIHsJYfopLhpBcsXqtsfgUPMAHDVxaIyykzLMmGwsGuUeJImKnprEuptgXUpwJnfPFenslORRXNZzTfrISFHTtSRhPRhpdWepwJZPAisSwOL",
	};
	return DVNwrncRYerp;
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
-(IBAction)OnWebsiteClickChangePenda:(id)sender
{
    NSString *website = [[DetailArray valueForKey:@"job_company_website"] componentsJoinedByString:@","];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:website]];
}
-(IBAction)OnApplyClickPenguina:(id)sender
{
    BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"LOGIN"];
    if (isLogin) {
        ApplyArrayPenguino = [[NSMutableArray alloc] init];
        NSArray *LoginArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"LoginArray"];
        NSString *userID = [[LoginArray valueForKey:@"user_id"] componentsJoinedByString:@","];
        NSString *jobID = [[DetailArray valueForKey:@"id"] componentsJoinedByString:@","];
        [self getApplyJobPenguina:userID JobId:jobID];
    } else {
        [KSToastView ks_showToast:[CommonUtils UserLoginMessage] duration:5.0f];
    }
}
-(void)getApplyJobPenguina:(NSString *)userId JobId:(NSString *)jobId
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
        [self getApplyJobPenguinaDataWErd:encodedString];
    }
}
-(void)getApplyJobPenguinaDataWErd:(NSString *)requesturl
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
             [ApplyArrayPenguino addObject:storeDict];
         }
         NSLog(@"ApplyArrayPenguino Count : %lu",(unsigned long)ApplyArrayPenguino.count);
         NSString *msg = [[ApplyArrayPenguino valueForKey:@"msg"] componentsJoinedByString:@","];
         [KSToastView ks_showToast:msg duration:5.0f];
         [self stopSpinner];
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         [KSToastView ks_showToast:[CommonUtils ServerErrorMsg] duration:5.0f];
     }];
}
-(IBAction)OnSaveClickDataPenda:(id)sender
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
-(IBAction)OnSPendayhareClickNow:(id)sender
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
-(IBAction)OnBackClickDonePenguino:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
