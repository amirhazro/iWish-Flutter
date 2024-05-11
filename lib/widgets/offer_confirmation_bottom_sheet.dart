import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/modules/offers/models/offers_response_model.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/utils/utils.dart';
import 'package:iwish_flutter/widgets/back_button.dart';
import 'package:iwish_flutter/widgets/image_widget.dart';
import 'package:iwish_flutter/widgets/primary_button.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iwish_flutter/widgets/trip_to_from_widget.dart';

class OfferConfirmationBottomSheet extends StatelessWidget {
  final Offers item;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  const OfferConfirmationBottomSheet({
    super.key,
    required this.item,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Utils.dismissKeyboard(context),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 32.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TopBarBackButton(
                      iconPath: AppAssets.icBackCross,
                      width: 33.sp,
                      height: 33.sp,
                      iconWidth: 15.w,
                      iconHeight: 15.h,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: TextWidget(
                      text: AppLocalizations.of(context)!.confirmation,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: ThemeColors().black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              TextWidget(
                text:
                    'Are you sure that you want to select Ahmed\'s offer for your order delivery?',
                fontSize: 14.sp,
                fontWeight: FontWeight.w300,
                color: ThemeColors().grey,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 24.h,
              ),
              _offersListItem(context),
              SizedBox(
                height: 24.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      titleText: AppLocalizations.of(context)!.cancel,
                      onPressed: onCancel,
                      backgroundColor: ThemeColors().transparent,
                      foregroundColor: ThemeColors().black,
                      textSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      buttonRadius: 8.sp,
                      width: 156.w,
                      height: 50.h,
                      borderSide: BorderSide(
                        color: ThemeColors().secondaryColorOne,
                        width: 1,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                    child: PrimaryButton(
                      titleText: AppLocalizations.of(context)!.confirm,
                      onPressed: onConfirm,
                      backgroundColor: ThemeColors().secondaryColorTwo,
                      foregroundColor: ThemeColors().black,
                      textSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      buttonRadius: 8.sp,
                      width: 156.w,
                      height: 50.h,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _offersListItem(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: ThemeColors().culturedTwo,
        borderRadius: BorderRadius.circular(12.sp),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ImageWidget(
                imagePath: '',
                width: 30.w,
                height: 30.h,
                fit: BoxFit.cover,
                borderRadius: 6.sp,
              ),
              SizedBox(
                width: 8.w,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextWidget(
                          text:
                              '${item.traveler?.firstName ?? ''} ${item.traveler?.lastName ?? ''}',
                          color: ThemeColors().homeTopCardTextColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 11.sp,
                        ),
                        SizedBox(
                          width: 8.sp,
                        ),
                        Image.asset(
                          AppAssets.icVarifiedProfilePic,
                          width: 13.w,
                          height: 13.h,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          AppAssets.icRating,
                          width: 12.w,
                          height: 12.h,
                        ),
                        SizedBox(
                          width: 6.sp,
                        ),
                        TextWidget(
                          text: '${item.traveler?.userRating ?? 0}',
                          color: ThemeColors().homeTopCardTextColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 10.sp,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
                decoration: BoxDecoration(
                    color: ThemeColors().white,
                    borderRadius: BorderRadius.circular(12.sp)),
                child: Row(
                  children: [
                    TextWidget(
                      text: (item.totalPrice ?? 0).toString(),
                      color: ThemeColors().homeTopCardTextColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    TextWidget(
                      text: item.currencyCode ?? 'USD',
                      color: ThemeColors().homeTopCardTextColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 11.sp,
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          ToFromWidget(
              toCity: item.trip?.toCity?.name ?? '',
              fromCity: item.trip?.fromCity?.name ?? '',
              toCountry: item.trip?.toCity?.countriesMaster?.iso3 ?? '',
              fromCountry: item.trip?.fromCity?.countriesMaster?.iso3 ?? '',
              date: item.trip?.departureDate ?? DateTime.now().toString()),
        ],
      ),
    );
  }
}
