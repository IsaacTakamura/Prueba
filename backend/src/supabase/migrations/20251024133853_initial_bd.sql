-- Archivo de Esquema: 01_initial_vault_schema.sql
-- Define la estructura completa del Data Vault Híbrido y el Data Mart.

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


