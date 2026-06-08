import 'package:flutter/material.dart';
import '../../core/themes/app_colors.dart';

class EditDialog extends StatelessWidget {
  final String title;
  final String label;
  final String? initialValue;
  final ValueChanged<String> onSave;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const EditDialog({
    super.key,
    required this.title,
    required this.label,
    this.initialValue,
    required this.onSave,
    this.keyboardType,
    this.validator,
  });

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String label,
    String? initialValue,
    required ValueChanged<String> onSave,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) async {
    final controller = TextEditingController(text: initialValue);
    final formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            validator: validator,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                onSave(controller.text);
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
