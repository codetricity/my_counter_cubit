import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_counter_cubit/cubits/counter/counter_cubit.dart';
import 'package:my_counter_cubit/my_flame_game.dart';
import 'package:my_counter_cubit/other_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'MyCounter Cubit',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: Stack(children: [
            GameWidget(game: MyFlameGame()),
            MyHomePage(),
          ]),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocConsumer<CounterCubit, CounterState>(
          listener: (context, state) {
            if (state.counter == 3) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text('counter is ${state.counter}'),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            context.read<CounterCubit>().increment();
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.add)),
                      ElevatedButton(
                          onPressed: () {
                            context.read<CounterCubit>().decrement();
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.remove)),
                    ],
                  );
                },
              );
            } else if (state.counter == -1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return OtherPage();
                }),
              );
            }
          },
          builder: (context, state) {
            return Center(
              child: Text(
                '${state.counter}',
                style: TextStyle(fontSize: 52.0),
              ),
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                context.read<CounterCubit>().increment();
              },
              child: Icon(Icons.add),
              heroTag: 'increment',
            ),
            SizedBox(width: 10.0),
            FloatingActionButton(
              onPressed: () {
                context.read<CounterCubit>().decrement();
              },
              child: Icon(Icons.remove),
              heroTag: 'decrement',
            ),
          ],
        ),
      ],
    );
  }
}
