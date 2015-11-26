//
//  TextAttributeItem.m
//  Wish
//
//  Created by lost on 15/7/14.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import "UIAttributeItem.h"

#define HTLight_FontName @"STHeitiSC-Light"
#define HTRegular_FontName @"STHeitiSC-Regular"

@implementation UIAttributeItem

@synthesize color = color_;
@synthesize font = font_;

//+(UIAttributeItem*)attributeforStyle:(TextStyle)type
//{
//    UIAttributeItem* attribute = [(UIAttributeItem*)[self alloc] init];
//    switch (type) {
//        case Login_Button:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:13.0];
//            attribute.color = COLOR4RGB(46, 30, 22);
//            break;
//        case Login_ForgetPassword_Text:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:12.0];
//            attribute.color = COLOR4RGB(102, 102, 102);
//            break;
//        case SignUp_Placeholder_Text:
//        case SignUp_SexButton_Text:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:13.0];
//            attribute.color = COLOR4RGB(184, 199, 209);
//            break;
//        case SignUp_SexButton_HighLight_Text:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:13.0];
//            attribute.color = COLOR4RGB(245, 123, 110);
//            break;
//        case Main_IndexWishItem_Widget:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:10.0];
//            attribute.color = COLOR4RGB(102, 102, 102);
//            break;
//        case Main_IndexWishItem_Gift:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:12.0];
//            attribute.color = COLOR4RGB(102, 102, 102);
//            break;
//        case Main_IndexWishItem_Name:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:10.0];
//            attribute.color = COLOR4RGB(48, 48, 48);
//            break;
//        case Main_Index_Segment_Text:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:14.0];
//            attribute.color = COLOR4RGB(255,76,48);
//            break;
//        case Main_Index_Segment_Text_Selected:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:14.0];
//            attribute.color = COLOR4RGB(255,255,255);
//            break;
//        case Found_TopTagCell_Num:
//        case Normal_WishItem_TextName:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:10.0];
//            attribute.color = COLOR4RGB(184, 199, 209);
//            break;
//        case Main_IndexWishItem_Widget_PhotoNum:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:10.0];
//            attribute.color = [UIColor whiteColor];
//            break;
//        case Main_IndexWishItem_Text:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:14.0];
//            attribute.color = COLOR4RGB(48, 48, 48);
//            break;
//        case Main_IndexWishItem_TextTag:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:13.0];
//            attribute.color = COLOR4RGB(0, 0, 0);
//            break;
//        case Main_IndexWishItem_MerchantName:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:16.0];
//            attribute.color = COLOR4RGB(255, 76, 48);
//            break;
//        case Main_IndexWishItem_Distance:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:10.0];
//            attribute.color = COLOR4RGB(153, 153, 153);
//            break;
//        case Normal_WishItem_TextTag:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:13.0];
//            attribute.color = COLOR4RGB(0, 0, 0);
//            break;
//        case Normal_WishItem_Text:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:13.0];
//            attribute.color = COLOR4RGB(48, 48, 48);
//            break;
//        case Login_86:
//        case Found_TopLastButton_Text:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:13.0];
//            attribute.color = COLOR4RGB(48, 48, 48);
//            break;
//        case Normal_WishItem_TextCity:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:10.0];
//            attribute.color = COLOR4RGB(190, 190, 190);
//            break;
//        case Info_WishItem_TextTag:
//            attribute.font = [UIFont fontWithName:HTRegular_FontName size:19.0];
//            attribute.color = COLOR4RGB(4, 4, 4);
//            break;
//        case Info_WishItem_Text:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:17.0];
//            attribute.color = COLOR4RGB(48, 48, 48);
//            break;
//        case Info_Addr_Name:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:19.0];
//            attribute.color = COLOR4RGB(246, 131, 120);
//            break;
//        case Person_Text_Name:
//        case Found_TopTagCell_Text:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:14.0];
//            attribute.color = COLOR4RGB(48, 48, 48);
//            break;
//        case Info_NickName:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:16.0];
//            attribute.color = COLOR4RGB(48, 48, 48);
//            break;
//        case Info_Commit_Title:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:14.0];
//            attribute.color = COLOR4RGB(0, 0, 0);
//            break;
//        case Info_Commit_Content:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:14.0];
//            attribute.color = COLOR4RGB(48, 48, 48);
//            break;
//        case Info_OfferRevordContent_Text:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:19.0];
//            attribute.color = COLOR4RGB(48, 48, 48);
//            break;
//        case Info_User_LastLocation:
//        case Info_Wish_ReleaseTime:
//        case Info_WishState_Finsh_Text:
//        case JM_TextTimeContent:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:10.0];
//            attribute.color = COLOR4RGB(153, 153, 153);
//            break;
//        case Info_WishState_Text:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:10.0];
//            attribute.color = COLOR4RGB(156, 160, 139);
//            break;
//        case Info_OfferRevord_Text:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:14.0];
//            attribute.color = COLOR4RGB(255, 103, 60);
//            break;
//        case Info_Toolbar_Widget_PhotoNum:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:14.0];
//            attribute.color = COLOR4RGB(102, 102, 102);
//            break;
//        case Info_Footer_Text:
//        case Info_Addr_Text:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:12.0];
//            attribute.color = COLOR4RGB(102, 102, 102);
//            break;
//        case info_Praise_Button:
//        case Info_Commit_FistApply:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:14.0];
//            attribute.color = COLOR4RGB(102, 102, 102);
//            break;
//        case Info_Toolbar_ButtonText:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:14.0];
//            attribute.color = COLOR4RGB(102, 102, 102);
//            break;
//        case Info_Toolbar_ButtonText_Disable:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:14.0];
//            attribute.color = COLOR4RGB(153, 153, 153);
//            break;
//        case Info_Commit_Name:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:14.0];
//            attribute.color = COLOR4RGB(0, 0, 0);
//            break;
//        case Person_Header_Text:
//        case Main_NavBar_Location_Text:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:12.0];
//            attribute.color = COLOR4RGB(48, 48, 48);
//            break;
//        case Person_Header_Addr_Text:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:11.0];
//            attribute.color = COLOR4RGB(153, 153, 153);
//            break;
//        case Person_Header_Button_Text:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:12.0];
//            attribute.color = COLOR4RGB(245, 123, 110);
//            break;
//        case Person_Column_Text_HighLight:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:12.0];
//            attribute.color = COLOR4RGB(246, 131, 120);
//            break;
//        case Person_Header_LastDistance_Text:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:12.0];
//            attribute.color = COLOR4RGB(102, 102, 102);
//            break;
//        case Person_Header_Tag_Text:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:12.0];
//            attribute.color = COLOR4RGB(48, 48, 48);
//            break;
//        case Person_Header_Signature_Text:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:14.0];
//            attribute.color = COLOR4RGB(48, 48, 48);
//            break;
//        case Post_TagButton_Text:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:15.0];
//            attribute.color = COLOR4RGB(245, 123, 110);
//            break;
//        case Person_Social_Title:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:13.0];
//            attribute.color = COLOR4RGB(102, 102, 102);
//            break;
//        case Person_Social_Text:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:14.0];
//            attribute.color = COLOR4RGB(48, 48, 48);
//            break;
//        case Person_Social_DetailText:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:14.0];
//            attribute.color = COLOR4RGB(102, 102, 102);
//            break;
//        case Post_Location_Info:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:13.0];
//            attribute.color = [UIColor colorWithHexColorString:@"999999"];
//            break;
//        case Post_Wish_Content:
//        case Info_Commit_Time:
//        case Person_Column_Text_Normal:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:14.0];
//            attribute.color = COLOR4RGB(153, 153, 153);
//            break;
//        case DP_Merchant_Title:
//        case DP_Filter_TableCell_Text:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:14.0];
//            attribute.color = [UIColor colorWithHexColorString:@"333333"];
//            break;
//        case DP_Merchant_AvgPrice:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:10.0];
//            attribute.color = [UIColor colorWithHexColorString:@"333333"];
//            break;
//        case DP_Merchant_Regin:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:11.0];
//            attribute.color = COLOR4RGB(145, 145, 145);
//            break;
//        case DP_Merchant_Distance:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:10.0];
//            attribute.color = COLOR4RGB(145, 145, 145);
//            break;
//        case DP_MerchantInfo_Title:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:17.0];
//            attribute.color = [UIColor colorWithHexColorString:@"333333"];
//            break;
//        case DP_MerchantInfo_PhotoCount:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:14.0];
//            attribute.color = [UIColor colorWithHexColorString:@"ffffff"];
//            break;
//        case DP_MerchantInfo_Address:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:15.0];
//            attribute.color = [UIColor colorWithHexColorString:@"333333"];
//            break;
//        case DP_Filter_Bar_Text:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:12.0];
//            attribute.color = [UIColor colorWithHexColorString:@"333333"];
//            break;
//        case DP_Filter_SerchBar_Text:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:14.0];
//            attribute.color = [UIColor colorWithHexColorString:@"919191"];
//            break;
//        case Post_Location_Title:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:15.0];
//            attribute.color = [UIColor colorWithHexColorString:@"333333"];
//            break;
//        case JM_TextContent:
//        case JM_TextVoicetime_Text:
//        case JM_TextHeadBar_Text:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:15];
//            attribute.color = COLOR4RGB(48, 48, 48);
//            break;
//        case JM_HeaderTitleText:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:15];
//            attribute.color = COLOR4RGB(48, 48, 48);
//            break;
//        case JM_HeaderDetailText:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:10];
//            attribute.color = COLOR4RGB(48, 48, 48);
//            break;
//        case Info_Commit_Submmit:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:14];
//            attribute.color = COLOR4RGB(255,231,222);
//            break;
//        case Info_Focus_Button:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:13.0];
//            attribute.color = COLOR4RGB(246, 131, 120);
//            break;
//        case Post_Gift_Text:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:13.0];
//            attribute.color = COLOR4RGB(255, 255, 255);
//            attribute.shadowColor = [UIColor blackColor];
//            break;
//        case Post_Gift_Tip:
//            attribute.font = [UIFont fontWithName:HTLight_FontName size:14.0];
//            attribute.color = COLOR4RGB(48, 48, 48);
//            break;
//        default:
//            break;
//    }
//    
//    return attribute;
//}
//
//- (void) dealloc
//{
//    self.font = nil;
//    self.color = nil;
//    self.shadowColor = nil;
//}
//
//+(NSDictionary*)dicforTextStyle:(TextStyle)type
//{
//    UIColor* color;
//    UIFont* font;
//    
//    switch (type) {
//        case Main_NavBar_Titile:
//            font = [UIFont fontWithName:HTLight_FontName size:18.0];
//            color = COLOR4RGB(255, 255, 255);
//            break;
//        case Post_ButtonItem_Text:
//            font = [UIFont fontWithName:HTLight_FontName size:14.0];
//            color = [UIColor whiteColor];
//            break;
//        case Main_TabBarItem_Title:
//            font = [UIFont fontWithName:HTLight_FontName size:10.0];
//            color = COLOR4RGB(102, 102, 102);
//            break;
//        case Main_TabBarItem_Title_Selected:
//            font = [UIFont fontWithName:HTLight_FontName size:10.0];
//            color = COLOR4RGB(0, 136, 249);
//            break;
//        case Main_NavBar_Location_Text:
//            font = [UIFont fontWithName:HTLight_FontName size:12.0];
//            color = COLOR4RGB(255, 255, 255);
//            break;
//        case Main_Index_Segment_Text:
//            font = [UIFont fontWithName:HTLight_FontName size:14.0];
//            color = [UIColor colorWithHexColorString:@"499dee"];
//            break;
//        case Main_Index_Segment_Text_Selected:
//            font = [UIFont fontWithName:HTLight_FontName size:14.0];
//            color = COLOR4RGB(255, 255, 255);
//            break;
//        default:
//            break;
//    }
//    
//    return @{
//             NSForegroundColorAttributeName: color,
//             NSFontAttributeName: font
//             };
//}
//
//+(UIColor*)colorforColorStyle:(ColorStyle)type
//{
//    UIColor* color = [UIColor blackColor];
//    switch (type) {
//        case Login_LoginRegiserButton_BackGround:
//            color = COLOR4RGB(245, 83, 76);
//            break;
//        case Login_LoginView_BackGround:
//            color = COLOR4RGB(246, 247, 249);
//            break;
//        case Login_LoginButton_Background:
//        case Main_NavBar_Background:
//            color = COLOR4RGB(0, 136, 249);
//            break;
//        case Setting_ChangeBtn_Active_Background:
//            color = [UIColor colorWithHexColorString:@"ffe7de"];
//            break;
//        case Main_TabBar_Background:
//            color = [UIColor whiteColor];
//            break;
//        case Main_Collection_Background:
//            color = COLOR4RGB(249,249,249);
//            break;
//        case IndexWish_LocationButton_Background:
//            color = [UIColor colorWithHexColorString:@"f8f8f8"];
//            break;
//        case Index_Segment_Border:
//            color = [UIColor colorWithHexColorString:@"ffffff"];
//            break;
//        case Index_Segment_Background:
//            color = [UIColor colorWithHexColorString:@"ffffff"];
//            break;
//        case Index_Segment_Selected_Background:
//            color = [UIColor colorWithHexColorString:@"499dee"];
//            break;
//        case Index_DividLine:
//            color = [UIColor colorWithHexColorString:@"e5e6ea"];
//            break;
//        case Found_TopLastWish_Background:
//            color = COLOR4RGB(249,249,249);
//            break;
//        case Normal_WishItemCell_DividLine:
//            color = COLOR4RGB(235,235,235);
//            break;
//        case Normal_TopLastWish_Background:
//            color = COLOR4RGB(246,250,249);
//            break;
//        case Info_Collection_Background:
//            color = COLOR4RGB(249,249,249);
//            break;
//        case Info_WishState_Background:
//            color = COLOR4RGB(242,252,247);
//            break;
//        case Info_WishState_Finsh_Background:
//            color = COLOR4RGB(249,249,249);
//            break;
//        case Info_Toolbar_Background:
//            color = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.8];
//            break;
//        case Person_Header_Background:
//            color = COLOR4RGB(255,255,255);
//            break;
//        case Person_Header_Tag_Background:
//            color = [UIColor colorWithHexColorString:@"f9f9f9"];
//            break;
//        case Person_Header_Button_Background:
//            color = COLOR4RGB(255,231,222);
//            break;
//        case Person_Column_Background:
//            color = COLOR4RGB(251,242,247);
//            break;
//        case Person_Column_MiddleLine:
//            color = COLOR4RGB(235,235,235);
//            break;
//        case Post_TagButton_Background:
//            color = COLOR4RGB(253,240,232);
//            break;
//        case DPInfo_PhotoCount_Background:
//            color = COLOR4RGBA(0,0,0,0.7);
//            break;
//        case DPInfo_GotoThereBtn_Background:
//            color = COLOR4RGB(250,167,159);
//            break;
//        case DP_Filter_Rough_Background:
//            color = [UIColor colorWithHexColorString:@"f5f5f5"];
//            break;
//        case DP_Filter_Sub_Background:
//            color = [UIColor whiteColor];
//            break;
//        case DP_Filter_TabelCell_DivColor:
//            color = [UIColor colorWithHexColorString:@"c8c8c8"];
//            break;
//        case Setting_ChangeDataBtn_Background:
//            color = COLOR4RGB(222,222,222);
//            break;
//        case Post_Gift_Collection_Background:
//            color = [UIColor colorWithHexColorString:@"e9e9e9"];
//            break;
//        default:
//            break;
//    }
//    return  color;
//}

+ (NSString *)getCurrentUserPhotoSavePath
{
    NSString *userPhotoFileName = [NSString stringWithFormat:@"%ud_userPhoto.png", arc4random()];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *userPhotoSavePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:userPhotoFileName];
    
    return userPhotoSavePath;
}

//+ (NSString*)parseIndexWishImageURL:(NSString*)url
//{
//    return [NSString stringWithFormat:@"%@%@?%d*%d",WISH_URL_GetImage,url,900,900];
//}
//
//+ (NSString*)parseIndexWishSmallImageURL:(NSString*)url
//{
//    return [NSString stringWithFormat:@"%@%@?%d*%d",WISH_URL_GetImage,url,600,600];
//}
//
//+ (NSString*)parseUserAvatarImageURL:(NSString*)url
//{
//    return [NSString stringWithFormat:@"%@%@?%d*%d",WISH_URL_GetImage,url,400,400];
//}
//
//+ (NSString*)parseUserAvatarSmallImageURL:(NSString*)url
//{
//    return [NSString stringWithFormat:@"%@%@?%d*%d",WISH_URL_GetImage,url,200,200];
//}
//
//+ (NSString*)parseGiftImageURL:(NSString*)url
//{
//    return [NSString stringWithFormat:@"%@%@",WishWebSite,url];
//}

@end
