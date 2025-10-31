/*
======================================================================
 PARTE 2: EL "DATA MART" (Capa de Presentación / Vistas)
======================================================================
*/

-- Vista para Tecnologías (la versión más actual de cada una)
CREATE VIEW DM_Current_Technologies AS
WITH LatestVersion AS (
    SELECT
        s.*,
        ROW_NUMBER() OVER(PARTITION BY s.HK_Technology ORDER BY s.Load_Date DESC) as rn
    FROM
        SAT_Technology_Details s
)
SELECT
    h.BK_Technology_UUID AS technology_id,
    lv.name_technology,
    lv.description_technology,
    lv.isActive
FROM
    HUB_Technology h
JOIN
    LatestVersion lv ON h.HK_Technology = lv.HK_Technology
WHERE
    lv.rn = 1;


-- Vista para Pruebas de Concepto (la versión más actual de cada una)
CREATE VIEW DM_Current_Proof_Concepts AS
WITH LatestVersion AS (
    SELECT
        s.*,
        ROW_NUMBER() OVER(PARTITION BY s.HK_Proof_Concept ORDER BY s.Load_Date DESC) as rn
    FROM
        SAT_Proof_Concept_Details s
)
SELECT
    h.BK_Proof_Concept_UUID AS proof_concept_id,
    lv.name_proof,
    lv.summary_proof,
    lv.counter,
    lv.isActive
FROM
    HUB_Proof_Concept h
JOIN
    LatestVersion lv ON h.HK_Proof_Concept = lv.HK_Proof_Concept
WHERE
    lv.rn = 1;


-- Vista para Casos de Éxito (la versión más actual de cada una)
CREATE VIEW DM_Current_Success_Stories AS
WITH LatestCore AS (
    SELECT
        s.*,
        ROW_NUMBER() OVER(PARTITION BY s.HK_Success_Story ORDER BY s.Load_Date DESC) as rn
    FROM
        SAT_Success_Story_Core s
),
LatestContent AS (
    SELECT
        s.*,
        ROW_NUMBER() OVER(PARTITION BY s.HK_Success_Story ORDER BY s.Load_Date DESC) as rn
    FROM
        SAT_Success_Story_Content s
)
SELECT
    h.BK_Success_Story_UUID AS success_story_id,
    core.name_success_text,
    core.summary_success,
    core.link_success_story,
    content.challenges_text,
    content.solution_intro_text,
    content.solution_items,
    content.results_items,
    content.results_comment,
    core.isActive
FROM
    HUB_Success_Story h
LEFT JOIN -- Usamos LEFT JOIN por si un satélite tiene datos y el otro aún no
    LatestCore core ON h.HK_Success_Story = core.HK_Success_Story AND core.rn = 1
LEFT JOIN
    LatestContent content ON h.HK_Success_Story = content.HK_Success_Story AND content.rn = 1;


-- Vista para tus Contadores (lee de las otras vistas)
CREATE VIEW DM_Site_Counters AS
SELECT
    (SELECT COUNT(*) FROM DM_Current_Technologies WHERE isActive = true) AS applied_technologies_count,
    (SELECT COUNT(*) FROM DM_Current_Proof_Concepts WHERE isActive = true) AS proof_concepts_count,
    (SELECT COUNT(*) FROM DM_Current_Success_Stories WHERE isActive = true) AS success_stories_count;

