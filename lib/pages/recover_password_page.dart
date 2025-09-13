import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../change_notifiers/registration_controller.dart';
import '../core/constants.dart';
import '../core/validator.dart';
import '../widgets/document_back_button.dart';
import '../widgets/document_button.dart';
import '../widgets/document_form_field.dart';

class RecoverPasswordPage extends StatefulWidget {
  const RecoverPasswordPage({super.key});

  @override
  State<RecoverPasswordPage> createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  late final TextEditingController emailController;

  GlobalKey<FormFieldState> emailKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const DocumentBackButton(),
        title: const Text('Recover Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Don\'t worry! Happens to the best of us!',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              DocumentFormField(
                key: emailKey,
                controller: emailController,
                fillColor: white,
                filled: true,
                labelText: 'Email',
                validator: Validator.emailValidator,
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 48,
                child: Selector<RegistrationController, bool>(
                  selector: (_, controller) => controller.isLoading,
                  builder: (_, isLoading, __) => DocumentButton(
                    onPressed: isLoading
                        ? null
                        : () {
                      if (emailKey.currentState?.validate() ?? false) {
                        context
                            .read<RegistrationController>()
                            .resetPassword(
                          context: context,
                          email: emailController.text.trim(),
                        );
                      }
                    },
                    child: isLoading
                        ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(color: white),
                    )
                        : const Text('Send me a recovery link!'),
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