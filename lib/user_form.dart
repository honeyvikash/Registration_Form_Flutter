import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserFormScreen extends StatefulWidget {
  const UserFormScreen({super.key});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final aadhaarController = TextEditingController();
  final panController = TextEditingController();
  final dobController = TextEditingController();

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  InputDecoration _customInputDecoration({
    required String label,
    required IconData icon,
    String? hint,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.deepPurple),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
      ),
      filled: true,
      fillColor: Colors.grey.shade50,
    );
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Form Submitted Successfully!"),
          backgroundColor: Colors.green.shade700,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Oops! Invalid Entry, Please resolve the marked issues."),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Registration Form", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          // autovalidateMode: AutovalidateMode.onUserInteraction, 
          child: Column(
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      // NAME
                      TextFormField(
                        controller: nameController,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))],
                        decoration: _customInputDecoration(label: "Full Name", icon: Icons.person),
                        validator: (v) => (v == null || v.isEmpty) ? "Name is Required" : null,
                        // validator: (value) {
                        // if (value == null || value.isEmpty) {
                        //   return "Name is required";
                        // }
                        autovalidateMode: AutovalidateMode.onUserInteraction, 
                      ),
                      const SizedBox(height: 16),

                      // NUMBER
                      TextFormField(
                        controller: numberController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
                        decoration: _customInputDecoration(label: "Phone Number", icon: Icons.phone, hint: "10-digit number"),
                        validator: (v) => (v?.length != 10) ? "Enter 10 digits" : null,
                        autovalidateMode: AutovalidateMode.onUserInteraction, 
                      ),
                      const SizedBox(height: 16),

                      // EMAIL
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: _customInputDecoration(label: "Email Address", icon: Icons.email),
                        validator: (v) => !RegExp(r'\S+@\S+\.\S+').hasMatch(v ?? "") ? "Invalid email" : null,
                        autovalidateMode: AutovalidateMode.onUserInteraction, 
                      ),
                      const SizedBox(height: 16),

                      // ADDRESS
                      TextFormField(
                        controller: addressController,
                        maxLines: 2,
                        decoration: _customInputDecoration(label: "Home Address", icon: Icons.home),
                        validator: (v) => (v == null || v.isEmpty) ? "Required" : null,
                        autovalidateMode: AutovalidateMode.onUserInteraction, 
                      ),
                      const SizedBox(height: 16),

                      // AADHAAR
                      TextFormField(
                        controller: aadhaarController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(12)],
                        decoration: _customInputDecoration(label: "Aadhaar Number", icon: Icons.fingerprint),
                        validator: (v) => (v?.length != 12) ? "Enter 12 digits" : null,
                        autovalidateMode: AutovalidateMode.onUserInteraction, 
                      ),
                      const SizedBox(height: 16),

                      // PAN
                      TextFormField(
                        controller: panController,
                        textCapitalization: TextCapitalization.characters,
                        inputFormatters: [LengthLimitingTextInputFormatter(10)],
                        decoration: _customInputDecoration(label: "PAN Card", icon: Icons.credit_card),
                        onChanged: (val) => panController.value = panController.value.copyWith(text: val.toUpperCase()),
                        validator: (v) => !RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(v ?? "") ? "Invalid PAN" : null,
                        autovalidateMode: AutovalidateMode.onUserInteraction, 
                      ),
                      const SizedBox(height: 16),

                      // DOB
                      TextFormField(
                        controller: dobController,
                        readOnly: true,
                        onTap: _selectDate,
                        decoration: _customInputDecoration(label: "Date of Birth", icon: Icons.calendar_month),
                        validator: (v) => (v == null || v.isEmpty) ? "Required" : null,
                        autovalidateMode: AutovalidateMode.onUserInteraction, 
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              
              // SUBMIT BUTTON
              SizedBox(
                width: double.infinity,
                height: 55,
                child: FilledButton.icon(
                  onPressed: submitForm,
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text("SUBMIT PROFILE", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}