import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stwebclientcopyver2/_bases/constants/pomangam_theme.dart';
import 'package:stwebclientcopyver2/providers/notice/notice_model.dart';
import 'package:stwebclientcopyver2/views/widgets/notice/notice_app_bar.dart';

class NoticeDetailPage extends StatefulWidget {

  final int nIdx;
  NoticeDetailPage(this.nIdx);

  @override
  _NoticeDetailPageState createState() => _NoticeDetailPageState();
}

class _NoticeDetailPageState extends State<NoticeDetailPage> {

  @override
  void initState() {
    super.initState();
    Provider.of<NoticeModel>(context, listen: false).fetchOne(nIdx: widget.nIdx);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoticeModel>(
      builder: (_, model, __) {
        return Scaffold(
          appBar: NoticeAppBar(
            title: '${model.notice?.title ?? ''}',
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
                    child: Text('${_textDate(model.notice?.modifyDate)}', style: TextStyle(fontSize: 12.0, color: subTextColor)),
                  ),
                ),
                Divider(thickness: 8.0, height: 0.5, color: Colors.black.withOpacity(0.03)),
                SingleChildScrollView(
                child: Html(
                  data: model.notice?.contents ?? '',
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
}
