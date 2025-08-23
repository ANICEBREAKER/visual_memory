import 'package:flutter/material.dart';
import 'package:game_testing/screens/visual_memory/visual_memory_result_screen.dart';

class VisualMemoryGameScreen extends StatefulWidget {
  const VisualMemoryGameScreen({super.key, required this.difficulty});

  final String difficulty;

  @override
  State<VisualMemoryGameScreen> createState() => _VisualMemoryGameScreenState();
}

class _VisualMemoryGameScreenState extends State<VisualMemoryGameScreen> {
  int levels = 0;
  int lives = 0;

  @override
  void initState() {
    super.initState();
    lives = widget.difficulty == "Easy"
        ? 3
        : widget.difficulty == "Medium"
            ? 2
            : 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text("Levels: $levels",
                      style: Theme.of(context).textTheme.labelSmall),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                      lives == 3
                          ? "Lives: 🖤🖤🖤"
                          : lives == 2
                              ? "Lives: 🖤🖤🤍"
                              : "Lives: 🖤🤍🤍",
                      style: Theme.of(context).textTheme.labelSmall),
                ),
              ],
            ),
            SizedBox(height: 7.5),
            SingleChildScrollView(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = 4;
                  int itemCount = 16;
                  int rowCount = (itemCount / crossAxisCount).ceil();

                  double horizontalPadding = 30.0;
                  double gridSpacing = 7.5;
                  double gridPadding = 10.0;

                  // Calculate available width for the grid
                  double availableWidth = constraints.maxWidth -
                      2 * horizontalPadding -
                      2 * gridPadding -
                      (crossAxisCount - 1) * gridSpacing;
                  double squareSize = availableWidth / crossAxisCount;

                  // Calculate the grid's total height to fit all rows
                  double gridHeight = squareSize * rowCount + (rowCount - 1) * gridSpacing;

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: gridPadding,
                    ),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: gridSpacing,
                        mainAxisSpacing: gridSpacing,
                        childAspectRatio: 1, // Always square
                        mainAxisExtent: squareSize, // Fixed height for each item
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              'Item $index',
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                            ),
                          ),
                        );
                      },
                      itemCount: itemCount,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 7.5),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VisualMemoryResultScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  backgroundColor: Colors.orangeAccent),
              child: Text(
                'Quit',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
