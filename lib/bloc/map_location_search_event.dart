part of 'map_location_search_bloc.dart';

@immutable
abstract class MapLocationSearchEvent {}

class GetLocationInfo extends MapLocationSearchEvent {
  final String homeAddress;
  final String collageAddress;

  GetLocationInfo({
    required this.collageAddress,
    required this.homeAddress,
  });
}
