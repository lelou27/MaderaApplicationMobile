class Devis {
  final String id;
  final String nomProjet;
  final String referenceProjet;
  final String client;
  final String dateDevis;

  Devis(
      {required this.id,
        required this.nomProjet,
        required this.referenceProjet,
        required this.client,
        required this.dateDevis});

  Map<String, dynamic> toJson() => {
    'nomProjet': nomProjet,
    'referenceProjet': referenceProjet,
    'client': client,
    'dateDevis': dateDevis,
  };

  static List<Devis> devisList(List<dynamic> body) {
    List<Devis> devisList = [];
    List<dynamic> results = body;
    results.forEach((devisJson) {
      Devis devis = getBaseDevis(devisJson);
      devisList.add(devis);
    });

    return devisList;
  }

  static Devis getBaseDevis(devisJson) {
    return Devis(
      id: devisJson["_id"],
      nomProjet: devisJson["nomProjet"],
      referenceProjet: devisJson["referenceProjet"],
      client: devisJson["client"],
      dateDevis: devisJson["dateDevis"],
    );
  }

}
