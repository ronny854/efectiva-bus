import 'dart:typed_data';
import 'package:activa_efectiva_bus/api/exceptions/network_exceptions.dart';
import 'package:activa_efectiva_bus/data/enums/device_action.dart';
import 'package:activa_efectiva_bus/data/enums/roles.dart';
import 'package:activa_efectiva_bus/data/model/response/partner_information_model.dart';
import 'package:activa_efectiva_bus/provider/auth_provider.dart';
import 'package:activa_efectiva_bus/provider/driver_provider.dart';
import 'package:activa_efectiva_bus/utill/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:provider/provider.dart';
import 'package:soundpool/soundpool.dart';
import 'package:activa_efectiva_bus/data/enums/connection_status.dart';
import 'package:activa_efectiva_bus/data/model/body/charge_request_model.dart';
import 'package:activa_efectiva_bus/provider/card_provider.dart';
import 'package:activa_efectiva_bus/provider/device_provider.dart';
import 'package:activa_efectiva_bus/provider/partner_provider.dart';
import 'package:activa_efectiva_bus/provider/route_provider.dart';
import 'package:activa_efectiva_bus/provider/travel_provider.dart';
import 'package:activa_efectiva_bus/view/screen/settings/settings_screen.dart';
import 'package:activa_efectiva_bus/localization/language_constrants.dart';
import 'package:activa_efectiva_bus/provider/localization_provider.dart';
import 'package:activa_efectiva_bus/provider/splash_provider.dart';
import 'package:activa_efectiva_bus/provider/theme_provider.dart';
import 'package:activa_efectiva_bus/view/screen/stats/stats_screen.dart';
import 'package:activa_efectiva_bus/view/screen/dashboard/widget/fancy_bottom_nav_bar.dart';
import 'package:activa_efectiva_bus/view/screen/home/home_screen.dart';
import 'package:activa_efectiva_bus/view/screen/bus_travel/bus_travel_screen.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreen createState() => new _DashBoardScreen();
}

class _DashBoardScreen extends State<DashBoardScreen> {
  //Bluetooth vars
  BluetoothConnection connection;
  bool isConnecting = true;
  bool get isConnected => connection != null && connection.isConnected;
  bool isDisconnecting = false;
  List<String> dataReader = [];
  String _dataReaderBuffer = '';

  final PageController _pageController = PageController();
  final GlobalKey<FancyBottomNavBarState> _bottomNavKey = GlobalKey();

  // SOUND
  Soundpool _soundpool;

  Future<int> _soundId;
  Future<int> _soundNoBalanceId;
  Future<int> _soundPrestamoId;

  @override
  void initState() {
    super.initState();
    _soundpool = Soundpool.fromOptions();
    _loadSounds();
    var address = Provider.of<DeviceProvider>(context, listen: false)
        .getSelectedMacAddress();
    var partnerID = Provider.of<PartnerProvider>(context, listen: false)
        .getSelectedPartnerID();
    Provider.of<PartnerProvider>(context, listen: false)
        .getPartnerInformation(partnerID)
        .then((value) {
      Provider.of<PartnerProvider>(context, listen: false)
          .setSelectedPartnerInformation();
      if (address == null || address.isEmpty) {
        Provider.of<DeviceProvider>(context, listen: false)
            .setConnectionStatus(DeviceStatus.DISCONNECTED);
        return;
      }

      BluetoothConnection.toAddress(address).then((_connection) {
        print('Connected to the device');
        Provider.of<DeviceProvider>(context, listen: false)
            .setConnectionStatus(DeviceStatus.CONNECTED);

        connection = _connection;
        setState(() {
          isConnecting = false;
          isDisconnecting = false;
        });

        connection.input.listen(_onDataReceived).onDone(() {
          if (isDisconnecting) {
            print('Disconnecting locally!');
          } else {
            print('Disconnected remotely!');
          }
          if (this.mounted) {
            print('QUE SE HACE AQUII!');

            setState(() {});
          }
        });
      }).catchError((error) {
        //Trying again
        print('Let\'s try again');

        BluetoothConnection.toAddress(address).then((_connection) {
          print('Connected to the device');
          Provider.of<DeviceProvider>(context, listen: false)
              .setConnectionStatus(DeviceStatus.CONNECTED);

          connection = _connection;
          setState(() {
            isConnecting = false;
            isDisconnecting = false;
          });

          connection.input.listen(_onDataReceived).onDone(() {
            if (isDisconnecting) {
              Provider.of<DeviceProvider>(context, listen: false)
                  .setConnectionStatus(DeviceStatus.UNAVAILABLE);

              print('Disconnecting locally!');
            } else {
              print('Disconnected remotely!');
            }
            if (this.mounted) {
              setState(() {});
            }
          });
        }).catchError((error) {
          print('Cannot connect, exception occured');
          print(error);
          Provider.of<DeviceProvider>(context, listen: false)
              .setConnectionStatus(DeviceStatus.DISCONNECTED);
        });
      });
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      print("grteeeeeeeeeeeeeeeerrer");

      isDisconnecting = true;
      connection.dispose();
      //connection = null;
    }
    _disposePool();
    //Hive.close();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _onDataReceived(Uint8List data) async {
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      setState(() {
        if (dataReader.length == 0) {
          dataReader.add(
            backspacesCounter > 0
                ? _dataReaderBuffer.substring(
                    0, _dataReaderBuffer.length - backspacesCounter)
                : _dataReaderBuffer + dataString.substring(0, index),
          );
          _dataReaderBuffer = dataString.substring(index);
        } else {
          dataReader[0] = backspacesCounter > 0
              ? _dataReaderBuffer.substring(
                  0, _dataReaderBuffer.length - backspacesCounter)
              : _dataReaderBuffer + dataString.substring(0, index);
          _dataReaderBuffer = dataString.substring(index);
        }
      });

      String codeReaded = dataReader[0].trim();
      var deviceAction =
          Provider.of<CardProvider>(context, listen: false).deviceAction;

      if (deviceAction == DeviceAction.CHARGE) {
        await executeCharge(codeReaded);
      } else if (deviceAction == DeviceAction.READ_ONLY) {
        await getCardByCode(codeReaded);
      } else {
        await getLastCharges(codeReaded);
      }
    } else {
      _dataReaderBuffer = (backspacesCounter > 0
          ? _dataReaderBuffer.substring(
              0, _dataReaderBuffer.length - backspacesCounter)
          : _dataReaderBuffer + dataString);
    }
  }

  void executeCharge(String code) async {
    Provider.of<TravelProvider>(context, listen: false)
        .setIsExecutingCharge(true);

    final travelInformation =
        Provider.of<PartnerProvider>(context, listen: false)
            .selectedPartnerInformation;
    final routeInformation =
        Provider.of<RouteProvider>(context, listen: false).selectedRoute;
    final driverInformation =
        Provider.of<DriverProvider>(context, listen: false).driverInformation;

    if (routeInformation == null || routeInformation.id == "") {
      Provider.of<TravelProvider>(context, listen: false)
          .showCardInformation(true);
      Provider.of<CardProvider>(context, listen: false)
          .setValidationErrorReader('Seleccione la ruta de transporte.');
      Provider.of<CardProvider>(context, listen: false).setSuccessReader(false);
      Provider.of<TravelProvider>(context, listen: false)
          .setIsExecutingCharge(false);
      await _playSoundNoBalance();
      return;
    }

    if (driverInformation == null || driverInformation.driverId == "") {
      Provider.of<TravelProvider>(context, listen: false)
          .showCardInformation(true);
      Provider.of<CardProvider>(context, listen: false)
          .setValidationErrorReader('Asigne un conductor al recorrido.');
      Provider.of<CardProvider>(context, listen: false).setSuccessReader(false);
      Provider.of<TravelProvider>(context, listen: false)
          .setIsExecutingCharge(false);
      await _playSoundNoBalance();
      return;
    }

    ChargeRequestModel payload = new ChargeRequestModel(
      code: code,
      operatorId: travelInformation.bus.operator.id,
      busId: travelInformation.bus.id,
      routeId: routeInformation.id,
    );

    Provider.of<CardProvider>(context, listen: false)
        .chargeCard(payload)
        .then((response) async {
      Provider.of<CardProvider>(context, listen: false).setSuccessReader(true);
      Provider.of<TravelProvider>(context, listen: false)
          .setIsExecutingCharge(false);
      Provider.of<TravelProvider>(context, listen: false)
          .showCardInformation(true);
      switch (response.status) {
        case "NOT_EXISTS":
        case "NO_BALANCE":
          await _playSoundNoBalance();
          break;
        default:
          if (response.balance < 0)
            await _playSoundPrestamo();
          else {
            // TODO: SAVE AS A SUCCESSFUL CHARGE TRANSACTION
            await _playSound();
          }
      }
    }).catchError((Object error) async {
      Provider.of<TravelProvider>(context, listen: false)
          .showCardInformation(true);

      if (error is NetworkException) {
        Provider.of<CardProvider>(context, listen: false)
            .setValidationErrorReader(error.message);
      } else {
        Provider.of<CardProvider>(context, listen: false)
            .setValidationErrorReader(
                getTranslated('DEFAULT_RESPONSE_ERROR', context));
      }
      Provider.of<CardProvider>(context, listen: false).setSuccessReader(false);
      Provider.of<TravelProvider>(context, listen: false)
          .setIsExecutingCharge(false);
      await _playSoundNoBalance();
    });
  }

  void getCardByCode(String code) {
    Provider.of<CardProvider>(context, listen: false).setFetchingCardInfo(true);
    Provider.of<CardProvider>(context, listen: false)
        .getCardByCode(code)
        .then((response) async {
      await _playSound();
      Provider.of<CardProvider>(context, listen: false)
          .setFetchingCardInfo(false);
    }).catchError((Object error) async {
      Provider.of<CardProvider>(context, listen: false).setCardReaded(null);
      Utils.showErrorMessage(context, error);
      Provider.of<CardProvider>(context, listen: false)
          .setFetchingCardInfo(false);
      await _playSoundNoBalance();
    });
  }

  void getLastCharges(String code) {
    PartnerInformationResponse partnerInfo =
        Provider.of<PartnerProvider>(context, listen: false)
            .selectedPartnerInformation;

    Provider.of<CardProvider>(context, listen: false).setFetchingCardInfo(true);
    Provider.of<CardProvider>(context, listen: false)
        .getLastCardChargedTransactions(code, partnerInfo.bus.id)
        .then((response) async {
      await _playSound();
      Provider.of<CardProvider>(context, listen: false)
          .setFetchingCardInfo(false);
    }).catchError((Object error) async {
      Utils.showErrorMessage(context, error);
      Provider.of<CardProvider>(context, listen: false)
          .setFetchingCardInfo(false);
      await _playSoundNoBalance();
    });
  }

  Future<int> _loadSound() async {
    var asset = await rootBundle.load("assets/audio/success.wav");
    return await _soundpool.load(asset);
  }

  Future<int> _loadSoundNoBalance() async {
    var asset = await rootBundle.load("assets/audio/no_balance.wav");
    return await _soundpool.load(asset);
  }

  Future<int> _loadSoundPrestamo() async {
    var asset = await rootBundle.load("assets/audio/prestamo.wav");
    return await _soundpool.load(asset);
  }

  Future<void> _playSound() async {
    var _alarmSound = await _soundId;
    await _soundpool.play(_alarmSound);
  }

  Future<void> _playSoundNoBalance() async {
    var _alarmSound = await _soundNoBalanceId;
    await _soundpool.play(_alarmSound);
  }

  Future<void> _playSoundPrestamo() async {
    var _alarmSound = await _soundPrestamoId;
    await _soundpool.play(_alarmSound);
  }

  Future<void> _loadSounds() async {
    _soundpool ??= Soundpool.fromOptions();
    _soundId = _loadSound();
    _soundNoBalanceId = _loadSoundNoBalance();
    _soundPrestamoId = _loadSoundPrestamo();
  }

  Future<void> _disposePool() async {
    _soundpool.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int _pageIndex;
    if (Provider.of<SplashProvider>(context, listen: false).fromSetting) {
      _pageIndex = 0;
    } else {
      _pageIndex = 0;
    }

    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _bottomNavKey.currentState.setPage(0);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        bottomNavigationBar:
            Consumer<AuthProvider>(builder: (context, auth, child) {
          if (auth.role == UserRole.DRIVER) {
            return FancyBottomNavBar(
              key: _bottomNavKey,
              initialSelection: _pageIndex,
              isLtr: Provider.of<LocalizationProvider>(context).isLtr,
              isDark: Provider.of<ThemeProvider>(context).darkTheme,
              tabs: [
                FancyTabData(
                    title: getTranslated('charges', context),
                    iconPath: Icons.directions_bus),
                FancyTabData(
                    title: getTranslated('stats', context),
                    iconPath: Icons.query_stats),
                FancyTabData(
                    title: getTranslated('settings', context),
                    iconPath: Icons.dashboard_outlined),
              ],
              onTabChangedListener: (int index) {
                _pageController.jumpToPage(index);
                _pageIndex = index;
              },
            );
          }

          return FancyBottomNavBar(
            key: _bottomNavKey,
            initialSelection: _pageIndex,
            isLtr: Provider.of<LocalizationProvider>(context).isLtr,
            isDark: Provider.of<ThemeProvider>(context).darkTheme,
            tabs: [
              FancyTabData(
                  title: getTranslated('charges', context),
                  iconPath: Icons.directions_bus),
              FancyTabData(
                  title: getTranslated('home', context),
                  iconPath: Icons.brightness_auto_outlined),
              FancyTabData(
                  title: getTranslated('stats', context),
                  iconPath: Icons.query_stats),
              FancyTabData(
                  title: getTranslated('settings', context),
                  iconPath: Icons.dashboard_outlined),
            ],
            onTabChangedListener: (int index) {
              _pageController.jumpToPage(index);
              _pageIndex = index;
            },
          );
        }),
        body: Consumer<AuthProvider>(
          builder: (context, auth, child) {
            if (auth.role == UserRole.DRIVER) {
              final List<Widget> _screens = [
                BusTravelScreen(),
                StatsScreen(isBackButtonExist: false),
                SettingsScreen(),
              ];

              return PageView.builder(
                controller: _pageController,
                itemCount: _screens.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _screens[index];
                },
              );
            }

            final List<Widget> _screens = [
              BusTravelScreen(),
              HomePage(),
              StatsScreen(isBackButtonExist: false),
              SettingsScreen(),
            ];

            return PageView.builder(
              controller: _pageController,
              itemCount: _screens.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return _screens[index];
              },
            );
          },
        ),
      ),
    );
  }
}
