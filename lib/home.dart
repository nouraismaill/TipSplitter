import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
double _billAmount=0.0;
int _nbOfPeople=1;
double _tipPercentage=10.0;
TextEditingController _billController = TextEditingController();
TextEditingController _peopleController = TextEditingController();

static const List<double> tipOptions = [10.0,15.0,20.0,25.0];
double calculateTip(){
  return _billAmount*(_tipPercentage/100);
}
double calculateTotal(){
  return _billAmount+calculateTip();
}
double calculateSplit(){
  return calculateTotal() / _nbOfPeople;
}

void clearData() {
  setState(() {
    _tipPercentage = 10.0;
    _billAmount=0.0;
    _nbOfPeople=1;
    _billController.text = '';
    _peopleController.text = '';
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tip Splitter', style: TextStyle(fontSize: 25),),
          backgroundColor: Colors.red,
          shadowColor: Colors.redAccent,
          toolbarHeight: 70,
        ),
        body:SingleChildScrollView(
       child: Padding(
           padding: EdgeInsets.all(16.0),
            child: Column(
                children: [
                  const SizedBox(height: 15),
                  Padding(
                      padding: EdgeInsets.all(15),
                      child: TextField(
                        controller: _billController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Bill Amount',
                            prefixIcon: Icon(Icons.attach_money)
                        ),
                        onChanged: (value) {
                          setState(() {
                            _billAmount = double.parse(value) ;
                          });
                        },
                      )
                  ),
                  Padding(
                      padding: EdgeInsets.all(15),
                      child: TextField(
                        controller: _peopleController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Number of people',
                            prefixIcon: Icon(Icons.people)
                        ),
                        onChanged: (value) {
                          setState(() {
                      _nbOfPeople = int.parse(value) ;
                          });
                        },
                      )
                  ),
                  const SizedBox(height: 18),
                  Text('Tip Percentage:',style: TextStyle(fontSize: 18,color: Colors.black)),
                  SizedBox(width: 16),
                  SizedBox(height: 15),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...tipOptions.map((percentage) =>
                            Row(
                              children: [
                                Radio(value: percentage,
                                  groupValue: _tipPercentage,
                                  onChanged: (value) {
                                    setState(() {
                                      _tipPercentage = value!;
                                    });
                                  },
                                ),
                                Text('$percentage%',style: TextStyle(fontSize: 14),),
                              ],
                            ),
                        ),
                      ],

                  ),
                  SizedBox(height: 24),
                 Card(
                   elevation: 5,
                   child: Padding(
                     padding: const EdgeInsets.all(16.0),
                     child: Column(
                       children: [
                         Result(label: 'Tip', billAmount:calculateTip()),
                         Result(label: 'Total', billAmount:calculateTotal()),
                         Result(label: 'Split', billAmount:calculateSplit()),
                       ],
                   ),
                 )
                 ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: clearData,
                    child: Text('Clear',style: TextStyle(fontSize: 21)),
                  ),
                  const SizedBox(height: 18),
            ]
        )
    ),

    )
    );
  }
}
class Result extends StatelessWidget {
  final String label;
  final double billAmount;
  const Result({required this.label,required this.billAmount, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
        Text('\$${billAmount.toStringAsFixed(2)}',
        style: TextStyle(fontSize: 18),)
      ],
    ),);
  }
}
