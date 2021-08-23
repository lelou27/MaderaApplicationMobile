class Client {
  final String id;
  final String first_name;
  final String mail;
  final String phone;
  final String address;
  final String postal_code;
  final String city;
  final String country;

  Client({required this.id, required this.first_name, required this.mail, required this.phone, required this.address, required this.postal_code, required this.city, required this.country});

  static List<Client> clientsList(List<dynamic> body) {
    List<Client> clientsList = [];
    List<dynamic> results = body;

    results.forEach((clientJson) {
      Client client = getBaseClient(clientJson);
      clientsList.add(client);
    });

    return clientsList;
  }

  static Client getBaseClient(clientJson) {
    return Client(
      id: clientJson["_id"],
      first_name: clientJson["first_name"],
      mail: clientJson["mail"],
      phone: clientJson["phone"],
      address: clientJson["address"],
      postal_code: clientJson["postal_code"],
      city: clientJson["city"],
      country: clientJson["country"],
    );
  }

// static Client getClient(Map<String, dynamic> body) {
//   Client client = getBaseClient(body);
//
//   return client;
// }
}
