import 'package:flutter/material.dart';
import 'package:post_management/models/post.dart';
import 'package:post_management/providers/post_provider.dart';
import 'package:post_management/utils/enum/api_status.dart';
import 'package:post_management/utils/mixins/form_validation_mixin.dart';
import 'package:post_management/widget/post_form.dart';
import 'package:post_management/widget/unsaved_changes_dialog.dart';
import 'package:provider/provider.dart';

class PostFormScreen extends StatefulWidget {
  final Post? post;

  const PostFormScreen({super.key, this.post});

  @override
  _PostFormScreenState createState() => _PostFormScreenState();
}

class _PostFormScreenState extends State<PostFormScreen> with FormValidationMixin {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _bodyController;
  final FocusNode _titleFocus = FocusNode();
  final FocusNode _bodyFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.post?.title ?? '');
    _bodyController = TextEditingController(text: widget.post?.body ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    _titleFocus.dispose();
    _bodyFocus.dispose();
    super.dispose();
  }

  bool get _hasUnsavedChanges {
    return _titleController.text != (widget.post?.title ?? '') || _bodyController.text != (widget.post?.body ?? '');
  }

  Future<bool> _onWillPop() async {
    if (!_hasUnsavedChanges) return true;
    return (await showDialog<bool>(
          context: context,
          builder: (context) => const UnsavedChangesDialog(),
        )) ??
        false;
  }

  Future<void> _savePost() async {
    if (_formKey.currentState!.validate()) {
      final postProvider = Provider.of<PostProvider>(context, listen: false);

      if (widget.post == null) {
        await postProvider.addPost(_titleController.text, _bodyController.text);
        if (postProvider.addStatus == ApiStatus.success) {
          Navigator.pop(context);
        }
      } else {
        await postProvider.updatePost(widget.post!.id, _titleController.text, _bodyController.text);
        if (postProvider.updateStatus == ApiStatus.success) {
          Navigator.pop(context);
        }
      }
    }
  }

  void _resetForm() {
    _titleController.text = widget.post?.title ?? '';
    _bodyController.text = widget.post?.body ?? '';
    _formKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text(
            widget.post == null ? 'Add Post' : 'Edit Post',
            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () async {
              if (await _onWillPop()) Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: PostFormWidget(
            formKey: _formKey,
            isLoading: widget.post == null ? postProvider.addStatus == ApiStatus.loading : postProvider.updateStatus == ApiStatus.loading,
            errorMessage: widget.post == null ? postProvider.addError : postProvider.updateError,
            titleController: _titleController,
            bodyController: _bodyController,
            titleFocus: _titleFocus,
            bodyFocus: _bodyFocus,
            onSave: _savePost,
            onReset: _resetForm,
            validateTitle: validateTitle,
            validateDescription: validateDescription,
            inputDecoration: inputDecoration,
          ),
        ),
      ),
    );
  }
}
