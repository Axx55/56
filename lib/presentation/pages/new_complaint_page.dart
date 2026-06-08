import 'package:flutter/material.dart';
import '../../core/themes/app_dimensions.dart';

class NewComplaintPage extends StatefulWidget {
  const NewComplaintPage({super.key});

  @override
  State<NewComplaintPage> createState() => _NewComplaintPageState();
}

class _NewComplaintPageState extends State<NewComplaintPage> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('شكوى جديدة')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingMd),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'تفاصيل الشكوى',
                style: TextStyle(
                  fontSize: AppDimensions.fontLg,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppDimensions.paddingMd),
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  labelText: 'عنوان الشكوى',
                  hintText: 'أدخل عنوان الشكوى',
                ),
                validator: (value) =>
                    value!.isEmpty ? 'الرجاء إدخال عنوان الشكوى' : null,
              ),
              const SizedBox(height: AppDimensions.paddingMd),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'وصف الشكوى',
                  hintText: 'اكتب تفاصيل الشكوى هنا...',
                  alignLabelWithHint: true,
                ),
                maxLines: 6,
                validator: (value) =>
                    value!.isEmpty ? 'الرجاء إدخال وصف الشكوى' : null,
              ),
              const SizedBox(height: AppDimensions.paddingLg),
              SizedBox(
                width: double.infinity,
                height: AppDimensions.buttonHeight,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text('إرسال الشكوى'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('تم الإرسال'),
          content: const Text('تم استلام شكواك بنجاح، سنقوم بمراجعتها قريباً'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('حسناً'),
            ),
          ],
        ),
      );
    }
  }
}
