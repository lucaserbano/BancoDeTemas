/* =============================================
   SUPABASE.JS — Inicialização do cliente
   =============================================

   INSTRUÇÕES:
   1. Acesse seu projeto em supabase.com
   2. Vá em Settings → API
   3. Copie "Project URL" e cole abaixo
   4. Copie "anon public" key e cole abaixo
   ============================================= */

const sb = supabase.createClient(
  'https://iwaoinijfjxvqawbzciv.supabase.co',   // ex: https://abcxyzabc.supabase.co
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml3YW9pbmlqZmp4dnFhd2J6Y2l2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzM2NjAwOTQsImV4cCI6MjA4OTIzNjA5NH0.nkSN31iTQU8AoffMqXr5j_l0spSJu_9i6LfNvk3SF28'       // ex: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
);
