import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/core/cubit/shared_preferences_cubit.dart';
import 'package:pushup_bro/core/cubit/shared_preferences_state.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';
import 'package:pushup_bro/core/utils/get_localized_language_name.dart';
import 'package:pushup_bro/core/widgets/pb_button.dart';
import 'package:pushup_bro/generated/l10n.dart';

class LanguageSetting extends StatefulWidget {
  const LanguageSetting({super.key});
  static const routeName = '/language';

  @override
  State<LanguageSetting> createState() => _LanguageSettingState();
}

class _LanguageSettingState extends State<LanguageSetting> {
  List<Locale> supportedLanguages = S.delegate.supportedLocales;
  String _selectedLocale = '';

  @override
  void initState() {
    super.initState();
    _getLanguage();
  }

  Future<void> _getLanguage() async {
    final lang =
        await BlocProvider.of<SharedPreferencesCubit>(context).getLanguage();
    setState(() => _selectedLocale = lang);
  }

  Future<void> _updateLanguage(Locale lang) async {
    final sharedPrefCubit = BlocProvider.of<SharedPreferencesCubit>(context);
    await sharedPrefCubit.setLanguage(lang);
    setState(() => _selectedLocale = lang.languageCode);
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SharedPreferencesCubit, SharedPreferencesState>(
        builder: (context, state) => CupertinoPageScaffold(
          backgroundColor: context.colorScheme.background,
          child: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    SingleChildScrollView(
                      child: Text(
                        S.of(context).switchLanguage,
                        style: context.textTheme.titleLarge,
                      ),
                    ),
                    Column(
                      children: [
                        for (var i = 0;
                            i <= supportedLanguages.length - 1;
                            i++) ...{
                          GestureDetector(
                            onTap: () => _updateLanguage(supportedLanguages[i]),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                      16,
                                    ),
                                    child: Text(
                                      LanguageLocal()
                                          .getDisplayLanguage(
                                            supportedLanguages[i].languageCode,
                                          )
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: context.textTheme.bodyMedium,
                                    ),
                                  ),
                                ),
                                if (_selectedLocale ==
                                    supportedLanguages[i].languageCode)
                                  const Icon(CarbonIcons.checkmark),
                                const SizedBox(
                                  width: 16,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: context.colorScheme.shadow.withOpacity(0.05),
                          ),
                        },
                      ],
                    ),
                    const Spacer(),
                    PBButton(
                      S.of(context).goBack,
                      callback: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
