import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:oops_list/models/task_model.dart';
import 'package:oops_list/providers/task_providers.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.redAccent,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text.trim();
      final description = _descriptionController.text.trim();

      final newTask = TaskModel(
        id: DateTime.now().millisecondsSinceEpoch,
        title: title,
        description: description,
        date: _selectedDate,
        isCompleted: false,
        createdAt: DateTime.now(),
      );

      Provider.of<TaskProviders>(context, listen: false).addTask(newTask);

      // Show sarcastic success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Task added! Will you actually do it? 🤔'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Add Task',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Sarcastic header
              Text(
                "Another task to ignore? 😏",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Let's pretend you'll complete this one.",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 30),

              // Title Field
              TextFormField(
                controller: _titleController,
                style: TextStyle(color: theme.colorScheme.onSurface),
                decoration: InputDecoration(
                  labelText: 'Task Title',
                  hintText: 'What are you avoiding today?',
                  prefixIcon: const Icon(Icons.title, color: Colors.redAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: isDark ? Colors.grey[850] : Colors.grey[100],
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.redAccent,
                      width: 2,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Come on, at least give it a title!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Description Field
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                style: TextStyle(color: theme.colorScheme.onSurface),
                decoration: InputDecoration(
                  labelText: 'Description (Optional)',
                  hintText: 'Details you\'ll probably forget...',
                  prefixIcon: const Icon(
                    Icons.description,
                    color: Colors.redAccent,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: isDark ? Colors.grey[850] : Colors.grey[100],
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.redAccent,
                      width: 2,
                    ),
                  ),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 20),

              // Date Picker
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[850] : Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: theme.colorScheme.outline.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.redAccent),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Due Date',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(
                                0.6,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            DateFormat(
                              'EEEE, MMMM dd, yyyy',
                            ).format(_selectedDate),
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () => _selectDate(context),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.redAccent.withOpacity(0.1),
                        foregroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Change'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Save Button
              ElevatedButton(
                onPressed: _saveTask,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.check_circle_outline, size: 24),
                    SizedBox(width: 8),
                    Text(
                      'Save Task',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Cancel Button
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  side: const BorderSide(color: Colors.redAccent),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
