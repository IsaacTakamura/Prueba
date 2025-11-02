/**
 * Obtiene los contadores desde la vista DM_Site_Counters de Supabase
 * @param {Object} supabaseClient - Cliente de Supabase autenticado
 * @returns {Promise<Object>} Objeto con los contadores o null si hay error
 */
export const getSiteCounters = async (supabaseClient) => {
  try {
    const { data, error } = await supabaseClient
      .from('dm_site_counters')
      .select('*')
      .single(); // .single() porque solo hay una fila en esta vista

    if (error) {
      console.error('Error al obtener contadores:', error);
      return null;
    }

    return {
      appliedTechnologies: data?.applied_technologies_count || 0,
      proofConcepts: data?.proof_concepts_count || 0,
      successStories: data?.success_stories_count || 0
    };
  } catch (error) {
    console.error('Error en getSiteCounters:', error);
    return null;
  }
};