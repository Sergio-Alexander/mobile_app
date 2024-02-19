import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mob_dev/app_status.dart';


import 'package:mob_dev/floor_model/recorder_database/recorder_database.dart';
import 'package:mob_dev/floor_model/diet_recorder/diet_recorder_entity.dart';



class DietRecorder extends StatefulWidget {
  final RecorderDatabase? database;
  const DietRecorder({Key? key, this.database}):super(key:key);

  @override
  _DietRecorderState createState() => _DietRecorderState();
}

class _DietRecorderState extends State<DietRecorder> {
  ScrollController _scrollController = ScrollController();
  final TextEditingController _foodController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String? selectedFood;

  List<DietRecorderEntity> dietData = [];

  Set<String> uniqueFoodItems = Set();

  @override
  void initState(){
    super.initState();
    _loadDiet();
  }

  Future<void> _loadDiet() async {
    if(widget.database != null){
      final diets = await widget.database!.dietRecorderDao.findAllDietRecorders();
      setState(() {
        dietData = diets;
        uniqueFoodItems = diets.map((diet) => diet.diet).toSet();
      });
    }
  }

  Future<void> _recordDiet() async {
    DietRecorderEntity? diet;
    final String food = _foodController.text;
    final String amount = _amountController.text;

    if(widget.database != null){
      final points = Provider.of<RecordingState>(context, listen: false).points;
      diet = DietRecorderEntity(null, food, int.parse(amount), points, DateTime.now());
    }

    if (diet != null){
      try{
        await widget.database!.dietRecorderDao.insertDietRecorder(diet);

        await _loadDiet();

        if (_scrollController.hasClients) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        }

        _foodController.clear();
        _amountController.clear();

        FocusScope.of(context).unfocus();
      } catch (e) {
        print('Error: $e');
      }
    }
    Provider.of<RecordingState>(context, listen: false).record('Diet');
  }

  Future<void> _deleteDiet(DietRecorderEntity diet) async {
    if(widget.database != null){
      try{
        await widget.database!.dietRecorderDao.deleteDietRecorder(diet);
        Provider.of<RecordingState>(context, listen: false).decreasePoints();
        await Provider.of<RecordingState>(context, listen: false).loadLastStatus();
        await _loadDiet();
      } catch (e){
        print('Error: $e');
      }
    }
  }

  Future<void> _updateDiet(DietRecorderEntity diet, int newAmount) async {
    if(widget.database != null){
      try{
        // Create a new DietRecorderEntity with the updated amount
        DietRecorderEntity updatedDiet = diet.copyWith(amount: newAmount);
        // Update the diet record in the database
        await widget.database!.dietRecorderDao.updateDietRecorder(updatedDiet);
        // Reload the diet records
        _loadDiet();
      } catch (e){
        print('Error: $e');
      }
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Diet Recorder')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DropdownButton<String>(
              key: const Key('foodDropdown'),
              value: selectedFood,
              hint: const Text('Select Food'),
              onChanged: (newValue) {
                setState(() {
                  selectedFood = newValue;
                  _foodController.text = newValue ?? '';
                });
              },
              items: uniqueFoodItems.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            TextField(
              controller: _foodController,
              decoration: const InputDecoration(
                hintText: 'Enter Food',
              ),
            ),
            const SizedBox(height: 50),
            const Text('Amount'),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter Amount',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _recordDiet,
              child: const Text('Log Food'),
            ),
            const Divider(),
            const Text('Food Logs'),
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: dietData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(dietData[index].diet),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Amount: ${dietData[index].amount}'),
                        Text('Date and Time: ${dietData[index].timestamp.toString()}'),
                      ],
                    ),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteDiet(dietData[index]),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () async {
                            final newAmount = await showDialog<int>(
                              context: context,
                              builder: (context) {
                                final controller = TextEditingController();
                                return AlertDialog(
                                  title: const Text('Enter new amount'),
                                  content: TextField(
                                    controller: controller,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter Amount',
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: const Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop(int.parse(controller.text));
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                            if (newAmount != null) {
                              _updateDiet(dietData[index], newAmount);
                            }
                          },
                        ),
                      ]
                    )
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _foodController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
