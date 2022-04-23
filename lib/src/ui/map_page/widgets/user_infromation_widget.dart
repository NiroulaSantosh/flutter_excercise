import 'package:flutter/material.dart';

import '../../../model/user.dart';

class UserInfromationWidet extends StatelessWidget {
  const UserInfromationWidet({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(0.5),
        2: FlexColumnWidth(5),
      },
      children: [
        buildTableRow('Name', user.name),
        buildTableRow('Date of Birth', user.dob.toString().split(' ').first),
        buildTableRow('Gender', user.gender),
        buildTableRow('Home Address', user.homeAddress),
        buildTableRow('Education', user.education),
        buildTableRow('Collage Name', user.collageName),
        buildTableRow('Collage Address', user.collageAddress),
      ],
    );
  }

  TableRow buildTableRow(String title, String content) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Text(
            '$title:',
            textAlign: TextAlign.end,
            style: buildTextStyle(),
          ),
        ),
        const SizedBox(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Text(
            content,
            style: buildTextStyle(),
          ),
        ),
      ],
    );
  }

  TextStyle buildTextStyle() {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Color(0xff333333),
    );
  }
}
