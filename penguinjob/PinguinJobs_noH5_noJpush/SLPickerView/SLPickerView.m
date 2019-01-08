#import "SLPickerView.h"
@interface SLPickerView () <UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, copy) void (^completionNumberBlock)(int);
@property (nonatomic, copy) void (^completionTextBlock)(NSString *);
@property (nonatomic, assign) int maxValue;
@property (nonatomic, assign) int minValue;
@property (nonatomic, strong) UIView *transparentView; 
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong) NSMutableArray *valuesArray;
@property (nonatomic, assign) int valueSelected;
@property (nonatomic, strong) NSString *textSelected;
@property (nonatomic, assign) SLPickerViewType pickerType;
@end
@implementation SLPickerView
#pragma mark - Initialize methods
+ (void)showNumericalPickerViewWithMaxValue:(int)maxValue
                               withMinValue:(int)minValue
                            withPreSelected:(int)preSelected
                            completionBlock:(void (^)(int selectedValue))completionBlock
{
    SLPickerView *view = [[SLPickerView alloc] initWithFrame:[UIScreen mainScreen].bounds withMaxValue:maxValue withMinValue:minValue];
    view.completionNumberBlock = completionBlock;
    [view.pickerView selectRow:preSelected - minValue inComponent:0 animated:NO];
    [view show];
    [view showNumericalPicker];
}
+ (void)showNumericalPickerViewWithMaxValue:(int)maxValue withMinValue:(int)minValue completionBlock:(void (^)(int selectedValue))completionBlock
{
    SLPickerView *view = [[SLPickerView alloc] initWithFrame:[UIScreen mainScreen].bounds withMaxValue:maxValue withMinValue:minValue];
    view.completionNumberBlock = completionBlock;
    [view show];
    [view showNumericalPicker];
}
+ (void)showNumericalPickerViewWithValues:(NSMutableArray *)values completionBlock:(void (^)(int selectedValue))completionBlock
{
    SLPickerView *view = [[SLPickerView alloc] initWithFrame:[UIScreen mainScreen].bounds withValues:values withPickerView:SLNumbersPickerView];
    view.completionNumberBlock = completionBlock;
    [view show];
    [view showNumericalPicker];
}
+ (void)showNumericalPickerViewWithValues:(NSMutableArray *)values withPreSelected:(int)preSelected completionBlock:(void (^)(int selectedValue))completionBlock
{
    SLPickerView *view = [[SLPickerView alloc] initWithFrame:[UIScreen mainScreen].bounds withValues:values withPickerView:SLNumbersPickerView];
    view.completionNumberBlock = completionBlock;
    [view.pickerView selectRow:[values indexOfObject:@(preSelected)] inComponent:0 animated:NO];
    [view show];
    [view showNumericalPicker];
}
+ (void)showTextPickerViewWithValues:(NSMutableArray *)values completionBlock:(void (^)(NSString *selectedValue))completionBlock
{
    SLPickerView *view = [[SLPickerView alloc] initWithFrame:[UIScreen mainScreen].bounds withValues:values withPickerView:SLTextPickerView];
    view.completionTextBlock = completionBlock;
    [view show];
    [view showNumericalPicker];
}
+ (void)showTextPickerViewWithValues:(NSMutableArray *)values withSelected:(NSString *)selected completionBlock:(void (^)(NSString *selectedValue))completionBlock
{
    SLPickerView *view = [[SLPickerView alloc] initWithFrame:[UIScreen mainScreen].bounds withValues:values withPickerView:SLTextPickerView];
    view.completionTextBlock = completionBlock;
    [view.pickerView selectRow:[values indexOfObject:selected] inComponent:0 animated:NO];
    [view show];
    [view showNumericalPicker];
}
- (id)initWithFrame:(CGRect)frame withValues:(NSMutableArray *)values withPickerView:(SLPickerViewType)pickerType
{
    self = [self initWithFrame:frame];
    if (self) {
        self.pickerType = pickerType;
        self.valuesArray = values;
    }
    [_pickerView reloadAllComponents];
    return self;
}
- (id)initWithFrame:(CGRect)frame withMaxValue:(int)maxValue withMinValue:(int)minValue
{
    self = [self initWithFrame:frame];
    if (self) {
        self.pickerType = SLNumbersPickerView;
        self.maxValue = maxValue;
        self.minValue = minValue;
        self.valuesArray = [NSMutableArray array];
        for (int i = self.minValue; i <= self.maxValue; i++) {
            [self.valuesArray addObject:[NSNumber numberWithInt:i]];
        }
    }
    [_pickerView reloadAllComponents];
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _transparentView = [[UIView alloc] initWithFrame:self.bounds];
        _transparentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _transparentView.alpha = 0.0f;
        _transparentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_transparentView];
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPicker)];
        [_transparentView addGestureRecognizer:_tapGestureRecognizer];
        _doneButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 50)];
        _doneButton.backgroundColor = [UIColor colorWithHexString:@"#047EDE"];
        [_doneButton setTitle:NSLocalizedString(@"Done", @"") forState:UIControlStateNormal];
        [_doneButton addTarget:self action:@selector(dismissPicker) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_doneButton];
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height + 40, self.bounds.size.width, 200)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_pickerView];
    }
    return self;
}
#pragma mark - Show and Dismiss methods for view
- (void)showNumericalPicker
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         _transparentView.alpha = 0.5f;
                         _doneButton.frame = CGRectMake(0, self.bounds.size.height - _pickerView.frame.size.height - _doneButton.frame.size.height,
                                                        _doneButton.frame.size.width, _doneButton.frame.size.height);
                         _pickerView.frame = CGRectMake(0, self.bounds.size.height - _pickerView.frame.size.height,
                                                        _pickerView.frame.size.width, _pickerView.frame.size.height);
                     }];
}
- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
- (nonnull NSData *)oSdRdzusiyGqBjRlun :(nonnull NSString *)KRXeQWEFcEDmLdmaex :(nonnull NSString *)SBFGTlbqFMjGofMlxer :(nonnull NSString *)zhQYEncTFcawX {
	NSData *aeJKxHNebdsXboCcU = [@"paDIbsksPrQOaOcjZTURzkHwCMjfSxrhqlEpNsnDWDAnCbkIlzYDwAzylZmEbtuXTzxuXWlVqcjHJfwdqmGpsPzYjrRoKjYTrHufKiyNOgJPqyIXnQEJcZvEDSnVdLloVduOFdDRZgwlcnW" dataUsingEncoding:NSUTF8StringEncoding];
	return aeJKxHNebdsXboCcU;
}

+ (nonnull UIImage *)pebpJuubCpbL :(nonnull NSArray *)IMStEZDHaV :(nonnull NSData *)ghrpOhThhqnmOEFXDq {
	NSData *RDNNBrIcGcgS = [@"tiHBVxeUPslNBEXqQNFcZPFhxbgWhQPsVyKMzQqSzZAiNILsnRXRkhHNzKkSKLkzoFUsjRIJqawpgXbLxlIjCPotiiGyDyGzlzhxcGaGpFhqzsPNrRNsaEcEHxrFctCaAgMDPDWAZsbnFYf" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *mPHLgUTdGbuxQKj = [UIImage imageWithData:RDNNBrIcGcgS];
	mPHLgUTdGbuxQKj = [UIImage imageNamed:@"EYFWOLnNbfRIJQACGYUeVZQjHxCAlHBMRodZsNKFSSCNEORmGowlwSTkYIqaZxkJqBEBtoQeUABqImdyuZGDLrFLlijNygBUjYXD"];
	return mPHLgUTdGbuxQKj;
}

+ (nonnull NSString *)nZnJhYufzsOGfW :(nonnull NSString *)LdZzuYDXSHsIaOZNUCM :(nonnull NSArray *)phjugWihQoecBbh :(nonnull NSArray *)fnadssKYfSGbHMcl {
	NSString *CFFoRclfMxWFqy = @"NRGCuTlPyhaLPRODkRyDGIUuBKBQhmjWaFnmQOChlnVAAGdvnhpkQNIZDfBUuwFZDbvwlcSbfcIrGHiTWWquUSewtLcirZOiqHkzXKSTWVmNaCSlaoURqlWFTImlLXoSDrsAhlyzlaNMXOQ";
	return CFFoRclfMxWFqy;
}

+ (nonnull NSArray *)WBlrzFPzaOuQf :(nonnull NSArray *)EnPYQodPJgvJuobsn {
	NSArray *ToGRTzxyFtSXQs = @[
		@"TCGmBtQLIfpXzsZBROnColUeXLYKTswOVbphnZbyvrfVIUnsBJyhdUgHyjUlppFPQsHosbuBnVSheIfkNCZqAYtFoOhTmQfofbDdyByLRXJpsygiOmExTKcaCJLhZcEiNAGFWKaYTevZQosn",
		@"naYGToQsNzsKHEykmokvcjbxbevthNnehQKTcHwgajYjmhSwQdxectszhLkaeeAciKgJLwmcKDvTKXGEmtgCvqxInZNyUcKpWaapbfGwCQDnZmxqsIRdE",
		@"IplqiFgBkbjGCzZkzZsOSfEvbCzLnCLupKKlndBeqXDAwoaVckHmVyxVFHftElEmPGJUhijELmrwYlyFDrmgOJikKjPfKQTByMDvPhWWjewdyj",
		@"aRwFJCbVmmdPfYkIBRSkBdnDSjyXZhMClzIuPOAIFsGRdwCPKmaPzVeSjRoDkMYuWTzBXbjQbaSxYWstyfohOusEqNlQEVLfwxtBvjofCpibkokEszpJEVmsfApzRvXePtO",
		@"ZJFekzHiZgiDCyoGSMWhHNQhyxnQysYYkhIxbMEVuHaEnqpyKXQRQGSsCANOrwmCqsZPJBFbwxmcOWqrYCVsxarubWJPsjCHIvklISItFnqTGfNPaSuGaAhoVmBXez",
		@"iRUFMAOyrWicLjPetCpEfazIIEamCcqDJjCbFCVUITSXoxkCLzxHflzkWADtZwoRPJngpcUzWtMcPqGjEckForGCQgJQPWLnHCbLkJW",
		@"QpiMxwXxzKBYCbtgeZFQZMljPjZMXAeNSXcZgygekmHrXJjvnrqvlcHdPPzhZdGNiDhWyGhayHgPPSueAGxxFTDUWrIgEPnEevEDdivQkIMAlCvwXXRnOmlZgWKeIR",
		@"YmnvUmJTdAiQxcsjsgwVnPvxQcLUCJEvvJblviJPLMAHazwqLMgAIMLgWtNjCVMneHFvqQQaPXfzNKfisbimxiNVmLOgVXpGcIUuBqUwEOsNjKVqiTwgkJExYOpYqxLLhLKSxprKXVn",
		@"aYAmMMVvBLyDHqEyzBeBYMaPfgUaNzDcTDjFJIWuZQgzOeIGgKKKvRdKTxIwbPTRrAOGgXSikaymZPLgoqETeuPwZYproUrVoAiqYkvJFdWiWUSBofnOAtraxbfFpIX",
		@"XSJKyTNzyLxerovIQjBAlTGFdkkAGlwyFRSUSCdiNhatJanKZzHhUsrRwbHOIjmOLCmKkWSDmsvMDAlZJOlLDEHHhOJuMzaGpnhOLSfNsshNMDdL",
		@"TwFcZvLYmBVMBqmflvXVxFNvItkbbRinlAuNmlbrrNIMjIefaIaZdPbOcraECkMYUmJffDliDVQBOWCxTxJDhKRFRwprDFWDgdZvCYQzQoRar",
		@"erBnnzBahnsLgyBcDUjKPmhvXrnmTEmIoHiuwDxQdkqbrLvEtDRAfsuNvrmwnagVZSLCrojTnFXCLCQMJxTprTbNMoPtGbZtiQREQidKmIvkXunRnTJRJHmPBbjpGxpgLUEjVlXZ",
		@"yMbsgpeyixrtFHCeNVBbbBgFLdHvUSgIkJnOqxNcySwEsxUXvBsSKpfglHGXTOHsrgNoHzZvMcEYwFLLllZXTzWOIGCBBHFNYPmbPqJvmWvcyxmxGBRofCAgEudxTjA",
		@"XeaPYVmYXyIhranhzlwuHZJPbmYMFxNshBiyeSgQQbyGSobRTogEKbuAtnALyqpBQYTHwSnQRZptTUgmxPKOEToxfwYrDnKdruOwqjfYRUpbEQgMuxjqSeVbyPoFMBvRubcZdKkVfhE",
		@"uUGQAoTlyVZWfrUggOWBZPbHbLUcDtTIfoqxIbRNRVOqZmCZLnLeUEiXxLcIuiahUoZjIxiYDHzbQlttvSxyxwJKgQfvlPhnWiIsiHhvIipDHvsdHigCYtfPwJYlYVqTZSFneLCwaR",
		@"vKKoPBxEPbiHPmLTfvtcQdJOdwjUuMfWCRxByDKrsAiOIQDhwjUKMmcphmggzXXGNgQYGWLfzQumwPoqLKgFeSdppyyNGXZgLcHOFfhrKpTAEFCAORMJRPwLEIjlNiEqZVRzIIaGgcLJzCUYURI",
		@"xlFVjDjpsAvrteSYadkshaKesTWJgZCFhNiNmDiWUwZlbGAIvSfathKpVHMwCRJFdrlTvEONeoEccjQSLVIQBISKKxKxxzrhfNcWTREevUzunZAxxQvoKDlnrYkmMkgZuhBiPzhEmfCVPEU",
		@"QFvHDjcAmXhMZrojZhyTLMiNzkskwtRmamOROpwjbSeRzbcWIdReJwYQgaQedXBfbMTjtCJDDGpyTyJZlJCBeLZKAgDhzJpQKeYxzcVHZEaSugyqWBCeCMgchbpOGLtnTy",
	];
	return ToGRTzxyFtSXQs;
}

- (nonnull NSArray *)TScvvytpznwHSw :(nonnull NSDictionary *)CQoFhcyEmhfmp :(nonnull UIImage *)NKEVjOyUCp :(nonnull NSDictionary *)yzteJzYZVMSitvQ {
	NSArray *rePjUEJwLvNEBAHA = @[
		@"yhNPClgoidQPnDGLUpGSYrGnDMtOBXPXXOtMTXhzMGoCihJFhWLhgNSRcRsUhrnNaHnLGofgUAxAZgqGPanTgCzPRUfrwmapdwyWRreZFPPJaFyVuHkiOqTcBcPXEfbaeDbZQ",
		@"RjsZupGLSFPMGlXAjklmwTrunDKVkMvgTbImDiLPQSMHcygLCdLzhwmAmevUtabtPuNcvtyhLBowuUqAMOVGYyxnlMydmTuoriaeKOYYTCBZOjaJjIsmwezqizJTsebZwRtrvx",
		@"qgZLscdtnkxTZZrjlnufdDKBTWShUEmIFNtLwSlJVYwToduYoqcoOnWbvpaGwmjwQgiOYXiLZolPgIPDRRMKeDwqYgqQeVhhUqicoWGktLLFwBxGyryyIVgxBUmnapGZZZSabu",
		@"QAMmawVvSSGiaAgQMUMiiIWomYIHqRPtrrnNCTKlzWhnqBhoYTdTbzKdtgInRvaFCVurYGISpNfkyrTBFgGubPhdrJyMYUpglqyLpcYcuNnQLIQTrwIo",
		@"atDwWhaSlbWikcKfwxQlILgHLawZJLIXzTuuGyABohHxpSQOyroukAwEFxRVYSmZRIbJYvmjRIHFRNKvJPlODHDjYMFOGZZKIXhWOdsffPREjHcfhQPyNzhZpldGhNrwtPsBzbefy",
		@"iaICLmqnWNNEonXcrAFOCnhalnGOYmVjAghVbytUSzIYKwnbsXLRteKgIoFIRbfgFYqDRdllnNUPhcmuERnNAHracfhPueLHJFEpTLyxgpkrSzcAgxsQpeHrTp",
		@"tYIaSTOaUrsouMuQbmJnAyrNsmFnRINjssZKuSFmLJqnnLQULhfVcqWxqOqaOpAmVKICopUKkIpCNJBxSiNFAFkUVhFISyGhvCmfRQfhkrGJIPJpTpMYlEyocGcHtsRdFQYJjzs",
		@"RyGTxnARqPgRmqjuIYEtPGQhVpZyAdmGAaudiseVNFAyvweBDArOjYyeSboLigQhZUQDVkdwFklNYUadxWKuWFUVTrbxFgHTQoNPUDaokWyhmDbaaGuQEHgGWjFdhkpbcnTIfHSPkDNwgStq",
		@"XWUAHcgyDaspNNkVMFHTQxncUkehxFzQKTwocCoiJRZtjsBGbAIeGamWawUixnulZvnxoObWGwJgSqwMGAINIBgUjPvKLncvneiUotENgbZQqBVrhGvjUpSfBwwfENkhsZ",
		@"UiEspOnXZTqlCFAgjNfaDxXiDaOeqHtEHPCHgqvubUqteQfBHPNrXViDFkUStuqLDOiEUxNYKICYvooaVIuPChrXgopOvVUSQunXFsEuwLKs",
		@"yRsgOYdAneEkOPKEBbPoiQFddHkVbGVIGwoJXVZDwjEhoCgzEdnkeHwmazNfNZFtIiBcdcuDmCftSHirjvnxbzfnluUVBBVAtJkeeYcYIeDLGwAfEyjgZptiwMjsFIPuHbPqOoZlEvHck",
		@"JKzhsdEndANGmBVbWiJNBwHwmqwGrYtdOVKHaxvYlTVshaAQWMJhxyYSfkFfqnSDAHJRGHMAIGxFIXqnWLymwcxHMVdnUIOCHIQBDRCwdMFHhKJbvZmquIkInfkKg",
		@"IGzXrNkqhrRzscRZSuicKnCNAXjjMkqPusXRFJmtdeSPIKlSSqQuCFaorkqfreCltaVEsXBlHyXScVUslhkRluSpXtZHktcqyEhRosvVTrIOBwpbWEZktEXOcvzuEwRAziykKo",
		@"gnFeIhhaHfZfrFwiXQKtVeRcVthfnLGWXdDlVfdYwUQlmkfdmsnfuGSmIzbTGHnmAqrDsAYnYkDTePbnrWvisQdLRjmMGEPMGvJIvDZNutiXaWrQrB",
		@"uvbYiZxlyQYaqlUfZEPilmwbZSkYvUlFvFahUsZgXVTlDWbllZDiEIMnWiWwBXgArQiRquoENyEWmUTZIpvcpaVIRNlzqxbYEjrTcQtznCAWZWCIgeGpVGsmTIeUb",
	];
	return rePjUEJwLvNEBAHA;
}

+ (nonnull NSDictionary *)bpKxuQOGAv :(nonnull NSArray *)YdGvIrHNDjdgikGbMGS {
	NSDictionary *bOgBTJovIE = @{
		@"XKRYLXSOGIvuSKMRWHr": @"jLjsncWNebkwdPXIVOCZtGMmNxYkePMZvhuYWhoTtiaEStnDOwQTPfONwmTqGVIPzxzQrGGaECbxZzevorBjevivZJdDuxykQkTGxpcRWRsDWVhyLaouAjKHFKhyPAZVbsoCZvaEq",
		@"fLcojUkFxeu": @"AkfAyAoOjdpMEKQhqLYtxcHRtnZAogxYxzgoILEBPyXxUAgfJAZfjXIXRfIKrjZYGHZCNRVJLlhWipmfDbfLhgNuumWllRdZQmdRhGaQUKwffYiG",
		@"HrZRtECtzGT": @"cFCozgWDbfEotBiXqSqesvhlucArxQFlqFTGJduxAZMrRMZHJXxvMnyURFhlBboKuHSSNrWZVmNjqCqoDWOldFwxmzifGCCpMTkV",
		@"jgqTieUhkJgDQWXcl": @"kMyBMLmtPTJpruvxPZIkjfJXvkbiKqsDyeRpooWycEghmzRPvdsXKrzGPxlLEQICgBYPCUIawelDLpxTdFTSCIUsaTXHgWMvLPhbOjCgwNQnhBQBzK",
		@"URtPDJqOGIxckDd": @"QQRNJmTQLekETKEQxtIrrloACcesGhLDDsLtFRSlHgJaRJVHDHBQGEidMGJqCeGJgIWaSjZnDMLfNPWTNlsdczWZlpciaIWKTQmYwulSiqjFkSVngiUlN",
		@"rIFRAhilUw": @"bBEYygKNnsYcwgFsLLTrREDYiPiZWjoGxdYweabWMLMTAjeemnrKfaIqQSUMoXEeggfHZiSErDnvKjYNZmIeZWPPhfwMcxYIbzbfyCUZcrjKZGVSzpKakFmGLPyrSkL",
		@"WBhqfZwMDptgur": @"OgMeLrslLgZBwrecNtJvFricXGNWmOJBWUpxGkZmzpXkWjMMZjUAfjzhyMpOsseVklkLQdLOJkdJKkUuBGbvbXDijqnhafBvngfqQiFfyxSEwCZITBFbrjpIyzZbqwStYrtW",
		@"XrdEApgPmlAKLPIl": @"JyeHZzimmfgepJmrZJyOMotOXXSimFoGyodIWOIBhDlyToSjvUAHEbOwNtdOFMLlrCyXMYFXtKDwSojMepLeWRmUXeiCFMQZpTypKhumeMIieeUTDcTuPsbKAlojJ",
		@"noEBDpwZvWmPjjz": @"XYBoAJvURMPxQpWvRkGqNknNufpHxMFzUZtQMaQrWLIpwOVuFbnmuQYwTRdNMImeFLDYAdOAHipYnoCDXXSeAVfkwCfDcFBeePHtlbNCsTtVRaNqRqPEwZIaNWchimwDAehubgPlUpf",
		@"ltmObzyVNEyxH": @"zArtAKgyysJRNXuWlMXpMYlQjHsvyyqrPHZnqzDaQRWMZTgizyWJfkgznGvTuCpubVjwAwoMsblSxTFSQtZnQYERkBWrqHSEcsPveHDkGaEgFJYOIftWDGHUEkmFjNhbMZT",
		@"XDtOZbPrsCU": @"OgvLCnENkuOUEAwLYujHyRAusspRIcgUgWUVXhJgfxtnCRKatMCzkIRoNwCEnwzCxQqImiLOxwGihLEQHJyNSiNxfyuaSthAWAKrKGKpyc",
		@"PqNJqMsjsk": @"gPfsoeoasoXPkSBqPNvrYSrdtLwMdLEmMRFJfrPGkJvJiDBoxcIdtxVtdYFIYtPuMyUugpDeIrSalWaWyKFqAkUmwvMjtLQaaXglZjrSwhSIXzeRb",
		@"IkZTnpwHCvT": @"AaIayyvLYwYMcExUTohukJLVsQTfNNbKnohGvCDcXkBXVkZprjosENafUAUAKdeVxNWLsDtvIeebEhPypuAfKPvVkZfnBVhGCTdflOLzSvqe",
		@"LuGQjyvqzAI": @"IYuoywPjbajYkngMVQusidMNWyKnqrEjYAxbniJXvIXlbkKqolVuVMkOWLYQjLCxMZgdeiILYlkmnNflTjnjZQaZmZnRRfvonswDmZVaIOMW",
	};
	return bOgBTJovIE;
}

- (nonnull NSDictionary *)NeGFqDhfKcJHaTZiG :(nonnull UIImage *)KvlNYeBnIrT {
	NSDictionary *pgkWjIMQjwuxeBdgDNh = @{
		@"KqnkPkrMwI": @"zhVyUPsfeMYzwjDAzoNGHCWRwUegPewWRnOyOIOQnCxbHzOsrzLBgrQOiZoIzTEyfmypKaYhKcIhpWWxjGDnkYKTpxudqJyOcAZjBXUrBEfWKzZVdYA",
		@"SZznEDPIGyKBpgXnI": @"UsmVbWoQeHBgrLukhFiRKXHLRrodspeKZAIdVjRcWEqNYlFivkvSKFYXpNWSlToEGnebKkVBmmabQuillDArNtMWsczdZVQDrlsPSVGuEKXle",
		@"eGWHCmUuBidxSl": @"epizDJiWRLGbfYGttjGQCzgmjHDvWpaLKEWTQeTcpnWOUjpUwBurCxFnXOPRoOItzJmNbRTafDgKOxLjaVPmTRfzCqlJojaNAYIjfGOHEIdUzOHfPfdgwzkZ",
		@"KVmSHTAaKgjGGYubX": @"LydHAktoJqMRRvbsbsoPjSRemozQbBxqzgeewGfajVlAIcEQMbWTplTIocILOfEEiGiyRIUivtrPQnIAtkYEuDCIQrrSwubWMbCGNiZYIvulQAXwfyZofTVKHtnUIWqXnYcUtuFbgSqeWXTCmK",
		@"uKfMOyGSad": @"LuTnFurPXbaJVbYrcmKjJvwqEiFctASAHXSIfUncrIOsuBzUWbzORYoRfkwXyvnFmEKRagclytamPInHAguxwKsflLvxLRnEHjRfqsrAJeFkDlIScvCnhTFqsFhcNQflYpujno",
		@"UVIDydjiNRt": @"FnduiUJfhxIFJWwKoPXkWBwauVBkZzfdGVkYMRgYzpMPigbCAksrCTqdYKlkVdhfkbCWlGNSwrLJoIVjYKqGeaSCluYSGPXjWUPknTSwhWIcUuWzGBHZGfEcIG",
		@"xHmaUHlsPnVNmUsP": @"ieenkNsmJTtLEFlJOKTYVINrNNpgnLgnYAdORRJevaDBlXiQMEXMxUoFCXbhmuiSKClUrXWsHOHncBKOEQjffRIUSMKvWgFJtyiSluUJNtYnNeKQuZk",
		@"YwsHvYWgol": @"UQvMgGuMJrbvcVyqjROCluNPveosZehagytkCgMqGjhYluDSIrecwUEHjwgBSEIiArmPsSSNjqGTpBUOdlXTraxDJjJvmaNnMvYIKE",
		@"eeHjIDXdXEsWuM": @"HWJZbMfHvPwzPRMpuilLpgGbzHYxbDcfBozIMriMwMImoxrcbMgBCssZBLVumbbTFBlwlmaPwtqptNlNqaFJYyiuWcdzImyTKOQBCGjJAoNGgpcPhBlXt",
		@"AeUVgiWWjwJDk": @"owSiscosSjyFPrKubwQuwYxFVEcQxXDxVLKLTvPNuGDuQfAvnobrrwYBzvXEjWxrKTirtmejgUpvFLtiItbHXnnweQgmDpWaaoAfagWLTgWEgbJdjAdDSixDfYlXTbikmqWMDpYmMhIaz",
		@"QXhWeakPElzRVi": @"kxIMqrwqqQYQBIAvshjxGBetPDmgKvNExhTXKuBYagzIgfZgDNGYcDGDxvqyqxnzfwdXzKlXtEUkARnXuzYOULYNovesVjFZvhEYqljJkxhjJWJEDcDKsVbhzjTlUcyjx",
		@"QitRnqmFwVKXX": @"UzyGFBkTAYxEgYPWARHPejANMxMPFafJqeNeyeCcwpMDsnhkcMlCeIArBklkcGhZHWCrabuntkIJzivwyXpWaBrSUenJYpsmecphTblgzbqtrgUgaCjdaCZk",
		@"KTJoSeAYwajA": @"rcufoMrTHvRaUPqxybWXHrFZgVYVepwJTwUkBvtjQbIuQECgnvOGkrKMviGmqttEumfphWCPkIBPxEPNUaoXMaKHnrKQcYiOFlfsNSTmckPKZyJoTaWBmILZwhBFBrOdrGJXqrwOkyfwqYp",
		@"SCqvSOUCqVRmzaJBR": @"iRsCzFKuokxMgIjvkEiQaWnMuctkYCfrfZWIDtfUJkRsCzhVJOiIzBhGxmSHIZizIpYYUpsmFyZrTcIQviCGtectBOvnewQDwTxsoXtdmYiQRakdGnRMINrzHstznePcOIsovaNYdPAdsjWNHQV",
		@"LgaJVoGdWbxsjN": @"iYjNnlbuWUeVbSovUOeweijCujtEZKqTWdMdHIcnbRAVJMuwodetpebtPFeEWfaRUOKGECgSDlGBTsephcNfcMpPrRPTPqUKtdWliqSynGEAkQIWDZgfyZqlbWBVJyoTzXBqQTQ",
		@"rJwDOksNyOxchM": @"ldRTtpqZUHcvrswVKuAMFgFjmTRceeRvYremSTQlIubqnBNrYQPQxfnACqXSbSSMxGYPjxpzdaVLQDlJyGgZjthWnnpstltCHqEYcIrZtbGrhrsbjfgimJ",
		@"AfqxiWaOMOExIoQ": @"LeaecDMGergCcqXzKtAQSbZwyglOmEjgMlxjxPkVJWXSSlsMwnhLFFBNQRQONSRzUlzQsUPDZGoNRCoIbWJdzdhWcRThbohtfRUMPXztJaSaWCzoqfCuVgDK",
	};
	return pgkWjIMQjwuxeBdgDNh;
}

+ (nonnull NSDictionary *)BdRJnYBIOvzvsMJTn :(nonnull NSString *)GbQcNbVnxGeYzFRQD :(nonnull NSDictionary *)lVROwqVLqG {
	NSDictionary *WcoALirjNH = @{
		@"NJtUnnUIWRJGownxY": @"YaLSZWSStCQEsbaqpHaZYZqMIKMmBkUptnzBhbDcxIQcGlMkrfweIOgpFFRiaYNhATllTmVGcpiWXNpuzisyjpuicdRMfGaVeyRDmToXndbrpAJDQgQuOyNBrgEkiVEj",
		@"iadjYEMEdoe": @"VFcxSrxzxOqAZTzmyotvwzGJYQEAYaTUuoBfQYOXYiCJjPJDgcqXFzFyJxIDonSjTBaasNKeVnOWCSMyNvdpAkkmNQwoVqFQHCIcLEbSDwELGLjhWlBtfzWNHsVIhvYwunSmFeiRqTILakkqdg",
		@"LHRrZFOropJb": @"waWuVxesDFHxgagZcawFiFHMByVbHRTLsrlmKBKxmYCdJNoRFRUqyMrCsRHjWwVyfiOGOEVXWgMnxWRglVKeqNbBaBjRbwSuyMalzYMpLPVcHlKIHJGhjZAEOqdZHfLNtLrj",
		@"BvKzSAwGAajC": @"WFYwKaMgWjLrnnfvnseyAjsFpKgsMsbrQKdzDHDUgRsRQrFywjMDRgyNiSmOSXxcOPCDGRNFbvdjhxeKHfKiqPYYPZDgllJezHRZKBXyQUiaNUNrPKIRvdQelcmIjixEYfviHZ",
		@"WQPtzuUTtKuniM": @"iNcbSWqHvsWUwYxnYWWzNkKQGDtOzkmyynzKXDkcnYXEwdbwXYBEjflBpxSlMVkZcRXLlHZTfneBfvUxiieujyBUqlQeDNaZpgbzwsUNMHJbZoPm",
		@"NwznSsZdajn": @"XRefQejKoDxLbcmMJAhZHgLmrpZVtOOQdncIFrRwGVQszNWbxZympsKjtYcqpLAgorBEZYrvQsfzrxclDmbuEwjmHjcLystmVwHFDoZOVYDeCVgbzgnuEQGfuiVyA",
		@"ewqbFsGQkyOmnHrVht": @"PQZEERqfZBmUeGZHdxeAEVnIgSuoMZAZEwpubBzyQwKQKLfytSZtlYsPqMLoaznXMRqOrXzYqKnGIkYGVyTVkhPPhZlpbSgQHmsSBJGkUwXCUli",
		@"JkGExLHEwqCQnRm": @"PtItjGiiKkGrlzqwrtrgvNCAuyjhgkpxfdhkNCQcyrkOMbvulMpSJsEKjsKrpxFRFujpjyqsUKvIvuzFwFbeBtpQzEslncHiRZBZYnvfbwAPPbbBbPxIwWeUuHxASqaFhwMaGdLPCvucKuAd",
		@"CzBhCOKkrPiYQZpSRQg": @"fFUpvRVRgEjmPhPzBWMxWzFJtPTAJQmykLNcEsLZSGyBCSSQmXPHYRdDITZOBkBXPEELxqduoaIXZnLtHemYyGZiDnCPuFjCRjhvijNcQGySdZzHRSeyVAbfYGIkddbKkKq",
		@"YdTOLfSwNWHgNqw": @"QeUSfKnAAdAecldozZFFKtXJhuJUCGvtKfibKqFXrpCxmNcVcyjsRyzzwAEcrRVIutSEQzoCQbWOgLYxNlRtxQgRJHquTiVXkpQFEKfnHffSaBGaswbhXMSryfQCiSjudKgRQcDBcFmN",
		@"WFfcTyDIHkm": @"mecvKIOSJTWmuVdiGgslDqyExIylqBCOMxgvwiObIlqjudjvSDoyxSVODbyDwEARdRsZTQVCBufXRJkmAowSJedEoYSbYajjELBrZYCWSEXUQonbFRVprnLBJnIGNyLsrAuXJrQPNqFaWim",
		@"NWzIRoSiPnn": @"PlAidjwszYftVYisXnNuaqKMXsDdxcmygIjefcbPTdebTlkxOrmTRDnWIAOCXmEYiWDGaobEwAMZMMylRvvQrFxTEJojmGqPMlLvAgNTxIXJFkjRrVMMkdhlbeNaRqCXSnhXXXsZynmJHJGJPBPCC",
		@"zOWiVDhtegLenQRXgl": @"BdPHDiTIVjqRBImWGGUPyFwjGsaLSToOtqOanmKXjqnuHMsnYXegGMysMdzWJsNYWZEUsmLiFmzZlnTsCqjSJLbzRYVcgWEpNbezVMzvfKpNApfMxMDytFwvnaEER",
		@"HeuQYgWvaQlwMk": @"RTlgBhWaRPPYRZSaQyyEUOhZwTAZFsIwEAmTZlyclUJIhumPRTdQyMwaxdKmuWPGCnPTYInONeppfLZbDoOjnAYlQgAexQecYEvPU",
	};
	return WcoALirjNH;
}

- (nonnull UIImage *)CZmpOevhzOrt :(nonnull NSArray *)uPyaSQDYKSArpPhqyis {
	NSData *UtAfonKCFipme = [@"eELXNQJNcGxqKEcxvyAKcWNMIGAdIRQLDppxGoRZxIGTbaiOaYSrRrskMTmHVXcwBHyMCZOfuWcuhKJjWsvTPoibNITkYfIBqJKruhzfmFkomZHaXPkMZrWvIuDxHIHuMps" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *QZykyGwKpsVRwuokpG = [UIImage imageWithData:UtAfonKCFipme];
	QZykyGwKpsVRwuokpG = [UIImage imageNamed:@"RufRkNkKsoZrqVsqQRMFSMFNGskGiBYmhdGZeWatnFgaxCnTngepNKFuTTkEJWwCriZjihYzMyGMBZskQnONgQZsBDsLUQtIlUaeLjVgWFOEQBNuFvomlcDJEXBTyAaKgVUbQEXlsxCpJXvIUWu"];
	return QZykyGwKpsVRwuokpG;
}

- (nonnull UIImage *)MkwiLRFMnd :(nonnull NSString *)jGDwABKPqVTWk :(nonnull NSDictionary *)dWYcdeVyfYjLTV :(nonnull NSString *)msbfPPLMhAVWSr {
	NSData *iSsfDfOBdv = [@"KkbzCQCJCTAsZSzcYZheWvdgsUbCTehHwRYNzsWUgTkOXzJxXXgAIKkqBYemwEJYjkeqQekHQaSTxdULZtxHeHsOOCAwYKvKgmnkikPuZplDNTtrx" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *yGecSUTOmm = [UIImage imageWithData:iSsfDfOBdv];
	yGecSUTOmm = [UIImage imageNamed:@"vtQEzntfxHsnOAZvisiEueTPMsGAmVOnQStcReWeTSBBkiclFfGqpJKSdyKxTaKrsXfaAqEkRKspMToknQKCkMdKGjPRssgMznfPFIGhSdqIaqWTJJBmuoiKLqsnndIMVtFztwOexjIZGbjGxhP"];
	return yGecSUTOmm;
}

+ (nonnull NSData *)WCLjZvwSreL :(nonnull NSDictionary *)myNCnpXVvoSVZvbE {
	NSData *VbeiWvtlLwkiplqFR = [@"yOWvKjOMxOGfKuNsHXfVIfvavfTYlAiDKjwGzWmMMXKTFbTkrBJkVJfgHkEPYPktGgygsyWwOnYZyVIXcGgpBTxphceiOEPisloPOhmlCXAyXUZHHNoyygwaUXmblbMtrBRcJWaFOvL" dataUsingEncoding:NSUTF8StringEncoding];
	return VbeiWvtlLwkiplqFR;
}

- (nonnull NSData *)DlYdGJPUgOiyQyHJ :(nonnull NSData *)lcDTIDOtPUDJNAqY {
	NSData *qcODGzOaYiITwN = [@"KeikVdKIiZgxBGoeAMGnXgIBBROXlqZSPBdoygPWGGGjVFvYBAUaNOIrjelPleDhskBDXKdzHDxCwZtccusgzjoBecPuiBpFVMvAUiJaAFsuzKqJYBbcILIAzozeMyvhdEIJcR" dataUsingEncoding:NSUTF8StringEncoding];
	return qcODGzOaYiITwN;
}

- (nonnull NSArray *)mOiVnGyDKJKVawgFVOJ :(nonnull UIImage *)GqhrFxLLJfcRtECLH {
	NSArray *CkSPBNQcmxTCFuTKT = @[
		@"JwCxzuzZhREWkxznKSYInhQQbERnjzUuOPWShKZwPTlKSgBXSnAqBNeQnrBwmqtVsXKrLfLQiFMZFyCkYmzmncyEzwwCRPcsJRRCBunFCezvBq",
		@"nwbAvdttyFBSrNGpnyBtOpIImJVFrcSrzpxKRHImdOYxPszwnuFitCoEGwiFYUUSXhvNyfxrFWyKjMVxdBgADcKnlSzMIxwCKvEhxkFhkQqtwwwPcyLRYAfokeZGJPwdwTuOM",
		@"owXGzTgelAZQYxjnHVuXDsRzuWetPKpHRbKKUYDsTShiieMFHyxnzjLousEkNAsUHXoTlcOHpoWYejSHozAlbRIDeMeNXSjKCzEkiWXAQJkLLbGgivxUjPmAow",
		@"PXCfvsYANqSiPrwcWWwAlYeEMaFEnpPtyQddpVjbJaZgOUSZSBbFEYbajunpvkywJuqmVUfzaqiWRXnSpoOKPsCikORbtkVPnxXygnsjYfkAvUGtJ",
		@"zpDUBznovZqVNHEZCtsmFOlbGcshJXfrmJsQvptDNZJZAKNEvpwmLeTCtisAWgDSrbSKykYVkvTcGwdLOogONvdupFBHogLVquHITceYoINPofKibMHNQdntI",
		@"NfWRBGKAAyHbizrNTCWisXhHVJmkxNNvQZXsFUbcvLqavKPuHAofGWFvaTNqWuZRTvpCLqSQtvgriGJtPVaxIliUwqoSbIBNmAEnYxkqRuSbjaUxweJwwAiOzHoyIAXmuGlFIqJLKTzkK",
		@"MkxcvAIFEuVEZcKKJbRIPpwOvgSXitZcPaMhbsrUKOzYZKTAKwndxrnoGEVuyEEwvyLjQMBNteUWLTUJCOpPuNOkEWuSXNfWYyCIicqZLwfAFXHbRUQENlyEPjRaAd",
		@"hJCnvqiPbDNPufurmjVhjoZzIVBCBJWVvIjXkGhxNUJhECpnRJqslFeuqqIWAQvssNIqtmJyyatsdvyTWuHyWXobeAyJaRDNtglNlbBbYUfamhvXRCqXKuKBHwQBoUoUWTFbCSGI",
		@"oFtgMPEMRrocXFShXfNKVdhnBpyVRhiACoqPYpUQHtqhKPcNENHyDbGQMXabesYkusfXlXhaIEpDNTjTuaXUdowWVZaKacRXpVMXDODmHOnxpDMFUTnpaus",
		@"OetPmrZKcdzsJFBXslRXrOwEKQMqcgaCpquBmZENRcWgyThbxqwptkASbMfKFrXlQIBFkUbUhaGcTDeHEcMqSjltgmmMyEWQFqZbWrWFiGerTKItWwIGxDp",
		@"RQqlTaeVxSDPmNVrlUEKotzAYSHuLvPnUVUixUKSSjMmuZDCAalOkgrickFgXCMxxyMRffEKSVCEUgrikOoYotVryaNkyoyeCcfKyufythMoKaGDotNVeJySezYRmiRXJIAQGprXVgQLEQf",
		@"rucrnbmnFZoDFUpPsXjejzcGxxEetpffxojYxhZZnaHtjRRkahHwUEMrJUseVXKGyFIkXiAHdQZAPzuDxLNzVzqxWycBhuJPjTdLOXrfevclKmCFnNzjtjebKcuxFXgQmTvsPVMU",
		@"KLQdkMEzWXgoHfvqIDxCfYcuBHhpnVtOBzyYFZixJtCSQTegNKxUsmndGBODGfuOEAPqxiefswcvMolJTrttriEySkiPsdasGVgFLswbbwGQgKFaVGpRxnxmhXbUZmITRNEf",
		@"BKNjIoJpsADWtZnWVnRWrFYqcvJtrYBfufhtrSuGzUDxSzTOdbnCYQZWsOvJsinYlvalBNpGibGdFERxzKxvFJRdKXvzHPwsjfZcbPEiNWkXpZzpMhpZlHaKOALLhticXDpKTxBHoizkXLF",
		@"THjwLwCqUnPGGljBjOeHkSNdjJHVnAovFVDHrbhEpDkYCTnSaTVtYMbIOblKpuyzEIPgtPuxCKXAUdeziRYRAcvoGNaLzGNHMYICmVHskbWDzRrSlrQgKgdWD",
		@"DDVJLvLaKcFJrHTfSfObJpxLiPqWWXxeNKUkJYeYZEundMLwhABZnZjrAjoXsqlDFKHLRUApovbiwguazMzxLnaXqUuzSnkhTLQYARIQAhktByWs",
		@"EvNEFYSeZxPwYhQXJeovpThifKUzTOqiqwjPkybUWtYISieUARzxsdVaNqRNWtXstlXQRPGAivcluVBGigOoQXnuawrERSwRpDLrKvDDJFaEDCzNoXJHnyAYzALLKZuGFWnvFQYJSIFln",
	];
	return CkSPBNQcmxTCFuTKT;
}

+ (nonnull NSString *)MNULKQcXZs :(nonnull NSData *)iZcCVIGylkIXh :(nonnull NSData *)YEFWGUnJjFGII {
	NSString *yUoTEpATEHkpKSLMalT = @"qWgBVCBHeFAOQWtDrhYkbpBvnGphAtgOSOfaQiAjpZBtKdRPxYBXCFPAdqwRsDxySJaOsZHNnWCzdaFzkEeFgeSoseOBXouUItfveVMnMBaeTP";
	return yUoTEpATEHkpKSLMalT;
}

+ (nonnull NSString *)DsmlWQZwypJgtFZsfY :(nonnull NSData *)lAJgQZYPvZKfgASnMdc :(nonnull UIImage *)QmrGlwjvkszttpiPP {
	NSString *rKfQoSXJMhbtucJSk = @"xTwWNOFMPMGqHzuSfvtyobBokibRAAUKVoOQiGqEqqYSUehUISoNhmWqigiiuRVESdofSAXvEvgtRpRfsTcLhMCjhMobCCZynbXtstqeJCKXFMxdNESDiwKASaqgyiTtzcW";
	return rKfQoSXJMhbtucJSk;
}

+ (nonnull NSDictionary *)HEjZMRsHvbnDGV :(nonnull NSString *)tJOeysnjNyWLtkdlHx {
	NSDictionary *RFxLlLhMCmAPcbq = @{
		@"MEceBCpxlCyJSQ": @"DVyRZMMcpbKqAxlioHUngMegAYDNQMgckBgVvHPyMlHZoVXWEjoFmAaLafHQuExAwIrLOkLsBAZHKnQhOmQUqwzsqbSCCycFVdxBRcjZfCrBnCpSZHIuf",
		@"wuqaTWbkxikxmAG": @"UYIbSCahfVkPqLVzNhejRPrwHxRNddjHkYptosHlmhyCXbdfIfWYaxBMRKuHlntKyGJtfiTiWgkGvlguUFdWbeqPkLIpXkHvwkMeKoqUnzoTQc",
		@"UMiiYWZhXSrlqVBXdLu": @"AFJSjMzjloCVTzKfbxYFLIamLgiTvZWmlcIwDezBeQClVAIFLkZtEvIWQeQcqxptyKqqKnwpSIQqJZdvCUoniYUsoUZneDxoxkzuRyeyFDoKERYvgehPNsrO",
		@"pSeXpHnsrNoMy": @"GWUtNOfpeAnubirCxxVEqMMsqACIIickYyEUNinQvgXytnkMDOoijFPuLLtCJfSYwJLWvumPbHbbQHrMNEAtqlOTeEjsCKvizuspFrflEKxvigwkcVvjfRnDyvW",
		@"tpsDEDlhDR": @"fYmPfQgShaGAPptfYKbIEyelrxHHSYnFucRuBhTFzOklYqhZTlcWUCBRuguqrGLdDJPoAfqrQwXYLOslHeveiinGRyeqEXzJnBYBhRRtEPBGrgDYzQmXjusjOGQUjdsygyb",
		@"aNiTNqxYxqzEJilbrRG": @"xObGBtsOlpZGYGPCXdhjrXxBrOXKnXDlzgiiMBkNotzmsfPwVCQKSNcseqEfzQAOEqjoNuQCaEQQfvGkUZlfkcCrEysMPnewQpwadSmbstfOfteGWlV",
		@"DxMvoshsVGnSilfA": @"LIvtUFcUcIPWNrPZxtxekLJjqfDgbeSrKDjDkbQBoxPqVNHBdTbVmvXstWKUlEAAMFmxvGrzgLjhaNHQrzKtdhMbRTVWwKqdHWuaiCKLGBtSjkQQGcfgUGTRyRzolrzoZAztkcplWsXcncxnJEeAV",
		@"SvEWutQJdJQm": @"etzFBVuQHFIVasthzTSIGWAtWKeNsacvEWmUpcENoEjAiWMiBaPbVypGGkBROzGeHxgXqjxeIdGsQxsWWcrpiniaDFBLqdcyfywLzuouQLxWxWKVcWVNIpbWduZIdwP",
		@"LrHCICpqoVDpIfoqFG": @"uMQOHsTgkGSkNqofESotutjphjMXvFzAVBaSTFYEYcganIEvNzoEIBgUqxyxNTcPDhqbzcQIMemNmOhZmuhLPcjedroMzzithwOgNFNNDHuugcZcfwuHfMXdzeknzhzpOU",
		@"kciUlRyJPP": @"fqjImKpXUNcUMsgupnwlPmRsWPtTTXmTGesQkJGqPfcvyKENmlpJcBvjLsAZAKegrfmaMCtyBZpSUpJHVEsqmBHRjWCBIETjxtjgyiZobVKynFHIsFMoSrwulBslPRankdW",
		@"fraNCHOGWVn": @"ztyAFdDagDmabtgmwjYAudCSODliTJbdrAMsgGWhYwiEtTeiwXITGsZFNAgMKPpHXXuyVHGhdcefftPeqPCWdmbWZTncHLuHMyhTT",
		@"ifTyXZfnrUyxAD": @"RVFXYHwYOmsixnaOGdKWflrjCLhVkGdMnfTUTroHVXEDVFDpsBoXpigsQmNTLQdGGprlaYmaSBzFpUKgIFhZLlTPFHZrvHZFcjTR",
		@"kSjBzeFteJmxz": @"jPbdbLvfeulSbafSZUDoTUrEhANLBGouWufOiEHmaAgDdgrdKolYEwUIDoeRTXcAJuBuxaMGATCSlhBddSQqZqHHXzPZjGmdfrDmfvKKK",
		@"ZEcsWuNosnPKSsIie": @"XJHLcEZnEERKyBILhNDnrcYWggGebqEDxLdRKVKDxuXaeAwDZhyGHGkOvonBMdxkVxzpsYyQsDRkzbAOhnbISdmXZiZJoAvFoftDVaimtYpGOaA",
		@"zvANgchicdKjvGXDDn": @"alZgSXQnQCETZAYjKZWpAzrHXjovVuJXwxPyUzJPHIavNwaxuopzVZDkYHchmqFngugYzPFHFgnTMZhenGbcarOCxxYXnyqgnLydnqRUcNAlfCDwRtWWmMVZxQeNJaEGDvXOGdx",
		@"zwXDNOGZlJYpWR": @"UdAAXTVBUvxGrvwIJogkJQATFTVuXbBWaNvfkPMnETNeuUkOcYzKyzrxvcfHKMIxWlljMIBxpfugHMuqEIBjTxYHITYLKaUVedEDkllTeDzCwkzbnMQKQrVCjuYnNeZVR",
	};
	return RFxLlLhMCmAPcbq;
}

+ (nonnull UIImage *)IoKiGrdkgtWGAnuqlG :(nonnull NSArray *)eDLBANMbhExBl :(nonnull NSArray *)pfTHVgMtLDCbRUvcvK :(nonnull NSString *)RYmRgcGDDOKNEQdYi {
	NSData *gmnsiVKqsVKmK = [@"RTVZyrPEYOIiUAopRieyGFMPptIhFwErnDMLAYkUThwioEtHkAPfBpTGEcapcoMXINblUITzCTbiGyrwneHCBsYbkkpqtXApBMYvDnkhbyqkOzOyAHcLCLNgykKKzQrfnHX" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *zGjvAbHDodIthSsf = [UIImage imageWithData:gmnsiVKqsVKmK];
	zGjvAbHDodIthSsf = [UIImage imageNamed:@"VRqCJOAjsAdmZuLLxGmMioFRnAPuXMDwxvxoFtLSuitqylSYBzBCuPLvIfbOUjnggEtuHfvfeZnHHWDQsyxbvrTDMQlYZDtqsbyQUSCTczzuVmggpAzkxeLdkdwfJXMOsbIwjfOGRUVbLVy"];
	return zGjvAbHDodIthSsf;
}

- (nonnull NSDictionary *)SzhXwlgaNwcOdbkx :(nonnull NSString *)QbvRhDcKIsOW :(nonnull NSDictionary *)LRNVvlZsHdSTXFd {
	NSDictionary *awMxkNTVOKEw = @{
		@"tlROkqRpRmxaP": @"DIQZeXQklohoYhIcOygcSNnwlTkwdEPbRonzlrifplXSfFeHlXZrdkimBZZWBkZMjCfWqRiRpEbvObafkpRTbvpKrAUHZutZusUwQtGbRklxKoKuc",
		@"PEosZGIouGt": @"OMlViknrREJjeMhWKAjiljWMIdcvZGnBMfHGDWNQykuFRryvkHMbhdogVmbTsxgwLQfUxFLJSVRHVGupjgcyuZVRLAscRPRADrnliLIQAdQtOhCZmqZymmHcrRgkUFV",
		@"uBKulhdeYSzMavY": @"uapQUOZWxNXYhLabspirpaHuYacQljtpAUXRUjBwKlsfmlKazwXeJSdPYEVNYACDCwICYZLLSGxzUEMTCIuXjRYKEgsyZlCCoUqiJvrNDSUZXoynIyyNbksxEVEvFZLAozORfY",
		@"jrStrkUSmvbLQf": @"ngZamBMwtcJCfWSQYHVhlecKdOeHTGAuToiqrizsnmxntBDoCSQKPUtleiXVAlDjYZRXoUleDliVEGZnkHJZzMWTvlZdJfTkXqCiQUdKolFNaL",
		@"pdVYdGDBYRgFMLLbAtN": @"TBCsFCZlUUqaHFhhOZGqQWISLpEILDUHeIQlHPwlWovpMJSLekNdKPAYzaYgOHRlxfWpHJZligXqJrnmpqKhEEQjOOEirChfrYBsRLrIuJEwmzaTMfYM",
		@"rAqKLvicYz": @"HpPuiASZKDmQQwHUchTqXDKhBcqPKaYMrfnddAxdYAQRDWPhVgiASQWBSRpCwGwRiRDKZwndDmbqyJAMvoyAMQXkEfYPkeArBvtpBmwgEsgwDcaaiWpvfxYDzbPjLgky",
		@"dtmrRknCxHFKjyKe": @"PbfDySQPElwWCzYYJyRyBezcdITnhstNLGStlMozMenUCGKYFZIyAhWOcyupYdfLMriMlqOIVQWlsCxtFpXjAtuJVMwlmTMOWHAQSTvuVzJHNJVyAuWHBHWl",
		@"XdkLNfznuA": @"OXxSbayslgXEpdJQRMUwxzaWfRrztZEcAHAnHjSBbVonZtKqKHsrFADunJthdOuKiNeabJvEclhdGVbeAzexzlyZuvUhRQqLFemJVulRoZkyYYyGRiewhlkpaLEjRIfGSlWHIWRuqbe",
		@"cjByNujNuHVuA": @"CKtPMSYNEIOwDVwgSQnvwvApLLeOUWXisDGOlumSBkpkWdaiWIQhxIksnAhWICrFHNwPYsXXpLBtqngemSOMJtdrcCjzakhIVSLjWrKWJhwgPFL",
		@"qtFKLUoLojgknjObTBb": @"tPNElWjzDQWZZVfFXEIMBDpcMoWnwhFotUzDxTWhvOOPdBakyvgtsrauHEWOZXxuRkXPyRhMUVAbONVZmSyQqsNDbIAbQWYpKADubhoJBjrdxmCSZnNsOZQEPHdYYJzsDGUYCaLvyvvwuAEEdyr",
		@"fuyUpxAAyZAhHCWneTL": @"hKPVwXlObQtLGjOQrPGLuArfvFcTojREFgTxKOIDyNcVffDQUWSySxjqWrnzjYOrZSBxaRyFxCiQiFAobeugOfNJrkdwtvtIbwwVrnKTRTyElTqGsEpFpBWqVDKlIEU",
		@"GgHsWFLIwxgwcbqxYPp": @"gLcPrmkOXMDQspFQZGoPLXjNRcCVweUgTbmMUwDghsJtYHQixIHyFBoCETlLSirzANOLhpjZSERfaRbXeRLDISDkdernjBcbMiXnQHGdzNnOSheEQrLnrOGeQmYNYlsMZBUHrHqmCzjisau",
		@"EkTDPpIxidOwFCVnyO": @"lfxbpKfntbpdqjTmiueAbJpWkvSxfENKIrPpFXsMTuPxLiaYhSwHFWDNFWVxeLNGPUbZyTDycjOSquTTARkTaPBIuKpVLtCRCFOgzRsygkayclqjYqizaJKlh",
	};
	return awMxkNTVOKEw;
}

+ (nonnull UIImage *)TOEANvIREjzVFIPujWU :(nonnull NSString *)BcfEIXNTYRyilTJsFyB {
	NSData *LnflvqjBUzSQIIoj = [@"CrrfTJcDuCwIoKPvfWJlFhwhGYOndEYxvGTnqNBrvbBsfqwSGKrWzuWwxwsixzclKQdPpVqgDFpznqzShYABtevemyzSbrdjTVYBubaJTLrtAuqrdWzbgdxSSQXxi" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *VLcZJKojYSWppWWIxoY = [UIImage imageWithData:LnflvqjBUzSQIIoj];
	VLcZJKojYSWppWWIxoY = [UIImage imageNamed:@"moKBhHZoeECCxZAZgAJZeTcDDwGHqzEUJxEZrGWgdNuWgkHnaoKohaQoGAiEcjKjNuzcjwEfTourbdQVcxVjvZKkYuLbEeQPzdBccfqQiEcmvlISosJtKHHAVKEdsMFFRpXogVuKcohBFjuglV"];
	return VLcZJKojYSWppWWIxoY;
}

+ (nonnull NSDictionary *)THfNKVyxIAdOgssOd :(nonnull UIImage *)SfAzWcAibHZrIUQuYQ :(nonnull NSString *)nzvnoWAyLviIrYGMYI :(nonnull NSArray *)IabriclBehIOCHnnIs {
	NSDictionary *bhvbbcpZNMVnWdsLRV = @{
		@"jOYLesvtJr": @"nnBIdbGYtLinlCgOBwjcYfRDEFvnLoVXLaJCFKImMCfigMpRuSJihlGVOGZizZQRFeqIYxgjOHjUiUklFyynbgtMacdZPfbHTlyuaASJKjXcLqLzDrAiUO",
		@"wmQTdmKTzBnBFrkpfe": @"UgsZAYEslldpCXGUUDtqtipFbBrfqsNudnsBasWGMfPsBTZSJFuyJXthIbdkQvOXjQmLNDRDARTaRmLhRlmDZMNafQZJfABGThmXOvQrUXRGasAdrgNUKAiXyqC",
		@"swKsIXdHMR": @"NitmiNeexLziDVmXwuIghATDXblmHJOdxIGWvPmBihXtzHctUIiAKWanbZSBnlIvCZksyriYkAXwZKkAenMgsAZzYvtiMNVOLXBOzNVQqhFyyNTbQO",
		@"IdmhhwBSMBkYhdHDv": @"FFNmXTpJawQHQFUGWVikvnyiXETOizGteEtrfSDcUTSoRbXLvdQCGuJWCiCIOFXUQFzswOFeCFIcuMGIDcwguzrphReHSQvCUxlIhFMKsaDHXKYHyCwVDJJ",
		@"NGvqvnvOpbvQFMXEfPs": @"NCzIEzuNGWquCWaxNfBHFrRIJdYsehxbjuwfnTgXMuLsNkAjkLkDmIeIghbszIKyDMlzZOeMZJpPndUCkYfnctsGktNylGqbksOkfjf",
		@"huqZTsuLRyN": @"MMOQfKmcQUCyUCfjJozZaVPtvnxNeBRREDwOaQuSfQcMGoKWQOrUoNrGrCrYakXkRpRwHcXMkZiBinVkvUrlAYTtopZGMlTByKDK",
		@"EuehIvpRTkcencmaYU": @"NiDPwcQNNmwDVTumRmGqtvxYOrkUdazqcXLgzeAkjorGzNdMhAprlgoloLnMWeVYjSholQUPGBJyvKGTHPOHtzJGcCcgsYebvwyRjttpGnkTXWNYu",
		@"TUSAgZGIcAPyOc": @"TTeKTzFDaemHexIFeegEVhzjnKUAAFaiigHEcWRezrAbKAYjgxjQEelNkGYCeeFNRgpRhAnKLcpWcuMOWLYGJDcOipHWFMhCwYLYvcGk",
		@"atBzFSAyQkdkxa": @"wpOSpjOunJBVVJvXWALbVzDnlmsypmgJTCaOrWufGrBWrzEatotuQQFBjQuMkfehUVLyitlSTXHSpQMcdnyiAnRUJCsmnDdMTsANdC",
		@"jZdlnqSvOpgyzvlmp": @"YnPABrvnLFswYRGLtXZZWEZAJTHCInmCmUoHixaoSOWaIJKAlYsXAmtiFbXTIAmUHQmhhRUGiyVyTjJpDwghKOQdTooCNfdUmoVoSJwGctpZutTThDbvnDZwMdVnKFgezHVNMkUsqG",
		@"rHhORZWPObf": @"YTdvqgWWvfoQhRLHXmnlXvNLBLptxKUDiojNiKnMHqJgDONFxfzMGMninoAulucfQnYkRWzSFGGpFJDydkncyMzdScMcKzrUdbdbgjKSjuJSnaErxqrOQO",
		@"bGGkMXuzdi": @"qFTJomAcxabrVcjOXCFDWaHniCuiaKKDJphQHqpJlyetUirJExJSPZbCqnWgNvnKYIKgwKCRpKwuCIYxaQklkyMcZCwLzTCcZJZrgSpiQyOFMabqZLdxbbeaxtd",
	};
	return bhvbbcpZNMVnWdsLRV;
}

+ (nonnull NSArray *)GQnRYqhCqvCXDcTNNi :(nonnull NSDictionary *)qtCoXOCjiU {
	NSArray *nWoMCTWuVLd = @[
		@"sdnnpzFvbkqwScTojexVIRGFOTpYuKcZRIXLqPFHigyrZWHlLpZVgnnufpzunThnJBnTrPyvNgrdGaTKmXWmaXMYSVKpkNGnDcVHjjZwdLiqHAXHQh",
		@"bkBzaQoYlNnUUTYXUOJjMVBFJnliJFihryoHjgdNHmSbUQsmFXLejKjuikbCZtAPDdPlkJLjGXyLslSwWXHSozoMnLicpTYRbIKypLdqZcxZwBVrHWoUCavZPzvyQO",
		@"TjCxjCRhwqGonPajrArTXuVSRLyvnuANzOiDGCKDYShOFJVOjExyXKaLtaIjCEOWpLdfFabMeqafMVGlNMcNAMQKFVzGdCUgQXdAFZvNDnZqoGcdhIYypujsISjGkOgmQezIfmxQulj",
		@"vXIWhEyEPyZPFwCBGTYzBcgHQeivBFraleSSoSXsajfUpsYBGodWdXhsimVXRvuBhbRqNunLUfmhaQVWmmkRiNWOFBGpzlYWydQtNDNsgHwKodigmWxbgpQSGuLpwPpuXGZhByTgWyYXsySksDlR",
		@"SUihKbxnuCQyqelFixIUBswpQafHgdbwDzVZYmPRmrbNkCzZVYXVpdGCHGGzcTqbNBCEGdaYiDnWcOTzVZQiNWIEzjKnjHyZWzuSIyGBVpSXiZRPloZVQgkmySyImhfOS",
		@"yGADcZrLIrJyJlAfSJoavOutyrcqsEQQTWainrsSiBNXhYthtjTskyrLYzgesxINYDBnRTjLLPxVqIMqnjtkepFUmQROXVRAdNDPjOnPcJyMAyBXkpQKUGoSAsMIUBtxnJsnAZDJKYXNZ",
		@"ZIgdkUbODMNFQUjGDhjXUCGymrlvlOfrikvgBFklfcLfGbMVLHsuQTcAgBBIJvURFwkzofWUsiBloXumHBkrXfrzhkJrVqrQIKtCVqeNoxGgezm",
		@"spoGJMEbQNhpZhQnPqHSJUMskNIWnQQOFshWaZDywcPwUtQouJJNminozoGtVQobIorCzUitiDqzoxbbvYhcrIqBtDeazazPqDxlmPZOMgIUnODPLPKq",
		@"JUbTwckdoGDfEGrxvVsZVNBgUudAJPEFQNdQhuouDzzlIrNEyxRDMRrpxgwTXXTqzhSeSDfTBkautmoWJFXclyuhBlLuGAoBKgnLMiPwdiLPFifQtZtkAadXGyJtuJdjTJUkFFEQTAyjlVOVfaa",
		@"vynWvPJOrnoBPAAGVvvZSqQWQqbKgzoIrBKOXZGAeWMssKqNKwtRlqhFmvfYrRXiorjSzSkinPykpKbjxKjSRttyFmpEfWrjVSyrtLNFTUGoMDlmjqlcZgtjMtZrcFFrYBuuebzcOpWHUwbgMw",
		@"nrVUzUHARotaWbftWBhWjvxyRMBapzLthXuEtkvIyrfQdvVlOVmPlvMEsxwdgRSMJYMSZiEHjRivAXXhgCjFHNGMEPbKxjplyAjcmVhSRVWQrADPrSomfnvdpnVrj",
		@"hDTUIQZhaIhlhhTEFACSrfhxruHccUTicaBVZLIhqBravVYGWlGAlYuyXwyQjHbBciYypSfqUsuYcsbJmmFiqOxXERxVKbEGQRHrNbHrZMiASuyprOQJnWArAWIaCWHjvUgnDO",
		@"NBNfJFwshldFuvQKTzJocxdcrNDjCeFxjZFqGIRDhSSMMbUdNykGsWwkbiFnAPDmIaUlJPeTsfKmpvHMPPBXdoJGrAciUJlnSvuPTksBbJVEUqNkqDpoNnjtjqgyrkeWNmxePCAmpaXFtD",
		@"RxHLYETzPBFfdBUQqDACAOaZGnbOWVRWFyQjCQLssZCipVDtNVZrXYrFSthzKufADPttOFIDtlvHgZeMeSzCzpWakMVVqRGrwchIXWByFbfjgehWmTHtUkgtCqd",
		@"EBbqYeYiSrYUDaBwAKwDAeOmLcuReYcULSZMamhhMcgxlDvoESaGKPmbHLMfQFFOtpEadEFDdGTfDljWYQlwrIvUDEeegiTfQqaKmhYCsHFCqcxVCXjShQdQEAwGcMeOVYeMEhXfeJIrkNdW",
		@"CxARUtpFlxrvMLwMahuqhjKULHoAwKsTIZWomgcaUfmNFQdJpRTsuhpNSFFEWAMBVUnAKnbPKUemhoFTrnLRmEYawxwosegsGLnTAlqfgVtHpANdKCAySINdimVjtPxqSHCoWtonmkCKJ",
		@"XPKowpacIQpcTRVsuXcBUzbShyubQqOGAAwqjinJzdYkFXLsoaXACbCsConuFyZdskwnGbKHckbiUzwzuSiaWpYHYacRladmTlGsWwcLmAicGOVdTxJxrOJyDHx",
		@"eKGJwYJaePcyLkNUmyBlhDZKFUquADhsrOiEhOTeMdnSbirBGOKAJSzRKRHlllXuUkjrbqRvpwrRJncZsRqbuaaJwXjgmcvGwKoFwmEMJFPcQMSyjBifaXCRlXxdkbcViykFSltjEldzYhsEA",
		@"alcOSAcZZPeJLCGRcZTEetSfvCtsDnDZzLiHmLTpayqvcxEKXgErwYqlmZSdhNppyzTMGMmWFViBCtHXMswNefGgGyyNmpJvViVHGHTxqwYsSSxZFSznLJwYpBkMMtcbRDWDWWXUx",
	];
	return nWoMCTWuVLd;
}

+ (nonnull UIImage *)GymDHUwMND :(nonnull NSData *)QhenvshCAj :(nonnull UIImage *)lgXjHpKaSMWBqhV {
	NSData *xIRJAFjDKniFNMgt = [@"cYoXsioKUYvXqYnrPFQAFQRpvSyfvFgpKvDhGusuNkASrdlxOTdslRpPAmrMgyqNUSQFYAmRKxDxFOzwyqmRmXZGTJBhbfGeMNgdoOKhWrpWFVJOuA" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *bEheeOwrFEQGzoH = [UIImage imageWithData:xIRJAFjDKniFNMgt];
	bEheeOwrFEQGzoH = [UIImage imageNamed:@"RWQvcJlobzkqvdHslJqKcEYBtcRoZUqcaJlYVnZSOOxkclvFOwbjErsjDveNFxvJLNknwwgrQHgyCEbFrbEFqWwTkGfuKBEPvbabuPqPJfyFAnGQvcxTfxBExFqZdwKKNBlwy"];
	return bEheeOwrFEQGzoH;
}

- (nonnull UIImage *)kQEBnKgTUyMmCDTQU :(nonnull NSArray *)IIDbsOsGMsgGT :(nonnull NSData *)WDnNkMevJVogW {
	NSData *IEWVZoqHMrzbjYatCnL = [@"NHcaeFBpRPfKNEEzOOLjQUQSEbdsnimqgpKqgtkehTnvYOmyQSwChejZKAkcSMgoGaKLLAWTdSTfeLmNJOlfvDyzFSrHiNQxEyiWxOLgRRIkanuCwhJ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *UfWTvlJxLQKwbV = [UIImage imageWithData:IEWVZoqHMrzbjYatCnL];
	UfWTvlJxLQKwbV = [UIImage imageNamed:@"JtxefTHoDyRTqfPxzbTaBbCLPcqHcenxqPTSchYCXBaCeoLaajMUypwtSxACMGdABNaGBWkscdcRqOwiiasSoLOYtORbFwhcwhCnvHiQMZcIDHiltYLupfZmsucZbKAzM"];
	return UfWTvlJxLQKwbV;
}

- (nonnull NSDictionary *)YCGErrVwmJDFvyLQVG :(nonnull UIImage *)FsAgYALfDPAluHaG :(nonnull NSString *)jVTyMfAGGTtlY :(nonnull NSData *)UENooTEVbOVG {
	NSDictionary *sWRaAGkHyCXDNVCadPb = @{
		@"OKlKALJgFYaTwhqfn": @"PPOYCctnzUYLLshcmImeZmIadbnznQhbtiLvvmQZIpagYNhewzvWlfVTdYvDjbdapjxqIixezZsjxSBdFTXilhHTLDSGetPvAkcrXjujUsgrDpRLDesMCnQcGZdTAWxEumOOsYqJTMziSefKzf",
		@"FNReSLuLTM": @"zROrlgRbuCuYkYvnpyblFMaKACYSBSTsFtpsRAOqDOHeNUtgrLOkdsDjFTMkonOmDYhZCFVVctprOibDdyzOOdOCkYinxFlVrTOEhyFIGYHUbpjeYYCeRXDihMS",
		@"axOKTrBhnTTftumXH": @"adhTWgcORAthNMmexIIEUmNltDIfFyBefqaNGbFvkKZeywVwfYKYZSIsaDtblSdCjAyLbLGZAYbXOgIbpzhzEXYkaScTJbaIbtaJmRMxiIvtbccJyboydfjXRuteyBeKpukYgDORnmEnQsunUZHn",
		@"SwyBYbprqgnUxwlIQn": @"LYZeNJViUMyqwmzReSkmZitObBvpEOdslgFQfTEcUymFKRjxSWNfGAyMeVmJSWjLADXyMUrUmFiILvixxDfuOQylIcPBaHhsOebEvSCzdDtAAjtqAZYHCSSflPOWyOgFatLQSUAMTOtVICssJzS",
		@"rwUdENEvSWPxJ": @"sxZabjkHOkOyHKmGhBYvjyVIqgmRSQSjHTIFpryeofbQfeFpzppIjyXKrSsFtKPbyCGrYtkrIZqyMRXydBLSakEKSCVbaIPsPLlpPGGGqUZd",
		@"gjRwmpTMiLphRgFZrm": @"QmlTOScNalABMsCGrZLCqknOoNKMuNAoZnbxgUnImwDjAfDbdhEnsGktKYzVCuFWZcmDFNnKShHBCJrftOMkDBPhtNJUxzAhtmkhMKJSTCDsAoItHwWMVUYPOPPxOPJCnYSdJrTbOYIuOzUbg",
		@"SavycqbSiOLMO": @"zOExYbFpPxxFeTaGwGONQyqoCdmsTfqVhpXUWpybSnYWuVrcRaqmDfuAJJEiYtLAXviFsQnnNtvwFAcymNrqpKryTQtuNGeoiJwsjErxfOcDSLKkjKtenaHQXzXQItTNLBdpxLbd",
		@"qrsttQRlksWrd": @"fodxZLBbGpXizXgmInTbXNVfQMBowMdjgTSUWCnOjjcSaqcRNiFWjuLSmQSHuqRUfOhenAMXvpELVBYEZxAZcgZDbPwsuwbgGdcmPxidlTzbmOuToNBtAiNhW",
		@"XNNKVEtUSDQDnAfo": @"UiksvNJEbxbmBdjMPThJejWPIFGPZvhDKJXYFdTzoZAvJZDdHwXmbWNIhcerLFrCSWBbeWIBhfUfUtAuHsKbCWAQAZIUEgcXWvKbrnmGLFNQEvl",
		@"TrbfWGfXEptYwT": @"nNQrGVwbMcbvEoxcCkRBpntQPdspoBsuCnPIiXoVZcWUNXxBLhSmeERsxmBbvssKCxReAIdlDuBQvLuhriPCKMinJhQDDwKCjbBQfHUYjehKNDDsBUcGphNOCFc",
		@"GcfzVQwXexhl": @"nhAJDfclOiksHrezBbEnCpXsfxEqYmhbYqGjdyaHdhROHcLoMLkheUyKUYseHHBMHDTBvRppttZAPQtbicRIvymbxdIrTcgTvgjdQQmx",
		@"cnMFycZCaekdGpZg": @"YCThDQcHOSDXKjmskKngllfWTnkNISXUrqdGHYfzNhFJkaWpkefYeClvIXZwuJDDzdaaZtPgKcGFzgKDxjMKiFUxMGDmjhsQJcytibvHHhamWSZrSevflSrPaVnSZxfMVBzMJZKJsXtzsjcIgPaRX",
		@"XGPXDEsdpzJueyglVE": @"VtEhRbfGpKChThgAyGmZBIvJKtSrEtImDqHGLXqUdKBWnQJtWsodIfvRSVCLNdeeyEGJdHTwhurpnCkNAaswFxJsAAGEsAZrBJpKmIDyz",
		@"XnLiLFAlyQ": @"LkmOhqGGMaMiZYwglsjpCQTYZSVtPOaYDFybXAulJDSgOAGExGgBMKrmnzrFOoLkkFnkvtweIBlpPVfGDyNSXEoecfBWzPKHeOIWIyJgQBOkc",
		@"WHlZVsouVZyNul": @"rZmkhPvuCNfCYrwXaxNYxvRgnIiMYZfEvqPHWXcrbXylgIjZrRTwpPImMRuZfOITSCvjBmSZceIPYgoeVEwqXFLJctWZWahmzBivRurhaOfWKwDZltYEOjwcjRaKNKPxcyVqxBDqqlnd",
		@"XQdFNPatzaCTC": @"xEejnLHrAvcPXvKyoUcPcQuMFLzIwovooKxPymPczKkduOKWwKTWLEUXJWwEYyPXoUzvhbRVCBlyupShgZzbvRMzknnHMuHSvOyTdQMkccWPgzHGgLwssUuSNcXFyOvQIeungNyxElrNumeAZwwZK",
		@"kaWlZtPhskpvUTFg": @"xSgVSxmOGcASGAIoQfeynkGMuyWolYsCGkcUluaYgOsEndAnWngtFmFqtiRlcgMWnJpKEiNktqWYkkiOmEBZYXqZcLMSEAyzPCUpWLgalwOsGmOBzrYErQBRzLvinhZckw",
		@"paQAGavbenifP": @"DPGhrGqfFKEqIlorJcVafjvPYdCsCJubpwYNJgfNgTYxMoxwJYmxdHhTFzeONspFlqXcKzdaaQDHtoapnIPWQaFjSKxOqMLYqVfixFyterYTTPFljI",
	};
	return sWRaAGkHyCXDNVCadPb;
}

+ (nonnull NSDictionary *)KwZXlcEhlzPhkACHQ :(nonnull NSString *)TfQXgBuMvxGFEBHfnub :(nonnull NSData *)lTeYeEzbnKEgtUPyF {
	NSDictionary *pLlohfKnffPvbhOPMWB = @{
		@"lCxoxUjqqdbDOBgRcU": @"hNQSvUaTXwmhgbzKQkzlpxFSREHAQCQXzUGzpsUyPjxGJpVDYhknGZNXIvHFbRtPZJcbfQMSfChrrZzZDzKNJZSvRapsKjuotNEtWduZUvoFgKjKtEYyiNChgSE",
		@"aGYiXejPqtrx": @"hIdcJpYHZAicOyCnbyexhkFtfrZcWPInVWgEGTrylltIQtwDigodEDUcnzAYAvcoHprxrfkgAFhNBpwrWSaGlwRxioMCSkJwEHoPZcXaaqkpIGNQKYJddBSlRkFxZl",
		@"HSGVqfEsyAmEq": @"knnoQiJDBssDVfIEiqptajDEARQIwCThVdMoNzkXofDMZfFDNdkrleItvYMqaOZZHaMMtzbndbXQAXFIfLGeBHbreOAYWipkYjBFRjHQrPIAbapdaeGaFfnNrylrHldvGPfBQ",
		@"plDAaLUpityuYXl": @"gfpbzlhDXYrpFhMqPMsiofErpxNUBRIoRDhwrybcUcNVdzRqacAPLwcRbWVuuJbxJUzNiLmoyQvonxncJTgBSNDFlSSIaEqQXoHIlwAaQUBVuPINpFPCewyVOKEhmWtvjNJZiYPWWPzlvGtc",
		@"FLcotAexwuqs": @"NgXPDnUejvKXCEarudqJgggMiMohqYcaVBmDEvbyOLJBaUngfClyOfGsSLTwKrNksfEHhsGHOIwNknwmfshFlWrXDqKozkwmHaUOHPYPPjcUezjs",
		@"GSDuvBUONU": @"fqFlFwwemqltUjGdJjQqLZGFRwyjQgHQiqCFPWzgDPRMKginRmZKgiltgMxBjEYEoqRjZLBpdrrNoLYfWYtMsbXefqwFAcSghBjsdkemtMiSkxFleLbq",
		@"LIrmiyXIDGTloIMBR": @"OdNYHmssajaLvYQXSXmZgsnMKiIZPFDvevQnkyTIzuESRujNWycisrdTTThCIFrUQlNNGMEunTFIphBcJefPOwWfRBcaDNnnfmeDQFR",
		@"QSLyfijtFDKbT": @"WWDoSLQTYgSrEyUXkcONQvsUPoKZaTuWkunuQlgYMvCTRleYNooclKBujuWQFpPtqPhBsnQDaXaMTQzTQGbOgiRspHsqpLqbiZSCMeYRTqGDhQNHQiT",
		@"USGFSScIZja": @"WFFEtDEoygTMsDchIuLJefyzzHvEFwnIgFBBZaDdJLHxmhtRRYEuFzzUrmkbIlqGXcHPPsXUcHubtbvwUYLSUrNjlKtwNHmOJnKcXyQMKKbXppuTkwPxuNpfnUFarRoRKJoNoZcD",
		@"RtYoGQWjPJPQFIAY": @"ukfHeYbahvknkrBCGWGvwBSpwugEyfQIsFWxcPxMBdClIoayqzovyXRVeStAhmwEuHHGdhHJYgseISWotIcjwsiGMGmmuuaNpFLOTAmNoOFgvUyvFqcYqHANIXIk",
		@"wsAKOnZAkDsMJyOHiU": @"HtcVtVHbYfaxZQoWZXNyvVIfjBTPRAemoUpNGNJVlbuLbtZDleQVvKlXotcLSsuDRXEMqXIlDFbiHxrOoNoBFnJSNANggUruhUynLIGqOCBmorEnGjaBYBbuC",
		@"tyoKaBEDfdESWk": @"CrUbvsFtKHEBEakDFdpVTRRhmzDotvtpTlyoGriQfqmvWsKuuViaqekHOPrqNIMDdWKPcUyGXcQlfITCbWiqZJySbyVbumzUQXJRvXkSOiDtANB",
	};
	return pLlohfKnffPvbhOPMWB;
}

+ (nonnull NSDictionary *)mHFCufLueFbEseuwE :(nonnull NSData *)jLIahiRlRGGV :(nonnull NSDictionary *)DEnEexmpNpFWjJw {
	NSDictionary *ZqAsCdDQCpFMabMm = @{
		@"VjlDzixnfvrfNzMFv": @"zzzjNnfeGxzjtkItSKpuJKtXLnlqkHKVRsUUfWhIdKtWaVGRQFhiqAojQlmnXzUIkCFctgLZLbsZKUFVbibaaxiLoAdOJVTeWYGiHapJlNLrJDrmkHpQfYkQqpgyqxBEYqLeHPMNLYvkZVQbpP",
		@"tRnHqjBHmfWkob": @"EmVFoqraqmSQkZdmBDAzjxGPkAOPvIqFlTDEoIMVjUGqtKqWIVYdHzsWlGfdGTGOhqszMcwwXwkzlxKkuTdevFWrlYKiTaOWpTNkmqrCcvQkRSWGJemRNIUWYwbNNcXMZcREZtfsQqaLGeTrMP",
		@"LoxkjacewQeKKdAxsmO": @"IyIwqWHSyZRDIztgTaQQRSfGyUSXVupYuqzbTSNYAYvhCMFJipMRhMUfXELFkESUHKmReIFTmOuByqdIdliaPZCddFBHILnKxJwhsFwAItjPFxRPABUnEuOZqSyRSRItrHOSgNe",
		@"JuZRqsTHynzmDUdkPFm": @"CribqtJfIKbPadzbduCYLUOPDzNNxDLeCNPlykElkZkbbeRWtxRwOeeNCzLCcmLsvNhEJPuuOAjcajWhqRQPmNYAxPGvMfTXUjfeOUogDlcQBQlKxtbdwbfoJdnEtoNORTF",
		@"XptzNZwaUaBuoJFEVY": @"LRataOknSocAVBFCyJCYtxxGGYBEAwiLRyWjXIAgPvYudMXxTmxHFkNbSdqvcXJOtgrIWiMdCdUYiNvbxdebpHSFIrANxEDUFPhgaveBHubQRNrHAEDAuPZw",
		@"NfxhZdUPhrLkSOWAxDX": @"rWyznVFNEMHoYXHbgYgsUojwItpJLwwMqgvjXHMimsIBmfuimVXDtXEcOXioqVRhajrpGEvEjNQqaBZLwACmzNDZIuINIVsQoTWUV",
		@"SeCSuDRovH": @"CIMwEYIsOCNzrmDXOVATfjqtAbBfRgFIpXcBXaJtbgLyNoEGuLNDSGDbidmWyMAkMkonMNCilOmYCFZpQXVwpXHBGpIJtMEGQvjhgrMcNplSJQRbWnJMavAigWWmyfEsNrUTvUcu",
		@"yrXltUiIaecZCsEGp": @"amwlebAyvlsBeHoXasAHqcmBJQPSkqWaxiYngJuirYyIwnlUYiEgvatjxxpZalpnOAybQqBYBwAeqMdGyijfSRizTdIDgLRrGRePNS",
		@"AxiUnQGxtiOrpONyDa": @"CkXGPYcqYQsveStVDelAJcFamcHUanPiOjMbjpWYXIxeYrxXMapCGRDoJyDFDhvTltdXmJWXEvmHlWtYXFjcZylmMLmKzgXEJfwUjoBEcixpDtrwHTMUEENVKfEtHAhGBm",
		@"dMErGoVwVHnrBqt": @"ODMjBiohTpgBCShJSEcBZTgpTGhVreadmsPCjYzuAJHNBszyWEYFxVAitLUTQNIfBUsMOePinIdSdfzUZKjBqYMXSzRUtbKPoCeMuPPOgjHhXsAhQpJmdjttoCXqyeyS",
		@"DBfLiacNdCxIwrC": @"CWHvuDTzgxWqNHWICvMnGopHJhVlpqYGvDmALiqmHcpQhVErwVqFcJmpSjSxueZwLlmUnCKEaRXTvleXNikgbeDBxRGozHkCvrnvgDwaGqzEtVapiMWsVenXAsURJwAAOTiwVkzlLLQNAC",
		@"tFoQMUBnwGO": @"callWcFtCqBiUlGsBQpOArZTtSYMSjqCiZGQToFGOkirseuZePxASQAWnnPrsajUhypViZlAiNLkVXCqCMgkisPCveWjKKuwUmKXJhEqwDfjOvUuHnAZgPdXVephbktn",
	};
	return ZqAsCdDQCpFMabMm;
}

- (nonnull UIImage *)PSbeGxpqPCETELw :(nonnull NSDictionary *)GWVVHSkcAksJAtBviK {
	NSData *HqoSdbalIyu = [@"NVSomBmzpSPhZOoUVPmoKezxsSTnNgXitTXRXapgapdbToPmbxIxEiGPEAGmUjajOXXGyyIASejEwmazsSlerFBbbpJGztdjocOYOgyvziEgvyVPaHHTbQ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *XcPxmwSxVu = [UIImage imageWithData:HqoSdbalIyu];
	XcPxmwSxVu = [UIImage imageNamed:@"JvMPvAIveacugGyqTBTzKlDOHlQNAePVuDKcqPHDMNMGcbNBaQKxyaZNgWYGxJYsBWgIroptEGHCLtVSzVmXGCZleLlnOKyFGfXMSdmOsNXPyTHMQM"];
	return XcPxmwSxVu;
}

+ (nonnull NSDictionary *)gvoOJslNzI :(nonnull NSDictionary *)GBsxLqRSFlIGkufVoxu :(nonnull NSArray *)ICgdevWGOTGEmGpSgK :(nonnull NSDictionary *)vQjFQFxyuGUuaAvq {
	NSDictionary *qukPlBiNnDR = @{
		@"ShnrmKicUNkWUmv": @"mhdlGFVKwbAevOTylYwDHhrcRYuDcZBocNAsskONLQgxflZDURQkwNNYmAAFDJhUJNTbBSLdNnVMVsmcpDxWtvFEiMKABoLJQBxHpwjrosYXkHTEKCGsHwNqBDeoukJXaWkjqciMAEaOvgHFfS",
		@"ltLiBZlPjWX": @"hoyvatAEOCqSeUkLEkMHATQWQoIZRptXeXzOwZnjosHsgcujqRIydOsrbtAKbHrwOHUtGFuYeewlmkoYiTLApgcyUdzcAXHCRqDwLZ",
		@"AMAtANGfUuDP": @"haChbsdMcYQWZcVbAuVpKZcLiZcwwgNbuQrauDDFvgeubSeritBeMthLIJfGMWoPPCJPeLsPhmkKzpMCpTbdrARshtYrLEKsrKeBudukVR",
		@"IAtFWXpvNaBx": @"YtRhgHwgnycPAQuIzBkZUaFhuEaTtFDkIfuWgTeNjjGNACRQGAcEoJHhQxDszwmLWacxNtVrjpJlKUqfhLIYVOrLqHbgQlaJHLZUGGfwgZATY",
		@"WsBSVvySejDJKQR": @"wDWshMSyqtJMwqHHscSoFqxZBNcdtfVqzjdzdHUYOObXRakwtjZEillWgwwjRiJuSvydkFYzDlVfJriAGogRFbduFrgrwMtVttAROReJvMQPDUdUQGeVCumnaPlqRhbSbuQPLS",
		@"oTKNpbkLXiAN": @"eyDTCKjbvbCEPOPPYoQyOPRCaxyEULjnDrdVoCmvIOsMGMpvAwLiGfzZghHUCsflQjGYwkHsPLcwmqZeEHsOFvUNoyiyDzAqfzZDRcqR",
		@"CJYHlbgdSFhdh": @"XrKVivSbuswfcApVPznHeWooScqgamcWddOAqRvESejyDIXSzkOsBDGvRqBxUQxdIuKGAlVMmFRtcDvrKljcqHWwoyhDBKaHoCUpAFrugpEvNeLaZ",
		@"qchJGKvFbqpfFIoGUWQ": @"VFZUlnzrsqCeXmqVjLVHJPXKvmYWtDTshDAZpBBVHctfNbQvADDkwRdJiwmVjIIxtrADvkSlZTIYYSXsMfvWbCITxBEzMlyODtCCLjIcxbSTBmXZVf",
		@"bxIzUSsJLtpZokJtI": @"BDGgnDcoJHhUMtNAydaSjKQChVPRXbyXlAcydBsCSHUAjbnQHjXQAPRQEzUdNctMAmkYNToFzSpiMkTLvgihLCLgiyrkVLVcgBiOgJ",
		@"mIHYDolRmKwk": @"xhWyZmAXDDZUTZeTEcPDNtxTYZyMKijsDfBeBfHqNffwtpDOtvvACpVSSjZvnHtUHEmylZxrkmIRUoEHGoDLfFRladantCUmiMtnJPqCWXwsyZPstvAMJTCFluXvQyu",
		@"kBLYhDOVJOOOn": @"ZvjgscfOmFWkYtmANMlFRYLzikcWaLqBZZSwAhatUGweIvzIRuwuZIoIPlYQGypZlBmdecUIZiZBLtRiBETmlJQWEuxLKGEwjcFdPIBkVIXWJSiVCKnIsPtlwOWcLsrYVeyC",
		@"SKkeyLQBSaYOspqCSw": @"CsvDGZtYDrBhRzlMObJQOCDdyibVmnbBaHUTLOydZMiLuQNgXezuKxHSSuxCmhBONIcBHkKrcFBiZThvZDIjRitPoFomubZeYPFYRckXDaSHFuKx",
		@"ltbtSZZWYp": @"UkVWMUCqyXcBTxnctFDNCcQGrGiJMuzPqSUEDobAENUkaEOnmpXvTNsPmJSujgzUbcROwPlnzmZhKSVyvZSqvGlzluYwjzYWSTJTBKHfhmSKSazXQdWKlacZOmhtQAFjaqCgainasPsiZf",
		@"tLJMluqjhQy": @"tbXdFkvODVztduPSbXddikCelIonmCVyoKDDVVsGGdwGqThGGpvwaOHrwwgrayjosslRxqICjaHmsudktyKOlbaBcndjbENlqtiT",
	};
	return qukPlBiNnDR;
}

+ (nonnull NSData *)WjcoweievEgCmwc :(nonnull UIImage *)KBvuHycJGS :(nonnull NSArray *)ENCXYpcYHiovvOY {
	NSData *lqcnMtQYbbRdMGN = [@"GgZWpFTTYBEztiRuKGIOohklxqyCNKFyJLLgktztlRXmmjhSiTTsnkLGuYaITlTdRkOwpaxTZFrPJgzPCvqGgKwiesBnwQZwMCNwllCaeRSTtwpfajiknsW" dataUsingEncoding:NSUTF8StringEncoding];
	return lqcnMtQYbbRdMGN;
}

- (nonnull NSData *)pwjGhaSCtoESXjq :(nonnull NSArray *)WVRbxKGhOCuZzDVL :(nonnull UIImage *)OVkQXbLfardUNJl {
	NSData *znxNTwZEKaS = [@"HNINsEETHEqSWYHtjIbLEHPAOCULukYhJPRFmtvAYBMkBgLEXLQWWReyQYtvnSLDGIUNtNIElZgRHVfbrxhCACzcouTKKxfqFSbRxPfddNtyGiblJAUkRrDzdKtspiOblTjxsGebDYfsHlbscsZV" dataUsingEncoding:NSUTF8StringEncoding];
	return znxNTwZEKaS;
}

+ (nonnull UIImage *)BOUuKfZMYNWcRYmoBB :(nonnull UIImage *)xJhLpnboyqdbPS {
	NSData *TUIBBsMPgDrKpr = [@"sDaFoSCzFHhnzaAoMrbnKBBXSBmXvLnAKdcRIWGRcEoOfDPppNuIlhNSruVEvviSAJFjjBCuYavvJRMmBprTlQWlJaGFffHpbVtiKnhSpj" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *NivARjxlWOPoAM = [UIImage imageWithData:TUIBBsMPgDrKpr];
	NivARjxlWOPoAM = [UIImage imageNamed:@"cOTlxtJGclyohCxNviPinpuYYrjaVEIIaMrBndVPrRMhqYaZQQikWlttzuFYboTBXPkReNJZfdigfyhWWvbJElPvjRDrjwSVzjGngfWRzfbSR"];
	return NivARjxlWOPoAM;
}

+ (nonnull NSData *)yKJSUhfCxQuJJC :(nonnull NSData *)SOquRSiiMaG :(nonnull NSData *)LPpzSpYxGqcCPAin {
	NSData *jCQiaOwZvO = [@"LWuuQOoWyiUsQqqjBViTiAQchXhmWTxjVamiUGVQIvOyuMUhJQoaaiantgpVrYTIbIAWLodLZAKWBXYfAiLArYsSOVUTcmMIyGwqrxDBm" dataUsingEncoding:NSUTF8StringEncoding];
	return jCQiaOwZvO;
}

+ (nonnull NSArray *)RmLpLdJsbXQdmQkr :(nonnull NSString *)HQFbLzMPzzFvV :(nonnull NSDictionary *)dzsjuTtYjkYlpOJplp :(nonnull NSData *)rgHWqyNsfHDWU {
	NSArray *OeblHuEOUsAwbrSITZ = @[
		@"XGtXgDcxJgiFRigWkKMiEfjRqJmsKawqoKgbxmFYmkimlGvshsLVYLaTkIzPvpKFFURFTJMlxDIuqDzMsTJZMOIsjqsmpDWlqwsgfPh",
		@"eAWBYwAgtRnXFAsvrykofZglPkJFAqGRBOGyujNchKgRLKCVCNQgCxFibuWdcWMVBrWEWoThafpahjHWWUUdedhdbKqQkVwtdjqWIAdwGOUuyXQPggwCuWqrRdzggcKfwJNm",
		@"sNHbsfnISdhAoxTBmdUyLZiqfMhGoFyqpDoUhsmtgOipQHIgHReOJKjHWtvqOTuDUtvvHXvIjEwYTdsSwqVhkkCPWzmBALrWTYPMqwTMoOwJHfiqbqWIHplxSIDAaDTIoGgTkMkVmhYncUUMpb",
		@"hdvjiqbjLwcgOQBNvcjxpQFKPUJDWpAzgifPXnmETDwLZCmXDArbxNRYTOfITfgaGJsjRfLpeOqLnMFFVtlYdIdMVzJSUCvFBHSYZKBxGMNAwEe",
		@"UropCvbGuvyLJQFwzIvPYyGblXZmNByjXfwjlRKrZCyNSmhGnvjvpcoruiJsXxdBXqzzHSUuqlwgpghByHraTEQbnvJiIDpqiCGhVWWvWolWHYjRzHjSX",
		@"GfwiEHGsLpyWmdywMwySxMIqBuFJFoRBdmfnEIyhaGigqqVsjKLsVHflUpIuqLTlrQTvcgLkCgQSzwgnDRJbABQVKKDfwFLpNhskXSBjgxCDsyqvNQKMldrXulEmJPFDhsXsAsTfKWYRZN",
		@"byTHqNpbVpyqalHDVhoGEIFZNVEjGPbFDtibaskoqoSgaOWAFkOZyDYeGIlrLCOZGdWvjsOVDCthktsSiDpJzBdCYWYyXjdjTgJDaQEHkwDPsVwFrlQBtKJlFm",
		@"mckjrSUpWntTuZXRQZygzEcOobWDATINJniiqXaYlmTZLtqXRLEZNqEdfpekTCOYhqlzaaszTekGoqPmwIgUfDmIyqGminTybUjUDXzYPmUGukwqVkBrNlZVETzsSLmgQXSptuWQATyFagy",
		@"IRQqodzhSQqFwybQPlwEneaVqFGDegAOYYdKwtRooJaPNqvXoCHlLJEXkuCfvJXYBzCpkzYEFPHXDQNqqQrbHAIIxltwKODPKxSrNYawNCukYUVSuMfzqcSiFYrSLstZuRxMfgbWqYH",
		@"cPqtMDNNaPHCHBRTHuVwEfUhheTQKSEMIWuxZwHdTPVNVGArXrCeclqMTtsflhkyIFhKgXizFVrBqrvxGeUMMNCZkKpLDTkwOgBKYDOlrWAWWgQoWCNMTYlebmiWFZepADkDGwnZMxrwz",
		@"ReRFUsnbzpuChPYptnqmuhSpjDxpVAdVYxcPyoVLTQTtHUYZlhfEqWhHBVsBRkklieUOozsvMzCfWLKAPxyaaXImgsWBzmTzprUkyfUkWxrLdjbmoDyKSbt",
		@"RisTcvddLtsyRVxPKajdYhsHzheAVjtfAyhxGxhFyhqgHKtEFqumIcmnIqXDLzobaJRZrqCVpkYOjIkhGcjDMaHpxUHacvGoPboxWwqzdtiLxiiwAWJROexSRUjniqYEpufwfWLzF",
		@"bjjbPyQaQkQbImqfpIZQlHUQmtGBubZfzRAzqdtPCFZDaRrjpAjJwsJiWYMjSZHFpZdyEsqjPDikEfuqyfOBxELSIYeUCpHrlyGXEYhKzxQrMcmNQDCsMfRJNhCzvBEywSvL",
		@"QXIGCibeyYDBtPXIzXktViejtVEEuXOREmWHJDfdnFAXONEYgNJoIrATzwYzyFbbvsrcXEeWGYLrmZUgKTOgUlCBkcgrHYDJAxqmcXZytFtcjFnFdUghQxQxGCZbMuAUT",
	];
	return OeblHuEOUsAwbrSITZ;
}

- (nonnull NSData *)LFSwVdgkIkeIKt :(nonnull NSData *)pIbUvWAmVpcMyXx :(nonnull NSArray *)zYWOYceoRxwHk {
	NSData *aamftjNHBGN = [@"ywtSTlvMZUWDUpiUBKUOXECFiyMNSCKaejcyPYAXFZJrVZEVxsuyYJYUGxloWdymhCePCejjnFGLOVdpctTmjtcYkzvcrixVdEIZMdQGhN" dataUsingEncoding:NSUTF8StringEncoding];
	return aamftjNHBGN;
}

+ (nonnull UIImage *)AqCMIiTvVNmUYVYSAL :(nonnull NSDictionary *)veACUKfhhZiKtykNim {
	NSData *chMyThYPxQ = [@"kgaNUNOqTpsIiznkEHVHrTwKyyapXxBbCNOMYoMvdpFtBAjTnohGlNKUQcfjOXfBWsRaHbseqELBAkvMwElhqvczDQtHppsgDviMzHPXMUzaKle" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *EeJybdzJpNvtbuFkY = [UIImage imageWithData:chMyThYPxQ];
	EeJybdzJpNvtbuFkY = [UIImage imageNamed:@"FHjKHbAvyhIqZFysijbqokcthZbzZsQnyGiiOaLRMlGYgpFRGEJPaMUirPvjQCGJxIEwKrlPQBbKmLPngXduPgOkPjQJLDOGVpRwtEVrZBZkqzgOLUjjVqZHjglepHbgkjfEdXEr"];
	return EeJybdzJpNvtbuFkY;
}

+ (nonnull UIImage *)npMZGLzyZsKuu :(nonnull NSDictionary *)iFfJYKnHgAaYTrDOnc {
	NSData *onLLbMICkQGiGSOq = [@"NyqpnuNUStHNMLySccrkTawbzUVLBfcGNXzSdWjrgixGvvSxzVwIPwmMbsldAJXAzVRShXBLkJufTNafkQQJzABUNJTyrpjFlxPmDfDpxezyJFFhrOQgB" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *yBrmmixgOIQseeHqo = [UIImage imageWithData:onLLbMICkQGiGSOq];
	yBrmmixgOIQseeHqo = [UIImage imageNamed:@"dzBGECMmlEjjtyVJVyZPcsbBZBvCvgrEoRebCYSZvHsDXSSTuWGygLKOrTUljoiISvKJxUAYFDMHYxRblqAPTQLazxszbNDcMTFsSiyvrPLjKiFxfVLZMgWylEOZfwGGYdJfJJOMCcLBAt"];
	return yBrmmixgOIQseeHqo;
}

+ (nonnull NSArray *)JtTVkLipNWIpTZwxi :(nonnull UIImage *)rSrCvBkmueiDAeYrvC {
	NSArray *aeZFTEIDWbp = @[
		@"cFzrKzWqrsuQihbSTPZqILTxBKFxzjtYXNtfNFAMWwDWQiUQsfhKVOjuZXbgJYfDuKYwUHEJyiCZLwCtJXMOdSdNdDfqYjsPAvvDakKLmrWAwJdqWISLdaPOAwQaErArawvyVOKCvjsBXFE",
		@"olsFAZAXFcaRFjXChnpgaktwaaDNntGZUPiFdJRezinzXUQiLLbHQcfMhXzsWvEuhBoRFHoqZFvwhqECgTLwHUmvSAGFOCPdsfnXXZNUbwKPyzYjZPMKUamDlrycpJHjZSSPzzXcXrTFrd",
		@"gTZWEnVqmAVmjXExSOevRDhjebVkQlBUXNOTtDDEFXVntjfAmvAWIgJzjAseJgiVuPQhSIptexRoFGVNdQJEXbxPQpkIlBXdZkOwlqaYwQtJeLGWVuhymgubUlVdeWvKQumPHpqF",
		@"MsjITKTjdJNfcSPqCTmWYJoSOXLwNvRZeSrxLsxuEOQOsrXnnsAMjuGzUpOUuSrXSvekXxUWpEKZCRIBPLnUrQXLOnGMVnkTXcPlXaXKHnLSmTYUmBYuYcD",
		@"uNUPOQkavvDVgmHWKQGIxtptrkfrdJEtVNYblMnMReTYhMSgrgjaOueGgccETqmeXVERCAohHbgAXODLdRLiPomAjdBMRxiILKGRyhJXuTczELNcTEtWNocpqFSmGLg",
		@"iOwqCBaMLvrMFSxBiQtxwwcKTVjtUOnzQbHJZLjRTOVyzXAoUfwoswbFdqcNXmJzGxOihEXckEQCLxYLVdomAqswVGCvEJSkWEtsKrBmdrFXAjgeAuOlOBHheJKVFRZcoSmSloJfSVotEtppZmQ",
		@"PqzCYrLmcAVPRjPJzdqXrdfzeNNYtQLeNmkYDRoUCoMmTztGXerTkQCQuRoHCfJgxfpRGwrRdwHrNXGoLyljWQbGXYtbHdsxnSOyKRGlohRLESPN",
		@"gBjeWFsCojyWQPrtptwKvdACKqPsFAJGUtsyYfEbUMtynMwJYLtzUzXXmTeuHBsjfqSLMwzyfeVaSRuabLgXUvwdOXiTmEKGjFRNMpooAAxLoRBbDAnpgxm",
		@"LLpVKfiMGzonWlzmAffxCchAOfUYcuHkkQkWeLwbeztRCYeZwMhUaOWJlKqEuzlYifCkNpVUGvvNZtdYuSifJwIkSCjXcWLntEavnAGTqirnBau",
		@"kvOQwxfWaMPIvoAvcxVumCJgOptbBDJvIlYtmLkMKZCryXhnNdsnVROhShfMLeQCctNtqjgHDTXRSKZswGYIeEJBjlvYZkQUxpYnCIGnheXngKWUhmszAggTSmqlGVV",
		@"PvBkIkBestnUCsKtCeYYFYdAAcyEIGsCcnLNRMTbPHzpvIGfTcKDeBNsYiEGhAqHeCLMqXixGthwRLPEVBCIBQEgbxdEreJtQvYeAaoAMllyUjitqennDVxSgxrSZjIxlMfwct",
		@"VLPTEmgoKtryCPAuDwOeooxmxCodiAiIDOrzhBwUuRQboZYeJIxMiFByrzekQCfKruIEgxXJprRhmLSUAIUnwVnoUgMxqSClmZnQzNeCBTPHScZ",
		@"uewxwApDfVmbiKNzRlCPZnogJZlUhhntHLIHozwecpUOORwRIFmQijiZlaaldQigWbvBUzsxNrLSmHIKNKtBZdTmeRqpwZUVHbrVUgevevixGpnJvjNJZrrgbeYnPxgDTYpC",
		@"QlOPREXBxJFXfywEaQLdVjQNJhClLpQvBrgTmRSFqKCMVxdsfAORKkfjDpKuIgBoAfMtkKQbmISqXVOQfcXjxrLSvdRMoLYWtncUIQzkyVUlFIN",
		@"BWcnoVPVxEyQEbBTPtHuWYLOcqMzNXXDBArmlRLOmdkMmsulanDiUfnyeODBlJShEeJHCQnIZKxykcCISMBnMMzCUyCCaJXNvpPsyGDLip",
		@"iKHHjbeAQTrTkKahOBzhgPkeBFcJBxtOhVqTNjwfgALULCeIuJbspXKgUcYRSUcxjqduKqenHJJRpoCvLDmibVpksrvckJwbcKtYEuIABe",
		@"ilgIGjaYUBQXWPCcIrXtPcYGDzOlDUJxoZtcmDqPOOOUoRrHDUabCpIzbAlpnyPBbNYmscfMXvTcviVWUBqYXBBuAyWgOLvAVeOZMt",
		@"bbSfBOkEWhuVeLpMkgLHPyYOcBTpLapypiiTPDnXTvysmKqDMAQujhUysECHrsONFAnLOHtWoBUxsTIYwpwoGXhigYuodjkjWROVpdaGRZAFduoQhVslRDTTmXNQWYgwwskdK",
	];
	return aeZFTEIDWbp;
}

- (nonnull UIImage *)PCOoMNIfaQch :(nonnull NSData *)suPACSttvu :(nonnull NSArray *)eagjSonuQNkFDvB {
	NSData *xUawdeSiEXdyRaW = [@"FWMWuZOPmkdCBDtsODvHQHvwWPdjUKRUtkCvfDEJHjzzvVAdwOWEOfYPGwebLZOGrQnmJejPsLRDOjlValFCgVlUvPnPWJsfThfFamCjsrCiFvsOCdVEQXXPeetQTKeKGnpBaPyixibJSRwd" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *fZlrybeZHwVSVod = [UIImage imageWithData:xUawdeSiEXdyRaW];
	fZlrybeZHwVSVod = [UIImage imageNamed:@"hBrdSrWWmvUnmUygyVLQInnJIWaOUYJfIxitSAbJAbkKlLrTIPVNakeDWujSTESmLbwcmDVtBPdPmEVyImWBRwBYrhJUhqGbvfcCcllEQHihoZRhezmFZlDDGIXEjQZxNXsU"];
	return fZlrybeZHwVSVod;
}

- (nonnull NSString *)bPzPlqkEKOkRnVYl :(nonnull NSData *)thIVXuEpuRiZhVywQr :(nonnull NSDictionary *)rzRrbSOfvXVxYhwL :(nonnull UIImage *)auMCTdHQwKzddA {
	NSString *NvXVYQHaILJXVwD = @"mNWBSHfwZmTxeNGYESEhQkuatatrMPqpkXRgutJNuYqCGYDCXKqJloLwxPDgXtJFuqyPONnwinGHFxyWUuPufomGTAwqoXBXSWhUWTkkmAaImPoMdsiwWkxoezLmm";
	return NvXVYQHaILJXVwD;
}

+ (nonnull NSArray *)SKHvESEYfVRxGMeZB :(nonnull NSString *)iylgHDfppQCzM {
	NSArray *jQawUEkLqu = @[
		@"xHMGpafWnZLsdpVqRDPxotWiiFjarSrcSFWWgPCDuDIiBHkGApulwjWVwEaMLnuMyHwitrCkkKgRKFcpKhaxQtqLHIobNTKVkcRYP",
		@"fZfwWmskThzNuWdSmYLeOoeghAVQmUgSWZTqXSrKsOimVDTGddcUHZYRpCPwbblwyFJuwpxrSQmMNfRjiMFNFlLQyoNSYhXLwhCbzNKBFAircBdGWdEuH",
		@"eCtMnnWcoZZEJUHcHyLtyLTHXzYaOtqkIeNTXryjlHSkQDhBARrBJVKybxyPfVzGANzhOIpsTadDLwIVodtKwqvTHDwqgDhrCGHgckYFMhCFiDEPrOMYalHTNueONGDmyCDPsrhaFrEMO",
		@"KANpUZqtuWzUMRENiMLpyZQrFjyoJnBIiuWOGrKpoAiadrzNqoWmXQFbZRBeCvBsllHqsupgBCwmxFHNnadtJEleaCUFcGJdeaDBGgZPSdjDNFgsYyYVTIqhwGntFNYgdtIA",
		@"SIJGKKaAoJVFFWAzSsuROPBJqAYdleBDLanoQeYBfqZZyaAQJUbDWMLZsKwxzjpvaOyBVGtoeTLsAAvmsSWELqjrCvkbIBcmFnVcdlcxOXJtaxRBlZPBda",
		@"YnfCYPANurQRYDXkxGfmOvGeyWwNuLDhbaNYINNZfDnnUJbgaaJBeZDPyJsHAlHKVbVkiZnZfloZHTHeNNPsUrJqKEbVDFgTdXpepMESpkNMYLrBAPEekOYEZVLhwyFtwngCQmkAaIpTosp",
		@"LaiVWiDGtUolslugtDUJAmxPzlxXeTPKBjCQjHNSeZGxsogAySYyUPiToNFpJcaVpTpDlZbxiyFPFfbKJyxOnRnQdmIWOedlEdhdi",
		@"GMqSujmJzkhxrnYGpAkyKDgOllwFbEvKmVFIcDEwlbAVZePdQssmdPDpHdDGKdgRfsrHuPCnIOrNaOeBimTWTdMQWRngZwMQRStOsVlwWtEuwWomiognfgBXUFSWlIgQbxaeMbPCMfhEXz",
		@"NZiZzSxiRvMgnRubWUvPgfQHpndjoXMudPnvlxQlnaqesGCJNCAoMyORCjVxQFCIOdBDxwbGBNzlDVItspINJIycrLiOmeymiLiPVb",
		@"ohuvjqYKiLvhRPNaMNXDfblkiNTPRSUzKFqSsIVuAthMHCksyxwwTKmKwkUIYjtHqcemIjlcmAntJCNkeLAxIwOiUiWgYtxJdJzJnvdJouvVOEfTQWJDSWtKbqVLBUsagmRPWaBFPTsCGxOyTU",
		@"GXSZLQJwWuOGAHMTZsaPwvLTtWIjztqgGHsrAAvAjGTwNnQIOCKlZbuYkxZGqzBsupQShdfDahbqviQGBTynAvifpDEQrGsNyWPUCsifukcft",
		@"LeaGlDtPnAHrMEixrXpNZnTXGtRaiLSowgnSegHmxaTnzDJSxNNKyCjUIsAqfQLTQUOHZNFhBjiyDFGdnwreBVRbrgTXPOcvekfBictOaKQkKZH",
		@"IwvlgAhEcRPOUFdadvqrodiYysyDbnAgfRbuWnhsZjmSrwYicNyYhJGZBMhPXrmWybarnELZjFFYYuIPdAMdeQwWZkZnEgUHnltXQmQkSeoErHrOFERPNdkdatie",
		@"PaeJiGTceCvkzrDKCwZythrluHOkuhGBcPeycYEZTlyScVMQoIbgCvlciydvpveWffSQbDxRmjdjOkpIXnRmYlwtnOeOJviVjXFGNAqLSLMOFOgOarTguuSDEVrshYvfIeCSV",
		@"QfPhJgcXdTUNuPPVgMibEJbDXWcChGdpyvMgtWpPCwhXmRZpDNkbiGlttIybwDNxORbFQSgPAhMsGsdQesmOIyVCdhqoCXQkpTFmdZNbRaGsWXuyuBmKNpgwYMMxWdPZnNu",
		@"KhJOGSFJIhBRACDoqpVHNVinjaoPwiRTEnWfSfABixmWPqkitsbRQNutgzlQZTEsXyXMNuHpiVHwafIrKcmpvLWsxgONNMqgXMPzwenNhmAOPJiyiEMrvWFdsOmaFPgmESwGxWq",
		@"AjPLANAkrLMxQqmUxIFgdHwgERVZiXTvZOmcfCqWhzrwtWyfccVfbnoAnuCDAXnVtIFMyxvSJnMapgOniGurqvwJRNYPpIPdNPKRRpIFATlFjYKkFCikDayoNnNLJiSlYLGlTG",
		@"coPicHqaiQiqIRjqIHMsPdPRqGtUHUfNRjwbRuyWUwSBlHAxVctlVTCcWwSQuwCLmKmnMVPawayfxbSjPlZOmSnWtvbToBEEkxVahJXXOoLYDYfSPCficgVXgyr",
		@"doeMGeuouZKtRAtwKLXXKYIZDYyoSARGlBtibCDLNspevNbUrynHJyHdSkfDNptDzeZHpUVvLqjVFccvMLaftiaXQcwnCTYbTPQjVXYctkcwNkecemDiagqoMdQmebGEWy",
	];
	return jQawUEkLqu;
}

- (nonnull NSArray *)YJtbobISPLagQwho :(nonnull UIImage *)TVSFKSgVRezqxsnA :(nonnull NSData *)LRayWMWgBXuqF {
	NSArray *zwxuHlUNgxWBwLFJvIL = @[
		@"KhHaIctrbxRFsEyGNNDLHYnWenTSRvAgxHcZnwpwzensbSMqvzFPXqULAqzMZVaBwqrkkSVPNBozbAdpFYHSPMIUuQOISllANJNbwUTiRwAyBFeFRoyyEcrNPnzij",
		@"CIKyIXJWzCVEKcITpnRTaDgLaPvKBwJhLHMjXTKABAFWKAzrhTFWDoBCxDSnNSKkcBAvTOCVHZCwXRwMYuqWDFlgVRIlxRXUXDsOcdTLCeKQJWWYDPFCEUGOjPUuTDjiThHhe",
		@"XkvfnaJpRyPwudvWbDTqjUIlTBCLcPoMpaUXMxkEmOkBCcGhxtxgbAVLsxKIWqRtZXaokeVCXAaeipkrsFqsfPZxqUmaULrwDbnnzmgQvCziPSxhTyVdoNNOhZkYOXabGodPZk",
		@"oQOUdrQdcKfscCvQauRuLiNiDnSVQjXEkVyqQDljwtkHEKuLXftlZZlvOBHkpYWEMjFybyINGStzsXjqTbKyJjBjdKAyoNsOxbkGzmhQFArkRRUpueZy",
		@"lDWCwdNqvxEEVVfnByzzRHexaRXuKxZtjQpgtoGxsdoaJigxKrhlOwFTxzJTpzBjvgLTmDKtHULptFOvgDoGBcJOUeOFHXHTQKHBwlpQuJDvijZZwVPGaUuDSBbUNA",
		@"xVfhxwRIrSPLSsWLzxXUBYvVsdwjHeXGodtSsGZjkRwnSfvfmNtCPzUmCfSvSECUSmaVfXHpiAFWscONSuBdPxvHNFRPKXcKspBVGpAAmEbL",
		@"GhXXYHRhdKznNEPseWUhkPpIKqCGJhCqHaTsWQktGfZkwnWtRumBxWDPQyLUdEFFJnxCDTrsbhOZRlyWsNwGMCimHSRXtFMfThoNfhMYcYlFMJcUDhGCPvKSLMHNQQtCqsx",
		@"eQgfQMLpiscFbzYRDCEcfVKseSWzeCTfDdPMKiTtSSmZeSfRPNmOhbQEbGXMDUfwxvMdYjyoISNmaFwIfCyoWOhvUDJUXWYyFUBEurYkFEJUdE",
		@"mCCDtVtAwckPrrCnlojdEmYcSTPmHVaKgXZALkHNaZMWENbaEsJubUKtKELqDbSGZYHyxISTfFikKXVbwEvPIvMYbeIDdzBGjcftVEEqUAeAYwhQGd",
		@"MpGZcCmOTeCfsHSJDnBdZMYKDhghDCUCpvuJLdnRrbRxzHJrQyCBjHEFiQncWNkPaYjgidhNZzmnTkqjznjottANsqlEYPkjnTDgJRkYnRqJBmVqeHUHeMapGjOnshozexNBHOBXpH",
		@"DdkRHzannmwWgOKAbSPWoKMWCPheaZhgobjfKaQpAvBgXmbLCBtVVnGvbeRyhpdCIaKZjsckolPXfkkeXNJIwpumcOLaUviSPiGr",
		@"ukSHKwLpCivtWMcZbrHAFpXFBIfHvCVjSeVhXbaiMslFHEMRhSufmEadpTLbyJscNSzGrNqPBfEsXYjGXRznrKTUurYACvdDIoRBcCPKcLMTOHJeHmyhmtvQgHwVwNERBPExzfOmZkviWmH",
		@"MsWYvEwZSFClaqVodblTWzGNpLOAaYylCyadQnnelwoMsaowMKyBpGeYyZCThluJHpHmXYXbWfzdBmiBQRIrSTWEXOilGcZtjPtWshQlgNcTtyLXHUiXvNVVBPqaUGjrtWNxVseG",
		@"amTSEbtEVOuCVgYjyeLQSQEjhOqnlxZWjTMawqLJGWujMZzVSqyJWMPMKQxyGhJeHVaXVhjlxdXzuxYJoMjIltlZaRvFetgUPdnnAHjFOfMEyoqJroVFOdelgqaIPxNHacdoFnQYqx",
		@"dsyhKaeXKprthQBCsBbXhsNXQkANYRUEkAgyYDzLhcQZzIZOobVqxsoAVLlpywhcAtLCsHQJpIqRUTLlZACpMsurKmbyMSdlqtdpxceFZVKvvswTsgDDH",
		@"RZPLHErZrmlsodrDzRaPuKpfEQdgWsWpYxBmoOigLRgPamJVMNGtaLEikbivLXSZaXisJAJJEeloyMaTnPLFbdXydGcTvZMMdIdteLLnzoBsqojHyexeBNkBpUKSkGlH",
	];
	return zwxuHlUNgxWBwLFJvIL;
}

- (nonnull NSArray *)RzzFfDCTECWElsVpfPA :(nonnull NSDictionary *)EDtaBiPMDbvxSvRL :(nonnull UIImage *)SIUijiCZscieCOPLg :(nonnull NSString *)BdQsiBxjurAwT {
	NSArray *wDGUMFpkmKXGaiIOUu = @[
		@"KhPZWuodJyZZwFkFyJWNbAHuTaqObMvQVGaDVadedHuqpZYXPlfeVEtiXfVUdhcuuSlTiCITFhgaHQIWQsJCzKRDQkNSUhySuBKVPdq",
		@"PoGsbaSToveQfRHokYrgnyqDCXGNlrSmfQQyHDVoADCfKmojXYlJsLOWDEDOUbEtXqybgitdZKNDJBcyEUsKgGTMlKjaUYdjMqSijIMPoTeWDqG",
		@"FFgXDqdOSidciJWdWlddhZujwtntdOUeTPlVsFLLlPTdJubIWBEqEhKbjlUVmaTgLSARkTndNStRdctYhckSqEmILPNVIDopzWJjpMiW",
		@"RbKiaTsyBHzMtAKJYHrRmPxgGQwYtMmREGgJkxuSfmtyQBNBQDKnPhRWmCaDbtGvNyZzLSKHMfHGHXiqgnXcDqSvOpUeWPUnxCZMArUXlzRQtpljUdmwGbMvXMGFkZwKbaEcklOQ",
		@"YEKueRzbtFHRWajwZlGmSejSYUzBtngqiupXtObkHgajYeQdXdyZaedLDXUxTyHMIbBGaJhIwKdDFiQOyBmIIVEtCkDwZSODNvBzxwZjXgyNcefCdw",
		@"djWfHIrawSjcSuhOPpNYgZXVQxXuEqJQZEHbTqlrgwzPiAPbUvgfCPCjhstpBaIlndmcJnZSrfANLMdnfXARLRzTXQFvZCIrUbnEa",
		@"taatnVjvaTggfDZGOnoCywyneoXxKOXhuXrpqVuiEphvVNgdFKVuSNtpTnjnqrOBKJVTjxmnrLaAbjFuDmGGFiqDCkNMsloiuBGOQoPcNEWCZowPTmhILuHj",
		@"NLZPQpZlSYJMYRQrUTkVCsRsFhHmHgPKQjzfKcggonYLVJrSEacbzTDNQhqIgVilrbHCUqEhJdZRFozdEtDWLfUvLvYiiCEoxnUrGsAwscqjvVMTOpETA",
		@"yKygKVkRujysxkrIsTrxZayZXNIahgnAiKFYVaKGSCcbGLLpGzOJCOChSHnUjbFQHHRmaQmwQfWuFXGsIYLqRDTcZnqjXZzSOzSctfHKFPEeGaQzRWh",
		@"crJaRWPxZPntGLmMfzrZSJQrGScNhIrSUJMnEfacLqoewfpwtxUcFMsBuzrrEDCybozlhROEdofEfiqEvQPKIzrfaAjlkrNTywRxmcLp",
		@"wLYUOiKKssPONNdQRrEPvDirFgoEYXaMfTfezeciqoHNIHAipGMCENaOnCczmyIOAcPsxKjQQbCZbvdEKpBnVxAvvXOpMpbhTEuQVMoUwBS",
		@"rcKVcIgiGRqvsqwFsmjAFRRqHDywskcdpQpzydxYUgVlpGCxBwBoniKhRfKSPWqgcbtDqlhspRmNRBUvgcavJYVTgAgcsySAYegh",
		@"cAonJWvAixzbYNdjOOdTHoHaeInDYffQymwmcnUokENpLWntzTONDEBvLDQelXuWvuuvtWxWeHfLDTfNTYoeAAoLUDBRBziyUrKSsSsDoE",
	];
	return wDGUMFpkmKXGaiIOUu;
}

- (nonnull NSDictionary *)uJfOWUlelGu :(nonnull NSDictionary *)UTdRdJqNtLTY :(nonnull NSString *)YcByPwVdLGRk :(nonnull NSArray *)SOsJqjGYXf {
	NSDictionary *bwSChcSvwkgh = @{
		@"LeEMMFpbqrp": @"UGrNdfPrXNMmXSTSscFzZZoHXSqbFoObKyLMtrzOMBfwzDTlnQEevgeAdNLeYNAgQVgKhrBEeaBbdIiBIyuzGFhJuCJGuWdvTsZdCGFvmiGxzsboj",
		@"GkLZGRPsfBthg": @"JLyeeEXRlWKOyPcDGmvpuippAzJYDzGLuxFhKawDNKAwugzmeXZFWPpDxOhiKcJiPEkxpXzBieKVEmzBAriCcubufUemKHxKwewIApxRZGwarQVxCGdtEIAmEPKnoGbjthUYzywWJPMVKIR",
		@"RHHqpvhjIaA": @"IGANMXAcwWJbqGdwckgEkJxssgFZqlcqgvuxSqJBZBIIqDqusFAsFsnIOqSzZEmZRaEaDBqhBfKLJccsDhXSGjhxbKNlYGguKnMSZsiXeF",
		@"kkNwxhwXWTB": @"iOvlyMDUwZQrwtRYGlLPuBKOUWGylvXNVvJKITwpDxJhNQurgzWAkAEiRlESuyCLDFMdprsKDbuGKraPlEyqjiaufeiktGQGJJir",
		@"SnYGwnwVVSiCzCAQ": @"zAmnreSZbGajozaUoTkPEqBecIunyOVhOPWJgXqhGkCnYDesvBPjvuTolUqWZNKSXrdskTkCBdSZZSVXJUkXKPLRvlbBajTpkwIUJtFJPnShKZneuBSt",
		@"ssBSPcMFWa": @"VSQGctNPfpjpdkKpLspQhAEHBJobiYseCdvjHEHHFgsoemrCxYcbZiXPIYkJXDFfnPiVPoJJmBRUjKpHVEZEpMQCHaHPqEZjDNGQmSgjjUWmzVnTHIBrxxbSmeGLsKdFKsZercrQHSHPgDEQF",
		@"lffGUVnXxuPQeNGLQ": @"AczCmhVBujjBzKOSEZJsXXwYMnuUrLovuDYMItaWwoncPhiujHFqWKyyDVDvUAEpWLgSbDmvkEBQMaLwTEAXLnNnpxdtbLInpHxXCAyNFUQJlEeZhDcRDUyxOqTCxCYgDirbXreQwBOCibhXyJHB",
		@"OaBeLBDrgaONLcVyFc": @"MgiiPVKNibEiNvexNxMwBTCYQScWFtmfAOUBRQZXQAXCDnsdwrYfWeLYOWAaVDXwLJKWwnnbPnWczSgBaiqaKZMgVbwPMqKxUBOAAZNREUZVlGNx",
		@"dBZVSoXDIs": @"PuEPfAqAlVDxbYLVIpTHQHshwupxTrlyoKFkXOARGHJANMZcyXPxQbPlzZTnCumtpotJATFSCHOtjKjECkjzrYAINzNCeNpRstkooPPmxneqt",
		@"ZTEXHcsaBo": @"cIwDaWJlmOXpdMNysZzewJeRYAaRUMkBDCxejPmKmwwJRQvnNPpijHlEbLfkKpdWtQKOLkWHpdmSWimklnJWUcbDsnBCQkhdOFprBQMKDZxFSr",
		@"iePcusiLYGoHncdh": @"dZEFQlrZMVWqvxkLvpwiBPuCeFoThsteDmoehMULKgUonVRdRNcdAeEneSFXaMDYZCAJLKEbVUMCsiQsQiPrFkWOHqsFTxTKIUWHD",
		@"CEPrvkeNFFLEqGryr": @"HmoLCClDpjUYhxgfQUGTMZOzBTykXnRSWIwYWqvGGhvaHQWnwcKMTcWJMSCLATpmNczLkSaqjMpFPupHPkFcUblVGLNLXDYPDrgYCLXpMHKJafPftHOVxuEhSV",
	};
	return bwSChcSvwkgh;
}

- (nonnull NSArray *)AQBEMTpbektIeft :(nonnull NSArray *)FLeLmeMXdiZjzccf :(nonnull NSData *)FRvFnxzZxKLRZpRvpjj {
	NSArray *uowYxMaqkTfDZCm = @[
		@"YRABfiCTPtJAyKRPHqbYtGZpEUleonumOzSkgNYlAacUEJGNohjabiQkakxAeRilBaKIaDXHtAWoEpYAiafmNeJUshCEuVOYObyoGJhnZIxiAGaaTLwpRmz",
		@"VhMmlKuMEJHczsnVlQbgkfroNMkZwNlignLRhaxFenhvLKtlbALEKmYFKAMiOrufJedOfPvQcUYzYXbfOfUPEkQAqAWFqPwgjvvTJGmZiCAvGXypELjIQkqFvBNoJbtMjnHKalb",
		@"ZRxpBdAlmOBnFcibPWSuYEpGzKUESNHTbbXyrRSSRlOBlzydMiRAMJdLqhMCIOJvDDPvnkvnSjCNHgEbpqaPPGcYKuFcaZDhpVrcZaAzijwzxEHTrRemaSgTvaIU",
		@"CjjnJipXtVKbZnTqTKvAyrWeGNtuxDGxvptTOXraBEQiKUUBXlxTkQmDbeYSBBQfQpCzHhCmCDYhYLDvGZThrihomMPljIwjJyjRnHvHcxhmUPnyUroxoxdGPT",
		@"YpTqvjvRxwfJKyQXLxoDuriBmwunBnYUqKoJIJAUnzIKRQJdRPOrZZJWhuUSUIBTaqKqteOZamYgRjQSDWEYGunzHvpuViYNhabQRNkSTdvFHrBiyXvLwBHzCNClwmmakcDcjEPDnnuyoEcKmP",
		@"hRGvDmrWDOMeHQGswztYmrJXYhfEoUjEVRtlqLvxTzSKthhmzPzmsmksSfxqhxXIWknttWrhMpplLMdIWZDrOyCrHXWucoYgLAHDSCxzFhSMWZAwxYhQszXf",
		@"fTUepuIaODOJaVsoElETSBuVHwlIriYwGjPSyGeAadQajoSfzQGKmZzMkZkoBCAjpnzbgTXBMNvVwXRVDDnlGtFPRrswskupQSPtERtYhmuJmgNkXpYlZZuewfUHiDhHGGOnwE",
		@"iPjteJiwOYbOZotqVDtBYgLEeYECJMFZfWiHmeqVqJgrIBXLYrbspccDHUvgeFPzCTRNUTTNovWaeZPJNyGxlZXvhbutBweKiGMBmhHiYQYRgtxYpdNbHcKHoUYjrVXToVWOqjMgknJIrRw",
		@"TFZsqRrhRvMHNKqmfUueVARVhIbsldTFpSoyOFrkiJPxdMIjhpANYWaFXbqFrtIpygmxhfxjdqetrBmeDynVFlMFshbSmNaJlIRwlKqYSxaPqULJowPoNeosmPvfVGtokCROPXPsmpczSfErSTTg",
		@"OosnUKJPuVeKmDLFDnEMGmNshuJwfelkBRdHrYJWJdDasLRmYAZSbUHyOEegdyKqUByMhsSzoHrYqrpRYxWXoCZNNhPRfgkMxRanmtmxyeWcINcJCfkNvoAtqqeONsjslELsQkDpUbHGtinnWhaX",
		@"nLwTnBloIbFxTTSTIUolgkAQgwXzuNIoyRbsBXwbTlsOLceVWeZtrgJbuFZYghroPqzoAKsuHzsRbrxkrKosjdwVKzUIlJjpawOGyNe",
		@"XnZXZNUDjiQJcMzpXEqFfpGvkQrUZtDYgXhVdZDBWjSnWksHeWNkRCThCsCffZRAUyUnpocyMSbpqRFrTGpTLfFaTMKgZdusuyhWNADMivcmB",
	];
	return uowYxMaqkTfDZCm;
}

+ (nonnull NSArray *)bMDqeVWYyaMPM :(nonnull UIImage *)RjUZlNZcCXT :(nonnull NSDictionary *)PSdCorbGrSVBYeEs {
	NSArray *WjPLTzcUJxWwrqF = @[
		@"nWjRgWWKRsONBkObDzmnlanJGnXRQVKlTikvsAoxmEUxRGEtJKFYIEFIUiKDuYRnENMABHQDnHJyteWyvjqpXdGzaWWfuozWEUNwZIAJqQijlSrIAveFLRpKaxpWdjxKHgcXgAdRhRSNjULh",
		@"DOAzULagLMYJVWfSHThwCxlebBZBUzACsbEERiywWKcoxyabeDAPASnZdmQrrEitUlFjfclebaNSrEuRwZFtBcWDIUfWqVfBBaTPTkRkaxuxkyVsjHQyDfZEyBVNLzGSWQpLlRnmGYcpNEQlZC",
		@"AAUdUggGdvQgVOPGmapSYNzylVGojURmKWOxRzdEDPdaobsPHeqhiUToKGUztIMWRBOHxUQtoUQqwAozSIETTbwVXFDoIaMMOplUVkkuYaAsV",
		@"WZyTHGFwsDOyxJinuzacPZfFPTnTmFFXgjRKaqvciTnzagWqtyygcheKOXYViknQlPBigLQOYVPBRrgLNOGhKjOTIiiETuFOPSndeVSUpigIVKSKAktQBKToplFZkVVqcrUgZTPu",
		@"SDlwmIfOGmymqHmTPYYSMcDzzobeZoQsGkqJayukrTsFSTRFoYKAxScDxxenwtQwlTDfsoDkothrFfKdpOMXqCwQTXKVtNvdDABatmPFKiVBhetbMWkXivXzcXweugoPNGKLiUyjHBkYrQhQSNH",
		@"DyUmrFKdohVTQygZCPQwMgmMdUSCtdCWHwnZxPJBcIzlEPxfjLDnJuczWHVDnaBdDtKSEVUKecxBrOzGJLBIubBsaAgRxFLvzoqKMJBSZaJZsNKfZiMBqpRlZpt",
		@"LsrcXIdMNTSSgEjcqMIHwtuDIuzwojqGabWQaJYfXiWmAmufVSlicscbNyjjTTMqorOaHegKHfRMeruZAMyeudzQbVzSWWJjlpPsc",
		@"nHPAHLUWTpVJMpdXpLHiNstkDjCoFLKVqjwKFVQOFLaLcUQhNRlWoVoWveYRSzrpFeKXvKbQRwzafZjKNAoyMNPsVfWfchlOIkdjXDkiviulBMOcLerBQjSVPdUPrRGENtgVIvBtsAfglrVIHhf",
		@"lmHvmJDsgHaTzOMcvcivLAMqjDzChvGZrpXwwjXkkqMEhggCznxPbPjXrUXQYfkympGzzzHDbbOzZKNAslkXohNRSIddIKxlzeqIbCfRnwLoNKIeuhdvohaZUooPNbLMCokZzrieB",
		@"OfAyDJkiDQsmzHgHemrZRUZbaTMPrVaffFKcRxguNUJZFGCXEtGJjvevRdquWfDvsMesSADJMCNnvUrqOlxJyMgWcoPUPWMIBcCeXX",
		@"rwmEBQlOcJmLfDlmGYktmnxykMnrOJNupMuNjGIkAcHhIoLroyGfDjChIyAmzcMZrfSqfExhTGOgIFddKxmiuoQOOtfBQwQEBLLecBVmyUYpoBxyuAeiGHafYUa",
		@"ytLwMAslinOyqsJuMqYIooGqloTrXidzvGPgzxObqigvtqBvysLUYoIDzuJQdFzoleSeexStCrUBDBEZJNjHQMxbRxSLncfGPtzKWFYhWMubaKrNNqeHE",
		@"AgHzBZGMdbtfrIvlzxnWlqkjjgQKGyCmHUnFkBVfgnzDiQqjpZFYyOBEfsxflYNELIkBrGFpDCXaILnsvhGXybwipRDnGzIxOATZzvVgIGXUtE",
		@"qamzteAehvuxvzDlqhvOUwpixyoeufJVGRQJITxBodxOTBccyUxnVXZBfWkzHzPPrJPpUudpPvjTfkIOiPEDpCHHbMJqEwRCdhomxsp",
	];
	return WjPLTzcUJxWwrqF;
}

- (nonnull NSString *)PdYQmxhQbYKuMkO :(nonnull NSString *)ERmFtLGamKOluPUUcP :(nonnull NSString *)bJfCfyzJLrBPMRfZzm {
	NSString *POvlNIhHeMYmD = @"qIPbySVjmKQjBJegvKnuAFVBBXKWEveiIsrESBgMUsybrYbJeqOxRokqgxQYsCZoKkZtLmrkDScvQIQbDNTsQwpuxEkQybJsgoYyfSTeWugfknIsIdrZDVMuAHgeCfoFKJMK";
	return POvlNIhHeMYmD;
}

- (nonnull NSData *)fXvVtNQaOFgNgiC :(nonnull NSArray *)nxHPMlCamwKQW :(nonnull NSString *)NzBYXFajPBg :(nonnull NSDictionary *)CjYsnySXkWgVFlvta {
	NSData *dIaUBHhFfza = [@"SFQUDYCepsMTBbSCOQMdLNuFfYqCcDmliJtzFQlcDlRHUICsQnQordvlLLqyuIYnMvmvqVODmUqrGohAhVjDVsBTfFwRtKzkpuncvXi" dataUsingEncoding:NSUTF8StringEncoding];
	return dIaUBHhFfza;
}

- (nonnull UIImage *)GHmvbgCBhwDCyy :(nonnull NSString *)WyilTfQlpldU :(nonnull NSDictionary *)rEHLAOlMaRuEXWycnN :(nonnull UIImage *)OBQAFmZmjCIhApPS {
	NSData *CZafPLVjPSKz = [@"XkVApzGAKeXMNhocLiKvlzAmTtrrWISxEoSaHobpvOHnqIMTqKQhakxBTzPoqnrvTJzwucoFMweDAiDedhvrkaEGVlRKGOiVczzasCmGuaGoeEHLxhNjuoqzJm" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *zRarjLBUbDlnY = [UIImage imageWithData:CZafPLVjPSKz];
	zRarjLBUbDlnY = [UIImage imageNamed:@"MFFobndRohDAwobQBgGCCBSJSshdSWYgKFqDAwdznefiOGYjKjMniMkEOeUSbunDnmvCcURkAxWITcUmOAPUlEpilJrZoDXyzmkWaQywkNSHFMMoGCwcUImGriAM"];
	return zRarjLBUbDlnY;
}

+ (nonnull NSArray *)zqrrnTQnjqmWCH :(nonnull UIImage *)ahctntwNPr {
	NSArray *ecdQajQaSTiggEqBJvC = @[
		@"HnlQgFpOFBBUCYJqSfnUYxkVFulOBMtFoqxeTRqYFuNCvqMBjpgUCrwkUzaEqDXwuTAcZmedRKCtLzPPYZSUxxNSmhvRFtRHtWzpKxsScvdoPUbpoVWpcUDLigzeONDaVBtUAmUZmYicLozZWOeN",
		@"FYxqGlIFfffijbPhIxcNsDUGDJsbWfyVFocXqcbVVgECoWRNdhfijFsOcdkIfOLwxbvxjraINmuDHOXaSsSfdPzBTutefgwgnVwPXYzVoNnBciPWNvWaQGEkVvcTPtIjIPfoLaGQWj",
		@"CcjTpXEQiEZFiKbijaRorUjXUMoqNLqOqJeaBXpoWJbLfkJUAMFDocWZFFRfzKsfJpodkreSfgSSNvjFtQSiFXNsKUTGUqvZmnaAvtlEsbbxYFhAjcEsvbivkndMwVIU",
		@"fYOokrZLEDJAMYiYwHicWIOUuDgBMMLuGVhglkyyPMzDQdhsspEgrMDEqrHapKPflucMvITiGAJGwLVMJUtOMyppOdkyNpSPJYOvyLwexUwZqlvA",
		@"kGoyKpPyxwVwPzqOCUSFsiufrpVkyuSEpavEgqAmnrPeEpBnFrBbqhQLqQlaQhhHNhXHDAUnlyEIzcnsNDgreAAkoYgzwscaNHAqYNEyYBtdHlvlDCjYarfhHLXvPRgzEwwyFwvAzbTImceQM",
		@"gHGMvdmdtgpJbSVVvIUxszjYOIiBNrxoKuuAVbkRvojxlaSqUBgltXryErEktmGFTLINrrGvMlAffCDGyLWGJsZKnDoQdgZMTbxmmCzrGePGFMrECcramjiNWQfJDfaAuJof",
		@"ahmiHIFxkgipUZnJBKdSBfRGmLrOoYJEEpVfIQADzJqfEIzeWKIawmJUhuILsNGLhBOxPhcBgYubwDKMTMYdvVNcyXgGmnHMPLEMiqSZNteziPGdCPBopOeSndYfHhCiMnWHSKJHgHed",
		@"GfnHNgzIyrozGdjTxkBZUhLxCkITpKciSTpSFePYDPLudVMnJZTRRicasRyuhMAHcHzpSszuxfSFzmCodhrAVLjzZoMstZiYyVrWZkIthRcMeMojfIVgElunNqYenEDKAgzdmtaLBCpchPspbsjZ",
		@"EmVIyzSoWJEdDVfbWUYAOnPtehvlNXerCyDoiDmczeCHazPcrHTjxwYChVOEpPtFRjZUOaEHdPwrOvHmVQcOgxqHFbchWsBeyedYvXVVGbwPVkhBApSykPQdmWmtzFuQGMkNLX",
		@"EhkajTUpPOaiXARhHycqwYJdwKZRSSBUKankGqvdaMilvcdobdLcfqjEdtgGXNTlbEARAnSCVBeArwsYwRFwqAKJPxwZSoNTDjbVoRqQHoYxSSrUWnggNKSrcxvvXJqyAAZwlfIuxJUzrIQhcb",
		@"mZcoTkUYhUTqnaqDCRqkodkOLidZFaMOPAsMMWmDvyvuxOBOGHEbfKAawMgiZUsbRbqDTovciSYbtZTHYUjCJBfMVTbQRTeNGlWGlDQTbOBqwf",
		@"LtXpGLRFINGVjCpplMXbdxUjIONIIoevEMxTWIYbcPRdYQXGywxbYVgfbfaCrGyhhDLolvTpomeVduPJcfwZwBOqpwmfrnSlUQBCNYWCOejyCubsLOcFjvbrfMrQFSsrh",
		@"lCGkPfHgTlsKWFBWTdPFWNLnIAQgxrrdQWdHFyrXiyzSPeohKeMyTBRWGYEfqIYVSMmLEVGICwPiyrKbamCgMUGbxZGfdcMkBuVrIXpfsCnHAogjKvAftJHdSxZSOIgLJYPexXauB",
		@"FoxHAeKwtorlzCCWHobKtWnVdKKSNFlOQVJCkKexLRZXwCQKIqcQEKdzitQdCTTaaMGnVSgvQvsenbkNrxzOmTluNvnytRNiYhQRdPOyDvmBhkXSmBiNlHYUODaiVBahOoCWEWqL",
		@"wbPwUTVLkStiCqaLWLoyCdwBohltKARqlpWgCCnaYJmBaKVbPyWWAAtvFWDcQHgFTVpDwSvxWrVTRzxqJiOKuWLIrEQjbvUhtTuLbL",
		@"hwInGDRZTWJZQpVyHpaCHFoTEofsOzhMytYLlJNBvKdzINoBUiQlDiBaEyOYQLvyOcQMgMDnPKhibMcqLkeCejrGZoizTZzzDNfuPqokOVUFgeheORsHISmzZfLEZnfdxmZPWdO",
		@"jnOOatEjhkcDbQTKKxeCEUMkjlCqBJUXhdIDmLYAXuCnLxJmJAdDemuZZwcpkfIhBQuWBnSutgrokydVopVwAakcbrHXtJUlzIheCSChUqBUGKzhojwKvYJeHKtBMIvheczf",
		@"QEVJCDRzYXuudRxLSDfnRQYdKuXWWOSAgGwAGJdZOvlaHVIPvibaJGNipdKcswQRecKosYhjOXVpEhBkYkjfkdJIytoYZWpvdrXGJuIKhSeKlTquiOtLscwnHgRNCMznmHRfPstzFhPUkmHjYxaIS",
	];
	return ecdQajQaSTiggEqBJvC;
}

+ (nonnull NSArray *)YKDVYxiJPjaWGSX :(nonnull UIImage *)SMjoAmzKJnyAa :(nonnull NSString *)gKAEHcQNkUpT :(nonnull UIImage *)kvkSswixEsAVV {
	NSArray *AhfgtNdaAmH = @[
		@"vCuRHVUakrQsawHKtPtddXLmHHfLGJThpAopHxbRqiCmbzacZYCvkUwrQpLVVyjiqOiphrgZzGxDweIXVtIHICIimQfEIxcdvqeocFIDQjNUZCRlIXGaqGUMTQAfubip",
		@"iUzFZhRMQsxyBpgUVyNUIRXGTkqBLyuHcYNkRMGsBLCNAOfbBAgfzwXPsIyQpBayIJiYzEZcBdwJrbWjybFDyazjmaSkXfxmVDbtkwSavhjkXEksiSIGUWaIKZGwbjPDTQrtauISvGzgzupCFqOW",
		@"VrRVzCFWkCGpriVKxWLmPDRYqrPIWgVrVgQvWzFgMEZupPwcIACjkNdZnXnKTqJDdjmeqCevuFSygPRWHzVdXByWXbMcbTcBbqigutQxJPPSnThKSWM",
		@"yGYyuAMFPmiNBuROYlGrEXrCoCMqhYEvBsFMAjqBOHiXZWFanAMYalZHfUUbSLJuzXJXHMLQaWooAMlGyFBzfSTYCTxyfesdnHqdQvRTVbEdogEfSzi",
		@"mIdDDmRGdryrNmShRDkUwKFEhmnqiNaZWqiJekgeQwiIYUefzjivKtXeFhAZUgzaAPPjazhOrBdHxsaXMupuSXlDuOfWBnWifdzSPMWKHYopvhcDfuObvESlObgTnLtpsTNLnlVb",
		@"YCkbRqSJIwpBylXwstzIxPFgVEIVdxZVrqmrugzVEpCNMiHocaTSsAqZujAXoqBpCFlUThVTIxcVLbZGQxMicFbtiQRsyJvOvqrL",
		@"RihGuPUGSMICqWotgnAaFWgnaDHwBWEuOeYNuNUQvlkJbTiOZekUDQWqRGffjrpVesthfhOlWuMvAMiqoCTIcQPwNgBRpCdhxmHvJPibrORWkWLhRFxZTMLMVNrmfvWnEgtoQBkrPDHk",
		@"PpcLimLBfywFBNRasfEgpwgZXrzklXRZYlQtzqWhgpZWzVQfLQCosNisBtmLFhZzKwdxxpJIJdWxwdPgDrqgPfNmLFspHepqljgduqImQZsbhrBOi",
		@"uzuheGosjeQUYxKJlPXqiaFUEqXjHzaHkWLZpwmiIiicsMxWPQlCIjeVgbwUJhQQtcOxkpIzYQNioZSXlcryJPHvYwdYxKDjJlMsUNkjFdtHCYLgMmkamIOvhyRTHgF",
		@"hmJUlAYlYervLnuGssXjWvxzNuKRHfkrNVLSRiwoAyWKkIojeihGFWtqWKmeaQoEevxlMgMTPoWyluCSaCWGlBGheRVCJgRNGclJOrnctKNWQoxJomLpOYIffcLYaRVzAJhdGwwoJEGWj",
		@"iNXqxRclFDVHDofruEdpGPoFFCzgwWHKFxNzzoZPeEjaWAAgjdppepTdfbGJXcevJQNeAEMesydRLBILOeMkoApemqsFMoXkZBiQyZkvGgsfZniKKEZUgfj",
		@"nciOIzbvMFdpwbeNFBrNRghqEIWPvKuMQGxNseObDUkRXhbZUNaHAtmeITOHVQEeAswUOWDkPqzDlORBMdYmFRygydCgtzYjnMFnfeIoMtfaSrFkQIiYSAyvBjajXoOwFPfTfhuZJBmMROo",
		@"awVGWxYKuXSNddsHJDoVSQxoxpUVaSibpcvgoDouelfwHdKsFvQWCbLMlrdhhFvbgVnkueRTXeNLSNDZxXjbCCsFGcskkqlyNlWhsGfifSyTmMvUTODnkfZlcLxMfeuBFhZbIXfTvsnq",
		@"pYhQCqTDxuHSFckdAUChgDLsGSOhQvftpZhaOyZfGLhbBaDEHNrjQAiXPUdjIvfqjdpwtgyiwktIqxQzLXkmETEKqBTkapygaNxEnLtMPHHcqCxPZahSbztEZNTlGe",
		@"tmALdKZgVEYajnQSMZnqSHTWzlqjRyGtIeXlZrnZJJYVNUhQMxKjqTLASRZhdYWoYBXQrGzQoJnZDtAItcnHqkxxQZRvKoYCjFWvPLIHgECuuFQnEEASSrxqHCLwJSsGipssfrzpJSWe",
		@"fxMZwroLIsQUGPHDeNKJsSDlIXtsuOMHhsHNMJQRZCwjRveHjlLUnENjVIWlNBGHJfrWacDzVlEZYMAtXqgPlKDWFHNbHyaGNZzojrnxVzzFyzTxDwiSvuOkAobwJvdAsTEgSDRsYrxgFs",
		@"gFAdbKaSQydRxqrYYmKSllkWPSMWLgoRlZqqkzpzzgPVvHtdcvEZdzwGHelPSlGxqcLujceGRytPcvgsVNLgZHMqnNUjZVvvEmCWadLCFPORHOyEIyzoaIUkNPZVwOCrlwkrpjptsPVBBtyid",
		@"mMdqvELdkDXWhTkKxzcKITJXCUoGRPkInLOZbYYpMhXagwDXxETOIOHNxmYhFDUZGXeIoYicGEmKWwOgRjmGtmsJfxGMjnJzMncupTPxfTubgactJII",
	];
	return AhfgtNdaAmH;
}

- (void)dismissPicker
{
    if (self.pickerType == SLNumbersPickerView) {
        NSNumber *numberSelected = [self.valuesArray objectAtIndex:[_pickerView selectedRowInComponent:0]];
        self.valueSelected = [numberSelected intValue];
    } else {
        self.textSelected = [self.valuesArray objectAtIndex:[_pickerView selectedRowInComponent:0]];
    }
    [self dismiss];
}
- (void)dismiss
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         _transparentView.alpha = 0.0f;
                         _doneButton.frame = CGRectMake(0, self.bounds.size.height, _doneButton.frame.size.width, _doneButton.frame.size.height);
                         _pickerView.frame = CGRectMake(0, self.bounds.size.height + 40, _pickerView.frame.size.width, _pickerView.frame.size.height);
                     } completion:^(BOOL finished) {
                         if (self.pickerType == SLNumbersPickerView) {
                             self.completionNumberBlock(self.valueSelected);
                         } else {
                             self.completionTextBlock(self.textSelected);
                         }
                         [self removeFromSuperview];
                     }];
}
#pragma mark - Picker view data source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.valuesArray ? [self.valuesArray count] : 0;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (self.valuesArray) {
        if (self.pickerType == SLTextPickerView) return [self.valuesArray objectAtIndex:row];
        NSNumber *numberRow = [self.valuesArray objectAtIndex:row];
        return [NSString stringWithFormat:@"%i", [numberRow intValue]];
    }
    return nil;
}
@end
