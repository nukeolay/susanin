import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:susanin/generated/l10n.dart';

class LocationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width; // TODO заменить на глобальные переменные, чтобы они получались один раз
    final double height = MediaQuery.of(context).size.height;
    final double topWidgetHeight = width * 0.3;
    final double padding = width * 0.01;
    return ListView.builder(
      padding: EdgeInsets.only(top: topWidgetHeight * 0.5 + topWidgetHeight, bottom: topWidgetHeight * 0.5),
      itemCount: 20,
      addAutomaticKeepAlives: false,
      itemExtent: 80,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
          margin: EdgeInsets.only(top: 4.0, bottom: 4.0),
          child: Slidable(
            actionPane: SlidableBehindActionPane(),
            actionExtentRatio: 0.2,
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0), color: CardTheme.of(context).color),
              child: ListTile(
                  selected: true,
                  onTap: () {},
                  //leading: CircleAvatar(child: Icon(Icons.location_on_outlined), backgroundColor: CardTheme.of(context).color),
                  title: Text("pointName"),
                  subtitle: Text("data")),
            ),
            actions: <Widget>[
              Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(4.0), bottomLeft: Radius.circular(4.0)), color: Colors.red),
                child: IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () {},
                ),
              ),
            ],
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Rename',
                color: Theme.of(context).accentColor.withAlpha(120),
                icon: Icons.edit,
                onTap: () {},
              ),
              Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(4.0), bottomRight: Radius.circular(4.0)), color: Theme.of(context).accentColor),
                child: IconSlideAction(
                  caption: 'Share',
                  color: Theme.of(context).accentColor,
                  icon: Icons.share,
                  onTap: () {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
