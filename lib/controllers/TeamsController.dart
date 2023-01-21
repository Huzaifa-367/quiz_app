import 'package:get/get.dart';
import 'package:quiz_app/models/TeamModel.dart';

import 'ApisFunctions.dart';

class TeamsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  List<team> teams = [];
  RxInt connectedTeams = 0.obs;
  getTeamsDetail() async {
    teams = await getTeamsDetails();
    for (int i = 0; i < teams.length; i++) {
      teams[i].buzzerRound = 0;
      teams[i].rapidRound = 0;
      teams[i].buzzerWrong = 0;
      teams[i].mcqRound = 0;
      teams[i].scores = 0;
    }
  }
}
