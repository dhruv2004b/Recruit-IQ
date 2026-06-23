import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recruit_iq/controllers/jobs_controller.dart';
import 'package:recruit_iq/utils/validators.dart';

class EditJobScreen extends StatefulWidget {
  const EditJobScreen({super.key});

  @override
  State<EditJobScreen> createState() => _EditJobScreenState();
}

class _EditJobScreenState extends State<EditJobScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ctrl = Get.find<JobsController>();
  late final TextEditingController _titleCtrl;
  late final TextEditingController _jdCtrl;

  @override
  void initState() {
    super.initState();
    final job = _ctrl.selectedJob.value;
    _titleCtrl = TextEditingController(text: job?.title ?? '');
    _jdCtrl = TextEditingController(text: job?.rawJd ?? '');
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _jdCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final id = _ctrl.selectedJob.value?.id;
    if (id == null) return;
    _ctrl.updateJob(id, _titleCtrl.text.trim(), _jdCtrl.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Job')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleCtrl,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (v) => Validators.minLength(v, 3, 'Job title'),
                decoration: const InputDecoration(
                  labelText: 'Job Title',
                  prefixIcon: Icon(Icons.title_rounded),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _jdCtrl,
                maxLines: 14,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (v) => Validators.minLength(v, 100, 'Job description'),
                decoration: const InputDecoration(
                  labelText: 'Job Description',
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 28),
              Obx(() => ElevatedButton.icon(
                onPressed: _ctrl.isSubmitting.value ? null : _submit,
                icon: _ctrl.isSubmitting.value
                    ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2))
                    : const Icon(Icons.save_rounded),
                label: Text(_ctrl.isSubmitting.value
                    ? 'Re-parsing with AI...'
                    : 'Save & Re-parse'),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
