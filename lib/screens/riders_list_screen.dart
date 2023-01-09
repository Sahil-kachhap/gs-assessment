import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rider_app/blocs/rider/rider_bloc.dart';
import 'package:rider_app/screens/register_rider_screen.dart';
import 'package:rider_app/screens/rider_details_screen.dart';

class RidersScreen extends StatefulWidget {
  const RidersScreen({super.key});

  @override
  State<RidersScreen> createState() => _RidersScreenState();
}

class _RidersScreenState extends State<RidersScreen> {
  @override
  void initState() {
    BlocProvider.of<RiderBloc>(context).add(LoadRidersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Riders",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: BlocConsumer<RiderBloc, RiderState>(listener: (context, state) {
        if (state is RiderLoading) {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
      }, builder: (context, state) {
        if (state is RiderLoadedState) {
          return ListView.builder(
              itemCount: state.riders!.length,
              itemBuilder: (context, index) {
                final rider = state.riders![index];
                log(rider.isApproved.toString());

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: FileImage(
                          File(rider.documents![4]),
                        ),
                      ),
                      title: Text(rider.name!),
                      subtitle: Text(rider.phoneNumber!),
                      trailing: StatusTag(
                        color: rider.isApproved! ? Colors.green : Colors.yellow,
                        text: rider.isApproved! ? "Approved" : "Under Review",
                        textColor:
                            rider.isApproved! ? Colors.white : Colors.black,
                      ),
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RiderDetails(
                            rider: rider,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              });
        }
        return const Center(
          child: Text("Something went wrong"),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const DetailsScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class StatusTag extends StatelessWidget {
  final String? text;
  final Color? color, textColor;

  const StatusTag({
    Key? key,
    required this.color,
    required this.text,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.0),
        ),
      ),
      child: Text(
        text!,
        style: TextStyle(
          color: textColor,
          fontSize: 10.0,
        ),
      ),
    );
  }
}
