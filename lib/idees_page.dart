import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class IdeesPage extends StatelessWidget {
  const IdeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true),
      home: const IdeasHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class IdeasHome extends StatelessWidget {
  const IdeasHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        mapController: null,
        options: MapOptions(
          center: LatLng(48.69821313814409, 6.18658746494504),
          zoom: 15,
        ),
        nonRotatedChildren: [
          AttributionWidget.defaultWidget(
            source: '© OpenStreetMap contributors',
            onSourceTapped: () {},
          ),
        ],
        children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: 'com.vitaville.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(48.69821313814409, 6.18658746494504),
                    width: 40,
                    height: 40,
                    builder: (context) => Icon(
                      Icons.location_on,
                      color: Colors.black,
                      size: 40.0,
                      semanticLabel: 'name of place',
                    ),
                  ),
                ],
              ),
        ],
      ),
      floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const IdeaForm()),
                );
              },
              child: const Icon(Icons.my_location),
            ),
            SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const IdeaForm()),
                );
              },
              child: const Icon(Icons.add),
            ),
          ]
      )
    );
  }
}

class IdeaForm extends StatelessWidget {
  const IdeaForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Déposer une idée",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
        backgroundColor: const Color(0xFFFFFBFE), //Couleur utilisée sur Figma
        elevation: 0, //Retire l'ombre sous l'Appbar
        centerTitle: true, //Permet de centrer le texte
      ),
    );
  }
}
