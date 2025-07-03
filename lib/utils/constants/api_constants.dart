class ApiConstants{
  static const String baseUrl = "https://crpfcilljvmbentfeijy.supabase.co";
  static const String apiKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNycGZjaWxsanZtYmVudGZlaWp5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTAyMjY5NzUsImV4cCI6MjA2NTgwMjk3NX0.WQJfE4E2hTXx3zsuzFjU4x-rU_mzdcQmBEeQK3ZiOfE";
  static const String registerApi = "/auth/v1/signup";
  static const String loginApi = "/auth/v1/token?grant_type=password";
  static const String taskApi = "/rest/v1/task?select=*";
  static const String deleteApi = "/rest/v1/task?id=eq.";
  static const String createApi = "/rest/v1/task";
  static const String updateApi = "/rest/v1/task?id=eq.";
  static const String refreshTokenApi = "/auth/v1/token?grant_type=refresh_token";
}