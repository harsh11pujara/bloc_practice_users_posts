import 'package:bloc_practice/Repository/image_repository.dart';
import 'package:bloc_practice/Repository/user_repository.dart';
import 'package:bloc_practice/bloc/home_bloc.dart';
import 'package:bloc_practice/details_user_screen.dart';
import 'package:bloc_practice/image_bloc/image_bloc.dart';
import 'package:bloc_practice/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'likes_bloc/likes_bloc.dart';

void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider(
          create: (context) => ImageRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                HomeBloc(RepositoryProvider.of<UserRepository>(context))
                  ..add(LoadUserEvent()),
          ),
          BlocProvider(
            create: (context) =>
                ImageBloc(RepositoryProvider.of<ImageRepository>(context))
                  ..add(LoadImageEvent()),
          ),
          BlocProvider(create: (context) => LikesBloc(),)
        ],
        child:
            const MaterialApp(debugShowCheckedModeBanner: false, home: Home()),
      ),
    ),
  );
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Bloc Trail'),
          centerTitle: true,
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is UserLoadedState) {
              List<UserModel> data = state.userData;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                          userData: data,
                          userIndex: index,
                        ),
                      ));
                    },
                    title: Text(data[index].name,
                        style: const TextStyle(fontSize: 22)),
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data[index].email,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600)),
                          Text(data[index].city),
                          Text(data[index].phone)
                        ]),
                    leading: CircleAvatar(
                      child: Text(data[index].id),
                    ),
                  );
                },
              );
            } else if (state is UserErrorState) {
              return const Center(child: Text('error'));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
