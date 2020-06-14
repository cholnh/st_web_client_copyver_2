import 'package:flutter/foundation.dart';
import 'package:stwebclientcopyver2/_bases/network/api/api.dart';
import 'package:stwebclientcopyver2/domains/event/event.dart';

class EventRepository {
  final Api api; // 서버 연결용
  EventRepository({this.api});

  Future<List<Event>> findAll({
    @required int dIdx
  }) async => Event.fromJsonList((await api.get(url: '/dsites/$dIdx/events')).data);

  Future<Event> findByIdx({
    @required int eIdx
  }) async => Event.fromJson((await api.get(url: '/dsites/-/events/$eIdx')).data);
}