import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfo extends StatelessWidget {
  const AppInfo({Key? key}) : super(key: key);

  Future<PackageInfo> _getPackageInfo() {
    return PackageInfo.fromPlatform();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FutureBuilder<PackageInfo>(
            future: _getPackageInfo(),
            builder:
                (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
              if (snapshot.hasError) {
                // print('Error => $snapshot');
                return Text('An error occured!');
              } else if (snapshot.hasData) {
                final _data = snapshot.data!;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /*  Text('App name: ${_data.appName}'),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text('Package name: ${_data.packageName}'), 
                    SizedBox(
                      height: 3.0,
                    ), */
                    Text('App version: ${_data.version}'),
                    SizedBox(
                      height: 3.0,
                    ),
                    /*    Text('Build number: ${_data.buildNumber}'), */
/*                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('App version: ${_data.version}'),
                        Text('Build number: ${_data.buildNumber}'),
                      ],
                    ) */
                  ],
                );
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
