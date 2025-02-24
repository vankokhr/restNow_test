import 'package:flutter/material.dart';

import '../services/api_service.dart';
import 'control_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool _isProcessing = false;

  void _simulatePayment() async {
    setState(() {
      _isProcessing = true;
    });

    bool success = await ApiService.simulatePayment();

    setState(() {
      _isProcessing = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Оплата успішна!'),
          duration: Duration(milliseconds: 1500),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ControlScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Помилка оплати! Спробуйте ще раз.'),
            backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Payment')),
      body: Center(
        child: _isProcessing
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _simulatePayment,
                child: Text('Оплатити'),
              ),
      ),
    );
  }
}
