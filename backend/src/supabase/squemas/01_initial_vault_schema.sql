-- Archivo de Esquema: 01_initial_vault_schema.sql
-- Define la estructura completa del Data Vault Híbrido y el Data Mart.

BEGIN;

/*
======================================================================
 PARTE 1: EL "RAW DATA VAULT" (Capa de Almacenamiento e Historial)
======================================================================
*/

/* --- 1.A. HUBS (Las "Cosas") --- */

CREATE TABLE HUB_Technology (
    HK_Technology VARCHAR(32) PRIMARY KEY, -- Hash MD5 de BK_Technology_UUID
    BK_Technology_UUID UUID NOT NULL UNIQUE, -- Tu ID de negocio original
    Load_Date TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    Record_Source VARCHAR(100) NOT NULL
);

CREATE TABLE HUB_Proof_Concept (
    HK_Proof_Concept VARCHAR(32) PRIMARY KEY, -- Hash MD5 de BK_Proof_Concept_UUID
    BK_Proof_Concept_UUID UUID NOT NULL UNIQUE, -- Tu ID de negocio original
    Load_Date TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    Record_Source VARCHAR(100) NOT NULL
);

CREATE TABLE HUB_Success_Story (
    HK_Success_Story VARCHAR(32) PRIMARY KEY, -- Hash MD5 de BK_Success_Story_UUID
    BK_Success_Story_UUID UUID NOT NULL UNIQUE, -- Tu ID de negocio original
    Load_Date TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    Record_Source VARCHAR(100) NOT NULL
);

/* --- 1.B. LINKS (Las "Relaciones") --- */

CREATE TABLE LINK_Technology_POC (
    HK_Link_Technology_POC VARCHAR(32) PRIMARY KEY, -- Hash de (HK_Technology, HK_Proof_Concept)
    HK_Technology VARCHAR(32) NOT NULL,
    HK_Proof_Concept VARCHAR(32) NOT NULL,
    Load_Date TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    Record_Source VARCHAR(100) NOT NULL,
    FOREIGN KEY (HK_Technology) REFERENCES HUB_Technology(HK_Technology),
    FOREIGN KEY (HK_Proof_Concept) REFERENCES HUB_Proof_Concept(HK_Proof_Concept)
);

CREATE TABLE LINK_Technology_Story (
    HK_Link_Technology_Story VARCHAR(32) PRIMARY KEY, -- Hash de (HK_Technology, HK_Success_Story)
    HK_Technology VARCHAR(32) NOT NULL,
    HK_Success_Story VARCHAR(32) NOT NULL,
    Load_Date TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    Record_Source VARCHAR(100) NOT NULL,
    FOREIGN KEY (HK_Technology) REFERENCES HUB_Technology(HK_Technology),
    FOREIGN KEY (HK_Success_Story) REFERENCES HUB_Success_Story(HK_Success_Story)
);

CREATE TABLE LINK_POC_Success_Story (
    HK_Link_POC_Story VARCHAR(32) PRIMARY KEY, -- Hash de (HK_Proof_Concept, HK_Success_Story)
    HK_Proof_Concept VARCHAR(32) NOT NULL,
    HK_Success_Story VARCHAR(32) NOT NULL,
    Load_Date TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    Record_Source VARCHAR(100) NOT NULL,
    FOREIGN KEY (HK_Proof_Concept) REFERENCES HUB_Proof_Concept(HK_Proof_Concept),
    FOREIGN KEY (HK_Success_Story) REFERENCES HUB_Success_Story(HK_Success_Story)
);

/* --- 1.C. SATELLITES (Los "Detalles" que cambian) --- */

CREATE TABLE SAT_Technology_Details (
    HK_Technology VARCHAR(32) NOT NULL,
    Load_Date TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    name_technology VARCHAR(255) NOT NULL,
    description_technology TEXT,
    isActive BOOLEAN NOT NULL DEFAULT true,
    Record_Source VARCHAR(100) NOT NULL,
    PRIMARY KEY (HK_Technology, Load_Date), -- Clave compuesta
    FOREIGN KEY (HK_Technology) REFERENCES HUB_Technology(HK_Technology)
);

CREATE TABLE SAT_Proof_Concept_Details (
    HK_Proof_Concept VARCHAR(32) NOT NULL,
    Load_Date TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    name_proof VARCHAR(255) NOT NULL,
    summary_proof TEXT,
    counter INTEGER NOT NULL DEFAULT 0,
    isActive BOOLEAN,
    Record_Source VARCHAR(100) NOT NULL,
    PRIMARY KEY (HK_Proof_Concept, Load_Date),
    FOREIGN KEY (HK_Proof_Concept) REFERENCES HUB_Proof_Concept(HK_Proof_Concept)
);

CREATE TABLE SAT_Success_Story_Core (
    HK_Success_Story VARCHAR(32) NOT NULL,
    Load_Date TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    name_success_text VARCHAR(255) NOT NULL,
    summary_success TEXT,
    link_success_story TEXT,
    isActive BOOLEAN,
    Record_Source VARCHAR(100) NOT NULL,
    PRIMARY KEY (HK_Success_Story, Load_Date),
    FOREIGN KEY (HK_Success_Story) REFERENCES HUB_Success_Story(HK_Success_Story)
);

CREATE TABLE SAT_Success_Story_Content (
    HK_Success_Story VARCHAR(32) NOT NULL,
    Load_Date TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    challenges_text TEXT NOT NULL,
    solution_intro_text TEXT,
    solution_items JSONB,
    results_items JSONB,
    results_comment TEXT,
    Record_Source VARCHAR(100) NOT NULL,
    PRIMARY KEY (HK_Success_Story, Load_Date),
    FOREIGN KEY (HK_Success_Story) REFERENCES HUB_Success_Story(HK_Success_Story)
);


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


COMMIT;