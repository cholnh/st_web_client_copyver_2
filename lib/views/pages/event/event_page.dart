import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stwebclientcopyver2/_bases/constants/pomangam_theme.dart';
import 'package:stwebclientcopyver2/domains/event/event.dart';
import 'package:stwebclientcopyver2/providers/deliverysite/delivery_site_model.dart';
import 'package:stwebclientcopyver2/providers/event/event_model.dart';
import 'package:stwebclientcopyver2/views/pages/event/event_detail_page.dart';
import 'package:stwebclientcopyver2/views/widgets/event/event_app_bar.dart';
import 'package:stwebclientcopyver2/views/widgets/event/event_item_widget.dart';

class EventPage extends StatefulWidget {

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {

  @override
  void initState() {
    super.initState();
    int dIdx = Provider.of<DeliverySiteModel>(context, listen: false).userDeliverySite.idx;
    Provider.of<EventModel>(context, listen: false).fetch(dIdx: dIdx);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EventAppBar(title: '이벤트'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Consumer<EventModel>(
                  builder: (_, eventModel, __) {
                    if(eventModel.isFetching) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Center(child: CupertinoActivityIndicator()),
                      );
                    }

                    List<Event> events = eventModel.events;
                    if(events.length == 0) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Center(child: Text('진행하는 이벤트가 없습니다.', style: TextStyle(color: subTextColor, fontSize: 12.0))),
                      );
                    }
                    return CustomScrollView(
                      physics: BouncingScrollPhysics(),
                      slivers: <Widget>[
                        SliverList(
                          delegate: SliverChildBuilderDelegate((context, index) {
                            Event event = events[index];
                            return EventItemWidget(
                              index: index,
                              title: event.title,
                              subTitle: '${_textDate(event.beginDate)} ~ ${_textDate(event.endDate)}',
                              trailingText: _trailingText(event.beginDate, event.endDate),
                              trailingColor: _trailingColor(event.beginDate, event.endDate),
                              onTap: () => Get.to(EventDetailPage(event.idx), duration: Duration.zero, transition: Transition.cupertino)
                            );
                          }, childCount: events.length)
                        )
                      ],
                    );
                  }
              ),
            )
          ],
        ),
      ),
    );
  }

  String _textDate(DateTime dt) {
    return dt == null ? '' : DateFormat('yyyy. MM. dd').format(dt);
  }

  String _trailingText(DateTime begin, DateTime end) {
    DateTime today = DateTime.now();
    if(begin != null && today.isBefore(begin)) {
      return '준비중';
    } else if(end != null && today.isAfter(end)) {
      return '마감';
    } else {
      return '진행중';
    }
  }

  Color _trailingColor(DateTime begin, DateTime end) {
    DateTime today = DateTime.now();
    if(begin != null && today.isBefore(begin)) {
      return subTextColor;
    } else if(end != null && today.isAfter(end)) {
      return subTextColor;
    } else {
      return primaryColor;
    }
  }
}
