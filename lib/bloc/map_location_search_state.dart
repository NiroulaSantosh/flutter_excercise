part of 'map_location_search_bloc.dart';

@immutable
abstract class MapLocationSearchState {}

class MapLocationSearchInitial extends MapLocationSearchState {}

class LocationInfoLoading extends MapLocationSearchState {}

class LocationInfoLoaded extends MapLocationSearchState {
  final LatLng collageLatLng;
  final LatLng homeLatLng;

  LocationInfoLoaded({
    required this.collageLatLng,
    required this.homeLatLng,
  });
}

class LocationInfoError extends MapLocationSearchState {}
