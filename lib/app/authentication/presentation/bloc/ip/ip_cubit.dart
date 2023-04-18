import 'package:bloc/bloc.dart';
import '../../../domain/usecases/set_ip.dart';

class IpCubit extends Cubit<String> {
  SetIp setIp;
  IpCubit({required this.setIp}) : super('');

  void set(String ip) {
    setIp.call(ip);
  }
}
