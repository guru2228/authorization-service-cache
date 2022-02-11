
CREATE domain IF NOT EXISTS jsonb AS other;
CREATE TABLE IF NOT EXISTS USER_TBL
(
	user_id              VARCHAR(250) NOT NULL,
	creat_dttm           TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	creat_user_id        VARCHAR(250) NULL,
	chg_dttm             TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	chg_user_id          VARCHAR(250) NULL,
	updt_ver_nbr         INTEGER NULL DEFAULT 0,
	creat_sys_ref_id     INTEGER NULL,
	chg_sys_ref_id       INTEGER NULL,
	lst_nm               VARCHAR(80) NOT NULL,
	fst_nm               VARCHAR(50) NOT NULL,
	user_sts_ref_id      INTEGER NOT NULL,
	email_id             VARCHAR(250) NOT NULL,
	alt_user_id          VARCHAR(250) NOT NULL,
	idp_typ_ref_id       INTEGER NOT NULL,
	user_desc            JSON NULL,
	phot_lobj            BYTEA NULL,
	user_atr_list        JSONB NOT NULL,
	mgr_user_id          VARCHAR(250) NULL,
	CONSTRAINT USER_TBL_PK PRIMARY KEY (user_id),
	CONSTRAINT USER_TBL_USER_TBL_f6bc FOREIGN KEY (mgr_user_id) REFERENCES USER_TBL (user_id)
);

CREATE TABLE IF NOT EXISTS USER_SGNON
(
	user_id              VARCHAR(250) NOT NULL,
	lst_sgnon_dttm       TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	user_ipadr_txt       VARCHAR(45) NULL,
	CONSTRAINT USER_SGNON_PK PRIMARY KEY (user_id),
	CONSTRAINT USER_SGNON_USER_TBL_97f0 FOREIGN KEY (user_id) REFERENCES USER_TBL (user_id)
);

CREATE INDEX IF NOT EXISTS USER_SGNON_IE1 ON USER_SGNON
(
	lst_sgnon_dttm ASC
);

CREATE TABLE IF NOT EXISTS FUNC_ROLE
(
	func_role_nm         VARCHAR(100) NOT NULL,
	creat_dttm           TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	creat_user_id        VARCHAR(250) NULL,
	chg_dttm             TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	chg_user_id          VARCHAR(250) NULL,
	updt_ver_nbr         INTEGER NULL DEFAULT 0,
	creat_sys_ref_id     INTEGER NULL,
	chg_sys_ref_id       INTEGER NULL,
	func_role_desc       JSON NULL,
	func_role_typ_ref_id INTEGER NULL,
	mng_func_role_nm     VARCHAR(100) NULL,
	CONSTRAINT FUNC_ROLE_PK PRIMARY KEY (func_role_nm),
	CONSTRAINT FUNC_ROLE_FUNC_ROLE_277d FOREIGN KEY (mng_func_role_nm) REFERENCES FUNC_ROLE (func_role_nm)
);

CREATE TABLE IF NOT EXISTS CLI_ORG
(
	cli_org_id           VARCHAR(10) NOT NULL,
	creat_dttm           TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	creat_user_id        VARCHAR(250) NULL,
	chg_dttm             TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	chg_user_id          VARCHAR(250) NULL,
	updt_ver_nbr         INTEGER NULL DEFAULT 0,
	creat_sys_ref_id     INTEGER NULL,
	chg_sys_ref_id       INTEGER NULL,
	inac_ind             SMALLINT NULL DEFAULT 0 CHECK ( inac_ind IN (0, 1) ),
	org_nm               VARCHAR(80) NULL,
	cli_desc             JSON NULL,
	cli_atr_list         JSONB NULL,
	CONSTRAINT CLI_ORG_PK PRIMARY KEY (cli_org_id)
);

CREATE TABLE IF NOT EXISTS USER_CLI_FUNC_ROLE
(
	user_id              VARCHAR(250) NOT NULL,
	cli_org_id           VARCHAR(10) NOT NULL,
	func_role_nm         VARCHAR(100) NOT NULL,
	creat_dttm           TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	creat_user_id        VARCHAR(250) NULL,
	chg_dttm             TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	chg_user_id          VARCHAR(250) NULL,
	updt_ver_nbr         INTEGER NULL DEFAULT 0,
	creat_sys_ref_id     INTEGER NULL,
	chg_sys_ref_id       INTEGER NULL,
	strt_dt              DATE NOT NULL,
	end_dt               DATE NULL,
	CONSTRAINT USER_CLI_FUNC_ROLE_PK PRIMARY KEY (user_id,cli_org_id,func_role_nm),
	CONSTRAINT USER_CLI_FUNC_ROLE_FUNC_ROLE_5ccb FOREIGN KEY (func_role_nm) REFERENCES FUNC_ROLE (func_role_nm),
	CONSTRAINT USER_CLI_FUNC_ROLE_USER_TBL_7a99 FOREIGN KEY (user_id) REFERENCES USER_TBL (user_id),
	CONSTRAINT USER_CLI_FUNC_ROLE_CLI_ORG_2dc1 FOREIGN KEY (cli_org_id) REFERENCES CLI_ORG (cli_org_id)
);

CREATE TABLE IF NOT EXISTS APPL
(
	appl_nm              VARCHAR(100) NOT NULL,
	creat_dttm           TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	creat_user_id        VARCHAR(250) NULL,
	chg_dttm             TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	chg_user_id          VARCHAR(250) NULL,
	updt_ver_nbr         INTEGER NULL DEFAULT 0,
	creat_sys_ref_id     INTEGER NULL,
	chg_sys_ref_id       INTEGER NULL,
	inac_ind             SMALLINT NULL DEFAULT 0 CHECK ( inac_ind IN (0, 1) ),
	appl_desc            JSON NULL,
	bpm_ind              SMALLINT NULL,
	CONSTRAINT APPL_PK PRIMARY KEY (appl_nm)
);

CREATE TABLE IF NOT EXISTS APPL_WIDGET
(
	appl_nm              VARCHAR(100) NOT NULL,
	widget_nm            VARCHAR(100) NOT NULL,
	creat_dttm           TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	creat_user_id        VARCHAR(250) NULL,
	chg_dttm             TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	chg_user_id          VARCHAR(250) NULL,
	updt_ver_nbr         INTEGER NULL DEFAULT 0,
	creat_sys_ref_id     INTEGER NULL,
	chg_sys_ref_id       INTEGER NULL,
	inac_ind             SMALLINT NULL DEFAULT 0 CHECK ( inac_ind IN (0, 1) ),
	widget_desc          JSON NULL,
	CONSTRAINT APPL_WIDGET_PK PRIMARY KEY (appl_nm,widget_nm),
	CONSTRAINT APPL_WIDGET_APPL_12e8 FOREIGN KEY (appl_nm) REFERENCES APPL (appl_nm)
);

CREATE TABLE IF NOT EXISTS APPL_VER
(
	appl_nm              VARCHAR(100) NOT NULL,
	appl_ver_id          VARCHAR(20) NOT NULL,
	creat_dttm           TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	creat_user_id        VARCHAR(250) NULL,
	chg_dttm             TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	chg_user_id          VARCHAR(250) NULL,
	updt_ver_nbr         INTEGER NULL DEFAULT 0,
	creat_sys_ref_id     INTEGER NULL,
	chg_sys_ref_id       INTEGER NULL,
	inac_ind             SMALLINT NULL DEFAULT 0 CHECK ( inac_ind IN (0, 1) ),
	appl_endpt_url       VARCHAR(250) NOT NULL,
	appl_ver_desc        JSON NULL,
	bas_mnu_url          VARCHAR(250) NOT NULL,
	appl_ver_sts_ref_id  INTEGER NULL,
	bus_jstfy_desc       JSON NULL,
	CONSTRAINT APPL_VER_PK PRIMARY KEY (appl_nm,appl_ver_id),
	CONSTRAINT APPL_VER_APPL_d3da FOREIGN KEY (appl_nm) REFERENCES APPL (appl_nm)
);

CREATE TABLE IF NOT EXISTS CLI_FUNC_ROLE_APPL
(
	cli_org_id           VARCHAR(10) NOT NULL,
	func_role_nm         VARCHAR(100) NOT NULL,
	appl_nm              VARCHAR(100) NOT NULL,
	creat_dttm           TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	creat_user_id        VARCHAR(250) NULL,
	chg_dttm             TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	chg_user_id          VARCHAR(250) NULL,
	updt_ver_nbr         INTEGER NULL DEFAULT 0,
	creat_sys_ref_id     INTEGER NULL,
	chg_sys_ref_id       INTEGER NULL,
	appl_ver_id          VARCHAR(20) NOT NULL,
	appl_endpt_url       VARCHAR(250) NOT NULL,
	bas_mnu_url          VARCHAR(250) NOT NULL,
	strt_dt              DATE NOT NULL,
	end_dt               DATE NULL,
	cli_func_role_appl_sts_ref_id INTEGER NULL,
	bus_jstfy_desc       JSON NULL,
	bpm_ind              SMALLINT NULL,
	cli_func_role_appl_als_nm VARCHAR(100) NULL,
	cli_func_role_appl_desc VARCHAR(300) NULL,
	prmis_role_nm        VARCHAR(300) NOT NULL,
	CONSTRAINT CLI_FUNC_ROLE_APPL_PK PRIMARY KEY (cli_org_id,func_role_nm,appl_nm),
	CONSTRAINT CLI_FUNC_ROLE_APPL_APPL_VER_be2e FOREIGN KEY (appl_nm, appl_ver_id) REFERENCES APPL_VER (appl_nm, appl_ver_id),
	CONSTRAINT CLI_FUNC_ROLE_APPL_APPL_8fec FOREIGN KEY (appl_nm) REFERENCES APPL (appl_nm),
	CONSTRAINT CLI_FUNC_ROLE_APPL_CLI_ORG_6f57 FOREIGN KEY (cli_org_id) REFERENCES CLI_ORG (cli_org_id),
	CONSTRAINT CLI_FUNC_ROLE_APPL_FUNC_ROLE_7985 FOREIGN KEY (func_role_nm) REFERENCES FUNC_ROLE (func_role_nm)
);

CREATE TABLE IF NOT EXISTS CLI_FUNC_ROLE
(
	cli_org_id           VARCHAR(10) NOT NULL,
	func_role_nm         VARCHAR(100) NOT NULL,
	creat_dttm           TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	creat_user_id        VARCHAR(250) NULL,
	chg_dttm             TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	chg_user_id          VARCHAR(250) NULL,
	updt_ver_nbr         INTEGER NULL DEFAULT 0,
	creat_sys_ref_id     INTEGER NULL,
	chg_sys_ref_id       INTEGER NULL,
	strt_dt              DATE NOT NULL,
	end_dt               DATE NULL,
	bpm_ind              SMALLINT NULL,
	cli_func_role_als_nm VARCHAR(100) NULL,
	cli_func_role_desc VARCHAR(300) NULL,
	CONSTRAINT CLI_FUNC_ROLE_PK PRIMARY KEY (cli_org_id,func_role_nm),
	CONSTRAINT CLI_FUNC_ROLE_CLI_ORG_6f57 FOREIGN KEY (cli_org_id) REFERENCES CLI_ORG (cli_org_id),
	CONSTRAINT CLI_FUNC_ROLE_FUNC_ROLE_7985 FOREIGN KEY (func_role_nm) REFERENCES FUNC_ROLE (func_role_nm)
);

CREATE TABLE IF NOT EXISTS UI_SET
(
	ui_set_id            SERIAL NOT NULL,
	creat_dttm           TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	creat_user_id        VARCHAR(250) NULL,
	chg_dttm             TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	chg_user_id          VARCHAR(250) NULL,
	updt_ver_nbr         INTEGER NULL DEFAULT 0,
	creat_sys_ref_id     INTEGER NULL,
	chg_sys_ref_id       INTEGER NULL,
	widget_nm            VARCHAR(100) NOT NULL,
	appl_nm              VARCHAR(100) NOT NULL,
	ui_set_nm            VARCHAR(200) NOT NULL,
	ui_set_dtl           JSONB NOT NULL,
	func_role_nm         VARCHAR(100) NULL,
	pvt_set_user_id      VARCHAR(250) NULL,
	pvt_pref_ind         SMALLINT NULL,
	cli_org_id           VARCHAR(10) NULL,
	CONSTRAINT UI_SET_PK PRIMARY KEY (ui_set_id),
	CONSTRAINT UI_SET_USER_TBL_dbd6 FOREIGN KEY (pvt_set_user_id) REFERENCES USER_TBL (user_id),
	CONSTRAINT UI_SET_APPL_WIDGET_3662 FOREIGN KEY (appl_nm, widget_nm) REFERENCES APPL_WIDGET (appl_nm, widget_nm),
	CONSTRAINT UI_SET_CLI_FUNC_ROLE_APPL_ad54 FOREIGN KEY (cli_org_id, func_role_nm, appl_nm) REFERENCES CLI_FUNC_ROLE_APPL (cli_org_id, func_role_nm, appl_nm)
);

CREATE INDEX IF NOT EXISTS UI_SET_IE1 ON UI_SET
(
	widget_nm ASC,
	appl_nm ASC
);

CREATE TABLE IF NOT EXISTS APPL_VER_PRMIS_ROLE
(
	appl_nm              VARCHAR(100) NOT NULL,
	appl_ver_id          VARCHAR(20) NOT NULL,
	prmis_role_nm        VARCHAR(300) NOT NULL,
	creat_dttm           TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	creat_user_id        VARCHAR(250) NULL,
	chg_dttm             TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	chg_user_id          VARCHAR(250) NULL,
	updt_ver_nbr         INTEGER NULL DEFAULT 0,
	creat_sys_ref_id     INTEGER NULL,
	chg_sys_ref_id       INTEGER NULL,
	CONSTRAINT APPL_VER_PRMIS_ROLE_PK PRIMARY KEY (appl_nm,appl_ver_id,prmis_role_nm),
	CONSTRAINT APPL_VER_PRMIS_ROLE_APPL_VER_c1ad FOREIGN KEY (appl_nm, appl_ver_id) REFERENCES APPL_VER (appl_nm, appl_ver_id)
);

CREATE TABLE IF NOT EXISTS USER_CLI_FUNC_ROLE_REQ
(
	user_cli_func_role_req_id SERIAL NOT NULL,
	creat_dttm           TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	creat_user_id        VARCHAR(250) NULL,
	chg_dttm             TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	chg_user_id          VARCHAR(250) NULL,
	updt_ver_nbr         INTEGER NULL DEFAULT 0,
	creat_sys_ref_id     INTEGER NULL,
	chg_sys_ref_id       INTEGER NULL,
	user_id              VARCHAR(250) NOT NULL,
	cli_org_id           VARCHAR(10) NOT NULL,
	func_role_nm         VARCHAR(100) NOT NULL,
	bus_jstfy_desc       JSON NULL,
	user_cli_func_role_req_sts_ref_id INTEGER NOT NULL,
	req_aprv_dtl         JSONB NULL,
	user_atr_list        JSONB NULL,
	CONSTRAINT USER_CLI_FUNC_ROLE_REQ_PK PRIMARY KEY (user_cli_func_role_req_id),
	CONSTRAINT USER_CLI_FUNC_ROLE_REQ_FUNC_ROLE_39a6 FOREIGN KEY (func_role_nm) REFERENCES FUNC_ROLE (func_role_nm),
	CONSTRAINT USER_CLI_FUNC_ROLE_REQ_USER_TBL_5f84 FOREIGN KEY (user_id) REFERENCES USER_TBL (user_id),
	CONSTRAINT USER_CLI_FUNC_ROLE_REQ_CLI_ORG_c199 FOREIGN KEY (cli_org_id) REFERENCES CLI_ORG (cli_org_id)
);

CREATE INDEX IF NOT EXISTS USER_CLI_FUNC_ROLE_REQ_IE1 ON USER_CLI_FUNC_ROLE_REQ
(
	user_id ASC
);

CREATE INDEX IF NOT EXISTS USER_CLI_FUNC_ROLE_REQ_IE2 ON USER_CLI_FUNC_ROLE_REQ
(
	func_role_nm ASC
);

CREATE TABLE IF NOT EXISTS CLI_ORG_ADMIN
(
	cli_org_id           VARCHAR(10) NOT NULL,
	user_id              VARCHAR(250) NOT NULL,
	creat_dttm           TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	creat_user_id        VARCHAR(250) NULL,
	chg_dttm             TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	chg_user_id          VARCHAR(250) NULL,
	updt_ver_nbr         INTEGER NULL DEFAULT 0,
	creat_sys_ref_id     INTEGER NULL,
	chg_sys_ref_id       INTEGER NULL,
	inac_ind             SMALLINT NULL DEFAULT 0 CHECK ( inac_ind IN (0, 1) ),
	pri_admin_ind        SMALLINT NULL,
	CONSTRAINT CLI_ORG_ADMIN_PK PRIMARY KEY (cli_org_id,user_id),
	CONSTRAINT CLI_ORG_ADMIN_CLI_ORG_7cfc FOREIGN KEY (cli_org_id) REFERENCES CLI_ORG (cli_org_id),
	CONSTRAINT CLI_ORG_ADMIN_USER_TBL_732d FOREIGN KEY (user_id) REFERENCES USER_TBL (user_id)
);

CREATE TABLE IF NOT EXISTS APPL_OWNR
(
	appl_nm              VARCHAR(100) NOT NULL,
	user_id              VARCHAR(250) NOT NULL,
	creat_dttm           TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	creat_user_id        VARCHAR(250) NULL,
	chg_dttm             TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	chg_user_id          VARCHAR(250) NULL,
	updt_ver_nbr         INTEGER NULL DEFAULT 0,
	creat_sys_ref_id     INTEGER NULL,
	chg_sys_ref_id       INTEGER NULL,
	inac_ind             SMALLINT NULL DEFAULT 0 CHECK ( inac_ind IN (0, 1) ),
	CONSTRAINT APPL_OWNR_PK PRIMARY KEY (appl_nm,user_id),
	CONSTRAINT APPL_OWNR_USER_TBL_e11c FOREIGN KEY (user_id) REFERENCES USER_TBL (user_id),
	CONSTRAINT APPL_OWNR_APPL_b8e5 FOREIGN KEY (appl_nm) REFERENCES APPL (appl_nm)
);

ALTER TABLE APPL_VER
ADD COLUMN IF NOT EXISTS data_dom_list JSONB NULL;
UPDATE user_tbl SET updt_ver_nbr = 0 WHERE updt_ver_nbr IS NULL;
ALTER TABLE user_tbl 
    ALTER COLUMN updt_ver_nbr SET DEFAULT 0,
    ALTER COLUMN updt_ver_nbr SET NOT NULL;
ALTER TABLE CLI_FUNC_ROLE DROP COLUMN IF EXISTS bpm_ind;

ALTER TABLE CLI_FUNC_ROLE_APPL
ADD CONSTRAINT CLI_FUNC_ROLE_APPL_CLI_FUNC_ROLE_fa90 FOREIGN KEY (cli_org_id, func_role_nm) REFERENCES CLI_FUNC_ROLE (cli_org_id, func_role_nm);

ALTER TABLE USER_CLI_FUNC_ROLE
ADD CONSTRAINT USER_CLI_FUNC_ROLE_CLI_FUNC_ROLE_b184 FOREIGN KEY (cli_org_id, func_role_nm) REFERENCES CLI_FUNC_ROLE (cli_org_id, func_role_nm);

ALTER TABLE USER_CLI_FUNC_ROLE_REQ
ADD CONSTRAINT USER_CLI_FUNC_ROLE_REQ_CLI_FUNC_ROLE_80f9 FOREIGN KEY (cli_org_id, func_role_nm) REFERENCES CLI_FUNC_ROLE (cli_org_id, func_role_nm);
-- US3557199 - User and Role fuzzy search
-- Created from example here - https://hasura.io/docs/latest/graphql/core/databases/postgres/schema/custom-functions.html#example-fuzzy-match-search-functions

-- extension for gist
CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- gist indexes on original table fields that are searched in fuzzy search
CREATE INDEX IF NOT EXISTS IF NOT EXISTS USER_TBL_GIST1 ON USER_TBL USING GIST(lower(lst_nm) gist_trgm_ops, lower(fst_nm) gist_trgm_ops, lower(email_id) gist_trgm_ops);
CREATE INDEX IF NOT EXISTS IF NOT EXISTS CLI_ORG_GIST1 ON CLI_ORG USING GIST(lower(org_nm) gist_trgm_ops);
CREATE INDEX IF NOT EXISTS IF NOT EXISTS CLI_FUNC_ROLE_GIST1 ON CLI_FUNC_ROLE USING GIST(lower(cli_func_role_als_nm) gist_trgm_ops);
CREATE INDEX IF NOT EXISTS IF NOT EXISTS FUNC_ROLE_GIST1 ON FUNC_ROLE USING GIST(lower(func_role_nm) gist_trgm_ops);
-- indexes for json columns because gist only supports jsob
CREATE INDEX IF NOT EXISTS IF NOT EXISTS USER_TBL_EXPR_IDX1 ON USER_TBL (lower(user_desc->>'phone'));
CREATE INDEX IF NOT EXISTS IF NOT EXISTS FUNC_ROLE_EXPR_IDX1 ON FUNC_ROLE (lower(func_role_desc->>'name'));

-- UI uses a combination of the view and fuzzy search
-- View used because Hasura requires a defined table or view to be returned
-- none searchable fields are for identifying records later in workflow
-- create a view with all the fields
CREATE OR REPLACE VIEW public.v_search_users AS
SELECT
      user_tbl.user_id,
      user_tbl.lst_nm as user_lst_nm,
      user_tbl.fst_nm as user_fst_nm,
      user_tbl.email_id,
      user_tbl.user_desc,                           -- used for phone
      user_tbl.phot_lobj,                           -- not searchable
      mgr_user_tbl.fst_nm as mgr_user_fst_nm,
      mgr_user_tbl.lst_nm as mgr_user_lst_nm,
      cli_org.cli_org_id,                           -- not searchable
      cli_org.org_nm,
      cli_func_role.func_role_nm,                   -- not searchable
      cli_func_role.cli_func_role_als_nm,
      func_role.func_role_desc,
      user_cli_func_role.strt_dt as role_strt_dt,   -- not searchable
      user_cli_func_role.end_dt as role_end_dt      -- not searchable
FROM
    user_tbl user_tbl
    LEFT JOIN user_tbl mgr_user_tbl ON mgr_user_tbl.user_id = user_tbl.mgr_user_id
    JOIN user_cli_func_role user_cli_func_role on user_cli_func_role.user_id = user_tbl.user_id
    JOIN cli_org cli_org ON cli_org.cli_org_id = user_cli_func_role.cli_org_id
    JOIN cli_func_role cli_func_role ON cli_func_role.cli_org_id = user_cli_func_role.cli_org_id AND cli_func_role.func_role_nm = user_cli_func_role.func_role_nm
    JOIN func_role func_role ON func_role.func_role_nm = cli_func_role.func_role_nm;

-- fuzzy search on the v_search_users
CREATE OR REPLACE FUNCTION public.search_users_fuzzy(_search text) RETURNS SETOF v_search_users
    LANGUAGE sql STABLE AS $function$
SELECT * FROM
    v_search_users
WHERE
    CAST(user_lst_nm AS text) % _search
    OR CAST(user_fst_nm AS text) % _search
    OR CAST(email_id AS text) % _search
    OR CAST(user_desc->>'phone' AS text) % _search AND user_desc::text % _search             -- searches only user_desc.phone in json
    OR CAST(mgr_user_fst_nm AS text) % _search
    OR CAST(mgr_user_lst_nm AS text) % _search
    OR CAST(org_nm AS text) % _search
    OR CAST(cli_func_role_als_nm AS text) % _search
    OR CAST(func_role_desc->>'name' AS text) % _search AND func_role_desc::text % _search    -- searches only func_role_desc.name in json
ORDER BY
    similarity(_search, (user_lst_nm || ' ' || user_fst_nm || ' ' || email_id || ' ' || user_desc || ' ' || mgr_user_fst_nm || ' ' || mgr_user_lst_nm || ' ' || org_nm || ' ' || cli_func_role_als_nm || ' ' || func_role_desc) ) ASC
LIMIT 500;
$function$;

-- fuzzy search on the combination of cli_func_role and func_role returning cli_func_role
CREATE OR REPLACE FUNCTION public.search_roles_fuzzy(_search text) RETURNS SETOF cli_func_role
    LANGUAGE sql STABLE AS $function$
SELECT
      cli_func_role.cli_org_id,
      func_role.func_role_nm,                                                                                   -- searchable
      func_role.creat_dttm,
      cli_func_role.creat_user_id,
      cli_func_role.chg_dttm,
      cli_func_role.chg_user_id,
      cli_func_role.updt_ver_nbr,
      cli_func_role.creat_sys_ref_id,
      cli_func_role.chg_sys_ref_id,
      cli_func_role.strt_dt,
      cli_func_role.end_dt,
      COALESCE (cli_func_role.cli_func_role_als_nm, func_role.func_role_desc->>'name') as cli_func_role_als_nm, -- searchable
      cli_func_role.cli_func_role_desc
FROM
    func_role func_role
    LEFT JOIN cli_func_role cli_func_role ON cli_func_role.func_role_nm = func_role.func_role_nm
WHERE
    CAST(func_role.func_role_nm AS text) % _search
    OR CAST(cli_func_role.cli_func_role_als_nm AS text) % _search
    OR CAST(func_role.func_role_desc->>'name' AS text) % _search AND func_role.func_role_desc::text % _search    -- searches only func_role_desc.name in json
ORDER BY
    similarity(_search, (func_role.func_role_nm || ' ' || cli_func_role.cli_func_role_als_nm || ' ' || func_role.func_role_desc) ) ASC
LIMIT 500;
$function$;

CREATE TABLE IF NOT EXISTS CLI_ORG_GRP
(
	cli_grp_org_id       VARCHAR(10) NOT NULL,
	cli_org_id           VARCHAR(10) NOT NULL,
	creat_dttm           TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	creat_user_id        VARCHAR(250) NULL,
	chg_dttm             TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	chg_user_id          VARCHAR(250) NULL,
	updt_ver_nbr         INTEGER NULL DEFAULT 0,
	creat_sys_ref_id     INTEGER NULL,
	chg_sys_ref_id       INTEGER NULL,
	strt_dt              DATE NOT NULL,
	end_dt               DATE NULL,
	CONSTRAINT CLI_ORG_GRP_PK PRIMARY KEY (cli_grp_org_id,cli_org_id)
);

ALTER TABLE CLI_ORG_GRP
ADD CONSTRAINT CLI_ORG_GRP_CLI_ORG_7ec5 FOREIGN KEY (cli_org_id) REFERENCES CLI_ORG (cli_org_id);


ALTER TABLE CLI_ORG_GRP
ADD CONSTRAINT CLI_ORG_GRP_CLI_ORG_7a5f FOREIGN KEY (cli_grp_org_id) REFERENCES CLI_ORG (cli_org_id);

ALTER TABLE CLI_ORG
ADD COLUMN IF NOT EXISTS CLI_TYP_REF_ID INTEGER NULL;

CREATE TABLE IF NOT EXISTS CLI_APPL
(
	cli_org_id           VARCHAR(10) NOT NULL,
	appl_nm              VARCHAR(100) NOT NULL,
	creat_dttm           TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	creat_user_id        VARCHAR(250) NULL,
	chg_dttm             TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	chg_user_id          VARCHAR(250) NULL,
	updt_ver_nbr         INTEGER NULL DEFAULT 0,
	creat_sys_ref_id     INTEGER NULL,
	chg_sys_ref_id       INTEGER NULL,
	strt_dt              DATE NOT NULL,
	end_dt               DATE NULL,
	CONSTRAINT CLI_APPL_PK PRIMARY KEY (cli_org_id,appl_nm)
);

ALTER TABLE CLI_APPL
ADD CONSTRAINT CLI_APPL_CLI_ORG_eb2c FOREIGN KEY (cli_org_id) REFERENCES CLI_ORG (cli_org_id);

ALTER TABLE CLI_APPL
ADD CONSTRAINT CLI_APPL_APPL_a49f FOREIGN KEY (appl_nm) REFERENCES APPL (appl_nm);

INSERT INTO CLI_APPL(cli_org_id, appl_nm, strt_dt, creat_user_id)  (select a.cli_org_id, a.appl_nm, CURRENT_TIMESTAMP(3), 'SYSTEM'  from (select distinct cli_org_id, appl_nm from cli_func_role_appl order by cli_org_id) a);

ALTER TABLE CLI_FUNC_ROLE_APPL
ADD CONSTRAINT CLI_FUNC_ROLE_APPL_CLI_APPL_3c58 FOREIGN KEY (cli_org_id, appl_nm) REFERENCES CLI_APPL (cli_org_id, appl_nm);

-- updating with DISTINCT by user_id and cli_org_id to flatten user records into one record per client for client
-- IT Admin will query distinct cli_org_id, and show full_role_list and full_cli_list
-- Client Admin will query only by cli_org_id
-- role and client list to jsonb_agg to search and show list compatible with hasura
DROP FUNCTION IF EXISTS public.search_users_fuzzy(text), public.search_roles_fuzzy(text);
DROP VIEW IF EXISTS public.v_search_users;

CREATE OR REPLACE VIEW public.v_search_users AS
SELECT DISTINCT ON (user_tbl.user_id, cli_org.cli_org_id)
      user_tbl.user_id,
      user_tbl.lst_nm as user_lst_nm,
      user_tbl.fst_nm as user_fst_nm,
      user_tbl.email_id,
      user_tbl.user_desc,                           -- used for phone
      user_tbl.phot_lobj,                           -- not searchable
      mgr_user_tbl.fst_nm as mgr_user_fst_nm,
      mgr_user_tbl.lst_nm as mgr_user_lst_nm,
      cli_org.cli_org_id,                           -- not searchable
      cli_org.org_nm,
      cli_func_role.func_role_nm,                   -- not searchable
      cli_func_role.cli_func_role_als_nm,
      func_role.func_role_desc,
      (
          SELECT MIN(user_cli_func_role.strt_dt)
          FROM user_cli_func_role
          WHERE user_cli_func_role.user_id = user_tbl.user_id
      ) as role_strt_dt,                           -- not searchable
      (
          SELECT MAX(user_cli_func_role.end_dt)
          FROM user_cli_func_role
          WHERE user_cli_func_role.user_id = user_tbl.user_id
      ) as role_end_dt,                            -- not searchable
      (
          SELECT jsonb_agg(DISTINCT cli_func_role.cli_func_role_als_nm order by cli_func_role.cli_func_role_als_nm)
          FROM user_cli_func_role
          JOIN cli_func_role cli_func_role ON cli_func_role.cli_org_id = user_cli_func_role.cli_org_id AND cli_func_role.func_role_nm = user_cli_func_role.func_role_nm
          WHERE user_cli_func_role.user_id = user_tbl.user_id and cli_org.cli_org_id = user_cli_func_role.cli_org_id
      ) as cli_role_list,
      (
          SELECT jsonb_agg(DISTINCT cli_func_role.cli_func_role_als_nm order by cli_func_role.cli_func_role_als_nm)
          FROM user_cli_func_role
          JOIN cli_func_role cli_func_role ON cli_func_role.cli_org_id = user_cli_func_role.cli_org_id AND cli_func_role.func_role_nm = user_cli_func_role.func_role_nm
          WHERE user_cli_func_role.user_id = user_tbl.user_id
      ) as full_role_list,
      (
          SELECT jsonb_agg(DISTINCT cli_org.org_nm order by cli_org.org_nm)
          FROM user_cli_func_role
          JOIN cli_org cli_org ON cli_org.cli_org_id = user_cli_func_role.cli_org_id
          WHERE user_cli_func_role.user_id = user_tbl.user_id
      ) as full_cli_list
FROM
    user_tbl user_tbl
    LEFT JOIN user_tbl mgr_user_tbl ON mgr_user_tbl.user_id = user_tbl.mgr_user_id
    JOIN user_cli_func_role user_cli_func_role on user_cli_func_role.user_id = user_tbl.user_id
    JOIN cli_org cli_org ON cli_org.cli_org_id = user_cli_func_role.cli_org_id
    JOIN cli_func_role cli_func_role ON cli_func_role.cli_org_id = user_cli_func_role.cli_org_id AND cli_func_role.func_role_nm = user_cli_func_role.func_role_nm
    JOIN func_role func_role ON func_role.func_role_nm = cli_func_role.func_role_nm;

-- fuzzy search on the v_search_users
-- changed order by to DESC
CREATE OR REPLACE FUNCTION public.search_users_fuzzy(_search text) RETURNS SETOF v_search_users
    LANGUAGE sql STABLE AS $function$
SELECT * FROM
    v_search_users
WHERE
    CAST(user_lst_nm AS text) % _search
    OR CAST(user_fst_nm AS text) % _search
    OR CAST(email_id AS text) % _search
    OR CAST(user_desc->>'phone' AS text) % _search AND user_desc::text % _search             -- searches only user_desc.phone in json
    OR CAST(mgr_user_fst_nm AS text) % _search
    OR CAST(mgr_user_lst_nm AS text) % _search
    OR CAST(full_role_list AS text) % _search
    OR CAST(full_cli_list AS text) % _search
ORDER BY
    similarity(_search, (user_lst_nm || ' ' || user_fst_nm || ' ' || email_id || ' ' || user_desc || ' ' || mgr_user_fst_nm || ' ' || mgr_user_lst_nm ||  ' ' || full_role_list ||  ' ' || full_cli_list) ) DESC
LIMIT 500;
$function$;

-- fuzzy search on the combination of cli_func_role and func_role returning cli_func_role
-- updating order by to DESC
CREATE OR REPLACE FUNCTION public.search_roles_fuzzy(_search text) RETURNS SETOF cli_func_role
    LANGUAGE sql STABLE AS $function$
SELECT
      cli_func_role.cli_org_id,
      func_role.func_role_nm,                                                                                   -- searchable
      func_role.creat_dttm,
      cli_func_role.creat_user_id,
      cli_func_role.chg_dttm,
      cli_func_role.chg_user_id,
      cli_func_role.updt_ver_nbr,
      cli_func_role.creat_sys_ref_id,
      cli_func_role.chg_sys_ref_id,
      cli_func_role.strt_dt,
      cli_func_role.end_dt,
      COALESCE (cli_func_role.cli_func_role_als_nm, func_role.func_role_desc->>'name') as cli_func_role_als_nm, -- searchable
      cli_func_role.cli_func_role_desc
FROM
    func_role func_role
    LEFT JOIN cli_func_role cli_func_role ON cli_func_role.func_role_nm = func_role.func_role_nm
WHERE
    CAST(func_role.func_role_nm AS text) % _search
    OR CAST(cli_func_role.cli_func_role_als_nm AS text) % _search
    OR CAST(func_role.func_role_desc->>'name' AS text) % _search AND func_role.func_role_desc::text % _search    -- searches only func_role_desc.name in json
ORDER BY
    similarity(_search, (func_role.func_role_nm || ' ' || cli_func_role.cli_func_role_als_nm || ' ' || func_role.func_role_desc) ) DESC
LIMIT 500;
$function$;


CREATE TABLE IF NOT EXISTS OTP_SRVC_REQ
(
	otp_srvc_req_id      BIGSERIAL NOT NULL,
	creat_dttm           TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	creat_user_id        VARCHAR(250) NULL,
	chg_dttm             TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	chg_user_id          VARCHAR(250) NULL,
	updt_ver_nbr         INTEGER NULL DEFAULT 0,
	creat_sys_ref_id     INTEGER NULL,
	chg_sys_ref_id       INTEGER NULL,
	cli_org_id           VARCHAR(10) NOT NULL,
	appl_nm              VARCHAR(100) NOT NULL,
	appl_ver_id          VARCHAR(20) NOT NULL,
	otp_srvc_req_sbj_id  VARCHAR(250) NOT NULL,
	otp_srvc_req_sbj_typ_ref_id INTEGER NOT NULL,
	otp_cmnct_chnl_ref_id INTEGER NOT NULL,
	cmnct_adr_dtl        JSONB NOT NULL,
	otp_srvc_req_sts_ref_id INTEGER NOT NULL,
	tgt_evnt_dttm        TIMESTAMP(3) NOT NULL,
	login_prr_dur_mn_nbr SMALLINT NULL,
	logout_aft_dur_mn_nbr SMALLINT NULL,
	otp_add_atr_list     JSONB NULL,
	bth_dt               DATE NULL,
	otp_retry_cnt        SMALLINT NULL,
	otp_retry_max_cnt    SMALLINT NULL,
	otp_resnd_max_cnt    SMALLINT NULL,
	auth_cd              VARCHAR(50) NULL,
	CONSTRAINT OTP_SRVC_REQ_PK PRIMARY KEY (otp_srvc_req_id)
);

ALTER TABLE OTP_SRVC_REQ 
ADD CONSTRAINT OTP_SRVC_REQ_AK1 UNIQUE 
(
	otp_srvc_req_sbj_id,
	otp_srvc_req_sbj_typ_ref_id,
	cli_org_id,
	appl_nm,
	appl_ver_id
);


CREATE TABLE IF NOT EXISTS OTP_VAL
(
	otp_srvc_req_id      BIGINT NOT NULL,
	otp_val              VARCHAR(20) NOT NULL,
	creat_dttm           TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	creat_user_id        VARCHAR(250) NULL,
	creat_sys_ref_id     INTEGER NULL,
	otp_val_expir_dttm   TIMESTAMP(3) NOT NULL,
	CONSTRAINT OTP_VAL_PK PRIMARY KEY (otp_srvc_req_id,otp_val)
);


ALTER TABLE OTP_SRVC_REQ
ADD CONSTRAINT OTP_SRVC_REQ_CLI_ORG_fbda FOREIGN KEY (cli_org_id) REFERENCES CLI_ORG (cli_org_id);

ALTER TABLE OTP_SRVC_REQ
ADD CONSTRAINT OTP_SRVC_REQ_APPL_VER_8e7c FOREIGN KEY (appl_nm, appl_ver_id) REFERENCES APPL_VER (appl_nm, appl_ver_id);

ALTER TABLE OTP_VAL
ADD CONSTRAINT OTP_VAL_OTP_SRVC_REQ_5466 FOREIGN KEY (otp_srvc_req_id) REFERENCES OTP_SRVC_REQ (otp_srvc_req_id);

DROP TABLE IF EXISTS UI_SET;

ALTER TABLE APPL_WIDGET
DROP CONSTRAINT APPL_WIDGET_PK,
ADD COLUMN IF NOT EXISTS ui_sect_nm          VARCHAR(100) NOT NULL DEFAULT '0',
ADD COLUMN IF NOT EXISTS web_appl_ind         SMALLINT NULL,
ADD COLUMN IF NOT EXISTS mbl_appl_ind         SMALLINT NULL;

ALTER TABLE APPL_WIDGET
ADD CONSTRAINT APPL_WIDGET_PK PRIMARY KEY (appl_nm,widget_nm,ui_sect_nm);

ALTER TABLE APPL_WIDGET
ALTER COLUMN ui_sect_nm DROP DEFAULT;



DROP TABLE IF EXISTS CLI_FUNC_ROLE_APPL_UI_STEP;

CREATE TABLE IF NOT EXISTS CLI_FUNC_ROLE_APPL_UI_STEP
(
	cli_org_id           VARCHAR(10) NOT NULL,
	func_role_nm         VARCHAR(100) NOT NULL,
	appl_nm              VARCHAR(100) NOT NULL,
	widget_nm            VARCHAR(100) NOT NULL,
	ui_sect_nm           VARCHAR(100) NOT NULL,
	creat_dttm           TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	creat_user_id        VARCHAR(250) NULL,
	chg_dttm             TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	chg_user_id          VARCHAR(250) NULL,
	updt_ver_nbr         INTEGER NULL DEFAULT 0,
	creat_sys_ref_id     INTEGER NULL,
	chg_sys_ref_id       INTEGER NULL,
	ui_step_ordr_nbr     SMALLINT NULL,
	rqr_ind              SMALLINT NULL,
	cli_func_role_appl_ui_step_desc VARCHAR(300) NULL,
	CONSTRAINT CLI_FUNC_ROLE_APPL_UI_STEP_PK PRIMARY KEY (cli_org_id,func_role_nm,appl_nm,widget_nm,ui_sect_nm)
);


ALTER TABLE CLI_FUNC_ROLE_APPL_UI_STEP
ADD CONSTRAINT CLI_FUNC_ROLE_APPL_UI_STEP_CLI_FUNC_ROLE_APPL_d75d FOREIGN KEY (cli_org_id, func_role_nm, appl_nm) REFERENCES CLI_FUNC_ROLE_APPL (cli_org_id, func_role_nm, appl_nm);

ALTER TABLE CLI_FUNC_ROLE_APPL_UI_STEP
ADD CONSTRAINT CLI_FUNC_ROLE_APPL_UI_STEP_APPL_WIDGET_35ce FOREIGN KEY (appl_nm, widget_nm, ui_sect_nm) REFERENCES APPL_WIDGET (appl_nm, widget_nm, ui_sect_nm);

CREATE INDEX IF NOT EXISTS OTP_SRVC_REQ_IE1 ON OTP_SRVC_REQ
(
	auth_cd
);
-- Client Search
CREATE INDEX IF NOT EXISTS IF NOT EXISTS CLI_ORG_GIST1 ON CLI_ORG USING GIST(lower(org_nm) gist_trgm_ops);

CREATE OR REPLACE FUNCTION public.search_client_fuzzy(_search text)
 RETURNS SETOF cli_org
 LANGUAGE sql
 STABLE
AS $function$
SELECT
    *
FROM
    cli_org
WHERE
    CAST(cli_org.org_nm AS text) % _search
    AND (cli_org.cli_typ_ref_id = 73487 OR cli_org.cli_typ_ref_id IS NULL)
ORDER BY
    similarity(_search, (cli_org.org_nm || '')) ASC
LIMIT 500;
$function$;

-- Accounts Search
CREATE INDEX IF NOT EXISTS IF NOT EXISTS CLI_ORG_IDX1 ON CLI_ORG (lower(cli_desc->>'abbreviation'));
CREATE INDEX IF NOT EXISTS IF NOT EXISTS CLI_ORG_IDX2 ON CLI_ORG (lower(cli_desc->>'accountID'));

CREATE OR REPLACE VIEW public.v_search_accounts AS
SELECT
    cli_org_account.cli_org_id AS account_cli_org_id,
    cli_org_account.cli_desc AS account_cli_desc,
    cli_org_account.org_nm AS account_name,
    cli_org_account.creat_dttm AS creat_dttm,
    cli_org_account.chg_dttm AS chg_dttm,
    cli_org_account.cli_atr_list AS attr_list,
    cli_org_client.org_nm AS associated_client
FROM cli_org cli_org_account
         LEFT JOIN cli_org_grp cli_org_grp ON cli_org_account.cli_org_id = cli_org_grp.cli_org_id
         LEFT OUTER JOIN cli_org cli_org_client ON cli_org_grp.cli_grp_org_id = cli_org_client.cli_org_id
WHERE cli_org_account.cli_typ_ref_id = 73486;

CREATE OR REPLACE FUNCTION public.search_accounts_fuzzy(_search text)
 RETURNS SETOF v_search_accounts
 LANGUAGE sql
 STABLE
AS $function$
SELECT * FROM
    v_search_accounts
WHERE
    CAST(account_cli_desc->>'abbreviation' AS text) % _search
    OR CAST(account_cli_desc->>'accountID' AS text) % _search
    OR CAST(account_name AS text) % _search
    OR CAST(associated_client AS text) % _search
ORDER BY
    similarity(_search, (account_cli_org_id || '' || account_name || '' || account_cli_desc || '' || associated_client)) ASC
LIMIT 500;
$function$;

ALTER TABLE CLI_FUNC_ROLE_APPL
ADD COLUMN IF NOT EXISTS cstm_prmis_role_list JSONB NULL;

ALTER TABLE APPL_VER
ADD COLUMN IF NOT EXISTS cstm_prmis_ind SMALLINT NULL;

ALTER TABLE APPL_VER_PRMIS_ROLE
ADD COLUMN IF NOT EXISTS widget_nm VARCHAR(100) NULL,
ADD COLUMN IF NOT EXISTS ui_sect_nm VARCHAR(100) NULL;

ALTER TABLE APPL_VER_PRMIS_ROLE
ADD CONSTRAINT APPL_VER_PRMIS_ROLE_APPL_WIDGET_952e FOREIGN KEY (appl_nm, widget_nm, ui_sect_nm) REFERENCES APPL_WIDGET (appl_nm, widget_nm, ui_sect_nm);
-- Create Fuzzy Search View
CREATE OR REPLACE VIEW public.v_search_tasks AS
(SELECT func_role.func_role_desc -> 'name'         AS role_name,
        func_role.mng_func_role_nm                 AS role_based_on,
        role_req.cli_func_role_appl_desc           AS description,
        role_req.bus_jstfy_desc -> 'justification' AS justification,
        role_req.creat_dttm                        AS submitted_date,
        cli_org.cli_org_id                         AS org_id,
        NULL                                       AS user_first_nm,
        NULL                                       AS user_last_nm,
        NULL                                       AS user_sts_ref_id,
        cli_org.org_nm                             AS client_name,
        NULL                                       AS user_current_role_start_date,
        NULL                                       AS mgr_user_fst_nm,
        NULL                                       AS mgr_user_lst_nm,
        NULL                                       AS user_requested_role,
        NULL                                       AS user_req_justification,
        NULL                                       AS application_name,
        NULL                                       AS new_version,
        NULL                                       AS old_version,
        NULL                                       AS release_notes
 FROM   cli_func_role_appl role_req
        LEFT JOIN cli_org cli_org
               ON cli_org.cli_org_id = role_req.cli_org_id
        LEFT JOIN func_role func_role
               ON func_role.func_role_nm = role_req.func_role_nm
 WHERE  role_req.cli_func_role_appl_sts_ref_id = 1)
UNION ALL
(SELECT func_role.func_role_desc -> 'name'                  AS role_name,
        NULL                                                AS role_based_on,
        NULL                                                AS description,
        NULL                                                AS justification,
        func_role_request.creat_dttm                        AS submitted_date,
        cli_org.cli_org_id                                  AS org_id,
        user_tbl.fst_nm                                     AS user_first_nm,
        user_tbl.lst_nm                                     AS user_last_nm,
        user_tbl.user_sts_ref_id                            AS user_sts_ref_id,
        cli_org.org_nm                                      AS client_name,
        user_role.strt_dt                                   AS user_current_role_start_date,
        mgr_user_tbl.fst_nm                                 AS mgr_user_fst_nm,
        mgr_user_tbl.lst_nm                                 AS mgr_user_lst_nm,
        new_role_info.func_role_desc -> 'description'       AS user_requested_role,
        func_role_request.bus_jstfy_desc -> 'justification' AS user_req_justification,
        NULL                                                AS application_name,
        NULL                                                AS new_version,
        NULL                                                AS old_version,
        NULL                                                AS release_notes
 FROM   user_tbl user_tbl
        LEFT JOIN user_tbl mgr_user_tbl
               ON mgr_user_tbl.user_id = user_tbl.mgr_user_id
        LEFT JOIN user_cli_func_role user_role
               ON user_tbl.user_id = user_role.user_id
        LEFT JOIN func_role func_role
               ON user_role.func_role_nm = func_role.func_role_nm
        LEFT JOIN cli_org cli_org
               ON user_role.cli_org_id = cli_org.cli_org_id
        LEFT JOIN user_cli_func_role_req func_role_request
               ON func_role_request.user_id = user_tbl.user_id
        LEFT JOIN func_role new_role_info
               ON new_role_info.func_role_nm = func_role_request.func_role_nm
 WHERE  func_role_request.user_cli_func_role_req_sts_ref_id = 1
        AND user_tbl.user_sts_ref_id = 3316)
UNION ALL
(SELECT NULL                                               AS role_name,
        NULL                                               AS role_based_on,
        NULL                                               AS description,
        NULL                                               AS justification,
        appl_ver.creat_dttm                                AS submitted_date,
        NULL                                               AS org_id,
        NULL                                               AS user_first_nm,
        NULL                                               AS user_last_nm,
        NULL                                               AS user_sts_ref_id,
        NULL                                               AS client_name,
        NULL                                               AS user_current_role_start_date,
        NULL                                               AS mgr_user_fst_nm,
        NULL                                               AS mgr_user_lst_nm,
        NULL                                               AS user_requested_role,
        NULL                                               AS user_req_justification,
        appl_ver.appl_nm                                   AS application_name,
        appl_ver.appl_ver_id                               AS new_version,
        (SELECT MAX(older_app_ver.appl_ver_id)
         FROM   appl_ver older_app_ver
         WHERE  older_app_ver.appl_nm = appl_ver.appl_nm
                AND older_app_ver.appl_ver_sts_ref_id = 2) AS old_version,
        CAST(appl_ver.appl_ver_desc -> 'releaseNotes' as TEXT)         AS release_notes
 FROM   appl_ver appl_ver
 WHERE  appl_ver.appl_ver_sts_ref_id = 1);

-- Create Indexes
CREATE INDEX IF NOT EXISTS FUNC_ROLE_GIST2 ON FUNC_ROLE USING GIST(lower(mng_func_role_nm) gist_trgm_ops);
CREATE INDEX IF NOT EXISTS CLI_FUNC_ROLE_APPL_GIST1 ON CLI_FUNC_ROLE_APPL USING GIST(lower(cli_func_role_appl_desc) gist_trgm_ops);
CREATE INDEX IF NOT EXISTS CLI_FUNC_ROLE_APPL_GIST2 ON CLI_FUNC_ROLE_APPL USING GIST(lower(bus_jstfy_desc->>'justification') gist_trgm_ops);
CREATE INDEX IF NOT EXISTS USER_CLI_FUNC_ROLE_REQ_GIST1 ON USER_CLI_FUNC_ROLE_REQ USING GIST(lower(bus_jstfy_desc->>'justification') gist_trgm_ops);
CREATE INDEX IF NOT EXISTS USER_TBL_GIST2 ON USER_TBL USING GIST(lower(fst_nm) gist_trgm_ops);
CREATE INDEX IF NOT EXISTS USER_TBL_GIST3 ON USER_TBL USING GIST(lower(lst_nm) gist_trgm_ops);
CREATE INDEX IF NOT EXISTS APPL_VER_GIST1 ON APPL_VER USING GIST(lower(appl_nm) gist_trgm_ops);
CREATE INDEX IF NOT EXISTS APPL_VER_GIST2 ON APPL_VER USING GIST(lower(appl_ver_id) gist_trgm_ops);
CREATE INDEX IF NOT EXISTS APPL_VER_GIST3 ON APPL_VER USING GIST(lower(appl_ver_desc->>'releaseNotes') gist_trgm_ops);

-- Create Fuzzy Search Function
CREATE OR REPLACE FUNCTION public.search_tasks_fuzzy(_search text)
RETURNS SETOF v_search_tasks
LANGUAGE sql
STABLE
AS $function$
SELECT *
FROM v_search_tasks
WHERE CAST(role_name AS text) % _search
  OR CAST(role_based_on AS text) % _search
  OR CAST(description AS text) % _search
  OR CAST(justification AS text) % _search

  OR CAST(user_first_nm AS text) % _search
  OR CAST(user_last_nm AS text) % _search
  OR CAST(client_name AS text) % _search
  OR CAST(mgr_user_fst_nm AS text) % _search
  OR CAST(mgr_user_lst_nm AS text) % _search
  OR CAST(user_requested_role AS text) % _search
  OR CAST(user_req_justification AS text) % _search
  OR CAST(application_name AS text) % _search
  OR CAST(new_version AS text) % _search
  OR CAST(old_version AS text) % _search
  OR CAST(release_notes AS text) % _search
ORDER BY similarity(_search, (client_name || '' || user_last_nm || '' ||
    user_first_nm || '' || mgr_user_lst_nm || '' || mgr_user_fst_nm || '' ||
    role_name || '' || user_requested_role || '' || application_name || '' ||
    description || '' || role_based_on || '' || justification
    || '' || user_req_justification || '' || new_version || '' || old_version || '' ||
    release_notes))
    LIMIT 500;
$function$;

ALTER TABLE APPL_VER_PRMIS_ROLE
ADD COLUMN IF NOT EXISTS appl_ver_prmis_role_desc VARCHAR(300) NULL;

ALTER TABLE USER_SGNON
ADD COLUMN IF NOT EXISTS lst_sgnoff_dttm TIMESTAMP(3) NULL;
-- Accounts Search
CREATE OR REPLACE VIEW public.v_search_accounts AS
SELECT
    cli_org_account.cli_org_id AS account_cli_org_id,
    cli_org_account.cli_desc AS account_cli_desc,
    cli_org_account.org_nm AS account_name,
    cli_org_account.creat_dttm AS creat_dttm,
    cli_org_account.chg_dttm AS chg_dttm,
    cli_org_account.cli_atr_list AS attr_list,
    cli_org_client.org_nm AS associated_client,
    cli_org_client.cli_org_id AS associated_client_id
FROM cli_org cli_org_account
         LEFT JOIN cli_org_grp cli_org_grp ON cli_org_account.cli_org_id = cli_org_grp.cli_org_id
         LEFT OUTER JOIN cli_org cli_org_client ON cli_org_grp.cli_grp_org_id = cli_org_client.cli_org_id
WHERE cli_org_account.cli_typ_ref_id = 73486;

CREATE OR REPLACE FUNCTION public.search_accounts_fuzzy(_search text)
 RETURNS SETOF v_search_accounts
 LANGUAGE sql
 STABLE
AS $function$
SELECT * FROM
    v_search_accounts
WHERE
    CAST(account_cli_desc->>'abbreviation' AS text) % _search
    OR CAST(account_cli_desc->>'accountID' AS text) % _search
    OR CAST(account_name AS text) % _search
    OR CAST(associated_client AS text) % _search
ORDER BY
    similarity(_search, (account_cli_org_id || '' || account_name || '' || account_cli_desc || '' || associated_client)) ASC
LIMIT 500;
$function$;

DROP INDEX IF EXISTS FUNC_ROLE_GIST2 CASCADE;
DROP INDEX IF EXISTS CLI_FUNC_ROLE_APPL_GIST1 CASCADE;
DROP INDEX IF EXISTS CLI_FUNC_ROLE_APPL_GIST2 CASCADE;
DROP INDEX IF EXISTS USER_CLI_FUNC_ROLE_REQ_GIST1 CASCADE;
DROP INDEX IF EXISTS USER_TBL_GIST2 CASCADE;
DROP INDEX IF EXISTS USER_TBL_GIST3 CASCADE;
DROP INDEX IF EXISTS APPL_VER_GIST1 CASCADE;
DROP INDEX IF EXISTS APPL_VER_GIST2 CASCADE;
DROP INDEX IF EXISTS APPL_VER_GIST3 CASCADE;

DROP FUNCTION IF EXISTS public.search_tasks_fuzzy(text);
DROP VIEW IF EXISTS public.v_search_tasks CASCADE;

-- Create Fuzzy Search View
CREATE OR REPLACE VIEW public.v_search_tasks AS
(SELECT func_role.func_role_desc -> 'name'         AS role_name,
        func_role.mng_func_role_nm                 AS role_based_on,
        role_req.cli_func_role_appl_desc           AS description,
        role_req.bus_jstfy_desc -> 'justification' AS justification,
        role_req.creat_dttm                        AS submitted_date,
        cli_org.cli_org_id                         AS org_id,
        NULL                                       AS user_first_nm,
        NULL                                       AS user_last_nm,
        NULL                                       AS user_sts_ref_id,
        cli_org.org_nm                             AS client_name,
        NULL                                       AS user_current_role_start_date,
        NULL                                       AS mgr_user_fst_nm,
        NULL                                       AS mgr_user_lst_nm,
        NULL                                       AS user_requested_role,
        NULL                                       AS user_req_justification,
        NULL                                       AS application_name,
        NULL                                       AS new_version,
        NULL                                       AS old_version,
        NULL                                       AS release_notes
 FROM   cli_func_role_appl role_req
        LEFT JOIN cli_org cli_org
               ON cli_org.cli_org_id = role_req.cli_org_id
        LEFT JOIN func_role func_role
               ON func_role.func_role_nm = role_req.func_role_nm
 WHERE  role_req.cli_func_role_appl_sts_ref_id = 1)
UNION ALL
(SELECT func_role.func_role_desc -> 'name'                  AS role_name,
        NULL                                                AS role_based_on,
        NULL                                                AS description,
        NULL                                                AS justification,
        func_role_request.creat_dttm                        AS submitted_date,
        cli_org.cli_org_id                                  AS org_id,
        user_tbl.fst_nm                                     AS user_first_nm,
        user_tbl.lst_nm                                     AS user_last_nm,
        user_tbl.user_sts_ref_id                            AS user_sts_ref_id,
        cli_org.org_nm                                      AS client_name,
        user_role.strt_dt                                   AS user_current_role_start_date,
        mgr_user_tbl.fst_nm                                 AS mgr_user_fst_nm,
        mgr_user_tbl.lst_nm                                 AS mgr_user_lst_nm,
        new_role_info.func_role_nm                          AS user_requested_role,
        func_role_request.bus_jstfy_desc -> 'justification' AS user_req_justification,
        NULL                                                AS application_name,
        NULL                                                AS new_version,
        NULL                                                AS old_version,
        NULL                                                AS release_notes
 FROM   user_tbl user_tbl
        LEFT JOIN user_tbl mgr_user_tbl
               ON mgr_user_tbl.user_id = user_tbl.mgr_user_id
        LEFT JOIN user_cli_func_role user_role
               ON user_tbl.user_id = user_role.user_id
        LEFT JOIN func_role func_role
               ON user_role.func_role_nm = func_role.func_role_nm
        LEFT JOIN cli_org cli_org
               ON user_role.cli_org_id = cli_org.cli_org_id
        LEFT JOIN user_cli_func_role_req func_role_request
               ON func_role_request.user_id = user_tbl.user_id
        LEFT JOIN func_role new_role_info
               ON new_role_info.func_role_nm = func_role_request.func_role_nm
 WHERE  func_role_request.user_cli_func_role_req_sts_ref_id = 1
        AND user_tbl.user_sts_ref_id = 3316)
UNION ALL
(SELECT NULL                                               AS role_name,
        NULL                                               AS role_based_on,
        NULL                                               AS description,
        NULL                                               AS justification,
        appl_ver.creat_dttm                                AS submitted_date,
        NULL                                               AS org_id,
        NULL                                               AS user_first_nm,
        NULL                                               AS user_last_nm,
        NULL                                               AS user_sts_ref_id,
        NULL                                               AS client_name,
        NULL                                               AS user_current_role_start_date,
        NULL                                               AS mgr_user_fst_nm,
        NULL                                               AS mgr_user_lst_nm,
        NULL                                               AS user_requested_role,
        NULL                                               AS user_req_justification,
        appl_ver.appl_nm                                   AS application_name,
        appl_ver.appl_ver_id                               AS new_version,
        (SELECT MAX(older_app_ver.appl_ver_id)
         FROM   appl_ver older_app_ver
         WHERE  older_app_ver.appl_nm = appl_ver.appl_nm
                AND older_app_ver.appl_ver_sts_ref_id = 2) AS old_version,
        CAST(appl_ver.appl_ver_desc -> 'releaseNotes' as TEXT)         AS release_notes
 FROM   appl_ver appl_ver
 WHERE  appl_ver.appl_ver_sts_ref_id = 1);

-- Create Indexes
CREATE INDEX IF NOT EXISTS FUNC_ROLE_GIST2 ON FUNC_ROLE USING GIST(lower(mng_func_role_nm) gist_trgm_ops);
CREATE INDEX IF NOT EXISTS CLI_FUNC_ROLE_APPL_GIST1 ON CLI_FUNC_ROLE_APPL USING GIST(lower(cli_func_role_appl_desc) gist_trgm_ops);
CREATE INDEX IF NOT EXISTS CLI_FUNC_ROLE_APPL_GIST2 ON CLI_FUNC_ROLE_APPL USING GIST(lower(bus_jstfy_desc->>'justification') gist_trgm_ops);
CREATE INDEX IF NOT EXISTS USER_CLI_FUNC_ROLE_REQ_GIST1 ON USER_CLI_FUNC_ROLE_REQ USING GIST(lower(bus_jstfy_desc->>'justification') gist_trgm_ops);
CREATE INDEX IF NOT EXISTS USER_TBL_GIST2 ON USER_TBL USING GIST(lower(fst_nm) gist_trgm_ops);
CREATE INDEX IF NOT EXISTS USER_TBL_GIST3 ON USER_TBL USING GIST(lower(lst_nm) gist_trgm_ops);
CREATE INDEX IF NOT EXISTS APPL_VER_GIST1 ON APPL_VER USING GIST(lower(appl_nm) gist_trgm_ops);
CREATE INDEX IF NOT EXISTS APPL_VER_GIST2 ON APPL_VER USING GIST(lower(appl_ver_id) gist_trgm_ops);
CREATE INDEX IF NOT EXISTS APPL_VER_GIST3 ON APPL_VER USING GIST(lower(appl_ver_desc->>'releaseNotes') gist_trgm_ops);

-- Create Fuzzy Search Function
CREATE OR REPLACE FUNCTION public.search_tasks_fuzzy(_search text)
RETURNS SETOF v_search_tasks
LANGUAGE sql
STABLE
AS $function$
SELECT *
FROM v_search_tasks
WHERE CAST(role_name AS text) % _search
  OR CAST(role_based_on AS text) % _search
  OR CAST(description AS text) % _search
  OR CAST(justification AS text) % _search

  OR CAST(user_first_nm AS text) % _search
  OR CAST(user_last_nm AS text) % _search
  OR CAST(client_name AS text) % _search
  OR CAST(mgr_user_fst_nm AS text) % _search
  OR CAST(mgr_user_lst_nm AS text) % _search
  OR CAST(user_requested_role AS text) % _search
  OR CAST(user_req_justification AS text) % _search
  OR CAST(application_name AS text) % _search
  OR CAST(new_version AS text) % _search
  OR CAST(old_version AS text) % _search
  OR CAST(release_notes AS text) % _search
ORDER BY similarity(_search, (client_name || '' || user_last_nm || '' ||
    user_first_nm || '' || mgr_user_lst_nm || '' || mgr_user_fst_nm || '' ||
    role_name || '' || user_requested_role || '' || application_name || '' ||
    description || '' || role_based_on || '' || justification
    || '' || user_req_justification || '' || new_version || '' || old_version || '' ||
    release_notes))
    LIMIT 500;
$function$;

-- Accounts Search
CREATE OR REPLACE VIEW public.v_search_accounts AS
SELECT
    cli_org_account.cli_org_id AS account_cli_org_id,
    cli_org_account.cli_desc AS account_cli_desc,
    cli_org_account.org_nm AS account_name,
    cli_org_account.creat_dttm AS creat_dttm,
    cli_org_account.chg_dttm AS chg_dttm,
    cli_org_account.cli_atr_list AS attr_list,
    cli_org_client.org_nm AS associated_client,
    cli_org_client.cli_org_id AS associated_client_id,
    cli_org_account.inac_ind AS inac_ind
FROM cli_org cli_org_account
         LEFT JOIN cli_org_grp cli_org_grp ON cli_org_account.cli_org_id = cli_org_grp.cli_org_id
         LEFT OUTER JOIN cli_org cli_org_client ON cli_org_grp.cli_grp_org_id = cli_org_client.cli_org_id
WHERE cli_org_account.cli_typ_ref_id = 73486;

SET pg_trgm.similarity_threshold = 0.02;

CREATE OR REPLACE FUNCTION public.search_accounts_fuzzy(_search text)
RETURNS SETOF v_search_accounts
LANGUAGE sql
STABLE
AS $function$
SELECT * FROM
v_search_accounts
WHERE
(CAST(account_cli_desc->>'description' AS text) % _search
OR CAST(account_cli_org_id AS text) % _search
OR CAST(account_name AS text) % _search
OR CAST(associated_client AS text) % _search)
AND inac_ind = 0
ORDER BY
similarity(_search, (account_cli_org_id || '' || account_name || '' || account_cli_desc || '' || associated_client)) ASC
LIMIT 500;
$function$

-- Apps Search
CREATE INDEX IF NOT EXISTS APPL_DESC_GIST2 ON APPL USING GIST(lower(APPL_DESC->>'name') gist_trgm_ops);
CREATE INDEX IF NOT EXISTS APPL_DESC_GIST3 ON APPL USING GIST(lower(APPL_DESC->>'description') gist_trgm_ops);

CREATE OR REPLACE VIEW public.v_search_apps AS
SELECT
    appl.appl_nm AS appl_nm,
    appl.appl_desc AS appl_desc,
    appl.creat_dttm AS creat_dttm,
    appl.bpm_ind AS bpm_ind,
    appl.inac_ind AS inac_ind,
      (
          SELECT jsonb_agg(DISTINCT appl_ver.appl_ver_id order by appl_ver.appl_ver_id)
          FROM appl_ver
          WHERE (appl_ver.inac_ind = 0 OR appl_ver.inac_ind = NULL) AND appl.appl_nm = appl_ver.appl_nm
      ) as appl_ver_list,
      (
          SELECT jsonb_agg(DISTINCT appl_widget.widget_nm order by appl_widget.widget_nm)
          FROM appl_widget
          WHERE (appl_widget.inac_ind = 0 OR appl_widget.inac_ind = NULL) AND appl.appl_nm = appl_widget.appl_nm
      ) as widget_nm_list,
      (
          SELECT jsonb_agg(DISTINCT COALESCE(user_tbl.lst_nm || ', ' || user_tbl.fst_nm))
          FROM appl_ownr
          LEFT JOIN user_tbl ON appl_ownr.user_id = user_tbl.user_id
          WHERE (appl_ownr.inac_ind = 0 OR appl_ownr.inac_ind = NULL) AND appl.appl_nm = appl_ownr.appl_nm
      ) as ownr_nm_list,
      (
          SELECT jsonb_agg(DISTINCT user_tbl.user_id)
          FROM appl_ownr
          LEFT JOIN user_tbl ON appl_ownr.user_id = user_tbl.user_id
          WHERE (appl_ownr.inac_ind = 0 OR appl_ownr.inac_ind = NULL) AND appl.appl_nm = appl_ownr.appl_nm
      ) as ownr_id_list,
      (
          SELECT jsonb_agg(DISTINCT cli_org.org_nm order by cli_org.org_nm)
          FROM cli_func_role_appl
          JOIN cli_org cli_org ON cli_org.cli_org_id = cli_func_role_appl.cli_org_id
          WHERE appl.appl_nm = cli_func_role_appl.appl_nm
      ) as cli_org_name_list,
      (
          SELECT jsonb_agg(DISTINCT cli_func_role_appl.cli_org_id)
          FROM cli_func_role_appl
          WHERE appl.appl_nm = cli_func_role_appl.appl_nm
      ) as cli_org_id_list
FROM
    appl appl;

-- fuzzy search on the v_search_apps
CREATE OR REPLACE FUNCTION public.search_apps_fuzzy(_search text) RETURNS SETOF v_search_apps
    LANGUAGE sql STABLE AS $function$
SELECT
     *
FROM
    v_search_apps
WHERE
    CAST(appl_nm AS text) % _search
    OR CAST(appl_desc->>'name' AS text) % _search   -- searches only appl_desc.name in json
    OR CAST(appl_desc->>'description' AS text) % _search   -- searches only appl_desc.description in json
    OR CAST(appl_ver_list AS text) % _search
    OR CAST(widget_nm_list AS text) % _search
    OR CAST(ownr_nm_list AS text) % _search
    OR CAST(cli_org_id_list AS text) % _search
    OR CAST(cli_org_name_list AS text) % _search
ORDER BY
    similarity(_search, (appl_nm || '' || appl_desc || '' || appl_ver_list || '' || widget_nm_list || '' || ownr_nm_list || '' || cli_org_id_list || '' || cli_org_name_list)) ASC
LIMIT 500;
$function$;

CREATE TABLE IF NOT EXISTS USER_CLI_FUNC_ROLE_AVL
(
	user_id              VARCHAR(250) NOT NULL,
	cli_org_id           VARCHAR(10) NOT NULL,
	func_role_nm         VARCHAR(100) NOT NULL,
	user_avl_typ_ref_id  INTEGER NOT NULL,
	creat_dttm           TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	creat_user_id        VARCHAR(250) NULL,
	chg_dttm             TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	chg_user_id          VARCHAR(250) NULL,
	updt_ver_nbr         INTEGER NOT NULL DEFAULT 0,
	creat_sys_ref_id     INTEGER NULL,
	chg_sys_ref_id       INTEGER NULL,
	user_avl_sts_ref_id  INTEGER NOT NULL,
	CONSTRAINT USER_CLI_FUNC_ROLE_AVL_PK PRIMARY KEY (user_id,cli_org_id,func_role_nm,user_avl_typ_ref_id)
);

CREATE INDEX IF NOT EXISTS USER_CLI_FUNC_ROLE_AVL_IE1 ON USER_CLI_FUNC_ROLE_AVL
(
	cli_org_id ASC,
	func_role_nm ASC,
	user_avl_sts_ref_id ASC,
	user_avl_typ_ref_id ASC
);

ALTER TABLE USER_CLI_FUNC_ROLE_AVL
ADD CONSTRAINT USER_CLI_FUNC_ROLE_AVL_USER_CLI_FUNC_ROLE_2c13 FOREIGN KEY (user_id, cli_org_id, func_role_nm) REFERENCES USER_CLI_FUNC_ROLE (user_id, cli_org_id, func_role_nm);

ALTER TABLE CLI_FUNC_ROLE_APPL
ADD COLUMN IF NOT EXISTS ui_set_dtl JSONB NULL;
DROP INDEX IF EXISTS FUNC_ROLE_GIST2 CASCADE;
DROP INDEX IF EXISTS CLI_FUNC_ROLE_APPL_GIST1 CASCADE;
DROP INDEX IF EXISTS CLI_FUNC_ROLE_APPL_GIST2 CASCADE;
DROP INDEX IF EXISTS USER_CLI_FUNC_ROLE_REQ_GIST1 CASCADE;
DROP INDEX IF EXISTS USER_TBL_GIST2 CASCADE;
DROP INDEX IF EXISTS USER_TBL_GIST3 CASCADE;
DROP INDEX IF EXISTS APPL_VER_GIST1 CASCADE;
DROP INDEX IF EXISTS APPL_VER_GIST2 CASCADE;
DROP INDEX IF EXISTS APPL_VER_GIST3 CASCADE;

DROP FUNCTION IF EXISTS public.search_tasks_fuzzy(text);
DROP VIEW IF EXISTS public.v_search_tasks CASCADE;

-- Create Fuzzy Search View
CREATE OR REPLACE VIEW public.v_search_tasks AS
(SELECT func_role.func_role_desc -> 'name'         AS role_name,
        func_role.func_role_nm                     AS role_based_on,
        role_req.cli_func_role_appl_desc           AS description,
        role_req.bus_jstfy_desc -> 'justification' AS justification,
        role_req.creat_dttm                        AS submitted_date,
        cli_org.cli_org_id                         AS org_id,
        NULL                                       AS user_first_nm,
        NULL                                       AS user_last_nm,
        NULL                                       AS user_sts_ref_id,
        cli_org.org_nm                             AS client_name,
        NULL                                       AS user_current_role_start_date,
        NULL                                       AS mgr_user_fst_nm,
        NULL                                       AS mgr_user_lst_nm,
        NULL                                       AS user_requested_role,
        NULL                                       AS user_req_justification,
        NULL                                       AS application_name,
        NULL                                       AS new_version,
        NULL                                       AS old_version,
        NULL                                       AS release_notes
 FROM   cli_func_role_appl role_req
        LEFT JOIN cli_org cli_org
               ON cli_org.cli_org_id = role_req.cli_org_id
        LEFT JOIN func_role func_role
               ON func_role.func_role_nm = role_req.func_role_nm
 WHERE  role_req.cli_func_role_appl_sts_ref_id = 1)
UNION ALL
(SELECT func_role.func_role_desc -> 'name'                  AS role_name,
        NULL                                                AS role_based_on,
        NULL                                                AS description,
        NULL                                                AS justification,
        func_role_request.creat_dttm                        AS submitted_date,
        cli_org.cli_org_id                                  AS org_id,
        user_tbl.fst_nm                                     AS user_first_nm,
        user_tbl.lst_nm                                     AS user_last_nm,
        user_tbl.user_sts_ref_id                            AS user_sts_ref_id,
        cli_org.org_nm                                      AS client_name,
        user_role.strt_dt                                   AS user_current_role_start_date,
        mgr_user_tbl.fst_nm                                 AS mgr_user_fst_nm,
        mgr_user_tbl.lst_nm                                 AS mgr_user_lst_nm,
        new_role_info.func_role_nm                          AS user_requested_role,
        func_role_request.bus_jstfy_desc -> 'justification' AS user_req_justification,
        NULL                                                AS application_name,
        NULL                                                AS new_version,
        NULL                                                AS old_version,
        NULL                                                AS release_notes
 FROM   user_tbl user_tbl
        LEFT JOIN user_tbl mgr_user_tbl
               ON mgr_user_tbl.user_id = user_tbl.mgr_user_id
        LEFT JOIN user_cli_func_role user_role
               ON user_tbl.user_id = user_role.user_id
        LEFT JOIN func_role func_role
               ON user_role.func_role_nm = func_role.func_role_nm
        LEFT JOIN cli_org cli_org
               ON user_role.cli_org_id = cli_org.cli_org_id
        LEFT JOIN user_cli_func_role_req func_role_request
               ON func_role_request.user_id = user_tbl.user_id
        LEFT JOIN func_role new_role_info
               ON new_role_info.func_role_nm = func_role_request.func_role_nm
 WHERE  func_role_request.user_cli_func_role_req_sts_ref_id = 1
        AND user_tbl.user_sts_ref_id = 3316)
UNION ALL
(SELECT NULL                                               AS role_name,
        NULL                                               AS role_based_on,
        NULL                                               AS description,
        NULL                                               AS justification,
        appl_ver.creat_dttm                                AS submitted_date,
        NULL                                               AS org_id,
        NULL                                               AS user_first_nm,
        NULL                                               AS user_last_nm,
        NULL                                               AS user_sts_ref_id,
        NULL                                               AS client_name,
        NULL                                               AS user_current_role_start_date,
        NULL                                               AS mgr_user_fst_nm,
        NULL                                               AS mgr_user_lst_nm,
        NULL                                               AS user_requested_role,
        NULL                                               AS user_req_justification,
        appl_ver.appl_nm                                   AS application_name,
        appl_ver.appl_ver_id                               AS new_version,
        (SELECT MAX(older_app_ver.appl_ver_id)
         FROM   appl_ver older_app_ver
         WHERE  older_app_ver.appl_nm = appl_ver.appl_nm
                AND older_app_ver.appl_ver_sts_ref_id = 2) AS old_version,
        CAST(appl_ver.appl_ver_desc -> 'releaseNotes' as TEXT)         AS release_notes
 FROM   appl_ver appl_ver
 WHERE  appl_ver.appl_ver_sts_ref_id = 1);

-- Create Indexes
CREATE INDEX IF NOT EXISTS FUNC_ROLE_GIST2 ON FUNC_ROLE USING GIST(lower(func_role_nm) gist_trgm_ops);
CREATE INDEX IF NOT EXISTS CLI_FUNC_ROLE_APPL_GIST1 ON CLI_FUNC_ROLE_APPL USING GIST(lower(cli_func_role_appl_desc) gist_trgm_ops);
CREATE INDEX IF NOT EXISTS CLI_FUNC_ROLE_APPL_GIST2 ON CLI_FUNC_ROLE_APPL USING GIST(lower(bus_jstfy_desc->>'justification') gist_trgm_ops);
CREATE INDEX IF NOT EXISTS USER_CLI_FUNC_ROLE_REQ_GIST1 ON USER_CLI_FUNC_ROLE_REQ USING GIST(lower(bus_jstfy_desc->>'justification') gist_trgm_ops);
CREATE INDEX IF NOT EXISTS USER_TBL_GIST2 ON USER_TBL USING GIST(lower(fst_nm) gist_trgm_ops);
CREATE INDEX IF NOT EXISTS USER_TBL_GIST3 ON USER_TBL USING GIST(lower(lst_nm) gist_trgm_ops);
CREATE INDEX IF NOT EXISTS APPL_VER_GIST1 ON APPL_VER USING GIST(lower(appl_nm) gist_trgm_ops);
CREATE INDEX IF NOT EXISTS APPL_VER_GIST2 ON APPL_VER USING GIST(lower(appl_ver_id) gist_trgm_ops);
CREATE INDEX IF NOT EXISTS APPL_VER_GIST3 ON APPL_VER USING GIST(lower(appl_ver_desc->>'releaseNotes') gist_trgm_ops);

-- Create Fuzzy Search Function
CREATE OR REPLACE FUNCTION public.search_tasks_fuzzy(_search text)
RETURNS SETOF v_search_tasks
LANGUAGE sql
STABLE
AS $function$
SELECT *
FROM v_search_tasks
WHERE CAST(role_name AS text) % _search
  OR CAST(role_based_on AS text) % _search
  OR CAST(description AS text) % _search
  OR CAST(justification AS text) % _search

  OR CAST(user_first_nm AS text) % _search
  OR CAST(user_last_nm AS text) % _search
  OR CAST(client_name AS text) % _search
  OR CAST(mgr_user_fst_nm AS text) % _search
  OR CAST(mgr_user_lst_nm AS text) % _search
  OR CAST(user_requested_role AS text) % _search
  OR CAST(user_req_justification AS text) % _search
  OR CAST(application_name AS text) % _search
  OR CAST(new_version AS text) % _search
  OR CAST(old_version AS text) % _search
  OR CAST(release_notes AS text) % _search
ORDER BY similarity(_search, (client_name || '' || user_last_nm || '' ||
    user_first_nm || '' || mgr_user_lst_nm || '' || mgr_user_fst_nm || '' ||
    role_name || '' || user_requested_role || '' || application_name || '' ||
    description || '' || role_based_on || '' || justification
    || '' || user_req_justification || '' || new_version || '' || old_version || '' ||
    release_notes))
    LIMIT 500;
$function$;

DROP INDEX IF EXISTS FUNC_ROLE_GIST2 CASCADE;
DROP INDEX IF EXISTS CLI_FUNC_ROLE_APPL_GIST1 CASCADE;
DROP INDEX IF EXISTS CLI_FUNC_ROLE_APPL_GIST2 CASCADE;
DROP INDEX IF EXISTS USER_CLI_FUNC_ROLE_REQ_GIST1 CASCADE;
DROP INDEX IF EXISTS USER_TBL_GIST2 CASCADE;
DROP INDEX IF EXISTS USER_TBL_GIST3 CASCADE;
DROP INDEX IF EXISTS APPL_VER_GIST1 CASCADE;
DROP INDEX IF EXISTS APPL_VER_GIST2 CASCADE;
DROP INDEX IF EXISTS APPL_VER_GIST3 CASCADE;

DROP FUNCTION IF EXISTS public.search_tasks_fuzzy(text);
DROP VIEW IF EXISTS public.v_search_tasks CASCADE;

-- Create Fuzzy Search View
-- Create Fuzzy Search View
CREATE OR REPLACE VIEW public.v_search_tasks AS
(SELECT cli_func_role.cli_func_role_als_nm         AS role_name,
        func_role.func_role_nm                     AS role_based_on,
        role_req.cli_func_role_appl_desc           AS description,
        role_req.bus_jstfy_desc -> 'justification' AS justification,
        role_req.creat_dttm                        AS submitted_date,
        cli_org.cli_org_id                         AS org_id,
        NULL                                       AS user_first_nm,
        NULL                                       AS user_last_nm,
        NULL                                       AS user_sts_ref_id,
        cli_org.org_nm                             AS client_name,
        NULL                                       AS user_current_role_start_date,
        NULL                                       AS mgr_user_fst_nm,
        NULL                                       AS mgr_user_lst_nm,
        NULL                                       AS user_requested_role,
        NULL                                       AS user_req_justification,
        NULL                                       AS application_name,
        NULL                                       AS new_version,
        NULL                                       AS old_version,
        NULL                                       AS release_notes,
        NULL                                       AS phot_lobj,
        NULL                                       AS user_id
 FROM   cli_func_role_appl role_req
        LEFT JOIN cli_org cli_org
               ON cli_org.cli_org_id = role_req.cli_org_id
        LEFT JOIN func_role func_role
               ON func_role.func_role_nm = role_req.func_role_nm
        LEFT JOIN cli_func_role cli_func_role
               ON (((cli_org.cli_org_id = cli_func_role.cli_org_id
                     AND func_role.func_role_nm = cli_func_role.func_role_nm)))
 WHERE  role_req.cli_func_role_appl_sts_ref_id = 1)
UNION ALL
(SELECT cli_func_role.cli_func_role_als_nm                  AS role_name,
        NULL                                                AS role_based_on,
        NULL                                                AS description,
        NULL                                                AS justification,
        func_role_request.creat_dttm                        AS submitted_date,
        cli_org.cli_org_id                                  AS org_id,
        user_tbl.fst_nm                                     AS user_first_nm,
        user_tbl.lst_nm                                     AS user_last_nm,
        user_tbl.user_sts_ref_id                            AS user_sts_ref_id,
        cli_org.org_nm                                      AS client_name,
        user_role.strt_dt                                   AS user_current_role_start_date,
        mgr_user_tbl.fst_nm                                 AS mgr_user_fst_nm,
        mgr_user_tbl.lst_nm                                 AS mgr_user_lst_nm,
        new_role_info.func_role_nm                          AS user_requested_role,
        func_role_request.bus_jstfy_desc -> 'justification' AS user_req_justification,
        NULL                                                AS application_name,
        NULL                                                AS new_version,
        NULL                                                AS old_version,
        NULL                                                AS release_notes,
        user_tbl.phot_lobj                                  AS phot_lobj,
        user_tbl.user_id                                    AS user_id
 FROM   user_tbl user_tbl
        LEFT JOIN user_tbl mgr_user_tbl
               ON mgr_user_tbl.user_id = user_tbl.mgr_user_id
        LEFT JOIN user_cli_func_role user_role
               ON user_tbl.user_id = user_role.user_id
        LEFT JOIN func_role func_role
               ON user_role.func_role_nm = func_role.func_role_nm
        LEFT JOIN cli_org cli_org
               ON user_role.cli_org_id = cli_org.cli_org_id
        LEFT JOIN user_cli_func_role_req func_role_request
               ON func_role_request.user_id = user_tbl.user_id
        LEFT JOIN func_role new_role_info
               ON new_role_info.func_role_nm = func_role_request.func_role_nm
        LEFT JOIN cli_func_role cli_func_role
               ON (((cli_org.cli_org_id = cli_func_role.cli_org_id AND func_role.func_role_nm = cli_func_role.func_role_nm)))
 WHERE  func_role_request.user_cli_func_role_req_sts_ref_id = 1
        AND user_tbl.user_sts_ref_id = 3316)
UNION ALL
(SELECT NULL                                               AS role_name,
        NULL                                               AS role_based_on,
        NULL                                               AS description,
        NULL                                               AS justification,
        appl_ver.creat_dttm                                AS submitted_date,
        NULL                                               AS org_id,
        NULL                                               AS user_first_nm,
        NULL                                               AS user_last_nm,
        NULL                                               AS user_sts_ref_id,
        NULL                                               AS client_name,
        NULL                                               AS user_current_role_start_date,
        NULL                                               AS mgr_user_fst_nm,
        NULL                                               AS mgr_user_lst_nm,
        NULL                                               AS user_requested_role,
        NULL                                               AS user_req_justification,
        appl_ver.appl_nm                                   AS application_name,
        appl_ver.appl_ver_id                               AS new_version,
        (SELECT MAX(older_app_ver.appl_ver_id)
         FROM   appl_ver older_app_ver
         WHERE  older_app_ver.appl_nm = appl_ver.appl_nm
                AND older_app_ver.appl_ver_sts_ref_id = 2) AS old_version,
        CAST(appl_ver.appl_ver_desc -> 'releaseNotes' as TEXT)         AS release_notes,
        NULL                                               AS phot_lobj,
        NULL                                               AS user_id
 FROM   appl_ver appl_ver
 WHERE  appl_ver.appl_ver_sts_ref_id = 1);

-- Create Indexes
CREATE INDEX IF NOT EXISTS FUNC_ROLE_GIST2 ON FUNC_ROLE USING GIST(lower(func_role_nm) gist_trgm_ops);
CREATE INDEX IF NOT EXISTS CLI_FUNC_ROLE_APPL_GIST1 ON CLI_FUNC_ROLE_APPL USING GIST(lower(cli_func_role_appl_desc) gist_trgm_ops);
CREATE INDEX IF NOT EXISTS CLI_FUNC_ROLE_APPL_GIST2 ON CLI_FUNC_ROLE_APPL USING GIST(lower(bus_jstfy_desc->>'justification') gist_trgm_ops);
CREATE INDEX IF NOT EXISTS USER_CLI_FUNC_ROLE_REQ_GIST1 ON USER_CLI_FUNC_ROLE_REQ USING GIST(lower(bus_jstfy_desc->>'justification') gist_trgm_ops);
CREATE INDEX IF NOT EXISTS USER_TBL_GIST2 ON USER_TBL USING GIST(lower(fst_nm) gist_trgm_ops);
CREATE INDEX IF NOT EXISTS USER_TBL_GIST3 ON USER_TBL USING GIST(lower(lst_nm) gist_trgm_ops);
CREATE INDEX IF NOT EXISTS APPL_VER_GIST1 ON APPL_VER USING GIST(lower(appl_nm) gist_trgm_ops);
CREATE INDEX IF NOT EXISTS APPL_VER_GIST2 ON APPL_VER USING GIST(lower(appl_ver_id) gist_trgm_ops);
CREATE INDEX IF NOT EXISTS APPL_VER_GIST3 ON APPL_VER USING GIST(lower(appl_ver_desc->>'releaseNotes') gist_trgm_ops);

-- Create Fuzzy Search Function
CREATE OR REPLACE FUNCTION public.search_tasks_fuzzy(_search text)
RETURNS SETOF v_search_tasks
LANGUAGE sql
STABLE
AS $function$
SELECT *
FROM v_search_tasks
WHERE CAST(role_name AS text) % _search
  OR CAST(role_based_on AS text) % _search
  OR CAST(description AS text) % _search
  OR CAST(justification AS text) % _search
  OR CAST(user_first_nm AS text) % _search
  OR CAST(user_last_nm AS text) % _search
  OR CAST(client_name AS text) % _search
  OR CAST(mgr_user_fst_nm AS text) % _search
  OR CAST(mgr_user_lst_nm AS text) % _search
  OR CAST(user_requested_role AS text) % _search
  OR CAST(user_req_justification AS text) % _search
  OR CAST(application_name AS text) % _search
  OR CAST(new_version AS text) % _search
  OR CAST(old_version AS text) % _search
  OR CAST(release_notes AS text) % _search
ORDER BY similarity(_search, (client_name || '' || user_last_nm || '' ||
    user_first_nm || '' || mgr_user_lst_nm || '' || mgr_user_fst_nm || '' ||
    role_name || '' || user_requested_role || '' || application_name || '' ||
    description || '' || role_based_on || '' || justification
    || '' || user_req_justification || '' || new_version || '' || old_version || '' ||
    release_notes))
    LIMIT 500;
$function$;



-- Updating 'v_search_tasks' view
CREATE
OR REPLACE VIEW public.v_search_tasks AS
(SELECT cli_func_role.cli_func_role_als_nm         AS role_name,
        func_role.func_role_nm                     AS role_based_on,
        role_req.cli_func_role_appl_desc           AS description,
        role_req.bus_jstfy_desc -> 'justification' AS justification,
        role_req.creat_dttm                        AS submitted_date,
        cli_org.cli_org_id                         AS org_id,
        NULL                                       AS user_first_nm,
        NULL                                       AS user_last_nm,
        NULL                                       AS user_sts_ref_id,
        cli_org.org_nm                             AS client_name,
        NULL                                       AS user_current_role_start_date,
        NULL                                       AS mgr_user_fst_nm,
        NULL                                       AS mgr_user_lst_nm,
        NULL                                       AS user_requested_role,
        NULL                                       AS user_req_justification,
        NULL                                       AS application_name,
        NULL                                       AS new_version,
        NULL                                       AS old_version,
        NULL                                       AS release_notes,
        NULL                                       AS phot_lobj,
        NULL                                       AS user_id
 FROM   cli_func_role_appl role_req
        LEFT JOIN cli_org cli_org
               ON cli_org.cli_org_id = role_req.cli_org_id
        LEFT JOIN func_role func_role
               ON func_role.func_role_nm = role_req.func_role_nm
        LEFT JOIN cli_func_role cli_func_role
               ON (((cli_org.cli_org_id = cli_func_role.cli_org_id
                     AND func_role.func_role_nm = cli_func_role.func_role_nm)))
 WHERE  role_req.cli_func_role_appl_sts_ref_id = 1)
UNION ALL
(SELECT  cli_func_role.cli_func_role_als_nm                  AS role_name,
        NULL                                                AS role_based_on,
        NULL                                                AS description,
        NULL                                                AS justification,
        func_role_request.creat_dttm                        AS submitted_date,
        cli_org.cli_org_id                                  AS org_id,
        user_tbl.fst_nm                                     AS user_first_nm,
        user_tbl.lst_nm                                     AS user_last_nm,
        user_tbl.user_sts_ref_id                            AS user_sts_ref_id,
        cli_org.org_nm                                      AS client_name,
        user_role.strt_dt                                   AS user_current_role_start_date,
        mgr_user_tbl.fst_nm                                 AS mgr_user_fst_nm,
        mgr_user_tbl.lst_nm                                 AS mgr_user_lst_nm,
        new_role_info.func_role_nm                          AS user_requested_role,
        func_role_request.bus_jstfy_desc -> 'justification' AS user_req_justification,
        NULL                                                AS application_name,
        NULL                                                AS new_version,
        NULL                                                AS old_version,
        NULL                                                AS release_notes,
        user_tbl.phot_lobj                                  AS phot_lobj,
        user_tbl.user_id                                    AS user_id
 FROM   user_tbl user_tbl
        LEFT JOIN user_tbl mgr_user_tbl ON mgr_user_tbl.user_id = user_tbl.mgr_user_id
        LEFT JOIN user_cli_func_role_req func_role_request ON func_role_request.user_id = user_tbl.user_id
        LEFT JOIN cli_func_role cli_func_role ON (((func_role_request.cli_org_id = cli_func_role.cli_org_id AND func_role_request.func_role_nm = cli_func_role.func_role_nm)))
        LEFT JOIN user_cli_func_role user_role ON (((cli_func_role.cli_org_id = user_role.cli_org_id AND cli_func_role.func_role_nm = user_role.func_role_nm AND user_tbl.user_id = user_role.user_id)))
        LEFT JOIN func_role func_role ON func_role_request.func_role_nm = func_role.func_role_nm
        LEFT JOIN cli_org cli_org ON func_role_request.cli_org_id = cli_org.cli_org_id
        LEFT JOIN func_role new_role_info ON new_role_info.func_role_nm = func_role_request.func_role_nm
 WHERE  func_role_request.user_cli_func_role_req_sts_ref_id = 1
        AND user_tbl.user_sts_ref_id = 3316)
UNION ALL
(SELECT NULL                                               AS role_name,
        NULL                                               AS role_based_on,
        NULL                                               AS description,
        NULL                                               AS justification,
        appl_ver.creat_dttm                                AS submitted_date,
        NULL                                               AS org_id,
        NULL                                               AS user_first_nm,
        NULL                                               AS user_last_nm,
        NULL                                               AS user_sts_ref_id,
        NULL                                               AS client_name,
        NULL                                               AS user_current_role_start_date,
        NULL                                               AS mgr_user_fst_nm,
        NULL                                               AS mgr_user_lst_nm,
        NULL                                               AS user_requested_role,
        NULL                                               AS user_req_justification,
        appl_ver.appl_nm                                   AS application_name,
        appl_ver.appl_ver_id                               AS new_version,
        (SELECT MAX(older_app_ver.appl_ver_id)
         FROM   appl_ver older_app_ver
         WHERE  older_app_ver.appl_nm = appl_ver.appl_nm
                AND older_app_ver.appl_ver_sts_ref_id = 2) AS old_version,
        CAST(appl_ver.appl_ver_desc -> 'releaseNotes' as TEXT)         AS release_notes,
        NULL                                               AS phot_lobj,
        NULL                                               AS user_id
 FROM   appl_ver appl_ver
 WHERE  appl_ver.appl_ver_sts_ref_id = 1);

CREATE
OR
replace FUNCTION PUBLIC.func_new_user_avl()
returns TRIGGER language plpgsql AS $function$
DECLARE
BEGIN
  IF new.cli_org_id IN ('ovc')
  AND
  new.func_role_nm IN ('vha',
                       'cn',
                       'rn',
                       'VHA',
                       'CN',
                       'RN') then
  INSERT INTO user_cli_func_role_avl
              (
                          user_id,
                          cli_org_id,
                          func_role_nm,
                          user_avl_typ_ref_id,
                          creat_dttm,
                          creat_user_id,
                          chg_dttm,
                          chg_user_id,
                          updt_ver_nbr,
                          creat_sys_ref_id,
                          chg_sys_ref_id,
                          user_avl_sts_ref_id
              )
              VALUES
              (
                          new.user_id,
                          new.cli_org_id,
                          new.func_role_nm,
                          740159,
                          new.creat_dttm,
                          new.creat_user_id,
                          new.chg_dttm,
                          new.chg_user_id,
                          new.updt_ver_nbr,
                          new.creat_sys_ref_id,
                          new.chg_sys_ref_id,
                          740160
              );

END IF;
RETURN new;
END;
$function$;

DROP TRIGGER IF EXISTS new_user_avl_def ON user_cli_func_role;

CREATE TRIGGER new_user_avl_def after
INSERT
OR
UPDATE
ON "user_cli_func_role" FOR each row
EXECUTE FUNCTION
  func_new_user_avl();

DROP FUNCTION IF EXISTS public.search_tasks_fuzzy(text);
DROP VIEW IF EXISTS public.v_search_tasks CASCADE;

-- Updating 'v_search_tasks' view
CREATE
OR REPLACE VIEW public.v_search_tasks AS
(SELECT cli_func_role.cli_func_role_als_nm         AS role_name,
        func_role.func_role_nm                     AS role_based_on,
        role_req.cli_func_role_appl_desc           AS description,
        role_req.bus_jstfy_desc -> 'justification' AS justification,
        role_req.creat_dttm                        AS submitted_date,
        cli_org.cli_org_id                         AS org_id,
        NULL                                       AS user_first_nm,
        NULL                                       AS user_last_nm,
        NULL                                       AS user_sts_ref_id,
        cli_org.org_nm                             AS client_name,
        NULL                                       AS user_current_role_start_date,
        NULL                                       AS mgr_user_fst_nm,
        NULL                                       AS mgr_user_lst_nm,
        NULL                                       AS user_requested_role,
        NULL                                       AS user_req_justification,
        NULL                                       AS application_name,
        NULL                                       AS new_version,
        NULL                                       AS old_version,
        NULL                                       AS release_notes,
        NULL                                       AS phot_lobj,
        NULL                                       AS user_id,
        role_req.appl_nm                           AS appl_nm
 FROM   cli_func_role_appl role_req
        LEFT JOIN cli_org cli_org
               ON cli_org.cli_org_id = role_req.cli_org_id
        LEFT JOIN func_role func_role
               ON func_role.func_role_nm = role_req.func_role_nm
        LEFT JOIN cli_func_role cli_func_role
               ON (((cli_org.cli_org_id = cli_func_role.cli_org_id
                     AND func_role.func_role_nm = cli_func_role.func_role_nm)))
 WHERE  role_req.cli_func_role_appl_sts_ref_id = 1)
UNION ALL
(SELECT  cli_func_role.cli_func_role_als_nm                  AS role_name,
        NULL                                                AS role_based_on,
        NULL                                                AS description,
        NULL                                                AS justification,
        func_role_request.creat_dttm                        AS submitted_date,
        cli_org.cli_org_id                                  AS org_id,
        user_tbl.fst_nm                                     AS user_first_nm,
        user_tbl.lst_nm                                     AS user_last_nm,
        user_tbl.user_sts_ref_id                            AS user_sts_ref_id,
        cli_org.org_nm                                      AS client_name,
        user_role.strt_dt                                   AS user_current_role_start_date,
        mgr_user_tbl.fst_nm                                 AS mgr_user_fst_nm,
        mgr_user_tbl.lst_nm                                 AS mgr_user_lst_nm,
        new_role_info.func_role_nm                          AS user_requested_role,
        func_role_request.bus_jstfy_desc -> 'justification' AS user_req_justification,
        NULL                                                AS application_name,
        NULL                                                AS new_version,
        NULL                                                AS old_version,
        NULL                                                AS release_notes,
        user_tbl.phot_lobj                                  AS phot_lobj,
        user_tbl.user_id                                    AS user_id,
        NULL                                                AS appl_nm
 FROM   user_tbl user_tbl
        LEFT JOIN user_tbl mgr_user_tbl ON mgr_user_tbl.user_id = user_tbl.mgr_user_id
        LEFT JOIN user_cli_func_role_req func_role_request ON func_role_request.user_id = user_tbl.user_id
        LEFT JOIN cli_func_role cli_func_role ON (((func_role_request.cli_org_id = cli_func_role.cli_org_id AND func_role_request.func_role_nm = cli_func_role.func_role_nm)))
        LEFT JOIN user_cli_func_role user_role ON (((cli_func_role.cli_org_id = user_role.cli_org_id AND cli_func_role.func_role_nm = user_role.func_role_nm AND user_tbl.user_id = user_role.user_id)))
        LEFT JOIN func_role func_role ON func_role_request.func_role_nm = func_role.func_role_nm
        LEFT JOIN cli_org cli_org ON func_role_request.cli_org_id = cli_org.cli_org_id
        LEFT JOIN func_role new_role_info ON new_role_info.func_role_nm = func_role_request.func_role_nm
 WHERE  func_role_request.user_cli_func_role_req_sts_ref_id = 1
        AND user_tbl.user_sts_ref_id = 3316)
UNION ALL
(SELECT NULL                                               AS role_name,
        NULL                                               AS role_based_on,
        NULL                                               AS description,
        NULL                                               AS justification,
        appl_ver.creat_dttm                                AS submitted_date,
        NULL                                               AS org_id,
        NULL                                               AS user_first_nm,
        NULL                                               AS user_last_nm,
        NULL                                               AS user_sts_ref_id,
        NULL                                               AS client_name,
        NULL                                               AS user_current_role_start_date,
        NULL                                               AS mgr_user_fst_nm,
        NULL                                               AS mgr_user_lst_nm,
        NULL                                               AS user_requested_role,
        NULL                                               AS user_req_justification,
        appl_ver.appl_nm                                   AS application_name,
        appl_ver.appl_ver_id                               AS new_version,
        (SELECT MAX(older_app_ver.appl_ver_id)
         FROM   appl_ver older_app_ver
         WHERE  older_app_ver.appl_nm = appl_ver.appl_nm
                AND older_app_ver.appl_ver_sts_ref_id = 2) AS old_version,
        CAST(appl_ver.appl_ver_desc -> 'releaseNotes' as TEXT)         AS release_notes,
        NULL                                               AS phot_lobj,
        NULL                                               AS user_id,
        NULL                                               AS appl_nm
 FROM   appl_ver appl_ver
 WHERE  appl_ver.appl_ver_sts_ref_id = 1);

-- Create Fuzzy Search Function
CREATE OR REPLACE FUNCTION public.search_tasks_fuzzy(_search text)
RETURNS SETOF v_search_tasks
LANGUAGE sql
STABLE
AS $function$
SELECT *
FROM v_search_tasks
WHERE CAST(role_name AS text) % _search
  OR CAST(role_based_on AS text) % _search
  OR CAST(description AS text) % _search
  OR CAST(justification AS text) % _search
  OR CAST(user_first_nm AS text) % _search
  OR CAST(user_last_nm AS text) % _search
  OR CAST(client_name AS text) % _search
  OR CAST(mgr_user_fst_nm AS text) % _search
  OR CAST(mgr_user_lst_nm AS text) % _search
  OR CAST(user_requested_role AS text) % _search
  OR CAST(user_req_justification AS text) % _search
  OR CAST(application_name AS text) % _search
  OR CAST(new_version AS text) % _search
  OR CAST(old_version AS text) % _search
  OR CAST(release_notes AS text) % _search
ORDER BY similarity(_search, (client_name || '' || user_last_nm || '' ||
    user_first_nm || '' || mgr_user_lst_nm || '' || mgr_user_fst_nm || '' ||
    role_name || '' || user_requested_role || '' || application_name || '' ||
    description || '' || role_based_on || '' || justification
    || '' || user_req_justification || '' || new_version || '' || old_version || '' ||
    release_notes))
    LIMIT 500;
$function$;

DROP FUNCTION IF EXISTS public.search_tasks_fuzzy(text);
DROP VIEW IF EXISTS public.v_search_tasks CASCADE;

-- Updating 'v_search_tasks' view
CREATE
OR REPLACE VIEW public.v_search_tasks AS
(SELECT cli_func_role.cli_func_role_als_nm         AS role_name,
        func_role.func_role_nm                     AS role_based_on,
        role_req.cli_func_role_appl_desc           AS description,
        role_req.bus_jstfy_desc -> 'justification' AS justification,
        role_req.creat_dttm                        AS submitted_date,
        cli_org.cli_org_id                         AS org_id,
        NULL                                       AS user_first_nm,
        NULL                                       AS user_last_nm,
        NULL                                       AS user_sts_ref_id,
        cli_org.org_nm                             AS client_name,
        NULL                                       AS user_current_role_start_date,
        NULL                                       AS mgr_user_fst_nm,
        NULL                                       AS mgr_user_lst_nm,
        NULL                                       AS user_requested_role,
        NULL                                       AS user_req_justification,
        NULL                                       AS application_name,
        NULL                                       AS new_version,
        NULL                                       AS old_version,
        NULL                                       AS release_notes,
        NULL                                       AS phot_lobj,
        NULL                                       AS user_id,
        role_req.appl_nm                           AS appl_nm,
        1                                          AS ref_id
 FROM   cli_func_role_appl role_req
        LEFT JOIN cli_org cli_org
               ON cli_org.cli_org_id = role_req.cli_org_id
        LEFT JOIN func_role func_role
               ON func_role.func_role_nm = role_req.func_role_nm
        LEFT JOIN cli_func_role cli_func_role
               ON (((cli_org.cli_org_id = cli_func_role.cli_org_id
                     AND func_role.func_role_nm = cli_func_role.func_role_nm)))
 WHERE  role_req.cli_func_role_appl_sts_ref_id = 1)
UNION ALL
(SELECT  cli_func_role.cli_func_role_als_nm                  AS role_name,
        NULL                                                AS role_based_on,
        NULL                                                AS description,
        NULL                                                AS justification,
        func_role_request.creat_dttm                        AS submitted_date,
        cli_org.cli_org_id                                  AS org_id,
        user_tbl.fst_nm                                     AS user_first_nm,
        user_tbl.lst_nm                                     AS user_last_nm,
        user_tbl.user_sts_ref_id                            AS user_sts_ref_id,
        cli_org.org_nm                                      AS client_name,
        user_role.strt_dt                                   AS user_current_role_start_date,
        mgr_user_tbl.fst_nm                                 AS mgr_user_fst_nm,
        mgr_user_tbl.lst_nm                                 AS mgr_user_lst_nm,
        new_role_info.func_role_nm                          AS user_requested_role,
        func_role_request.bus_jstfy_desc -> 'justification' AS user_req_justification,
        NULL                                                AS application_name,
        NULL                                                AS new_version,
        NULL                                                AS old_version,
        NULL                                                AS release_notes,
        user_tbl.phot_lobj                                  AS phot_lobj,
        user_tbl.user_id                                    AS user_id,
        NULL                                                AS appl_nm,
        2                                                   AS ref_id
 FROM   user_tbl user_tbl
        LEFT JOIN user_tbl mgr_user_tbl ON mgr_user_tbl.user_id = user_tbl.mgr_user_id
        LEFT JOIN user_cli_func_role_req func_role_request ON func_role_request.user_id = user_tbl.user_id
        LEFT JOIN cli_func_role cli_func_role ON (((func_role_request.cli_org_id = cli_func_role.cli_org_id AND func_role_request.func_role_nm = cli_func_role.func_role_nm)))
        LEFT JOIN user_cli_func_role user_role ON (((cli_func_role.cli_org_id = user_role.cli_org_id AND cli_func_role.func_role_nm = user_role.func_role_nm AND user_tbl.user_id = user_role.user_id)))
        LEFT JOIN func_role func_role ON func_role_request.func_role_nm = func_role.func_role_nm
        LEFT JOIN cli_org cli_org ON func_role_request.cli_org_id = cli_org.cli_org_id
        LEFT JOIN func_role new_role_info ON new_role_info.func_role_nm = func_role_request.func_role_nm
 WHERE  func_role_request.user_cli_func_role_req_sts_ref_id = 1
        AND user_tbl.user_sts_ref_id = 3316)
UNION ALL
(SELECT NULL                                               AS role_name,
        NULL                                               AS role_based_on,
        NULL                                               AS description,
        NULL                                               AS justification,
        appl_ver.creat_dttm                                AS submitted_date,
        NULL                                               AS org_id,
        NULL                                               AS user_first_nm,
        NULL                                               AS user_last_nm,
        NULL                                               AS user_sts_ref_id,
        NULL                                               AS client_name,
        NULL                                               AS user_current_role_start_date,
        NULL                                               AS mgr_user_fst_nm,
        NULL                                               AS mgr_user_lst_nm,
        NULL                                               AS user_requested_role,
        NULL                                               AS user_req_justification,
        appl_ver.appl_nm                                   AS application_name,
        appl_ver.appl_ver_id                               AS new_version,
        (SELECT MAX(older_app_ver.appl_ver_id)
         FROM   appl_ver older_app_ver
         WHERE  older_app_ver.appl_nm = appl_ver.appl_nm
                AND older_app_ver.appl_ver_sts_ref_id = 2) AS old_version,
        CAST(appl_ver.appl_ver_desc -> 'releaseNotes' as TEXT)         AS release_notes,
        NULL                                               AS phot_lobj,
        NULL                                               AS user_id,
        NULL                                               AS appl_nm,
        3                                                  AS ref_id
 FROM   appl_ver appl_ver
 WHERE  appl_ver.appl_ver_sts_ref_id = 1);

-- Create Fuzzy Search Function
CREATE OR REPLACE FUNCTION public.search_tasks_fuzzy(_search text)
RETURNS SETOF v_search_tasks
LANGUAGE sql
STABLE
AS $function$
SELECT *
FROM v_search_tasks
WHERE CAST(role_name AS text) % _search
  OR CAST(role_based_on AS text) % _search
  OR CAST(description AS text) % _search
  OR CAST(justification AS text) % _search
  OR CAST(user_first_nm AS text) % _search
  OR CAST(user_last_nm AS text) % _search
  OR CAST(client_name AS text) % _search
  OR CAST(mgr_user_fst_nm AS text) % _search
  OR CAST(mgr_user_lst_nm AS text) % _search
  OR CAST(user_requested_role AS text) % _search
  OR CAST(user_req_justification AS text) % _search
  OR CAST(application_name AS text) % _search
  OR CAST(new_version AS text) % _search
  OR CAST(old_version AS text) % _search
  OR CAST(release_notes AS text) % _search
ORDER BY similarity(_search, (client_name || '' || user_last_nm || '' ||
    user_first_nm || '' || mgr_user_lst_nm || '' || mgr_user_fst_nm || '' ||
    role_name || '' || user_requested_role || '' || application_name || '' ||
    description || '' || role_based_on || '' || justification
    || '' || user_req_justification || '' || new_version || '' || old_version || '' ||
    release_notes))
    LIMIT 500;
$function$;

CREATE OR REPLACE VIEW public.v_search_apps AS
SELECT
    appl.appl_nm AS appl_nm,
    appl.appl_desc AS appl_desc,
    appl.creat_dttm AS creat_dttm,
    appl.bpm_ind AS bpm_ind,
    appl.inac_ind AS inac_ind,
      (
          SELECT jsonb_agg(DISTINCT appl_ver.appl_ver_id order by appl_ver.appl_ver_id)
          FROM appl_ver
          WHERE (appl_ver.inac_ind = 0 OR appl_ver.inac_ind IS NULL)
          AND appl_ver.appl_ver_sts_ref_id = 2
          AND appl.appl_nm = appl_ver.appl_nm
      ) as appl_ver_list,
      (
          SELECT jsonb_agg(DISTINCT appl_widget.widget_nm order by appl_widget.widget_nm)
          FROM appl_widget
          WHERE (appl_widget.inac_ind = 0 OR appl_widget.inac_ind IS NULL) AND appl.appl_nm = appl_widget.appl_nm
      ) as widget_nm_list,
      (
          SELECT jsonb_agg(DISTINCT COALESCE(user_tbl.lst_nm || ', ' || user_tbl.fst_nm))
          FROM appl_ownr
          LEFT JOIN user_tbl ON appl_ownr.user_id = user_tbl.user_id
          WHERE (appl_ownr.inac_ind = 0 OR appl_ownr.inac_ind IS NULL) AND appl.appl_nm = appl_ownr.appl_nm
      ) as ownr_nm_list,
      (
          SELECT jsonb_agg(DISTINCT user_tbl.user_id)
          FROM appl_ownr
          LEFT JOIN user_tbl ON appl_ownr.user_id = user_tbl.user_id
          WHERE (appl_ownr.inac_ind = 0 OR appl_ownr.inac_ind IS NULL) AND appl.appl_nm = appl_ownr.appl_nm
      ) as ownr_id_list,
      (
          SELECT jsonb_agg(DISTINCT cli_org.org_nm order by cli_org.org_nm)
          FROM cli_func_role_appl
          JOIN cli_org cli_org ON cli_org.cli_org_id = cli_func_role_appl.cli_org_id
          WHERE appl.appl_nm = cli_func_role_appl.appl_nm
          AND cli_func_role_appl.end_dt IS NULL
          AND cli_func_role_appl.cli_func_role_appl_sts_ref_id = 2
      ) as cli_org_name_list,
      (
          SELECT jsonb_agg(DISTINCT cli_func_role_appl.cli_org_id)
          FROM cli_func_role_appl
          WHERE appl.appl_nm = cli_func_role_appl.appl_nm
          AND cli_func_role_appl.end_dt IS NULL
          AND cli_func_role_appl.cli_func_role_appl_sts_ref_id = 2
      ) as cli_org_id_list
FROM
appl appl
WHERE  (appl.inac_ind = 0 OR appl.inac_ind IS NULL)
AND appl.appl_nm IN (SELECT DISTINCT appl_nm FROM appl_ver where (inac_ind = 0 OR inac_ind IS NULL) AND appl_ver_sts_ref_id = 2);

DROP FUNCTION IF EXISTS public.search_tasks_fuzzy(text);
DROP VIEW IF EXISTS public.v_search_tasks CASCADE;

CREATE
OR REPLACE VIEW public.v_search_tasks AS
(SELECT cli_func_role.cli_func_role_als_nm         AS role_name,
        func_role.func_role_nm                     AS role_based_on,
        role_req.cli_func_role_appl_desc           AS description,
        role_req.bus_jstfy_desc -> 'justification' AS justification,
        role_req.creat_dttm                        AS submitted_date,
        cli_org.cli_org_id                         AS org_id,
        NULL                                       AS user_first_nm,
        NULL                                       AS user_last_nm,
        NULL                                       AS user_sts_ref_id,
        cli_org.org_nm                             AS client_name,
        NULL                                       AS user_current_role_start_date,
        NULL                                       AS mgr_user_fst_nm,
        NULL                                       AS mgr_user_lst_nm,
        NULL                                       AS user_requested_role,
        NULL                                       AS user_req_justification,
        NULL                                       AS application_name,
        NULL                                       AS new_version,
        NULL                                       AS old_version,
        NULL                                       AS release_notes,
        NULL                                       AS phot_lobj,
        NULL                                       AS user_id,
        role_req.appl_nm                           AS appl_nm,
        1                                          AS ref_id,
        NULL                                       AS email_id,
        NULL                                       AS appl_ownr_id,
        NULL                                       AS appl_ownr_fst_nm,
        NULL                                       AS appl_ownr_lst_nm,
        NULL                                       AS appl_ownr_email_id
 FROM   cli_func_role_appl role_req
        LEFT JOIN cli_org cli_org
               ON cli_org.cli_org_id = role_req.cli_org_id
        LEFT JOIN func_role func_role
               ON func_role.func_role_nm = role_req.func_role_nm
        LEFT JOIN cli_func_role cli_func_role
               ON (((cli_org.cli_org_id = cli_func_role.cli_org_id
                     AND func_role.func_role_nm = cli_func_role.func_role_nm)))
 WHERE  role_req.cli_func_role_appl_sts_ref_id = 1)
UNION ALL
(SELECT  cli_func_role.cli_func_role_als_nm                  AS role_name,
        NULL                                                AS role_based_on,
        NULL                                                AS description,
        NULL                                                AS justification,
        func_role_request.creat_dttm                        AS submitted_date,
        cli_org.cli_org_id                                  AS org_id,
        user_tbl.fst_nm                                     AS user_first_nm,
        user_tbl.lst_nm                                     AS user_last_nm,
        user_tbl.user_sts_ref_id                            AS user_sts_ref_id,
        cli_org.org_nm                                      AS client_name,
        user_role.strt_dt                                   AS user_current_role_start_date,
        mgr_user_tbl.fst_nm                                 AS mgr_user_fst_nm,
        mgr_user_tbl.lst_nm                                 AS mgr_user_lst_nm,
        new_role_info.func_role_nm                          AS user_requested_role,
        func_role_request.bus_jstfy_desc -> 'justification' AS user_req_justification,
        NULL                                                AS application_name,
        NULL                                                AS new_version,
        NULL                                                AS old_version,
        NULL                                                AS release_notes,
        user_tbl.phot_lobj                                  AS phot_lobj,
        user_tbl.user_id                                    AS user_id,
        NULL                                                AS appl_nm,
        2                                                   AS ref_id,
        user_tbl.email_id                                   AS email_id,
        NULL                                                AS appl_ownr_id,
        NULL                                                AS appl_ownr_fst_nm,
        NULL                                                AS appl_ownr_lst_nm,
        NULL                                                AS appl_ownr_email_id
 FROM   user_tbl user_tbl
        LEFT JOIN user_tbl mgr_user_tbl ON mgr_user_tbl.user_id = user_tbl.mgr_user_id
        LEFT JOIN user_cli_func_role_req func_role_request ON func_role_request.user_id = user_tbl.user_id
        LEFT JOIN cli_func_role cli_func_role ON (((func_role_request.cli_org_id = cli_func_role.cli_org_id AND func_role_request.func_role_nm = cli_func_role.func_role_nm)))
        LEFT JOIN user_cli_func_role user_role ON (((cli_func_role.cli_org_id = user_role.cli_org_id AND cli_func_role.func_role_nm = user_role.func_role_nm AND user_tbl.user_id = user_role.user_id)))
        LEFT JOIN func_role func_role ON func_role_request.func_role_nm = func_role.func_role_nm
        LEFT JOIN cli_org cli_org ON func_role_request.cli_org_id = cli_org.cli_org_id
        LEFT JOIN func_role new_role_info ON new_role_info.func_role_nm = func_role_request.func_role_nm
 WHERE  func_role_request.user_cli_func_role_req_sts_ref_id = 1
        AND user_tbl.user_sts_ref_id = 3316)
UNION ALL
(SELECT NULL                                               AS role_name,
        NULL                                               AS role_based_on,
        NULL                                               AS description,
        NULL                                               AS justification,
        appl_ver.creat_dttm                                AS submitted_date,
        NULL                                               AS org_id,
        NULL                                               AS user_first_nm,
        NULL                                               AS user_last_nm,
        NULL                                               AS user_sts_ref_id,
        NULL                                               AS client_name,
        NULL                                               AS user_current_role_start_date,
        NULL                                               AS mgr_user_fst_nm,
        NULL                                               AS mgr_user_lst_nm,
        NULL                                               AS user_requested_role,
        NULL                                               AS user_req_justification,
        appl_ver.appl_nm                                   AS application_name,
        appl_ver.appl_ver_id                               AS new_version,
        (SELECT MAX(older_app_ver.appl_ver_id)
         FROM   appl_ver older_app_ver
         WHERE  older_app_ver.appl_nm = appl_ver.appl_nm
                AND older_app_ver.appl_ver_sts_ref_id = 2) AS old_version,
        CAST(appl_ver.appl_ver_desc -> 'releaseNotes' as TEXT)         AS release_notes,
        NULL                                               AS phot_lobj,
        NULL                                               AS user_id,
        NULL                                               AS appl_nm,
        3                                                  AS ref_id,
        NULL                                               AS email_id,
        appl_ownr.user_id                                  AS appl_ownr_id,
        user_tbl.fst_nm                                    AS appl_ownr_fst_nm,
        user_tbl.lst_nm                                    AS appl_ownr_lst_nm,
        user_tbl.email_id                                  AS appl_ownr_email_id
 FROM   appl_ver appl_ver
        LEFT JOIN appl appl ON appl.appl_nm = appl_ver.appl_nm
        LEFT JOIN appl_ownr appl_ownr ON appl_ownr.appl_nm = appl.appl_nm
        LEFT JOIN user_tbl user_tbl ON user_tbl.user_id = appl_ownr.user_id
 WHERE  appl_ver.appl_ver_sts_ref_id = 1);

-- Create Fuzzy Search Function
CREATE OR REPLACE FUNCTION public.search_tasks_fuzzy(_search text)
RETURNS SETOF v_search_tasks
LANGUAGE sql
STABLE
AS $function$
SELECT *
FROM v_search_tasks
WHERE CAST(role_name AS text) % _search
  OR CAST(role_based_on AS text) % _search
  OR CAST(description AS text) % _search
  OR CAST(justification AS text) % _search
  OR CAST(user_first_nm AS text) % _search
  OR CAST(user_last_nm AS text) % _search
  OR CAST(client_name AS text) % _search
  OR CAST(mgr_user_fst_nm AS text) % _search
  OR CAST(mgr_user_lst_nm AS text) % _search
  OR CAST(user_requested_role AS text) % _search
  OR CAST(user_req_justification AS text) % _search
  OR CAST(application_name AS text) % _search
  OR CAST(new_version AS text) % _search
  OR CAST(old_version AS text) % _search
  OR CAST(release_notes AS text) % _search
  OR CAST(appl_ownr_email_id AS text) % _search
  OR CAST(appl_ownr_fst_nm AS text) % _search
  OR CAST(appl_ownr_lst_nm AS text) % _search
ORDER BY similarity(_search, (client_name || '' || user_last_nm || '' ||
    user_first_nm || '' || mgr_user_lst_nm || '' || mgr_user_fst_nm || '' ||
    role_name || '' || user_requested_role || '' || application_name || '' ||
    description || '' || role_based_on || '' || justification
    || '' || user_req_justification || '' || new_version || '' || old_version || '' ||
    release_notes || '' || appl_ownr_email_id || '' || appl_ownr_fst_nm || '' || appl_ownr_lst_nm))
    LIMIT 500;
$function$;

-- fuzzy search on the cli_func_role
-- added cli_org_id in search
CREATE OR REPLACE FUNCTION public.search_roles_fuzzy(_search text) RETURNS SETOF cli_func_role
    LANGUAGE sql STABLE AS $function$
SELECT
      cli_func_role.cli_org_id,
      cli_func_role.func_role_nm,                                                                                   -- searchable
      cli_func_role.creat_dttm,
      cli_func_role.creat_user_id,
      cli_func_role.chg_dttm,
      cli_func_role.chg_user_id,
      cli_func_role.updt_ver_nbr,
      cli_func_role.creat_sys_ref_id,
      cli_func_role.chg_sys_ref_id,
      cli_func_role.strt_dt,
      cli_func_role.end_dt,
      cli_func_role.cli_func_role_als_nm,
      cli_func_role.cli_func_role_desc
FROM
    cli_func_role cli_func_role
WHERE
    CAST(cli_func_role.func_role_nm AS text) % _search
    OR CAST(cli_func_role.cli_func_role_als_nm AS text) % _search
    OR CAST(cli_func_role.cli_org_id AS text) % _search
    OR CAST(cli_func_role.cli_func_role_desc AS text) % _search
    AND cli_func_role.end_dt IS NULL
ORDER BY
    similarity(_search, (cli_func_role.func_role_nm || '' || cli_func_role.cli_org_id) ) ASC
LIMIT 500;
$function$;

-- fuzzy search on the cli_org
-- added cli_org_id and cli_desc also in search
CREATE OR REPLACE FUNCTION public.search_client_fuzzy(_search text)
 RETURNS SETOF cli_org
 LANGUAGE sql
 STABLE
AS $function$
SELECT
    *
FROM
    cli_org
WHERE
    CAST(cli_org.org_nm AS text) % _search
    OR CAST(cli_org.cli_org_id AS text) % _search
    OR CAST(cli_org.cli_desc->>'description' AS text) % _search
    AND (cli_org.cli_typ_ref_id IS NULL OR cli_org.cli_typ_ref_id = 73487)
ORDER BY
    similarity(_search, (cli_org.org_nm || '' || cli_org.cli_org_id)) ASC
LIMIT 500;
$function$;

-- fuzzy search on the v_search_tasks
-- added user_id also in search
CREATE OR REPLACE FUNCTION public.search_tasks_fuzzy(_search text)
RETURNS SETOF v_search_tasks
LANGUAGE sql
STABLE
AS $function$
SELECT *
FROM v_search_tasks
WHERE CAST(role_name AS text) % _search
  OR CAST(role_based_on AS text) % _search
  OR CAST(description AS text) % _search
  OR CAST(justification AS text) % _search
  OR CAST(user_first_nm AS text) % _search
  OR CAST(user_last_nm AS text) % _search
  OR CAST(user_id AS text) % _search
  OR CAST(client_name AS text) % _search
  OR CAST(mgr_user_fst_nm AS text) % _search
  OR CAST(mgr_user_lst_nm AS text) % _search
  OR CAST(user_requested_role AS text) % _search
  OR CAST(user_req_justification AS text) % _search
  OR CAST(application_name AS text) % _search
  OR CAST(new_version AS text) % _search
  OR CAST(old_version AS text) % _search
  OR CAST(release_notes AS text) % _search
ORDER BY similarity(_search, (client_name || '' || user_last_nm || '' ||
    user_first_nm || ' ' || user_id  || '' || mgr_user_lst_nm || '' || mgr_user_fst_nm || '' ||
    role_name || '' || user_requested_role || '' || application_name || '' ||
    description || '' || role_based_on || '' || justification
    || '' || user_req_justification || '' || new_version || '' || old_version || '' ||
    release_notes)) ASC
    LIMIT 500;
$function$;

-- fuzzy search on the v_search_users
-- added user_id also in search
CREATE OR REPLACE FUNCTION public.search_users_fuzzy(_search text) RETURNS SETOF v_search_users
    LANGUAGE sql STABLE AS $function$
SELECT * FROM
    v_search_users
WHERE
    CAST(user_lst_nm AS text) % _search
    OR CAST(user_fst_nm AS text) % _search
    OR CAST(user_id AS text) % _search
    OR CAST(email_id AS text) % _search
    OR CAST(user_desc->>'phone' AS text) % _search AND user_desc::text % _search             -- searches only user_desc.phone in json
    OR CAST(mgr_user_fst_nm AS text) % _search
    OR CAST(mgr_user_lst_nm AS text) % _search
    OR CAST(full_role_list AS text) % _search
    OR CAST(full_cli_list AS text) % _search
ORDER BY
    similarity(_search, (user_lst_nm || ' ' || user_fst_nm || ' ' || user_id || ' ' || email_id || ' ' || user_desc || ' ' || mgr_user_fst_nm || ' ' || mgr_user_lst_nm ||  ' ' || full_role_list ||  ' ' || full_cli_list) ) ASC
LIMIT 500;
$function$;

DROP FUNCTION IF EXISTS public.search_tasks_fuzzy(text);
DROP VIEW IF EXISTS public.v_search_tasks CASCADE;

CREATE OR REPLACE VIEW "public"."v_search_tasks" AS 
 SELECT cli_func_role.cli_func_role_als_nm AS role_name,
    func_role.func_role_nm AS role_based_on,
    role_req.cli_func_role_appl_desc AS description,
    ((role_req.bus_jstfy_desc)::jsonb -> 'justification'::text) AS justification,
    role_req.creat_dttm AS submitted_date,
    cli_org.cli_org_id AS org_id,
    NULL::character varying AS user_first_nm,
    NULL::character varying AS user_last_nm,
    NULL::integer AS user_sts_ref_id,
    cli_org.org_nm AS client_name,
    NULL::date AS user_current_role_start_date,
    NULL::character varying AS mgr_user_fst_nm,
    NULL::character varying AS mgr_user_lst_nm,
    NULL::character varying AS user_requested_role,
    NULL::jsonb AS user_req_justification,
    NULL::text AS application_name,
    NULL::text AS new_version,
    NULL::text AS old_version,
    NULL::text AS release_notes,
    NULL::bytea AS phot_lobj,
    NULL::character varying AS user_id,
    role_req.appl_nm,
    1 AS ref_id,
    NULL::character varying AS email_id,
    NULL::jsonb AS cli_role_list,
    NULL::jsonb AS full_role_list,
    NULL::jsonb AS appl_owner_id_list,
    NULL::jsonb AS appl_owner_name_list,
    NULL::jsonb AS appl_owner_email_list
   FROM (((cli_func_role_appl role_req
     LEFT JOIN cli_org cli_org ON (((cli_org.cli_org_id)::text = (role_req.cli_org_id)::text)))
     LEFT JOIN func_role func_role ON (((func_role.func_role_nm)::text = (role_req.func_role_nm)::text)))
     LEFT JOIN cli_func_role cli_func_role ON ((((cli_org.cli_org_id)::text = (cli_func_role.cli_org_id)::text) AND ((func_role.func_role_nm)::text = (cli_func_role.func_role_nm)::text))))
  WHERE (role_req.cli_func_role_appl_sts_ref_id = 1)
UNION ALL
 SELECT cli_func_role.cli_func_role_als_nm AS role_name,
    NULL::character varying AS role_based_on,
    NULL::character varying AS description,
    NULL::jsonb AS justification,
    func_role_request.creat_dttm AS submitted_date,
    cli_org.cli_org_id AS org_id,
    user_tbl.fst_nm AS user_first_nm,
    user_tbl.lst_nm AS user_last_nm,
    user_tbl.user_sts_ref_id,
    cli_org.org_nm AS client_name,
    user_role.strt_dt AS user_current_role_start_date,
    mgr_user_tbl.fst_nm AS mgr_user_fst_nm,
    mgr_user_tbl.lst_nm AS mgr_user_lst_nm,
    new_role_info.func_role_nm AS user_requested_role,
    ((func_role_request.bus_jstfy_desc)::jsonb -> 'justification'::text) AS user_req_justification,
    NULL::text AS application_name,
    NULL::text AS new_version,
    NULL::text AS old_version,
    NULL::text AS release_notes,
    user_tbl.phot_lobj,
    user_tbl.user_id,
    NULL::character varying AS appl_nm,
    2 AS ref_id,
    user_tbl.email_id,
    ( SELECT jsonb_agg(DISTINCT cli_func_role_1.cli_func_role_als_nm ORDER BY cli_func_role_1.cli_func_role_als_nm) AS jsonb_agg
           FROM (user_cli_func_role user_cli_func_role_1
             JOIN cli_func_role cli_func_role_1 ON ((((cli_func_role_1.cli_org_id)::text = (user_cli_func_role_1.cli_org_id)::text) AND ((cli_func_role_1.func_role_nm)::text = (user_cli_func_role_1.func_role_nm)::text))))
          WHERE (((user_cli_func_role_1.user_id)::text = (user_tbl.user_id)::text) AND ((cli_org.cli_org_id)::text = (user_cli_func_role_1.cli_org_id)::text))) AS cli_role_list,
    ( SELECT jsonb_agg(DISTINCT cli_func_role_1.cli_func_role_als_nm ORDER BY cli_func_role_1.cli_func_role_als_nm) AS jsonb_agg
           FROM (user_cli_func_role user_cli_func_role_1
             JOIN cli_func_role cli_func_role_1 ON ((((cli_func_role_1.cli_org_id)::text = (user_cli_func_role_1.cli_org_id)::text) AND ((cli_func_role_1.func_role_nm)::text = (user_cli_func_role_1.func_role_nm)::text))))
          WHERE ((user_cli_func_role_1.user_id)::text = (user_tbl.user_id)::text)) AS full_role_list,
    NULL::jsonb AS appl_owner_id_list,
    NULL::jsonb AS appl_owner_name_list,
    NULL::jsonb AS appl_owner_email_list
   FROM (((((((user_tbl user_tbl
     LEFT JOIN user_tbl mgr_user_tbl ON (((mgr_user_tbl.user_id)::text = (user_tbl.mgr_user_id)::text)))
     LEFT JOIN user_cli_func_role_req func_role_request ON (((func_role_request.user_id)::text = (user_tbl.user_id)::text)))
     LEFT JOIN cli_func_role cli_func_role ON ((((func_role_request.cli_org_id)::text = (cli_func_role.cli_org_id)::text) AND ((func_role_request.func_role_nm)::text = (cli_func_role.func_role_nm)::text))))
     LEFT JOIN user_cli_func_role user_role ON ((((cli_func_role.cli_org_id)::text = (user_role.cli_org_id)::text) AND ((cli_func_role.func_role_nm)::text = (user_role.func_role_nm)::text) AND ((user_tbl.user_id)::text = (user_role.user_id)::text))))
     LEFT JOIN func_role func_role ON (((func_role_request.func_role_nm)::text = (func_role.func_role_nm)::text)))
     LEFT JOIN cli_org cli_org ON (((func_role_request.cli_org_id)::text = (cli_org.cli_org_id)::text)))
     LEFT JOIN func_role new_role_info ON (((new_role_info.func_role_nm)::text = (func_role_request.func_role_nm)::text)))
  WHERE ((func_role_request.user_cli_func_role_req_sts_ref_id = 1) AND (user_tbl.user_sts_ref_id = 3316))
UNION ALL
 SELECT DISTINCT NULL::character varying AS role_name,
    NULL::character varying AS role_based_on,
    NULL::character varying AS description,
    NULL::jsonb AS justification,
    appl_ver.creat_dttm AS submitted_date,
    NULL::character varying AS org_id,
    NULL::character varying AS user_first_nm,
    NULL::character varying AS user_last_nm,
    NULL::integer AS user_sts_ref_id,
    NULL::character varying AS client_name,
    NULL::date AS user_current_role_start_date,
    NULL::character varying AS mgr_user_fst_nm,
    NULL::character varying AS mgr_user_lst_nm,
    NULL::character varying AS user_requested_role,
    NULL::jsonb AS user_req_justification,
    ( SELECT DISTINCT appl_ver.appl_nm AS application_name) AS application_name,
    appl_ver.appl_ver_id AS new_version,
    ( SELECT max((older_app_ver.appl_ver_id)::text) AS max
           FROM appl_ver older_app_ver
          WHERE (((older_app_ver.appl_nm)::text = (appl_ver.appl_nm)::text) AND (older_app_ver.appl_ver_sts_ref_id = 2))) AS old_version,
    ((appl_ver.appl_ver_desc -> 'releaseNotes'::text))::text AS release_notes,
    NULL::bytea AS phot_lobj,
    NULL::character varying AS user_id,
    NULL::character varying AS appl_nm,
    3 AS ref_id,
    NULL::character varying AS email_id,
    NULL::jsonb AS cli_role_list,
    NULL::jsonb AS full_role_list,
    ( SELECT jsonb_agg(DISTINCT appl_ownr_1.user_id ORDER BY appl_ownr_1.user_id) AS jsonb_agg
           FROM (((appl_ver appl_ver_1
             LEFT JOIN appl appl_1 ON (((appl_1.appl_nm)::text = (appl_ver_1.appl_nm)::text)))
             LEFT JOIN appl_ownr appl_ownr_1 ON (((appl_ownr_1.appl_nm)::text = (appl.appl_nm)::text)))
             LEFT JOIN user_tbl user_tbl_1 ON (((user_tbl_1.user_id)::text = (appl_ownr_1.user_id)::text)))
          WHERE (appl_ver_1.appl_ver_sts_ref_id = 1)) AS appl_owner_id_list,
    ( SELECT jsonb_agg(DISTINCT user_tbl_1.fst_nm ORDER BY user_tbl_1.fst_nm) AS jsonb_agg
           FROM (((appl_ver appl_ver_1
             LEFT JOIN appl appl_1 ON (((appl_1.appl_nm)::text = (appl_ver_1.appl_nm)::text)))
             LEFT JOIN appl_ownr appl_ownr_1 ON (((appl_ownr_1.appl_nm)::text = (appl.appl_nm)::text)))
             LEFT JOIN user_tbl user_tbl_1 ON (((user_tbl_1.user_id)::text = (appl_ownr_1.user_id)::text)))
          WHERE (appl_ver_1.appl_ver_sts_ref_id = 1)) AS appl_owner_name_list,
    ( SELECT jsonb_agg(DISTINCT user_tbl_1.email_id ORDER BY user_tbl_1.email_id) AS jsonb_agg
           FROM (((appl_ver appl_ver_1
             LEFT JOIN appl appl_1 ON (((appl_1.appl_nm)::text = (appl_ver_1.appl_nm)::text)))
             LEFT JOIN appl_ownr appl_ownr_1 ON (((appl_ownr_1.appl_nm)::text = (appl.appl_nm)::text)))
             LEFT JOIN user_tbl user_tbl_1 ON (((user_tbl_1.user_id)::text = (appl_ownr_1.user_id)::text)))
          WHERE (appl_ver_1.appl_ver_sts_ref_id = 1)) AS appl_owner_email_list
   FROM (((appl_ver appl_ver
     LEFT JOIN appl appl ON (((appl.appl_nm)::text = (appl_ver.appl_nm)::text)))
     LEFT JOIN appl_ownr appl_ownr ON (((appl_ownr.appl_nm)::text = (appl.appl_nm)::text)))
     LEFT JOIN user_tbl user_tbl ON (((user_tbl.user_id)::text = (appl_ownr.user_id)::text)))
  WHERE (appl_ver.appl_ver_sts_ref_id = 1);


--  dependent function
  CREATE OR REPLACE FUNCTION public.search_tasks_fuzzy(_search text)
RETURNS SETOF v_search_tasks
LANGUAGE sql
STABLE
AS $function$
SELECT *
FROM v_search_tasks
WHERE CAST(role_name AS text) % _search
  OR CAST(role_based_on AS text) % _search
  OR CAST(description AS text) % _search
  OR CAST(justification AS text) % _search
  OR CAST(user_first_nm AS text) % _search
  OR CAST(user_last_nm AS text) % _search
  OR CAST(user_id AS text) % _search
  OR CAST(client_name AS text) % _search
  OR CAST(mgr_user_fst_nm AS text) % _search
  OR CAST(mgr_user_lst_nm AS text) % _search
  OR CAST(user_requested_role AS text) % _search
  OR CAST(user_req_justification AS text) % _search
  OR CAST(application_name AS text) % _search
  OR CAST(new_version AS text) % _search
  OR CAST(old_version AS text) % _search
  OR CAST(release_notes AS text) % _search
ORDER BY similarity(_search, (client_name || '' || user_last_nm || '' ||
    user_first_nm || ' ' || user_id  || '' || mgr_user_lst_nm || '' || mgr_user_fst_nm || '' ||
    role_name || '' || user_requested_role || '' || application_name || '' ||
    description || '' || role_based_on || '' || justification
    || '' || user_req_justification || '' || new_version || '' || old_version || '' ||
    release_notes)) ASC
    LIMIT 500;
$function$
CREATE OR REPLACE VIEW "public"."v_search_users" AS
 SELECT DISTINCT ON (user_tbl.user_id, cli_org.cli_org_id) user_tbl.user_id,
    user_tbl.lst_nm AS user_lst_nm,
    user_tbl.fst_nm AS user_fst_nm,
    user_tbl.email_id,
    user_tbl.user_desc,
    user_tbl.phot_lobj,
    mgr_user_tbl.fst_nm AS mgr_user_fst_nm,
    mgr_user_tbl.lst_nm AS mgr_user_lst_nm,
    cli_org.cli_org_id,
    cli_org.org_nm,
    cli_func_role.func_role_nm,
    cli_func_role.cli_func_role_als_nm,
    func_role.func_role_desc,
    ( SELECT min(user_cli_func_role_1.strt_dt) AS min
          FROM user_cli_func_role user_cli_func_role_1
          WHERE ((user_cli_func_role_1.user_id)::text = (user_tbl.user_id)::text)) AS role_strt_dt,
    ( SELECT max(user_cli_func_role_1.end_dt) AS max
          FROM user_cli_func_role user_cli_func_role_1
          WHERE ((user_cli_func_role_1.user_id)::text = (user_tbl.user_id)::text)) AS role_end_dt,
    ( SELECT jsonb_agg(DISTINCT cli_func_role_1.cli_func_role_als_nm ORDER BY cli_func_role_1.cli_func_role_als_nm) AS jsonb_agg
          FROM (user_cli_func_role user_cli_func_role_1
             JOIN cli_func_role cli_func_role_1 ON ((((cli_func_role_1.cli_org_id)::text = (user_cli_func_role_1.cli_org_id)::text) AND ((cli_func_role_1.func_role_nm)::text = (user_cli_func_role_1.func_role_nm)::text))))
          WHERE (((user_cli_func_role_1.user_id)::text = (user_tbl.user_id)::text) AND ((cli_org.cli_org_id)::text = (user_cli_func_role_1.cli_org_id)::text))) AS cli_role_list,
    ( SELECT jsonb_agg(DISTINCT cli_func_role_1.cli_func_role_als_nm ORDER BY cli_func_role_1.cli_func_role_als_nm) AS jsonb_agg
          FROM (user_cli_func_role user_cli_func_role_1
             JOIN cli_func_role cli_func_role_1 ON ((((cli_func_role_1.cli_org_id)::text = (user_cli_func_role_1.cli_org_id)::text) AND ((cli_func_role_1.func_role_nm)::text = (user_cli_func_role_1.func_role_nm)::text))))
          WHERE ((user_cli_func_role_1.user_id)::text = (user_tbl.user_id)::text)) AS full_role_list,
    ( SELECT jsonb_agg(DISTINCT cli_org_1.org_nm ORDER BY cli_org_1.org_nm) AS jsonb_agg
          FROM (user_cli_func_role user_cli_func_role_1
             JOIN cli_org cli_org_1 ON (((cli_org_1.cli_org_id)::text = (user_cli_func_role_1.cli_org_id)::text)))
          WHERE ((user_cli_func_role_1.user_id)::text = (user_tbl.user_id)::text)) AS full_cli_list,
    EXISTS(
        SELECT 1
        FROM user_cli_func_role user_cli_func_role_1
        JOIN user_tbl ON user_tbl.user_id = user_cli_func_role_1.user_id
        WHERE (user_cli_func_role_1.end_dt IS NULL OR user_cli_func_role_1.end_dt > now())
        AND (user_cli_func_role_1.user_id)::text = (user_tbl.user_id)::text
    ) AS is_active
  FROM (((((user_tbl user_tbl
     LEFT JOIN user_tbl mgr_user_tbl ON (((mgr_user_tbl.user_id)::text = (user_tbl.mgr_user_id)::text)))
     JOIN user_cli_func_role user_cli_func_role ON (((user_cli_func_role.user_id)::text = (user_tbl.user_id)::text)))
     JOIN cli_org cli_org ON (((cli_org.cli_org_id)::text = (user_cli_func_role.cli_org_id)::text)))
     JOIN cli_func_role cli_func_role ON ((((cli_func_role.cli_org_id)::text = (user_cli_func_role.cli_org_id)::text) AND ((cli_func_role.func_role_nm)::text = (user_cli_func_role.func_role_nm)::text))))
     JOIN func_role func_role ON (((func_role.func_role_nm)::text = (cli_func_role.func_role_nm)::text)));
ALTER TABLE USER_CLI_FUNC_ROLE
ADD COLUMN IF NOT EXISTS sgnon_dflt_ind SMALLINT NULL;
ALTER TABLE APPL_OWNR
ADD COLUMN IF NOT EXISTS appl_ownr_role_ref_id INTEGER NOT NULL DEFAULT 20190;

ALTER TABLE APPL_OWNR
ALTER appl_ownr_role_ref_id DROP DEFAULT,
DROP CONSTRAINT APPL_OWNR_PK;

ALTER TABLE APPL_OWNR
ADD CONSTRAINT APPL_OWNR_PK PRIMARY KEY (appl_nm, user_id, appl_ownr_role_ref_id);

ALTER TABLE OTP_SRVC_REQ
ADD COLUMN IF NOT EXISTS user_authn_lvl_nbr SMALLINT NULL;

--  UPDATE SEARCH_USER_VIEW

CREATE OR REPLACE VIEW "public"."v_search_users" AS
 SELECT DISTINCT ON (user_tbl.user_id, cli_org.cli_org_id) user_tbl.user_id,
    user_tbl.lst_nm AS user_lst_nm,
    user_tbl.fst_nm AS user_fst_nm,
    user_tbl.email_id,
    user_tbl.user_desc,
    user_tbl.phot_lobj,
    mgr_user_tbl.fst_nm AS mgr_user_fst_nm,
    mgr_user_tbl.lst_nm AS mgr_user_lst_nm,
    cli_org.cli_org_id,
    cli_org.org_nm,
    cli_func_role.func_role_nm,
    cli_func_role.cli_func_role_als_nm,
    func_role.func_role_desc,
    ( SELECT min(user_cli_func_role_1.strt_dt) AS min
           FROM user_cli_func_role user_cli_func_role_1
          WHERE ((user_cli_func_role_1.user_id)::text = (user_tbl.user_id)::text)) AS role_strt_dt,
    ( SELECT max(user_cli_func_role_1.end_dt) AS max
           FROM user_cli_func_role user_cli_func_role_1
          WHERE ((user_cli_func_role_1.user_id)::text = (user_tbl.user_id)::text)) AS role_end_dt,
    ( SELECT jsonb_agg(DISTINCT cli_func_role_1.cli_func_role_als_nm ORDER BY cli_func_role_1.cli_func_role_als_nm) AS jsonb_agg
           FROM (user_cli_func_role user_cli_func_role_1
             JOIN cli_func_role cli_func_role_1 ON ((((cli_func_role_1.cli_org_id)::text = (user_cli_func_role_1.cli_org_id)::text) AND ((cli_func_role_1.func_role_nm)::text = (user_cli_func_role_1.func_role_nm)::text))))
          WHERE (((user_cli_func_role_1.user_id)::text = (user_tbl.user_id)::text) AND ((cli_org.cli_org_id)::text = (user_cli_func_role_1.cli_org_id)::text))) AS cli_role_list,
    ( SELECT jsonb_agg(DISTINCT cli_func_role_1.cli_func_role_als_nm ORDER BY cli_func_role_1.cli_func_role_als_nm) AS jsonb_agg
           FROM (user_cli_func_role user_cli_func_role_1
             JOIN cli_func_role cli_func_role_1 ON ((((cli_func_role_1.cli_org_id)::text = (user_cli_func_role_1.cli_org_id)::text) AND ((cli_func_role_1.func_role_nm)::text = (user_cli_func_role_1.func_role_nm)::text))))
          WHERE ((user_cli_func_role_1.user_id)::text = (user_tbl.user_id)::text)) AS full_role_list,
    ( SELECT jsonb_agg(DISTINCT cli_org_1.org_nm ORDER BY cli_org_1.org_nm) AS jsonb_agg
           FROM (user_cli_func_role user_cli_func_role_1
             JOIN cli_org cli_org_1 ON (((cli_org_1.cli_org_id)::text = (user_cli_func_role_1.cli_org_id)::text)))
          WHERE ((user_cli_func_role_1.user_id)::text = (user_tbl.user_id)::text)) AS full_cli_list,
    (EXISTS ( SELECT 1
           FROM (user_cli_func_role user_cli_func_role_1
             JOIN user_tbl user_tbl_1 ON (((user_tbl_1.user_id)::text = (user_cli_func_role_1.user_id)::text)))
          WHERE (((user_cli_func_role_1.end_dt IS NULL) OR (user_cli_func_role_1.end_dt > now())) AND ((user_cli_func_role_1.user_id)::text = (user_tbl_1.user_id)::text)))) AS is_active
   FROM (((((user_tbl user_tbl
     LEFT JOIN user_tbl mgr_user_tbl ON (((mgr_user_tbl.user_id)::text = (user_tbl.mgr_user_id)::text)))
     LEFT JOIN user_cli_func_role user_cli_func_role ON (((user_cli_func_role.user_id)::text = (user_tbl.user_id)::text)))
     LEFT JOIN cli_org cli_org ON (((cli_org.cli_org_id)::text = (user_cli_func_role.cli_org_id)::text)))
     LEFT JOIN cli_func_role cli_func_role ON ((((cli_func_role.cli_org_id)::text = (user_cli_func_role.cli_org_id)::text) AND ((cli_func_role.func_role_nm)::text = (user_cli_func_role.func_role_nm)::text))))
     LEFT JOIN func_role func_role ON (((func_role.func_role_nm)::text = (cli_func_role.func_role_nm)::text)));


--  UPDATE SERACH FUZZY FUNCTION
CREATE OR REPLACE FUNCTION public.search_users_fuzzy(_search text)
 RETURNS SETOF v_search_users
 LANGUAGE sql
 STABLE
AS $function$
SELECT * FROM
    v_search_users
WHERE
    CAST(user_lst_nm AS text) % _search
    OR CAST(user_fst_nm AS text) % _search
    OR CAST(user_id AS text) % _search
    OR CAST(full_role_list AS text) % _search
    OR CAST(full_cli_list AS text) % _search
ORDER BY
    similarity(_search, (user_lst_nm || ' ' || user_fst_nm || ' ' || user_id || ' ' || full_role_list || ' ' || full_cli_list) ) DESC
LIMIT 500;
$function$;
