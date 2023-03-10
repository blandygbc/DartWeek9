import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vakinhaburger/app/core/extensions/formatter_extension.dart';
import 'package:vakinhaburger/app/core/routes/routes_names.dart';
import 'package:vakinhaburger/app/core/ui/helpers/size_extensions.dart';
import 'package:vakinhaburger/app/core/ui/styles/text_styles.dart';
import 'package:vakinhaburger/app/dto/order_product_dto.dart';
import 'package:vakinhaburger/app/pages/home/home_controller.dart';

class ShoppingBagWidget extends StatelessWidget {
  final List<OrderProductDto> bag;
  const ShoppingBagWidget({super.key, required this.bag});

  @override
  Widget build(BuildContext context) {
    double totalBag = bag.fold<double>(
      0,
      (total, element) => total += element.totalPrice,
    );
    return Container(
      width: context.screenWith,
      height: 90,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: ElevatedButton(
          onPressed: () {
            _goOrder(context);
          },
          child: Stack(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.shopping_cart_outlined),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Ver Sacola',
                  style: context.textStyles.textButtonLabel,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  totalBag.currencyPTBR,
                  style: context.textStyles.textExtraBold.copyWith(
                    fontSize: 11,
                  ),
                ),
              )
            ],
          )),
    );
  }

  Future<void> _goOrder(BuildContext context) async {
    final navigator = Navigator.of(context);
    final controller = context.read<HomeController>();
    final sp = await SharedPreferences.getInstance();
    if (!sp.containsKey('accessToken')) {
      final loginResult = await navigator.pushNamed(RoutesNames.loginPage);
      if (loginResult == null || loginResult == false) {
        return;
      }
    }
    final updateBag =
        await navigator.pushNamed(RoutesNames.orderPage, arguments: bag);
    controller.updateBag(updateBag as List<OrderProductDto>);
  }
}
