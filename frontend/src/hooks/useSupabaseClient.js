import { createClient } from '@supabase/supabase-js';
import { useAuth } from '@clerk/clerk-react';

export function useSupabaseClient() {
  const { getToken } = useAuth();

  const getClient = async () => {
    const supabase = createClient(
      import.meta.env.VITE_SUPABASE_URL,
      import.meta.env.VITE_SUPABASE_ANON_KEY
    );

    try {
      // Obtener el token JWT de Clerk si el usuario está autenticado
      const token = await getToken({ template: 'supabase' });
      
      // Si hay token, configurar el cliente de Supabase con él
      if (token) {
        supabase.auth.setSession({
          access_token: token,
          refresh_token: '',
        });
      }
    } catch (error) {
      console.log('Usuario no autenticado, usando acceso anónimo');
    }

    return supabase;
  };

  return { getClient };
}