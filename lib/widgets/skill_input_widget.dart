import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recruit_iq/Model/all_models.dart';
import 'package:recruit_iq/utils/app_constant.dart';
import '../utils/app_theme.dart';

class SkillInputWidget extends StatelessWidget {
  final RxList<Skill> skills;
  final void Function(Skill) onAdd;
  final void Function(int) onRemove;

  const SkillInputWidget({
    super.key,
    required this.skills,
    required this.onAdd,
    required this.onRemove,
  });

  void _showAddSkillDialog(BuildContext context) {
    final nameCtrl = TextEditingController();
    final proficiency = AppConstants.proficiencyLevels.first.obs;

    Get.dialog(
      AlertDialog(
        title: const Text('Add Skill'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Skill Name'),
            ),
            const SizedBox(height: 16),
            Obx(
              () => DropdownButtonFormField<String>(
                value: proficiency.value,
                decoration: const InputDecoration(labelText: 'Proficiency'),
                items: AppConstants.proficiencyLevels
                    .map(
                      (p) => DropdownMenuItem(
                        value: p,
                        child: Text(p[0].toUpperCase() + p.substring(1)),
                      ),
                    )
                    .toList(),
                onChanged: (val) => proficiency.value = val!,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: Size.zero),
            onPressed: () {
              if (nameCtrl.text.trim().isEmpty) return;
              onAdd(
                Skill(
                  name: nameCtrl.text.trim(),
                  proficiency: proficiency.value,
                ),
              );
              Get.back();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Column(
            children: skills
                .asMap()
                .entries
                .map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entry.value.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                Text(
                                  entry.value.proficiency,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.close,
                              size: 18,
                              color: AppColors.textSecondary,
                            ),
                            onPressed: () => onRemove(entry.key),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        OutlinedButton.icon(
          onPressed: () => _showAddSkillDialog(context),
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Add Skill'),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 44),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            side: const BorderSide(color: AppColors.divider),
          ),
        ),
      ],
    );
  }
}
