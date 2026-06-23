// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:recruit_iq/Model/all_models.dart';
// import 'package:recruit_iq/controllers/auth_controller.dart';
// import 'package:recruit_iq/controllers/profile_controller.dart';
// import 'package:recruit_iq/utils/validators.dart';
// import 'package:recruit_iq/widgets/skill_input_widget.dart';
//
// import '../utils/app_theme.dart';
//
// class EditProfileScreen extends StatefulWidget {
//   const EditProfileScreen({super.key});
//
//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }
//
// class _EditProfileScreenState extends State<EditProfileScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _auth = Get.find<AuthController>();
//   final _ctrl = Get.find<ProfileController>();
//
//   late final TextEditingController _nameCtrl;
//   late final TextEditingController _headlineCtrl;
//   late final TextEditingController _titleCtrl;
//   late final TextEditingController _companyCtrl;
//   late final TextEditingController _locationCtrl;
//   late final TextEditingController _yearsExpCtrl;
//   late final TextEditingController _domainCtrl;
//   late final RxList<Skill> _skills;
//   late final RxList<CareerHistory> _career;
//   late final RxList<Education> _education;
//   late final RxList<Certification> _certifications;
//   late final RxList<Language> _languages;
//
//   int _currentStep = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     final p = _auth.candidateProfile.value;
//     _nameCtrl = TextEditingController(text: p?.fullName ?? '');
//     _headlineCtrl = TextEditingController(text: p?.headline ?? '');
//     _titleCtrl = TextEditingController(text: p?.currentTitle ?? '');
//     _companyCtrl = TextEditingController(text: p?.currentCompany ?? '');
//     _locationCtrl = TextEditingController(text: p?.location ?? '');
//     _yearsExpCtrl =
//         TextEditingController(text: p?.yearsExp.toString() ?? '0');
//     _domainCtrl =
//         TextEditingController(text: p?.domain.join(', ') ?? '');
//     _skills = RxList<Skill>(List.from(p?.skills ?? []));
//     _career = RxList<CareerHistory>(List.from(p?.careerHistory ?? []));
//     _education = RxList<Education>(List.from(p?.education ?? []));
//     _certifications =
//         RxList<Certification>(List.from(p?.certifications ?? []));
//     _languages = RxList<Language>(List.from(p?.languages ?? []));
//   }
//
//   @override
//   void dispose() {
//     _nameCtrl.dispose();
//     _headlineCtrl.dispose();
//     _titleCtrl.dispose();
//     _companyCtrl.dispose();
//     _locationCtrl.dispose();
//     _yearsExpCtrl.dispose();
//     _domainCtrl.dispose();
//     super.dispose();
//   }
//
//   void _submit() {
//     if (!_formKey.currentState!.validate()) return;
//
//     final payload = <String, dynamic>{
//       'full_name': _nameCtrl.text.trim(),
//       'headline': _headlineCtrl.text.trim(),
//       'current_title': _titleCtrl.text.trim(),
//       'current_company': _companyCtrl.text.trim(),
//       'location': _locationCtrl.text.trim(),
//       'years_exp': double.tryParse(_yearsExpCtrl.text) ?? 0.0,
//       'domain': _domainCtrl.text
//           .split(',')
//           .map((s) => s.trim())
//           .where((s) => s.isNotEmpty)
//           .toList(),
//       'skills': _skills.map((s) => s.toJson()).toList(),
//       'career_history': _career.map((c) => c.toJson()).toList(),
//       'education': _education.map((e) => e.toJson()).toList(),
//       'certifications': _certifications.map((c) => c.toJson()).toList(),
//       'languages': _languages.map((l) => l.toJson()).toList(),
//     };
//     _ctrl.updateProfile(payload);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Edit Profile')),
//       body: Form(
//         key: _formKey,
//         child: Stepper(
//           currentStep: _currentStep,
//           onStepTapped: (i) => setState(() => _currentStep = i),
//           controlsBuilder: (context, details) => Padding(
//             padding: const EdgeInsets.only(top: 16),
//             child: Row(
//               children: [
//                 if (details.stepIndex < 3)
//                   ElevatedButton(
//                     onPressed: details.onStepContinue,
//                     style: ElevatedButton.styleFrom(
//                         minimumSize: const Size(100, 44)),
//                     child: const Text('Next'),
//                   ),
//                 if (details.stepIndex == 3)
//                   Obx(() => ElevatedButton(
//                     onPressed:
//                     _ctrl.isUpdating.value ? null : _submit,
//                     style: ElevatedButton.styleFrom(
//                         minimumSize: const Size(120, 44)),
//                     child: _ctrl.isUpdating.value
//                         ? const SizedBox(
//                         width: 18,
//                         height: 18,
//                         child: CircularProgressIndicator(
//                             color: Colors.white, strokeWidth: 2))
//                         : const Text('Save Profile'),
//                   )),
//                 const SizedBox(width: 12),
//                 if (details.stepIndex > 0)
//                   OutlinedButton(
//                     onPressed: details.onStepCancel,
//                     style: OutlinedButton.styleFrom(
//                         minimumSize: const Size(80, 44)),
//                     child: const Text('Back'),
//                   ),
//               ],
//             ),
//           ),
//           onStepContinue: () {
//             if (_currentStep < 3) {
//               setState(() => _currentStep++);
//             }
//           },
//           onStepCancel: () {
//             if (_currentStep > 0) {
//               setState(() => _currentStep--);
//             }
//           },
//           steps: [
//             Step(
//               title: const Text('Basic Info'),
//               isActive: _currentStep >= 0,
//               state: _currentStep > 0
//                   ? StepState.complete
//                   : StepState.indexed,
//               content: _buildBasicInfo(),
//             ),
//             Step(
//               title: const Text('Skills & Domain'),
//               isActive: _currentStep >= 1,
//               state: _currentStep > 1
//                   ? StepState.complete
//                   : StepState.indexed,
//               content: _buildSkillsSection(),
//             ),
//             Step(
//               title: const Text('Career History'),
//               isActive: _currentStep >= 2,
//               state: _currentStep > 2
//                   ? StepState.complete
//                   : StepState.indexed,
//               content: _buildCareerSection(),
//             ),
//             Step(
//               title: const Text('Education & More'),
//               isActive: _currentStep >= 3,
//               state: StepState.indexed,
//               content: _buildEducationSection(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBasicInfo() {
//     return Column(
//       children: [
//         TextFormField(
//           controller: _nameCtrl,
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           validator: Validators.name,
//           decoration: const InputDecoration(labelText: 'Full Name'),
//         ),
//         const SizedBox(height: 12),
//         TextFormField(
//           controller: _headlineCtrl,
//           decoration: const InputDecoration(
//               labelText: 'Headline',
//               hintText: 'ML Engineer at Google'),
//         ),
//         const SizedBox(height: 12),
//         Row(
//           children: [
//             Expanded(
//               child: TextFormField(
//                 controller: _titleCtrl,
//                 decoration:
//                 const InputDecoration(labelText: 'Current Title'),
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: TextFormField(
//                 controller: _yearsExpCtrl,
//                 keyboardType: TextInputType.number,
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 validator: Validators.positiveNumber,
//                 decoration:
//                 const InputDecoration(labelText: 'Years Exp.'),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         TextFormField(
//           controller: _companyCtrl,
//           decoration:
//           const InputDecoration(labelText: 'Current Company'),
//         ),
//         const SizedBox(height: 12),
//         TextFormField(
//           controller: _locationCtrl,
//           decoration: const InputDecoration(labelText: 'Location'),
//         ),
//         const SizedBox(height: 12),
//         TextFormField(
//           controller: _domainCtrl,
//           decoration: const InputDecoration(
//             labelText: 'Domain (comma-separated)',
//             hintText: 'ml, backend, cloud',
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSkillsSection() {
//     return Obx(() => SkillInputWidget(
//       skills: _skills,
//       onAdd: (s) => _skills.add(s),
//       onRemove: (i) => _skills.removeAt(i),
//     ));
//   }
//
//   Widget _buildCareerSection() {
//     return Obx(() => Column(
//       children: [
//         ..._career.asMap().entries.map((entry) {
//           final i = entry.key;
//           final c = entry.value;
//           return _CareerTile(
//             career: c,
//             onRemove: () => _career.removeAt(i),
//           );
//         }),
//         OutlinedButton.icon(
//           onPressed: () => _showAddCareerDialog(),
//           icon: const Icon(Icons.add, size: 18),
//           label: const Text('Add Position'),
//           style: OutlinedButton.styleFrom(
//             minimumSize: const Size(double.infinity, 44),
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10)),
//           ),
//         ),
//       ],
//     ));
//   }
//
//   Widget _buildEducationSection() {
//     return Obx(() => Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text('Education',
//             style: TextStyle(fontWeight: FontWeight.w600)),
//         const SizedBox(height: 8),
//         ..._education.asMap().entries.map((entry) {
//           final i = entry.key;
//           final e = entry.value;
//           return ListTile(
//             contentPadding: EdgeInsets.zero,
//             leading: const Icon(Icons.school_outlined,
//                 color: AppColors.primary),
//             title: Text(e.institution),
//             subtitle: Text('${e.degree} • ${e.fieldOfStudy}'),
//             trailing: IconButton(
//               icon: const Icon(Icons.close,
//                   color: AppColors.error, size: 18),
//               onPressed: () => _education.removeAt(i),
//             ),
//           );
//         }),
//         OutlinedButton.icon(
//           onPressed: _showAddEducationDialog,
//           icon: const Icon(Icons.add, size: 18),
//           label: const Text('Add Education'),
//           style: OutlinedButton.styleFrom(
//             minimumSize: const Size(double.infinity, 44),
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10)),
//           ),
//         ),
//         const SizedBox(height: 20),
//         const Text('Certifications',
//             style: TextStyle(fontWeight: FontWeight.w600)),
//         const SizedBox(height: 8),
//         ..._certifications.asMap().entries.map((entry) {
//           final i = entry.key;
//           final c = entry.value;
//           return ListTile(
//             contentPadding: EdgeInsets.zero,
//             leading: const Icon(Icons.verified_outlined,
//                 color: AppColors.success),
//             title: Text(c.name),
//             subtitle: c.issuer != null ? Text(c.issuer!) : null,
//             trailing: IconButton(
//               icon: const Icon(Icons.close,
//                   color: AppColors.error, size: 18),
//               onPressed: () => _certifications.removeAt(i),
//             ),
//           );
//         }),
//         OutlinedButton.icon(
//           onPressed: _showAddCertDialog,
//           icon: const Icon(Icons.add, size: 18),
//           label: const Text('Add Certification'),
//           style: OutlinedButton.styleFrom(
//             minimumSize: const Size(double.infinity, 44),
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10)),
//           ),
//         ),
//         const SizedBox(height: 20),
//         const Text('Languages',
//             style: TextStyle(fontWeight: FontWeight.w600)),
//         const SizedBox(height: 8),
//         ..._languages.asMap().entries.map((entry) {
//           final i = entry.key;
//           final l = entry.value;
//           return ListTile(
//             contentPadding: EdgeInsets.zero,
//             leading: const Icon(Icons.language_outlined,
//                 color: AppColors.secondary),
//             title: Text(l.language),
//             subtitle: Text(l.proficiency),
//             trailing: IconButton(
//               icon: const Icon(Icons.close,
//                   color: AppColors.error, size: 18),
//               onPressed: () => _languages.removeAt(i),
//             ),
//           );
//         }),
//         OutlinedButton.icon(
//           onPressed: _showAddLanguageDialog,
//           icon: const Icon(Icons.add, size: 18),
//           label: const Text('Add Language'),
//           style: OutlinedButton.styleFrom(
//             minimumSize: const Size(double.infinity, 44),
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10)),
//           ),
//         ),
//       ],
//     ));
//   }
//
//   // ── Dialogs ───────────────────────────────────────────────────────────────
//
//   void _showAddCareerDialog() {
//     final companyCtrl = TextEditingController();
//     final titleCtrl = TextEditingController();
//     final descCtrl = TextEditingController();
//     final isCurrent = false.obs;
//     final industryCtrl = TextEditingController();
//
//     Get.dialog(AlertDialog(
//       title: const Text('Add Position'),
//       content: SingleChildScrollView(
//         child: Column(mainAxisSize: MainAxisSize.min, children: [
//           TextField(
//               controller: companyCtrl,
//               decoration: const InputDecoration(labelText: 'Company')),
//           const SizedBox(height: 10),
//           TextField(
//               controller: titleCtrl,
//               decoration: const InputDecoration(labelText: 'Title')),
//           const SizedBox(height: 10),
//           TextField(
//               controller: industryCtrl,
//               decoration: const InputDecoration(labelText: 'Industry')),
//           const SizedBox(height: 10),
//           TextField(
//               controller: descCtrl,
//               maxLines: 3,
//               decoration: const InputDecoration(
//                   labelText: 'Description (optional)')),
//           const SizedBox(height: 10),
//           Obx(() => SwitchListTile(
//             contentPadding: EdgeInsets.zero,
//             title: const Text('Currently working here',
//                 style: TextStyle(fontSize: 14)),
//             value: isCurrent.value,
//             onChanged: (v) => isCurrent.value = v,
//           )),
//         ]),
//       ),
//       actions: [
//         TextButton(onPressed: Get.back, child: const Text('Cancel')),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(minimumSize: Size.zero),
//           onPressed: () {
//             if (companyCtrl.text.isEmpty || titleCtrl.text.isEmpty) return;
//             _career.add(CareerHistory(
//               company: companyCtrl.text.trim(),
//               title: titleCtrl.text.trim(),
//               isCurrent: isCurrent.value,
//               industry: industryCtrl.text.trim().isEmpty
//                   ? null
//                   : industryCtrl.text.trim(),
//               description: descCtrl.text.trim().isEmpty
//                   ? null
//                   : descCtrl.text.trim(),
//             ));
//             Get.back();
//           },
//           child: const Text('Add'),
//         ),
//       ],
//     ));
//   }
//
//   void _showAddEducationDialog() {
//     final instCtrl = TextEditingController();
//     final degreeCtrl = TextEditingController();
//     final fieldCtrl = TextEditingController();
//     final startYearCtrl = TextEditingController();
//     final endYearCtrl = TextEditingController();
//
//     Get.dialog(AlertDialog(
//       title: const Text('Add Education'),
//       content: Column(mainAxisSize: MainAxisSize.min, children: [
//         TextField(
//             controller: instCtrl,
//             decoration:
//             const InputDecoration(labelText: 'Institution')),
//         const SizedBox(height: 10),
//         TextField(
//             controller: degreeCtrl,
//             decoration: const InputDecoration(labelText: 'Degree')),
//         const SizedBox(height: 10),
//         TextField(
//             controller: fieldCtrl,
//             decoration:
//             const InputDecoration(labelText: 'Field of Study')),
//         const SizedBox(height: 10),
//         Row(children: [
//           Expanded(
//             child: TextField(
//                 controller: startYearCtrl,
//                 keyboardType: TextInputType.number,
//                 decoration:
//                 const InputDecoration(labelText: 'Start Year')),
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             child: TextField(
//                 controller: endYearCtrl,
//                 keyboardType: TextInputType.number,
//                 decoration:
//                 const InputDecoration(labelText: 'End Year')),
//           ),
//         ]),
//       ]),
//       actions: [
//         TextButton(onPressed: Get.back, child: const Text('Cancel')),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(minimumSize: Size.zero),
//           onPressed: () {
//             if (instCtrl.text.isEmpty) return;
//             _education.add(Education(
//               institution: instCtrl.text.trim(),
//               degree: degreeCtrl.text.trim(),
//               fieldOfStudy: fieldCtrl.text.trim(),
//               startYear: int.tryParse(startYearCtrl.text),
//               endYear: int.tryParse(endYearCtrl.text),
//             ));
//             Get.back();
//           },
//           child: const Text('Add'),
//         ),
//       ],
//     ));
//   }
//
//   void _showAddCertDialog() {
//     final nameCtrl = TextEditingController();
//     final issuerCtrl = TextEditingController();
//     final yearCtrl = TextEditingController();
//
//     Get.dialog(AlertDialog(
//       title: const Text('Add Certification'),
//       content: Column(mainAxisSize: MainAxisSize.min, children: [
//         TextField(
//             controller: nameCtrl,
//             decoration: const InputDecoration(labelText: 'Name')),
//         const SizedBox(height: 10),
//         TextField(
//             controller: issuerCtrl,
//             decoration: const InputDecoration(labelText: 'Issuer')),
//         const SizedBox(height: 10),
//         TextField(
//             controller: yearCtrl,
//             keyboardType: TextInputType.number,
//             decoration: const InputDecoration(labelText: 'Year')),
//       ]),
//       actions: [
//         TextButton(onPressed: Get.back, child: const Text('Cancel')),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(minimumSize: Size.zero),
//           onPressed: () {
//             if (nameCtrl.text.isEmpty) return;
//             _certifications.add(Certification(
//               name: nameCtrl.text.trim(),
//               issuer: issuerCtrl.text.trim().isEmpty
//                   ? null
//                   : issuerCtrl.text.trim(),
//               year: int.tryParse(yearCtrl.text),
//             ));
//             Get.back();
//           },
//           child: const Text('Add'),
//         ),
//       ],
//     ));
//   }
//
//   void _showAddLanguageDialog() {
//     final langCtrl = TextEditingController();
//     final proficiency = 'professional'.obs;
//
//     Get.dialog(AlertDialog(
//       title: const Text('Add Language'),
//       content: Column(mainAxisSize: MainAxisSize.min, children: [
//         TextField(
//             controller: langCtrl,
//             decoration: const InputDecoration(labelText: 'Language')),
//         const SizedBox(height: 10),
//         Obx(() => DropdownButtonFormField<String>(
//           value: proficiency.value,
//           decoration:
//           const InputDecoration(labelText: 'Proficiency'),
//           items: const [
//             DropdownMenuItem(
//                 value: 'native', child: Text('Native')),
//             DropdownMenuItem(
//                 value: 'professional', child: Text('Professional')),
//             DropdownMenuItem(
//                 value: 'conversational',
//                 child: Text('Conversational')),
//             DropdownMenuItem(
//                 value: 'basic', child: Text('Basic')),
//           ],
//           onChanged: (v) => proficiency.value = v!,
//         )),
//       ]),
//       actions: [
//         TextButton(onPressed: Get.back, child: const Text('Cancel')),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(minimumSize: Size.zero),
//           onPressed: () {
//             if (langCtrl.text.isEmpty) return;
//             _languages.add(Language(
//               language: langCtrl.text.trim(),
//               proficiency: proficiency.value,
//             ));
//             Get.back();
//           },
//           child: const Text('Add'),
//         ),
//       ],
//     ));
//   }
// }
//
// class _CareerTile extends StatelessWidget {
//   final CareerHistory career;
//   final VoidCallback onRemove;
//   const _CareerTile({required this.career, required this.onRemove});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 10),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: AppColors.surface,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: AppColors.divider),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(career.title,
//                     style: const TextStyle(
//                         fontWeight: FontWeight.w600, fontSize: 13)),
//                 Text(career.company,
//                     style: const TextStyle(
//                         fontSize: 12, color: AppColors.primary)),
//                 if (career.isCurrent)
//                   const Text('Current',
//                       style: TextStyle(
//                           fontSize: 11, color: AppColors.success)),
//               ],
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.close,
//                 color: AppColors.error, size: 18),
//             onPressed: onRemove,
//             padding: EdgeInsets.zero,
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recruit_iq/Model/all_models.dart';
import 'package:recruit_iq/controllers/auth_controller.dart';
import 'package:recruit_iq/controllers/profile_controller.dart';
import 'package:recruit_iq/utils/validators.dart';
import 'package:recruit_iq/widgets/skill_input_widget.dart';

import '../utils/app_theme.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = Get.find<AuthController>();
  final _ctrl = Get.find<ProfileController>();

  late final TextEditingController _nameCtrl;
  late final TextEditingController _headlineCtrl;
  late final TextEditingController _titleCtrl;
  late final TextEditingController _companyCtrl;
  late final TextEditingController _locationCtrl;
  late final TextEditingController _yearsExpCtrl;
  late final TextEditingController _domainCtrl;
  late final RxList<Skill> _skills;
  late final RxList<CareerHistory> _career;
  late final RxList<Education> _education;
  late final RxList<Certification> _certifications;
  late final RxList<Language> _languages;

  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    final p = _auth.candidateProfile.value;
    _nameCtrl = TextEditingController(text: p?.fullName ?? '');
    _headlineCtrl = TextEditingController(text: p?.headline ?? '');
    _titleCtrl = TextEditingController(text: p?.currentTitle ?? '');
    _companyCtrl = TextEditingController(text: p?.currentCompany ?? '');
    _locationCtrl = TextEditingController(text: p?.location ?? '');
    _yearsExpCtrl =
        TextEditingController(text: p?.yearsExp.toString() ?? '0');
    _domainCtrl =
        TextEditingController(text: p?.domain.join(', ') ?? '');
    _skills = RxList<Skill>(List.from(p?.skills ?? []));
    _career = RxList<CareerHistory>(List.from(p?.careerHistory ?? []));
    _education = RxList<Education>(List.from(p?.education ?? []));
    _certifications =
        RxList<Certification>(List.from(p?.certifications ?? []));
    _languages = RxList<Language>(List.from(p?.languages ?? []));
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _headlineCtrl.dispose();
    _titleCtrl.dispose();
    _companyCtrl.dispose();
    _locationCtrl.dispose();
    _yearsExpCtrl.dispose();
    _domainCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final payload = <String, dynamic>{
      'full_name': _nameCtrl.text.trim(),
      'headline': _headlineCtrl.text.trim(),
      'current_title': _titleCtrl.text.trim(),
      'current_company': _companyCtrl.text.trim(),
      'location': _locationCtrl.text.trim(),
      'years_exp': double.tryParse(_yearsExpCtrl.text) ?? 0.0,
      'domain': _domainCtrl.text
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList(),
      'skills': _skills.map((s) => s.toJson()).toList(),
      'career_history': _career.map((c) => c.toJson()).toList(),
      'education': _education.map((e) => e.toJson()).toList(),
      'certifications': _certifications.map((c) => c.toJson()).toList(),
      'languages': _languages.map((l) => l.toJson()).toList(),
    };
    _ctrl.updateProfile(payload);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: Form(
        key: _formKey,
        child: Stepper(
          currentStep: _currentStep,
          onStepTapped: (i) => setState(() => _currentStep = i),
          controlsBuilder: (context, details) => Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              children: [
                if (details.stepIndex < 3)
                  ElevatedButton(
                    onPressed: details.onStepContinue,
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(100, 44)),
                    child: const Text('Next'),
                  ),
                if (details.stepIndex == 3)
                  Obx(() => ElevatedButton(
                    onPressed:
                    _ctrl.isUpdating.value ? null : _submit,
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(120, 44)),
                    child: _ctrl.isUpdating.value
                        ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2))
                        : const Text('Save Profile'),
                  )),
                const SizedBox(width: 12),
                if (details.stepIndex > 0)
                  OutlinedButton(
                    onPressed: details.onStepCancel,
                    style: OutlinedButton.styleFrom(
                        minimumSize: const Size(80, 44)),
                    child: const Text('Back'),
                  ),
              ],
            ),
          ),
          onStepContinue: () {
            if (_currentStep < 3) {
              setState(() => _currentStep++);
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() => _currentStep--);
            }
          },
          steps: [
            Step(
              title: const Text('Basic Info'),
              isActive: _currentStep >= 0,
              state: _currentStep > 0
                  ? StepState.complete
                  : StepState.indexed,
              content: _buildBasicInfo(),
            ),
            Step(
              title: const Text('Skills & Domain'),
              isActive: _currentStep >= 1,
              state: _currentStep > 1
                  ? StepState.complete
                  : StepState.indexed,
              content: _buildSkillsSection(),
            ),
            Step(
              title: const Text('Career History'),
              isActive: _currentStep >= 2,
              state: _currentStep > 2
                  ? StepState.complete
                  : StepState.indexed,
              content: _buildCareerSection(),
            ),
            Step(
              title: const Text('Education & More'),
              isActive: _currentStep >= 3,
              state: StepState.indexed,
              content: _buildEducationSection(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfo() {
    return Column(
      children: [
        TextFormField(
          controller: _nameCtrl,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: Validators.name,
          decoration: const InputDecoration(labelText: 'Full Name'),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _headlineCtrl,
          decoration: const InputDecoration(
              labelText: 'Headline',
              hintText: 'ML Engineer at Google'),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _titleCtrl,
                decoration:
                const InputDecoration(labelText: 'Current Title'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: _yearsExpCtrl,
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: Validators.positiveNumber,
                decoration:
                const InputDecoration(labelText: 'Years Exp.'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _companyCtrl,
          decoration:
          const InputDecoration(labelText: 'Current Company'),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _locationCtrl,
          decoration: const InputDecoration(labelText: 'Location'),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _domainCtrl,
          decoration: const InputDecoration(
            labelText: 'Domain (comma-separated)',
            hintText: 'ml, backend, cloud',
          ),
        ),
      ],
    );
  }

  Widget _buildSkillsSection() {
    return Obx(() {
      // Force Obx subscription tracking by explicitly reading from the observable list
      final _ = _skills.length;
      return SkillInputWidget(
        skills: _skills,
        onAdd: (s) => _skills.add(s),
        onRemove: (i) => _skills.removeAt(i),
      );
    });
  }

  Widget _buildCareerSection() {
    return Obx(() => Column(
      children: [
        ..._career.asMap().entries.map((entry) {
          final i = entry.key;
          final c = entry.value;
          return _CareerTile(
            career: c,
            onRemove: () => _career.removeAt(i),
          );
        }),
        OutlinedButton.icon(
          onPressed: () => _showAddCareerDialog(),
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Add Position'),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 44),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    ));
  }

  Widget _buildEducationSection() {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Education',
            style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        ..._education.asMap().entries.map((entry) {
          final i = entry.key;
          final e = entry.value;
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.school_outlined,
                color: AppColors.primary),
            title: Text(e.institution),
            subtitle: Text('${e.degree} • ${e.fieldOfStudy}'),
            trailing: IconButton(
              icon: const Icon(Icons.close,
                  color: AppColors.error, size: 18),
              onPressed: () => _education.removeAt(i),
            ),
          );
        }),
        OutlinedButton.icon(
          onPressed: _showAddEducationDialog,
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Add Education'),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 44),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(height: 20),
        const Text('Certifications',
            style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        ..._certifications.asMap().entries.map((entry) {
          final i = entry.key;
          final c = entry.value;
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.verified_outlined,
                color: AppColors.success),
            title: Text(c.name),
            subtitle: c.issuer != null ? Text(c.issuer!) : null,
            trailing: IconButton(
              icon: const Icon(Icons.close,
                  color: AppColors.error, size: 18),
              onPressed: () => _certifications.removeAt(i),
            ),
          );
        }),
        OutlinedButton.icon(
          onPressed: _showAddCertDialog,
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Add Certification'),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 44),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(height: 20),
        const Text('Languages',
            style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        ..._languages.asMap().entries.map((entry) {
          final i = entry.key;
          final l = entry.value;
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.language_outlined,
                color: AppColors.secondary),
            title: Text(l.language),
            subtitle: Text(l.proficiency),
            trailing: IconButton(
              icon: const Icon(Icons.close,
                  color: AppColors.error, size: 18),
              onPressed: () => _languages.removeAt(i),
            ),
          );
        }),
        OutlinedButton.icon(
          onPressed: _showAddLanguageDialog,
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Add Language'),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 44),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    ));
  }

  // ── Dialogs ───────────────────────────────────────────────────────────────

  void _showAddCareerDialog() {
    final companyCtrl = TextEditingController();
    final titleCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final isCurrent = false.obs;
    final industryCtrl = TextEditingController();

    Get.dialog(AlertDialog(
      title: const Text('Add Position'),
      content: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(
              controller: companyCtrl,
              decoration: const InputDecoration(labelText: 'Company')),
          const SizedBox(height: 10),
          TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(labelText: 'Title')),
          const SizedBox(height: 10),
          TextField(
              controller: industryCtrl,
              decoration: const InputDecoration(labelText: 'Industry')),
          const SizedBox(height: 10),
          TextField(
              controller: descCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                  labelText: 'Description (optional)')),
          const SizedBox(height: 10),
          Obx(() => SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Currently working here',
                style: TextStyle(fontSize: 14)),
            value: isCurrent.value,
            onChanged: (v) => isCurrent.value = v,
          )),
        ]),
      ),
      actions: [
        TextButton(onPressed: Get.back, child: const Text('Cancel')),
        ElevatedButton(
          style: ElevatedButton.styleFrom(minimumSize: Size.zero),
          onPressed: () {
            if (companyCtrl.text.isEmpty || titleCtrl.text.isEmpty) return;
            _career.add(CareerHistory(
              company: companyCtrl.text.trim(),
              title: titleCtrl.text.trim(),
              isCurrent: isCurrent.value,
              industry: industryCtrl.text.trim().isEmpty
                  ? null
                  : industryCtrl.text.trim(),
              description: descCtrl.text.trim().isEmpty
                  ? null
                  : descCtrl.text.trim(),
            ));
            Get.back();
          },
          child: const Text('Add'),
        ),
      ],
    ));
  }

  void _showAddEducationDialog() {
    final instCtrl = TextEditingController();
    final degreeCtrl = TextEditingController();
    final fieldCtrl = TextEditingController();
    final startYearCtrl = TextEditingController();
    final endYearCtrl = TextEditingController();

    Get.dialog(AlertDialog(
      title: const Text('Add Education'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(
            controller: instCtrl,
            decoration:
            const InputDecoration(labelText: 'Institution')),
        const SizedBox(height: 10),
        TextField(
            controller: degreeCtrl,
            decoration: const InputDecoration(labelText: 'Degree')),
        const SizedBox(height: 10),
        TextField(
            controller: fieldCtrl,
            decoration:
            const InputDecoration(labelText: 'Field of Study')),
        const SizedBox(height: 10),
        Row(children: [
          Expanded(
            child: TextField(
                controller: startYearCtrl,
                keyboardType: TextInputType.number,
                decoration:
                const InputDecoration(labelText: 'Start Year')),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
                controller: endYearCtrl,
                keyboardType: TextInputType.number,
                decoration:
                const InputDecoration(labelText: 'End Year')),
          ),
        ]),
      ]),
      actions: [
        TextButton(onPressed: Get.back, child: const Text('Cancel')),
        ElevatedButton(
          style: ElevatedButton.styleFrom(minimumSize: Size.zero),
          onPressed: () {
            if (instCtrl.text.isEmpty) return;
            _education.add(Education(
              institution: instCtrl.text.trim(),
              degree: degreeCtrl.text.trim(),
              fieldOfStudy: fieldCtrl.text.trim(),
              startYear: int.tryParse(startYearCtrl.text),
              endYear: int.tryParse(endYearCtrl.text),
            ));
            Get.back();
          },
          child: const Text('Add'),
        ),
      ],
    ));
  }

  void _showAddCertDialog() {
    final nameCtrl = TextEditingController();
    final issuerCtrl = TextEditingController();
    final yearCtrl = TextEditingController();

    Get.dialog(AlertDialog(
      title: const Text('Add Certification'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(
            controller: nameCtrl,
            decoration: const InputDecoration(labelText: 'Name')),
        const SizedBox(height: 10),
        TextField(
            controller: issuerCtrl,
            decoration: const InputDecoration(labelText: 'Issuer')),
        const SizedBox(height: 10),
        TextField(
            controller: yearCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Year')),
      ]),
      actions: [
        TextButton(onPressed: Get.back, child: const Text('Cancel')),
        ElevatedButton(
          style: ElevatedButton.styleFrom(minimumSize: Size.zero),
          onPressed: () {
            if (nameCtrl.text.isEmpty) return;
            _certifications.add(Certification(
              name: nameCtrl.text.trim(),
              issuer: issuerCtrl.text.trim().isEmpty
                  ? null
                  : issuerCtrl.text.trim(),
              year: int.tryParse(yearCtrl.text),
            ));
            Get.back();
          },
          child: const Text('Add'),
        ),
      ],
    ));
  }

  void _showAddLanguageDialog() {
    final langCtrl = TextEditingController();
    final proficiency = 'professional'.obs;

    Get.dialog(AlertDialog(
      title: const Text('Add Language'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(
            controller: langCtrl,
            decoration: const InputDecoration(labelText: 'Language')),
        const SizedBox(height: 10),
        Obx(() => DropdownButtonFormField<String>(
          value: proficiency.value,
          decoration:
          const InputDecoration(labelText: 'Proficiency'),
          items: const [
            DropdownMenuItem(
                value: 'native', child: Text('Native')),
            DropdownMenuItem(
                value: 'professional', child: Text('Professional')),
            DropdownMenuItem(
                value: 'conversational',
                child: Text('Conversational')),
            DropdownMenuItem(
                value: 'basic', child: Text('Basic')),
          ],
          onChanged: (v) => proficiency.value = v!,
        )),
      ]),
      actions: [
        TextButton(onPressed: Get.back, child: const Text('Cancel')),
        ElevatedButton(
          style: ElevatedButton.styleFrom(minimumSize: Size.zero),
          onPressed: () {
            if (langCtrl.text.isEmpty) return;
            _languages.add(Language(
              language: langCtrl.text.trim(),
              proficiency: proficiency.value,
            ));
            Get.back();
          },
          child: const Text('Add'),
        ),
      ],
    ));
  }
}

class _CareerTile extends StatelessWidget {
  final CareerHistory career;
  final VoidCallback onRemove;
  const _CareerTile({required this.career, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(career.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 13)),
                Text(career.company,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.primary)),
                if (career.isCurrent)
                  const Text('Current',
                      style: TextStyle(
                          fontSize: 11, color: AppColors.success)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close,
                color: AppColors.error, size: 18),
            onPressed: onRemove,
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}