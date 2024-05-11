import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/utils/utils.dart';
import 'package:iwish_flutter/widgets/back_button.dart';
import 'package:iwish_flutter/widgets/primary_button.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MakeOfferConfirmationBottomSheet extends StatelessWidget {
  final VoidCallback onPressed;
  final String productName;
  final String totalQuantity;
  final String priceOfProduct;
  final String totalPrice;
  final String vat;
  final String iwishFee;
  final String shippingCost;
  final String totalValue;
  final String unit;
  final bool isUpdate;
  const MakeOfferConfirmationBottomSheet({
    super.key,
    required this.onPressed,
    required this.totalPrice,
    required this.vat,
    required this.iwishFee,
    required this.shippingCost,
    required this.totalValue,
    required this.unit,
    required this.productName,
    required this.totalQuantity,
    required this.priceOfProduct,
    this.isUpdate = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Utils.dismissKeyboard(context),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 32.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TopBarBackButton(
                      iconPath: AppAssets.icBackCross,
                      width: 33.sp,
                      height: 33.sp,
                      iconWidth: 11.w,
                      iconHeight: 11.h,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
              TextWidget(
                text: AppLocalizations.of(context)!.confirmation,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: ThemeColors().black,
              ),
              SizedBox(
                height: 16.h,
              ),
              TextWidget(
                text: AppLocalizations.of(context)!.confirmationDetail,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: ThemeColors().black,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 24.h,
              ),
              productDetailContainer(
                context,
                AppLocalizations.of(context)!.productName,
                productName,
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: productDetailContainer(
                      context,
                      AppLocalizations.of(context)!.price,
                      '$unit $priceOfProduct',
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: productDetailContainer(
                      context,
                      AppLocalizations.of(context)!.quantity,
                      totalQuantity,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: AppLocalizations.of(context)!.totalPrice,
                    color: ThemeColors().black,
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                  ),
                  TextWidget(
                    text: '$totalPrice $unit',
                    color: ThemeColors().black,
                    fontWeight: FontWeight.w300,
                    fontSize: 14.sp,
                  )
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: AppLocalizations.of(context)!.vAT,
                    color: ThemeColors().black,
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                  ),
                  TextWidget(
                    text: '$vat $unit',
                    color: ThemeColors().black,
                    fontWeight: FontWeight.w300,
                    fontSize: 14.sp,
                  )
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: AppLocalizations.of(context)!.shippingFees,
                    color: ThemeColors().black,
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                  ),
                  TextWidget(
                    text: '$shippingCost $unit',
                    color: ThemeColors().black,
                    fontWeight: FontWeight.w300,
                    fontSize: 14.sp,
                  )
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: AppLocalizations.of(context)!.iwishFee,
                    color: ThemeColors().black,
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                  ),
                  TextWidget(
                    text: '$iwishFee $unit',
                    color: ThemeColors().black,
                    fontWeight: FontWeight.w300,
                    fontSize: 14.sp,
                  )
                ],
              ),
              Divider(
                color: ThemeColors().greyDivider,
              ),
              Row(
                children: [
                  TextWidget(
                    text: AppLocalizations.of(context)!.total,
                    color: ThemeColors().black,
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  TextWidget(
                    text: AppLocalizations.of(context)!.taxInclusive,
                    color: ThemeColors().philippineGray2,
                    fontWeight: FontWeight.w300,
                    fontSize: 14.sp,
                  ),
                  const Spacer(),
                  TextWidget(
                    text: '$totalValue $unit',
                    color: ThemeColors().black,
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                  )
                ],
              ),
              SizedBox(height: 32.h),
              PrimaryButton(
                titleText: isUpdate
                    ? AppLocalizations.of(context)!.updateOffer
                    : AppLocalizations.of(context)!.makeAnOffer,
                onPressed: onPressed,
                backgroundColor: ThemeColors().primaryColorOne,
                foregroundColor: ThemeColors().black,
                textSize: 14.sp,
                fontWeight: FontWeight.w500,
                buttonRadius: 8.sp,
                width: Get.width,
                height: 50.h,
                borderSide: BorderSide(
                  color: ThemeColors().secondaryColorOne,
                  width: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget productDetailContainer(BuildContext context, String title, String desc,
      {bool isUrl = false, double? width}) {
    if (isUrl) {
      return Container(
        width: width,
        decoration: BoxDecoration(
          color: ThemeColors().greySocialButtons,
          borderRadius: BorderRadius.circular(12.sp),
        ),
        padding: EdgeInsets.all(12.sp),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: title,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: ThemeColors().homeTopCardTextColor,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  TextWidget(
                    text: desc,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: ThemeColors().homeTopCardTextColor,
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () async {},
                child: Image.asset(
                  AppAssets.icUrl,
                  width: 25.w,
                  height: 25.h,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        width: Get.width,
        decoration: BoxDecoration(
          color: ThemeColors().greySocialButtons,
          borderRadius: BorderRadius.circular(12.sp),
        ),
        padding: EdgeInsets.all(12.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: title,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: ThemeColors().homeTopCardTextColor,
            ),
            SizedBox(
              height: 4.h,
            ),
            TextWidget(
              text: desc,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: ThemeColors().homeTopCardTextColor,
            )
          ],
        ),
      );
    }
  }
}
