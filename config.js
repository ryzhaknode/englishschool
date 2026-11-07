// Налаштування бази даних Supabase.
// Візьми ці два значення в Supabase: Project Settings → API (або Data API).
// anon / publishable key можна тримати в публічному коді: доступ до даних захищають правила RLS з schema.sql.
// Поки поля порожні, застосунок працює і зберігає прогрес лише на пристрої.
window.SCHOOL_CONFIG = {
  SUPABASE_URL: "",       // наприклад "https://abcdefghijkl.supabase.co"
  SUPABASE_ANON_KEY: ""   // довгий ключ "anon public" або "publishable"
};
