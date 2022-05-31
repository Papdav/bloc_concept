import 'package:bloc_concept/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
      
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocConsumer<CounterCubit,CounterState>(
              builder: (context,state) {
                return Text(state.counterValue.toString());
              },
              listener: (context,state){
                if(state.wasIncrement == true){
                  Scaffold.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Increment'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                }else if(state.wasIncrement == false) {
                  Scaffold.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Decrement'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                }
              },
            ),
            Row(
              children: [
                FloatingActionButton(
                  onPressed: (){
                    BlocProvider.of<CounterCubit>(context).decrement();
                    // context.bloc<CounterCubit>().decrement();
                  },
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                ),
                FloatingActionButton(
                  onPressed: (){
                    BlocProvider.of<CounterCubit>(context).increment();
                    // context.bloc<CounterCubit>().increment();
                  },
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
