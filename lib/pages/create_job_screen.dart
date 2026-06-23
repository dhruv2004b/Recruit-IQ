import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recruit_iq/controllers/jobs_controller.dart';
import 'package:recruit_iq/utils/validators.dart';

import '../utils/app_theme.dart';

class CreateJobScreen extends StatefulWidget {
  const CreateJobScreen({super.key});

  @override
  State<CreateJobScreen> createState() => _CreateJobScreenState();
}

class _CreateJobScreenState extends State<CreateJobScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _jdCtrl = TextEditingController();
  final _jdLength = 0.obs;
  final _ctrl = Get.find<JobsController>();

  @override
  void initState() {
    super.initState();
    _jdCtrl.addListener(() => _jdLength.value = _jdCtrl.text.length);
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _jdCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    _ctrl.createJob(_titleCtrl.text.trim(), _jdCtrl.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post a Job')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Info banner
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.auto_awesome, color: AppColors.primary, size: 18),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'AI will parse your JD and extract skills, seniority, and domain signals automatically.',
                        style: TextStyle(
                            fontSize: 13, color: AppColors.primary, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Job Title
              TextFormField(
                controller: _titleCtrl,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (v) => Validators.minLength(v, 3, 'Job title'),
                decoration: const InputDecoration(
                  labelText: 'Job Title',
                  hintText: 'e.g. Senior ML Engineer',
                  prefixIcon: Icon(Icons.title_rounded),
                ),
              ),
              const SizedBox(height: 16),

              // Job Description
              TextFormField(
                controller: _jdCtrl,
                maxLines: 12,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (v) => Validators.minLength(v, 100, 'Job description'),
                decoration: const InputDecoration(
                  labelText: 'Job Description',
                  hintText:
                  'Paste the full job description here. Include required skills, responsibilities, experience level...',
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 6),

              // Character count (reactive)
              Obx(() => Text(
                '${_jdLength.value} characters (min 100 required)',
                style: TextStyle(
                  fontSize: 11,
                  color: _jdLength.value < 100
                      ? AppColors.warning
                      : AppColors.textSecondary,
                ),
              )),
              const SizedBox(height: 28),

              // Submit
              Obx(() => ElevatedButton.icon(
                onPressed: _ctrl.isSubmitting.value ? null : _submit,
                icon: _ctrl.isSubmitting.value
                    ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2))
                    : const Icon(Icons.rocket_launch_rounded),
                label: Text(_ctrl.isSubmitting.value
                    ? 'Parsing with AI...'
                    : 'Post Job'),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
