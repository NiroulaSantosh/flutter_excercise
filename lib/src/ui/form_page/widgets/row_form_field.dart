import 'package:flutter/material.dart';

import '../form_screen.dart';

class RowFormField extends StatelessWidget {
  const RowFormField({
    Key? key,
    this.controller,
    this.focusNode,
    required this.label,
    this.validator,
    this.onSaved,
    this.isDob = false,
  }) : super(key: key);
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String label;
  final ValidatorFunction? validator;
  final ValueSetter<String?>? onSaved;
  final bool isDob;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        children: [
          SizedBox(
            width: constraints.maxWidth * 0.34,
            child: Text(
              '$label:',
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xff333333),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: controller,
              focusNode: focusNode,
              validator: validator,
              onFieldSubmitted: onSaved,
              onTap: isDob
                  ? () async {
                      final data = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now().subtract(
                          const Duration(days: 365 * 50),
                        ),
                        lastDate: DateTime.now(),
                      );

                      if (data != null) {
                        debugPrint("$data");
                        controller!.text = data.toString().split(' ').first;
                      }
                    }
                  : null,
              decoration: InputDecoration(
                isDense: true,
                suffixIcon: isDob
                    ? const Icon(
                        Icons.calendar_today,
                      )
                    : null,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
