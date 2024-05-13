import 'package:app_unicv/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextInput extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType tipoTeclado;
  final bool inputSenha;
  final Function(String?)? validator;
  final Function()? onSaved;

  const TextInput(
      {super.key,
      required this.label,
      required this.controller,
      this.tipoTeclado = TextInputType.text,
      this.inputSenha = false,
      this.validator,
      this.onSaved});

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool _obscureText = false;
  bool _inputValidado = true;
  @override
  void initState() {
    super.initState();
    _obscureText = widget.inputSenha;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 20,
            color: AppColors.mainYellow,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          cursorColor: AppColors.black,
          controller: widget.controller,
          keyboardType: widget.tipoTeclado,
          obscureText: _obscureText,
          validator: (value) => widget.validator?.call(value),
          onSaved: (value) => widget.onSaved?.call(),
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.black,
              ),
              borderRadius: BorderRadius.all(
                Radius.zero,
              ),
            ),
            filled: true,
            fillColor: AppColors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10.0,
            ),
            suffixIcon: widget.inputSenha
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: _obscureText
                        ? const Icon(
                            Icons.visibility,
                            color: AppColors.mainYellow,
                          )
                        : const Icon(
                            Icons.visibility_off,
                            color: AppColors.mainYellow,
                          ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
