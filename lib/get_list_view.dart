import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class GetListView extends StatefulWidget {
  final Function onClickAction;

  const GetListView({super.key, required this.onClickAction});

  @override
  State<StatefulWidget> createState() => _GetListViewState();
}

class _GetListViewState extends State<GetListView>
    with AutomaticKeepAliveClientMixin<GetListView> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
      itemScrollController: itemScrollController,
      itemPositionsListener: itemPositionsListener,
      padding: const EdgeInsets.only(top: 30),
      physics: BouncingScrollPhysics(),
      itemCount: 50,
      shrinkWrap: true,
      addAutomaticKeepAlives: true,
      key: const PageStorageKey<String>('page'),
      itemBuilder: (context, index) => Card(
        color: Colors.white70,
        child: ListTile(
          onTap: () {
            setState(() {
              widget.onClickAction(index);
            });
          },
          leading: CircleAvatar(
            child: Text("$index"),
          ),
          title: Text("Title $index"),
          subtitle: Text("Subtitle $index"),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
