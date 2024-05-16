import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_client/blocs/address/address_cubit.dart';
import 'package:food_client/contants.dart';
import 'package:food_client/models/address.dart';
import 'package:food_client/models/user.dart';
import 'package:food_client/widgets/order/delivery_address_widget.dart';

class AddAddress extends StatelessWidget {
  final User? user;

  const AddAddress({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddressCubit(),
      child: AddAddressBody(user: user),
    );
  }
}

class AddAddressBody extends StatefulWidget {
  final User? user;

  const AddAddressBody({Key? key, this.user}) : super(key: key);

  @override
  State<AddAddressBody> createState() => _AddAddressBodyState();
}

class _AddAddressBodyState extends State<AddAddressBody> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String? _selectedProvince;
  String? _selectedDistrict;
  late final AddressCubit addressCubit;


  List<String> _province = ['Hà Nội', 'Bắc Giang', 'Bắc Ninh', 'Hải Phòng'];
  Map<String, List<String>> _districts = {
    'Hà Nội': ['Quận Ba Đình', 'Quận Hoàn Kiếm', 'Quận Hai Bà Trưng', '...'],
    'Bắc Giang': ['Huyện Tân Yên', 'Huyện Hiệp Hòa', 'Huyện Yên Dũng', '...'],
    'Bắc Ninh': [
      'Thành phố Bắc Ninh',
      'Thị xã Từ Sơn',
      'Huyện Yên Phong',
      '...'
    ],
    'Hải Phòng': ['Quận Hồng Bàng', 'Quận Lê Chân', 'Quận Ngô Quyền', '...']
  };

  void showBottom({String? userId}) {

  }

  @override
  Widget build(BuildContext context) {
    final String? userId = widget.user?.user?.id ?? "";
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return BlocBuilder<AddressCubit, AddressState>(
                        builder: (context, state) {
                          return Container(
                            width: double.infinity,
                            height: 700,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20.0),
                                    topLeft: Radius.circular(20.0))),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Liên hệ",
                                      style:
                                      TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                    TextField(
                                      controller:  nameController,
                                      decoration: InputDecoration(
                                        prefixIconConstraints:
                                        const BoxConstraints(minHeight: 30, minWidth: 30),
                                        hintText: "Họ tên",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextField(
                                      controller: phoneController,
                                      decoration: InputDecoration(
                                        prefixIconConstraints:
                                        const BoxConstraints(minHeight: 30, minWidth: 30),
                                        hintText: "Số điện thoại",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Địa chỉ",
                                      style:
                                      TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                                    ),
                                    DropdownButton<String>(
                                      value: _selectedProvince,
                                      isExpanded: true,
                                      items: _province
                                          .map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _selectedProvince = newValue!;
                                          _selectedDistrict =
                                          null; // Reset district when province changes
                                        });
                                      },
                                      hint: _selectedProvince != null
                                          ? Text(_selectedProvince!)
                                          : const Text("Chọn tỉnh/thành phố"),
                                    ),
                                    DropdownButton<String>(
                                      value: _selectedDistrict,
                                      isExpanded: true,
                                      items: _selectedProvince != null
                                          ? _districts[_selectedProvince!]!
                                          .map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList()
                                          : const [],
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _selectedDistrict = newValue!;
                                        });
                                      },
                                      hint: _selectedDistrict != null
                                          ? Text(_selectedDistrict!)
                                          : const Text("Chọn quận/huyện"),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      controller: addressController,
                                      decoration: InputDecoration(
                                        prefixIconConstraints:
                                        const BoxConstraints(minHeight: 30, minWidth: 30),
                                        hintText: "Địa chỉ cụ thể",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    // const Expanded(child: SizedBox()),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  width: 1, color: Colors.black),
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(10.0))),
                                          child: const Center(
                                              child: Text(
                                                "Hủy",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black),
                                              )),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            addressCubit.addAddress(userId!, nameController.text, phoneController.text as int, addressController.text, _selectedDistrict!, _selectedProvince!);
                                          },
                                          child: Container(
                                            width: 100,
                                            height: 50,
                                            decoration: const BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                BorderRadius.all(Radius.circular(10.0))),
                                            child: const Center(
                                                child: Text(
                                                  "Lưu",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w600),
                                                )),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    });
              },
              child: Row(
                children: [
                  Image.asset("assets/images/circle-plus.png"),
                  const SizedBox(width: 10.0),
                  const Text("Thêm địa chỉ giao hàng"),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            BlocBuilder<AddressCubit, AddressState>(
              builder: (context, state) {
                context.read<AddressCubit>().getAddress(userId!);
                if (state is AddressInitial) {
                  return const Center(
                    child: Text("Bạn chưa có địa chỉ giao hàng nào"),
                  );
                } else if (state is AddressSuccess) {
                  final listAddress = state.address;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: listAddress.length,
                      itemBuilder: (context, index) {
                        final addressU = listAddress[index];
                        return GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                       DeliveryAddressWidget(name:addressU.name,phone:addressU.phonenum.toString(),address:addressU.address,district:addressU.district,city:addressU.city)));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${addressU.name} - ${addressU.phonenum}"),
                                Text("${addressU.address} , ${addressU
                                    .district} , ${addressU.city}"),
                                const SizedBox(
                                  height: 20.0,
                                )
                              ],
                            ));
                      },
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
