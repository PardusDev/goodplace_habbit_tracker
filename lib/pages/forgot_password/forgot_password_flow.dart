import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'forgot_password_page_1.dart';
import 'forgot_password_page_2.dart';
import 'forgot_password_view_model.dart';

class ForgotPasswordFlow extends StatelessWidget {
  const ForgotPasswordFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ForgotPasswordViewModel(context),
      child: Consumer<ForgotPasswordViewModel>(
        builder: (context, viewModel, child) {
          return Navigator(
            key: viewModel.navigatorKey,
            initialRoute: '/',
            onGenerateRoute: (RouteSettings settings) {
              WidgetBuilder builder;
              switch (settings.name) {
                case '/':
                  builder = (BuildContext _) => ForgotPasswordPage1();
                  break;
                case '/forgotPasswordPage2':
                  builder = (BuildContext _) => ForgotPasswordPage2();
                  break;
                default:
                  throw Exception('Invalid route: ${settings.name}');
              }
              return MaterialPageRoute(builder: builder, settings: settings);
            },
          );
        }
      ),
    );
  }
}
