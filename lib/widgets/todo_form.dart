import 'package:flutter/material.dart';

import '../screens/home_page.dart';

class TodoForm extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final Category selectedCategory;
  final Priority selectedPriority;
  final ValueChanged<Category?> onCategoryChanged;
  final ValueChanged<Priority?> onPriorityChanged;
  final VoidCallback onSave;

  const TodoForm({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.selectedCategory,
    required this.selectedPriority,
    required this.onCategoryChanged,
    required this.onPriorityChanged,
    required this.onSave,
  });

  @override
  TodoFormState createState() => TodoFormState();
}

class TodoFormState extends State<TodoForm> {
  bool _isDescriptionVisible = false; 

  // Toggle description visibility
  void _toggleDescriptionVisibility() {
    setState(() {
      _isDescriptionVisible = !_isDescriptionVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Add New Todo',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),

        // Title TextField
        TextField(
          controller: widget.titleController,
          decoration: InputDecoration(
            labelText: 'Todo Title',
            hintText: 'Enter the title',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIcon: IconButton(
              onPressed: _toggleDescriptionVisibility,
              icon: Icon(
                _isDescriptionVisible
                    ? Icons.remove_circle_outline
                    : Icons.add_circle_outline,
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Description TextField (toggle visibility)
        if (_isDescriptionVisible)
          TextField(
            controller: widget.descriptionController,
            decoration: InputDecoration(
              labelText: 'Todo Description',
              hintText: 'Enter the description',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            maxLines: 3, // Adjust the number of lines
          ),

        const SizedBox(height: 16),

        // Category and Priority Dropdowns
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<Category>(
                value: widget.selectedCategory,
                onChanged: widget.onCategoryChanged,
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: Category.values.map<DropdownMenuItem<Category>>(
                      (Category category) {
                    return DropdownMenuItem<Category>(
                      value: category,
                      child: Text(category.toString().split('.').last),
                    );
                  },
                ).toList(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DropdownButtonFormField<Priority>(
                value: widget.selectedPriority,
                onChanged: widget.onPriorityChanged,
                decoration: InputDecoration(
                  labelText: 'Priority',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: Priority.values.map<DropdownMenuItem<Priority>>(
                      (Priority priority) {
                    return DropdownMenuItem<Priority>(
                      value: priority,
                      child: Text(priority.toString().split('.').last),
                    );
                  },
                ).toList(),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Add button
        SizedBox(
          width: double.infinity, // Full width button
          child: ElevatedButton(
            onPressed: widget.onSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent, // Button color
              padding: const EdgeInsets.symmetric(vertical: 16), // Button height
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
            ),
            child: const Text(
              'Add Todo',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        const SizedBox(height: 16), // Space below the button
      ],
    );
  }
}
