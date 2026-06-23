import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recruit_iq/Model/all_models.dart';
import 'package:recruit_iq/controllers/auth_controller.dart';
import 'package:recruit_iq/utils/Ads_Variable.dart';
import 'package:recruit_iq/utils/app_connectivity.dart';
import 'package:recruit_iq/utils/app_constant.dart';
import 'package:recruit_iq/utils/validators.dart';
import 'package:recruit_iq/widgets/skill_input_widget.dart';

import '../utils/app_theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = Get.find<AuthController>();

  // Shared controllers
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();

  // Recruiter
  final _companyCtrl = TextEditingController();

  // Candidate
  final _headlineCtrl = TextEditingController();
  final _titleCtrl = TextEditingController();
  final _currentCompanyCtrl = TextEditingController();
  final _yearsExpCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  final _domainCtrl = TextEditingController();

  final _selectedRole = AppConstants.roleRecruiter.obs;
  final _obscurePassword = true.obs;
  final _skills = <Skill>[].obs;

  @override
  void initState() {
    showLog("backend Uri : ${AdsVariable.backendUri}");
    super.initState();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _nameCtrl.dispose();
    _companyCtrl.dispose();
    _headlineCtrl.dispose();
    _titleCtrl.dispose();
    _currentCompanyCtrl.dispose();
    _yearsExpCtrl.dispose();
    _locationCtrl.dispose();
    _domainCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final payload = <String, dynamic>{
      'email': _emailCtrl.text.trim(),
      'password': _passwordCtrl.text,
      'role': _selectedRole.value,
      'full_name': _nameCtrl.text.trim(),
    };

    if (_selectedRole.value == AppConstants.roleRecruiter) {
      if (_companyCtrl.text.isNotEmpty) {
        payload['company'] = _companyCtrl.text.trim();
      }
    } else {
      if (_headlineCtrl.text.isNotEmpty)
        payload['headline'] = _headlineCtrl.text.trim();
      if (_titleCtrl.text.isNotEmpty)
        payload['current_title'] = _titleCtrl.text.trim();
      if (_currentCompanyCtrl.text.isNotEmpty)
        payload['current_company'] = _currentCompanyCtrl.text.trim();
      if (_locationCtrl.text.isNotEmpty)
        payload['location'] = _locationCtrl.text.trim();
      if (_yearsExpCtrl.text.isNotEmpty) {
        payload['years_exp'] = double.tryParse(_yearsExpCtrl.text) ?? 0.0;
      }
      // Parse domain chips
      if (_domainCtrl.text.isNotEmpty) {
        payload['domain'] = _domainCtrl.text
            .split(',')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .toList();
      }
      if (_skills.isNotEmpty) {
        payload['skills'] = _skills.map((s) => s.toJson()).toList();
      }
    }

    _auth.register(payload);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Role toggle
              Text('I am a', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              Obx(
                () => Row(
                  children: [
                    _RoleChip(
                      label: 'Recruiter',
                      icon: Icons.business_center_outlined,
                      selected:
                          _selectedRole.value == AppConstants.roleRecruiter,
                      onTap: () =>
                          _selectedRole.value = AppConstants.roleRecruiter,
                    ),
                    const SizedBox(width: 12),
                    _RoleChip(
                      label: 'Candidate',
                      icon: Icons.person_outline,
                      selected:
                          _selectedRole.value == AppConstants.roleCandidate,
                      onTap: () =>
                          _selectedRole.value = AppConstants.roleCandidate,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Common fields
              TextFormField(
                controller: _nameCtrl,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: Validators.name,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: Validators.email,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => TextFormField(
                  controller: _passwordCtrl,
                  obscureText: _obscurePassword.value,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: Validators.password,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () =>
                          _obscurePassword.value = !_obscurePassword.value,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Role-specific fields
              Obx(
                () => _selectedRole.value == AppConstants.roleRecruiter
                    ? _buildRecruiterFields()
                    : _buildCandidateFields(),
              ),

              const SizedBox(height: 28),
              Obx(
                () => ElevatedButton(
                  onPressed: _auth.isLoading.value ? null : _submit,
                  child: _auth.isLoading.value
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Create Account'),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: const Text.rich(
                    TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(color: AppColors.textSecondary),
                      children: [
                        TextSpan(
                          text: 'Sign In',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecruiterFields() {
    return TextFormField(
      controller: _companyCtrl,
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        labelText: 'Company (optional)',
        prefixIcon: Icon(Icons.apartment_outlined),
      ),
    );
  }

  Widget _buildCandidateFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _headlineCtrl,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            labelText: 'Headline (e.g. ML Engineer at Google)',
            prefixIcon: Icon(Icons.title_outlined),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _titleCtrl,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Current Title'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: _yearsExpCtrl,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: Validators.positiveNumber,
                decoration: const InputDecoration(labelText: 'Years Exp.'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _currentCompanyCtrl,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            labelText: 'Current Company',
            prefixIcon: Icon(Icons.business_outlined),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _locationCtrl,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            labelText: 'Location',
            prefixIcon: Icon(Icons.location_on_outlined),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _domainCtrl,
          decoration: const InputDecoration(
            labelText: 'Domain (comma-separated)',
            hintText: 'ml, backend, cloud',
            prefixIcon: Icon(Icons.category_outlined),
          ),
        ),
        const SizedBox(height: 20),

        // Skills
        Text('Skills', style: Get.textTheme.titleMedium),
        const SizedBox(height: 12),
       SkillInputWidget(
            skills: _skills,
            onAdd: (skill) => _skills.add(skill),
            onRemove: (idx) => _skills.removeAt(idx),
          ),

      ],
    );
  }
}

class _RoleChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _RoleChip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.divider,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: selected ? Colors.white : AppColors.textSecondary,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
