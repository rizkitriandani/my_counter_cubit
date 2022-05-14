import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/counter/counter_cubit.dart';
import 'other_page.dart';

/**
 * BuildContext extension ini sangat bermanfaat untuk case di mana kita butuh
 * mengakses multiple state dari multiple bloc yang berebeda-beda. 
 * Tinggal buat masing-masing variable untukt tiap state contoh :
 * var state1 = context.watch<BlocA>().state;
 * var state2 = context.watch<BlocB>().state;
 * var state3 = context.watch<BlocC>().state;
 * 
 * , terus taro di widget-widget yang diperlukan. untuk selangkapnya cek di sini :
 * https://github.com/felangel/bloc/issues/1902
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
              context.read<CounterCubit>().increment();
              // BlocProvider.of<CounterCubit>(context).increment();
            },
            child: Icon(Icons.add),
            heroTag: 'increment',
          ),
          SizedBox(width: 10.0),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterCubit>().decrement();
              // BlocProvider.of<CounterCubit>(context).decrement();
            },
            child: Icon(Icons.remove),
            heroTag: 'decrement',
          ),
        ],
      ),
    );
  }
}
