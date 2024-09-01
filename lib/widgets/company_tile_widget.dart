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

class CompanyTileWidget extends StatelessWidget {
  final Company company;
  final bool isApplied;
  final Function onTileTap;
  const CompanyTileWidget(
      {super.key,
      required this.company,
      required this.isApplied,
      required this.onTileTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 14),
      child: Card(
        surfaceTintColor: Colors.white,
        color: Colors.white,
        elevation: 1,
        child: InkWell(
          onTap: () {
            onTileTap();
          },
          child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              width: MediaQuery.of(context).size.width * 0.85,
              height: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
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
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(company.name.toTitleCase,
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                        Text(company.description,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: isApplied
                              ? Colors.green.withOpacity(0.2)
                              : Colors.blue.withOpacity(0.2),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: IconButton(
                        onPressed: () {
                          onTileTap();
                        },
                        icon: Icon(
                          isApplied
                              ? Icons.check_circle_outline_rounded
                              : Icons.work,
                          color: Colors.white,
                          size: 16,
                        ),
                        style: IconButton.styleFrom(
                            backgroundColor: isApplied
                                ? Colors.green[600]
                                : Colors.blue[600])),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
