import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app_new/model/user_model.dart';
import 'package:my_app_new/provider/user.dart';

class UserView extends ConsumerWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Data Users'),
          leading: IconButton(
            onPressed: () {
              context.goNamed(
                'homepage',
                pathParameters: {
                  'email': 'No Email',
                },
              );
            },
            icon: Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        body: Consumer(
          builder: (context, ref, child) => ref.watch(userDataProvider).when(
            data: (data) {
              List<UserModel> userList = data.map((e) => e).toList();
              return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.amber,
                      child: ListTile(
                        title: Text(
                            '${userList[index].firstName} ${userList[index].lastName}'),
                        subtitle: Text('${userList[index].email}'),
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(userList[index].avatar.toString()),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            error: (error, stackTrace) {
              return Text('error ambil data ${error.toString()} ');
            },
            loading: () {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ));
  }
}
