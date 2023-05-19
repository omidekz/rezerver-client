import 'package:flutter/material.dart'
    show
        StatelessWidget,
        IconData,
        TextEditingController,
        Size,
        TextInputType,
        Widget,
        BuildContext,
        TextField,
        TextDirection,
        InputDecoration,
        Column,
        Row,
        Flexible,
        Icon,
        Padding,
        EdgeInsets,
        Text,
        TextStyle,
        Colors,
        TextOverflow,
        CrossAxisAlignment,
        MainAxisAlignment;

class TextFieldC extends StatelessWidget {
  final String hintText;
  final String? errMsg;
  final IconData icon;
  final TextEditingController? controller;
  final TextInputType? keyboard;
  final bool? obscure;
  const TextFieldC({
    super.key,
    required this.hintText,
    required this.icon,
    this.controller,
    this.keyboard,
    this.obscure,
    this.errMsg = '',
  });

  TextField textField() {
    return TextField(
      textDirection: TextDirection.rtl,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon),
        hintTextDirection: TextDirection.rtl,
      ),
      keyboardType: keyboard,
      obscureText: obscure ?? false,
    );
  }

  Row errorText() {
    return Row(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              errMsg ?? '',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: Colors.red.shade400,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 2,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Column build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        textField(),
        errorText(),
      ],
    );
  }
}
