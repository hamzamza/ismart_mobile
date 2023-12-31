import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/common/routes.dart';
import '/common/theme.dart';
import '/common/utils/api_domain_sneak_spot.dart';
import '/common/utils/logger.dart';
import '/features/account_feature/services/signup_service.dart';
import '/features/wallet_feature/repository/wallet_repository.dart';
import '/network/api_client.dart';
import 'features/account_feature/repository/account_repository.dart';
import 'features/stations_feature/bloc/stations_bloc.dart';
import 'features/stations_feature/bloc/stations_event.dart';
import 'features/stations_feature/repository/station_repository.dart';
import 'features/stations_feature/services/location_service.dart';
import 'features/stations_feature/services/stations_api_service.dart';
import 'features/wallet_feature/services/wallet_serivce.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLogger();
  runApp(const RepositoryHolder(
    child: StationsApp(),
  ));
}

class RepositoryHolder extends StatelessWidget {
  final Widget child;

  const RepositoryHolder({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => StationRepositoryImpl(
            stationApiService: StationsApiServiceImpl(
              ApiClientImpl(apiDomain: ApiDomainSneakSpot.apiDomain),
            ),
            locationService: LocationServiceImpl(),
          ),
        ),
        RepositoryProvider(
          create: (context) => WalletRepositoryImpl(
            walletService: WalletServiceImpl(
              ApiClientImpl(apiDomain: ApiDomainSneakSpot.apiDomain),
            ),
          ),
        ),
        RepositoryProvider(
          create: (context) => AccountRepositoryImpl(
            SignInServiceImpl(FirebaseAuth.instance),
          ),
        ),
      ],
      child: Builder(builder: (context) => child),
    );
  }
}

class StationsApp extends StatelessWidget {
  const StationsApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          StationsBloc(RepositoryProvider.of<StationRepositoryImpl>(context))
            ..add(FetchStationsEvent()),
      child: MaterialApp(
        title: 'Stations App',
        initialRoute: homeScreenPath,
        routes: routes,
        theme: lightTheme,
      ),
    );
  }
}
