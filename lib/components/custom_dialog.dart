import 'package:app_settings/app_settings.dart';
import 'package:app_well_mate/components/info_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog(
      {super.key,
      required this.title,
      required this.subtitle,
      this.icon,
      required this.onPositive,
      this.onNegative,
      this.positiveText,
      this.negativeText});
  final String title;
  final String subtitle;
  final IconData? icon;
  final void Function() onPositive;
  final void Function()? onNegative;
  final String? positiveText;
  final String? negativeText;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ErrorInfo(
              title: title,
              subtitle: subtitle,
              icon: icon,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () async {
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                        onPositive();
                      },
                      child: Text(positiveText ?? "Có")),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                      onPressed: () {
                        if (onNegative != null) {
                          onNegative!();
                        }
                        Navigator.pop(context);
                      },
                      child: Text(negativeText ?? "Không")),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}