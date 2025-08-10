import 'package:flutter/material.dart';
import 'schedule_visit_screen.dart';
import '../widgets/section_header.dart';
import '../widgets/info_tip.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  int _starRating = 0;
  bool _isGoodExperience = false;
  bool _isNeedsImprovement = false;
  final TextEditingController _commentsController = TextEditingController();
  final TextEditingController _suggestionsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rate Your Experience & Provide Feedback'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SectionHeader(icon: Icons.star_border, title: 'Rating the Purchase Experience'),
            const SizedBox(height: 15),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      'How was your crop sale experience today?',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.lightGreen.shade800,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            index < _starRating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 35,
                          ),
                          onPressed: () {
                            setState(() {
                              _starRating = index + 1;
                            });
                          },
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _ThumbButton(
                          icon: Icons.thumb_up,
                          label: 'Good',
                          isSelected: _isGoodExperience,
                          onTap: () {
                            setState(() {
                              _isGoodExperience = !_isGoodExperience;
                              if (_isGoodExperience) _isNeedsImprovement = false;
                            });
                          },
                        ),
                        _ThumbButton(
                          icon: Icons.thumb_down,
                          label: 'Needs Improvement',
                          isSelected: _isNeedsImprovement,
                          onTap: () {
                            setState(() {
                              _isNeedsImprovement = !_isNeedsImprovement;
                              if (_isNeedsImprovement) _isGoodExperience = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            const SectionHeader(icon: Icons.comment, title: 'Share Your Comments'),
            const SizedBox(height: 15),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your feedback helps us improve! Let us know how we can serve you better.',
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _commentsController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Type your feedback here...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.mic, color: Colors.grey.shade600),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Voice input (Mock)')),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            const SectionHeader(icon: Icons.lightbulb_outline, title: 'Suggestion Box for Quality'),
            const SizedBox(height: 15),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How do you think we can help you improve the quality of your crops next time? Any tips or tools needed?',
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _suggestionsController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Share your suggestions here...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Feedback Submitted (Mock)')),
                      );
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.send),
                    label: const Text('Submit Feedback'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const ScheduleVisitScreen()));
                    },
                    icon: const Icon(Icons.event_note),
                    label: const Text('Request Next Visit'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const InfoTip(
              icon: Icons.lightbulb_outline,
              text: 'Help us improve! Receive ₹100 on your next sale for submitting feedback!',
              color: Color(0xFFFFF9C4),
              iconColor: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}

class _ThumbButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThumbButton({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected ? Colors.lightGreen.shade100 : Colors.grey.shade100,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Colors.lightGreen : Colors.grey.shade300,
                width: 2,
              ),
            ),
            child: Icon(
              icon,
              size: 30,
              color: isSelected ? Colors.lightGreen : Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.lightGreen : Colors.grey.shade700,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
