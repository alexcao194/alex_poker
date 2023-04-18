import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  const InputText({
    Key? key,
    this.controller,
    required this.title,
    this.isObscure,
    this.textInputAction,
    this.textInputType
  }) : super(key: key);

  final TextEditingController? controller;
  final bool? isObscure;
  final String title;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  bool visible = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: const Color.fromARGB(79, 255, 255, 255),
          border: Border.all(color: Colors.white, width: 1.2
        ),
        borderRadius: BorderRadius.circular(15.0)
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: TextField(
          textInputAction: widget.textInputAction,
          keyboardType: widget.textInputType,
          controller: widget.controller,
          obscureText: (widget.isObscure == true ? visible : false),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.title,
              hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: const Color.fromARGB(180, 255, 255, 255),
              ),
              suffixIcon: (widget.isObscure == true)
                  ? IconButton(
                      icon: Icon(
                          visible ? Icons.visibility : Icons.visibility_off,
                          color: const Color.fromARGB(180, 255, 255, 255)),
                      onPressed: () {
                        setState(() {
                          visible = !visible;
                        });
                      },
                    )
                  : null),
        ),
      ),
    );
  }
}
