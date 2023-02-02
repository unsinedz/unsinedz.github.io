import 'package:flutter/material.dart';

class ProfitFilter extends StatefulWidget {
  const ProfitFilter({
    super.key,
    required this.onChanged,
  });

  final ValueChanged<int> onChanged;

  @override
  State<ProfitFilter> createState() => _ProfitFilterState();
}

class _ProfitFilterState extends State<ProfitFilter> {
  static const options = <int>[5, 10, 20, 25, 50, 100];

  int? _value = options[3];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Minimum profit'),
        DropdownButton(
          hint: const Text('%'),
          value: _value,
          items: options
              .map((value) => DropdownMenuItem(
                    value: value,
                    child: Text('$value%'),
                  ))
              .toList(),
          onChanged: (value) => setState(() {
            _value = value;
            if (_value != null) {
              widget.onChanged(value!);
            }
          }),
        ),
      ],
    );
  }
}
