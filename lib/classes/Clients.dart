class Client {
  final String id;
  final String first_name;
  final String mail;

  Client({required this.id, required this.first_name, required this.mail});

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
    );
  }

  // static Client getClient(Map<String, dynamic> body) {
  //   Client client = getBaseClient(body);
  //
  //   return client;
  // }
}
