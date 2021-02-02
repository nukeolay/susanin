import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:susanin/data/api/api_util.dart';
import 'package:susanin/data/repository/susanin_data_repository.dart';
import 'package:susanin/internal/dependencies/repository_module.dart';

import 'data/api/mapper/location_point_mapper.dart';
import 'data/api/mapper/susanin_data_mapper.dart';
import 'data/api/model/api_location_point.dart';
import 'data/api/model/api_susanin_data.dart';
import 'data/api/service/service_shared_prefs_susanin_data.dart';
import 'domain/model/location_point.dart';
import 'domain/model/susanin_data.dart';
import 'domain/repository/susanin_repository.dart';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SusaninRepository susaninRepository = RepositoryModule.susaninRepository();
    ServiceSharedPrefsSusaninData serviceData = new ServiceSharedPrefsSusaninData();
    ApiUtil apiUtil = new ApiUtil(serviceData);
    return Container(
      child: Center(
        child: Column(
          children: [
            Text("test"),
            FutureBuilder(
                future: susaninRepository.getSusaninData(),
                builder: (BuildContext context, AsyncSnapshot<SusaninData> snapshot) {
                  if (snapshot.hasData) {
                    return Text("${snapshot.data}", style: TextStyle(fontSize: 10));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ],
        ),
      ),
    );
  }
}