import 'package:app_unicv/common/colors.dart';
import 'package:app_unicv/services/academico_service.dart';
import 'package:app_unicv/utils/error_message.dart';
import 'package:app_unicv/utils/navigation_helper.dart';
import 'package:app_unicv/utils/snackbar.dart';
import 'package:app_unicv/utils/validators/email.dart';
import 'package:app_unicv/widgets/form/button.dart';
import 'package:app_unicv/widgets/form/text_input.dart';
import 'package:app_unicv/widgets/nav/back_navigator.dart';
import 'package:app_unicv/widgets/space.dart';
import 'package:app_unicv/widgets/spinner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TelaResetSenha extends StatefulWidget {
  const TelaResetSenha({super.key});

  @override
  State<TelaResetSenha> createState() => _TelaResetSenhaState();
}

class _TelaResetSenhaState extends State<TelaResetSenha> {
  final _keyForm = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  void _enviar() async {
    String email = _emailController.text.trim();

    if (!_keyForm.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      AcademicoService academicoService = AcademicoService();
      bool enviadoComSucesso =
          await academicoService.enviarResetSenhaByEmail(email);

      if (enviadoComSucesso) {
        SnackBarMessage.showSuccessSnackbar(
            context, 'E-mail de redefinição enviado com sucesso!');
        NavigationUtil.direcionarPara(context, '/');
      } else {
        SnackBarMessage.showErrorSnackbar(context,
            'E-mail não cadastrado, por favor escreva um e-mail cadastrado.');
      }
    } on FirebaseException catch (e) {
      SnackBarMessage.showErrorSnackbar(
          context, ErrorMessage.definirMensagemErro(e.code));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  BackNavigator(
                    onPressed: () {
                      NavigationUtil.direcionarPara(context, '/');
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 30,
                      bottom: 20,
                      left: 20,
                      right: 20,
                    ),
                    child: Image.asset(
                      'img/logo-unicv.png',
                      width: 300,
                      height: 100,
                    ),
                  ),
                ],
              ),
              const SpaceWidget(spaceWidth: 0, spaceHeight: 100),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _keyForm,
                  child: Column(
                    children: [
                      TextInput(
                        label: 'E-mail',
                        controller: _emailController,
                        tipoTeclado: TextInputType.emailAddress,
                        validator: (value) => EmailValidator.validate(value),
                      ),
                      const SpaceWidget(spaceWidth: 0, spaceHeight: 30),
                      if (_isLoading) ...{
                        const SpinnerProgressIndicator(),
                      } else ...{
                        MainButton(label: 'Enviar', onPressed: _enviar),
                      }
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
