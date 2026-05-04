import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'signin_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedCategory;
  final List<String> _categories = [
    'School Friend',
    'College Friend',
    'Coaching Friend',
    'Varsity Friend',
    'Elakar vai brother'
  ];

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> _signUp() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
      return;
    }
    try {
      // 1. Create account with email and password
      // Firebase automatically logs in the user upon successful account creation
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // 2. User is now logged in. Save extra info to Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': _nameController.text.trim(),
        'nickname': _nicknameController.text.trim(),
        'email': _emailController.text.trim(),
        'phone': _phoneController.text.trim(),
        'category': _selectedCategory,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Account Created and Logged In!")));
        // Navigate to your main app screen here
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF4338CA)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Muhib's Den", style: TextStyle(color: Color(0xFF4338CA), fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Text("Create Account", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF0B1C30))),
              const SizedBox(height: 8),
              const Text("Start your journey at Muhib's Den", style: TextStyle(color: Color(0xFF464554))),
              const SizedBox(height: 32),
              
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: const Color(0xFFC7C4D7)),
                ),
                child: Column(
                  children: [
                    _buildTextField("Full Name", Icons.person_outline, _nameController, "Enter your name"),
                    const SizedBox(height: 16),
                    _buildTextField("Nickname", Icons.badge_outlined, _nicknameController, "Enter your nickname"),
                    const SizedBox(height: 16),
                    _buildTextField("Email Address", Icons.mail_outline, _emailController, "you@example.com"),
                    const SizedBox(height: 16),
                    _buildTextField("Phone Number", Icons.phone_outlined, _phoneController, "01XXXXXXXXX"),
                    const SizedBox(height: 16),
                    _buildDropdown(),
                    const SizedBox(height: 16),
                    _buildTextField("Password", Icons.lock_outline, _passwordController, "••••••••", obscure: true),
                    const SizedBox(height: 16),
                    _buildTextField("Confirm Password", Icons.lock_outline, _confirmPasswordController, "••••••••", obscure: true),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _signUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4338CA),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("Create Account", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInScreen())),
                    child: const Text("Sign in", style: TextStyle(color: Color(0xFF006A61), fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, TextEditingController controller, String hint, {bool obscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF464554))),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: const Color(0xFF777586)),
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFC7C4D7))),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Category", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF464554))),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedCategory,
          hint: const Text("Select category"),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFC7C4D7))),
          ),
          items: _categories.map((category) => DropdownMenuItem(value: category, child: Text(category))).toList(),
          onChanged: (value) => setState(() => _selectedCategory = value),
        ),
      ],
    );
  }
}
