import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/map_location_search_bloc.dart';
import '../../model/user.dart';
import 'widgets/map_widget_section.dart';
import 'widgets/user_infromation_widget.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool isCollageAddress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              UserInfromationWidet(user: widget.user),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.centerLeft,
                child: Switch.adaptive(
                    value: isCollageAddress,
                    onChanged: (_) {
                      setState(() {
                        isCollageAddress = !isCollageAddress;
                      });
                    }),
              ),
              const SizedBox(height: 15),

              // map integration part
              BlocBuilder<MapLocationSearchBloc, MapLocationSearchState>(
                builder: (context, state) {
                  if (state is LocationInfoLoading) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  } else if (state is LocationInfoError) {
                    return const Center(
                      child: Text('failed to fetch your location infromation'),
                    );
                  } else if (state is MapLocationSearchInitial) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  } else if (state is LocationInfoLoaded) {
                    return Expanded(
                      child: MapWidgetSection(
                        latLng: isCollageAddress
                            ? state.collageLatLng
                            : state.homeLatLng,
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
