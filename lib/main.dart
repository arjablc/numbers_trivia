import 'core/resources/theme/app_theme.dart';
import 'features/number_trivia/presentation/bloc/numbertrivia_bloc.dart';
import 'features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'core/service/service_locator.dart' as injector;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  injector.init();
  final appDocumentPath = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentPath.path);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector.sl<NumberTriviaBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        darkTheme: AppTheme.darkTheme,
        theme: AppTheme.lightTheme,
        home: const NumberTriviaPage(),
      ),
    );
  }
}
