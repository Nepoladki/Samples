------------------------------codes-------------------------------
-- Table: public.codes

-- DROP TABLE IF EXISTS public.codes;

CREATE TABLE IF NOT EXISTS public.codes
(
    id uuid NOT NULL,
    code_index text COLLATE pg_catalog."default" NOT NULL,
    code_name text COLLATE pg_catalog."default" NOT NULL,
    legacy_code_name text COLLATE pg_catalog."default",
    stock_level text COLLATE pg_catalog."default",
    note text COLLATE pg_catalog."default",
    type_id integer,
    layers integer,
    thickness real,
    CONSTRAINT pk_codes PRIMARY KEY (id),
    CONSTRAINT fk_codes_sample_types_type_id FOREIGN KEY (type_id)
        REFERENCES public.sample_types (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.codes
    OWNER to postgres;
-- Index: ix_codes_type_id

-- DROP INDEX IF EXISTS public.ix_codes_type_id;

CREATE INDEX IF NOT EXISTS ix_codes_type_id
    ON public.codes USING btree
    (type_id ASC NULLS LAST)
    TABLESPACE pg_default;


-----------------------------vaults----------------------------
-- Table: public.vaults

-- DROP TABLE IF EXISTS public.vaults;

CREATE TABLE IF NOT EXISTS public.vaults
(
    id uuid NOT NULL,
    vault_name text COLLATE pg_catalog."default" NOT NULL,
    note text COLLATE pg_catalog."default",
    CONSTRAINT pk_vaults PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.vaults
    OWNER to postgres;

-----------------------------codes_vaults-------------------------
-- Table: public.codes_vaults

-- DROP TABLE IF EXISTS public.codes_vaults;

CREATE TABLE IF NOT EXISTS public.codes_vaults
(
    id uuid NOT NULL,
    code_id uuid NOT NULL,
    vault_id uuid NOT NULL,
    CONSTRAINT pk_codes_vaults PRIMARY KEY (id),
    CONSTRAINT fk_codes_vaults_codes_code_id FOREIGN KEY (code_id)
        REFERENCES public.codes (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_codes_vaults_vaults_vault_id FOREIGN KEY (vault_id)
        REFERENCES public.vaults (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.codes_vaults
    OWNER to postgres;
-- Index: ix_codes_vaults_code_id

-- DROP INDEX IF EXISTS public.ix_codes_vaults_code_id;

CREATE INDEX IF NOT EXISTS ix_codes_vaults_code_id
    ON public.codes_vaults USING btree
    (code_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: ix_codes_vaults_vault_id

-- DROP INDEX IF EXISTS public.ix_codes_vaults_vault_id;

CREATE INDEX IF NOT EXISTS ix_codes_vaults_vault_id
    ON public.codes_vaults USING btree
    (vault_id ASC NULLS LAST)
    TABLESPACE pg_default;
--------------------------------sample_types---------------------------
-- Table: public.sample_types

-- DROP TABLE IF EXISTS public.sample_types;

CREATE TABLE IF NOT EXISTS public.sample_types
(
    id integer NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    type_name text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_sample_types PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.sample_types
    OWNER to postgres;
-------------------------------users--------------------------------
-- Table: public.users

-- DROP TABLE IF EXISTS public.users;

CREATE TABLE IF NOT EXISTS public.users
(
    id uuid NOT NULL,
    user_name text COLLATE pg_catalog."default" NOT NULL,
    hashed_password text COLLATE pg_catalog."default" NOT NULL,
    role text COLLATE pg_catalog."default" NOT NULL,
    is_active boolean NOT NULL,
    refresh_token text COLLATE pg_catalog."default",
    refresh_expires timestamp with time zone,
    CONSTRAINT pk_users PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.users
    OWNER to postgres;
