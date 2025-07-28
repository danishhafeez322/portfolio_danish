import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_danish/utils/app_strings.dart';
import 'package:portfolio_danish/widgets/custom_textfield.dart';
import 'package:portfolio_danish/utils/app_theme.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    final formData = {
      'name': nameController.text,
      'email': emailController.text,
      'subject': subjectController.text,
      'timestamp': Timestamp.now(),
    };

    try {
      // Save to Firebase Firestore
      await FirebaseFirestore.instance.collection('contact_form').add(formData);

      // Send email notification
      sendEmail(
        nameController.text,
        emailController.text,
        subjectController.text,
      ); // Show success Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Your response has been recorded!"),
          backgroundColor: Colors.green,
        ),
      );

      // Clear form fields
      nameController.clear();
      emailController.clear();
      subjectController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error submitting form: $e"),
          backgroundColor: Colors.red,
        ),
      );
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text("Fill it out:", style: textTheme.titleMedium),
          const SizedBox(height: 10),
          CustomTextField(
            hintText: 'Your Name',
            controller: nameController,
            validator: (value) => value == null || value.isEmpty
                ? 'Please enter your name'
                : null,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            hintText: 'Email',
            controller: emailController,
            validator: (value) =>
                value == null || value.isEmpty ? 'Please enter email' : null,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            hintText: 'Subject & Description',
            controller: subjectController,
            maxLines: 4,
            validator: (value) =>
                value == null || value.isEmpty ? 'Please enter subject' : null,
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 200,
            child: OutlinedButton(
              onPressed: _submitForm,
              style: OutlinedButton.styleFrom(
                backgroundColor: PortfolioAppTheme.nameColor,
                side: const BorderSide(color: PortfolioAppTheme.nameColor),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
              ),
              child: Text(
                'Submit',
                style: textTheme.titleSmall!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void sendEmail(String name, String email, String subject) async {
  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      "service_id": AppStrings.serviceId,
      "template_id": AppStrings.templateId,
      "user_id": AppStrings.publicKey,
      "template_params": {
        "to_name": "Danish Hafeez",
        "from_name": name,
        "from_email": email,
        "message": subject,
      }
    }),
  );

  if (response.statusCode == 200) {
    print("Email sent successfully!");
  } else {
    print("Failed to send email: ${response.body}");
  }
}
