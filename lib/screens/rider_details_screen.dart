import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rider_app/data/models/rider.dart';
import 'package:rider_app/domain/usecases/screen_riders.dart';
import 'package:rider_app/screens/riders_list_screen.dart';

class RiderDetails extends StatefulWidget {
  final Rider? rider;
  const RiderDetails({super.key, required this.rider});

  @override
  State<RiderDetails> createState() => _RiderDetailsState();
}

class _RiderDetailsState extends State<RiderDetails> {
  ScreenRiders screenRiders = ScreenRiders();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "View Rider",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                height: 250.0,
                child: PageView.builder(
                    itemCount: widget.rider!.documents!.length,
                    pageSnapping: true,
                    itemBuilder: (context, pagePosition) {
                      return Image.file(
                        File(widget.rider!.documents![pagePosition]),
                      );
                    }),
              ),
            ),
            const Divider(
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name: ${widget.rider!.name!}",
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    "Phone number: ${widget.rider!.phoneNumber!}",
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    "Address: ${widget.rider!.address!}",
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    "Localities:\n${widget.rider!.localities!.map((e) => e).toString()}",
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    screenRiders.removeRider(widget.rider!);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RidersScreen(),
                      ),
                    );
                  },
                  child: const Text("Reject"),
                ),
                ElevatedButton(
                  onPressed: () {
                    screenRiders.approveRider(widget.rider!);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RidersScreen(),
                      ),
                    );
                  },
                  child: const Text("Approve"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
