import 'package:flutter/material.dart';

import 'draggable_home.dart';
import 'get_list_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const MaterialApp(
        title: "Draggable Home",
        home: HomePage(),
      );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  bool isTileClicked = false;
  int opacity = 0;
  int currentIndex = 1;
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      leading: const Icon(Icons.arrow_back_ios),
      title: const Text("Example Home"),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
      ],
      headerWidget: headerWidget(context),
      headerBottomBar: headerBottomBarWidget(),
      body: [
        Stack(
          children: [
            if (isTileClicked) detailsView(),
            Offstage(
              offstage: isTileClicked,
              child: GetListView(
                onClickAction: (value) {
                  setState(() {
                    isTileClicked = true;
                    currentIndex = value;
                  });
                },
              ),
            )
          ],
        )
      ],
      fullyStretchable: false,
      expandedBody: headerWidget(context),
      backgroundColor: Colors.white,
      appBarColor: Colors.teal,
    );
  }

  Row headerBottomBarWidget() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }

  Widget headerWidget(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: Text(
          "Title",
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(color: Colors.white70),
        ),
      ),
    );
  }

  detailsView() {
    return AnimatedOpacity(
      opacity: isTileClicked ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Card(
          color: Colors.white70,
          child: ListTile(
            onTap: () {
              setState(() {
                isTileClicked = false;
              });
            },
            leading: CircleAvatar(
              child: Icon(Icons.arrow_back),
            ),
            title: Text("Title$currentIndex"),
            subtitle: Text("Subtitile$currentIndex"),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
