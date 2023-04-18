import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/ip/ip_cubit.dart';
import 'authentication_button.dart';
import 'input_text.dart';
class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  late TextEditingController ipController;

  @override
  void initState() {
    super.initState();
    ipController = TextEditingController();
  }


  @override
  void dispose() {
    ipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IpCubit, String>(
      builder: (context, ip) {
        ipController.text = ip.replaceAll(RegExp(r':1904'), '');
        return Container(
          color: const Color.fromARGB(100, 255, 255, 255),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InputText(title: 'ip', controller: ipController),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AuthenticationButton(
                    onTap: () {
                      _setIP();
                    },
                    child: Text(
                      'Set IP',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _setIP() {
    context.read<IpCubit>().set('${ipController.value.text}:1904');
    Scaffold.of(context).closeDrawer();
  }
}
