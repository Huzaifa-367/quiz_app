import 'package:get/get.dart';
import 'package:quiz_app/models/TeamModel.dart';

import 'ApisFunctions.dart';

class TeamsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  List<team> teams = [];

  getTeamsDetail() async {
    await getTeamsDetails();
  }
}
