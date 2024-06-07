import 'package:flutter/material.dart';
import 'package:polloscanallas/utils_widgets/appbar_widget.dart';
import 'package:polloscanallas/utils_widgets/card_forlist_widget.dart';
import 'package:polloscanallas/utils_widgets/drawer_widget.dart';

import '../../services/products_services/crud_products.dart';


class ListProductsPage extends StatefulWidget {
  const ListProductsPage({super.key});

  @override
  State<ListProductsPage> createState() => _ListProductsPageState();
}

class _ListProductsPageState extends State<ListProductsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(),
      drawer: const DrawerWidget(),
      body: SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: [

            const SizedBox(height: 5.0), // Espacio entre el subtítulo y los campos de entrada

            const Divider(color: Colors.redAccent, thickness: 4,),

            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Center(
                child: Text(
                  'Productos',
                  style: TextStyle(fontSize: 30, fontFamily: "Rye"),
                ),
              ),
            ),

            const Divider(color: Colors.redAccent, thickness: 4),

            const SizedBox(height:30.0), // Espacio entre el título y los campos de entrada

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                          height: 70,
                          width: 200,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 255, 63, 84),
                          ),
                          child: TextButton(
                              child: const Text("Nuevo Producto", //Boton de iniciar sesion
                                textAlign: TextAlign.center ,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),),
                              onPressed: () async{
                                await Navigator.pushNamed(context, '/newproduct');
                                setState(() {});
                              }  //a donde deberia mandar el boton iniciar sesion
                          ),
                        ),
                    ),
                    const SizedBox(width: 15.0),
                    Expanded(
                        child: Container(
                          height: 70,
                          width: 200,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 255, 63, 84),
                          ),
                          child: TextButton(
                              child: const Text("Agregar Existencias", //Boton de iniciar sesion
                                textAlign: TextAlign.center ,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),),
                              onPressed: (){
                                Navigator.pushNamed(context, '/addstockproducts');
                              }  //a donde deberia mandar el boton iniciar sesion
                          ),
                        ),
                    ),
                  ],
                ),
              ),

          const SizedBox(height: 30.0),

          FutureBuilder(
              future: getProducts(),
              builder: ((context, snapshot) {
                if(snapshot.hasData){
                  return Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return CardForlistWidget(
                            notifyParent: refresh,
                            properties: {
                              'urlImage': snapshot.data?[index]['url'],
                              'name': snapshot.data?[index]['name'],
                              'SKU': snapshot.data?[index]['SKU'],
                              'price': snapshot.data?[index]['price'],
                              'stock': snapshot.data?[index]['stock'],
                              'description': snapshot.data?[index]['description'],
                              'type': snapshot.data?[index]['type'],
                              'uid': snapshot.data?[index]['uid'],
                            },
                            updateRoute: '/updateproduct',
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })
          ),
        ]),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }

}
