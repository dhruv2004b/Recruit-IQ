// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:recruit_iq/controllers/jobs_controller.dart';
// import 'package:recruit_iq/controllers/search_controller.dart' as sc;
// import 'package:recruit_iq/utils/validators.dart';
// import 'package:recruit_iq/widgets/common_widgets.dart';
//
// import '../utils/app_theme.dart';
//
// class SearchTab extends StatelessWidget {
//   const SearchTab({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final searchCtrl = Get.find<sc.SearchController>();
//     final jobsCtrl = Get.find<JobsController>();
//     final locationCtrl = TextEditingController();
//     final expCtrl = TextEditingController();
//
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header
//           Container(
//             padding: const EdgeInsets.all(18),
//             decoration: BoxDecoration(
//               gradient: const LinearGradient(
//                 colors: [AppColors.primary, Color(0xFF6366F1)],
//               ),
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: const Row(
//               children: [
//                 Icon(Icons.auto_awesome, color: Colors.white, size: 28),
//                 SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('AI Candidate Search',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 18,
//                               fontWeight: FontWeight.w700)),
//                       Text('5-step matching pipeline',
//                           style: TextStyle(
//                               color: Colors.white70, fontSize: 12)),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 24),
//
//           // Job selector
//           const SectionHeader(title: 'Select Job'),
//           Obx(() {
//             if (jobsCtrl.jobs.isEmpty) {
//               return const InfoChip(
//                 label: 'No jobs yet — create one first',
//                 color: Color(0xFFFEF9C3),
//                 textColor: AppColors.warning,
//               );
//             }
//             return DropdownButtonFormField<String>(
//               value: searchCtrl.selectedJobId.value.isEmpty
//                   ? null
//                   : searchCtrl.selectedJobId.value,
//               decoration: const InputDecoration(
//                 hintText: 'Choose a job to search candidates for',
//                 prefixIcon: Icon(Icons.work_outline_rounded),
//               ),
//               items: jobsCtrl.jobs
//                   .map((j) => DropdownMenuItem(value: j.id, child: Text(j.title)))
//                   .toList(),
//               onChanged: (val) => searchCtrl.selectedJobId.value = val ?? '',
//             );
//           }),
//           const SizedBox(height: 24),
//
//           // Filters
//           const SectionHeader(title: 'Filters (Optional)'),
//           Row(
//             children: [
//               Expanded(
//                 child: TextFormField(
//                   controller: expCtrl,
//                   keyboardType: TextInputType.number,
//                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                   validator: Validators.positiveNumber,
//                   decoration: const InputDecoration(
//                     labelText: 'Min. Years Exp.',
//                     prefixIcon: Icon(Icons.trending_up_rounded),
//                   ),
//                   onChanged: (v) {
//                     searchCtrl.minYearsExp.value =
//                     v.isEmpty ? null : int.tryParse(v);
//                   },
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: TextFormField(
//                   controller: locationCtrl,
//                   decoration: const InputDecoration(
//                     labelText: 'Location',
//                     prefixIcon: Icon(Icons.location_on_outlined),
//                   ),
//                   onChanged: (v) => searchCtrl.locationFilter.value = v,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 32),
//
//           // Search button
//           Obx(() => ElevatedButton.icon(
//             onPressed: searchCtrl.isSearching.value
//                 ? null
//                 : searchCtrl.runSearch,
//             icon: searchCtrl.isSearching.value
//                 ? const SizedBox(
//                 width: 18,
//                 height: 18,
//                 child: CircularProgressIndicator(
//                     color: Colors.white, strokeWidth: 2))
//                 : const Icon(Icons.auto_awesome),
//             label: Text(searchCtrl.isSearching.value
//                 ? 'Running AI Pipeline...'
//                 : 'Run AI Search'),
//           )),
//
//           const SizedBox(height: 20),
//
//           // Pipeline steps info
//           _PipelineStepsCard(),
//         ],
//       ),
//     );
//   }
// }
//
// class _PipelineStepsCard extends StatelessWidget {
//   final steps = const [
//     ('Parse JD', 'AI extracts skills, seniority & signals', Icons.text_fields_rounded),
//     ('Embed', 'Convert profiles to vector embeddings', Icons.hub_rounded),
//     ('Vector Search', 'Find top-K semantically similar candidates', Icons.search_rounded),
//     ('Score', 'Multi-factor candidate scoring', Icons.analytics_rounded),
//     ('Re-Rank', 'Final ranked shortlist with explanations', Icons.format_list_numbered_rounded),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: AppColors.divider),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text('Search Pipeline',
//               style: TextStyle(
//                   fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
//           const SizedBox(height: 12),
//           ...steps.asMap().entries.map((entry) {
//             final i = entry.key;
//             final step = entry.value;
//             return Padding(
//               padding: const EdgeInsets.only(bottom: 10),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 28,
//                     height: 28,
//                     decoration: BoxDecoration(
//                       color: AppColors.primaryLight,
//                       shape: BoxShape.circle,
//                     ),
//                     child: Center(
//                       child: Text('${i + 1}',
//                           style: const TextStyle(
//                               color: AppColors.primary,
//                               fontWeight: FontWeight.w700,
//                               fontSize: 12)),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Icon(step.$3, size: 16, color: AppColors.primary),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(step.$1,
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 13,
//                                 color: AppColors.textPrimary)),
//                         Text(step.$2,
//                             style: const TextStyle(
//                                 fontSize: 11,
//                                 color: AppColors.textSecondary)),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recruit_iq/controllers/jobs_controller.dart';
import 'package:recruit_iq/controllers/search_controller.dart' as sc;
import 'package:recruit_iq/utils/validators.dart';
import 'package:recruit_iq/widgets/common_widgets.dart';

import '../utils/app_theme.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    final searchCtrl = Get.find<sc.SearchController>();
    final jobsCtrl = Get.find<JobsController>();
    final locationCtrl = TextEditingController();
    final expCtrl = TextEditingController();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, Color(0xFF6366F1)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                Icon(Icons.auto_awesome, color: Colors.white, size: 28),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('AI Candidate Search',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700)),
                      Text('5-step matching pipeline',
                          style: TextStyle(
                              color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Job selector
          const SectionHeader(title: 'Select Job'),
          Obx(() {
            if (jobsCtrl.jobs.isEmpty) {
              return const InfoChip(
                label: 'No jobs yet — create one first',
                color: Color(0xFFFEF9C3),
                textColor: AppColors.warning,
              );
            }
            return DropdownButtonFormField<String>(
              isExpanded: true, // Forces dropdown text container layout constraint limits
              value: searchCtrl.selectedJobId.value.isEmpty
                  ? null
                  : searchCtrl.selectedJobId.value,
              decoration: const InputDecoration(
                hintText: 'Choose a job to search candidates for',
                prefixIcon: Icon(Icons.work_outline_rounded),
              ),
              items: jobsCtrl.jobs
                  .map((j) => DropdownMenuItem(
                value: j.id,
                child: Text(
                  j.title,
                  overflow: TextOverflow.ellipsis, // Safely handles overflow text bounds
                ),
              ))
                  .toList(),
              onChanged: (val) => searchCtrl.selectedJobId.value = val ?? '',
            );
          }),
          const SizedBox(height: 24),

          // Filters
          const SectionHeader(title: 'Filters (Optional)'),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: expCtrl,
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: Validators.positiveNumber,
                  decoration: const InputDecoration(
                    labelText: 'Min. Years Exp.',
                    prefixIcon: Icon(Icons.trending_up_rounded),
                  ),
                  onChanged: (v) {
                    searchCtrl.minYearsExp.value =
                    v.isEmpty ? null : int.tryParse(v);
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: locationCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Location',
                    prefixIcon: Icon(Icons.location_on_outlined),
                  ),
                  onChanged: (v) => searchCtrl.locationFilter.value = v,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Search button
          Obx(() => ElevatedButton.icon(
            onPressed: searchCtrl.isSearching.value
                ? null
                : searchCtrl.runSearch,
            icon: searchCtrl.isSearching.value
                ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2))
                : const Icon(Icons.auto_awesome),
            label: Text(searchCtrl.isSearching.value
                ? 'Running AI Pipeline...'
                : 'Run AI Search'),
          )),

          const SizedBox(height: 20),

          // Pipeline steps info
          _PipelineStepsCard(),
        ],
      ),
    );
  }
}

class _PipelineStepsCard extends StatelessWidget {
  final steps = const [
    ('Parse JD', 'AI extracts skills, seniority & signals', Icons.text_fields_rounded),
    ('Embed', 'Convert profiles to vector embeddings', Icons.hub_rounded),
    ('Vector Search', 'Find top-K semantically similar candidates', Icons.search_rounded),
    ('Score', 'Multi-factor candidate scoring', Icons.analytics_rounded),
    ('Re-Rank', 'Final ranked shortlist with explanations', Icons.format_list_numbered_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Search Pipeline',
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 12),
          ...steps.asMap().entries.map((entry) {
            final i = entry.key;
            final step = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text('${i + 1}',
                          style: const TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                              fontSize: 12)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Icon(step.$3, size: 16, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(step.$1,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: AppColors.textPrimary)),
                        Text(step.$2,
                            style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}