import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';
import 'package:rider_app/data/models/manager.dart';
import 'package:rider_app/data/models/rider.dart';
import 'package:rider_app/screens/riders_list_screen.dart';
import 'package:rider_app/widgets/document_field.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final formKey = GlobalKey<FormState>();
  List<String> selectedLocalities = [];

  int currentStep = 0;

  String aadharPath = "",
      panPath = "",
      dlPath = "",
      chequePath = "",
      photoPath = "";

  bool gotAadhar = false,
      gotPan = false,
      gotDL = false,
      gotBankCheque = false,
      gotPhoto = false;

  // Rider Details
  String name = "",
      phone = "",
      localities = "",
      address = "",
      pincode = "",
      account = "",
      ifsc = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add New Rider",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stepper(
                type: StepperType.vertical,
                currentStep: currentStep,
                onStepTapped: (step) {
                  setState(() {
                    currentStep = step;
                  });
                },
                onStepContinue: () {
                  final lastStep = currentStep == 1;
                  if (lastStep) {
                    if (gotAadhar &&
                        gotPan &&
                        gotDL &&
                        gotBankCheque &&
                        gotPhoto) {
                      List<String> validDocuments = [
                        aadharPath,
                        panPath,
                        dlPath,
                        chequePath,
                        photoPath
                      ];
                      final Rider rider = Rider(
                        name: name,
                        phoneNumber: phone,
                        localities: selectedLocalities,
                        address: address,
                        pinCode: pincode,
                        bankAccountNumber: account,
                        ifscNumber: ifsc,
                        documents: validDocuments,
                      );

                      Manager manager = Manager(name: "Sahil");
                      manager.addRider(rider);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RidersScreen(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("All Documents are required"),
                        ),
                      );
                    }
                  } else {
                    formKey.currentState!.save();
                    if (currentStep == 0 &&
                        (name.isNotEmpty &&
                            phone.isNotEmpty &&
                            selectedLocalities.isNotEmpty &&
                            address.isNotEmpty &&
                            pincode.isNotEmpty &&
                            account.isNotEmpty &&
                            ifsc.isNotEmpty)) {
                      setState(() => currentStep += 1);
                    } else {
                      log("$name, $phone, $localities, $address, $pincode, $account, $ifsc");
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("All fields are required"),
                        ),
                      );
                    }
                  }
                },
                onStepCancel: () {
                  currentStep == 0 ? null : setState(() => currentStep -= 1);
                },
                controlsBuilder: (context, details) {
                  return Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: details.onStepContinue,
                          child: Text(currentStep == 1 ? "Save" : "Next"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      if (currentStep != 0)
                        Expanded(
                          child: ElevatedButton(
                            onPressed: details.onStepCancel,
                            child: const Text("Back"),
                          ),
                        ),
                    ],
                  );
                },
                steps: [
                  Step(
                    title: const Text("Personal Details"),
                    subtitle: const Text("Locality and Bank Details"),
                    content: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Name',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Name Field is mandatory';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (newValue) => setState(() {
                                name = newValue!;
                              }),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Phone Number',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value != null && value.length < 9) {
                                  return 'Phone number must be 9 digit';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (newValue) => setState(() {
                                phone = newValue!;
                              }),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: DropDownMultiSelect(
                              options: const [
                                'sector-4',
                                'sector-12',
                                'cooperative colony',
                                'chira chas',
                                'sector-9'
                              ],
                              selectedValues: selectedLocalities,
                              whenEmpty: 'Select Localities (Max 3 allowed)',
                              onChanged: (value) {
                                selectedLocalities = value;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Current Address',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Address Field is mandatory';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (newValue) => setState(() {
                                address = newValue!;
                              }),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Current Pincode',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value != null && value.length < 6) {
                                  return 'Pincode is mandatory and must be of 6 digit';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (newValue) => setState(() {
                                pincode = newValue!;
                              }),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Bank Account Number',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Account number is required';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (newValue) => setState(() {
                                account = newValue!;
                              }),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'IFSC Number',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'IFSC Number is required';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (newValue) => setState(() {
                                ifsc = newValue!;
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    isActive: currentStep >= 0,
                    state: currentStep > 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: const Text("Submit Information"),
                    subtitle: const Text("Documents"),
                    content: Column(
                      children: [
                        DocumentField(
                          documentName: "Aadhar",
                          gotDocument: gotAadhar,
                          filePath: aadharPath,
                          onDocumentRequested: () async {
                            final result = await FilePicker.platform
                                .pickFiles(type: FileType.image);
                            if (result != null) {
                              final file = result.files.first;
                              log(file.path!);
                              setState(() {
                                gotAadhar = true;
                                aadharPath = file.path!;
                              });
                            } else {
                              return;
                            }
                          },
                        ),
                        DocumentField(
                          documentName: "PAN CARD",
                          gotDocument: gotPan,
                          filePath: panPath,
                          onDocumentRequested: () async {
                            final result = await FilePicker.platform
                                .pickFiles(type: FileType.image);
                            if (result != null) {
                              final file = result.files.first;
                              log(file.path!);
                              setState(() {
                                gotPan = true;
                                panPath = file.path!;
                              });
                            } else {
                              return;
                            }
                          },
                        ),
                        DocumentField(
                          documentName: "DL",
                          gotDocument: gotDL,
                          filePath: dlPath,
                          onDocumentRequested: () async {
                            final result = await FilePicker.platform
                                .pickFiles(type: FileType.image);
                            if (result != null) {
                              final file = result.files.first;
                              log(file.path!);
                              setState(() {
                                gotDL = true;
                                dlPath = file.path!;
                              });
                            } else {
                              return;
                            }
                          },
                        ),
                        DocumentField(
                          documentName: "Bank Cheque",
                          gotDocument: gotBankCheque,
                          filePath: chequePath,
                          onDocumentRequested: () async {
                            final result = await FilePicker.platform
                                .pickFiles(type: FileType.image);
                            if (result != null) {
                              final file = result.files.first;
                              log(file.path!);
                              setState(() {
                                gotBankCheque = true;
                                chequePath = file.path!;
                              });
                            } else {
                              return;
                            }
                          },
                        ),
                        DocumentField(
                          documentName: "Photo",
                          gotDocument: gotPhoto,
                          filePath: photoPath,
                          onDocumentRequested: () async {
                            final result = await FilePicker.platform
                                .pickFiles(type: FileType.image);
                            if (result != null) {
                              final file = result.files.first;
                              log(file.path!);
                              setState(() {
                                gotPhoto = true;
                                photoPath = file.path!;
                              });
                            } else {
                              return;
                            }
                          },
                        ),
                      ],
                    ),
                    isActive: currentStep >= 1,
                    state: currentStep > 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
