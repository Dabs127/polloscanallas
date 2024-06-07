import 'package:flutter/cupertino.dart';

class OrderItemWidget extends StatefulWidget {
  const OrderItemWidget({super.key});

  @override
  State<OrderItemWidget> createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "x4 Espinazos de cantina",
          style: TextStyle(
              color: Color.fromARGB(255, 255, 63, 84),
              fontSize: 20.0,
              fontWeight: FontWeight.bold
          ),
        ),
        Text(
          'ESP-1.2-PAQ-SC',
          style: TextStyle(
            color: Color.fromARGB(255, 115, 113, 113),
            fontSize: 15.0,
          ),
        ),
      ],
    );
  }
}
