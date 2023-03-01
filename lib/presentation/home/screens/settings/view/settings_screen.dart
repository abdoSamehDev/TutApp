import 'package:advanced_flutter_arabic/app/app_prefs.dart';
import 'package:advanced_flutter_arabic/app/di.dart';
import 'package:advanced_flutter_arabic/data/data_source/local_data_source.dart';
import 'package:advanced_flutter_arabic/presentation/resources/assets_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/color_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/routes_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/strings_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AppPreferences _preferences = instance<AppPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: const EdgeInsets.all(AppPadding.p8),
        children: [
          ListTile(
            leading: SvgPicture.asset(ImageAssets.changeLang),
            title: Text(
              AppStrings.changeLang.tr(),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: ColorManager.grey),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: ColorManager.primary,
            ),
            onTap: () {
              _changeLang();
            },
          ),
          const Divider(),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.contactUs),
            title: Text(
              AppStrings.contactUs.tr(),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: ColorManager.grey),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: ColorManager.primary,
            ),
            onTap: () {
              _contactUs();
            },
          ),
          const Divider(),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.inviteFriends),
            title: Text(
              AppStrings.invite.tr(),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: ColorManager.grey),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: ColorManager.primary,
            ),
            onTap: () {
              _inviteFriends();
            },
          ),
          const Divider(),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.logout),
            title: Text(
              AppStrings.logout.tr(),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: ColorManager.grey),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: ColorManager.primary,
            ),
            onTap: () {
              _logout();
            },
          ),
        ],
      ),
    );
  }

  _changeLang() {
    _preferences.changeAppLanguage();
    Phoenix.rebirth(context);
  }

  _inviteFriends() {}

  _contactUs() {}

  _logout() {
    // app prefs
    _preferences.setUserLoggOut();

    //clear cache of local data source
    _localDataSource.clearCache();

    //navigate to login
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }
}
