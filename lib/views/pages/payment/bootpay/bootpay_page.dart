import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stwebclientcopyver2/providers/order/order_model.dart';
import 'package:stwebclientcopyver2/views/widgets/payment/payment_app_bar.dart';
import 'package:provider/provider.dart';

class BootPayPage extends StatefulWidget {
  @override
  _BootPayPageState createState() => _BootPayPageState();
}

class _BootPayPageState extends State<BootPayPage> {

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PaymentAppBar(
        context,
        title: '주문 결제',
        leadingIcon: const Icon(CupertinoIcons.back, color: Colors.black),
      ),
      body: SafeArea(
        child: Center(
          child: Consumer<OrderModel>(
            builder: (_, model, __) {
              return GestureDetector(
                onTap: () {
                  print('tab');
                },
                child: Text('${model.orderResponse}')
              );
            }
          )
        ),
      ),
    );
  }
}
