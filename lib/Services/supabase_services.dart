import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseServices {
  final SupabaseClient supabase = Supabase.instance.client;

  // INSERT
  Future<dynamic> insert(String name, int age) async {
    try {
      final response = await supabase
          .from('students')
          .insert({
            'name': name,
            'age': age,
          });
      return response;
    } catch (error) {
      throw Exception("Insert Error: $error");
    }
  }

  // READ
  Future<List<dynamic>> getData() async {
    try {
      final response = await supabase
          .from('students')
          .select()
          .order('created_at', ascending: false);
      return response;
    } catch (error) {
      throw Exception("Read Error: $error");
    }
  }

  // UPDATE
  Future<dynamic> update(String id, String name, int age) async {
    try {
      final response = await supabase
          .from('students')
          .update({
            'name': name,
            'age': age,
          })
          .eq('id', id)
          .select()
          .single();
      return response;
    } catch (error) {
      throw Exception("Update Error: $error");
    }
  }

  // DELETE
  Future<dynamic> delete(String id) async {
    try {
      final response = await supabase
          .from('students')
          .delete()
          .eq('id', id);
      return response;
    } catch (error) {
      throw Exception("Delete Error: $error");
    }
  }
}
