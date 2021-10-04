import 'package:fludget/Models/widgetModel.dart';
import 'package:fludget/routes/Card.dart';
import 'package:fludget/routes/Root/rootScreen.dart';
import 'package:fludget/routes/button.dart';
import 'package:fludget/routes/column.dart';
import 'package:fludget/routes/dialogBox.dart';
import 'package:fludget/routes/expanded.dart';
import 'package:fludget/routes/gridList.dart';
import 'package:fludget/routes/hero.dart';
import 'package:fludget/routes/icon.dart';
import 'package:fludget/routes/image.dart';
import 'package:fludget/routes/opacity.dart';
import 'package:fludget/routes/reorderableListView.dart';
import 'package:fludget/routes/row.dart';
import 'package:fludget/routes/settings.dart';
import 'package:fludget/routes/stack.dart';
import 'package:fludget/routes/switch.dart';
import 'package:fludget/routes/text.dart';
import 'package:fludget/routes/textfield.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  bool searching = false;
  String searchString = '';

  AppBar showSearchBar() {
    return AppBar(
      backgroundColor: Colors.grey[900],
      title: TextField(
        keyboardType: TextInputType.text,
        cursorColor: Colors.white,
        autofocus: true,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              setState(() {
                searching = false;
                searchString = '';
              });
            },
          ),
          hintText: 'Search....',
          border: UnderlineInputBorder(borderSide: BorderSide.none),
        ),
        style: TextStyle(
          color: Colors.white,
          decorationColor: Colors.white,
        ),
        onSubmitted: (String text) {
          setState(() {
            searchString = text;
          });
        },
        onChanged: (String text) {
          setState(() {
            searchString = text;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searching
          ? showSearchBar()
          : AppBar(
              backgroundColor: Colors.orange[900],
              title: Text("Widget Catalog"),
              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      searching = true;
                    });
                  },
                  icon: const Icon(Icons.search),
                )
              ],
              centerTitle: true,
            ),
      backgroundColor: Colors.grey[900],
      drawer: SettingsWidget(),
      body: getWidgetList(searchString),
    );
  }

  ListView getWidgetList(String filter) {
    List<WidgetModel> widgets = [
      const WidgetModel(
          name: "Column",
          sample: ColumnSample(),
          sampleDescription: ColumnDescription()),
      const WidgetModel(
          name: "Row",
          sample: RowSample(),
          sampleDescription: RowWidgetDescription()),
      const WidgetModel(
          name: "Stack",
          sample: StackSample(),
          sampleDescription: StackWidgetDescription()),
      const WidgetModel(
          name: "Text",
          sample: TextSample(),
          sampleDescription: TextWidgetDescription()),
      const WidgetModel(
          name: "Icon",
          sample: IconSample(),
          sampleDescription: IconWidgetDescription()),
      const WidgetModel(
          name: "Image",
          subtitle: "Asset Image, Network Image",
          sample: ImageSample(),
          sampleDescription: ImageWidgetDescription()),
      const WidgetModel(
          name: "Button",
          subtitle: "Elevated Button, Text Button, Floating Action Button",
          sample: ButtonSample(),
          sampleDescription: ButtonDescription()),
      const WidgetModel(
          name: "DialogBox",
          subtitle: "shows Dialog",
          sample: DialogBox(),
          sampleDescription: DialogBoxDescription()),
      const WidgetModel(
        name: "GridList",
        subtitle: "shows Dialog",
        sample: GridListSample(),
        sampleDescription: GridListDescription(),
      ),
      const WidgetModel(
        name: "Switch",
        subtitle: "Toggle Switch",
        sample: SwitchSample(),
        sampleDescription: SwitchDescription(),
      ),
      const WidgetModel(
        name: "TextField",
        subtitle: "Input field for username and password",
        sample: TextFieldSample(),
        sampleDescription: TextFielDescription(),
      ),
      const WidgetModel(
          name: "Card",
          sample: CardSample(),
          sampleDescription: CardDescription()),
      const WidgetModel(
          name: "Opacity",
          sample: opacitysample(),
          sampleDescription: opacitydescription()),
      const WidgetModel(
          name: "Expanded",
          sample: ExpandedSample(),
          sampleDescription: ExpandedWidgetDescription()),
      const WidgetModel(
        name: "ReOrderableListView",
        subtitle: "A Reorderable List",
        sample: ReOrderableListViewSample(),
        sampleDescription: ReOrderableListViewDescription(),
      ),
      WidgetModel(
        name: "Hero Widget",
        subtitle: "Hero Animation between widgets",
        sample: HeroWidget(
          tag: hashCode,
        ),
        sampleDescription: HeroWidgetDescription(),
      ),
    ];

    return ListView(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      children: filterWidgets(widgets, filter),
    );
  }

  List<Widget> filterWidgets(List<WidgetModel> widgets, String filter) {
    List<WidgetModel> filtered = [];

    widgets.forEach((item) {
      String itemName = item.name.toLowerCase();
      String subtitle = item.subtitle.toLowerCase();
      if (itemName.contains(filter.toLowerCase()))
        filtered.add(item);
      else if (subtitle.contains(filter.toLowerCase())) filtered.add(item);
    });

    if (filtered.isEmpty) {
      return [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 15,
            ),
            child: Text('No widget found with name:\n' + filter,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                )),
          ),
        ),
      ];
    }

    return filtered.map((item) => buildListItem(item)).toList();
  }

  ListTile buildListItem(WidgetModel item) {
    CircleAvatar arrow = CircleAvatar(
      child: Icon(
        Icons.keyboard_arrow_right,
        color: Colors.white,
      ),
      backgroundColor: Colors.orange[900],
    );

    TextStyle titleStyle = TextStyle(
      color: Colors.white,
    );

    TextStyle subtitleStyle = TextStyle(color: Colors.white70);

    return ListTile(
      leading: arrow,
      title: Text(
        item.name + " Widget",
        style: titleStyle,
      ),
      subtitle: item.subtitle.isEmpty
          ? null
          : Text(
              item.subtitle,
              style: subtitleStyle,
            ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RootScreen(
              widgetImplementation: item.sample,
              widgetName: item.name,
              widgetDescription: item.sampleDescription,
            ),
          ),
        );
      },
    );
  }

  constCardSample() {}
}
