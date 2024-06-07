import 'crud_products.dart';

Future<List<Map<String, dynamic>>> getProductNamesAndPrice() async {
  List<Map<String, dynamic>> productNames = [];

  // Llama a la función getProducts para obtener la lista de objetos
  List products = await getProducts();

  // Extrae solo la propiedad "name" de cada objeto y añádela a la lista de nombres
  for (var product in products) {
    productNames.add({
      "name": product['name'],
      "price": product['price']
    });
  }

  return productNames;
}