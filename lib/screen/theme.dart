import 'package:flutter/material.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Theme preview"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text("bodyLarge", style: Theme.of(context).textTheme.bodyLarge),
              Text("bodyMedium", style: Theme.of(context).textTheme.bodyMedium),
              Text("bodySmall", style: Theme.of(context).textTheme.bodySmall),
              Text("displayLarge",
                  style: Theme.of(context).textTheme.displayLarge),
              Text("displayMedium",
                  style: Theme.of(context).textTheme.displayMedium),
              Text("displaySmall",
                  style: Theme.of(context).textTheme.displaySmall),
              Text("headlineLarge",
                  style: Theme.of(context).textTheme.headlineLarge),
              Text("headlineMedium",
                  style: Theme.of(context).textTheme.headlineMedium),
              Text("headlineSmall",
                  style: Theme.of(context).textTheme.headlineSmall),
              Text("labelLarge", style: Theme.of(context).textTheme.labelLarge),
              Text("labelMedium",
                  style: Theme.of(context).textTheme.labelMedium),
              Text("labelSmall", style: Theme.of(context).textTheme.labelSmall),
              Text("titleLarge - AppBar",
                  style: Theme.of(context).textTheme.titleLarge),
              Text("titleMedium",
                  style: Theme.of(context).textTheme.titleMedium),
              Text("titleSmall", style: Theme.of(context).textTheme.titleSmall),
              FilledButton(onPressed: () {}, child: Text("filledButton")),
              ElevatedButton(onPressed: () {}, child: Text("elevatedButton")),
              TextButton(onPressed: () {}, child: Text("textButton")),
              IconButton(onPressed: () {}, icon: Icon(Icons.abc)),
              Switch(value: true, onChanged: (v) {}),
              // Shortcut(icon: Icons.abc, text: "Hi",)
            ],
          ),
        ),
      ),
    );
  }
}
