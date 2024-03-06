import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';


class PhoneNumberInputForm extends StatefulWidget {
  const PhoneNumberInputForm({super.key, required this.controller, required this.initialCountry, required this.phoneNumber});

  final TextEditingController controller;
  final String initialCountry;
  final PhoneNumber phoneNumber;
  @override
  State<PhoneNumberInputForm> createState() => _PhoneNumberInputFormState();
}

class _PhoneNumberInputFormState extends State<PhoneNumberInputForm> {
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding:
      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(10)
      ),
      child: InternationalPhoneNumberInput(
        onInputChanged: (PhoneNumber number) {
          print(number.phoneNumber);
        },
        onInputValidated: (bool value) {
          print(value);
        },
        selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          useBottomSheetSafeArea: true,
        ),
        ignoreBlank: false,
        autoValidateMode: AutovalidateMode.disabled,
        selectorTextStyle: const TextStyle(color: Colors.black),
        initialValue: widget.phoneNumber,
        textFieldController: widget.controller,
        formatInput: true,
        keyboardType: const TextInputType.numberWithOptions(
            signed: true, decimal: true),
        inputBorder: InputBorder.none,
        onSaved: (PhoneNumber number) {
          print('On Saved: $number');
        },
      ),
    );
  }
}