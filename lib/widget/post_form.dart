import 'package:flutter/material.dart';

class PostFormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController bodyController;
  final bool isLoading;
  final String errorMessage;
  final FocusNode titleFocus;
  final FocusNode bodyFocus;
  final VoidCallback onSave;
  final VoidCallback onReset;
  final String? Function(String?) validateTitle;
  final String? Function(String?) validateDescription;
  final InputDecoration Function(String) inputDecoration;

  const PostFormWidget({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.bodyController,
    required this.isLoading,
    required this.errorMessage,
    required this.titleFocus,
    required this.bodyFocus,
    required this.onSave,
    required this.onReset,
    required this.validateTitle,
    required this.validateDescription,
    required this.inputDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: titleController,
            focusNode: titleFocus,
            decoration: inputDecoration('Title'),
            validator: validateTitle,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: bodyController,
            focusNode: bodyFocus,
            decoration: inputDecoration('Description'),
            maxLines: 5,
            validator: validateDescription,
          ),
          const SizedBox(height: 20),
          Center(
            child: isLoading ? CircularProgressIndicator() : SizedBox(),
          ),
          Center(
            child: Text(
              errorMessage,
              style: TextStyle(color: Colors.red),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: onSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Save', style: TextStyle(color: Colors.white)),
                ),
              ),
              ElevatedButton(
                onPressed: onReset,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.blueAccent, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Reset', style: TextStyle(color: Colors.blueAccent)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
