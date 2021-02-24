import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

abstract class FabEvent {}

class FabEventPressed extends FabEvent {}

class FabEventAdded extends FabEvent {}

class FabEventLoaded extends FabEvent {}

class FabEventLoading extends FabEvent {}

class FabEventError extends FabEvent {}
