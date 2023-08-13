import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../bussines_logic/app_cubit.dart';

class InsertDialog extends StatelessWidget {
   InsertDialog({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  /*@override
  void () {
    cubit = AppCubit();
    super.initState();
  }*/


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Dialog(
          //alignment: AlignmentDirectional.center,

          backgroundColor: Colors.teal[250],
          /*shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.sp),
          ),*/
          child: Form(
            key: _formKey,
            child: SizedBox(
              width: double.infinity,
              child: Column(


                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocBuilder<AppCubit, AppState>(
                    builder: (context, state) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.sp),
                        child: TextFormField(
                          controller: _controller,
                          maxLines: 1,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "name can't be empty";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.teal)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black45)),
                            hintText: 'Add Task ..',
                          ),
                        ),
                      );
                    },
                  ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.tealAccent),
                            )),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextButton(
                          onPressed: () async{
                            if(_formKey.currentState!.validate()) {
                              await AppCubit.get(context).insertToAccount(text: _controller.text,
                                  type: AppCubit.get(context).initialType);

                              Fluttertoast.showToast(
                                  msg: "Task Added !",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);

                                Navigator.pop(context);

                            }

                          },
                          child: const Text(
                            'Add',
                            style: TextStyle(color: Colors.tealAccent),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                            padding: EdgeInsetsDirectional.only(start: 70.sp),
                            child: StatefulBuilder(
                              builder: (BuildContext context, StateSetter setState) =>
                               DropdownButton<String>(
                                value: AppCubit.get(context).initialType,
                                icon: const Icon(Icons.menu),
                                style: const TextStyle(color: Colors.teal),
                                underline: Container(
                                  color: Colors.transparent,
                                ),
                                onChanged: (value) {
                                  setState((){ AppCubit.get(context).changeDropDown(value!);
                                  print(AppCubit.get(context).initialType);});
                                },
                                items: const [
                                  DropdownMenuItem<String>(
                                    value: 'Personal',
                                    child: Text('Personal'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Work',
                                    child: Text('Work'),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
