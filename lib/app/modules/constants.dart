import "package:dio/dio.dart";

var dio = Dio();

String startApi = "https://web-production-3141.up.railway.app/";

class Role {
  static const String STUDENT = "Etudiant";
  static const String TEACHER = "Enseignant";
  static const String HEAD_OF_DEPARTMENT = "Chef de département";
  static const String SECRETARY = "Sécretaire";
  static const String EXECUTIVE_OFFICER = "Agent de direction";
  static const String IT_OFFICER = "Agent informatique";
}

class RequestStatus {
  static const String DRAFT = "Brouillon";
  static const String SUBMITTED = "En attente de vérification";
  static const String REJECTED = "Rejété après traitement";
  static const String TREATMENT_PENDING = "En attente de traitement";
  static const String TREATMENT_IN_PROGRESS = "En cours de traitement";
  static const String TREATMENT_AT_VERIFY = "Traitement à verifié";
  static const String TREATMENT_ASSIGNED = "Traitement assigné";
  static const String DELIBERATION_PENDING = "En attente de déliberation";
  static const String PUBLISHING_PENDING = "En attente de publication";
  static const String PUBLISHING_AND_SUCCESS = "Publié et favorable";
  static const String PUBLISHING_AND_FAIL = "Publié et non favorable";
}

class Decision {
  static const String FAVORABLE = "Favorable";
  static const String NON_FAVORABLE = "Non Favorable";
}

class RequestSubmitState {
  static const String DRAFT = "Brouillon";
  static const String SAVE = "Enregistré";
}
