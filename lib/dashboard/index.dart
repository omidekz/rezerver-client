import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:service_manager_client/dashboard/logic.dart';

class DashboardPage extends StatelessWidget {
  static final DashboardLogic logic = GetIt.I<DashboardLogic>();
  const DashboardPage({super.key});

  Widget bottomNavigator(Color secondaryColor) {
    return ValueListenableBuilder(
      valueListenable: logic.bottomIndex,
      builder: (context, value, child) {
        return BottomNavigationBar(
          selectedItemColor: secondaryColor,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.line_style_outlined),
              label: '',
            ),
          ],
          elevation: 0,
          currentIndex: logic.bottomIndex.value,
          onTap: (value) => logic.loadPage(value),
        );
      },
    );
  }

  Widget homePage(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: size.height * .03,
            horizontal: size.width * .02,
          ),
          child: Card(
            elevation: 20,
            child: SizedBox(
              height: size.height * .15,
              child: Row(
                children: const [Text('data')],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget shopPage() {
    return const Text('shop');
  }

  Widget profilePage() {
    return const Text('profile');
  }

  Expanded tb(String title, {void Function()? onPressed}) => Expanded(
        flex: 1,
        child: TextButton(onPressed: onPressed, child: Text(title)),
      );

  Row tbRow(List<Expanded> exs) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: exs.reversed.toList(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      bottomNavigationBar:
          bottomNavigator(Theme.of(context).colorScheme.secondary),
      body: SafeArea(
        child: Center(
          child: Column(children: [
            tbRow([tb('منو ها'), tb('محصولات')]),
            tbRow([tb('نظرات'), tb('سفارش ها')]),
            tbRow([tb('تنظیمات')])
          ]),
        ),
      ),
    );
  }
}
