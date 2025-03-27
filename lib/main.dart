import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(
          title: 'Reown AppKit Task'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() =>
      _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final ReownAppKitModal _appKitModal;

  @override
  void initState() {
    super.initState();

    _appKitModal = ReownAppKitModal(
      context: context,
      projectId:
          'f3d7c5a3be3446568bcc6bcc1fcc6389',
      metadata: const PairingMetadata(
        name: "Example App",
        description: "Example Description",
        url: 'https://example.com/',
        icons: ['https://example.com/logo.png'],
        redirect: Redirect(
          native: 'exampleapp',
          universal:
              'https://reown.com/exampleapp',
          linkMode: true,
        ),
      ),
      logLevel: LogLevel.info,
      enableAnalytics: true,
      featuresConfig: FeaturesConfig(
        email: true,
        socials: [
          AppKitSocialOption.Google,
          AppKitSocialOption.Discord,
          AppKitSocialOption.Facebook,
          AppKitSocialOption.GitHub,
          AppKitSocialOption.X,
          AppKitSocialOption.Apple,
          AppKitSocialOption.Twitch,
          AppKitSocialOption.Farcaster,

        ],
        showMainWallets: true,
      ),
    );
    _appKitModal
        .init()
        .then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final double cardWidth = MediaQuery.of(context).size.width * 0.9;
    final double cardHeight = MediaQuery.of(context).size.height * 0.4;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade700,
      body: Center(
        child: Card(
          elevation: 8,
          shadowColor: Colors.blueAccent.withOpacity(0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: cardWidth,
            height: cardHeight,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppKitModalNetworkSelectButton(
                  appKit: _appKitModal,
                  context: context,
                ),
                const SizedBox(height: 16),
                AppKitModalConnectButton(
                  appKit: _appKitModal,
                  context: context,
                ),
                const SizedBox(height: 16),
                if (_appKitModal.isConnected) ...[
                  _buildCardItem(
                    context,
                    AppKitModalAccountButton(
                      appKitModal: _appKitModal,
                      context: context,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildCardItem(
                    context,
                    AppKitModalBalanceButton(
                      appKitModal: _appKitModal,
                      onTap: _appKitModal.openModalView,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildCardItem(
                    context,
                    AppKitModalAddressButton(
                      appKitModal: _appKitModal,
                      onTap: _appKitModal.openModalView,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardItem(BuildContext context, Widget child) {
    return Container(
      decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        child: child,
      ),
    );
  }
}
