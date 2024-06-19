import 'package:flutter/cupertino.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';

BoxShadow getFinalBoxShadow(BuildContext context) => BoxShadow(
      color: context.colorScheme.shadow.withOpacity(0.2),
      blurRadius: 10,
      offset: const Offset(1, 10),
    );
