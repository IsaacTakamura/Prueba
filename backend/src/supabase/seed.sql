-- Archivo: supabase/seed.sql
-- Contiene el ejemplo original del usuario más los 5 ejemplos adicionales (total 6 sets).
-- TODOS los UUIDs y las fechas han sido validados para evitar errores.

-- \echo '--- INSERTANDO 6 EJEMPLOS DE SEED DATA VALIDADO ---'


-- =============================================
-- EJEMPLO 1: Original del Usuario (Data Vault y PostgreSQL)
-- =============================================

/* --- 1. HUBS --- */
INSERT INTO HUB_Technology (HK_Technology, BK_Technology_UUID, Record_Source) VALUES
('HK_TECH_1234', 'a1a1a1a1-b2b2-c3c3-d4d4-e5e5e5e5e5e5', 'SEED_ORIGINAL'),
('HK_TECH_5678', 'f6f6f6f6-a7a7-b8b8-c9c9-d0d0d0d0d0d0', 'SEED_ORIGINAL'); -- UUID CORREGIDO

INSERT INTO HUB_Proof_Concept (HK_Proof_Concept, BK_Proof_Concept_UUID, Record_Source) VALUES
('HK_POC_A', '11111111-2222-3333-4444-555555555555', 'SEED_ORIGINAL');

INSERT INTO HUB_Success_Story (HK_Success_Story, BK_Success_Story_UUID, Record_Source) VALUES
('HK_STORY_X', 'aaaaaaa1-bbbb-cccc-dddd-eeeeeeeeeeee', 'SEED_ORIGINAL');


/* --- 2. SATELLITES (Detalles iniciales) --- */
INSERT INTO SAT_Technology_Details (HK_Technology, name_technology, description_technology, isActive, Record_Source) VALUES
('HK_TECH_1234', 'Data Vault 2.0', 'Metodología para modelado de datos en un DWH, ideal para agilidad.', true, 'SEED_ORIGINAL'),
('HK_TECH_5678', 'PostgreSQL', 'Base de datos relacional robusta y Open Source.', true, 'SEED_ORIGINAL');

INSERT INTO SAT_Proof_Concept_Details (HK_Proof_Concept, name_proof, summary_proof, counter, isActive, Record_Source) VALUES
('HK_POC_A', 'Migración a Supabase', 'Demostración de la migración de un DWH a la plataforma Supabase.', 15, true, 'SEED_ORIGINAL');

INSERT INTO SAT_Success_Story_Core (HK_Success_Story, name_success_text, summary_success, link_success_story, isActive, Record_Source) VALUES
('HK_STORY_X', 'Implementación de Hybrid Data Vault', 'Logramos implementar una arquitectura de Data Vault Híbrida en 3 meses.', 'https://misite.com/story-x', true, 'SEED_ORIGINAL');

INSERT INTO SAT_Success_Story_Content (HK_Success_Story, challenges_text, solution_intro_text, solution_items, results_items, Record_Source) VALUES
('HK_STORY_X', 'La principal dificultad fue la gestión del historial de datos.', 'La solución fue usar la estructura HUB-LINK-SAT.', '["Usar MD5 para HK","Definir Business Keys"]'::jsonb, '{"KPI1": "50% mejora", "KPI2": "Reducción de latencia"}'::jsonb, 'SEED_ORIGINAL');


/* --- 3. LINKS (Relaciones) --- */
INSERT INTO LINK_Technology_POC (HK_Link_Technology_POC, HK_Technology, HK_Proof_Concept, Record_Source) VALUES
('HK_LINK_T1_P1', 'HK_TECH_1234', 'HK_POC_A', 'SEED_ORIGINAL');

INSERT INTO LINK_Technology_Story (HK_Link_Technology_Story, HK_Technology, HK_Success_Story, Record_Source) VALUES
('HK_LINK_T1_S1', 'HK_TECH_1234', 'HK_STORY_X', 'SEED_ORIGINAL'),
('HK_LINK_T2_S1', 'HK_TECH_5678', 'HK_STORY_X', 'SEED_ORIGINAL');


-- =============================================
-- EJEMPLO 2: Tecnología enfocada en Cloud (AWS Redshift)
-- =============================================

INSERT INTO HUB_Technology (HK_Technology, BK_Technology_UUID, Record_Source) VALUES
('HK_TECH_CLOUD', '1b1b1b1b-2c2c-3d3d-4e4e-5f5f5f5f5f5f', 'SEED_CLOUD');

INSERT INTO SAT_Technology_Details (HK_Technology, name_technology, description_technology, isActive, Record_Source) VALUES
('HK_TECH_CLOUD', 'AWS Redshift', 'Data Warehouse en la nube de AWS, ideal para análisis escalable.', true, 'SEED_CLOUD');

INSERT INTO HUB_Proof_Concept (HK_Proof_Concept, BK_Proof_Concept_UUID, Record_Source) VALUES
('HK_POC_B', '22222222-3333-4444-5555-666666666666', 'SEED_CLOUD');

INSERT INTO SAT_Proof_Concept_Details (HK_Proof_Concept, name_proof, summary_proof, counter, isActive, Record_Source) VALUES
('HK_POC_B', 'Benchmarking Redshift vs Postgres', 'Comparativa de rendimiento entre Redshift y la base de datos local.', 50, true, 'SEED_CLOUD');

INSERT INTO LINK_Technology_POC (HK_Link_Technology_POC, HK_Technology, HK_Proof_Concept, Record_Source) VALUES
('HK_LINK_T3_P2', 'HK_TECH_CLOUD', 'HK_POC_B', 'SEED_CLOUD');


-- =============================================
-- EJEMPLO 3: Una Historia de Éxito Antigua (Inactiva)
-- =============================================

INSERT INTO HUB_Success_Story (HK_Success_Story, BK_Success_Story_UUID, Record_Source) VALUES
('HK_STORY_Y', 'bbbbbbb2-cccc-dddd-eeee-ffffffffffff', 'SEED_INACTIVO'); -- UUID CORREGIDO

INSERT INTO SAT_Success_Story_Core (HK_Success_Story, name_success_text, summary_success, link_success_story, isActive, Record_Source) VALUES
('HK_STORY_Y', 'ETL Tradicional a DV', 'Migración exitosa de un proceso ETL complejo a la arquitectura Data Vault.', NULL, false, 'SEED_INACTIVO');

INSERT INTO SAT_Success_Story_Content (HK_Success_Story, challenges_text, solution_intro_text, solution_items, results_items, Record_Source) VALUES
('HK_STORY_Y', 'La lentitud en la carga diaria de datos era un cuello de botella.', 'Se implementó un proceso de carga incremental moderno.', '["Uso de Staging Area", "Eliminación de Joins complejos"]'::jsonb, '{"Ahorro": "10% de costos operativos"}'::jsonb, 'SEED_INACTIVO');


-- =============================================
-- EJEMPLO 4: Spark y Múltiples Links
-- =============================================

INSERT INTO HUB_Technology (HK_Technology, BK_Technology_UUID, Record_Source) VALUES
('HK_TECH_SPARK', 'a1b2c3d4-e5f6-a7b8-c9d0-e1f2a3b4c5d6', 'SEED_MULTI'); -- UUID CORREGIDO

INSERT INTO SAT_Technology_Details (HK_Technology, name_technology, description_technology, isActive, Record_Source) VALUES
('HK_TECH_SPARK', 'Apache Spark', 'Plataforma unificada para el procesamiento de datos a gran escala y Big Data.', true, 'SEED_MULTI');

INSERT INTO HUB_Proof_Concept (HK_Proof_Concept, BK_Proof_Concept_UUID, Record_Source) VALUES
('HK_POC_C', '33333333-4444-5555-6666-777777777777', 'SEED_MULTI');

INSERT INTO SAT_Proof_Concept_Details (HK_Proof_Concept, name_proof, summary_proof, counter, isActive, Record_Source) VALUES
('HK_POC_C', 'Despliegue de Spark en Kubernetes', 'Prueba de concepto para orquestar cargas de trabajo de Big Data con Spark.', 5, true, 'SEED_MULTI');

INSERT INTO LINK_Technology_POC (HK_Link_Technology_POC, HK_Technology, HK_Proof_Concept, Record_Source) VALUES
('HK_LINK_T4_P3', 'HK_TECH_SPARK', 'HK_POC_C', 'SEED_MULTI');

INSERT INTO LINK_Technology_Story (HK_Link_Technology_Story, HK_Technology, HK_Success_Story, Record_Source) VALUES
('HK_LINK_T4_S2', 'HK_TECH_SPARK', 'HK_STORY_Y', 'SEED_MULTI');

INSERT INTO LINK_POC_Success_Story (HK_Link_POC_Story, HK_Proof_Concept, HK_Success_Story, Record_Source) VALUES
('HK_LINK_P3_S2', 'HK_POC_C', 'HK_STORY_Y', 'SEED_MULTI');


-- =============================================
-- EJEMPLO 5 & 6: PoC de Alto Interés (SCD Tipo 2)
-- =============================================

INSERT INTO HUB_Proof_Concept (HK_Proof_Concept, BK_Proof_Concept_UUID, Record_Source) VALUES
('HK_POC_D', '44444444-5555-6666-7777-888888888888', 'SEED_CONTADOR');

-- Primer registro (SCD 1)
INSERT INTO SAT_Proof_Concept_Details (HK_Proof_Concept, name_proof, summary_proof, counter, isActive, Record_Source) VALUES
('HK_POC_D', 'Integración de IA en Datavault', 'Prueba de concepto para usar modelos de IA en la capa de presentación del DV.', 1000, true, 'SEED_CONTADOR');

-- Segundo registro (SCD 2 - Actualización)
-- La clave Load_Date debe ser diferente.
INSERT INTO SAT_Proof_Concept_Details (HK_Proof_Concept, Load_Date, name_proof, summary_proof, counter, isActive, Record_Source) VALUES
('HK_POC_D', NOW() + INTERVAL '1 second', 'Integración de IA en Datavault (Actualizado)', '¡Hemos duplicado el contador! Se ha visto mucho interés.', 2000, true, 'SEED_ACTUALIZACION');