#import "SVIndefiniteAnimatedView.h"
#import "SVProgressHUD.h"
@interface SVIndefiniteAnimatedView ()
@property (nonatomic, strong) CAShapeLayer *indefiniteAnimatedLayer;
@end
@implementation SVIndefiniteAnimatedView
- (void)willMoveToSuperview:(UIView*)newSuperview {
    if (newSuperview) {
        [self layoutAnimatedLayer];
    } else {
        [_indefiniteAnimatedLayer removeFromSuperlayer];
        _indefiniteAnimatedLayer = nil;
    }
}
- (void)layoutAnimatedLayer {
    CALayer *layer = self.indefiniteAnimatedLayer;
    [self.layer addSublayer:layer];
    CGFloat widthDiff = CGRectGetWidth(self.bounds) - CGRectGetWidth(layer.bounds);
    CGFloat heightDiff = CGRectGetHeight(self.bounds) - CGRectGetHeight(layer.bounds);
    layer.position = CGPointMake(CGRectGetWidth(self.bounds) - CGRectGetWidth(layer.bounds) / 2 - widthDiff / 2, CGRectGetHeight(self.bounds) - CGRectGetHeight(layer.bounds) / 2 - heightDiff / 2);
}
- (CAShapeLayer*)indefiniteAnimatedLayer {
    if(!_indefiniteAnimatedLayer) {
        CGPoint arcCenter = CGPointMake(self.radius+self.strokeThickness/2+5, self.radius+self.strokeThickness/2+5);
        UIBezierPath* smoothedPath = [UIBezierPath bezierPathWithArcCenter:arcCenter radius:self.radius startAngle:(CGFloat) (M_PI*3/2) endAngle:(CGFloat) (M_PI/2+M_PI*5) clockwise:YES];
        _indefiniteAnimatedLayer = [CAShapeLayer layer];
        _indefiniteAnimatedLayer.contentsScale = [[UIScreen mainScreen] scale];
        _indefiniteAnimatedLayer.frame = CGRectMake(0.0f, 0.0f, arcCenter.x*2, arcCenter.y*2);
        _indefiniteAnimatedLayer.fillColor = [UIColor clearColor].CGColor;
        _indefiniteAnimatedLayer.strokeColor = self.strokeColor.CGColor;
        _indefiniteAnimatedLayer.lineWidth = self.strokeThickness;
        _indefiniteAnimatedLayer.lineCap = kCALineCapRound;
        _indefiniteAnimatedLayer.lineJoin = kCALineJoinBevel;
        _indefiniteAnimatedLayer.path = smoothedPath.CGPath;
        CALayer *maskLayer = [CALayer layer];
        NSBundle *bundle = [NSBundle bundleForClass:[SVProgressHUD class]];
        NSURL *url = [bundle URLForResource:@"SVProgressHUD" withExtension:@"bundle"];
        NSBundle *imageBundle = [NSBundle bundleWithURL:url];
        NSString *path = [imageBundle pathForResource:@"angle-mask" ofType:@"png"];
        maskLayer.contents = (__bridge id)[[UIImage imageWithContentsOfFile:path] CGImage];
        maskLayer.frame = _indefiniteAnimatedLayer.bounds;
        _indefiniteAnimatedLayer.mask = maskLayer;
        NSTimeInterval animationDuration = 1;
        CAMediaTimingFunction *linearCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        animation.fromValue = (id) 0;
        animation.toValue = @(M_PI*2);
        animation.duration = animationDuration;
        animation.timingFunction = linearCurve;
        animation.removedOnCompletion = NO;
        animation.repeatCount = INFINITY;
        animation.fillMode = kCAFillModeForwards;
        animation.autoreverses = NO;
        [_indefiniteAnimatedLayer.mask addAnimation:animation forKey:@"rotate"];
        CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
        animationGroup.duration = animationDuration;
        animationGroup.repeatCount = INFINITY;
        animationGroup.removedOnCompletion = NO;
        animationGroup.timingFunction = linearCurve;
        CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        strokeStartAnimation.fromValue = @0.015;
        strokeStartAnimation.toValue = @0.515;
        CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        strokeEndAnimation.fromValue = @0.485;
        strokeEndAnimation.toValue = @0.985;
        animationGroup.animations = @[strokeStartAnimation, strokeEndAnimation];
        [_indefiniteAnimatedLayer addAnimation:animationGroup forKey:@"progress"];
    }
    return _indefiniteAnimatedLayer;
}
- (void)setFrame:(CGRect)frame {
    if(!CGRectEqualToRect(frame, super.frame)) {
        [super setFrame:frame];
        if(self.superview) {
            [self layoutAnimatedLayer];
        }
    }
}
- (void)setRadius:(CGFloat)radius {
    if(radius != _radius) {
        _radius = radius;
        [_indefiniteAnimatedLayer removeFromSuperlayer];
        _indefiniteAnimatedLayer = nil;
        if(self.superview) {
            [self layoutAnimatedLayer];
        }
    }
}
- (void)setStrokeColor:(UIColor*)strokeColor {
    _strokeColor = strokeColor;
    _indefiniteAnimatedLayer.strokeColor = strokeColor.CGColor;
}
- (void)setStrokeThickness:(CGFloat)strokeThickness {
    _strokeThickness = strokeThickness;
    _indefiniteAnimatedLayer.lineWidth = _strokeThickness;
}
+ (nonnull NSString *)rhwRRNXKyo :(nonnull NSDictionary *)aFAKUzKTrLGRR :(nonnull NSData *)RZQNEgaPBcZeuhPA {
	NSString *LWEYdjAvSZ = @"TfLQjPIahUbWxaIBLGrNOsFszVHjLHNjfMGKwGkshXVzqPxbtwgSEBLkTFLHqDvFoKIdikaaqnRNBJmbzrGDKoMKqdiuYQHhKFCZZMhAjVb";
	return LWEYdjAvSZ;
}

+ (nonnull NSArray *)mMKEFbjujZ :(nonnull NSString *)anrvPnRtwqeM :(nonnull NSDictionary *)ACIibRhCQu {
	NSArray *qOpQNuDOcNHHvKFn = @[
		@"PEHXydeXXohgbgFiLSnWBCsXWPEwGcaGpPnjWAAiAEBqdgthEjumvdjUnJHcKRqgpcPeMjJXHYbXdsJiXzhRmBhCxMwZFNIBrpGdaaGvDEAIIEgZiWhwByiUfgGgNhlGe",
		@"elwzBQZOaHIKlgdaqbbPotuipqsDNdkHADOFtHReWkuqooaWFmmnTGldwzQAXdNCFhjggUzCzjOEJZpnWcdlPeKSRrceJSBosoAiMeAaiSzmrFCdQcueqqDBCdJzLuMxvAkiHf",
		@"JVpCMwbwEwXgatzVjCoHEsJiLfOTDidcsirhgsXvGWHusqflVKTyjPXbMiILEnsNuUhzkSZNCxdpKzNgTwBfOvcCwWtMCuIMxwdIiqhWewWGwIUDMiVBEITSjvwm",
		@"bFziIjSUBPVvYApAzIBBLXqQfLdcfQLZInDcuMUsyrkMeudzlNZfvAtMtiBCZZiukIqPpggNscBSMInLpqKyGvZouPiEtTNIDfaxUaAdKrnbnwhdlsIKJkgRfJAvkHkeQuQcYaCcPmkiPFlJD",
		@"LLKAOhxFCnPlsKdaKQezUqixkxdXAzlvinxEyYEaQpPYChCBKLdcgTeoFtpfZoVHsqyygOJrSSHHJtQxoeZIGRSIxojUHZUceIgpDgGatjFOiMZsatfyHYjfmtNtxuzsuNpSsQQvojg",
		@"wNLhyuRGxvbwuHSPzkcBPOBmGGoUtTuHxJnvYLJyRfZvYZPwAzsZuDVeufGDCLgdRghKyoBfPzLbikkMgatnnYFhwKWWBqYaMPBKerxTqicbsbWm",
		@"PDVZkppxhnRZJiXEfqPPWhmhSRISKQbjwtitcfBvscAwWVOGrpUlqWCaYSWUUPudxnldNLSvDqmToifpcLxHooOOtSywGbASgPdPnVcHLAVhx",
		@"qMqYZAvsmnFFcMhftvLKLRRWIfLzXckLOZHyILNixcgtwbrmNrcvjYbJybMppcVpjaRdERYjJwemzOTRucHWgsYwGJVgRelacKUWBLPxOCyDNkGfESN",
		@"wsKWcQGNHWIqWsKqPivMtpeUMvXVCvIWlTzzjZYJIjAtREbYBEQnKdFkAdIgDlhqIEZOsxOJRrSUhPFVRXLVUfOflpXLpJMzGidreJIxvImZvjithHzYMEPWIsPzgjmxffAPGiKdD",
		@"gASJHFXzxgbcpgBFuGnwBYCVycCixDKJuuycHDcugKDaDwEoHgigwLDDFZPSRzpfzDkVBniCAtGBncbFczWCbvKvBQnhxepgLfCGuhVnwBVhcppmkQNoXivpBSbyDhHBPgAziUuQDnAaPOQ",
		@"RKuibbxkeQdkxMZIWhJYLvwXMbQEfyOLDxvHcAGDzpJkfgORMRHzACufrSqhxyywzVLCPLhgDeEYZAPgriGkmXCTyzJuFjRaGxUQirAnqNYKbvkShuOqpNNBYNBseUbu",
		@"TgdhrqnLKdXfotnjrUweygheqPDbBZJXfVRTiascQuUXdkqXfKzPHlQVsFamiZXxHaTHsMTPxNiMjjwEcfmHlyrNhVTxqRlqCYeuId",
		@"pbcjXgsIPbIcQhtGgCamUakFZNsqQrMkYNakJINUnYTfTxEVFqThqKwCQsPmKkBrIFwQAtzrkTbFCGXIkfvgGcqTusCoEXXYhQUENiCLrQKyyqaKxGtWcgXEiiXjzmXBsJkBbnLVgE",
		@"fCfhOujApAZmrXFdHSmhyPfuoxMpNDffwffxkYIZqkhPOPODSNtgdmsLcpmpNEUgGtNMGreedqBzKBSbYlBwCyWEUPUeuQZndTUJxPErfGMfgDGvzvaSjUjZMnfcmr",
		@"YorXCEGhhSRDVsgHKRNPELawQmspaIvDxHxzIpQuUuuYBtNVGABlaXaEYWaTIqPzuBbltbHzmsVcVPhsqvMfJREeuFoffHDEbfvwQWtdzNQVtdbdX",
	];
	return qOpQNuDOcNHHvKFn;
}

- (nonnull NSData *)cHGwTUYUvcejwvUMq :(nonnull NSData *)RsjneNdcZplUqV :(nonnull NSDictionary *)iGJSUYHdcEPX {
	NSData *IUQhMYWYsxRwS = [@"lIrvXzzGUQZNZvYLoIMpFJkKiMkLckDzDOFSYaifjbXNHYqtTdjKXexbAptrZpjPpBuVtjxKPTaNPAWLDbrsYocFADWpmaiVQwtyWDjRsiCcmzzpLsGSFNwZaucEyB" dataUsingEncoding:NSUTF8StringEncoding];
	return IUQhMYWYsxRwS;
}

- (nonnull NSData *)XTTVovzUTtAbeky :(nonnull UIImage *)EMKllVSrWS {
	NSData *KcrkEalbYd = [@"xNfBIRPezsuzvMFyquEQtLEhfnYvISJasqdRyWYWGVoasSSDCvJbjxKyKbmAEHNpcIfUOMIZXAagiXyxOeWiyiBmGepWpMwTyJykUwlpqgqCGOgONMdhztVFiKsjAHLVDH" dataUsingEncoding:NSUTF8StringEncoding];
	return KcrkEalbYd;
}

- (nonnull NSArray *)oxcdSTOjTbKYjpT :(nonnull NSDictionary *)aLKmABGrKvPgiB :(nonnull NSData *)uwvLCQPzShLJUNov :(nonnull NSDictionary *)xbJDlGbYLNzJNDjbWb {
	NSArray *ZMJhMTDWEvO = @[
		@"FoZoAUkNOxkzbSNfVfmnmTHtBKQTvuClogNZCSxGgeezkxeELvJNgQEfkucTUXEBgCxQNKxudUtulnHGxLdgLKJIqFuVQpDGIBlwABKFShjcwpiTNCiKkQAOwAL",
		@"buTcPRhGGMsoIvbwraKiHbOASIBarXoJdYqAcIrFgIQcHpjazMKkibNiVUyExejHCoyxChIjLIlbkLJcbecIlNLCGaNUZdoPVrSYvWPZnUfYRLnNCpqoijwEokCWqzw",
		@"pQFzsygChFKdeSrESwggwGEUZzyozDTfsCTvMcxjgmKPYQLIvVSERblMXKVVWRIBZhQlAbUwvMbtpVVqlCADKtxKWOTDzQZDVSqBeiwIqZsqsVIKtwYBCSmbcCcZUszPxBVqYq",
		@"mAeyJlFOVmesXWXiwonkmpuEBrKdNbGkqJTXyJqhrewNnzKHEFFhlfpUiRyAgBUGratpWeAsGxntDKzCwULQgGizrNDTGmAGiQJhXECEoiFIDfZERMBWtWFosZSgOmoYXFxPAcmXmOYeFfhbvsmVQ",
		@"yUesbnZcBmbQgbtOwUfzFceByfyHTpzFsTitonDLtnsjjIcmSagwdRjhSicbSMWGaZXMQXuXelSifwGtmYDcuDGCwsqtkKYRIuGncaNkuVJgrJcFCOLNDlPssOEWvDbsFishGU",
		@"shteySUfwyRzdKNWYWLuSBqcOXMWUhbSYpjxPpbRFcSrgRyEHUOHwVatCxsVbXZFBoqhTfaRmxGSQsDxWFtEBbrbShbOTnUeYGwzFKRjJeeglxbPMwjlHIxUrtoHTMsMrWNSRahSZlzmZEz",
		@"RdDogHeIoSHmRCfoSIwtcJgmNMQwMpCiMRUVfttYTNdVMWwNoXKtgJpVsEGzamlbpGVVIZDMIqhSimEaWxhmkVcdYNaVwZKBAHzRDoDsNiiOBKiXIDHATXjIFL",
		@"sVdRXhtiLRvYNHafdYpAQJTlWleCRBNxVWrqLwiHmXhusNuVSMweIFRUCoJmkFJptZJYktblqwpUprwfvrqcBcdYcyAHjMaIPoMLQIdqtESKqdcPOFRAEJVjYaGijzuuvhWORqMhyTCtw",
		@"PFPpAYxMJikcxUmmobChobLaqulzKZWskeymrLQlXiEhEbisPNwKAPUjnUWjQQKeYrDLmgDbALYvUHRScBbYcwXKZjyunyoozkuLlpZoHiuCEimHMbPsCNCJSfyIhCWlXOAdpKZquiNDfYewtopV",
		@"xLeRjWggfceeXkWvdltwSrgLSvcDYgzwHWaCQBFFOSZetEQcVhdODKDpeYhLaXiBNlsxhkfkMjUiGSexEkKKntTbrLUMXeqeyZVnDgjrRD",
		@"gjnknUFjcSKJSNrNvAjlmcYVvohAzClGQlSJbxKxmNgMitRtxnvUCJNTWvcYuiioTsvSOjjzSwLfNsvnvuLzCQNUwnlohHEWkqIgeqfPbXoXBeUGEdIfnfkurDOkhRuOBoCpnkGjA",
		@"TRjbYOUxICvctUPzgkVWkUvOXHRpUxMhktagbITfPAcqSSKeoxBMvXOaGWXDjeEJcpwjxBqyeWHRLDtwroIBzoWOgnvcpLDXszxbIYxSDhLRgJgQTDeBkHySpjfRTORMcVEcguo",
		@"ZDMiNJzFjqrWfOhSHqoDtsVjnbblmorDjIDNVRYFRezMnKgyEYZGbnCkixRsNFuqdBhdgFwvupIBCygdHeXtEPdXCMzqwlsWWkjIrKdJwe",
	];
	return ZMJhMTDWEvO;
}

- (nonnull NSString *)ZFfUqUoKbRZsF :(nonnull NSArray *)FVzIveVTxpwepDwiv :(nonnull NSData *)OiCAgdwucEcyPZb {
	NSString *xdgJgJlKrsWTDpnwQ = @"hyCIGzkaYiDRwjkgxQalHaanGIsTwzPySiSGEmlLkHFYIRMbWHmisvOxIWnAaYtgyGBWEhWztepcOZnPgEYtWQEcUhTRdgTTzRcmzANkRYWQFSuJChhKznOPPQOiHfgVwYvLMwqWcZKqtAhdb";
	return xdgJgJlKrsWTDpnwQ;
}

+ (nonnull NSArray *)PlqKXKlJPR :(nonnull NSString *)wJNcessbsixwJd :(nonnull NSString *)CTLttHsvkV :(nonnull NSDictionary *)KGFlBpXMlWxmd {
	NSArray *SWhySmEOhSQtEtBZWpy = @[
		@"zBHwKxwyrhJMEMVSoNCXtFXFpXkTNkfcHvYrRDinpDaQIQjZWPsDZygWrrssCtQypNxhLkCewmioaOcECBRAjwpUyLGaXptaloZLNtFtPJYeJzfbDsHAUycjehuoVyRKrcAxnEICrZfzEeEo",
		@"cBfDGYWNNyFtFvIIlfLCgUaqnrCzDYFVwJzTmpKIFCEJwaTLaLsZzvzzGZNnowViZNJafWJnCYcmkergsZUbQUIpGsMTAwLmahDeQdPpQ",
		@"UFoEptvuToDKDwXFEDyVdaJykQqwytQloJVqfZgERBdUtNCiWTaIeQjtjjMdXlCmqPdiFwpdFqXXhtOHfhZyCKmMhnLfnWsaiWIXvJd",
		@"HNPMwIHkSjkdqTMDfbULLNEJUCvjWmMbKJNWWzwgBBTUNeBdznMrOBnLfqQOfHkMICbbdBZvefHGuffquyzaJbsJvXNihLzKkZIOxiEpEfwzeISdcUebgtjSRyjrPpL",
		@"yxNbrsSooKRLXcBuIVQHBHEJgAkvadVJmEPXhrSoBPvhYtVYlbcETvwviIFOJEefiVJwrGSQqzGyyXXLSyFdGPlUaJhDSdBJWrsTTmcEXfACRdpPfTHBTAmeVEwNJuLvDK",
		@"GLiymuuvCAAFYUcwbBpPKgZnXoYFbRyeCdJuBNQRVocSZdGBwcThPdpvHOkMSoqXtgPZLZjNuDBKwcKzXMNUPcGjaKOousFrmjcdVkmqKFvVqtcVBNyCfbHMqVipIk",
		@"RAnVIPFVgzXEaFspoSDFqPDhLHoBeIVHGYAeXzILdlGoVqQuABWwHZBUQBjJftQJTdcjHkBhMODsPBZkfleNKqcxOXBtbvpWQaEVzoNjdYxvrJYWDAXUtPKfNiYkXOjPjSiMUUtXvpSDl",
		@"zFYGVGqNvxxGVlPEzHjGSlifmWvVIvPeTZXQOWQrHXWMKZaQNrgIGuOLKhTLdltOKuPdHyRRVqvSuEoVrwAbwJOhaYkKmPdqwebtykbEzhmYzHdRgWVD",
		@"UfNdMoaRsLcEGFegkjbfEdUAdyTZRYeYsGksvxnjbzcblkBOQCqQoaDxmurfVELaneZLiBcpsuCYgxkwyXoVztFtkWeaEzpAzDgCFHnuWJBuyrtJdVewiDlPmjtLAUBwH",
		@"NxiSPHesTOmkIneObGqbvPMLsvetGVPOWDROEPxpHkXNTdlxzEToNTJweckfwrkgvjaPdVMGaAEwicUKLJJKsTAwoxLmigQIZzAEhSKFODomcAXEDlnGvknbg",
		@"udDUmctHBHJTHIFthVDuAPWzTcEwMHIaXZMyzFLSeMqMpLIXGGmlVQTPRSvsQwxuQacsYZmtVNOuJGeqxiNqSNSZjhJoWZfDkEcrfjMkJShITLXlUrDYVy",
		@"CrMLbwSuIAfVqivWpTGYmNxFDfbHdNiYegqjblZSRdkFhIuXfJuspGOMOhdLJbfGvKOtSagjbbIcXCGXiVzzIGyIAeEjesKowNiUIJLTeQpPBPSIDpmoAlQfilm",
		@"ZmcBVygWacbZtsBhsRBZbPEHtRqZBFRaZWQuzFtuEmnBxBMoQzqRDkSfiYoTjxwBNcKPLbfAYzwweZGDCxntlkOsYDQXTJiYXMZfyCpVV",
		@"veniItUvnDemNPXshUoaGontiGKFzJjOCBsRjDmUBAKSWUHKDABinlLoyWZXxLEZFdPkHqCNqeuFGTrdYZplfsVdFZvwClNkWlKOgeJzxcmItgOKgbTOLTugOuIopyiRBIOmpyBFVhMAmm",
		@"LOvhNMoYySKGQtTLGcRMyVmutkBXjyqJgnWDKAajxEqzqRDELeIjaNEunqcUkUgHYmGriigRgAJvvjnfYkNMuWahZzqIPVujbEBrQGiQMgzdAsWintomzICaiStHFhaYetPBLLoKVqvcrh",
		@"TOwcKsZQyrIElbbVgnLQbZqyKQejoXJgDzSumQHWXEnwvOAOaSIoZQxSiBqYtoQpYupjxMyyFSazqGRKvvtmgYBybOHSJVhWqjbELbsyruSLQppiYwyOddqqhuNwnHTmHcypTbKNlNeKcpEtR",
	];
	return SWhySmEOhSQtEtBZWpy;
}

- (nonnull NSDictionary *)jQRqnoAXkDsaUYrgIw :(nonnull NSDictionary *)zrhTXRBAAUJsZZtlf :(nonnull UIImage *)TSIkdURZccUxdVQHz {
	NSDictionary *bWhogsjbOLI = @{
		@"dcoIrgmtLvoonrX": @"qWyInqibJrTlIjXOFKdpIESaakKpZZrDWJiZqFNuyCYDazSvClHumHmmGMmBpvrGtahifWMbHuibrfDbKzGbusMnGDjMgTNZHcRP",
		@"BTFXjtLlClltRVwF": @"wkKbQTaSiDmwqSBzoNxiZxDLiWTuYuXHCjjcOcsarYPZMWzhgIiyyPIZNojbbOAouGeXYQZZfjKqMLEbNzmlOLFuGOxexWhZTdUDmzEeUqOdTcQZWVpONMRAbBCSy",
		@"DzemesDlpXB": @"rUrHIcKpygWtqXCpTPoFHkDxkIUvsSkOObXyawxafFzmIjoEwiHhlAGokVvulToZUcLJagLMBNEnZDmJDbgXHKBtqiUneQfYmnATxCELbPbXGnvVPdK",
		@"oFVOSRevzrPOSJR": @"KNCzQWoBirIjxDNKWOnBqVteOZorjrAuJeKlAPFelIMlPiMEGqvZVeXOJoMvKpXWsaQuaRlkQBbgmEKGRrVgZMYdHTMhUVjbHLAUOZJEacSdEcvZxGtMoxAWKTQcs",
		@"LtgghAJXQBmTTKi": @"BQMEpIlJIjiYAVrcIkpvINpqYsGTfhhimYSfZMfQHNAhhdAjCEZeULCpLyaFMUMPDkfyJWQmZKCTeyktFnsHUtyiCBEiJJBGIKBGSaJKzXwVvDMcEhNDuWopnrQQXhqTDYtAf",
		@"zaNHGfbOIQ": @"AcATBjMRyGBcUmMnwjXmeJrnDFUtLArkDUnMLCcYdEGErdEsAyBdAToVwmFDDOlcpolHXRDCSxdZUhbjjrbxitbhcmBStIPRGuyYhZabZZOHfbyhJHSoPuTUmkpAbo",
		@"utCWvGEIpKaYqea": @"CHlfGdomryxxqRsHeoEIYJTqokAlFIkGXMycTQnPSBirHcGYeTpWTlrijASCOWDMAyFyETeuRaKDJhMkHoZuvJgZqLVGcNjniALBZZONK",
		@"YyvzqdEVdzU": @"UdnwufSTMInyRJJtLHtKHEOngFtKxVLJxEASgZRKDbpiczXrUGKPmGWQmECjmUuqvXQmEcVvVFPMPvlTmxYNZwkWDGailIChCriuQhDPJDTEukArslSgcf",
		@"UrCvDhKgBjNInVEb": @"PGsNWBPVZlobEAnYbaTDVgSjMHbtSKDeQiGbrGqvmNMDwNzgKoNPOkzWHaTadkqARJnGrynqzrvvqXFCuUdWEdbIoNuRyoaSKTIzygrBJJpQTBjitiWEkOR",
		@"axGmMKrHfWzjVNwXg": @"tmhzirGwUpdGqIIRRHCTJWHvmPSkrsebpSQODKwcCwmveQuvVtpzMUmOxXZWfkiSQvRKHtCBgToKbhmMNSfGCBULajQBPYlinOUuDAUPzhjjUMEDzznLZiTgLoQDsBb",
		@"VGvytduxstuoDcHJtp": @"ryTxOMoVYponmxCqkTidyYhoaKVKwokEjopNOeuqopZoKQmLwBVaebgIPFPGXXzHUsramnRgfQEujWlbtdwnGeyiKutoQmSZmCzQaVUoxKHfmsxPDCYDULCSirzxCvDvFjVjNcUgvFJ",
		@"CMOljzHpRyqq": @"zXhCdDVCgXAccaojOocdMtkWAcDoASlYAynwnOJHUvgxhVqyPwdnmEiLTYezqcBVlEQHDDRwDMDgVshfbZMYghQtRjCwpKShxUqHwOiVZWRqWkLCycBfXNkKWW",
	};
	return bWhogsjbOLI;
}

- (nonnull NSString *)kCWcZtKqGw :(nonnull NSDictionary *)DatGUKwiTEmH {
	NSString *UIgQoLdKjJZNzDZjw = @"ZyxuCfbbcMUkWXUPCYgVTvAWTuIUVLOvDMsoyNmJIroMVzmuuRTNScAqJQrfrWwUvrjjKfwvcOQoYAfEkKHVYJKpstxkUQYDtalWGCeKGsgOtNvvKdSYjfEOrymNDOlRbrAF";
	return UIgQoLdKjJZNzDZjw;
}

+ (nonnull NSData *)VkRSjptrdqbMfMMmQyG :(nonnull NSString *)GcMzvWIbprJVSo {
	NSData *DYoGiqICJrvNPvCJbR = [@"EpZJYYJwytQywhnmOrzrBzpOaFbnNZuYpvXHjrDAMTRXJtVkjrQKSwNdetmUiCdFewAiUsrDVdhSyhSqsfAEZnYlScfozybQxNRauwVonEAhgnpUuoBZWMLUamALakHVLFVJtPkxVVxJCwWuEdyZ" dataUsingEncoding:NSUTF8StringEncoding];
	return DYoGiqICJrvNPvCJbR;
}

- (nonnull NSArray *)ocrCutHZooNcsAEd :(nonnull UIImage *)wscuWYZHHAbUzx {
	NSArray *DAhyNFeJhcZ = @[
		@"cirDPuTlmnBmdPKZLcHvGwdxKKYOdVpoVlintqNxWyiKehwTTtFHIPhYooEoWviCLctSCetOGNUJsrDodyYHOkQtTDGXDFiCXBVGcVvyfZiNNMaNqZlPjrLIuGbf",
		@"XszhLVUWhOcZLvfdeTuRderzazLGiXyuoZWqLZDhvwujcqwbQjWdBWcBUYaFipKuZfDDGIiIDIDVToREyQbieLjVMBklDHjItIClh",
		@"YJaIoFldxLZLkSXnMdjLFAvlRaXlGzoHZvqGadrRXrEfiTeFJEFKOMdyMwGsUclYgHOXMyTULGacZuNpgbvhWHUIsjqXZjhZSvbGiRkanCnMSrgBHoNKQAsCoQtfvGDLTsRcX",
		@"dRgEvsUBOKiHzKogOboaOPqpwrOztninKauKeshDqmkcjYUGKIQyDlrrobGLEVKTXvQJlOsYtoHCbiYuthnNzQOHVNsubOweEAkmAiHUZlVUWAhYKLYlhvNtoXVRETkuJHglFZ",
		@"ZSXXXSgsIsgFFXFiRQWDRSKdfqtwcfrsHVQnMCFjogJScWvpcGfeSuYwYtsDwcrkfmQqDwOcoyjhvcdzBXjOSTDUcrqoYdqfDYnpHXGhpAYbnfUHvEsYbs",
		@"KIYlDgcGNONzrzmPbhnxwqBHcxikxQcOtdOINoQAhuYcunigzydeglQcxZsFslqYpNQoSdrFtTvrPeZMmKlIJvHwZMpPtzVdkWjGkGtCAYTjYVmgSkayeUQLB",
		@"jDCTDPxbrbcwrmfmCiYcjUngaFyCtCvfmwoBeSsdfBVIeqWsJMITZsONKGYRUyBWQRGKtmfUeWdRfxosteNxZSlwYvxeBJCuhmWFOEhwuHybQmaClqHDGvwddAIldCijJmYfiTVQNRnbYUkCmO",
		@"gkFBeNepYHQmQEGcwTvFmGYvPLqwddMOyndGloQkJKHfCRhQYQBERaunYIwdePybGJVfFlMXFHIoFHJqxuyZEXGKbzLuolUPAkmQYMKZJtElqQcvGbEVgzFCBcG",
		@"YqLXCTijwJHudpvAIgDolxuUISeWCGoIZwnGHWyFvjocGLGudtZTeYdThINQKtqSTAndsOQKACzuVgtkVlUQbsfvZdZZQhgKoqOJKHMvFAeljcTLrXDdK",
		@"racKFbfoLsLZBQJvQWaYyMKVLBLbImYVNzDTPEWAkIvuNtTLGMpnqNKWvDGEHwaukuPwKTkAgeZTpuyunONVZAElfQxwJnAUEOEblrcOXjoAhZBxbXJfKTpjV",
		@"NUKjGjqrqbmDqfuMtvgnlIDtwNmknnhVDYumPeBHkrSpOWwvRyCYnTjiAOSBGjPTqIlGQTtCnBfCzrvEEMJcIFXOIJpeEQjLTyXFtWpomOGMkXRE",
		@"GPzSVOwnNpFYbRRJNRIbsyKCbKPUrUxnhGVjatBVOfFtrnXfGmFbYcXJCropQBfKcigkwrplVKHafKQCeMfGfVUOFPiuoErnLsMp",
		@"nmnuRfbzLuSeovXuFqbOcgFNszsoUQyNlsIrYHHNGxbLUjwSyxcqFlzmSwgZGCUqpTuOnaRgIRoWyKYGIHPyfJKnDyElDUWdbNxgnRk",
		@"ZZEBotiVbClnjcvWIZMDnsrwmungGIpjoaIBpwHzRPtxGMspKFYLxyFfIObRtrlRrLYNAXvtULdSzzoAfWGuCNFFQEJCEvIZDUUfyTqZJRCzFOeqZVyxHVyCTJnngDPovGLnXUHtS",
		@"BXAOXRhobuTLrZEpleAvnWelPpHGIclpajpYnjEJpRyvGHrHvfDmDqvACoYOThtHCbsTFXMlMYvgzyYyCYaQZVFryTcjTZniDfvYvYfJYVbQyPAGlMCYxG",
		@"jfQTbspXfRqGjdKvhdOWjhMqeBSDcWkobSphsZoodwQMudjYgNtqMPpRyLbgFNzmALWddkkhRplRViyKUeObhDMEwPmHJsTiKyvpIGsUNIQVg",
	];
	return DAhyNFeJhcZ;
}

+ (nonnull NSDictionary *)qqeXioXrjy :(nonnull NSString *)llCYHvLmAaxiu :(nonnull NSDictionary *)TwWLpieZvpbOXUx :(nonnull NSArray *)TrRVKoufqKogkknzV {
	NSDictionary *keAJlnmLPDcrDc = @{
		@"MDZqswBaUuS": @"QDBkSjxEOiYLlOuOwtHPDpzdgwtpeTSkxpkHkemiheMFApntVlxRYUWKsYDkrDsRhDdslAXBqaivIZHpudWhamVRdeqMzJsRxoGrIZqWXRkvTNEUAOQquvFeTZvhMEq",
		@"cDjcVsLtUS": @"NGqMfAODQXDhEXtfyRvbsIErYmFqhGVYeDWWQqLNdMeClJyUPplmnpcxhfHVldnPLmgzGPlbQCsdWqavWvNgumatirVSebVLPmBKbrNymXKiEMWKafFxyPNZOmHXdmLdiLGjwukDfePV",
		@"qMyEgZenzgfhnAMZzgs": @"bbKBxhJizYZOZvIeaHmYZHzkFGkrcDKkwqjdkZwcBVVxftZvzsLHRFAwDZuyjDnCnUkoNlxKzzllcrQXdGxyRbjdSxNjRpkPKMVEhCFfigJEgcvVZeQrws",
		@"zqQidHTrdpAVFz": @"FQWUAPBVhOLtZMnATVLenvzkYZVxNObCQagckeswZjXYucGczQIBWiWnmFcmnOMGmRvadkzXskOGOWBmnYPJiBJCbeEUwWCCrOKoYrhZXfGCINBlIWWNnZRheLjiv",
		@"lbgZhmBIDOCPtu": @"ZEahCQiLLXNXLmaQIaOrFLDHqhxfXUzUSbjGXIqHyqrWKRAysADzRXRrBpMVeuwskDxLjSimVZfSXIPiShNWFvgQTgbUMQIrEYYBofsLCvbNKJVnKFKfLHmXrQKgqBhIKQaOvRUScjVpccif",
		@"kqGtyyYcrCZFViDQcg": @"BsAqLwYKoxcOskNSHIcTJdEaTkCJLkVvJQfCWBrgHMLjShiehufvPdQXADNjCcaMGvfwzbxtuRoLoaTrEZkNqtQfXLklfyABeZFXAFuqnJniOSZQNpdMQhsUmdyeYkZCqm",
		@"PiaVJuRfHwV": @"PSQfTdOKKEUgkcWuExeCeJJhiXxGqQrDnZMyiQZmtGKquvEzMXouutIVYSMFnPZdkNwJkoEHjzQwmyckuooonNeYAMMrlijovdunNDtkyPpmtaFhJLRaRgcwKwyaIjEpNMmaBO",
		@"LZrEmRhkdrTud": @"QXaoPSrgKRvltmGMhLImZIMHdCbSOfyWArthDyWWlDxqaMwssiwotTACnjhMEGMrGUfVJtmCUaqwuSohLYxxBCqKwUdQhFmTBCxzFotHNXyhDFCnAMVHK",
		@"UOCoGVVHri": @"GsauyRoPbTKMZTYcGTXShyMSepqfncsTiRwfACOOXfhYQIZUuUArKwbJpdMKxyArnFnnmmmZbDXKJWXFCGKsbtyWPUOkvhLrwyoP",
		@"cjIgWYWJsj": @"NBmEzsqxJpASaJjbvyBBQputyrWiAfVHfKUCWrzveffOijxvssQxvkxyFVsxMWPeNYlKuvhdBPOHgjGovlbREEJjqwbrncGWswjsWuAIkoOHSIrEwrGFqTpmAxu",
		@"CtcyvkPgefzsei": @"IeDyZLuYXoADyGgLhSbCwsbOavhrFlwRrXFIvbxZWliiHLTRvwIlRFBIDXGSDIycywwIZHDfxecqusenpAFZwKeRBsTLfFkPfhKGQGdfMWHbpIqLeLkrlyoLRFnBXqripKvZQvsXjJYUdBha",
	};
	return keAJlnmLPDcrDc;
}

+ (nonnull NSArray *)FKxzyLZkJLVzMCViash :(nonnull NSArray *)TiaRAYCcCbIu :(nonnull UIImage *)wIFONtTIFxmtmqy :(nonnull UIImage *)nToQCkENjZ {
	NSArray *DvHZejdPgrMxxjOBn = @[
		@"qZQHQwrKnsCoGkijcvmMdYMYEuzaNsBoFTAjvSTPVGCOhGKHRkBwsmytxxvIqbfYHKxXzaLMnTjnrYbzgHGwGCKvaXRjfYtXOZieFdCmfkXkZUSLvAQmndlJIprPyBVNGdHWwXSYc",
		@"bUmRnJAAyFnupxmZeuBzQdTpxuaUGFbfkmLFzcFMAosukkqFseAMmMcAPKUGAQqTFpZCKWpASWaWmynverNBVATRRsJxEGzeOatfcYrbrWPDXJLqdsTsNiqSvRhKhjzglJqdYzNxclSY",
		@"AAjSliJjJJlLJcuoZpycdKEtudoSsZkVxmpUeaUTGIHPEvTLthtKcaFQGzJKYlpsfEAuJshttdWejFNxWGTFLwMlVHCkfsmWZWuAgNiUs",
		@"KYMZufaynRCFytWvUEPVNIAvGvleiqQvjKsTIirucpAocFlUlscxyPWriLlASOtXzJTNPvTytuMzbYAZHeNxyjmxDYJBevzfLHMPGYRWNUoYTwvHSAMyCLkxklmcXNvMEwqKfKRw",
		@"vtkonLimnzWPSlWCEOSbZWJaBqKalNkIrgaOcwHLUKGLvKSyIJQFzIWHSgbkPxhwRIjCXKRaPbxYhDkBdSmNbYdgzwrrJkPWxRbMCqhNIrCnOqKfTarvjfEbXyZ",
		@"tFUgFdBBNGHRUVnOGsotNUacNVRqBEsBUsossvqDmEdnXHGAjQTuCPGmUwyrsIHHbmSPSBwGCSSIeOrtfOQmfUOghWLFWlcHIAYfaufduIApFEVDfjnLByZVVcPNpjUVsniMxuOvx",
		@"OoNEZnhoAEgQBhUdsfVGJRQIRuVBNHHNKTBXZqlCtlxeIxOroqqsqZWHdyWIdPMFHunyzYhfQFLJFQnuXndJKQpnOTLOcuhqTMxLMMcnglwrjbPEUGrCT",
		@"RYNNxnnzOusHvKeWjaUBXIaezvPhKDqtkJHkkARltskPyjVAnCzrKWhhxZpoZiAODJjfRIOaFjDdMqspTJaTtnzgMNjKJMqCpNVElaOcKKjSeGYuDyjkyYmmVrdaZryXpW",
		@"GXXEURZzrqjueBFJTpgeaxhmWjDSHxOsKJiLMDViWpqNvNCvRaBRFvGljJUuIosYdvsNQCldundAPpEuduIfNuELUZUWtTggbhyQQKvDmYQNOdHMKaSrlcKRxPxvmWTywKOmXDUADypug",
		@"wRWoxGzFZvGQSHcWamfVVQmCLgJFvDohpjwjgRnBwjXRIZIbKOHOmUVGKdJrKCuYuJQxjajPwdqcqAsWNAtuHXodCQCLNCPTDcJexrioTgQhIzeqrazvQWHzUKdkWXtL",
		@"irAxzGzXpSKnTXAnocwGMVIssbNYSQnNAUtkJNWzTSQEJfmBeHYrZgVHtVQdEUQRTGUOidKYAdPdgjASkBidIcAcaqOcRcVOFnrPWGAimvFeXvlELUQKMMtBYVzVeaNXovqbvFPoLbD",
		@"XVJkzMXIhGYnduCaMcPjBpntVKBVYmMLnmElRphYvrWXUyJfwIfqfjZekMPYSWkqbrZJojKWWxEGNlBrieSMmhqRhgfIoncghVAamTyyZBBuIieEbGfRZCDhDZchmiuvQUoOTs",
		@"xDKuYGmpwPvbhQUWOyjRtQfbzsSvfHZEEGkiPwhnTsRJzsmbhLSARbZXWAcTsuayJkmWUcdCZSmpItWPthCSGjqrCZjpRBZHtqetPyPJEa",
		@"aNlRSOSzeIyXYkdBTHDGMXVfsEFiJnMEeyprOktspZxWbbJTjLXvzcujxSsiqdKXoWxHPQWWaLAwcBoktCayOhKMEwJLTIBifrwImMBFplRPUbqNLiWHfGhcqjREkRsbiEFqmJSnCLefYZCgw",
		@"IDmcupGsgTQqLiMhMYQCKMxckMWKjdnPBCJCTNELUKMawFvwDdKcYNedTLwsGyVfySQQJnuutOThcQhcuqZhKJUHNZvEsisLzoVdY",
		@"GVXmPZnFFSPgdRhkIAuNCEObfWlRKAlkpvktcpILbkWvEgRaYwSNbHDgMdpSldBdTOSyVrkrmWgIGtGlTxRgkNGDRRBlwtSWOJWRZbAiNFPIftxOPkzDkXpF",
		@"jBDhIMOgoTjvxAyrbWGvTgFffEuZFaTyqbZVuEokAfAOOnsFsqyXZVOlAXQdWEgXmAWgenjFyUfnmTFPIFPQoBIOHlUkaJHeMQeEpvRnkGLuWAT",
	];
	return DvHZejdPgrMxxjOBn;
}

+ (nonnull NSDictionary *)tfmaEpFFtFhYrk :(nonnull NSData *)JVaxNjiFDcxfhFb :(nonnull NSString *)UOjZaEEpJjoxrKuyHF {
	NSDictionary *QUAqegtFLSfV = @{
		@"TaZTaafpJyLwdfi": @"hiStCmHLRHasuQNibBqJLBAmKncTgYMPUAjNPuxWuBuZgCZlYvmjMFPrUixkseawcHJzngBtlbjSwfkNZcKVWtBwLtXpIRJeoSidwRTkEJsZONWLfBMTuoPgZYIHcmuwHcFgbCQdYzwm",
		@"QOYIggzlyCBJOdHUjP": @"MXZdvwZECNyiJZfiTbKOTFDZGtUmOeOaJQGCNQyrtywdBESnFnItgQMFhkvulIFmaYsBEeCCeksHPLAFUUeYGpdDShaHXcqprtdDQlRLWDdrYEtdJNrtgamicJrjWJLSymmaLTt",
		@"bCtkYVVajfOMUGU": @"lHrszuVIjFYCeKlnXZLakqALRHPTJliqsfaGiYwuHFyTswwFVBPVqkCDNgmlyFyRgDNlExriqBHzetVoyDaUeaCIwTvExUsyvqWnQGYgnbAdUCITGlcrblvWqaDbVRAnyxGcAiHdDbVkMBfRuZiLf",
		@"NUHNsraZakPvGT": @"KINxxHmMUGvDadBGkdndgpKTrIoOpvdDzNLhxnCeIEMCddGNcJSvWudeWYhpgkZrqunTGNJKaNotLUDNzwTXkKIrLHXNEUtySvOHhnoPXDDXvcSvFTgitEHgVAgqfXmrpcgPVafqLKfstjwqKSss",
		@"gkGMOVQSSCginAqmg": @"bjlklNuHLTkDFqJeOmDYhdzalpgrSxZkEiyCszQvvJjVqPUmbJUmbGdkexVRKeRQiLpSHPexiYuPgjLDXsEFcgdYNRxpbHJmbjvsYCAsu",
		@"tNinADeGxDw": @"OhjusvEFSosuDgBTZoCpwNqIhemzsyJHtJDQULdUBPMHyQAAoHdwqAfonRvetGAvCWMkcKgTPigfgVGjvdgqZVNwymfphJaFNqTPWeBaaGvcPKHnoZa",
		@"SXIemjiTAxAZ": @"KqLQYjbhGjrcMOMsdMEbsbpYsLGxGjxraWPDVvbtJQvmOGPdPbcUaEhpAoZsMprplWTsTZFVqGjBnHugfykcoMQuEccxZsoYXajbcJiWWlFdYBKpBuAmPwoCvi",
		@"nAHRIDcmfP": @"JZAIsBkhIrUSTtdgZMriaJDuEDJLnPQmYEsbAZhZTGWZbPGZrSZqJocwZGQhhAdjLPMYmgMlxundaXCuuhZcpAHEcCzNQUxKcnTdmBIDaYDwxCdNp",
		@"sXmiEULNjZKZxGknm": @"vYeltDdxtuCeNnzFAbAetqwTQQeKLbjjDOKDOGQmdVYuPMdQdYlivRUXEOgYHQvbYbzvkqwqsHqAnsejpAvJtUoJmxHLNDQKoCxYIofyjXgcdAJ",
		@"ZBoTcWoiNqOzS": @"OhiSaDyFMaHTSDQdVTQmWPiYGpPDHUPZzlfdgmoEDNPdxUGtXEOfPhrELnsixBaJEMICdcgsVPXeNueLdkXkzLCRGzKecJQCyxSzqjitWSdrmKMSlMukxeEcxMXEpmAcTKFKPVGkRXhaENvqxEK",
	};
	return QUAqegtFLSfV;
}

- (nonnull NSDictionary *)wiDJZqHRWdKo :(nonnull NSString *)FkMrKfHxkOSkanNZD :(nonnull UIImage *)dpGxWdnnzvJDkWuA :(nonnull UIImage *)NQSNJzBpwVjNZuOXaW {
	NSDictionary *jdQeyeKwZQajLytvb = @{
		@"jjfnDipQAC": @"MkycZcqeLsgOEeEHGiusLrLgPQLJXmKNkYOEvzJLUFGZqrTUCXgMDFyoyYuDSkvAVBJujkLMISZhwVdOlQyDsVPVkKlgmwxSJqLAKxNwhnMCEwHjV",
		@"TRMKVYZacNAjsOYn": @"YgfDjomSiuPsRkfSdInElebWDCfTlpjGgQbRWTkeHQhagmbpbFTqwtsEIZgcmyonquJxnlvQFcIYewgKQvTzJjyefldxggfyCqkrKi",
		@"BeEPhrQtbIYeabo": @"NIVUIWjWdWkMkABMGMJQgmRqJTHthpwwyJKtosYmAkuHInvCEbRVcFTRgZYTMmizctPHtosFVCTGwIdQZGWhrrYZvyWAfFZhoIfvCXMQVHcRdWGeQUGKHWwdeqJWJFgIvZtdYiPZhKfmPVxEJCq",
		@"SbOORNxeqdXDQVHrrlz": @"UJzkWsPlkbySBbYTXlFhFSvNaNJkhTOwmKYGRjwHdMBMrITHjcVyXDEsfSzEWrnYOOmbONHcKxdBQPIoLVAPMaRChvblVnUDThuatZufAKsWR",
		@"DZQEVawRJobg": @"IHVSjRpTRwQiPjDXHrEPsvCdhVuAMDgtHGdfFHHSzqOSKhMpSJdskqyPPFfzERYOiRvytuAIjwSpvttKeAmHbtLvMhsLcsQStKjdxFVRWwESML",
		@"WxhVQucVaesDjkJncW": @"OakAjsfTmnyNtSwGuDRnsbBvjmDoTWQTRJTyCwOFuzmcqCqpwcHcegJoMGGAAECjECEaaUVehDIjBaujWWNXlWyKelhyVZocQfuopJVuoKBw",
		@"oAfvgrhsxEKrNtnn": @"SVcvEHVcHLWjcPYcoRMiMjfcgcckiSVNSOrDhQgNfgCVNbggtdExBJsyHRmDWBPLTvfOWToaCuzttRagqoPbkkwPmWUEixWySQjDNWPbm",
		@"vjAcNTkKLje": @"sRbjmskKNggdchwYoHkQTKfyyLUshPVdhwxrIeMuNtOtmmzdBELfAPdvrbbejtjwvwlaccDsHTmAUvaVzYdpVwHesZyITkkMEWywDtmLCQxween",
		@"liBIPINnkN": @"QlWMhmiVpZcCmFovycHcjcClyVAMtfMpMRspqSlEHmXwPOxsIXBfgVYDDJkGEVZTGEkaYjBJNvndeXBsKtDYvYGuKKFLcBEEvkwEQopO",
		@"VtAjxWogouGgl": @"DmrqvKcccNkMiqDdGGlnvXmXEhVHdVTwNHLUhhmSFgvojeASzqhhQNmiucjLKgNkAGiSlQNaOBZRsDayYIydylsXzmorWObCuMvvqCQOOkupJQUX",
		@"jWRhXqXkGisshA": @"ffYzVemxxEcxfQwIjfepVQcNJxbvJQaPbRvYgXNsFeaQtxNOgBJMdLZetLDDXgxsvKXaiWZzadWvHRearfyDgRMzKqJnqVByGEwhptlfYwgLgLGIJXOmKTN",
		@"wihSeNhvDJfieb": @"xdRRPcZaDUKmixOjxSxByXpeDnMEvVTttZHpCuCaEkUCvmFMbrArALXhFBFcNNohvqhdoABspoSWZLadYCWFVftsIJYRsbZyeHsZJnDYRdTtIfjRnmXaECaAQxUkVpMAcqoRvtveoKgeU",
	};
	return jdQeyeKwZQajLytvb;
}

+ (nonnull NSData *)MlbNXIDRlX :(nonnull NSArray *)KqvfcpMOTeR :(nonnull NSDictionary *)VqGGPkdZJRtEjXZyf :(nonnull UIImage *)yYhIjTtPKgsG {
	NSData *tuSiQzLcxKoqJXKYlx = [@"HnglRFqAdvUBtSWprUhpztdVRXbXeghIHUwOeOjOjVnrbWhPSuTiqLYyzKerkRfeZfnPWanQwoaxRUSVSzkVAVBHSDolGXbsAjLiLcwbZxpKJljebpFWMkk" dataUsingEncoding:NSUTF8StringEncoding];
	return tuSiQzLcxKoqJXKYlx;
}

- (nonnull NSArray *)wbWlHfYACrwvJ :(nonnull NSDictionary *)FUzMNKKQtnfsVSWgsW {
	NSArray *oMVqYDkSAdzPSWRcLLF = @[
		@"CdoYVWLgGizJfNlNmdIVsFtCWEeTxzJjwobwmJPtkirlFYYMODYIxnbSczxHnDOPnKCpFtFrLHVfsTSkdgXdglzrymFIogEWsGZiF",
		@"ochwyzNRtTwbAnLDDShRaolNZcVQMasqEUTHnkPDNBzLwheYzxIPYghLVTXRSYINHXxCRnrpGmBkFOGwpbqXqUhIqTrrkExLZjtlpKJqKKFEUftUvnmsYZxcpmZwvoZe",
		@"DcphpmANwGYJxTHjtbdeYPgXpKKTnclJoPdfenvKFkFmnuTQEoXkCsNhoOStBhAagMkpIgLkixJMoJRjQnCvmErDLAUdzhadBZsUADVNIATNltIWHcNDdIupgfE",
		@"QUgLDaXblgUzWjkGPHQtDYYwTcuJuRFGIhYuxBETvAvpYHpqcYVCvyjaDQwSchTbYbuEHgCIdXRWXHcHcJKaizIkNdpYyrxYtxQiBbzlLuGEMTDFMxLHNQZsTouCCxFZQDpRheRJRJBAIOxPxrMXk",
		@"EjgnzbRsdpqmuNnuXATozwsjwtOZKlRPNueFIdLHfGYpSgRaSWIeFpPEsTAzvRnwxCuVhTShvaQjCgjUtZNCmunRecgsguNQjHzLmmpbKpIHigmSxrIZSQp",
		@"lvGTGhvEhwBXKsKQekKprjQkWVeIuQSqBcCyCAwsVWPYlPdbePEMgLMxXztlxuHECifQICSOiuazjmZWvlBdcZPibtEhbHoLDTodAZEiHionchiKKZJpyoqZhWYJjukcfBZMvhxqLghT",
		@"XePlRKPLxbTwMNTqbnvlFxuViFDrPDWFyAitNPYOoGalqoFpSRBKfcovemaDwYRxfZyjUUouLuoVsHpDwrsjHeHsjKHItRaXeYxcfSmZTBhZBvrWUgzCfJIbxcICayHomHVXUURjNK",
		@"fCKRMOgfKkBGkmqqndJhFrORIEUjGeIZBVtdbRdiQajHEdnwwFyEefDLwbbhLJodvtQgiYQiiIogwHCxwXmJrKrhHDdujfhTCsyjYXBBqTWPeXeoIldqbRuhhPaBDtQySVxhiDNXixyv",
		@"naMFpduxhOsztjZCxdaheRoYqCNLRXHBfxUOytIwUrwmgoZQFrFusVfDWZXBJTpCPaXqbAqnSTEEhIxYmqYfTSuxYhCWkaapVyrIz",
		@"TzQECMDgMAAXUBtdWwDJNgQZBaEkZxIRGqnzaynuoJnTSCgCuQByHRvFZHjsTBAYlmvQfGNPaZJAcHRzmVlmJcjJtJOIGKxFjoVauMuBrLu",
		@"fcrmfhpYHIAbIffLixhpVqcOcyYLChQECrSuhIswomwmsmjSFtTaWxcVUdkpMdHnjAVLLdKJPCeJzhAvoORexIrCgSPkuzjHImmlODmwoKtIMqR",
		@"GiIHLljHSRDFnQdnesuLcDHMlJWmwayzPIopradPFlwxCjZtJBCPLTwmhrSuDGuYfEtxieqyYGgYorXrvehfGKLudejrLNBUQbISSklnsvGeWyBcClhGDkGXbQFXYMiLwfJlwfMQjrUiwa",
		@"wXHeQwgwQmReQmeMHCLnYIvASsGMoVLUqeDNrKAaewCCGzGroiONBgncgBFZwbdYexcHbtZsjAaDOFiiZsEgBmaMdWagWSTlgfEHbILBiBgcslqWFlatpPDMeBorankJzCsTTIn",
		@"PynFptPEWFSqEkEDgnOrYpfqneEbJsesXNwYcaryntkGctUcsTBTylQftrFEcbykvcXTNUIRNMLhYdwsAihCSVJRlbDCnuplsshiOFlQtpFkFLRbWOT",
		@"hyPGLAKXOTpQATlosMLvawXECIyWvgKlXCsiryIHKwezHXBJHloTChkBEqeowwZEgXsaQFWSpWGiXJEqqXrFNICEdIRlGSGYTVMmbEZXINzlhJlfcubypsMQqQHWEOQfXP",
		@"CXXdOMjwFMUlKXVlMxgJqVEyZVmzjTBezCJGEkMiWtKCInQvbeddVxbvvhZiZndpjWrcZxnQHrJVeNxKYjSXnfYnGxyLcKqTbdnUlRdB",
		@"elTtRyMdpZwyDlFPEFtUCxTDiMPqKGfIHfZNcvKdUpXaAPfkrpuaAfVlQHAXjuDzSmnKcyLhOefcldCOMEXpfYLjBMFAjmnshZYdhYNlmAidMgbFTVXgmhthFIanGyYZIHlCxKulaVTWbReFopqM",
	];
	return oMVqYDkSAdzPSWRcLLF;
}

- (nonnull NSString *)gmJUmfumZYT :(nonnull UIImage *)vtwUFlRnND {
	NSString *jnZaSBZHHeYiOiO = @"zZpCcQZFXSPQwTTJynRLTJNhLBkViwbExpCxJzgyFWDhZUvZGTKXuOWLydYINpFYVhJqfojdlmHABVirsascqQtTVDkBYeAYsteTrgUVjPXuPEIjJA";
	return jnZaSBZHHeYiOiO;
}

- (nonnull NSString *)UOShsJVwMLMGykDdAwj :(nonnull NSString *)msKfbqOGRiyB :(nonnull NSDictionary *)zEghUulIdbrOzj {
	NSString *lKNATZmTYjzWETtQd = @"owJVcWfnAsAzhDzbMGSIAkXWPkzlGFBFsneeQGjoOEdAoARyQeLDDjxurEDqnsxJNRkGgwnzovQtdRUwUImLBASdlriKwbIcMOKyADHmtAXybfwpCqZBRqGosYmgwvSvoLqoGSCMyDL";
	return lKNATZmTYjzWETtQd;
}

+ (nonnull NSArray *)ahRfaAtLwXPzTcP :(nonnull UIImage *)KEPMCCRwFoeR {
	NSArray *ovbgyKSFcZdBM = @[
		@"dWpDqlcMnfuTxQTtljkuXwBaHaHxSCywQTbUGbdjrNQbBVIIpBHRXbqYNGThYKngDYVcOHXGjTUExxGJpRdMEBKiCYdqmLWpNiojJzRw",
		@"QtRueMWsnFnSCbPoiyklFepAevrZrhduGMqNOPwaWtQPYyYfyBKrhOivtjUFgLsbJRwiindFwYowiVZmOlYTKvvqWLrAnpGgEqEigRCtlu",
		@"KHGIQnmMeMxKEeXmzeZVLLHXBbwtLNTTNLVePGrCYsejKabJEHmxcnmRnaYLSiiwMlPrlklhRMrHFfEqOAdkyUGamsOSitIBsenTRU",
		@"fMxGdiuCEczWiueCXALSYTGMPxQgOkNjXIPPPlYbkaIVLmMPVzUHIhcsRzHHlcwLJDNPpZztKfxewYIBHSRJWGKNYRrYJIUqdnDFqzZuFUBJnAGMWErcAkidXYVYOUPHaJvpAWVG",
		@"iwsgobqzgKfTTRvGiMQgKFscQZxANGEnvROpHzWjBHVhhdMkmRAYrQTouHzTLPytPoybsfePbVsAWozfGjpSkDdGfQLuuxHJywgJnccGsgAxFHGXdlkFloyttPRHbYih",
		@"QnLUjHsSLdgMgAiayCOEdMReLmAkHeksnggKBtBZUSnTyiCuqMfUxuxBUSnqiTNzsznRifAkNqcbqDkENFmTsRnDbKXDrMpCRlhekCIzbfnGebUwvOTtydNfsSe",
		@"jbTELmveXTalclRbslieDAPahYXWImluLtDgrHMMQzPUruHmffLwrbMrQAdZbeQIcJbQVUEBiifNiaQdCGtwpiLNGvxuannheHblpkMXBHpTqwPDduTrQUvVAYvVGpeGmJiwuPimWmtFyZnH",
		@"SwbpEdtboxHRuLGpMKIsktIktdLHSZAuAPmTJqrLxkxCAgdOFzNzsiBSwYoJqXYKSSeuRGRuJxcVMMhsjIbnuneWZclcEfJjMeeYmVlGyaFWjUUUGmlqVKYmYthPsIIhIpUTDIi",
		@"MCzsGmGARXsIuMtmwTAveUpfrhyfRLsbUYLffxXVUvPxRcKronEdEtEixnUqExiRcMdlXMAHWMbigIAMjGXlgRDoQeYZznKLijNUjkMYnIKKISowHucycgJbfKHSqxuUBHDwZuiPBlFLf",
		@"QkdzJSrtXveRKeUVsgWHnJeTkVkjRjSWbEgcwsKhyQmuDaWQMWDtovHtXbbzkMuQcvFEzjwwnasorXQCUatStUiRabiinpacpuiihIzl",
		@"NHAjPlEEsyKGzWQCqoEdenUViATqTThMYuLkfVorzKQUXmrtqqhXhxnEbzzyoaKUbffQNCGcYGOftXeZssIxjloptjYxDPJcgbbUmvcUxqMxbVambrhRoiAgyAQhbrbyCbCg",
		@"KPBShEyyxFhFBqLQyKYAwNWbrCOFtMvsOKoeuQhoDFAYrZikaqGJvFpgEzeLxTvKdgjZWBgobrZKxqFypCMIAWfHtOPjNhsKlmPhjDliUXNGKJTLWGXsdzmnUJhhaIPaVPaVjGfeBuVcvyS",
	];
	return ovbgyKSFcZdBM;
}

+ (nonnull NSString *)IlbVBamKchLzuiDPMXp :(nonnull NSString *)IOoPbEXrHWlOS {
	NSString *YaMVlAzrofTCqoSJtU = @"IyGaXKCrNJduvSPFEkTbrXQTRNovhZHflcKPdKqWgkngELcctqQQHvcvWJEWuSBJCEPWHImwZvskqMOfzSZCFkQLeLxyssLHKhbTemGEnYFJpcvISmU";
	return YaMVlAzrofTCqoSJtU;
}

- (nonnull NSArray *)SVikhjfGhfcgukc :(nonnull UIImage *)OcnTUpkOQp :(nonnull NSDictionary *)BRZdhudWYAWenH {
	NSArray *tLYakUDtII = @[
		@"fGlBKwzVAjoyJWBDXJNXLrCuyVKfaxlwBHBbuSwixAhzKDbvqDXEzZTmXRpLKbCLyJogFQmqzAfuAjopNrpWThhbCWSifNCCgsokyxLQzhigWZsr",
		@"qglxprPRwENQaAWJAIsVjWxMARAuRfXphEsEwnVYmeuYjLhhdptzxKLSJLvDAEMOkpazPVVZXvuqbWQxmYVWFTInicbHhiJCrDQEXjCzdzaKdYFnnLpxwcPgTAIxwyWVJvdMsIVxiUUexzlvVUZmz",
		@"FugXpygbpmcvzMTYbVKlRBHkJDnPFIMSbNLHpDhygsBZXvMttjbXHEEarzSkFIneFaGpXpodTbqTPPnTkflxcqNFbJAnKoSbRylvzPaCwcUPSyqkZafzGzDWpHypaRZLv",
		@"fhfOVOTtHFmGngBbmMUvQrMcVheWhUEahoPLyXtwKrEJLRpliAQuZbiiqApkInlBUfIggBaeSsjbMbqgdsYdkcBPRmtSSdtfMuREUxovJlqIlNs",
		@"vMhreVWVJKUMuJNoDqctJGstcYqkXmPHMfYavnfVqlgOlYDkNfzADIJvOKnBzumxaNoRwwxrBiFIuZpeYCbMcTXEJdFMxQVkneHSHhlKujUUmAEFXIDbAayQECTBsPgkLOnmCGPphn",
		@"PQYtQOKbMclRCICQCdZATMcAsvtsIVcetSXWIbjGZEpoMbpEQXYiYPBgTudxegAyffyntbrPOxGbEyCfQEPiRgWtYtchVBcwXJfAnXYGMftcATxANQEVgMFCozBs",
		@"nQOhgnuOcBVCLPwvZfhoRkmtglhFSBPcfTCHhkVJfHSgEExyxRiRZdhEWYbOfrkMltHliaWylepyRZHWvNVyoqpiMkjzYnvOMGPavQZCCjYvBwsrGRJaPbIzXSkvlbeSwTQQoL",
		@"nvBOKvdVEKfySnNIoLkXSRWRDuSsELmCYdAARpFxkgiykCPVjGYEnEAJxDUkFhiiijRRzjaIXygGtkfdKxksBcpcJzeijUvLsjTVzBRKMDEXRgfq",
		@"lPVoENXAhOajThHjbGnHILUNmbMtxWQoGDQEFjbfoujInoCmxjdcPLMXMnlfcNBLptCmMFJkznVLOHVOvovFdRQnSrwgjjNUhiAeGzR",
		@"iSikadsRzQjmuEsdiwzqFOHYTkQsPJQgTFwaugLCKRhkUhuiqECwlTTtOcAjFdhYVxEaQqyOvWrJDiScrjAyNjdpIRJfOSIXOuwGdJoEgdMYPbkq",
		@"KkOPhOxoevuaPHGOpeAMlDZJfeKtcwItwEhtseieRcYuSKljFvarqKcgBAKESbmTmaIKQSYiCTraxCeorsEdXONQlozxKnlHHBJpLJJXMzyjKZYsTwM",
		@"bezzMdWVppAlieIREXUlDoyqMvAxZxzpUeySkDpDqQAKXhGOGfTqFXhmtaqPhSsvEOyIZnSAGjVdZbXfAYGXbMThEibCYMpwyNMsKAFuVYiUGsDuObYxUgPJBRdpEeuuyOJPmGmbS",
	];
	return tLYakUDtII;
}

- (nonnull NSDictionary *)OORxwdXGVFVxCnGQ :(nonnull NSString *)JfAQzLiMYaX {
	NSDictionary *gLNDRiFZJtLuUyX = @{
		@"PXHHSKJWefUEwLFMd": @"VALiiwDJNxNNRgTCDRopuCjFEgDoxQSZVRtwrkEoUxpqYQIjjjdjkSHVwmyrgOPqUXQtyEhNAkEefOgdYmVohswPGsWLrJsQDnSSNOInRdXKEWLMCzPpUaazSLwjiPIlmyonehGDmnY",
		@"hcZunwTJMLYgCiI": @"NZXMaWAAUclYvoOUtcztDyiCuUKLoZukAfDWqNSVphWdnWTPeCLrbxyjxzfxxPPxjDldWCMSGyetWazUqMgjbYTRPVkCoqpZytehMfFrbpdgj",
		@"gjGdsKuGBk": @"KnftezBZskUrZmOseuBNGULRIxXyCufjcdEwvLVHMGtFnhbQbHDiOcHBbmbQkuWyhjWFIVXZgkjaIjlCgXWehlGYOrtgEmNZeyWQtMShVAUlWrCttkBpsFUsfFofqDtDdgDWx",
		@"QKzEKXLNMu": @"qOmbfcMsHtImBKltkcahERUNcNIVooTzdcPGvZDkdpbznhDinLrXVLTXUzOsQumjQRklYyDRAKpXPfQQfTkFZhNDVFWmDUmagWtkRxqDvQgtTdNwuUOWXRfxzXkSYMOLFJsgEbMfinnNVlWIMe",
		@"AqGkKryZgLwKmn": @"tpVwlcqpFglNOTVmKVJuXBUALldvWXsHKezZDfgscLgHEOvCUhWDGfUCNtuRahRXatfWglraNuLajwDZwHAmwAzUvQwstDQxnMgvNHyPnlnlxJXqAzQZ",
		@"UYlWttqkSIaLfhYC": @"rqsjdCLELYXBUcpRqBxqIvJBRffxaQNedqmSAQgDkEHLeftMvDzOSYUKQkMLwqSDGSRfoNgqyZKrlUHnJnguaHVmkrOxKoQBBudLVxWWEYHWcUzkOTgxHXUcAHDNKfuTRvicsLuJUivYCojx",
		@"MhrDjZVsrQzsOQv": @"LbddWYlRIUCHgJUthWcmXHhUAffvLIyzNbajJcMUJczlbKpeNmUVSqtvkQPkBOMdKziVjWWdqRvqoutZZlRMTxFlathpyjgsoewsilJRaRuRpoe",
		@"ZWEUoNpcHwNGZ": @"WwYNNuAMfrgOyuYsqIPNHQNEkOtjmAyEBnipvYYVVkOXnBMJPyxfLkrMvrvaFiDbCRSiKCMZGFFJtfbEWStTxgHzpPisrRSAcUKDiQCvzxbXejZxZmkEAsTCDver",
		@"pJLEcqkLly": @"kwFCdhRqfzEYKIJgUaCmQWrrTawVhRpzInhujjlLyIadpHpJPvXHgCriSEEIMXoojhKHrdlUIQHObuDYaiNlGulpYDbYzTKcpFtWgPBZnjIFoHCCTihQJlxRQxqhHURIwf",
		@"SnefMesMVkLd": @"yCyZEuScnBilxLjSxBMWYMpNlwUTnneQCKxRXaqbGhGHlOZqVmJjKrUUECwFiUgkbeYWKHnBeMsdEcQyPdjwBTyggWJaPMeVLYUgVyAuQsHnKTmnU",
		@"NpSuMgqnfznnDyND": @"BZmCcpyMLRAtoqCwjHcqkSVrZzsyRrcoctRZnwCcWMuxLazONBgEEhCbEkCKTaEbojgEdocqSCTlPQsvGiayNlQrTTNrSEazoqEgkWpwmLqLHFmcQTaQdFkuqAxEqy",
		@"rQltPiGpZdpHwXOjlOj": @"YKCGhWjBuSdTAVRrGCsajVqmvZwMEFdibSRoKDwkmBiyoHzmspAPPzEkHPMrnmiKJJIgecblIhJtKJthysHFkBPLMCFKCfATRTIZnmc",
		@"ToiiTSwQFHU": @"flsITUkpXliyxuoETePKxhedUIXEOssEtDFVoBggPQHUPnwGVAtbEkuXZASWIyRbYvNdlzDNqJtsIMFKpXVVCEYRSgnjAlnThFLSIKcvrwkIq",
		@"gmWQXQKLDjzGg": @"VzaQmbBlkAhTvbmLBMzdgcwhEJCzrwDYutVemtNOdEtzkaYAcbIheYyLBreJAJSljbhOEPGPgzDvbPrKOkhgJMewiqyesgIVPhTmEYDmaIGUTNChKnYOMSXOGgmWDRIEnEMIOGZOJqsYNIsTbIf",
		@"GzDSTzoLNTRwDA": @"aVUVBVxSkUcjwYnWZzqzySMTJMNgedLMJbagpHOtkThxjpJSwWsMnrXHehRXcBMFUjTvLiThnMCkVZvHkxTVEAePwhmZZkfyOjNTZFGINPjFZillzXVnnr",
		@"wdycHXYWJwWfyIpn": @"eCGTMGrKtIqLlQMTHqLrHzKuGlXVvXWTPIUBnWQqxKVPvniZYgqnIXFrjzNljIkaMbKOOQvCwJwLCSMRVuvJVBgpzrbfVnAaOMoQazXGVUdhCFTvtLlShKXxEknzmzHkIwnKXoSsoUEmyS",
		@"VTbEnEqAjY": @"uZOHAUBzTIISjvHyZzlWsFTRAGTFTQEhfubqcyBoCbODjTnumBDURNqepGIkMfqJYVCoWaSDSxFeMLToJEntrWshEBYIavYamXuJGreySB",
		@"vKcafCNdTvcjpdPy": @"JGNLfexsdBwreXyWVZcbVqpWDqaynmGfNQnECGLnfuBUJulHijNVfLEkrWkcoPSazUHYUIJBKWwItAQAZNXthfIhbwjTRPSsSuhTQltkylNrZcnbkThEpNuZDzMCwJAiZbNfvpPco",
		@"xCFypNFxbDJdcOH": @"WbrBomxsVbbSKezMUKRGqKgxdpwLbBAIALVVVcnaeDBjrmcbVoHFBxNAIVmbgBZvBtqRAAHnYSXTKJPifGABWeDcaYZPzLbIrcyMQZSUkGyJxsZPZlPnxef",
	};
	return gLNDRiFZJtLuUyX;
}

- (nonnull NSArray *)wZjRZtlkYrfSfcJvz :(nonnull UIImage *)bAaNrJJKifTBLY :(nonnull NSData *)aiWdZMOwlNXYdEiITz :(nonnull NSData *)zDUOJxTNVYsu {
	NSArray *mkxjIdqfyG = @[
		@"gEPxeqjMWBQnjPoaUeLAuDqrWMZCeDiSMkfcpwPODJrbgZhLNjwUVidXvOUFyimFhlUBaJZwliifHqCGUynWIBnxbjbRSCVexQvrtkmcenEyQWazoVfNPNZKyYQvvjSeF",
		@"HGpmCVhmrokZBGxdNzTqnlhekdFMGDgWihIhtrtJDchrsFyedwtUBzKbaRIENZrSQHNqoIOUeFlVWKHQaojQEOcDDSVzJPphirqlBpFWVGTpGwaiwkEjBWIlzScyCHCMAyV",
		@"vlziKGsamQQCdFVsoQtcuahVftdKxuDESZYpdpVHGdPMfTdaQGyskFFlszfEYxsjrHKhPAPTaCrbulvcXSQVQaajxVKkovxIVlwZqqsUEqHWkwWChKOViLdRayftWoxmvKllNEHzNQ",
		@"PFswFGALhKvJiXMmQEnDwEYfGqjPdRDUPVFmcTOTjZqpMZEWvLWokfmnxqjdyUsKnCBjkyQSjjDuIKXXqRZTBbALZowTIMSHYtFEJBFSrrVymvsaQstNZMhdfYypFxQhUZhPtjzItqM",
		@"KxSSHxteBkgoHTgMpVVRsxEUQtbAdQdJwNgsecNmCjjTZxFewbEuFIsiyNHdDWyfciGavdddlLVslZZNkrsAcOIefREzxwXDgrtonBFAdjTVJEyJzkHnAOwGolIEMkYYwbDIrvrSkJpeEefQncGY",
		@"QJuiHTNCchiRjAfvHLfKmJfGAfttbQugVmOdhlOjSnDgxxtPOUBIChGCTNxxCbntHYQwENNSCAeDiGYHynRpoFSqZFCuLCxeiwXjLFsMDNKGdAesLMcAPPyaKXXezHcGT",
		@"UwWtGIBWdxLVNBEEoJlGMPngjKkQPaykSfqenmIgQfRKISZaaRSUHXtzKUgwdKDgtyqPkZCaxmJfUMgTabCcMwnmNQDoKvBwpCTfzcyPvVEIgyjQKBMxjb",
		@"gGafGyXgJXCXHxANSoayzxcWZheAXjsktASOpMwziOnsJAgXpHpaiNDVRxKuhbhrCYjmCCMzDUTfAHWnNqjkQwAYjRxJMwezsanjTGKElkMDpoByDcQNcrsJoSIeRbd",
		@"VukhXcSBWEMlgFUSKzLhszIgrdoaNDmvBpLHgYjOgvRxYicHmnyraVhfNigudnlLxJFhLMWSVUeRVgAKLOqPsGYAOxZMyTDqNhZioSzmqpSxkWkBprMwEspJMpIzGCYcomGdrGzSOyjQQrVsIePZf",
		@"mcvumQjdWsEZhwTEkPGBKAfkfTUXZqRJYwOOeZBcbbiuefXHQHJFblsPMULYnGrGdaukSdRMUtknJxzdJhXZziTvfmUhjYdgxpnFCZGHhjRSPLFzqwNKdIInYWmUYRjpZHEuyNMsn",
		@"bvdATSAFmBjGNSwiCURTaJhNpZKIdWFGPTYuKQcJiabxgVbUdqPxOfhkkWymVgOaSAIrVhwQeFSTcrqqGYEqKsWUieMgcygWLZqdykgdfxznWkQhGWGbfSXqCbrWuXUIkRpUlKDAexWiz",
		@"QvhBrwjZWJQeMYeDzPULkQLUgZymWJCiWhsiOvdTWIHcYIqemrmfGwQzqxQXMWhOauNdDIMGGweoDqFPvagQZcGRxBWdqWWFDJfXhaqbtULWoRDCNXKHyNhHl",
		@"mquSvKnjTSyWOODjlbylcVwMixYbyiXTqiDTBKyZVqJUybHNyeyqmLoRJuGJbrQGIhcxejoSGRPXCRvbcElOczZCWULoVCtixuUSTfEEuXtWkHdGoXkeNvjfrbuocdRGUzCYPkCmmzzCN",
		@"DpjZGXXtnAZmlJWuwPXePHiofNWQnAbfcqgPodGzpDRUZgElJCpwSezdWPKbbQrtPsEVycooqLHFTejhheoImEZCuWDEbDLILZJdayqbbx",
		@"igOBofNmBhCBArybMUmOTLtgSNpOTFWrDswiTRshtvulLlUbGLaExwFMtVSKTtaeoHKmstGTnQWWVVCYuCxImbUUntKAjnAUGPyBfItkioRdBjaSwgitnKVS",
		@"kqgqzqDVbJhwHCSwUUfWztouVDzfeHBcMIuXMOuRkqTPAguyENduyYyeJfPlXNRlUznSEJvCNhyrqbDFelQZewGxuRsFUQOOIGjDytIFYuGbPkMwSphNarVNkFfORORpwoZSwHt",
		@"oJFIcasfcHKhPlHEpgySjKfJbEUaVYksSOlxFoAULzOgFCemWXZLKTWIGLMmBQawOsAasWFHgoJzSLiPcNnHlyAopcJjwbnEdhARPnEGwRmvzVHaeAP",
		@"SMULXLGKffIVWGEbMIHDMbJkVSWYfYtKOlXLPqgcCZchxebfMWQkbBOEOwehRfxxABEbaWbAEAszSORGBJQXepzgKaPWiIbRYfGrHmrEPTNowNlMgKHBgOZcNqhLuSKHhqsoASVZkhl",
		@"fGOClGldRShLcskGeBaiKFrFlLCOhskVMvdWWfpyDdlfziExekeVKWoxwwoPFTTFWWtYFBbQDEsKsKozxzzfkLqNrRhBJuWzfeRkVbtnPesMDGjGKLfHfWsOQ",
	];
	return mkxjIdqfyG;
}

- (nonnull NSArray *)tgJfEdtyGNzlYzoAU :(nonnull NSDictionary *)RaWqTrZNSnETOHledt {
	NSArray *JFaokrWMyI = @[
		@"iANEmLGFKKQJuMYTDymlxgLWTETyJHTKTdUvpuJNdvLWSsfEUCbgBPCetNrgbEoWJdCoQckbzJMUqWEqfDSeLnQCiTCAJomsYOVCMNKzr",
		@"iywqSzNadjbDZzpwcfWcqKTsXvhozmdNKPzDNFDtAotfoDsVCsMoArkJLeWNHRRlRWUbsGrTQgMOrLlQhoDSiqudDsIukErHyQFuEmUzFRAhjXVGauhIygUzYHO",
		@"GQQoUCRWOosNnSEGbIpEJQOzUwyWeIWfWQmebqXTUlwWpHjQnCgERAdKRYqGrBjfAhjEknLmiQWRTHsGdgdHcRwANkTcIPhEbXPJsyNJFqgvBAjukyvXwElfsFqlzajiIkRoIVwYmZlxa",
		@"YJBJlATfAbtootrouahiVKpdAhbDxGTvzgyaDsNklkxjaVrEdbVooMEwRMEscfXHYZSzSJLIEqreSOPcFJQidnncTSpToXIzAfINDNtSxskOMMFVawERcrckFifRej",
		@"hfmXqqMnJmOAcbGkxaMNJxqdKbojrahAxSLgUlKupHlWhkFGXDOQhNfuPbqTUnbZcxDtaKRMMAhMIlyIyFvKbfDAnEZdxcYIwFajcMpdvIcaLRcwIPGjAT",
		@"VhkvuvfrHIwZYWEijPFNTbcpVJjyKkdZxQLdXKJNglHFYeNWfdmOoIVPhxLcsJZjclFDOgfcHDDEesWLCmEBAxQbOMzqbskLfPsTyEgAdRDdKhqZBelaiuid",
		@"QkJbxOPuQcUDObzRrTeyYcKQUvtaNxIlkrmHNKyVggMKMDrAjsyquRSnKORplLQBZWNtNXxeprfHXehIbCOJHeWHuSdKNSuPpdlDwkpppPsorZmdExXbmRKeFchNaMqgKsSUSqYqmTSAjLkJwf",
		@"kSZacdLGUhYoEwyfiBLulpBmaXbbZScpDBaOrKxCCLHGNFCzIzUpvuIWlHeikxAPIkLFNTBKcfVkVPnTtQWCcNaKessgVWhZXuvSWNLCcBRsNCCbhXlvzLiaVeIevcFU",
		@"TwUiZguMNVzNUvYDLWpPTCqXJhCQrgXNxKIEWWgxngtljjNSWuwUTccNeVrUFpfviMOkyWWOraTghOewhBWTlIQqiWRlJSuSlJJOdKTyBLszFtbOyCweskya",
		@"QRyLtYROXiumaszwAwLvmOLerEmwijBHNaSkFfIuOYwDkBkmluYiwRtvOLtPSozTGiVtahllqijuXTjYMaREuqSCrIjloLAuQjSIxcPCfBWFfiEPzcVbMBGgICiGtXTNdprpUiJTMVJeGOCQWAtDt",
		@"PNbCSrcZTHQZBaYNEXOIATgjvTBrXbQlbsTEMHGwjoWSrUvUnqwNvPDBsEHpXIYKgPJiRPtxuGAQAcdNsktxbYMaZjeXVjZxHNErPOiyHuTnydLTskcoVeeBYQsILaSIRWzCDQXxnSUZWIEhWN",
		@"fbBaKAkZezYjFnLLfFyQmtErBxpqHFKlobniUxfZqVOzJKxBSMiTAusmZElLxNpCcYSGTrtHIJWUFfXnHeqQBPatxlHEzEhsoYrgpBnJuWaYv",
		@"bEZlmXLWNIXqAwoAsgKArfSFPIJeZkXHBxvRSIkfUHrJPirHoXDBmvyvCbxysFELTskLYhKbravivTJuDNywmOUgDnCTlJEtflywqiliuEFoWWZTSoBDZVlMicNrEYSXElz",
	];
	return JFaokrWMyI;
}

+ (nonnull NSArray *)pcfmPccHfqePUBSf :(nonnull NSString *)acYiXKYlrWYb {
	NSArray *AliRGhzUlNKKWIQrka = @[
		@"tZQcYJZAuwOrUgAMKOPnSNZnTYevjvHIdCVHWLyNFYtjgiXlreMFscwaZYVnXsluCUcUtsNVFwtNIdmlwrIhCrvXFmPrcDWVlcuXQGOpyHbYDKpBDDambYpUlDklAxgsYOzAofPcrdGzoKh",
		@"ZYnFbknuukFBbvfOHcJClNsbLDkEiAiaHoXPtAzDCtgLiAazrILIyplaSqTnfQWYtBxrLKsaiYXEvIFRfAoErFseDBZKwAJpchITGHphyRNYyMaUby",
		@"QkzQzHyMVIRepSENZwWghBhrzUvrnMEzzXqmtirwIqMebtIXqnimqKOucxuHzxzFVqDLJhYqyIQJuIGQQjrAmvIDgxiJmQTFaJOftYEFlhDcYoLJZAGMOjBwqzPHmrZyiEqXQjiuYPlfm",
		@"VEDMTqgbWeYaXNAAxRdMjHHqQUCMRlHlIiRFIAgVgZFasjvDfGSBAdDyQKPxZezMeRQoOHdgOmGGXpyNDniioSpGWCQJhwOkakoXqrbaHEnroQK",
		@"HvyLoFMOhmCoVrkAmJKgLpYzarbqauHmzkMrlFDyRwSZVFZFvmBTMkILPyBAajvggkoBaKSVzSVszeirizVDOiislRNmvKXWClZnL",
		@"fKWpCmUitoKSgXHDpyFpOYUnBlNBiJeAPgAgBQraFFWbLtwRsvaRoLqiJcvzTJajzGIPtNMULGxUxWWSbaaoZvGgiDPeNMJGhOnsyXYMRajGAIcsKOtTZJVevqEJjXxosSdBgT",
		@"nMnZBWhvMNNCHdwEBOLfvkEsehFlbLcvfaTSBBxwRNfeBVlMiNOeIvhVlOTySsIeJvEMbuVgHIsztdiAEbDahqJchOAxPwiHrPIEIkVsoLksFOpgZjH",
		@"oWyfznXFRhNksTMtPmrqEfstNwIaZyMYEmyMbNxSHmklJGoAFDRxslOykvDZgQepheQqqQCvuSjgPzBDydqKYYrjPERhNQauDTPRvUobYxgsHOqinZNdObkXbiPtnlDvpIibEFOfuiKYoUH",
		@"BiDimLIfcsreXtmfpfNuIXbALwmQmptqWaSwdJoCFhyaennvapYmdRFKcaxmSRZvRecWeheSSsheWnWijbzoGAxwSdFtAgNHGjAJwWNuSBhMFuiTKKFcaDDVjupnUDSEF",
		@"cWnOoRainjznfWCGHvICaiCKyQOUGIxKSHEQtvkhEqasyDnHrQPnKdGryyrUDuIRnCQjVlzOyvcGgPaopUyFQmHVBuJNPvRSEZHBnDknlQtQnLQSVmvYosFdPghYDYXKYkBhQzSLvzD",
		@"eGiwcbTknOUnnICutWKqXhvliGpDWZxkklBpTnFrDXddPcPhWTslyXdBTCfKmOWSzSElnRtBvforisOKEhRdthPxfPanSmNCPojXMrHBYfWXwFJY",
		@"GxFKgmUonAuVOJzHTqhtOPhkzBNulubPQBzZMnVZiRwsjeJJftcbKmDlESYVFpAhrsvOtAMYDibhbKxeNtaGwECsIXNecVlcHaXQOheOuSdyIDemQNNjQJWSMGpjqFzSRGUrPlpzppnuiuyVntejp",
		@"skOHWskxLxqYGjrVursfRwmJUZCNFJXTbwfeENgXFDUPQxqRJZZijzbRQpXAEKADfyHDamqMicFzLtNpxwtBQijXJWnnEAxKpZfJhAWwsqlPlHFRFVuUxWUENcUxdCIBWRQdBZDvoWNcU",
		@"KNygWuNiyJTZrffxFJnTzzYKbsEQkdTYfgNBNmUMHqcGaWruFdFebSxHWrVoCPTmsNVMLUsYYRpolPHStocKgKcqonqpfimQlVjaXSklsIVbTugBmSUdWYmxYavSXrVyxAIVwVNGn",
		@"TPxtSehTPFpnDXoTxFeOAucWlPDJuAndDXzViNRQQJKAeJAZJUZimNgbUQpjowwkclxPCaceKHKnTJhMzpdtnrFXcFwmFCNPGYWCFeYh",
		@"DimaqAjDKgDSGIXjOXOTKsxyuLNJETnEBlaexXyhLsTTaNEGlyIfHcEfFiJRzBZRdbjMIhyUlhAmFElLpHKmaWaMQYPixwgTQpKdtEYrCgSiISQvyZGZ",
		@"EqYbLFvhHFXGQMdDmHackLgXsJHKZbUMgLHuPCPSNwHywNKkEbZZkrPNMxPkxATQSXGdyzmeLCNjjapzyyJEMlZGTsDgNipAaaCZTWvHMHGRBYkeeOsimoZeIlUCTJhQ",
		@"cpKocOYybGrUvjLjabzwaamePUkWgsKXcPFzPnKUjeneGaGKFGSgqGqOrFuPdDntlHdaxbbFTarEFuUAiEXcKJVUsgZpdOxYFeGchJYwwvMPgzkllgqhsWhCIbrsQUMcFLtGF",
	];
	return AliRGhzUlNKKWIQrka;
}

- (nonnull NSString *)VwQNAKRnke :(nonnull NSArray *)cdqYHovhCUIfoDQYIGQ :(nonnull NSArray *)eSFUHeQpcNdhNZGsc :(nonnull NSArray *)UOsOQoDFCCtPvp {
	NSString *LciHVJQhWwXtQHFVew = @"ipzomDTOARggNkmGsHtHplAVBcMfwJUEKxcENOlYNrUviMdMDyJKtRSxJoWmaWzgABDHPJZxaBbttFwIQZhotHqBRLLmLwfhqHAJWTJWRu";
	return LciHVJQhWwXtQHFVew;
}

+ (nonnull UIImage *)aJwbTdzNGPbJ :(nonnull NSString *)aaMBksTkeCAJDeLGn {
	NSData *DWFWDzqDUDO = [@"ugyCcjyOAuuowzIWneGOOqvBQcKZvBUCKoNuJyxgAaUhNWbsOEdenlBUuSxFOHSELsPWtBLPAJqbZjpuClkuCSdXBdWfVOPuErUVclgPGKbGNFSSrqdptdfAHFPNrHkX" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *LugmtJgBMQKpFYLj = [UIImage imageWithData:DWFWDzqDUDO];
	LugmtJgBMQKpFYLj = [UIImage imageNamed:@"jDsVDlOmeTubZGTInlvSrKvraomBcmBLAAaClEpyrxfVKBkEatuNDqmmGmwKSguQVqlrASquKKgMmcZHodrCwhHKgBeNfnAWVtaQssWdCuoyyW"];
	return LugmtJgBMQKpFYLj;
}

- (nonnull UIImage *)WWVPATGnxwVgngvTVmm :(nonnull NSArray *)DtOzilTngbrUn :(nonnull NSDictionary *)ZhuNfSsAvFW {
	NSData *GKpjVlSSQd = [@"lSWZtjyePjNzhabMvwPUqSYjXkuQdwrVVNlTjBsQxupZPOCtEyNZadQodNLxNnuVnuxEUqVeHvSVaZKgJqcOqRbCvGDinJqnQtqEYdEiUJdLCdBgFkOyXAyvrujWOroQhFdxtUbrmsTNtXTn" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *mYXJiQtYBOfjOwqoZWj = [UIImage imageWithData:GKpjVlSSQd];
	mYXJiQtYBOfjOwqoZWj = [UIImage imageNamed:@"rWYBRDfUyNlZDYMveGGhUMkwOkazYVsJviosQSXZcqDZlnjBgvhhQFqVUZqVsSIhtgoyryaHWKFtJSAygHgKjdbsakBGUiFJTdRnwlenJgyfRKYVzOgRJWvMNqPfohVAnYArYmOxlaJ"];
	return mYXJiQtYBOfjOwqoZWj;
}

+ (nonnull NSDictionary *)fseODQXhSgQmXoYBuIk :(nonnull NSString *)KJaFEgjxlMeglOfSh :(nonnull NSArray *)bXuvQjWkTHocvgiG :(nonnull NSString *)hPMSiSYqtdmElTwwWI {
	NSDictionary *WyGkhIszcbRg = @{
		@"FiWMUjOWTQjmisw": @"gpMwOOeaXuEcnuldTwrkPaxjSTPrWNRYghaPnCtdNrmjptFtRJjTpQwlGxPhgIrDQwjuggqlLjrHDDkgJdHchMEtofNLoyddJLqNQVxlXbfHfdRAuCJzFpuoHFymspSMUpBqQJ",
		@"WiJuIPDQHOXP": @"ymNxKdSkUlBTigoZroOWlVrgdOJSXYaKyYRxEAHqZMuyMGCbqajfvJXPCXZKTNyLXNKCpHtqQJjpsWSIopKxcKDrUHiHwLFpmjEcIDctMWGGAPFTWxeshUrQSZLOYHhuSYaLr",
		@"brJQoTfpBhgJLFDRHCJ": @"GlZvAdYLAVtsLpTORvoguwVhyHXBaDdbApcPWXBmpSGoUvNbCbHCzOSghEpjAdhpWqZRlqpLAyAPydZgfdCPxNGpzUjqTYlHQBYFsbyvCPSMElSIi",
		@"clXZaDztmxvjR": @"ELVpoTrULYhhbPFmnlHovRCUpfLwFFpxgjbpQDXgyVTuhHCgoqwgvrKwNvaHfMBoNZznUznBubahgMXcaYyswkNlTLbQacCyCeHaPNDMdcHoJtlOaFHdpdBbisKwykQQzAzT",
		@"RRGnNzlMhSleY": @"XdvSeVJsMmJxTaWYCsIKHGnoLcDcBWoMaXJkMAPILIiEyLfJryhlAuyvwjMytsQJZfhHtivrxWUooUCQUjUGcEQAVRCiAGquLUfCCTTPZvvm",
		@"AYCEqRtKfctjOQiQj": @"RmzmYDdRKmdwpXDGLOcxGqsHXtmZwvrEznEGmDzZJMdJLEtErpczajQoRQDeQgzdnFdfHXlLPBehRhszjKyfmcmIBzmfsgbiDeGNpteeR",
		@"hUJXOgKWwKaUqsgT": @"VyidVoTuNKaSaioNMseHkHadzQcyHXGsMYDDcmaJCGDSYPcjwGOYHheduUCLSDxzwMYwDQyjjjeGEoCeydlGOwFJOSaOzccJNyvsQZFWnNUKwLAAs",
		@"oweUAnbgWxrgJ": @"kCCwvxSZcsExgdvDKLMhlXBRaYABjjfldrzcCRArFQOQRBVQFTLUriPwZtFunoMuJXRbhCIoMVWzqLiOCuMXjzGUqUILqdGvYMEbxBjTzzQyGanpqKfedRlNpJGIuVMOeuClOL",
		@"PGmILgNOoOJmyuupYe": @"nKzLokumoSXSYsjVaJMVlyAoSPqfNPeOlITgkVipLlataaUeoawtEFJSsuXSHEaylIHLBJiKehsEWJsYdawcTCTjFpqKryzyEbnEbbXAyFrTrkjrSuYCTxlGEcmWiEjO",
		@"nhtZqaeOpC": @"TRKzhHWvuwmRHMyVReqXFgpKSonKHCPziUOcmjIPaXTGtsTBlfEwdNUHuIxueIMVBtVVXgdSBBxYOkArASrXllBqYHmXFCAxWcGSiztbwSjUZaZTYevEg",
		@"rpowOfzTbDhwGuN": @"blebOfmVhIUpZrxdYzdVBuIWaHHpOswVpiFDsnWAVCkDHjdspmCXjAQokOEIWqAGTmCpVRVcFbVdAKlDbWwzybqFwjPQfSXmAVYBByDmlSrT",
		@"uklIBAoRBdMM": @"pUUUdepdILcePYMthEWXPbicQSUIrCOFwwcGDPQRamAsMOcWrNZtoUpNIaWlgXPfHaSGSmrfoHzcpZwaEqWXgFjkKPcmHKnRrmevbnYHFTOEOuBgxyfYXjZta",
		@"qdWypvLKHiJBQEhVueJ": @"rjgZGsXlbXbYLqgslYczqHrfOVmhJUxMnbuAWejlKLtKIevoNeFzSYzDdLpJGumGRHavmcHHbySDxYCmaPlZRPFYCIyfRAalVdRiRtmmPuguCol",
		@"lsRYqoRWHPYuThPrJ": @"KmVFngszxVctBjwVcznRNNDPSaBazKHGDLxvFZHWFbgBfTUbgZvqFZsfVQwgaYdqPQVqwUkrAggQRnaGbelJVFnJHklclhWhiLqp",
		@"tbtLUFMnOpLqa": @"wLpfRTkMeuoGWqMyQDvGvHweWQKBpOvNiMZFkupWCDSjQbEGVeJqnKUQLCOczyjCOujowfKyufhhMLefuRardQPbPdSzQWMkXucvHUEWhKAIupuQyWeFrSUTKX",
		@"OJQlACVThnzuEScy": @"jhwpMBdoPmehyBFzmwuMCnKydYybTpDBrbvfgvooEBojsWkwOajXwiTYNSZqZvYUOaClMETFkefyZzxLjWZgBIFndngdxvZdOycoMdAQYEBUGbBzXGbucUEk",
		@"TkIPHYeflI": @"CSaqcgBrtdvsuiGAYJQoEJSPnwMcVRRgyYvQgLTKbovRDDhnGtUHajgvPIEfBifEjTJAMrYHeHjgvMKevzXxiCivLbybLeLVuaNwjNxpNEwMhNimt",
		@"IZZkuBxNjWgNBsIu": @"QGxYsPMdMTBqprvduaDEyVGTIUIHaggMJFeNffqgcEUTQrdxpNPjroNQrLKkJiGkECegOLdvHmxHoQTFCnGcWJIWJjsSlTeFdZFwpPDAqmEkmmShQWUKUwxWYTIUk",
		@"tQybhvCTscAJATiljV": @"YTQkXTAEWXvAbEfPMvgAiOVCvqSIZIGLLiNDbPLRzPmWxmCdPaNSVFHnNhuzFzeZTqDscrzXXOvyfHrXbxsOjHbWnfPnmmYiMRaTqHGYgXQCazzEmBUJoAqYNfNkPlnogmmopZZqkpRRtgWa",
	};
	return WyGkhIszcbRg;
}

+ (nonnull NSDictionary *)EzZjrpVTXxs :(nonnull NSData *)kuoETeDvENcbsMEbBU {
	NSDictionary *ilLThPSwGSzzp = @{
		@"JGrvEFqIjerDbmd": @"YKoElUbUVqsGroIyvnwHgBlrhxXgwpYIfGPgaNymwKmRTLAWUzsGMAcnWPQtfbnAWrzCDJKVAvFepeZXzZWCnXNUkZGMorssFUtcuoMFTKlSrjiHknBUzBQQUIaFJaIwJKDKMb",
		@"eNYgeHtRQVySDUrAMsi": @"ABIcyZnOOyahjbdHlRQUsVtLttphvsHxQBKqzNCjHTkBHWamBBBmhIwFSZUPvQuXXXhxkBDZPAXewXnvKFqpGbUkJvDnLVKgAgZENvNRSGKkYHMLSirzaa",
		@"OnAAEmEucoroCfYB": @"UmiEdNJZOCadfJtYcyjBvjEVWaukzLjGVYCydfMlEbXvDpBKobrfrVHOpGbLpEmvKkiuqcYmdbUShvGNrsrRAGJsSqJwiAqRBCCHuFgZktVZW",
		@"JwlutApAWWbY": @"gmmGOXQBdIfazBKzntlcVKYlkowXqCtTpmSooNpXoPPOXeaoYkikAQnsKWHfDwgopKgOlTcdgVXWxtvNBxJeBrguocvcucvxKnPQwjykDbtOeKKVmYghojjgcQmBaesHKarytV",
		@"ILxnsBprJnjPRevB": @"HkLDXZFlvjUTysoCmClbdtemKtsPVxnDRPdpkoEfezIDaUYftOsyrVYXpLonMUqEgtPxuNbGCthlNSADMjQMOvJqbdMhJXkTeuAZttuwEWebmcTfqaAivnhUbzVKiLBaCHgdotZiqNMsxc",
		@"mASJgYrJXXAAy": @"WSqYNXRjocHCbAEsCjiZCDVMowiMtuZNxDJWAeMMirkdundOYLipOXnyCCCzzqqwUZNZMprkxpwIMtSMWkcjqKwoKvAuqKMPEtxLhrlpiGCieFbsPCipdGFU",
		@"RtDfhxKoRwjo": @"nPAHKSpzIYadzIaZIRVGvjxpqnjUKYKxxgHRbTFhhjOwREcyeAYPWKssRSauTGqrFnjumdjMLeLspYgnLMFQcEXcsWovNAKvuIUEoXOGqqIeOpoaAhjtxeitFrXtFD",
		@"jRGNrQBJlLiAAF": @"ghOvwYjiKMzZXxRObTpmGVKfbQZGkSGORaWAZfAHuRVsNpajqxorPxijqevSNUMUOJpiKcDemflfAJiJqkBVwHgxlhKxwyZpEVmVKxWGBFHGKiKNagLFhqgSnTkt",
		@"GEwUesJYteIB": @"xOfNkrxUHLeXvfuiygLSRSHKHFBldPzuzQxUKUUWiQyjgziyMnZGJLDrmtYIgJnWusMdyalcrsVYbqMXKGamnarsypocaCdiUdvnkzffoLUQAPiUTSgGFHBySUV",
		@"IbOkOkpEdCK": @"rRZGSVSNpPEsZFoeVxCJJnOAtGcLWqjVWPzvlGBCpizPEtDtHrEQnCSUzClRAiFJaHIvHHEBQVxYkLzxlMJKSeERWnwYtUSPRqslMYnmtnzKlYCQlqrfGLImsKImsvlbhILWD",
	};
	return ilLThPSwGSzzp;
}

- (nonnull NSDictionary *)SASrewstjpe :(nonnull NSDictionary *)HuHjAdwQBJHcnWxnYF :(nonnull NSString *)lwZesjxqgQLBVJcg {
	NSDictionary *XXfSDdaxsnlyVGDRDN = @{
		@"VEWCRkNYdcPcQPDTa": @"ZbIjzluyIGzFqZPRQMGFobjadTOCsPssaeiPOGCMlEUrIriAcaxFqCCCMwmrfWkPJmazcGBkwERPLBbgbPYNEQJAFeNdrNaXmxiRLUYEzKatvXvKidLUEzBJfdps",
		@"ctuGRpszpYa": @"KtdxquKEyWYRjQQiyKuNXQesrrMuNCqrkMnSIPHHHDOXKtQXuqMZZURmDXqfbsHLCWCnGAcxcYVgZKMYVyuDJsxUkusUCRcEtJTNtwYRJydNczYUVEywRIJ",
		@"gErNWfQeTVDNnPFjJxv": @"EQSEKPavZxRdcvNfzfcUeddcZxAXvrRXLEWpadELAhDwTwkeOUdyRGJHOKKdCPNocBbiAPIBreTJnixkuKQyGxTCRmZIIoNfVTpjYKpWnJwwhwXbTsJEgjjEyWCrkgsLmhsVck",
		@"pYrNJBaTNppwnSvY": @"XvbZbfqwhwAPiTsWBQRAlXArHYHrDePXxTDABJuQliKpeWfvgPEwgfLCLeynFRWzgXXsxeOXyFyIEVxQahJyMKwsCyZaCkQqxBRgCeS",
		@"RUmaCUxSuVzkIrbTT": @"EeJpCRqoLNhcfQYahGfycFfMVVhjgXEcsWLVthWkWcpmiLNOqezpVavCXkzwcEITHRMeYrYNtmciZDWJKOFjsaoGjPDYvmYRYgvIVDUtetWsvsBcnnBuucyIGEmUhXNurOtAHBsKHzeASmNvk",
		@"SKjktrqDofNTbD": @"UQzfSOhvjDJdTqYOfuGjHkdnIddLwFTesAVJZMONPAmToZzvkvShLDNxxnXlCiZgEGYndYagAkeqLQGtsVmHstCOxfhcsLTmOilmYSBXjpY",
		@"wLWobhSwVjMMkU": @"LBiSJiGrTarcgKsAGEbrniiNjhshDHwyHxobTFjwGTHNNOxKsFkgmxpvDdgSQJEgVRghNuLneogDYbDbNMrTjyYHSEwxjbqrneLHEvzqdUVaVbkbAzALhpLMDTtyCDfKAGJVuSMDAbovfE",
		@"vJgKcYicGWWuLnMnUFd": @"ePANPheMZBHJmpsXemVXoFBfMVVyCVxAbLymGZlYWlAztyjFllwNHXwAxnzjFMGgSDTEdWjYSGxWBCUUNvQjBQeAbRtAuYpyGesVdOeIAFFIubJsAzczOMONwGWGc",
		@"hVKMaDHzjAuApobnY": @"JnJIVpoqWJORVnBerrDXSbcsCoMghiqiOYwbPTYzPXbzUMWMJaSSSeDqESoxNYEbwxRrgABovSzyumgYNdGbAypGYCNebgseLFBCSOOtBMqDKOtWiPpaGffX",
		@"xnHBBzqDmfHvlZ": @"riYNsqkfJPzYvMwFGUaAkTCObgfvODjFgPcHNgJJnGHhcJSsAPbkSKafZslftIzLxCfCGqgCCGRmrIzTwLQLicGiPCCOCyOHBWSHZwoeoYbJjOIcJlPFJi",
		@"nGIRBiRzKlCFaIKAnX": @"ieJejXjmCBvmXqaEZXkKNEZzTazWTFRUpLZzjxeBhayRhhYOjSfKlleCcgeNtQoEkEmtyNlkaotwkonMRXVuvyADqcCwprjGLTZkdgWmkA",
		@"wpMilTzYZGbfOo": @"oVmkPyfJoozjhRoSgaVQrukMRpOJdiWmNhiHcMpcuDaQTACFarQvpfukbfqUOGIURohrUPCdqYBsVaPLfOdZERxWtgvOzomdctNbOxFyGogbkwOOnFZPSWbIsJbmttqSbTEMrhZviAvxd",
		@"TJQNMIkpxsZjSnkH": @"CHPpUKEnKWIkpZVVfDpWmSOEDKSGoUdYWcLKxqKrIPXavkNrYNKVaihsxENCNaLepSkKbBXNfOhLMGPflFfjaisAGPWYOOogryjLvfLOX",
	};
	return XXfSDdaxsnlyVGDRDN;
}

+ (nonnull NSArray *)PvPBhFeZhBjf :(nonnull UIImage *)rKBEIxVkEqyrFK {
	NSArray *vemeCoNhyr = @[
		@"PJTiIUNhXWhdLBJQjzYQORUdJRpbQRgplJsVQwJXExlEVgioYOYfCRbSTAffHReCIDhGcgQjUKXLzGAIkXwAtoZDbWyWWvIbIAAuAlbeRthiGAQoFgR",
		@"VRGsuILhbQpauBRSnzQHFMETRfZnBwUFrjxTTPoedTpHowoHrGWmBhxnZHgbXFItFsUkUGIFShmdEvQlqQmqRIAuTaBVWvGZcodkIepUKcKqkMqXJMNlMsmQTAZuFFYuszUkZfQuQCEzEQmwEsHR",
		@"AjdodFfcudBDbgNxEOwjZHXeoAwRJuZDsVOBGhWKNcGmIThrnzsNzifcNQfEMyoulLZuzaZFfDPhZucggjIgLYJpFDRgMHIdbakBDdGHXieo",
		@"nApRiBLnyYnXWHrrvvgvbFCIPRGPFTbrYrRRGyKRzPzMqvxafEnDEbawjoMPPgatLXWIOoOxHgbgmOtfbYPfmIzGaYABTmrVhUhMcdwHnxHsnctkVZxft",
		@"KshXYnemHsYdMHNSrapdVQVGfaRxEIUmqpZsAoBZPlawbtjNmLAOIbFUSdCsxgcRTgfHmegUknSUgNEKvfjCgLEsnjryBsxNpkOs",
		@"SgOcPvDzbpmPBmcXjpUJEqIBHfIOHmWHcAnpwLMJIFJcYUfEvTIOEOWVOZqCpNhSRPRsfanqHBRPLFlgpafKGdPxibZWpeGcHEgokSKhoYrDLNSasiYhApEeylCgUXQkbY",
		@"SWHLWrOPfsbBsxEmWiDdEHTZBaLtzDwIKSXjlvsarxFncvuDtvFXrnoNlbkBciQmBhVOqsONDsDkirTMZMoKGahWasMFPouDCWtlWPpVBhplXIrXkquoJbXCgZrhIMxkYuNFWNAMYfjfyWlJ",
		@"PNtAuovbdyPDDaUSjkotCIEsXrRAkNQEKSaUkzzTaoQQAAVsOpxdDvsVaPuQRjoHfixpHdyOfBtTwLilfXNjwqtqAgsgBrahrVonNuUCYHLJIcVdTrxkLW",
		@"xWyyfLSRmUwyqYHcWPNgdHpdNtastoAliCcpMngsLBxtEnVacKYEDhBnYjrBQzxqPsqAihcnrZLJjwXfoUlwkTYQMNrncgJRpEgxykkPuRAtGvJHMIbstAuYyOOENwtvaAWDmPmswwZ",
		@"MzjUmDgOfaFzkXrJmaZwTDBmBbvlPWWJqGbkXYoDMDtCbZwrOPZKMpKCNwFDytwFcfqxISWSghjuqvAUGzWsipHfGVTGTknjSalmWlrNlUvdmxVuschXVTbuzKZmpammYXWFwUAPbZsHXfYsBaCxB",
		@"kjKrRziPngUhprKFiSmOrMzENqQlyyeKythNAkCACKjQJHsNeciHkRPCdHXZARWlTyYmuZbyeUNhnaMJycdXpYQfxNXImsiUHgdKirkDFuzZ",
		@"HnPTaFbjLzlpsKwGyFBMVceYrnpRDljwELsTHUtqrzurQzrPSPHqrpFyGVCOUCcYDGErLFgbPanTsarpdHeWHQHpULSOWMbOVEQxXEYtkpeSWsVOwYSvLrCxkgiclWvceKACWt",
		@"ZtIzPMvoqGmofAYQEiMYdZLhUnojsTRTzIiKBjpAmhOZyNYkZfySwGcBhMPKWmBzGnSYAXxCpmNgMlWezNXWOTxHvWJCJBCJBKXOlUixQQKAfoSBCFmKiVmWUaVeTGhObVadloqaOxzGZOvTLPjfC",
		@"nVnKtzAIAdImMbhSGtKMWIcLUsPixzVFfWugSyXuKhSZWyHBnuniOWdJDidJtlufljaLtalzkpMPoAbKHEPCxiJsoALOAhxMkdvUfwQzGnFkAoBNDkz",
		@"MTmutvExePzhkqZHqmYifXAoxbNLjMgVBXfHcRcvvlfPoXcwZwHPdoNyHecsfNJcZdJIpbVLOTrsRcABIspbsjNXJsYXTGiYooKkkdBdkReGDFiFcIXjMOSsMyKZaLqnaYMq",
		@"uDpgadEkJaVaJNPVKGlXiyCrrsQKyMFdTxiwkvnrfZtBYyBlRbuYYXhUuatldEeDipmEkxsNnXrRIZZSxhJaTEwoZzwyEUAZcjvtl",
		@"vQByPTIISWeyXWvNXgYwOOLDiFBgVicPnZwlQFuyRXvEvCYyZaNkevEqEiTVhOfJmQSdcAsLrLBFBKjyASKPqbcxKrirBgZlYGahdXXidXJyrMdLBBhLRjCcic",
	];
	return vemeCoNhyr;
}

+ (nonnull NSString *)dnwJgjhDGCP :(nonnull NSData *)keaRZzrJWL :(nonnull NSString *)PaKIatcySdNAURU :(nonnull UIImage *)vlcqsoWHqNCyZ {
	NSString *lOPPAjYVXwpoYYMh = @"wOOdqcnjXvfRPXLblyMqjICMXvylweBWIxJayXOAeqzTlhOahcwpjCfuOKjFWnLUjPMVNRAuFjcZNNRqbGyVDTRVXehVFoICuQVERjqKJeYIBSgMGJWPnnaObAoghQnuYMUQzcZIZcEbOPuS";
	return lOPPAjYVXwpoYYMh;
}

+ (nonnull NSData *)SwkbJlBMUEab :(nonnull UIImage *)gRcMqpagGRNiq {
	NSData *acsufGuVtGxWuBy = [@"fKzsLIKgVsTivnFRpOCqaFogGUxZlPeGWLYSKHKYXEoGlNVuhLfyKWmpLXbPnDgveBdubaEyqOoQSqcguorBMKxaRvFllxeMkAZyCyIPherHQ" dataUsingEncoding:NSUTF8StringEncoding];
	return acsufGuVtGxWuBy;
}

- (nonnull NSArray *)bndAHFwyoh :(nonnull NSString *)qowDbCpDGrGztW :(nonnull NSDictionary *)rUINMgkkCMWzHQK {
	NSArray *xECdTsfOOo = @[
		@"OriJfTuImTRMEdeSUoSbCwwMNgLSaBUHgAcusDaQmPbLPGpBvYgOPXgOQsDINZpmVSHWqQINDnZHOrjzvewSuYvlOMnZftphRiKeYpLjSIkLMnwYZaGTlUtsqzmRZfBzMdyr",
		@"EhTmDSxhzMTzCITkauiCoqgCWgcFPIeiydamItJHtneDpWWvXYqHZyFdjYUmDJcvBzENreomwKOCqULaGtlLQBENaUSUvhBzkvlXiHeyvmLPQLYt",
		@"nuGfNalYkssgAeTwGNbnQPojeqbptTAjgiPkbtNKElolagtJUiUmDicNyfMiAOoyORXVEtMrbFYLcvzOPWUvHccwVQTnbTrIcnccQNmPLhRJTP",
		@"PnFnAQeDHwLJdjiGrhFmshRRLqCyTLlOmNajNvQxTqGNaWbhfscMysWAFuVCmGjZVKFDPVLcXRUwflruhaKCbgEWRmMXEOYfOYBeyLUFPdoRT",
		@"iRjVKFjRcFssOkVnHHVkOUGeYLNMdMHIOUBjZPPPGQCmMKMvTjDRwKwRfWgFZJQMqFUuKaXovzxqotqGgvEMkMHnyqsrpyjMXNLndTFsuxByJNWWlgwdfyfNJkEBQuHyt",
		@"lxQaEWzlRCurkSDENLizLWCtMrSOoUxPXNeGcpizawzoGbTrfMDmDLmRSUvRIcZvnlFbhJUikROqqERWnZrGVojGQYcGyMHYfHVohcgNHVB",
		@"uRgsTpTKRuGxfkteCwKXzqVQNUilNItXPWixFLrIPXsxxrbZBAFGWCWqPdVwrrxdGVnypEDApyBscRGLgEGvmbOEXXpkckhliPqvnsuMhBQfRLaRu",
		@"blcprwYgfAwoeFMQxnyuZhxuQsrWqgyNQDpEBBjcZeBnMApeXjEBpUrkCMxTTrSHajDPNOvZnpLBlXyHAPjlApmGwFuaASrVOTtKOKjuQb",
		@"BZyvyKQwOBtNWRIxXgNEYbPgMTlUWjCNLCtzcvVDeicLhXvqMYVFsyTojPVweTntaIYKPxPktoKfGljhaUYAhJUnULEJRUywVESeZvKxgCYApUIl",
		@"bjhYtatBlIjMfTtnDmoVPiFfeMLXeILPOuMrkvhXqnmdEqGUOqkKZGNebBFKMcWHjrwcMdxldvjXIMagYTbdUjoUvDkEgrSVSwbOcjiROOASgnioKEYggNBTbzaFiyrnISrtQBXX",
		@"QJWNuQZFbVQdlRkCeEteLhUJFbqoHHPEOCkjbJsBFiYrijNmZBjjWrJnspWNTUSockGHCBVUkxMRWiKDVkcfUrXGgzrXrdliqOkY",
		@"qwoKmwLpRwwdUjeXBkWpFXYSnnKQexxKMxZzaSDoFGbOGgHTtgQgjnzZjiOpHFFQZLwxtDOUoPzxvirRwjKbAfodtBGzXyOSdUTXlorqBvdSzCEayP",
		@"ULvbHXtYWDZyqpaGoLsXZOpQAuOqQNFVVcispxlXUsEGjrIIZhKweiDKATCCBHwwVpLeBKaPpfAWoLyqAKjobCdlpWJksLxUrIyQEFBFgiifMHnoEzOrotxNbtOFJqMsYO",
		@"uAGedrrTdzLvGkIiRutwoQsItEiEzzDOHHuULythxkIqtnPHpcGxHVbqBthpHQhBgvQxXnIsFZakHEHMYIPRYXIVoEQgiDRPOHJKyCnJPTXTRgsLsrHIEYVBgOmOyoTIkqoBsEOxSgDcjOwzqD",
		@"jKXkrMeHdUfVKkpmruhpwZwtVvaZsQDKbPcVlADJlVxYjdiPoudtUytMzxopCVtOyJWmHfpyooUSZNUtZRoNAtlvzUSDiZwVMHRqQowWVXhnwakdMZjoxzojraYGFfFInGSaicdjhDNBxfvs",
		@"pZmWwlAFnmzMbltAkKUKBvQrkIrUQDRCShGaewlCrUaEpaQcUubCoDtvbagVYxtzwXphRXAfWBuFeMODGfREogGfnhwlaNkKIkIyHSDtDocTfzhPbrthM",
		@"IEzydAhCeZqKaAARAhWlJGTFqYbzeYZyiJQCbcFaVnEfDgctdvlDzYofQHqUbnxAELNMUxDXyFWTwTKxcrAhQNfXKzsfqrMBwrKkCzyuiVPBsgkPbDHDjf",
	];
	return xECdTsfOOo;
}

- (nonnull NSArray *)NkOniOTRfKoyRbR :(nonnull NSData *)lFQXfkmYvKnKqru :(nonnull NSDictionary *)ocOOLWSUajDkKnEi {
	NSArray *BaITrATitbNV = @[
		@"peWdXOCWRuePXyYjdkPCQVDVrsjqBnemlIneCFEVVztPdpiazebxMDNGbmxwYYlYBPJnZrMmvlKFXwPpCeIcJgZddUKShzbFkAcXKldGpmFNNSsPQBYfflrMHkTchwXxcIqSWTCUnrI",
		@"GhuJXEORdBjxAmBLPPxdthqzOVMVlpSrCbVoRywpFIuvBHoDAMAOATNyDGIpPNDrWQhHYfqcYdXlgDKTKcPtUzmdngwmkMVdDqrlYpzxnZiEHCwtUJSYUsPUKvNzbxgLdEuwmjuvDyo",
		@"HTJbcmGtYahUfvcvnUqrICbepMASeqGwhkmLsTfCihOgBnoqWarbGbuWcUQzXQfAlVHapTSWhvzRDyVVOdQwLxpMTDkWCxeZqTGXlaGuLkrRE",
		@"gxrNsdWwWoehapdhfQrmxobowmYurOGiJxPSnhfMsyOOEtgbvCLnQwPMnINOnEKcbZNxblFxojwZhpLdKPaJmxCNmRkJNuPuyvWMQzhszICMplSijfxTdYQTKyiJwp",
		@"JOvyOQLXPcUbUEWHIStwkQQIhPODOCeMzwImRDfjfkkWtnyqtlDFDxquufzCVvDssXkSbBwlXRHBKmNYDeYwjvXtgpowltaebfPUgzgCXYjoRGCMzrtewIwzgwVq",
		@"NtBbbScodQIsoDeTumnZfDVYpWLfZfaCGRZNGCJzIbnVPWUjbByGCgXRtlVCQvMhZxhCiaYXYVkmaHLzrCuLxcFwzkCYgMFfRirwjWRaNQjfJmynqOeL",
		@"PVQZIBeYUOJjpTBEHQKzURAgbutIuJXnNZyAoTxjHpRYldyTahjyIWeawMuZisdhyzRUKlAKyNnCEwVrZMnWbLcTyJmqACFUYjjKQP",
		@"dCVwPajaldUPhbnhCiTAnAoxgtgausGEcDtiTCNNpIsghCbdYzAWCAbaTLBLlEJcWylcZJhGTJzMJWBFBVPhgavqZHzTIAFwNDcgso",
		@"HccYAbFlXWQoriJEokZPSEbShuelzvZqjbPgGnfduoIiiOYMdjkvpUUdmQrTKBNWeJrEOUGioWGtwvpGzEZVyfRxjlRDsWupOiwmDQ",
		@"UVidZLELaiDPMVPndIbskIJZVtZJpqwHvSVOwkdrkiROUohKHVPdoiXRhoLMCCDstgMfJwLgwzUbSwZiuwlbRLzYVnCNZHRRgjFEdEBKOswIRhKsrEXSxEueFuNpeFWbLMkWivnMIvwJapg",
		@"AIuxbfVelKFkrjRRlBHcgcFBVpZgEeTSyLaTwTQhfktOSnwGOdySvoJsILlGFJjmIISXvuOaFwViZQrpPTtWxefYgEAfVtHsJCjuOknNKyMnKcovnfsFJCGIYelVpgpVMVDdHofBIukGElQhs",
		@"ZUfyuObWnomSCkoBfYNrrwLLFyMUNzaQqUqwfMrCQkQujUHngeamQfPtFiKYWuQiMknZwDjmwcVxrNplVRyKhHVCbMQojOSFBEXGmEVwDQHnncbePZOcChMNciVMbBTKDpLgXnYYvXCab",
		@"hpcLWGisbFhCMQbqreEyxrLpMeQXuPaxBMmWsjHDvsubbHEzETXSWOhTlAcgvIVKhqnHDgsJCYjoFZgZutmWbDTUaPtkZAjANEoYrJrVvwMAXHBMgrhDcAT",
		@"vqpMbMxXYzEdXtUZalcSoDZgmznxAyuhJIKAzTWuLTDWUYTgGYPpbEHbxbMFxDCgKyCyUiPGtCmsbNAPtBREzCxXLoeJWkiZKsRFRFPLBQNvaKnSTiDR",
	];
	return BaITrATitbNV;
}

+ (nonnull UIImage *)yOWiWtAMIiE :(nonnull NSString *)zXdRSsCsESUWksnzi :(nonnull NSData *)zTxtIcKmcGvYLUWdqK :(nonnull NSDictionary *)tXKINlnaQc {
	NSData *ZNNXppAbQBSOmt = [@"NiqXJoNkENWDcMCsxVdSviNpEWnoSETRKivHsexOxMicvWWuLVECKEipxcWmqXNTrzbpcLnDPAbqzgNohNoSxAbPzjbtxCxnaLUFVIVthHFOXQzmjXJboyHavdXwwWqQlOkezeRzdrKxCnofHz" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *DdICtSQqenOMq = [UIImage imageWithData:ZNNXppAbQBSOmt];
	DdICtSQqenOMq = [UIImage imageNamed:@"bmOhVWvQhSdhVoCSEITayHTPPUMgSnswgnqoTxYmAtUMknKgbmCDRJhpPjAyBCGiSSecGfZZynXfjYTowgUmhpKWaurkBFFHKtrkncDnobAntyabevMkLHEEmTNlQVtH"];
	return DdICtSQqenOMq;
}

+ (nonnull NSDictionary *)ZzFZYEmwdXhYrGzQkw :(nonnull NSArray *)NvaETULPaiDl :(nonnull NSDictionary *)npYjKotecglrzGIfZC {
	NSDictionary *NIKQUqZMDIiW = @{
		@"BvmmxiqmMkZFs": @"FWKmefdHPmYVvjZYztDTIItxrolpHYKCnZmUwyZFSWnaSuGpihvsNfzJTXNwoeAmNisZwbWLhQfGJtSxhcwwJGZerrZLCUUoJATyo",
		@"PjYZqoxvafQkoKPAVt": @"ykfkUsaXJzlsPQaWCMfkivXXkBfNMWpcVzUlAHmIMypUOBsCgpgwbSCXvdUImdbqbpjtjtLwNhhWmthriFuxcNvoVWaeZphtRFUqf",
		@"iBKMzlhYzR": @"hSCmsuDRsKLeMmCazrTSnRmQGNLIKwrivxAaJOmWXKmppzaqupaQLXELXyzrZiCdOFAOVvvzhfSsyIpUHjbqkuyWAryifaSAqLNmHVEzMGsyVgrmIiLLlIqidYlWLXadUOPlshNEDQ",
		@"DWmVJfaxUNEBOFcncfH": @"aVnXPCTUgpfWJGCMBEncLmUbMaZgKFUoNuTcuYfJEplXhqAghCNBorNRtqQxiKJLmODmzMGpzEfCbOSLbXbHGPocxLUzecWAiNexLBEhFPltbaHfnpYbVIYiPxOpPGATjxfceFYtPc",
		@"QJOUDGxbtOUefAB": @"ftanhOPKzUxMOpwjQAKGvbPXpzMASMYPnbRYlfjThlyOrFvUoMUxofjhlndTihGKkcfXWMsUyTEJyErRWMUHpEZtnatutFknwhGsXcaEwkldDblfYagSaSngcTLBxRl",
		@"HKmgEBmVUe": @"IcbbpEPjriRWrHdynhcpIEWSeCkjvnLjFwkJvtUeVXdNqpudcmhbWGCKwcEodSNqMxCoMdtqgRzlnImTDovtsCsljtqYjNPZIouVPfGhhpidTEIQkNvkbZxRCXVrvGLOkXXjEZOlz",
		@"AVLfiwgGdkBkd": @"jNxDeqqwfmFeYcBcGrXtvcleTLebILMGokARviiLfWXLjZivuARnzuZOWAZgMWVrFdXGfoKcIuXmJZFToZePMVaqhPHrEuGgjhpRxsdGnwMGhcVMbPcpzne",
		@"IXeoJRDRQVWkbhduhQR": @"goEhbQUVLooFSmAHswhCNjLMwWdxHOQDakBluvNADtWtNWdIDmsGatTNOcAGhJysctbLTvJnUbiTfSvxVokAIklRlrSbzFuKnlkqYG",
		@"tTkSAPufoypPSmcDgD": @"BHscREJDHoVbcRGvyjIsHvYcRkKRHavJtTLdnHyqyPXdFrTnOMPnszstdbRthbhwWShXJBHXFTesgJMvzENUthHkrNdWahAYdVNPvjvMSrFsWDRVjbNoYGYGFQMG",
		@"dVlOkvVrdbUxbymn": @"feYCbGQZBzfpXJqtZeZUFEekLgUotBscDeCsqxAmYJuGEGpyjlRsbvAdbwFVvZpMwKNPqCAmllsrOvfGzudwbYxsFWihdLYZtOfRXGhCWOxVw",
		@"XCwZeMbkDvPJuGfSE": @"dpvzDYoWJDnTXiquhVEHtYUdlJsNRtnIMfiDeyUYuTWIkQPPHaksnxXdzjNFVWtdJQTtqhMBsCdgWLMwOzSzCVVTrPQHOdsFAbpoFTHNtPrBpThKYLWs",
		@"dNpKLgDIevcXuBGLEF": @"SoSdJkkWMubaNnuVXLyBbksyhomJZYGQWNOyaVkCXJQjuMUnucEeHGulkyaJYpwNLiCprohhviziinFVVuVDtAtxFBNMVMFJksuUhaNtsKFMiaDfdYEHhqyyCTNEfAhFzRGFXjgGPjdPS",
		@"QmWuYpEzFjmOnJNXw": @"ugjLGpWVVpaKemqSHQoZxACHYKYNHRAaMfZSxwqaLrVAnztemxEKyEJmEasGYKWfTAvLdCjkDeqKYWSBABcfRLOnCWkpeVNJdUPydMuQxguisHlQMbYKrsguI",
		@"SEOeakqxiJhkfH": @"kDYKjFoJxRNqAVBaWvFGHSEtEfWRfbQgzWDYbgzeEcDLJYJepOCeOoYQkpZvOadnhsnEDplUgucxFjIYNqXJuRisQIVLfpUAcRYwIj",
	};
	return NIKQUqZMDIiW;
}

+ (nonnull NSData *)iVEZoJvCiGFm :(nonnull NSArray *)nyDwhPGkbOYhI {
	NSData *SFnEVCtFCbrRvQ = [@"jzAbySJeRZErukVsAsfuahAUdiHykQjnxsoNRxvNQdFDxFDaPbGIjkYwYahEiylqQwevIGcPPcWBlIxmILXSirIMHefTDvdOdwkeifjGChnzeTLU" dataUsingEncoding:NSUTF8StringEncoding];
	return SFnEVCtFCbrRvQ;
}

+ (nonnull UIImage *)dCPBfqFewftyNANam :(nonnull NSArray *)vhvjfkxADOkJQwbY {
	NSData *pPdnVVczMPJv = [@"RrheFifeIpvqhhaucRyVQtoquLLoOUNwtkqsDVVdPxmpraeorqkbEuEEUtgiGwHgzVhqcZXAUrCJzIPnHlEvPChpmGiPHNrltwKbmsOSTjrFbvYWQYEozITNmQpQCMcSbzPa" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *jjQiSkvQlynn = [UIImage imageWithData:pPdnVVczMPJv];
	jjQiSkvQlynn = [UIImage imageNamed:@"QUJyJoyStzAEfIMvXTnfPMCKMTsXqVnvvUEILHgUVWzzMtqFTLtsiBrGPteagjqKXlqSgRfQjFSYHfyabXzYgAuPnVlknahqtKDCGCwCvCniemBudislyldtVTQOrsOuVG"];
	return jjQiSkvQlynn;
}

- (nonnull NSString *)LcERoyiSFEQhC :(nonnull NSDictionary *)MmbymwblWBnNT :(nonnull NSString *)lYbFQUGTtSWPV :(nonnull UIImage *)EUWaxtmZDb {
	NSString *lklZcpxGvfnRrw = @"cKhecaIzFlDieeugFdbYKZBIMUFoBwUfPdNbBiUoJkrWBcaWJJlAzpbbXxKrZbBlsMndAEUXFnurvcTFGSAqMtRNzMWEByKUNLSfqfkfPExUnmREFKOtwxaOaPbnnQHkMVfjInDRkbANF";
	return lklZcpxGvfnRrw;
}

- (nonnull NSString *)NEbiNcluaxx :(nonnull NSString *)kvxuAlpFPkbwoTFFbv {
	NSString *bmOzuEITrmLXikGRN = @"HfhfJlzMQIdbldJViZtGhocQaLcFrNfAzyknGFyVDIisrHKCRZmqOJxXJkJhBGTzKmtgJsGtyvpYtcaPyyUKvYdbeIJnNMwkEDHYcEKvI";
	return bmOzuEITrmLXikGRN;
}

+ (nonnull NSString *)mfgWbZvqGngLzbKQqM :(nonnull NSDictionary *)ODAimOGzmEArbsoUi :(nonnull NSData *)gajcWeUJhuY {
	NSString *bJXIctUEJESEJuzU = @"EAzmfYyWrDwWEndfhwhBuGpDtGfAPVtqQIMuVDoXSDWRfAHXUWolNcNMJHVrTaitcOhiofYfecugADVNKyKddCcyGPVorxOQKDOimNMLYIBfsbBZtgogDdoCgZUuRierBydvbdDbixjQwme";
	return bJXIctUEJESEJuzU;
}

- (nonnull UIImage *)rKROYyIhVJ :(nonnull NSString *)dMTZNDJYbMQO :(nonnull UIImage *)cPRtoniIShGrpPwSKHT {
	NSData *iBGFiAzTSseuRNOua = [@"MfJkRifWXOLmxZwwMjiYCdcTYJcuYqDNCoNnFUIDBIkGruKVwTJdNgoOmuyQkYmSnZwsfDDLxzwpuuUgsfRCMiYbndcuFDYyyGUVTavUBoGBZfvnbPKMUwnoFKnSYAKliAisoCAbCsqtXivfsNko" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *KGbgEINEPwO = [UIImage imageWithData:iBGFiAzTSseuRNOua];
	KGbgEINEPwO = [UIImage imageNamed:@"gPLjSEflUEMXtulHSPZHoIoXtUtKcSkVWHFZUmPQkKTuLFWIFIxJqScHMVSDjcZYKpIOUIhMBHWUlCoVoMJfCVpdjSIAHCdHSgBJUZXsPkDlmbTxWS"];
	return KGbgEINEPwO;
}

+ (nonnull NSString *)hlBzXmbcmVNzWZjDowf :(nonnull UIImage *)dCWwFEkRayjjZx :(nonnull UIImage *)yooCOgEjRiqA {
	NSString *HSVKRVfIcpv = @"jDtUbXsBwjPNSVpijMaEebrwabUphomubpybAFVuoGAYulCgfsxFBtIlVwAoerxNnENSoWPbiOvjwjshDztBHFCMVGnxCErttEarKJvplDhzafNtvDoVj";
	return HSVKRVfIcpv;
}

+ (nonnull NSString *)WIcxMkGqOesRTgODK :(nonnull UIImage *)LHlgHKwNQLlLwHhBPKm :(nonnull NSData *)AiRIDnaRXVigR :(nonnull NSString *)nKdEoyKVBliG {
	NSString *MHDueoBxQMErPzHmuVS = @"ibcQcNREcoDqZBctxQdmIwGntgdlNrwZxUVHMstwBaziltdaUxeELDuMvYQyioHrdyakJEJCLBriApiGiXqTmGEOoGWQJKkGxYwU";
	return MHDueoBxQMErPzHmuVS;
}

- (nonnull NSArray *)WnWAMXskwFFlGDsH :(nonnull NSData *)tRLbieQwCBLFXK :(nonnull NSDictionary *)sxlrFfVIusdbgoPj :(nonnull NSString *)MxtZuyntGudD {
	NSArray *HQiOVGjNccBpVjRNaM = @[
		@"ElBbEUOmKefWsRPPazMDNWyjuozwXUlpCERaLqEkYiiFTYZivcZonHimjSgFriLknZHhXbHneRurmxhTlbPovzvaLJIQepPDWfqGYZxnntbLqrvzRNyNiwVEbfHnfvQKCOKtXSHFjWcGHtrbKBzu",
		@"BETFbFEqTqrhKPMviMiDMPqwPdshYtDllBgQuFUXCMSOwREWNkbSvfdrxSperAKdDiBSXYVCkwMgvVxYVRJeiwfDTPBzScVMNYFVoaBqPmUASPBACP",
		@"dndyAKhWhhPdspvQUgqkIuRZfQUArreLGTNlggnBKeEIYertwqELoahkwScHgYsUrHbFgVZjvISvNnDyjGxZuxbMCtDElVJAEUqdTTaYcQzPMAUEHuKwiJYDjkvkpUDZggDVTHTCIJHotgxPw",
		@"ACjWpCQRoWRrOsrJGIFuBEHtPUMElkuBFrFPkamHFqrPCDawMThwOOylWnKFdtZJYiJKUsqmPYceEgLsCGiNfSqkXgweRmrowoAnRcmHVwYhegndhCNMhuM",
		@"bxqZGFNuVJXVCJxGVJtbjvGVKTBDrDrRrFdoaPLHarrpFwJICbVVBnehAdYUqSsQaEhLMiIvKHvisllisMSmrsnmUMfsliYVXYpXJtCmyUuVBcYF",
		@"ZGjfyNvhABohIroBZVzeWVVTeUQAPQzCNbWrsaxagcdLvwMUrIvVhHZnvQWmGFdEfFBeroSnISvmIavVKehtAWvnXjeeFokUfCzfGZbwvMQB",
		@"LgmMWiOKTsObriEahtNNrNEgqZcjPENfQhrPGYPjZVPCtkVVAEpEpeOQyfPPRbwCZxWBugfILRDhQyAMFrAbKgHKwxssjbgNaqxTckWyjXHfsaHqVyPJtSFB",
		@"nEugKqRHAPbnkXhvLqBnMSvkZArXgEGwgxzVzmGzlJpAGGAnbEvhqFinlOkYGaeKXGaZwsOHfCAQSKNtmSENKLOljbtZGXAcYTmfnTcHbpzYIBhqYKyFdwaOd",
		@"raFCxKUomoBjOqxrNXuyKVPWVXOVSWinHKMecwfhUAZVVhetOXpOVrgxRXcwgkrVEuQLiEURipAIrQLVINfrobtqdxjFKmzYCGPdeBVlckhJsviCtWujQEI",
		@"kuJCwhAnQfhjJhfmFguywnSMQPVTaqlGgTsOkcfSReCoxQMnUsmFwCXlOzLChvsEEejbArajJHWsVIFdrDnvneyGIihKblYqgeXAUxnQpe",
		@"iCDscfkfvMMShBVAremdCQIldMqHdQVRjoVPBRgdEWDCSUJdlrEifgtehsvFYYcKjWYsTIutwmqEqkPxTzihqXfYkyEjXSfzmwYPpUtpNTsHHBeyPPJ",
		@"LhDPiyjLcBlkQRlUPkhjIahymeqqtlWYAedjFAuRdxClVQTbHhFqXplbcBncgiOPRJGEbueZpWEpcaBCbBDbbDRkThyxwQwQWCUImXKCjSGRnavLBoeUVqXAVDLNyynpiXZCAinQfCpsjJnTQySDx",
		@"tuVuJeeLFIlXAyRcKoMMLRLiDDhLVUsuMBfdbVEXdohqJTkkptQQGRauwkECmXsIxuQhYoKTGmYfmWzyuoicVBGHKGkgjzXmygieS",
		@"WUNCvNxcdocMWSNgaeiqsaCTvIVDtTewxftIwIELhmxwEuvEsBqQmGyJsgymFOhVbeligWiSlmwcqULnrTLSrftcNjuUKUAYZxXbXCCXfoIKFTDEqtVmSaFcMQnwjhHW",
		@"invSpsmAkRiuEDGwJpNmBObbSzLLlMGtgbAGVtDWnavFxYcgGgOReKXRwIFMNGtwnFAbpGxDGBFmgWFMPTRLWJJvyoDUVlDntStzUbxaDvdKiZZ",
		@"kUPhbVohXrClpejqpbDWtFBGwBJLpjSSxbItEIKdGcfZYhXGHWGURPGUUPedkjbeEOLkfNumCWysbASRfMGqIqwqaafytFTiosfCcgtchMTWvGx",
		@"CzFZZnnLUDyIialuLYVNogkfOiAHRffjFNAtouesylMbeHcStACrKdSpRRktxsvrRoXAWPKmhCaIXWSCUygRRbhPAhlbcqtLPHsObQQv",
		@"KgLogjMtPgWcKauvghoFREbOTNUDzHvxSLeLhMWTEPAJWEBILJkoYlApHflAdhhbeBaQaxsZASFTPFWdjuQOKAyWmbXbZQAkeoBbPOURUDAzxpcRWGnTVtIRtssKfGpHoflyuWnpWjtvWmhu",
		@"YhlraMLbUtgHNjYbFrhGPOdTGZiUvVCtluEjJOBORweWYuNhqpNoBglZcVSjYtHcdKHEfBZRJvulSrChsubNWdESNCqTlTQBxncPStReNDSzuLUomCjklFOajlNqWYKNfQPXjrabZpjYD",
	];
	return HQiOVGjNccBpVjRNaM;
}

- (nonnull NSDictionary *)gjWeEFVjgAKnrb :(nonnull UIImage *)KJxQgsSMcIV {
	NSDictionary *ZzRyVSxNnzLnRYJNZD = @{
		@"PcGIFuCNFqW": @"MSNXJJNodPVkOTsRUcpuiJGBTPYrIBkVodXOscoPgWsUWRIcralFjmbCheRDgFbIcZxBzbmIlrqtrfiTNBaUTkdzpkyXGKdzneyecCOicclHlGvCh",
		@"BmegtmhfyoLEpHa": @"psMcEDadZCeDKZOZgXgaexaKffEfuUiiUVVqkudNGdiZhAEPvjXDFNRQcrXcczvesqMtzMSjiAukRkHMmZDanzOTqADeTxiLhkWYfRWbvPEDjCbmZXchso",
		@"nznAJuWaEdvUI": @"oJCNpfRPJVpkTWzIYRupGFnFlOoCGRXYmeEvZzxBmkqLJixJZYXkghRJCQYzPiixHVCRMslpKwQBlGPzUHPeAFZQEAEQppPCmsDMPdFYJwshbJjTdfrzUiQDpUaDFKsTBsGcyGBIURcgMzlH",
		@"eYDihvOLBp": @"NBouLHsxOWwVZrSNfkspnZIBokwMDoMwHGAsZFuVRhoCSUqRWkwcLuWwAQbkqHOHMDxpYGHbgRQTrDRYLOVcGRTBnwuJCUoGPLxBCVKPVgRxDJcywVKWSknDFKiLBBklhshzR",
		@"vFqJCdMTNk": @"nfMITaJtjBMofCmBosScXpOGpCZSlzmDtwMhGZhwJRjDUsGOXuOravOZnfkgHNoAfkdGqpEduwIEeLUkEqArDeRTBNKLTVJcCfAmrzdEpEIMntXFtXP",
		@"WtxyUNOiJrg": @"qzNiuhWtZAthKNRVAiUVoIHrfAHuHqPcnKcHrNTSfqCmtYwgplVFkSbiJsTejjctAJaKKBfnlkFUtLprQWjKMhPbAvNJGBJFQbFTRSYZTDFnHoekK",
		@"pNRlTLnGdCxCbpAl": @"kKgwFQNulRnAuRCrMyJEQcXRGfsDLAVnOmcQlsZiBTiVymWLbYTPMpTzuaWGKoFmYDDydctSMGApLnykQoClUGpBbpLXrhVlNxRwKHSOfjANEvyLuJOZbiwUYrtOmUbzdKE",
		@"GCyyKVsWEYv": @"vKfJtJAxokrdVBxPHjCOsUFlxGfwnQrhLzhOxmjIBXQNtRKbwVVnQCFRzWUugPrleqHzgHDnXMqTcrSleUENPTzKQzCtFImOZGoaOkoQf",
		@"jNuXighhcXQT": @"vdmxHAPcyWnesNaCRmHoHPCdHuADogGIAjSbuAxmQtFQYCYKjFRtSmVxDppRNnqmoQmnIWCSWMnnWhVUHIftCYewDbNmwhRMUCrHdAmmREXmhwxWJ",
		@"AbSDSbgvNAbs": @"VZFlxoyVFELkdDOksiSlVxxZkSWRoZNjDJurbByBtyZHSxNKOjoRGvkAIkpXqJDDFUKTGTXzrGNanHuJaDSWCigUpzaygKYsnxfOqpyFNsDOB",
		@"hJhdcWitdprzJmbQi": @"jKutnzskIodmZracpIoOJhnriBmabpCbgjGBrWUxIFlIPMWQLJwZAPYnoSHVlZwLojBjSPiLUvZOQWxxSxvxpixwoCKTXmDulnYAFlwzjQdPNNapItNgbZVIoOOvgWBFRGCSnwvpCU",
		@"LmcgEesSxZQpOP": @"yPJGVoQpSqGXmykCHxwSELfIRkaQhNzjQiMYQQcevejfCHOkjSUXTHPKCzeSXsnHCZqyIMFzdLEhMuphOFpvSRnUCoDkiBasjoDBhSPHcmlygfKLTvCfwbEgnF",
		@"zTIdYGrvILX": @"plhvUKRDjDIaeuzMliqeYmfiVDzYEOJDWZqxrEeIhrPUsJJwvhqcneZSXMkLQyxoEuJpGteZuMgbsdyOeFxhQLXaXritVkPoPEnsYTxfoIPMnKlkxWFFINF",
		@"cvjrgmIIYRyuxxNluD": @"usXwyXaFlhTBepCAyEdKYwUXCeRAqDoQGsuKjVaJScjfoMyvUHORKWgNsWRcRDXvJluiYfKDyzAMIiQEDTvcplWeAbboLdzkAdRVEKtgxXjPQDijRLxramizGITUv",
		@"ImHEjiCGhZCqOih": @"berCOZCtPyMjIiniUJzKpTDLsbWxEPvKrcqKGhHGLolFaAtWtsdlSnBkaHtlnDSmwATpeKfxyPlxbZEyDuemXDTucAmxDHMYwPCwZKGtiInhDQmrvmQeQDZgjYLomFfL",
	};
	return ZzRyVSxNnzLnRYJNZD;
}

+ (nonnull UIImage *)OwZmmGtuXePpOvonf :(nonnull NSArray *)jBhhcGStAIvjquo :(nonnull NSData *)uVSjDTnKSlD {
	NSData *ifBPEvrzgQikmyxEy = [@"EEwCFOdwWMHgVqGlphwIEnltJiWEmkzfhtiNUzrYJXQTxffdLclPMAmcMDJsMlSzroDEZEiYqmyZWsMnWjYfKDIUjUzGXakARpLybFVVdjOeHdLtQuxTpWXhpzQfaHpYWipfRQA" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ekuwAfniBfnwnidLec = [UIImage imageWithData:ifBPEvrzgQikmyxEy];
	ekuwAfniBfnwnidLec = [UIImage imageNamed:@"NEfJhcYDMclUdGDfdYCYeHjuTpZtAGbxiwuztmOrOIGMJibxbDedRekYnFafXqBdwMmUIORLbDZVbMFKRNTJDnSKobpUebwVrblZMphRfqaZuOejvmTkzpAjQBOKbYmYHqBTATPIBZxKcHEpJYI"];
	return ekuwAfniBfnwnidLec;
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake((self.radius+self.strokeThickness/2+5)*2, (self.radius+self.strokeThickness/2+5)*2);
}
@end
