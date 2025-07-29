// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:vpn/constants/app_colors.dart';
// import 'package:vpn/generated/assets.dart';
// import 'package:vpn/widgets/common_image_view_widget.dart';
// import 'package:vpn/widgets/custom_animated_column.dart';

// import '../controllers/home_controller.dart';
// import '../helpers/pref.dart';
// import '../main.dart';
// import '../models/vpn_status.dart';
// import '../services/vpn_engine.dart';
// import '../widgets/count_down_timer.dart';
// import '../widgets/home_card.dart';
// import 'location_screen.dart';
// import 'network_test_screen.dart';

// class HomeScreen extends StatelessWidget {
//   HomeScreen({super.key});

//   final _controller = Get.put(HomeController());

//   @override
//   Widget build(BuildContext context) {
//     mq = MediaQuery.sizeOf(context);

//     ///Add listener to update vpn state
//     VpnEngine.vpnStageSnapshot().listen((event) {
//       _controller.vpnState.value = event;
//     });

//     return Scaffold(
//       //app bar
//       appBar: _buildAppBar(),
//       bottomNavigationBar: _changeLocation(context),
//       //body
//       body: Padding(
//         padding: EdgeInsets.all(8),
//         child: AnimatedColumn(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             //vpn button
//             Obx(() => _vpnButton()),
//             // Country and Ping Info
//             _buildCountryPingRow(),
//             // Download/Upload Stats
//             _buildStatsRow(),
//           ],
//         ),
//       ),
//     );
//   }

//   // App Bar Widget
//   AppBar _buildAppBar() {
//     return AppBar(
//       shadowColor: Colors.transparent,
//       surfaceTintColor: Colors.transparent,
//       elevation: 0,
//       leading: CommonImageView(imagePath: Assets.imagesLogo, height: 20),
//       title: Text('VPN'),
//       actions: [
//         IconButton(
//           onPressed: () {
//             Get.changeThemeMode(
//               Pref.isDarkMode ? ThemeMode.light : ThemeMode.dark,
//             );
//             Pref.isDarkMode = !Pref.isDarkMode;
//           },
//           icon: Icon(Icons.brightness_medium, size: 24),
//         ),
//         IconButton(
//           onPressed: () => Get.to(() => NetworkTestScreen()),
//           icon: Icon(CupertinoIcons.info, size: 24),
//         ),
//       ],
//     );
//   }

//   // Country and Ping Row Widget
//   Widget _buildCountryPingRow() {
//     return Obx(
//       () => Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           //country flag
//           HomeCard(
//             title:
//                 _controller.vpn.value.countryLong.isEmpty
//                     ? 'Country'
//                     : _controller.vpn.value.countryLong,
//             subtitle: '',
//             icon: CircleAvatar(
//               radius: 30,
//               backgroundColor: Colors.blue,
//               child:
//                   _controller.vpn.value.countryLong.isEmpty
//                       ? Icon(
//                         Icons.vpn_lock_rounded,
//                         size: 30,
//                         color: Colors.white,
//                       )
//                       : null,
//               backgroundImage:
//                   _controller.vpn.value.countryLong.isEmpty
//                       ? null
//                       : AssetImage(
//                         'assets/flags/${_controller.vpn.value.countryShort.toLowerCase()}.png',
//                       ),
//             ),
//           ),

//           //ping time
//           HomeCard(
//             title:
//                 _controller.vpn.value.countryLong.isEmpty
//                     ? ' ms'
//                     : '${_controller.vpn.value.ping} ms',
//             subtitle: 'PING',
//             icon: CircleAvatar(
//               radius: 30,
//               backgroundColor: Colors.orange,
//               child: Icon(
//                 Icons.equalizer_rounded,
//                 size: 30,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Download/Upload Stats Row Widget
//   Widget _buildStatsRow() {
//     return StreamBuilder<VpnStatus?>(
//       initialData: VpnStatus(),
//       stream: VpnEngine.vpnStatusSnapshot(),
//       builder:
//           (context, snapshot) => Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               //download
//               HomeCard(
//                 title: '${snapshot.data?.byteIn ?? '0 kbps'}',
//                 subtitle: 'DOWNLOAD',
//                 icon: CircleAvatar(
//                   radius: 30,
//                   backgroundColor: Colors.lightGreen,
//                   child: Icon(
//                     Icons.arrow_downward_rounded,
//                     size: 30,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),

//               //upload
//               HomeCard(
//                 title: '${snapshot.data?.byteOut ?? '0 kbps'}',
//                 subtitle: 'UPLOAD',
//                 icon: CircleAvatar(
//                   radius: 30,
//                   backgroundColor: Colors.blue,
//                   child: Icon(
//                     Icons.arrow_upward_rounded,
//                     size: 30,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//     );
//   }

//   //vpn button
//   Widget _vpnButton() => AnimatedColumn(
//     children: [
//       //count down timer
//       Obx(
//         () => CountDownTimer(
//           startTimer: _controller.vpnState.value == VpnEngine.vpnConnected,
//         ),
//       ),
//       _controller.vpnState.value == VpnEngine.vpnDisconnected
//           ? Gap(10)
//           : Gap(0),
//       Container(
//         margin: EdgeInsets.only(top: mq.height * .015, bottom: mq.height * .02),
//         padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
//         decoration: BoxDecoration(),
//         child: Text(
//           _controller.vpnState.value == VpnEngine.vpnDisconnected
//               ? ''
//               : _controller.vpnState.replaceAll('_', ' ').toUpperCase(),
//           style: TextStyle(fontSize: 12.5),
//         ),
//       ),

//       Gap(20),
//       Semantics(
//         button: true,
//         child: InkWell(
//           onTap: () {
//             _controller.connectToVpn();
//           },
//           borderRadius: BorderRadius.circular(100),
//           child: Container(
//             padding: EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: _getButtonBackgroundColor().withOpacity(.1),
//               boxShadow:
//                   _controller.vpnState.value == VpnEngine.vpnDisconnected
//                       ? [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.1),
//                           spreadRadius: 2,
//                           blurRadius: 8,
//                           offset: Offset(0, 4),
//                         ),
//                       ]
//                       : [
//                         BoxShadow(
//                           color: _getButtonBackgroundColor().withOpacity(0.4),
//                           spreadRadius: 2,
//                           blurRadius: 12,
//                           offset: Offset(0, 4),
//                         ),
//                       ],
//             ),
//             child: Container(
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: _getButtonBackgroundColor().withOpacity(.3),
//               ),
//               child: Container(
//                 width: mq.height * .14,
//                 height: mq.height * .14,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: _getButtonBackgroundColor(),
//                 ),
//                 child: AnimatedColumn(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     //icon
//                     Icon(
//                       Icons.power_settings_new,
//                       size: 28,
//                       color: _getIconColor(),
//                     ),
//                     SizedBox(height: 4),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     ],
//   );

//   // Get button background color based on VPN state
//   Color _getButtonBackgroundColor() {
//     switch (_controller.vpnState.value) {
//       case VpnEngine.vpnDisconnected:
//         return Colors.white;
//       case VpnEngine.vpnConnected:
//         return Colors.lightBlue;
//       default:
//         return Colors.lightGreen;
//     }
//   }

//   // Get icon color based on VPN state
//   Color _getIconColor() {
//     switch (_controller.vpnState.value) {
//       case VpnEngine.vpnDisconnected:
//         return Colors.blue;
//       case VpnEngine.vpnConnected:
//         return Colors.white;
//       default:
//         return Colors.yellow;
//     }
//   }

//   //bottom nav to change location
//   Widget _changeLocation(BuildContext context) => SafeArea(
//     child: Semantics(
//       button: true,
//       child: InkWell(
//         onTap: () => Get.to(() => LocationScreen()),
//         child: Container(
//           margin: EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: kWhite,
//             borderRadius: BorderRadius.circular(20),
//           ),
//           padding: EdgeInsets.symmetric(horizontal: 20),
//           height: 60,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Row(
//                 spacing: 20,
//                 children: [
//                   HomeCard(
//                     brake: false,
//                     icon: CircleAvatar(
//                       radius: 20,
//                       child:
//                           _controller.vpn.value.countryLong.isEmpty
//                               ? Icon(
//                                 Icons.vpn_lock_rounded,
//                                 size: 30,
//                                 color: Colors.white,
//                               )
//                               : null,
//                       backgroundImage:
//                           _controller.vpn.value.countryLong.isEmpty
//                               ? null
//                               : AssetImage(
//                                 'assets/flags/${_controller.vpn.value.countryShort.toLowerCase()}.png',
//                               ),
//                     ),
//                   ),

//                   Text(
//                     _controller.vpn.value.countryLong.isEmpty
//                         ? 'Country'
//                         : _controller.vpn.value.countryLong,
//                     style: TextStyle(
//                       color: Colors.blue,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),

//               //icon
//               Container(
//                 padding: EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: kWhite,
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.4),
//                       spreadRadius: 2,
//                       blurRadius: 8,
//                       offset: Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: Icon(
//                   Icons.keyboard_arrow_right_rounded,
//                   color: Colors.blue,
//                   size: 26,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:vpn/constants/app_colors.dart';
import 'package:vpn/generated/assets.dart';
import 'package:vpn/widgets/common_image_view_widget.dart';
import 'package:vpn/widgets/custom_animated_column.dart';
import 'package:vpn/widgets/custom_animated_row.dart';

import '../controllers/home_controller.dart';
import '../helpers/config.dart';
import '../helpers/pref.dart';
import '../main.dart';
import '../models/vpn_status.dart';
import '../services/vpn_engine.dart';
import '../widgets/count_down_timer.dart';
import '../widgets/home_card.dart';
import 'location_screen.dart';
import 'network_test_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.sizeOf(context);

    ///Add listener to update vpn state
    VpnEngine.vpnStageSnapshot().listen((event) {
      _controller.vpnState.value = event;
    });

    return Scaffold(
      //app bar
      appBar: _buildAppBar(),
      bottomNavigationBar: _changeLocation(context),
      //body
      body: AnimatedColumn(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //vpn button
          Obx(() => _vpnButton()),
          // Country and Ping Info
          _buildCountryPingRow(),
          // Download/Upload Stats
          _buildStatsRow(),
        ],
      ),
    );
  }

  // App Bar Widget
  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      leading: CommonImageView(imagePath: Assets.imagesLogo, height: 20),
      title: Text('VPN'),
      actions: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                Get.changeThemeMode(
                  Pref.isDarkMode ? ThemeMode.light : ThemeMode.dark,
                );
                Pref.isDarkMode = !Pref.isDarkMode;
              },
              icon: Icon(Icons.brightness_medium, size: 24),
            ),
            IconButton(
              onPressed: () => Get.to(() => NetworkTestScreen()),
              icon: Icon(CupertinoIcons.info, size: 24),
            ),
          ],
        ),
      ],
    );
  }

  // Country and Ping Row Widget
  Widget _buildCountryPingRow() {
    return Obx(
      () => AnimatedRow(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //country flag
          HomeCard(
            title:
                _controller.vpn.value.countryLong.isEmpty
                    ? 'Country'
                    : _controller.vpn.value.countryLong,
            subtitle: '',
            icon: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blue,
              child:
                  _controller.vpn.value.countryLong.isEmpty
                      ? Icon(
                        Icons.vpn_lock_rounded,
                        size: 30,
                        color: Colors.white,
                      )
                      : null,
              backgroundImage:
                  _controller.vpn.value.countryLong.isEmpty
                      ? null
                      : AssetImage(
                        'assets/flags/${_controller.vpn.value.countryShort.toLowerCase()}.png',
                      ),
            ),
          ),

          //ping time
          HomeCard(
            title:
                _controller.vpn.value.countryLong.isEmpty
                    ? ' ms'
                    : '${_controller.vpn.value.ping} ms',
            subtitle: 'PING',
            icon: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.orange,
              child: Icon(
                Icons.equalizer_rounded,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Download/Upload Stats Row Widget
  Widget _buildStatsRow() {
    return StreamBuilder<VpnStatus?>(
      initialData: VpnStatus(),
      stream: VpnEngine.vpnStatusSnapshot(),
      builder:
          (context, snapshot) => AnimatedRow(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //download
              HomeCard(
                title: '${snapshot.data?.byteIn ?? '0 kbps'}',
                subtitle: 'DOWNLOAD',
                icon: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.lightGreen,
                  child: Icon(
                    Icons.arrow_downward_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),

              //upload
              HomeCard(
                title: '${snapshot.data?.byteOut ?? '0 kbps'}',
                subtitle: 'UPLOAD',
                icon: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.arrow_upward_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
    );
  }

  //vpn button
  Widget _vpnButton() => AnimatedColumn(
    children: [
      //count down timer
      Obx(
        () => CountDownTimer(
          startTimer: _controller.vpnState.value == VpnEngine.vpnConnected,
        ),
      ),
     _controller.vpnState.value == VpnEngine.vpnDisconnected
          ? Gap(16)
          : Gap(10),
      //connection status label
      Text(
        _controller.vpnState.value == VpnEngine.vpnDisconnected
            ? 'Tap to Connect'
            : _controller.vpnState.replaceAll('_', ' ').toUpperCase(),
        style: TextStyle(fontSize: 12.5, color: Colors.white),
      ),
      //button
      Semantics(
        button: true,
        child: InkWell(
          onTap: () {
            _controller.connectToVpn();
          },
          borderRadius: BorderRadius.circular(100),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _getButtonBackgroundColor().withOpacity(.1),
              boxShadow:
                  _controller.vpnState.value == VpnEngine.vpnDisconnected
                      ? [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ]
                      : [
                        BoxShadow(
                          color: _getButtonBackgroundColor().withOpacity(0.4),
                          spreadRadius: 2,
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
            ),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _getButtonBackgroundColor().withOpacity(.3),
              ),
              child: Container(
                width: mq.height * .14,
                height: mq.height * .14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _getButtonBackgroundColor(),
                ),
                child: AnimatedColumn(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //icon
                    Icon(
                      Icons.power_settings_new,
                      size: 28,
                      color: _getIconColor(),
                    ),
                    SizedBox(height: 4),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
 
    ],
  );

  // Get button background color based on VPN state
  Color _getButtonBackgroundColor() {
    switch (_controller.vpnState.value) {
      case VpnEngine.vpnDisconnected:
        return Colors.white;
      case VpnEngine.vpnConnected:
        return Colors.lightBlue;
      default:
        return Colors.lightGreen;
    }
  }


  // Get icon color based on VPN state
    Color _getIconColor() {
    switch (_controller.vpnState.value) {
      case VpnEngine.vpnDisconnected:
        return Colors.blue;
      case VpnEngine.vpnConnected:
        return Colors.white;
      default:
        return Colors.yellow;
    }
  }


  //bottom nav to change location
  Widget _changeLocation(BuildContext context) => SafeArea(
    child: Semantics(
      button: true,
      child: InkWell(
        onTap: () => Get.to(() => LocationScreen()),
        child: Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: 60,
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  spacing: 20,
                  children: [
                    HomeCard(
                      brake: false,
                      icon: CircleAvatar(
                        radius: 20,
                        child:
                            _controller.vpn.value.countryLong.isEmpty
                                ? Icon(
                                  Icons.vpn_lock_rounded,
                                  size: 30,
                                  color: Colors.white,
                                )
                                : null,
                        backgroundImage:
                            _controller.vpn.value.countryLong.isEmpty
                                ? null
                                : AssetImage(
                                  'assets/flags/${_controller.vpn.value.countryShort.toLowerCase()}.png',
                                ),
                      ),
                    ),

                    Text(
                      _controller.vpn.value.countryLong.isEmpty
                          ? 'Country'
                          : _controller.vpn.value.countryLong,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                //icon
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: kWhite,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_right_rounded,
                    color: Colors.blue,
                    size: 26,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
