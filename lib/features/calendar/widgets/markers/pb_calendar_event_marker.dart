import 'package:flutter/cupertino.dart';
import 'package:pushup_bro/features/calendar/widgets/circular_dotted_border.dart';

class PBCalendarEventMarker extends StatelessWidget {
  const PBCalendarEventMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 48,
        height: 48,
        child: CustomPaint(
          painter: CirularDottedBorder(dots: 10),
        ),
      ),
    );
  }
}
