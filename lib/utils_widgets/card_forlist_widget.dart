import 'package:flutter/material.dart';
import 'package:polloscanallas/services/firebase_service.dart';

class CardForlistWidget extends StatefulWidget {

  final VoidCallback notifyParent;
  final String updateRoute;
  final Map properties;


  const CardForlistWidget({super.key,
    required this.notifyParent,
    required this.properties,
    required this.updateRoute
  });

  @override
  State<CardForlistWidget> createState() => _CardForlistWidgetState();
}

class _CardForlistWidgetState extends State<CardForlistWidget> {
  @override
  Widget build(BuildContext context) {

    return Center(
      child: Container(
        width: 300,
        margin: const EdgeInsets.symmetric(vertical: 20.0), // Margen vertical para centrar en la pantalla
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255), // Color de fondo del contenedor
          borderRadius: BorderRadius.circular(0.0), // Bordes redondeados del contenedor
          border: Border.all(
            color: const Color.fromARGB(255, 176, 162, 162), // Color del contorno
            width: 2.5, // Ancho del contorno
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            widget.properties['urlImage'] != null && widget.properties['urlImage'] != "" ? SizedBox(
                width: double.infinity,
                height: 200,
                child: Image.network(widget.properties['urlImage']!, fit: BoxFit.cover,)) : Image.asset(
              "assets/images/no_image.jpg", // Ruta de la imagen
              width: double.infinity, // Ancho de la imagen
              height: 150, // Alto de la imagen
              fit: BoxFit.fill, // Ajuste de la imagen
            ),

            const SizedBox(height: 16.0), // Espaciado vertical entre la imagen y el texto

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.properties['name'],
                style: const TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 162, 162, 162) // Texto
                ),
              ),
            ),

            const SizedBox(
                height:
                8.0), // Espaciado vertical entre los elementos

            Container(
              child: widget.properties.containsKey('SKU') ?Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.properties['SKU'],
                  style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w800,
                      color: Color.fromARGB(
                          255, 162, 162, 162) // Texto
                  ),
                ),
              ) : null,
            ),

            const SizedBox(height: 8.0), // Espaciado vertical entre los elementos

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.properties.containsKey('price')? 'Precio: \$ ${widget.properties['price']}' : widget.properties.containsKey('expense')? 'Gasto: \$ ${widget.properties['expense']}' : '# Contacto: ${widget.properties['phonenumber']}',
                style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 162, 162, 162) // Texto
                ),
              ),
            ),

            const SizedBox(height: 8.0), // Espaciado vertical entre los elementos

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.properties.containsKey('stock')? 'Existencia: ${widget.properties['stock']}' : 'Direccion: ${widget.properties['location']}',
                style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 162, 162, 162) // Texto
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  widget.properties.containsKey('supplier') && widget.properties['supplier'] != '' ? 'Proveedor: ${widget.properties['supplier']}' : 'Proveedor: No especificado',
                style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 162, 162, 162) // Texto
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Descripción: ${widget.properties['description']}',
                style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(
                        255, 162, 162, 162) // Texto
                ),
              ),
            ),

            Column(children: [
              const Divider(
                color: Color.fromARGB(255, 176, 162, 162),
                thickness: 4,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () async{
                        bool result = false;

                        result = await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Esta seguro de querer eliminar a ${widget.properties['name']}?"),
                                actions: [
                                  ElevatedButton(onPressed: (){
                                    return Navigator.pop(
                                      context,
                                      false
                                    );
                                  }, style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Color de fondo del botón
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0.0), // Bordes redondeados del botón
                                    ),
                                  ),
                                    child: const Text(
                                      "Cancelar",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 162, 162, 162)
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(onPressed: (){
                                    return Navigator.pop(
                                        context,
                                        true
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Color de fondo del botón
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0.0), // Bordes redondeados del botón
                                      ),
                                    ), child: const Text(
                                        "Si, estoy seguro",
                                        style: TextStyle(color: Color.fromARGB(255, 255, 82, 82)),
                                    ),
                                  ),
                                ],
                              );
                            }
                        );

                        if(result){
                          await deleteDocument(widget.properties['uid'], widget.properties['type']);
                          widget.notifyParent();
                        }

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 82, 82), // Color de fondo del botón
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0), // Bordes redondeados del botón
                        ),
                      ),
                      child: const Text(
                        'Eliminar',
                        style: TextStyle(
                          color: Colors.white, // Color del texto del botón
                          fontSize: 12.0, // Tamaño del texto
                        ),
                      ),
                    ),

                    const SizedBox(width: 40.0), // Espaciado horizontal entre los botones

                    ElevatedButton(
                      onPressed: () async {
                        await Navigator.pushNamed(context, widget.updateRoute, arguments: widget.properties);
                        widget.notifyParent();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Color de fondo del botón
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0), // Bordes redondeados del botón
                        ),
                      ),
                      child: const Text(
                        'Actualizar',
                        style: TextStyle(
                          color: Colors.red, // Color del texto del botón
                          fontSize: 12.0, // Tamaño del texto
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
