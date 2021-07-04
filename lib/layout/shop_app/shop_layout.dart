import 'package:first_flutter_app/modules/shop_app/login/shop_login_scree.dart';
import 'package:first_flutter_app/shared/components/components.dart';
import 'package:first_flutter_app/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Salla'
        ),
      ),
      body: TextButton(
          onPressed: (){
            CacheHelper.removeData(key: 'token').then((value) {
              if(value){
                navigateFinish(context, ShopLoginScreen());
              }
            });
          },
          child: Text('SIGN OUT'),
      ),
    );
  }
}
