import 'package:fire_base_app/shared/entities/entities.dart';
import 'package:fire_base_app/shared/enums/enums.dart';
import 'package:fire_base_app/shared/style.dart';
import 'package:fire_base_app/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late Category _category;
  late DateTimeRange _dateTimeRange;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final filterEntity =
        ModalRoute.of(context)!.settings.arguments as FilterEntity;

    _category = filterEntity.category;
    _dateTimeRange = filterEntity.dateTimeRange;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapews'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton<Category>(
                alignment: Alignment.center,
                hint: Text('Category'),
                value: _category,
                onChanged: (value) => setState(() {
                  if (value == null) {
                    return;
                  }
                  _category = value;
                }),
                items: Category.values
                    .map(
                      (e) => DropdownMenuItem<Category>(
                        value: e,
                        child: Text(
                          e.getTitle(context),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () async {
                final now = DateTime.now();
                const dateTimeDelta = Duration(days: 365 * 5);

                final DateTimeRange? dateTimeRange = await showDateRangePicker(
                  context: context,
                  firstDate: now.subtract(dateTimeDelta),
                  lastDate: now.add(dateTimeDelta),
                );

                if (dateTimeRange == null) {
                  return;
                }
                setState(() {
                  _dateTimeRange = dateTimeRange;
                });
              },
              child: Container(
                margin: const EdgeInsets.all(8),
                child: Text(
                  '${DateFormat('dd.MM.yyyy').format(_dateTimeRange.start)} - ${DateFormat('dd.MM.yyyy').format(_dateTimeRange.end)}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: AppButton(
                title: 'Apply',
                onTap: () => Navigator.of(context).pop(
                  FilterEntity(
                    category: _category,
                    dateTimeRange: _dateTimeRange,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: AppButton(
                color: AppColors.redColor,
                title: 'Cancel',
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
