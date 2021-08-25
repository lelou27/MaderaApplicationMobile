class Module {
  final String id;
  final String nomModule;

  Module(
      {required this.id,
        required this.nomModule});

  Map<String, dynamic> toJson() => {
    'nomModule': nomModule,
  };

  static Module module(dynamic body) {
    print(body);
    return getBaseModule(body);
  }


  static Module getBaseModule(clientJson) {
    return Module(
      id: clientJson["_id"],
      nomModule: clientJson["nomModule"],
    );
  }

}
