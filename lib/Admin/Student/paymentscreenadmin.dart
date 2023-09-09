import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // Sample data for payment details
  double totalPayment = 1000;
  double totalPaidAmount = 700;
  List<double> paidAmounts = [300, 100, 300];

  double get balancedAmount => totalPayment - totalPaidAmount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Total Payment: \$${totalPayment.toStringAsFixed(2)}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Total Paid Amount: \$${totalPaidAmount.toStringAsFixed(2)}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Balanced Amount: \$${balancedAmount.toStringAsFixed(2)}'),
                  ),

                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: paidAmounts.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('Payment ${index + 1}'),
                  subtitle: Text('\$${paidAmounts[index].toStringAsFixed(2)}'),
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}