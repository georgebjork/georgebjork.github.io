import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'API.dart';

const supabaseUrl = 'https://mhsfovjzepjqkknljjdm.supabase.co';
const supabaseAnnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYzOTI4OTE3MiwiZXhwIjoxOTU0ODY1MTcyfQ.VEzKvk0LK3l0lzyguMRWYF7Wt22t6PKbLQAmq04WVQU';

final supabase = Supabase.instance.client;

final Api service = Api();

extension ShowSnackBar on BuildContext {
  void showSnackBar({
    required String message,
    Color backgroundColor = Colors.white,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    ));
    
  }

  void showErrorSnackBar({required String message}) {
    showSnackBar(message: message, backgroundColor: Colors.red);
  }
}