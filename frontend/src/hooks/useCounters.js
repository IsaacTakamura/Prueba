import { useState, useEffect } from "react";
import { getSiteCounters } from "../services/countersService";
import { useSupabaseClient } from "./useSupabaseClient";

export function useCounters() {
  const { getClient } = useSupabaseClient();
  const [counters, setCounters] = useState({
    appliedTechnologies: 0,
    proofConcepts: 0,
    successStories: 0
  });
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const loadCounters = async () => {
      try {
        const supabase = await getClient();
        const data = await getSiteCounters(supabase);

        if (data) {
          setCounters(data);
        }
      } catch (error) {
        console.error('Error cargando contadores:', error);
      } finally {
        setLoading(false);
      }
    };

    loadCounters();
  }, []);

  return { counters, loading };
}