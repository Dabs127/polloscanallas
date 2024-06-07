import 'package:flutter/material.dart';
import '../../services/supplies_services/crud_supplies.dart';
import '../../utils_widgets/appbar_widget.dart';
import '../../utils_widgets/card_forlist_widget.dart';
import '../../utils_widgets/drawer_widget.dart';

class ListSuppliesPage extends StatefulWidget {
  const ListSuppliesPage({super.key});

  @override
  State<ListSuppliesPage> createState() => _ListSuppliesPageState();
}

class _ListSuppliesPageState extends State<ListSuppliesPage> {


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
                'Insumos',
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
                        child: const Text("Nuevo Insumo", //Boton de iniciar sesion
                          textAlign: TextAlign.center ,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),),
                        onPressed: () async{
                          await Navigator.pushNamed(context, '/newsupply');
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
                          Navigator.pushNamed(context, '/addstocksupplies');
                        }  //a donde deberia mandar el boton iniciar sesion
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30.0),

          FutureBuilder(
              future: getSupplies(),
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
                              'type': snapshot.data?[index]['type'],
                              'expense': snapshot.data?[index]['expense'],
                              'supplier': snapshot.data?[index]['supplier'],
                              'stock': snapshot.data?[index]['stock'],
                              'description': snapshot.data?[index]['description'],
                              'uid': snapshot.data?[index]['uid'],
                            },
                            updateRoute: '/updatesupply',
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
