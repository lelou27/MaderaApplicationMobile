import 'package:madera_mobile/classes/Module.dart';

class Devis {
  final String id;
  final String nomProjet;
  final String referenceProjet;
  final String client;
  final String dateDevis;
  final List<dynamic> modules;

  Devis(
      {required this.id,
        required this.nomProjet,
        required this.referenceProjet,
        required this.client,
        required this.modules,
        required this.dateDevis});

  Map<dynamic, dynamic> toJson() => {
    'nomProjet': nomProjet,
    'referenceProjet': referenceProjet,
    'client': client,
    'modules': modules,
    'dateDevis': dateDevis,
  };

  static List<Devis> devisList(List<dynamic> body) {
    List<Devis> devisList = [];
    body.forEach((devisJson) {
      Devis devis = getBaseDevis(devisJson);

      devisList.add(devis);
    });

    return devisList;
  }

  static Devis getBaseDevis(devisJson) {
    return Devis(
      id: devisJson["_id"],
      modules: devisJson["modules"],
      nomProjet: devisJson["nomProjet"],
      referenceProjet: devisJson["referenceProjet"],
      client: devisJson["client"],
      dateDevis: devisJson["dateDevis"],
    );
  }
}
