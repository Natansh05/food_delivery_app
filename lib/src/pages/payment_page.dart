
import 'package:flutter/material.dart';
import 'package:myapp/src/common%20widgets/my_button.dart';
import 'package:myapp/src/common%20widgets/my_textfield.dart';
import 'package:myapp/src/pages/delivery_page.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isDelivery = true;
  bool isCod = true;
 // String _name = "";
 // String _phone = "";
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();

  // final ValueNotifier<bool> _showError = ValueNotifier<bool>(true);
  bool showError = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    super.dispose();
  }

  // void _validateInputs() {
  //   setState(() {
  //     _showError.value = _name.text.isEmpty || _phone.text.isEmpty;
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text("Order Confirmation"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30.0,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'CHECKOUT',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25.0,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20.0),
                  Text(
                    'Contact Information',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              MyTextField(
                controller: name,
                hintText: 'Name*',
                obscureText: false,
                check: false,
              ),
              const SizedBox(height: 25.0),
              MyTextField(
                controller: phone,
                hintText: 'Phone*',
                obscureText: false,
                check: true,
              ),
              const SizedBox(height: 25.0),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20.0),
                  Text(
                    'Order Type',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ListTile(
                      title: const Text('Delivery'),
                      leading: Radio<bool>(
                        value: true,
                        groupValue: isDelivery,
                        onChanged: (bool? value) {
                          setState(() {
                            isDelivery = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text('Pickup'),
                      leading: Radio<bool>(
                        value: false,
                        groupValue: isDelivery,
                        onChanged: (bool? value) {
                          setState(() {
                            isDelivery = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20.0),
                  Text(
                    'Payment Method',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ListTile(
                      title: const Text('COD'),
                      leading: Radio<bool>(
                        value: true,
                        groupValue: isCod,
                        onChanged: (bool? value) {
                          setState(() {
                            isCod = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text('UPI'),
                      leading: Radio<bool>(
                        value: false,
                        groupValue: isCod,
                        onChanged: (bool? value) {
                          setState(() {
                            isCod = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              if (showError)
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Please enter the required fields before confirming',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                )
              else if (isCod)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: MyButton(
                    text: 'Confirm the Order?',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DeliveryPage(),
                      ),
                    ),
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: MyButton(
                    onTap: () {},
                    text: 'UPI KA OPTION',
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
