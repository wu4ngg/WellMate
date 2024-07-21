import 'dart:developer';

import 'package:app_well_mate/components/snack_bart.dart';
import 'package:app_well_mate/providers/cart_page_provider.dart';
import 'package:app_well_mate/screen/drug/medicine_order/widget_buy_medicine.dart';
import 'package:app_well_mate/screen/drug/medicine_order/widget_complete_medicine.dart';
import 'package:app_well_mate/screen/drug/medicine_order/widget_payment_medicine.dart';
import 'package:app_well_mate/screen/drug_cart.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:app_well_mate/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:app_well_mate/screen/drug/medicine_order/widget_prescriptionstatus_medicine.dart';

class MedicinesOrder extends StatefulWidget {
  const MedicinesOrder({super.key});

  @override
  State<MedicinesOrder> createState() => _MedicinesOrderState();
}

class _MedicinesOrderState extends State<MedicinesOrder> {
  int _currentPageIndex = 0;
  final PageController _pageController = PageController();
  final List<Widget> _pages = [
    const WidgetBuyMedicine(),
    const WidgetPaymentMedicine(),
    const WidgetCompleteMedicine(),
  ];
  final List<String> _tittle = [
    "Mua thuốc",
    "Thanh toán",
    "Hoàn tất",
  ];

  void _nextPage(BuildContext context) {
    final cartProvider = Provider.of<CartPageProvider>(context, listen: false);

    if (_currentPageIndex == 1 && cartProvider.selectedAddress == null) {
      showCustomSnackBar(context, "Vui lòng chọn địa chỉ giao hàng");
      return;
    }

    if (_currentPageIndex < 2) {
      setState(() {
        _currentPageIndex++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartPageProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Text(
                _tittle[_currentPageIndex],
                key: ValueKey(_tittle[_currentPageIndex]),
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: _pages.length,
                  axisDirection: Axis.horizontal,
                  effect: const SlideEffect(
                    spacing: 8.0,
                    radius: 4.0,
                    dotWidth: 36.0,
                    dotHeight: 10.0,
                    strokeWidth: 1,
                    dotColor: AppColors.greyColor,
                    activeDotColor: AppColors.primaryColor,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    children: _pages,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tổng tiền",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(
                      convertCurrency(value.totalPrice),
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _currentPageIndex != _pages.length - 1
                              ? FilledButton(
                                  onPressed: () {
                                    if (_currentPageIndex > 0) {
                                      setState(() {
                                        _currentPageIndex--;
                                      });
                                      _pageController.animateToPage(
                                        _currentPageIndex,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeInOutCubicEmphasized,
                                      );
                                    } else {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return const CartPage();
                                        },
                                      ));
                                    }
                                  },
                                  child: const Text("Quay lại"),
                                )
                              : const SizedBox.shrink(),
                          _currentPageIndex != _pages.length - 1
                              ? ElevatedButton(
                                  onPressed: () => _nextPage(context),
                                  child: const Text("Tiếp theo"),
                                )
                              : Expanded(
                                  child: SizedBox(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const WidgetPrescriptionstatusMedicine(),
                                          ),
                                        );
                                      },
                                      child: const Text("Tiến hành thanh toán"),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
