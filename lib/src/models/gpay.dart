import 'dart:io';

import 'package:pay/pay.dart';
import 'package:flutter/material.dart';

import '../../Services/Payments API/payment_configurations.dart';

class UPI_Pay extends StatefulWidget {
  const UPI_Pay({super.key});

  @override
  State<UPI_Pay> createState() => _UPI_PayState();
}

class _UPI_PayState extends State<UPI_Pay> {
  String os = Platform.operatingSystem;
  var applePayButton = ApplePayButton(
    paymentConfiguration: PaymentConfiguration.fromJsonString(defaultApplePay),
    paymentItems: const [
      PaymentItem(
        label: 'Item A',
        amount: '0.01',
        status: PaymentItemStatus.final_price,
      ),
      PaymentItem(
        label: 'Item B',
        amount: '0.01',
        status: PaymentItemStatus.final_price,
      ),
      PaymentItem(
        label: 'Total',
        amount: '0.02',
        status: PaymentItemStatus.final_price,
      )
    ],
    style: ApplePayButtonStyle.black,
    width: double.infinity,
    height: 50,
    type: ApplePayButtonType.buy,
    margin: const EdgeInsets.only(top: 15.0),
    onPaymentResult: (result) => debugPrint('Payment Result $result'),
    loadingIndicator: const Center(
      child: CircularProgressIndicator(),
    ),
  );

  var googlePayButton = GooglePayButton(
    paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
    paymentItems: const [
      PaymentItem(
        label: 'Item A',
        amount: '0.02',
        status: PaymentItemStatus.final_price,
      ),
      PaymentItem(
        label: 'Item B',
        amount: '0.02',
        status: PaymentItemStatus.final_price,
      ),
      PaymentItem(
        label: 'Total',
        amount: '0.04',
        status: PaymentItemStatus.final_price,
      )
    ],
    type: GooglePayButtonType.pay,
    margin: const EdgeInsets.only(top: 15.0),
    onPaymentResult: (result) => debugPrint('Payment Result $result'),
    loadingIndicator: const Center(
      child: CircularProgressIndicator(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ? googlePayButton : applePayButton;
  }
}
