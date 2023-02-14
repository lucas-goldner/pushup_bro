import 'package:flutter/cupertino.dart';

class PBTextInput extends StatefulWidget {
  const PBTextInput({super.key});

  @override
  State<PBTextInput> createState() => _PBTextInputState();
}

class _PBTextInputState extends State<PBTextInput> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.25,
      child: const CupertinoTextField(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: CupertinoColors.white,
        ),
      ),
    );
  }
}
