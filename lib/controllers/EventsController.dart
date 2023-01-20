import 'package:get/get.dart';
import 'package:quiz_app/controllers/ApisFunctions.dart';
import 'package:quiz_app/models/Event.dart';

class EventController extends GetxController
    with GetSingleTickerProviderStateMixin {
  List<eventss> eventssList = [];
  eventss? onGoingEvent;
  int team = 0;

  RxString teamName = "".obs;

  getEventsList() async {
    eventssList = await getEventsLists();
    return eventssList;
    //notifyChildrens();
  }
}
