import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stwebclientcopyver2/_bases/constants/pomangam_theme.dart';
import 'package:stwebclientcopyver2/providers/event/event_model.dart';
import 'package:stwebclientcopyver2/views/widgets/event/event_app_bar.dart';

class EventDetailPage extends StatefulWidget {

  final int eIdx;
  EventDetailPage(this.eIdx);

  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {

  @override
  void initState() {
    super.initState();
    Provider.of<EventModel>(context, listen: false).fetchOne(eIdx: widget.eIdx);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EventModel>(
      builder: (_, model, __) {
        return Scaffold(
          appBar: EventAppBar(
            title: '${model.event?.title ?? ''}',
            leadingIcon: Icon(CupertinoIcons.back, color: Colors.black),
          ),
          body: model.isFetching
            ? Center(
                child: CupertinoActivityIndicator(),
            )
            : Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text('${_textDate(model.event?.beginDate)} ~ ${_textDate(model.event?.endDate)}', style: TextStyle(fontSize: 12.0, color: subTextColor)),
                      Padding(padding: const EdgeInsets.only(bottom: 3.0)),
                      Text('${_dateText(model.event?.beginDate, model.event?.endDate)}', style: TextStyle(fontSize: 12.0, color: primaryColor)),
                    ],
                  ),
                ),
              ),
              Divider(thickness: 8.0, height: 0.5, color: Colors.black.withOpacity(0.03)),
              SingleChildScrollView(
                child: Html(
                  data: model.event?.contents ?? '',
                  backgroundColor: backgroundColor,
                  padding: const EdgeInsets.all(20.0),
                  defaultTextStyle: TextStyle(fontSize: 14.0),
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  String _textDate(DateTime dt) {
    return dt == null ? '' : DateFormat('yyyy. MM. dd').format(dt);
  }

  String _dateText(DateTime begin, DateTime end) {
    DateTime today = DateTime.now();
    if(begin != null && today.isBefore(begin)) {
      return '준비중';
    } else if(end != null && today.isAfter(end)) {
      return '마감';
    } else {
      return '진행중';
    }
  }
}
