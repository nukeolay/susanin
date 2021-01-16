import 'package:flutter/material.dart';
import 'package:susanin/generated/l10n.dart';

class LocationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width; // заменить на глобальные переменные, чтобы они получались один раз
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
          //color: Theme.of(context).cardColor,
          child: ListTile(
              selected: true,
              onTap: () {},
              leading: SizedBox(
                width: 50,
                child: IconButton(
                  icon: Icon(
                    Icons.delete_outline,
                    color: Theme.of(context).primaryColor,
                  ),
                  tooltip: S.of(context).tipDeleteLocation,
                  onPressed: () {},
                ),
              ),
              title: Text("pointName"),
              subtitle: Text("data")),
        );
      },
    );
  }
}
