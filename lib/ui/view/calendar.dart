import 'package:flutter/cupertino.dart';

class Calendar extends StatelessWidget {
  const Calendar({super.key});
  static const routeName = '/calendar';

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Column(
          children: const [Text('Calendar')],
        ),
      );
}
