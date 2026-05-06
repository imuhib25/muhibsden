import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GroupInfoScreen extends StatelessWidget {
  const GroupInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF4338CA)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Group Info", style: TextStyle(color: Color(0xFF4338CA), fontWeight: FontWeight.bold)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final members = snapshot.data!.docs;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Group Avatar & Title
                Center(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 60,
                        backgroundColor: Color(0xFF4338CA),
                        child: Icon(Icons.group, size: 60, color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      const Text("Muhib's Den", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      Text("${members.length} Members", style: const TextStyle(color: Color(0xFF777586))),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Members Section
                const Text("MEMBERS", style: TextStyle(color: Color(0xFF777586), fontWeight: FontWeight.bold, fontSize: 12)),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: members.length,
                    separatorBuilder: (context, index) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final data = members[index].data() as Map<String, dynamic>;
                      return ListTile(
                        leading: CircleAvatar(child: Text(data['name'][0])),
                        title: Text(data['name']),
                        subtitle: Text(data['category'] ?? 'Member'),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // About Section
                const Text("ABOUT", style: TextStyle(color: Color(0xFF777586), fontWeight: FontWeight.bold, fontSize: 12)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
                  child: const Text(
                    "A dedicated space for the Friday night crew to coordinate meetups, share memes, and plan our next big adventure. Keep it friendly, keep it wild! 🚀",
                    style: TextStyle(color: Color(0xFF464554)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
