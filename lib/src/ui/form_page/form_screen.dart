import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/map_location_search_bloc.dart';
import '../../../helper/form_validator.dart';
import '../../model/user.dart';
import '../map_page/map_screen.dart';
import 'widgets/row_form_field.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

typedef ValidatorFunction = String? Function(String?);

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _homeAddressController;
  late final TextEditingController _educationController;
  late final TextEditingController _collageNameController;
  late final TextEditingController _collageAddressController;
  late final TextEditingController _dobEditingController;

  late final FocusNode _nameFocuNode;
  late final FocusNode _homeAddressFocuNode;
  late final FocusNode _collageNameFocuNode;
  late final FocusNode _collageAddressFocuNode;
  late final FocusNode _educationFocuNode;
  late final FocusNode _dobFocusNode;

  String selectedGender = 'Male';

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _homeAddressController = TextEditingController();
    _educationController = TextEditingController();
    _collageNameController = TextEditingController();
    _collageAddressController = TextEditingController();
    _dobEditingController = TextEditingController();

    _nameFocuNode = FocusNode();
    _homeAddressFocuNode = FocusNode();
    _collageNameFocuNode = FocusNode();
    _collageAddressFocuNode = FocusNode();
    _educationFocuNode = FocusNode();
    _dobFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _homeAddressController.dispose();
    _educationController.dispose();
    _collageNameController.dispose();
    _collageAddressController.dispose();
    _dobEditingController.dispose();

    _nameFocuNode.dispose();
    _homeAddressFocuNode.dispose();
    _collageNameFocuNode.dispose();
    _collageAddressFocuNode.dispose();
    _educationFocuNode.dispose();
    _dobFocusNode.dispose();

    super.dispose();
  }

  validateFormField() {
    if (_formKey.currentState!.validate()) {
      context.read<MapLocationSearchBloc>().add(
            GetLocationInfo(
              collageAddress: _collageAddressController.text,
              homeAddress: _homeAddressController.text,
            ),
          );

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MapScreen(
            user: User(
              name: _nameController.text,
              dob: DateTime.tryParse(_dobEditingController.text) ??
                  DateTime.now(),
              gender: selectedGender,
              homeAddress: _homeAddressController.text,
              education: _educationController.text,
              collageName: _collageNameController.text,
              collageAddress: _collageAddressController.text,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                RowFormField(
                  controller: _nameController,
                  focusNode: _nameFocuNode,
                  label: 'Name',
                  validator: FormValidator.nameValidator,
                  onSaved: (_) => _dobFocusNode.requestFocus(),
                ),
                const SizedBox(height: 10),
                RowFormField(
                  label: 'Date Of Birth',
                  isDob: true,
                  controller: _dobEditingController,
                  focusNode: _dobFocusNode,
                ),
                const SizedBox(height: 10),
                DropDownField(
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value!;
                    });
                  },
                  selectedGender: selectedGender,
                ),
                const SizedBox(height: 10),
                RowFormField(
                  controller: _homeAddressController,
                  focusNode: _homeAddressFocuNode,
                  label: 'Home Address',
                  validator: FormValidator.addressValidator,
                  onSaved: (_) => _educationFocuNode.requestFocus(),
                ),
                const SizedBox(height: 10),
                RowFormField(
                    controller: _educationController,
                    focusNode: _educationFocuNode,
                    label: 'Education',
                    validator: FormValidator.educationValidator,
                    onSaved: (_) => _collageNameFocuNode.requestFocus()),
                const SizedBox(height: 10),
                RowFormField(
                    controller: _collageNameController,
                    focusNode: _collageNameFocuNode,
                    label: 'Collage Name',
                    validator: FormValidator.collageNameValidator,
                    onSaved: (_) => _collageAddressFocuNode.requestFocus()),
                const SizedBox(height: 10),
                RowFormField(
                    controller: _collageAddressController,
                    focusNode: _collageAddressFocuNode,
                    label: 'Collage Address',
                    validator: FormValidator.addressValidator,
                    onSaved: (_) {
                      validateFormField();
                    }),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: validateFormField,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    icon: Icon(Icons.adaptive.arrow_forward_rounded,
                        color: Colors.white),
                    label: const Text(
                      'Next',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DropDownField extends StatelessWidget {
  const DropDownField({
    Key? key,
    required this.onChanged,
    required this.selectedGender,
  }) : super(key: key);
  final ValueSetter<String?> onChanged;
  final String selectedGender;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        children: [
          SizedBox(
            width: constraints.maxWidth * 0.34,
            child: const Text(
              'Gender',
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xff333333),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                isDense: true,
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
              items: const [
                DropdownMenuItem(
                  value: 'Male',
                  child: Text('Male'),
                ),
                DropdownMenuItem(
                  value: 'Female',
                  child: Text('Female'),
                ),
                DropdownMenuItem(
                  value: 'Other',
                  child: Text('Other'),
                ),
              ],
              onChanged: onChanged,
              value: selectedGender,
            ),
          ),
        ],
      );
    });
  }
}
