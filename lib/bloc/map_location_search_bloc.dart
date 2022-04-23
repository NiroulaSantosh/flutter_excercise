import 'package:bloc/bloc.dart';
import 'package:flutter_excercise/helper/http_helper.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:meta/meta.dart';

part 'map_location_search_event.dart';
part 'map_location_search_state.dart';

class MapLocationSearchBloc
    extends Bloc<MapLocationSearchEvent, MapLocationSearchState> {
  MapLocationSearchBloc() : super(MapLocationSearchInitial()) {
    on<GetLocationInfo>((event, emit) async {
      try {
        emit(LocationInfoLoading());
        final collageData = await getLatLangFromQuery(event.collageAddress);
        final homeData = await getLatLangFromQuery(event.homeAddress);

        emit(
          LocationInfoLoaded(
            collageLatLng: LatLng(collageData.last, collageData.first),
            homeLatLng: LatLng(homeData.last, homeData.first),
          ),
        );
      } catch (e) {
        emit(LocationInfoError());
      }
    });
  }
}
