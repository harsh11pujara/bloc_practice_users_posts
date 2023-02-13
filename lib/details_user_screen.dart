import 'package:bloc_practice/image_bloc/image_bloc.dart';
import 'package:bloc_practice/image_model.dart';
import 'package:bloc_practice/likes_bloc/likes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_practice/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailsScreen extends StatefulWidget {
  final int userIndex;
  final List<UserModel> userData;

  const DetailsScreen({
    Key? key,
    required this.userData,
    required this.userIndex,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late List<ImageModel> imageData;
  List<int> likesList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        centerTitle: true,
      ),
      body: BlocBuilder<ImageBloc, ImageState>(
        builder: (context, state) {
          if (state is ImageLoadedState) {
            imageData = state.data;
            return ListView.builder(
              itemCount: imageData.length,
              itemBuilder: (context, index) {
                likesList.add(0);
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  color: Colors.grey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        imageUrl: imageData[index + widget.userIndex].url,
                        placeholder: (context, url) =>
                            const SizedBox(height: 500, width: 600),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      Text(widget.userData[widget.userIndex].name,
                          style: const TextStyle(fontSize: 22)),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                BlocProvider.of<LikesBloc>(context)
                                    .add(IncrementEvent(index));
                              },
                              icon: const Icon(Icons.thumb_up)),
                          IconButton(
                              onPressed: () {
                                if (likesList[index] > 0) {
                                  BlocProvider.of<LikesBloc>(context)
                                      .add(DecrementEvent(index));
                                }
                              },
                              icon: const Icon(Icons.thumb_down)),
                          const SizedBox(
                            width: 10,
                          ),
                          BlocProvider<LikesBloc>.value(
                            value: BlocProvider.of<LikesBloc>(context),
                            child: BlocListener<LikesBloc, LikesState>(child: Text(likesList[index].toString(), style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500)),listener: (context, state) {
                              if (state is LikesIncrementState){
                                if (state.dataList[index] != null) {
                                  likesList[index] = state.dataList[index]!;
                                  setState(() {
                                  
                                  });
                                }
                                print('increment ${state.dataList[index]}');
                              }else if (state is LikesDecrementState){
                                if (state.dataList[index] != null) {
                                  likesList[index] = state.dataList[index]!;
                                  setState(() {
                                    
                                  });
                                }
                                print('decrement ${state.dataList[index]}');
                              }else{
                                likesList[index];
                              }
                            },)),

                          // BlocBuilder<LikesBloc, LikesState>(
                          //   builder: (context, likesState) {
                          //     if (likesState is LikesIncrementState) {
                          //       likesList[index] = likesState.dataList[index] != null ? likesState.dataList[index]! : 0;
                          //       return Text(
                          //         likesState.dataList[index]!.toString(),
                          //         style: const TextStyle(
                          //             fontSize: 22,
                          //             fontWeight: FontWeight.w500),
                          //       );
                          //     } else if (likesState is LikesDecrementState) {
                          //       likesList[index] = likesState.dataList[index]!;
                          //       return Text(
                          //         likesList[index].toString(),
                          //         style: const TextStyle(
                          //             fontSize: 22,
                          //             fontWeight: FontWeight.w500),
                          //       );
                          //     } else {
                          //       return Text(
                          //         likesList[index].toString(),
                          //         style: const TextStyle(
                          //             fontSize: 22,
                          //             fontWeight: FontWeight.w500),
                          //       );
                          //     }
                          //   },
                          // )
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          } else if (state is ImageErrorState) {
            return Center(
              child: Text(state.error),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
