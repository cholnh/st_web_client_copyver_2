import 'package:stwebclientcopyver2/_bases/network/api/api.dart';
import 'package:stwebclientcopyver2/domains/deliverysite/delivery_site.dart';

class DeliverySiteRepository {
  final Api api; // 서버 연결용
  DeliverySiteRepository({this.api});

  Future<List<DeliverySite>> findAll() async
    => DeliverySite.fromJsonList((await api.get(url: '/dsites')).data);

  Future<DeliverySite> findByIdx({int dIdx}) async
    => DeliverySite.fromJson((await api.get(url: '/dsites/$dIdx')).data);

  Future<List<DeliverySite>> search({String query}) async
    => DeliverySite.fromJsonList((await api.get(url: '/dsites/search?query=$query')).data);

}