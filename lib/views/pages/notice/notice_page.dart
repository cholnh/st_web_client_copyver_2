import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stwebclientcopyver2/_bases/constants/pomangam_theme.dart';
import 'package:stwebclientcopyver2/domains/notice/notice.dart';
import 'package:stwebclientcopyver2/providers/deliverysite/delivery_site_model.dart';
import 'package:stwebclientcopyver2/providers/notice/notice_model.dart';
import 'package:stwebclientcopyver2/views/pages/notice/notice_detail_page.dart';
import 'package:stwebclientcopyver2/views/widgets/notice/notice_app_bar.dart';
import 'package:stwebclientcopyver2/views/widgets/notice/notice_item_widget.dart';

class NoticePage extends StatefulWidget {
  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {

  @override
  void initState() {
    super.initState();
    int dIdx = Provider.of<DeliverySiteModel>(context, listen: false).userDeliverySite.idx;
    Provider.of<NoticeModel>(context, listen: false).fetch(dIdx: dIdx);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NoticeAppBar(title: '공지사항'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Consumer<NoticeModel>(
                  builder: (_, noticeModel, __) {
                    if(noticeModel.isFetching) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Center(child: CupertinoActivityIndicator()),
                      );
                    }

                    List<Notice> notices = noticeModel.notices;
                    if(notices.length == 0) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Center(child: Text('공지사항이 없습니다.', style: TextStyle(color: subTextColor, fontSize: 12.0))),
                      );
                    }
                    return CustomScrollView(
                      physics: BouncingScrollPhysics(),
                      slivers: <Widget>[
                        SliverList(
                          delegate: SliverChildBuilderDelegate((context, index) {
                            Notice notice = notices[index];
                            return NoticeItemWidget(
                              index: index,
                              title: notice.title,
                              subTitle: '${_textDate(notice.modifyDate)}',
                              onTap: () => Get.to(NoticeDetailPage(notice.idx), duration: Duration.zero, transition: Transition.cupertino)
                            );
                          }, childCount: notices.length)
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
}
