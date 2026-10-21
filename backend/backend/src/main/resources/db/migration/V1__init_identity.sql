-- =========================================================
-- V1: Identity domain
-- Household, User, FamilyMember
-- =========================================================

CREATE TABLE households (
    id              BIGINT AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(100)    NOT NULL,
    timezone        VARCHAR(50)     NOT NULL DEFAULT 'Asia/Kolkata',
    created_at      DATETIME(6)     NOT NULL,
    updated_at      DATETIME(6),
    created_by      BIGINT,
    updated_by      BIGINT,
    deleted_at      DATETIME(6),
    UNIQUE KEY uk_households_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE users (
    id              BIGINT AUTO_INCREMENT PRIMARY KEY,
    household_id    BIGINT          NOT NULL,
    username        VARCHAR(50)     NOT NULL,
    email           VARCHAR(150)    NOT NULL,
    password_hash   VARCHAR(100)    NOT NULL,
    full_name       VARCHAR(100)    NOT NULL,
    role            VARCHAR(20)     NOT NULL,
    active          BOOLEAN         NOT NULL DEFAULT TRUE,
    last_login_at   DATETIME(6),
    created_at      DATETIME(6)     NOT NULL,
    updated_at      DATETIME(6),
    created_by      BIGINT,
    updated_by      BIGINT,
    deleted_at      DATETIME(6),
    UNIQUE KEY uk_users_username (username),
    UNIQUE KEY uk_users_email (email),
    KEY idx_users_household (household_id),
    CONSTRAINT fk_users_household FOREIGN KEY (household_id) REFERENCES households (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE family_members (
    id                BIGINT AUTO_INCREMENT PRIMARY KEY,
    household_id      BIGINT          NOT NULL,
    full_name         VARCHAR(100)    NOT NULL,
    nickname          VARCHAR(50),
    date_of_birth     DATE,
    gender            VARCHAR(20),
    blood_group       VARCHAR(10),
    relation          VARCHAR(30)     NOT NULL,
    photo_url         VARCHAR(500),
    emergency_contact VARCHAR(200),
    notes             TEXT,
    created_at        DATETIME(6)     NOT NULL,
    updated_at        DATETIME(6),
    created_by        BIGINT,
    updated_by        BIGINT,
    deleted_at        DATETIME(6),
    KEY idx_fm_household (household_id),
    KEY idx_fm_relation (relation),
    CONSTRAINT fk_fm_household FOREIGN KEY (household_id) REFERENCES households (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;