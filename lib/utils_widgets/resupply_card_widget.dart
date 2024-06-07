import 'package:flutter/cupertino.dart';

class ResupplyCardWidget extends StatefulWidget {
  final String date;
  final String branch;
  final int total;
  final List<dynamic> orders;

  const ResupplyCardWidget(
      {
        super.key,
        required this.date,
        required this.branch,
        required this.total,
        required this.orders
      });

  @override
  State<ResupplyCardWidget> createState() => _ResupplyCardWidgetState();
}

class _ResupplyCardWidgetState extends State<ResupplyCardWidget> {



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 200,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 120,
              margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromARGB(255, 115, 113, 113))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fecha ${widget.date.substring(0, 10)}',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 115, 113, 113),
                      fontSize: 15.0,
                    ),
                    overflow: TextOverflow.visible,
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    'Enviado a: ${widget.branch}',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 115, 113, 113),
                      fontSize: 15.0,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    'Total: MXN${widget.total}',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 115, 113, 113),
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: const Color.fromARGB(255, 115, 113, 113))
                ),
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: widget.orders.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 8, top: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "x${widget.orders[index]['quantity']} ${widget.orders[index]['name']}",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 63, 84),
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
