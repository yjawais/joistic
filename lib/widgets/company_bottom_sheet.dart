import 'package:flutter/material.dart';

import 'package:joistic/models/company_model.dart';

extension StringCasingExtension on String {
  String get toCapitalized =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String get toTitleCase => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized)
      .join(' ');
}

class CompanyBottomSheet extends StatelessWidget {
  final Company company;
  final bool isApplied;
  final Function onApplyTap;
  const CompanyBottomSheet(
      {super.key,
      required this.company,
      required this.isApplied,
      required this.onApplyTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            height: 350,
            constraints: const BoxConstraints(maxHeight: 350),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Text(
                  company.name.toTitleCase,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800]),
                ),
                const SizedBox(height: 10),
                Text(
                  company.description,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                const SizedBox(height: 10),
                const RoleRequirementTextWidget(
                  title: "Role",
                  description: "Flutter Developer",
                ),
                const SizedBox(height: 10),
                const RoleRequirementTextWidget(
                  title: "Requirement",
                  description:
                      "We are looking for a skilled Flutter Developer to join our team.",
                ),
                const Spacer(),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: isApplied
                              ? Colors.green.withOpacity(0.2)
                              : Colors.blue.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: isApplied
                          ? () {}
                          : () {
                              onApplyTap();
                              Navigator.pop(context);
                            },
                      style: ElevatedButton.styleFrom(
                          shadowColor: isApplied ? Colors.green : Colors.blue,
                          backgroundColor:
                              isApplied ? Colors.green[600] : Colors.blue[800],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      child: Text(isApplied ? 'Applied' : 'Apply Now',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              left: 60,
              top: 5,
              child: Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    radius: 28,
                    backgroundImage: NetworkImage(company.imageUrl),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

class RoleRequirementTextWidget extends StatelessWidget {
  final String title;
  final String description;
  const RoleRequirementTextWidget(
      {super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
        Text(description,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800])),
      ],
    );
  }
}
