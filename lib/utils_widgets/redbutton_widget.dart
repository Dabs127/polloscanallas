import 'package:flutter/material.dart';

class RedButtonWidget extends StatefulWidget {

  final String text;
  final VoidCallback function;


  const RedButtonWidget({super.key,
    required this.text,
    required this.function
  });

  @override
  State<RedButtonWidget> createState() => _RedButtonWidgetState();
}

class _RedButtonWidgetState extends State<RedButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: const MaterialStatePropertyAll<Color>(Color.fromARGB(255, 255, 63, 84)),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        minimumSize: MaterialStateProperty.all<Size>(const Size(200, 50)),
        shape: MaterialStateProperty.all<OutlinedBorder>(
            const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero
            )
        ),
      ),
      onPressed: () => widget.function(),
      child: Text(
        widget.text,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 20
        ),
      ),
    );
  }
}
