//
//  SearchDoctorModel.h
//  
//
//  Created by Denny on 16/7/18.
//
//

#import <Foundation/Foundation.h>

@interface SearchDoctorModel : NSObject
@property (nonatomic,strong)NSString *aboutMe;
@property (nonatomic,strong)NSString *clinicId;
@property (nonatomic,strong)NSString *clinicName;
@property (nonatomic,strong)NSString *doctorId;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *photo;
@property (nonatomic,strong)NSString *practitionerNo;

-(id)initWithDic:(NSDictionary *)dic;
@end
