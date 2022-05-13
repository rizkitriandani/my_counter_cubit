import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/counter/counter_cubit.dart';
import 'other_page.dart';

/**
 * BlocListener digunakan ketika kamu ingin men-trigger sebuah action ketika suatu state tercapai (diluar dari state yang diubah ya), misal ketika angka counter mancapai angka 3 kamu ingin memunculkan alert dialog. state tetap berubah tapi kamu butuh cara untuk invoke side effect ketika counter berubah ke angka 3 kan? nah disinilah dibutuhkan BlocListener.
  1. Bungkus widget yang mengandung BlocBuilder dengan BlocListener
  2. Masukkan action yang kamu ingin aplikasi jalankan ketika suatu state tertentu tercapai menggunakan perintan percabangan.
  3. Ingat untuk selalu panggill state dengan cara state.<variabel_state>
*/

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Counter Cubit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => CounterCubit(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("==REBUILD ALL==");
    return Scaffold(
      body: Center(
        child: BlocConsumer<CounterCubit, CounterState>(
          listener: (context, state) {
            if (state.counter == 3) {
              print("MANTAP");
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        content: Text("TADA"),
                      ));
            } else if (state.counter == -1) {
              print("MANTAP");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OtherPage()));
            }
          },
          builder: (context, state) {
            return Text(
              "${state.counter}",
              style: TextStyle(fontSize: 52.0),
            );
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<CounterCubit>(context).increment();
            },
            child: Icon(Icons.add),
            heroTag: 'increment',
          ),
          SizedBox(width: 10.0),
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<CounterCubit>(context).decrement();
            },
            child: Icon(Icons.remove),
            heroTag: 'decrement',
          ),
        ],
      ),
    );
  }
}
