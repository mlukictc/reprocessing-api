--
-- PostgreSQL database dump
--

\restrict UXnMPFBLlmAk8UnUqZQSA46ehOc2Yd1f6wh8OhYaXJ6d7wrc7KrSvC0tReeB6YJ

-- Dumped from database version 18.3 (Debian 18.3-1.pgdg13+1)
-- Dumped by pg_dump version 18.3 (Debian 18.3-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: private; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA private;


ALTER SCHEMA private OWNER TO postgres;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- Name: postgres_fdw; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgres_fdw WITH SCHEMA public;


--
-- Name: EXTENSION postgres_fdw; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgres_fdw IS 'foreign-data wrapper for remote PostgreSQL servers';


--
-- Name: foreign_server; Type: SERVER; Schema: -; Owner: postgres
--

CREATE SERVER foreign_server FOREIGN DATA WRAPPER postgres_fdw OPTIONS (
    dbname 'InterfaceX_person',
    host 'localhost',
    port '5432'
);


ALTER SERVER foreign_server OWNER TO postgres;

--
-- Name: USER MAPPING postgres SERVER foreign_server; Type: USER MAPPING; Schema: -; Owner: postgres
--

CREATE USER MAPPING FOR postgres SERVER foreign_server OPTIONS (
    password 'admin',
    "user" 'postgres'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: p_deviceuseretd5; Type: TABLE; Schema: private; Owner: postgres
--

CREATE TABLE private.p_deviceuseretd5 (
    useraccount_id integer NOT NULL,
    username character varying,
    pin character varying,
    pinhashed character varying,
    pinsalt character varying,
    formerauthdata character varying,
    lastmodificationinsec integer DEFAULT 0 NOT NULL,
    isincomplete boolean NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL
);


ALTER TABLE private.p_deviceuseretd5 OWNER TO postgres;

--
-- Name: p_logbook; Type: TABLE; Schema: private; Owner: postgres
--

CREATE TABLE private.p_logbook (
    logbook_id integer NOT NULL,
    textualcontent text,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL
);


ALTER TABLE private.p_logbook OWNER TO postgres;

--
-- Name: p_person; Type: TABLE; Schema: private; Owner: postgres
--

CREATE TABLE private.p_person (
    useraccount_id integer NOT NULL,
    username character varying,
    firstname character varying,
    lastname character varying,
    dateofbirth date,
    employeenumber character varying,
    socialsecurityno character varying,
    localpassword character varying,
    distinguishedname character varying,
    customfield1 character varying,
    customfield2 character varying,
    customfield3 character varying,
    customfield4 character varying,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean NOT NULL,
    isincomplete boolean NOT NULL,
    middlename character varying
);


ALTER TABLE private.p_person OWNER TO postgres;

--
-- Name: actionreason; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.actionreason (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.actionreason OWNER TO postgres;

--
-- Name: attachment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attachment (
    id integer NOT NULL,
    filename character varying,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL,
    data bytea
);


ALTER TABLE public.attachment OWNER TO postgres;

--
-- Name: attachment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.attachment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.attachment_id_seq OWNER TO postgres;

--
-- Name: attachment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.attachment_id_seq OWNED BY public.attachment.id;


--
-- Name: batch; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.batch (
    id integer NOT NULL,
    reprocessingdevice_id integer NOT NULL,
    devicebatchid integer NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public.batch OWNER TO postgres;

--
-- Name: batch_has_endoscope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.batch_has_endoscope (
    batch_id integer NOT NULL,
    endoscope_id integer NOT NULL
);


ALTER TABLE public.batch_has_endoscope OWNER TO postgres;

--
-- Name: batch_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.batch_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.batch_id_seq OWNER TO postgres;

--
-- Name: batch_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.batch_id_seq OWNED BY public.batch.id;


--
-- Name: checklist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.checklist (
    id integer NOT NULL,
    reprocessingstation_id integer NOT NULL,
    name character varying,
    description text,
    ismandatory boolean,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL,
    minduration integer NOT NULL,
    mintimeunit integer NOT NULL,
    maxduration integer NOT NULL,
    maxtimeunit integer NOT NULL,
    isdefaultchecklist boolean NOT NULL,
    isrelease boolean NOT NULL,
    infotext character varying,
    isquickscan boolean DEFAULT false NOT NULL,
    isonescanapproach boolean DEFAULT false NOT NULL,
    isconfirmallenabled boolean DEFAULT false NOT NULL
);


ALTER TABLE public.checklist OWNER TO postgres;

--
-- Name: checklist_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.checklist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.checklist_id_seq OWNER TO postgres;

--
-- Name: checklist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.checklist_id_seq OWNED BY public.checklist.id;


--
-- Name: checklistitem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.checklistitem (
    id integer NOT NULL,
    checklist_id integer NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL,
    displaytext character varying NOT NULL,
    ismandatory boolean NOT NULL,
    ordernr integer NOT NULL,
    infotext character varying,
    filedisplayname character varying
);


ALTER TABLE public.checklistitem OWNER TO postgres;

--
-- Name: checklistitem_has_attachment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.checklistitem_has_attachment (
    id integer NOT NULL,
    attachment_id integer NOT NULL,
    checklistitem_id integer NOT NULL,
    checklistitem_checklist_id integer CONSTRAINT checklistitem_has_attachmen_checklistitem_checklist_id_not_null NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL
);


ALTER TABLE public.checklistitem_has_attachment OWNER TO postgres;

--
-- Name: checklistitem_has_attachment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.checklistitem_has_attachment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.checklistitem_has_attachment_id_seq OWNER TO postgres;

--
-- Name: checklistitem_has_attachment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.checklistitem_has_attachment_id_seq OWNED BY public.checklistitem_has_attachment.id;


--
-- Name: checklistitem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.checklistitem_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.checklistitem_id_seq OWNER TO postgres;

--
-- Name: checklistitem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.checklistitem_id_seq OWNED BY public.checklistitem.id;


--
-- Name: chemicalstype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chemicalstype (
    id integer NOT NULL,
    name character varying NOT NULL,
    enumchemicalname character varying
);


ALTER TABLE public.chemicalstype OWNER TO postgres;

--
-- Name: confirmationprotocol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.confirmationprotocol (
    id integer NOT NULL,
    reprocessingstation_id integer NOT NULL,
    reprocessinghistoryitem_id integer NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL
);


ALTER TABLE public.confirmationprotocol OWNER TO postgres;

--
-- Name: confirmationprotocol_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.confirmationprotocol_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.confirmationprotocol_id_seq OWNER TO postgres;

--
-- Name: confirmationprotocol_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.confirmationprotocol_id_seq OWNED BY public.confirmationprotocol.id;


--
-- Name: connectionstatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.connectionstatus (
    id integer NOT NULL,
    connectionstate character varying,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean,
    isdisabled boolean
);


ALTER TABLE public.connectionstatus OWNER TO postgres;

--
-- Name: contamination; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contamination (
    id integer NOT NULL,
    reprocessinghistoryitem_id integer NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL,
    ispatientuse boolean NOT NULL,
    startedat timestamp without time zone,
    endedat timestamp without time zone,
    statusconfirmed character varying,
    commenttext character varying,
    externalsystem character varying,
    externalreference character varying,
    externalexamination_id character varying,
    externalversion character varying,
    location character varying(255)
);


ALTER TABLE public.contamination OWNER TO postgres;

--
-- Name: contamination_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contamination_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contamination_id_seq OWNER TO postgres;

--
-- Name: contamination_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contamination_id_seq OWNED BY public.contamination.id;


--
-- Name: currentdata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.currentdata (
    reprocessingdevice_id integer CONSTRAINT etddcurrentdata_reprocessingdevice_id_not_null NOT NULL,
    connectionstatus_id integer CONSTRAINT etddcurrentdata_connectionstatus_id_not_null NOT NULL,
    deviceinfo character varying,
    reprocessingstatus_id integer NOT NULL,
    lastconnected timestamp without time zone,
    estimatedprogramend timestamp without time zone,
    usersynchstatus_id integer DEFAULT 1 NOT NULL,
    endoscopesynchstatus_id integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.currentdata OWNER TO postgres;

--
-- Name: cycle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cycle (
    id integer NOT NULL,
    reprocessinginstruction_id integer,
    endoscope_id integer NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    starttime timestamp without time zone NOT NULL,
    endtime timestamp without time zone,
    ispending boolean NOT NULL,
    cyclestate_id integer DEFAULT 1 NOT NULL,
    statustime timestamp without time zone NOT NULL,
    statusexpirationtime timestamp without time zone NOT NULL,
    contaminationstart timestamp without time zone,
    reprocessingstart timestamp without time zone,
    startcontamination_id integer,
    reprocessingend timestamp without time zone,
    startcyclestate_id integer NOT NULL,
    startstateexpirationtime timestamp without time zone NOT NULL,
    cyclefinishedreason_id integer
);


ALTER TABLE public.cycle OWNER TO postgres;

--
-- Name: cycle_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cycle_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cycle_id_seq OWNER TO postgres;

--
-- Name: cycle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cycle_id_seq OWNED BY public.cycle.id;


--
-- Name: cyclefinishedreason; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cyclefinishedreason (
    id integer NOT NULL,
    name character varying NOT NULL,
    description character varying NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL
);


ALTER TABLE public.cyclefinishedreason OWNER TO postgres;

--
-- Name: cyclefinishedreason_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cyclefinishedreason_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cyclefinishedreason_id_seq OWNER TO postgres;

--
-- Name: cyclefinishedreason_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cyclefinishedreason_id_seq OWNED BY public.cyclefinishedreason.id;


--
-- Name: cyclelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cyclelog (
    id integer NOT NULL,
    endoscope_id integer NOT NULL,
    instruction_id integer,
    constraint_id integer,
    reprocessingdevice_id integer,
    cycle_id integer NOT NULL,
    protocol_id integer NOT NULL,
    reprocessingstationfrom_id integer,
    reprocessingstationto_id integer,
    reprocessingcompensationstation_id integer,
    cyclestependstate integer NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    constraintbrokenat timestamp without time zone,
    reprocessingdeviceerror character varying,
    logbook_id integer,
    user_id integer
);


ALTER TABLE public.cyclelog OWNER TO postgres;

--
-- Name: cyclelog_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cyclelog_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cyclelog_id_seq OWNER TO postgres;

--
-- Name: cyclelog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cyclelog_id_seq OWNED BY public.cyclelog.id;


--
-- Name: cyclestate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cyclestate (
    id integer NOT NULL,
    name character varying NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL
);


ALTER TABLE public.cyclestate OWNER TO postgres;

--
-- Name: cyclestate_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cyclestate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cyclestate_id_seq OWNER TO postgres;

--
-- Name: cyclestate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cyclestate_id_seq OWNED BY public.cyclestate.id;


--
-- Name: cyclestationinfo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cyclestationinfo (
    id integer NOT NULL,
    cycle_id integer NOT NULL,
    reprocessingstation_id integer NOT NULL,
    cyclestep_id integer,
    cyclestationstate_id integer NOT NULL,
    creationdate timestamp without time zone NOT NULL
);


ALTER TABLE public.cyclestationinfo OWNER TO postgres;

--
-- Name: cyclestationinfo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cyclestationinfo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cyclestationinfo_id_seq OWNER TO postgres;

--
-- Name: cyclestationinfo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cyclestationinfo_id_seq OWNED BY public.cyclestationinfo.id;


--
-- Name: cyclestationstate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cyclestationstate (
    id integer NOT NULL,
    name character varying DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.cyclestationstate OWNER TO postgres;

--
-- Name: cyclestep; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cyclestep (
    id integer NOT NULL,
    cycle_id integer NOT NULL,
    reprocessinghistoryitem_id integer NOT NULL,
    reprocessingstation_id integer,
    starttime timestamp without time zone NOT NULL,
    endtime timestamp without time zone,
    success boolean NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    retroactive boolean DEFAULT false NOT NULL
);


ALTER TABLE public.cyclestep OWNER TO postgres;

--
-- Name: cyclestep_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cyclestep_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cyclestep_id_seq OWNER TO postgres;

--
-- Name: cyclestep_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cyclestep_id_seq OWNED BY public.cyclestep.id;


--
-- Name: cyclestependstate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cyclestependstate (
    id integer NOT NULL,
    enum_value character varying NOT NULL,
    display_value character varying NOT NULL
);


ALTER TABLE public.cyclestependstate OWNER TO postgres;

--
-- Name: cyclestepqueue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cyclestepqueue (
    id integer NOT NULL,
    endoscope_id integer NOT NULL,
    reprocessinghistoryitem_id integer NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    starttime timestamp without time zone NOT NULL,
    endtime timestamp without time zone,
    retroactivehandled boolean DEFAULT false NOT NULL
);


ALTER TABLE public.cyclestepqueue OWNER TO postgres;

--
-- Name: cyclestepqueue_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cyclestepqueue_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cyclestepqueue_id_seq OWNER TO postgres;

--
-- Name: cyclestepqueue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cyclestepqueue_id_seq OWNED BY public.cyclestepqueue.id;


--
-- Name: department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department (
    id integer NOT NULL,
    departmentname character varying,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL,
    isdisabled boolean NOT NULL
);


ALTER TABLE public.department OWNER TO postgres;

--
-- Name: department_endoscopetype_instruction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department_endoscopetype_instruction (
    id integer NOT NULL,
    department_id integer,
    endoscopetype_id integer,
    reprocessinginstruction_id integer CONSTRAINT department_endoscopetype_in_reprocessinginstruction_id_not_null NOT NULL,
    creationdate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    lastedit timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    isdeleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public.department_endoscopetype_instruction OWNER TO postgres;

--
-- Name: department_endoscopetype_instruction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.department_endoscopetype_instruction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.department_endoscopetype_instruction_id_seq OWNER TO postgres;

--
-- Name: department_endoscopetype_instruction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.department_endoscopetype_instruction_id_seq OWNED BY public.department_endoscopetype_instruction.id;


--
-- Name: department_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.department_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.department_id_seq OWNER TO postgres;

--
-- Name: department_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.department_id_seq OWNED BY public.department.id;


--
-- Name: deviceuseredc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deviceuseredc (
    useraccount_id integer NOT NULL,
    staffpin character varying,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean NOT NULL,
    isincomplete boolean CONSTRAINT deviceuseredc_isquarantined_not_null NOT NULL
);


ALTER TABLE public.deviceuseredc OWNER TO postgres;

--
-- Name: deviceuseretd34; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deviceuseretd34 (
    useraccount_id integer NOT NULL,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean NOT NULL,
    isincomplete boolean CONSTRAINT deviceuseretd34_isquarantined_not_null NOT NULL
);


ALTER TABLE public.deviceuseretd34 OWNER TO postgres;

--
-- Name: deviceuseretddouble; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deviceuseretddouble (
    useraccount_id integer NOT NULL,
    username character varying,
    accesscode character varying,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean NOT NULL,
    isincomplete boolean CONSTRAINT deviceuseretddouble_isquarantined_not_null NOT NULL
);


ALTER TABLE public.deviceuseretddouble OWNER TO postgres;

--
-- Name: edcadaptergroup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.edcadaptergroup (
    id integer NOT NULL,
    edcconfig_reprocessingdevice_id integer NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL,
    "position" integer NOT NULL,
    adaptergroup character varying NOT NULL
);


ALTER TABLE public.edcadaptergroup OWNER TO postgres;

--
-- Name: edcadaptergroup_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.edcadaptergroup_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.edcadaptergroup_id_seq OWNER TO postgres;

--
-- Name: edcadaptergroup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.edcadaptergroup_id_seq OWNED BY public.edcadaptergroup.id;


--
-- Name: edcconfig; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.edcconfig (
    reprocessingdevice_id integer NOT NULL,
    unitcode character varying NOT NULL,
    endoscopecapacity integer NOT NULL,
    ipaddress character varying
);


ALTER TABLE public.edcconfig OWNER TO postgres;

--
-- Name: edcreprocessingprotocol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.edcreprocessingprotocol (
    id integer NOT NULL,
    reprocessinghistoryitem_id integer NOT NULL,
    scopekey integer NOT NULL,
    unitkey integer NOT NULL,
    cabinetposition integer,
    staffkeystart integer,
    staffkeyend integer,
    protocolstart timestamp without time zone,
    protocolend timestamp without time zone,
    result integer,
    scopelogkey integer,
    adaptergrouptypename character varying,
    connectiontime integer,
    flow integer,
    minpressure integer,
    maxpressure integer,
    dryingtime integer,
    storagetime integer,
    minvalve integer,
    maxvalve integer,
    predryperiod integer,
    predryflow integer,
    ontimepredryperiod integer,
    offtimepredryperiod integer,
    ontimedryingperiod integer,
    offtimedryingperiod integer,
    ontimestorageperiod integer,
    offtimestorageperiod integer,
    rawdata character varying DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.edcreprocessingprotocol OWNER TO postgres;

--
-- Name: edcreprocessingprotocol_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.edcreprocessingprotocol_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.edcreprocessingprotocol_id_seq OWNER TO postgres;

--
-- Name: edcreprocessingprotocol_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.edcreprocessingprotocol_id_seq OWNED BY public.edcreprocessingprotocol.id;


--
-- Name: endoscan_has_reprocessingdevice; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.endoscan_has_reprocessingdevice (
    endoscan_id integer NOT NULL,
    reprocessingdevice_id integer NOT NULL,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    tcpport smallint,
    port smallint
);


ALTER TABLE public.endoscan_has_reprocessingdevice OWNER TO postgres;

--
-- Name: endoscanconfig; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.endoscanconfig (
    reprocessingdevice_id integer NOT NULL,
    ipadress character varying NOT NULL,
    port integer NOT NULL,
    mergedata boolean NOT NULL
);


ALTER TABLE public.endoscanconfig OWNER TO postgres;

--
-- Name: endoscope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.endoscope (
    id integer NOT NULL,
    endoscopetype_id integer,
    serialnumber character varying,
    productionidentifier character varying,
    isloanerdevice boolean NOT NULL,
    purchaseddate date,
    retiredate date,
    customdescription text,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL,
    isdisabled boolean NOT NULL,
    customcolumn1 character varying,
    customcolumn2 character varying,
    customcolumn3 character varying,
    customcolumn4 character varying,
    customcolumn5 character varying,
    customcolumn6 character varying,
    customcolumn7 character varying,
    customcolumn8 character varying,
    customcolumn9 character varying,
    customcolumn10 character varying,
    isquarantine boolean DEFAULT false NOT NULL,
    internalid character varying,
    inventorynumber character varying
);


ALTER TABLE public.endoscope OWNER TO postgres;

--
-- Name: endoscope_has_department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.endoscope_has_department (
    id integer NOT NULL,
    endoscope_id integer NOT NULL,
    department_id integer NOT NULL,
    startdate timestamp without time zone,
    enddate timestamp without time zone,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL
);


ALTER TABLE public.endoscope_has_department OWNER TO postgres;

--
-- Name: endoscope_has_department_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.endoscope_has_department_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.endoscope_has_department_id_seq OWNER TO postgres;

--
-- Name: endoscope_has_department_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.endoscope_has_department_id_seq OWNED BY public.endoscope_has_department.id;


--
-- Name: endoscope_has_identifier; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.endoscope_has_identifier (
    id integer NOT NULL,
    identifier_id integer NOT NULL,
    endoscope_id integer NOT NULL,
    startdate timestamp without time zone,
    enddate timestamp without time zone,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean NOT NULL
);


ALTER TABLE public.endoscope_has_identifier OWNER TO postgres;

--
-- Name: endoscope_has_identifier_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.endoscope_has_identifier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.endoscope_has_identifier_id_seq OWNER TO postgres;

--
-- Name: endoscope_has_identifier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.endoscope_has_identifier_id_seq OWNED BY public.endoscope_has_identifier.id;


--
-- Name: endoscope_has_logbook; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.endoscope_has_logbook (
    endoscope_id integer NOT NULL,
    logbook_id integer NOT NULL,
    lastedit timestamp without time zone,
    isdeleted boolean,
    isdisabled boolean,
    creationdate timestamp without time zone
);


ALTER TABLE public.endoscope_has_logbook OWNER TO postgres;

--
-- Name: endoscope_has_reprocessighistoryitems; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.endoscope_has_reprocessighistoryitems (
    id bigint NOT NULL,
    endoscope_id integer,
    reprocessinghistoryitem_id integer CONSTRAINT endoscope_has_reprocessighi_reprocessinghistoryitem_id_not_null NOT NULL,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean,
    isdisabled boolean,
    level character varying
);


ALTER TABLE public.endoscope_has_reprocessighistoryitems OWNER TO postgres;

--
-- Name: endoscope_has_reprocessighistoryitems_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.endoscope_has_reprocessighistoryitems_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.endoscope_has_reprocessighistoryitems_id_seq OWNER TO postgres;

--
-- Name: endoscope_has_reprocessighistoryitems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.endoscope_has_reprocessighistoryitems_id_seq OWNED BY public.endoscope_has_reprocessighistoryitems.id;


--
-- Name: endoscope_has_task; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.endoscope_has_task (
    id integer NOT NULL,
    task_id integer NOT NULL,
    endoscope_id integer NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL,
    isdisabled boolean NOT NULL,
    startmaintenancedate timestamp without time zone NOT NULL
);


ALTER TABLE public.endoscope_has_task OWNER TO postgres;

--
-- Name: endoscope_has_task_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.endoscope_has_task_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.endoscope_has_task_id_seq OWNER TO postgres;

--
-- Name: endoscope_has_task_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.endoscope_has_task_id_seq OWNED BY public.endoscope_has_task.id;


--
-- Name: endoscope_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.endoscope_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.endoscope_id_seq OWNER TO postgres;

--
-- Name: endoscope_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.endoscope_id_seq OWNED BY public.endoscope.id;


--
-- Name: endoscopereprocessingstatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.endoscopereprocessingstatus (
    endoscope_id integer NOT NULL,
    cyclestate_id integer NOT NULL,
    statustime timestamp without time zone NOT NULL,
    statusexpirationtime timestamp without time zone NOT NULL,
    laststation_id integer,
    runningstation_id integer,
    pendingstation_id integer,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    expectedreprocessingend timestamp without time zone,
    expectedstorageend timestamp without time zone,
    delayed boolean DEFAULT false NOT NULL
);


ALTER TABLE public.endoscopereprocessingstatus OWNER TO postgres;

--
-- Name: endoscopetype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.endoscopetype (
    id integer NOT NULL,
    manufacturer_id integer NOT NULL,
    typename character varying,
    articlenumber character varying,
    deviceidentifier character varying,
    internalordernumber character varying,
    numberofchannels smallint NOT NULL,
    hasalbaranchannel boolean NOT NULL,
    customdescription text,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL,
    customcolumn1 character varying,
    customcolumn2 character varying,
    customcolumn3 character varying,
    customcolumn4 character varying,
    customcolumn5 character varying,
    customcolumn6 character varying,
    customcolumn7 character varying,
    customcolumn8 character varying,
    customcolumn9 character varying,
    customcolumn10 character varying,
    olympusdefined boolean NOT NULL,
    actionreason_id integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.endoscopetype OWNER TO postgres;

--
-- Name: identifier; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identifier (
    id integer NOT NULL,
    identifiertype_id integer NOT NULL,
    value character varying,
    islocked boolean,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean NOT NULL,
    isdisabled boolean NOT NULL,
    iscancelcode boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identifier OWNER TO postgres;

--
-- Name: identifiertype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identifiertype (
    id integer NOT NULL,
    typename character varying,
    description text,
    creationtime timestamp without time zone,
    lastedit timestamp without time zone,
    givenname character varying,
    isenabledforendoscopes boolean DEFAULT false NOT NULL,
    isenabledforusers boolean DEFAULT false NOT NULL,
    isenabledforreprocessingdevices boolean DEFAULT false NOT NULL,
    isenabledforcancelquickscan boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identifiertype OWNER TO postgres;

--
-- Name: manufacturer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.manufacturer (
    id integer NOT NULL,
    name character varying,
    street character varying,
    streetnumber character varying,
    postcode character varying,
    city character varying,
    country character varying,
    email text,
    phonenumber text,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL
);


ALTER TABLE public.manufacturer OWNER TO postgres;

--
-- Name: reprocessinginstruction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reprocessinginstruction (
    id integer NOT NULL,
    name character varying,
    description text,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL,
    isdefaultinstruction boolean DEFAULT false NOT NULL
);


ALTER TABLE public.reprocessinginstruction OWNER TO postgres;

--
-- Name: reprocessingstation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reprocessingstation (
    id integer NOT NULL,
    reprocessinginstruction_id integer NOT NULL,
    ismandatory boolean NOT NULL,
    sequencenumber smallint NOT NULL,
    name character varying,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL,
    profil_id integer,
    compensationstation_id integer,
    infotext character varying,
    printsettings_id integer,
    filedisplayname character varying,
    symbolid integer DEFAULT 0 NOT NULL,
    expecteddurationinmins integer
);


ALTER TABLE public.reprocessingstation OWNER TO postgres;

--
-- Name: setting; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.setting (
    id integer NOT NULL,
    key character varying NOT NULL,
    value character varying,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    apipermission integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.setting OWNER TO postgres;

--
-- Name: endoscope_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.endoscope_view AS
 SELECT endoscope.id,
    endoscope.isdeleted,
    COALESCE(endoscope.serialnumber, ''::character varying) AS serialnumber,
    COALESCE(endoscope.internalid, ''::character varying) AS internalid,
    concat_ws(' '::text, NULLIF((endoscopetype.deviceidentifier)::text, ''::text), NULLIF((endoscope.productionidentifier)::text, ''::text)) AS udi,
    endoscope.isloanerdevice AS isloaner,
    COALESCE(endoscope.customdescription, ''::text) AS customdescription,
    endoscope.purchaseddate AS purchasedate,
    endoscope.retiredate,
    endoscope.customcolumn1,
    endoscope.customcolumn2,
    endoscope.customcolumn3,
    endoscope.customcolumn4,
    endoscope.customcolumn5,
    endoscope.customcolumn6,
    endoscope.customcolumn7,
    endoscope.customcolumn8,
    endoscope.customcolumn9,
    endoscope.customcolumn10,
    COALESCE(manufacturer.name, ''::character varying) AS manufacturer,
    COALESCE(endoscopetype.typename, ''::character varying) AS endoscopetype,
    COALESCE(endoscopetype.hasalbaranchannel, false) AS hasalbaranchannel,
    COALESCE(endoscopetype.numberofchannels, (0)::smallint) AS numberofchannels,
    endoscope.isdisabled,
    endoscope.isquarantine AS isquarantined,
    COALESCE(cyclestate.name, ''::character varying) AS cyclestate,
        CASE
            WHEN ((EXISTS ( SELECT 1
               FROM public.setting
              WHERE (((setting.key)::text = 'Department.IsDepartmentEnabled'::text) AND ((setting.value)::text = 'True'::text) AND (setting.isdeleted = false)))) AND (EXISTS ( SELECT 1
               FROM public.endoscope_has_department ehd_check
              WHERE ((ehd_check.endoscope_id = endoscope.id) AND (ehd_check.isdeleted = false))))) THEN COALESCE(( SELECT
                    CASE
                        WHEN (count(DISTINCT d.departmentname) = 1) THEN string_agg(DISTINCT (ri.name)::text, ' | '::text)
                        ELSE string_agg(DISTINCT concat_ws(': '::text, d.departmentname, ri.name), ' | '::text)
                    END AS string_agg
               FROM (((public.endoscope_has_department ehd
                 JOIN public.department d ON (((d.id = ehd.department_id) AND (d.isdeleted = false))))
                 JOIN public.department_endoscopetype_instruction dei ON (((dei.department_id = ehd.department_id) AND (dei.endoscopetype_id = endoscope.endoscopetype_id) AND (dei.isdeleted = false))))
                 JOIN public.reprocessinginstruction ri ON (((ri.id = dei.reprocessinginstruction_id) AND (ri.isdeleted = false))))
              WHERE ((ehd.endoscope_id = endoscope.id) AND (ehd.isdeleted = false))), ''::text)
            ELSE COALESCE(( SELECT string_agg((ri.name)::text, ' | '::text) AS string_agg
               FROM (public.department_endoscopetype_instruction dei
                 JOIN public.reprocessinginstruction ri ON ((ri.id = dei.reprocessinginstruction_id)))
              WHERE ((dei.endoscopetype_id = endoscope.endoscopetype_id) AND (dei.isdeleted = false) AND (ri.isdeleted = false))), ''::text)
        END AS instructionsdisplayname,
    COALESCE(( SELECT string_agg(concat_ws(': '::text, identifiertype.givenname, identifier.value), ' '::text) AS string_agg
           FROM public.endoscope_has_identifier,
            public.identifier,
            public.identifiertype
          WHERE ((endoscope_has_identifier.endoscope_id = endoscope.id) AND (identifier.id = endoscope_has_identifier.identifier_id) AND (identifiertype.id = identifier.identifiertype_id) AND (endoscope_has_identifier.isdeleted = false))), (''::character varying)::text) AS associatedidentifiers,
    ( SELECT string_agg((department.departmentname)::text, ', '::text) AS string_agg
           FROM public.endoscope_has_department,
            public.department
          WHERE ((endoscope_has_department.department_id = department.id) AND (endoscope_has_department.endoscope_id = endoscope.id) AND (endoscope_has_department.isdeleted = false))) AS department,
        CASE
            WHEN (runningstation.name IS NOT NULL) THEN runningstation.name
            ELSE
            CASE
                WHEN (laststation.name IS NOT NULL) THEN laststation.name
                ELSE '-'::character varying
            END
        END AS currentstation,
        CASE
            WHEN (runningstation.name IS NOT NULL) THEN '-'::character varying
            ELSE
            CASE
                WHEN (pendingstation.name IS NOT NULL) THEN pendingstation.name
                ELSE '-'::character varying
            END
        END AS nextstation,
    ( SELECT (count(cycle.id))::integer AS count
           FROM public.cycle
          WHERE ((cycle.endoscope_id = endoscope.id) AND (cycle.ispending = false) AND (cycle.starttime > endoscope.purchaseddate))) AS cyclessincepurchase,
    COALESCE(( SELECT (date_part('days'::text, ((now())::timestamp without time zone - endoscope_has_task.startmaintenancedate)))::character varying AS date_part
           FROM public.endoscope_has_task
          WHERE (endoscope_has_task.endoscope_id = endoscope.id)
          ORDER BY endoscope_has_task.startmaintenancedate DESC
         LIMIT 1), '-'::character varying) AS dayssincelastmaintenance,
    COALESCE(( SELECT (date_part('days'::text, ((now())::timestamp without time zone - cycle.lastedit)))::character varying AS date_part
           FROM public.cycle
          WHERE ((cycle.endoscope_id = endoscope.id) AND (cycle.ispending = false) AND (cycle.lastedit IS NOT NULL))
          ORDER BY cycle.lastedit DESC
         LIMIT 1), '-'::character varying) AS dayssincelastreprocessing,
    (date_part('days'::text, ((now())::timestamp without time zone - (endoscope.purchaseddate)::timestamp without time zone)))::integer AS ageofendoscope
   FROM (((((((public.endoscope
     LEFT JOIN public.endoscopetype ON ((endoscope.endoscopetype_id = endoscopetype.id)))
     LEFT JOIN public.manufacturer ON ((endoscopetype.manufacturer_id = manufacturer.id)))
     LEFT JOIN public.endoscopereprocessingstatus ON ((endoscope.id = endoscopereprocessingstatus.endoscope_id)))
     LEFT JOIN public.reprocessingstation laststation ON ((endoscopereprocessingstatus.laststation_id = laststation.id)))
     LEFT JOIN public.reprocessingstation pendingstation ON ((endoscopereprocessingstatus.pendingstation_id = pendingstation.id)))
     LEFT JOIN public.reprocessingstation runningstation ON ((endoscopereprocessingstatus.runningstation_id = runningstation.id)))
     LEFT JOIN public.cyclestate ON ((endoscopereprocessingstatus.cyclestate_id = cyclestate.id)));


ALTER VIEW public.endoscope_view OWNER TO postgres;

--
-- Name: endoscopedashboardconfig; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.endoscopedashboardconfig (
    id integer NOT NULL,
    templatename character varying(100) NOT NULL,
    showmanufacturer boolean NOT NULL,
    showendoscopename boolean NOT NULL,
    isquickfindenabled boolean NOT NULL,
    quickfindtitle character varying(100) NOT NULL,
    showstatuscolumn boolean NOT NULL,
    shownotifications boolean NOT NULL,
    tablesorder character varying(100) NOT NULL,
    createdat timestamp without time zone,
    editedat timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public.endoscopedashboardconfig OWNER TO postgres;

--
-- Name: endoscopedashboardconfig_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.endoscopedashboardconfig_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.endoscopedashboardconfig_id_seq OWNER TO postgres;

--
-- Name: endoscopedashboardconfig_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.endoscopedashboardconfig_id_seq OWNED BY public.endoscopedashboardconfig.id;


--
-- Name: endoscopelocation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.endoscopelocation (
    id integer NOT NULL,
    endoscopeid integer NOT NULL,
    location character varying(255),
    connectedat timestamp without time zone,
    disconnectedat timestamp without time zone,
    externalsystem character varying(255),
    externalversion character varying(100),
    isactive boolean DEFAULT false NOT NULL
);


ALTER TABLE public.endoscopelocation OWNER TO postgres;

--
-- Name: endoscopelocation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.endoscopelocation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.endoscopelocation_id_seq OWNER TO postgres;

--
-- Name: endoscopelocation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.endoscopelocation_id_seq OWNED BY public.endoscopelocation.id;


--
-- Name: endoscopetype_has_etd5referencetype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.endoscopetype_has_etd5referencetype (
    id integer NOT NULL,
    endoscopetype_id integer NOT NULL,
    etd5referencetype_id integer CONSTRAINT endoscopetype_has_etd5referencety_etd5referencetype_id_not_null NOT NULL,
    olympusdefined boolean NOT NULL,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean,
    isdisabled boolean,
    mappinggroup_id integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.endoscopetype_has_etd5referencetype OWNER TO postgres;

--
-- Name: endoscopetype_has_etd5referencetype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.endoscopetype_has_etd5referencetype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.endoscopetype_has_etd5referencetype_id_seq OWNER TO postgres;

--
-- Name: endoscopetype_has_etd5referencetype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.endoscopetype_has_etd5referencetype_id_seq OWNED BY public.endoscopetype_has_etd5referencetype.id;


--
-- Name: endoscopetype_has_etddoublereferencetype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.endoscopetype_has_etddoublereferencetype (
    id integer NOT NULL,
    endoscopetype_id integer CONSTRAINT endoscopetype_has_etddoublereferencet_endoscopetype_id_not_null NOT NULL,
    etddoublereferencetype_id integer CONSTRAINT endoscopetype_has_etddoubler_etddoublereferencetype_id_not_null NOT NULL,
    olympusdefined boolean CONSTRAINT endoscopetype_has_etddoublereferencetyp_olympusdefined_not_null NOT NULL,
    mappinggroup_id integer DEFAULT 0 CONSTRAINT endoscopetype_has_etddoublereferencety_mappinggroup_id_not_null NOT NULL,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean,
    isdisabled boolean
);


ALTER TABLE public.endoscopetype_has_etddoublereferencetype OWNER TO postgres;

--
-- Name: endoscopetype_has_etddoublereferencetype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.endoscopetype_has_etddoublereferencetype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.endoscopetype_has_etddoublereferencetype_id_seq OWNER TO postgres;

--
-- Name: endoscopetype_has_etddoublereferencetype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.endoscopetype_has_etddoublereferencetype_id_seq OWNED BY public.endoscopetype_has_etddoublereferencetype.id;


--
-- Name: endoscopetype_has_logbook; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.endoscopetype_has_logbook (
    endoscopetype_id integer NOT NULL,
    logbook_id integer NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL
);


ALTER TABLE public.endoscopetype_has_logbook OWNER TO postgres;

--
-- Name: endoscopetype_has_proceduretype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.endoscopetype_has_proceduretype (
    id integer NOT NULL,
    endoscopetype_id integer NOT NULL,
    proceduretype_id integer NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL
);


ALTER TABLE public.endoscopetype_has_proceduretype OWNER TO postgres;

--
-- Name: endoscopetype_has_proceduretype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.endoscopetype_has_proceduretype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.endoscopetype_has_proceduretype_id_seq OWNER TO postgres;

--
-- Name: endoscopetype_has_proceduretype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.endoscopetype_has_proceduretype_id_seq OWNED BY public.endoscopetype_has_proceduretype.id;


--
-- Name: endoscopetype_has_reprocessingdevicetype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.endoscopetype_has_reprocessingdevicetype (
    endoscopetype_id integer CONSTRAINT endoscopetype_has_reporcessingdevicet_endoscopetype_id_not_null NOT NULL,
    reprocessingdevicetype_id integer CONSTRAINT endoscopetype_has_reporcessi_reporcessingdevicetype_id_not_null NOT NULL,
    mappinggroup_id integer DEFAULT 0 CONSTRAINT endoscopetype_has_reprocessingdevicety_mappinggroup_id_not_null NOT NULL
);


ALTER TABLE public.endoscopetype_has_reprocessingdevicetype OWNER TO postgres;

--
-- Name: endoscopetype_has_task; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.endoscopetype_has_task (
    id integer NOT NULL,
    task_id integer NOT NULL,
    endoscopetype_id integer NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL
);


ALTER TABLE public.endoscopetype_has_task OWNER TO postgres;

--
-- Name: endoscopetype_has_task_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.endoscopetype_has_task_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.endoscopetype_has_task_id_seq OWNER TO postgres;

--
-- Name: endoscopetype_has_task_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.endoscopetype_has_task_id_seq OWNED BY public.endoscopetype_has_task.id;


--
-- Name: endoscopetype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.endoscopetype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.endoscopetype_id_seq OWNER TO postgres;

--
-- Name: endoscopetype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.endoscopetype_id_seq OWNED BY public.endoscopetype.id;


--
-- Name: etd5blockinfo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etd5blockinfo (
    id integer NOT NULL,
    etd5reprocessingprotocol_id integer NOT NULL,
    blockname integer,
    blockstarttime timestamp without time zone,
    tempvalminvalue double precision,
    tempvalmaxvalue double precision,
    tempvalunit integer,
    tempvalrequiredvalue double precision,
    tempvalrequiredunit integer,
    holdtimevalue double precision,
    holdtimeunit integer,
    watervalvalue double precision,
    watervalunit integer,
    watervalrequiredmin double precision,
    watervalrequiredmax double precision,
    watervalrequiredunit integer,
    tanktemp1value double precision,
    tanktemp1unit integer,
    tanktemp2value double precision,
    tanktemp2unit integer,
    creationdata timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL
);


ALTER TABLE public.etd5blockinfo OWNER TO postgres;

--
-- Name: etd5blockinfo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etd5blockinfo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etd5blockinfo_id_seq OWNER TO postgres;

--
-- Name: etd5blockinfo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etd5blockinfo_id_seq OWNED BY public.etd5blockinfo.id;


--
-- Name: etd5config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etd5config (
    reprocessingdevice_id integer NOT NULL,
    ipadress character varying,
    port integer,
    pairingpin character varying,
    username character varying,
    userpassword character varying,
    certificateisvalidated boolean DEFAULT false CONSTRAINT etd5config_certificateisvalidated_not_null1 NOT NULL,
    certificatefingerprint character varying,
    certificateeffectivedate timestamp without time zone,
    certificateexpirationdate timestamp without time zone,
    certificateissuer character varying,
    certificateserial character varying,
    certificatesubject character varying,
    defaultsessiontoken character varying,
    mergedata boolean NOT NULL,
    isconnectioninitiated boolean NOT NULL
);


ALTER TABLE public.etd5config OWNER TO postgres;

--
-- Name: etd5dosageinfo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etd5dosageinfo (
    id integer NOT NULL,
    etd5blockinfo_id integer NOT NULL,
    chemid character varying,
    expirationdate timestamp without time zone,
    dosagevalvalue double precision,
    dosagevalunit integer,
    dosagevalrequiredmin double precision,
    dosagevalrequiredmax double precision,
    dosagevalrequiredunit integer
);


ALTER TABLE public.etd5dosageinfo OWNER TO postgres;

--
-- Name: etd5dosageinfo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etd5dosageinfo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etd5dosageinfo_id_seq OWNER TO postgres;

--
-- Name: etd5dosageinfo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etd5dosageinfo_id_seq OWNED BY public.etd5dosageinfo.id;


--
-- Name: etd5endoscope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etd5endoscope (
    id integer NOT NULL,
    currentdata_reprocessingdevice_id integer NOT NULL,
    endoscope_id integer,
    scopeid character varying,
    typeid character varying,
    name character varying,
    serialnumber character varying,
    inventarynumber character varying,
    isotransponder character varying,
    trovantransponder character varying,
    loandeviceflag boolean,
    cleaningcount integer NOT NULL,
    lastmodificationtime timestamp without time zone,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL
);


ALTER TABLE public.etd5endoscope OWNER TO postgres;

--
-- Name: etd5endoscope_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etd5endoscope_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etd5endoscope_id_seq OWNER TO postgres;

--
-- Name: etd5endoscope_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etd5endoscope_id_seq OWNED BY public.etd5endoscope.id;


--
-- Name: etd5endoscopeinfo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etd5endoscopeinfo (
    id integer NOT NULL,
    etd5reprocessingprotocol_id integer NOT NULL,
    scopeid character varying,
    scopestatus integer,
    flowcontrol integer,
    leakagetest boolean,
    creationdata timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL
);


ALTER TABLE public.etd5endoscopeinfo OWNER TO postgres;

--
-- Name: etd5endoscopeinfo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etd5endoscopeinfo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etd5endoscopeinfo_id_seq OWNER TO postgres;

--
-- Name: etd5endoscopeinfo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etd5endoscopeinfo_id_seq OWNED BY public.etd5endoscopeinfo.id;


--
-- Name: etd5endoscopetype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etd5endoscopetype (
    id integer NOT NULL,
    currentdata_reprocessingdevice_id integer NOT NULL,
    endoscopetype_id integer,
    typeid character varying,
    refid character varying,
    typemanufacturer character varying,
    typename character varying,
    typecategory boolean,
    lastmodificationtime timestamp without time zone,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL
);


ALTER TABLE public.etd5endoscopetype OWNER TO postgres;

--
-- Name: etd5endoscopetype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etd5endoscopetype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etd5endoscopetype_id_seq OWNER TO postgres;

--
-- Name: etd5endoscopetype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etd5endoscopetype_id_seq OWNED BY public.etd5endoscopetype.id;


--
-- Name: etd5errorprotocol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etd5errorprotocol (
    id integer NOT NULL,
    reprocessinghistoryitem_id integer,
    reprocessingdevice_id integer NOT NULL,
    errorprotocolid integer,
    blockname integer,
    blocknumber integer,
    errortime timestamp without time zone,
    category integer,
    eventid character varying,
    errorno integer,
    shorttext character varying,
    longtext character varying,
    messageid integer,
    progname character varying,
    stepid integer,
    machinetype integer,
    fabricationno character varying,
    cycleno integer,
    changecode integer,
    etd5scopeid1 character varying,
    etd5scopeid2 character varying
);


ALTER TABLE public.etd5errorprotocol OWNER TO postgres;

--
-- Name: etd5errorprotocol_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etd5errorprotocol_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etd5errorprotocol_id_seq OWNER TO postgres;

--
-- Name: etd5errorprotocol_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etd5errorprotocol_id_seq OWNED BY public.etd5errorprotocol.id;


--
-- Name: etd5machineinfo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etd5machineinfo (
    reprocessingdevice_id integer NOT NULL,
    activationdate timestamp without time zone,
    lastvalidation timestamp without time zone,
    lastselfdesinfection timestamp without time zone,
    location character varying,
    serialnumber character varying,
    softwareversion character varying,
    tempunit integer,
    pressureunit integer,
    dateunit integer,
    etd5maschinevariant_id integer NOT NULL
);


ALTER TABLE public.etd5machineinfo OWNER TO postgres;

--
-- Name: etd5maschinevariant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etd5maschinevariant (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.etd5maschinevariant OWNER TO postgres;

--
-- Name: etd5maschinevariant_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etd5maschinevariant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etd5maschinevariant_id_seq OWNER TO postgres;

--
-- Name: etd5maschinevariant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etd5maschinevariant_id_seq OWNED BY public.etd5maschinevariant.id;


--
-- Name: etd5message; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etd5message (
    id integer NOT NULL,
    reprocessingdevice_id integer NOT NULL,
    uniqueerrorid integer NOT NULL,
    errornumber character varying,
    category integer NOT NULL,
    isacknowledged boolean NOT NULL,
    "time" timestamp without time zone,
    shorttextid character varying,
    longtextid character varying
);


ALTER TABLE public.etd5message OWNER TO postgres;

--
-- Name: etd5message_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etd5message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etd5message_id_seq OWNER TO postgres;

--
-- Name: etd5message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etd5message_id_seq OWNED BY public.etd5message.id;


--
-- Name: etd5pressure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etd5pressure (
    id integer NOT NULL,
    etd5blockinfo_id integer NOT NULL,
    pressureval1min double precision,
    pressureval1max double precision,
    pressureval1unit integer,
    pressureval2min double precision,
    pressureval2max double precision,
    pressureval2unit integer,
    pressurevalrequiredmin double precision,
    pressurevalrequiredmax double precision,
    pressurevalrequiredunit integer,
    pressureapc1value double precision,
    pressureapc1unit integer,
    pressureapc2value double precision,
    pressureapc2unit integer,
    fc1pressureopenavalue double precision,
    fc1pressureopenaunit integer,
    fc1pressureopenbvalue double precision,
    fc1pressureopenbunit integer,
    fc1pressureopencvalue double precision,
    fc1pressureopencunit integer,
    fc1pressureopendvalue double precision,
    fc1pressureopendunit integer,
    fc1pressureopenevalue double precision,
    fc1pressureopeneunit integer,
    fc1pressureopenfvalue double precision,
    fc1pressureopenfunit integer,
    fc1pressurecloseavalue double precision,
    fc1pressurecloseaunit integer,
    fc1pressureclosebvalue double precision,
    fc1pressureclosebunit integer,
    fc1pressureclosecvalue double precision,
    fc1pressureclosecunit integer,
    fc1pressureclosedvalue double precision,
    fc1pressureclosedunit integer,
    fc1pressurecloseevalue double precision,
    fc1pressurecloseeunit integer,
    fc1pressureclosefvalue double precision,
    fc1pressureclosefunit integer,
    fc2pressureopenavalue double precision,
    fc2pressureopenaunit integer,
    fc2pressureopenbvalue double precision,
    fc2pressureopenbunit integer,
    fc2pressureopencvalue double precision,
    fc2pressureopencunit integer,
    fc2pressureopendvalue double precision,
    fc2pressureopendunit integer,
    fc2pressureopenevalue double precision,
    fc2pressureopeneunit integer,
    fc2pressureopenfvalue double precision,
    fc2pressureopenfunit integer,
    fc2pressurecloseavalue double precision,
    fc2pressurecloseaunit integer,
    fc2pressureclosebvalue double precision,
    fc2pressureclosebunit integer,
    fc2pressureclosecvalue double precision,
    fc2pressureclosecunit integer,
    fc2pressureclosedvalue double precision,
    fc2pressureclosedunit integer,
    fc2pressurecloseevalue double precision,
    fc2pressurecloseeunit integer,
    fc2pressureclosefvalue double precision,
    fc2pressureclosefunit integer
);


ALTER TABLE public.etd5pressure OWNER TO postgres;

--
-- Name: etd5pressure_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etd5pressure_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etd5pressure_id_seq OWNER TO postgres;

--
-- Name: etd5pressure_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etd5pressure_id_seq OWNED BY public.etd5pressure.id;


--
-- Name: etd5processdatadetailed; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etd5processdatadetailed (
    id integer NOT NULL,
    reprocessinghistoryitem_id integer,
    lastedit timestamp without time zone NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    temperaturedryingblockmillidegreeclesius integer,
    temperatureotherblocksmillidegreeclesius integer,
    pressurelt1millibar integer,
    pressurelt2millibar integer,
    pressurefc1millibar integer,
    pressurefc2millibar integer,
    pressurefp1millibar integer,
    pressurefp2millibar integer,
    currentblockname integer,
    currentblockstart timestamp without time zone,
    rawdata character varying NOT NULL,
    temperaturedryingblockmillidegreeclesiustarget integer,
    temperaturedryingblockmillidegreeclesiusmaxdeviation integer,
    temperatureothterblockmillidegreeclesiustarget integer,
    temperatureothterblockmillidegreeclesiustargetlower integer,
    temperatureothterblockmillidegreeclesiustargetupper integer,
    pressurefc1millibartargetlower integer,
    pressurefc1millibartargetupper integer,
    pressurefc2millibartargetlower integer,
    pressurefc2millibartargetupper integer
);


ALTER TABLE public.etd5processdatadetailed OWNER TO postgres;

--
-- Name: etd5processdatadetailed_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etd5processdatadetailed_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etd5processdatadetailed_id_seq OWNER TO postgres;

--
-- Name: etd5processdatadetailed_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etd5processdatadetailed_id_seq OWNED BY public.etd5processdatadetailed.id;


--
-- Name: etd5referencetypeitem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etd5referencetypeitem (
    id integer NOT NULL,
    etd5referencetypelist_id integer,
    refid character varying NOT NULL,
    albaran json NOT NULL,
    bioflag json NOT NULL,
    dry json NOT NULL,
    fcflag json NOT NULL,
    flow json NOT NULL,
    lt json NOT NULL,
    isdeleted boolean NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL
);


ALTER TABLE public.etd5referencetypeitem OWNER TO postgres;

--
-- Name: etd5referencetypeitem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etd5referencetypeitem_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etd5referencetypeitem_id_seq OWNER TO postgres;

--
-- Name: etd5referencetypeitem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etd5referencetypeitem_id_seq OWNED BY public.etd5referencetypeitem.id;


--
-- Name: etd5referencetypelist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etd5referencetypelist (
    id integer NOT NULL,
    reftypelistversion character varying NOT NULL,
    isdeleted boolean NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL
);


ALTER TABLE public.etd5referencetypelist OWNER TO postgres;

--
-- Name: etd5referencetypelist_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etd5referencetypelist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etd5referencetypelist_id_seq OWNER TO postgres;

--
-- Name: etd5referencetypelist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etd5referencetypelist_id_seq OWNED BY public.etd5referencetypelist.id;


--
-- Name: etd5reprocessingprotocol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etd5reprocessingprotocol (
    id integer NOT NULL,
    reprocessinghistoryitem_id integer NOT NULL,
    protocolid integer NOT NULL,
    protocoltype integer NOT NULL,
    machinetype integer,
    machinevariant integer,
    location character varying,
    softwareversion character varying,
    fabricationnumber character varying,
    referencetypedatabaseversion character varying,
    systemlanguage character varying,
    cyclenumber integer NOT NULL,
    resultcode integer,
    programname character varying,
    hygienetestmodeactive boolean,
    endlessprogrammodeactive boolean,
    programprofile integer,
    programstart timestamp without time zone,
    programend timestamp without time zone,
    errornumber integer,
    errorshorttext character varying,
    statuscoarsefiltervalue double precision,
    statuscoarsefilterunit integer,
    statusfinefiltervalue double precision,
    statusfinefilterunit integer,
    lastselfdesinfection timestamp without time zone,
    selfdisinfectiona0we character varying,
    selfdisinfectiona0sk character varying,
    layerpressureloss1value double precision,
    layerpressureloss1unit integer,
    layerpressureloss2value double precision,
    layerpressureloss2unit integer,
    etd5userinfostart_id integer,
    etd5userinfoend_id integer,
    rawdata character varying,
    creationdata timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL
);


ALTER TABLE public.etd5reprocessingprotocol OWNER TO postgres;

--
-- Name: etd5reprocessingprotocol_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etd5reprocessingprotocol_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etd5reprocessingprotocol_id_seq OWNER TO postgres;

--
-- Name: etd5reprocessingprotocol_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etd5reprocessingprotocol_id_seq OWNED BY public.etd5reprocessingprotocol.id;


--
-- Name: etd5rotation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etd5rotation (
    id integer NOT NULL,
    etd5blockinfo_id integer NOT NULL,
    sprayarmspeed1min double precision,
    sprayarmspeed1max double precision,
    sprayarmspeed1unit integer,
    sprayarmspeed2min double precision,
    sprayarmspeed2max double precision,
    sprayarmspeed2unit integer,
    sprayarmspeedrequiredmin double precision,
    sprayarmspeedrequiredmax double precision,
    sprayarmspeedrequiredunit integer
);


ALTER TABLE public.etd5rotation OWNER TO postgres;

--
-- Name: etd5rotation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etd5rotation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etd5rotation_id_seq OWNER TO postgres;

--
-- Name: etd5rotation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etd5rotation_id_seq OWNED BY public.etd5rotation.id;


--
-- Name: etd5user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etd5user (
    id integer NOT NULL,
    currentdata_reprocessingdevice_id integer NOT NULL,
    useraccount_id integer,
    userid character varying,
    lastname character varying,
    firstname character varying,
    employeenumber character varying,
    userrights character varying,
    transponder character varying,
    transponderhashed character varying,
    pin character varying,
    pinhashed character varying,
    pinsalt character varying,
    lastmodificationtime timestamp without time zone,
    formerauthdata character varying,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone
);


ALTER TABLE public.etd5user OWNER TO postgres;

--
-- Name: etd5user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etd5user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etd5user_id_seq OWNER TO postgres;

--
-- Name: etd5user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etd5user_id_seq OWNED BY public.etd5user.id;


--
-- Name: etd5userinfo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etd5userinfo (
    id integer NOT NULL,
    userid character varying,
    timeauth timestamp without time zone,
    creationdata timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL
);


ALTER TABLE public.etd5userinfo OWNER TO postgres;

--
-- Name: etd5userinfo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etd5userinfo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etd5userinfo_id_seq OWNER TO postgres;

--
-- Name: etd5userinfo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etd5userinfo_id_seq OWNED BY public.etd5userinfo.id;


--
-- Name: etdbasicprocessdata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etdbasicprocessdata (
    id integer NOT NULL,
    reprocessinghistoryitem_id integer,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    deviceserialnumber character varying,
    programname character varying,
    protocolstart timestamp without time zone,
    protocolend timestamp without time zone,
    watertemperature integer,
    airtemperature integer,
    rawdata character varying NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    pressure1_mpa integer,
    pressure2_mpa integer
);


ALTER TABLE public.etdbasicprocessdata OWNER TO postgres;

--
-- Name: etdbasicprocessdata_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etdbasicprocessdata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etdbasicprocessdata_id_seq OWNER TO postgres;

--
-- Name: etdbasicprocessdata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etdbasicprocessdata_id_seq OWNED BY public.etdbasicprocessdata.id;


--
-- Name: etdconfig; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etdconfig (
    reprocessingdevice_id integer NOT NULL,
    ipadress character varying,
    tosegosoft boolean NOT NULL,
    portforsegosoft integer
);


ALTER TABLE public.etdconfig OWNER TO postgres;

--
-- Name: etddconfig; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etddconfig (
    reprocessingdevice_id integer NOT NULL,
    ipadress character varying,
    port integer,
    mergedata boolean
);


ALTER TABLE public.etddconfig OWNER TO postgres;

--
-- Name: etddoubleapcinfo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etddoubleapcinfo (
    id integer NOT NULL,
    etddoubleblockinfo_id integer NOT NULL,
    apcinfonominal character varying,
    apcinfoactual character varying,
    levelinformation character varying
);


ALTER TABLE public.etddoubleapcinfo OWNER TO postgres;

--
-- Name: etddoubleapcinfo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etddoubleapcinfo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etddoubleapcinfo_id_seq OWNER TO postgres;

--
-- Name: etddoubleapcinfo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etddoubleapcinfo_id_seq OWNED BY public.etddoubleapcinfo.id;


--
-- Name: etddoubleblockinfo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etddoubleblockinfo (
    id integer NOT NULL,
    etddoublereprocessingprotocol_id integer NOT NULL,
    blockname character varying,
    blocknominal character varying,
    blockactual character varying,
    blockstartnominal character varying,
    blockstartactual character varying,
    waterquantintynominal character varying,
    waterquantityactual character varying,
    vaccinationnominal character varying,
    vaccinationactual character varying,
    uvradiationnominal character varying,
    uvradiationactual character varying,
    reactiontimenominal character varying,
    reactiontimeactual character varying,
    temperaturenominal character varying,
    temperatureactual character varying
);


ALTER TABLE public.etddoubleblockinfo OWNER TO postgres;

--
-- Name: etddoubleblockinfo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etddoubleblockinfo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etddoubleblockinfo_id_seq OWNER TO postgres;

--
-- Name: etddoubleblockinfo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etddoubleblockinfo_id_seq OWNED BY public.etddoubleblockinfo.id;


--
-- Name: etddoubledosinginfo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etddoubledosinginfo (
    id integer NOT NULL,
    etddoubleblockinfo_id integer NOT NULL,
    dosingmedium character varying,
    dosingchemienominal character varying,
    dosingchemieactual character varying,
    dosingnumbernominal character varying,
    dosingnumberactual character varying,
    dosingexperationdatenominal character varying,
    dosingexperationdateactual character varying,
    dosingquantitynominal character varying,
    dosingquantityactual character varying
);


ALTER TABLE public.etddoubledosinginfo OWNER TO postgres;

--
-- Name: etddoubledosinginfo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etddoubledosinginfo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etddoubledosinginfo_id_seq OWNER TO postgres;

--
-- Name: etddoubledosinginfo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etddoubledosinginfo_id_seq OWNED BY public.etddoubledosinginfo.id;


--
-- Name: etddoubleendoscope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etddoubleendoscope (
    id integer NOT NULL,
    currentdata_id integer CONSTRAINT etddoubleendoscope_etddcurrentdata_reprocessingdevice__not_null NOT NULL,
    transponder character varying,
    displaytype character varying,
    referencetype character varying,
    serialnumber character varying,
    internalid character varying,
    loandeviceflag boolean,
    oldtransponder character varying,
    cleaningcount integer,
    updatetime timestamp without time zone,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    isdisabled boolean DEFAULT false NOT NULL
);


ALTER TABLE public.etddoubleendoscope OWNER TO postgres;

--
-- Name: etddoubleendoscope_has_endoscope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etddoubleendoscope_has_endoscope (
    etddoubleendoscope_id integer NOT NULL,
    endoscope_id integer NOT NULL,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean,
    isdisabled boolean
);


ALTER TABLE public.etddoubleendoscope_has_endoscope OWNER TO postgres;

--
-- Name: etddoubleendoscope_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etddoubleendoscope_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etddoubleendoscope_id_seq OWNER TO postgres;

--
-- Name: etddoubleendoscope_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etddoubleendoscope_id_seq OWNED BY public.etddoubleendoscope.id;


--
-- Name: etddoubleendoscopeinfo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etddoubleendoscopeinfo (
    id integer NOT NULL,
    etddoublereprocessingprotocol_id integer CONSTRAINT etddoubleendoscopeinfo_etddoublereprocessingprotocol_i_not_null NOT NULL,
    scopeit character varying,
    scopename character varying,
    scopestatus character varying,
    scopetype character varying,
    creationdate timestamp without time zone CONSTRAINT etddoubleendoscopeinfo_creationdata_not_null NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL,
    serialnumber character varying,
    scopeid character varying,
    flowcontrol character varying
);


ALTER TABLE public.etddoubleendoscopeinfo OWNER TO postgres;

--
-- Name: etddoubleendoscopeinfo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etddoubleendoscopeinfo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etddoubleendoscopeinfo_id_seq OWNER TO postgres;

--
-- Name: etddoubleendoscopeinfo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etddoubleendoscopeinfo_id_seq OWNED BY public.etddoubleendoscopeinfo.id;


--
-- Name: etddoubleerrorprotocol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etddoubleerrorprotocol (
    id integer NOT NULL,
    reprocessingdevice_id integer NOT NULL,
    reprocessinghistoryitem_id integer,
    lastedit timestamp without time zone NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    errortime timestamp without time zone,
    errornumber integer,
    errordescription character varying,
    blocknumber integer,
    stepnumber integer
);


ALTER TABLE public.etddoubleerrorprotocol OWNER TO postgres;

--
-- Name: etddoubleerrorprotocol_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etddoubleerrorprotocol_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etddoubleerrorprotocol_id_seq OWNER TO postgres;

--
-- Name: etddoubleerrorprotocol_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etddoubleerrorprotocol_id_seq OWNED BY public.etddoubleerrorprotocol.id;


--
-- Name: etddoublepressure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etddoublepressure (
    id integer NOT NULL,
    etddoubleblockinfo_id integer NOT NULL,
    pressurenominal character varying,
    pressureactual character varying,
    levelinformation character varying
);


ALTER TABLE public.etddoublepressure OWNER TO postgres;

--
-- Name: etddoublepressure_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etddoublepressure_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etddoublepressure_id_seq OWNER TO postgres;

--
-- Name: etddoublepressure_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etddoublepressure_id_seq OWNED BY public.etddoublepressure.id;


--
-- Name: etddoubleprocessdata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etddoubleprocessdata (
    id integer NOT NULL,
    reprocessinghistoryitem_id integer,
    lastedit timestamp without time zone NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    deviceserialnumber character varying,
    programname character varying,
    protocolstart timestamp without time zone,
    protocolend timestamp without time zone,
    watertemperature integer,
    airtemperature integer,
    currentblockname character varying,
    currentblockstart timestamp without time zone,
    holdingtime integer,
    blockinflowvolume integer,
    dosagevolume1 integer,
    dosagevolume2 integer,
    dosagevolume3 integer,
    sprayarmrotationtop integer,
    sprayarmrotationbottom integer,
    scavengingpressureupper integer,
    scavengingpressuremiddle integer,
    scavengingpressurelower integer,
    uvstatus1 integer,
    uvstatus2 integer,
    rawdata character varying NOT NULL,
    "timestamp" timestamp without time zone NOT NULL
);


ALTER TABLE public.etddoubleprocessdata OWNER TO postgres;

--
-- Name: etddoubleprocessdata_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etddoubleprocessdata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etddoubleprocessdata_id_seq OWNER TO postgres;

--
-- Name: etddoubleprocessdata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etddoubleprocessdata_id_seq OWNED BY public.etddoubleprocessdata.id;


--
-- Name: etddoublereferencetypeitem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etddoublereferencetypeitem (
    id integer NOT NULL,
    etddoublereferencetypelist_id integer,
    refid character varying NOT NULL,
    itemcontentasxml xml NOT NULL,
    isdeleted boolean NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL
);


ALTER TABLE public.etddoublereferencetypeitem OWNER TO postgres;

--
-- Name: etddoublereferencetypeitem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etddoublereferencetypeitem_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etddoublereferencetypeitem_id_seq OWNER TO postgres;

--
-- Name: etddoublereferencetypeitem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etddoublereferencetypeitem_id_seq OWNED BY public.etddoublereferencetypeitem.id;


--
-- Name: etddoublereferencetypelist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etddoublereferencetypelist (
    id integer NOT NULL,
    reftypelistversion character varying NOT NULL,
    isdeleted boolean NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL
);


ALTER TABLE public.etddoublereferencetypelist OWNER TO postgres;

--
-- Name: etddoublereferencetypelist_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etddoublereferencetypelist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etddoublereferencetypelist_id_seq OWNER TO postgres;

--
-- Name: etddoublereferencetypelist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etddoublereferencetypelist_id_seq OWNED BY public.etddoublereferencetypelist.id;


--
-- Name: etddoublereprocessingprotocol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etddoublereprocessingprotocol (
    id integer NOT NULL,
    etddoubleuserinfostart_id integer,
    etddoubleuserinfoend_id integer,
    reprocessinghistoryitem_id integer CONSTRAINT etddoublereprocessingprotoc_reprocessinghistoryitem_id_not_null NOT NULL,
    protocolstart timestamp without time zone,
    chargenumber integer NOT NULL,
    machinetype character varying,
    lastselfdesinfection timestamp without time zone,
    programtext character varying,
    programname character varying,
    hygienetestmodus character varying,
    processparameters character varying,
    errornumber character varying,
    processend timestamp without time zone,
    username character varying,
    usertext character varying,
    processstart timestamp without time zone,
    scopetext character varying,
    rawdata character varying,
    protocolend timestamp without time zone,
    name character varying,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean,
    fabricationnumber character varying,
    processabortion timestamp without time zone
);


ALTER TABLE public.etddoublereprocessingprotocol OWNER TO postgres;

--
-- Name: etddoublereprocessingprotocol_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etddoublereprocessingprotocol_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etddoublereprocessingprotocol_id_seq OWNER TO postgres;

--
-- Name: etddoublereprocessingprotocol_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etddoublereprocessingprotocol_id_seq OWNED BY public.etddoublereprocessingprotocol.id;


--
-- Name: etddoublerotation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etddoublerotation (
    id integer NOT NULL,
    etddoubleblockinfo_id integer NOT NULL,
    rotationnominal character varying,
    rotationactual character varying
);


ALTER TABLE public.etddoublerotation OWNER TO postgres;

--
-- Name: etddoublerotation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etddoublerotation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etddoublerotation_id_seq OWNER TO postgres;

--
-- Name: etddoublerotation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etddoublerotation_id_seq OWNED BY public.etddoublerotation.id;


--
-- Name: etddoubleuser; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etddoubleuser (
    id integer NOT NULL,
    currentdata_id integer CONSTRAINT etddoubleuser_etddcurrentdata_reprocessingdevice_id_not_null NOT NULL,
    transponder character varying,
    lastname character varying,
    firstname character varying,
    employeenumber character varying,
    username character varying,
    userrights character varying,
    accesscode character varying,
    updatetime timestamp without time zone,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean,
    isdisabled boolean
);


ALTER TABLE public.etddoubleuser OWNER TO postgres;

--
-- Name: etddoubleuser_has_useraccount; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etddoubleuser_has_useraccount (
    etddoubleuser_id integer NOT NULL,
    useraccount_id integer NOT NULL,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean,
    isdisabled boolean
);


ALTER TABLE public.etddoubleuser_has_useraccount OWNER TO postgres;

--
-- Name: etddoubleuser_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etddoubleuser_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etddoubleuser_id_seq OWNER TO postgres;

--
-- Name: etddoubleuser_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etddoubleuser_id_seq OWNED BY public.etddoubleuser.id;


--
-- Name: etddoubleuserinfo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etddoubleuserinfo (
    id integer NOT NULL,
    useridstatus character varying,
    username character varying,
    firstname character varying,
    creationdate timestamp without time zone CONSTRAINT etddoubleuserinfo_creationdata_not_null NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL,
    userid character varying,
    personalnumber character varying
);


ALTER TABLE public.etddoubleuserinfo OWNER TO postgres;

--
-- Name: etddoubleuserinfo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etddoubleuserinfo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etddoubleuserinfo_id_seq OWNER TO postgres;

--
-- Name: etddoubleuserinfo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etddoubleuserinfo_id_seq OWNED BY public.etddoubleuserinfo.id;


--
-- Name: etdendoscope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etdendoscope (
    id integer NOT NULL,
    currentdata_reprocessingdevice_id integer NOT NULL,
    transponder character varying,
    referencetype character varying,
    serialnumber character varying,
    isloanerdevice boolean NOT NULL,
    updatetime timestamp without time zone,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    numberofchannels integer DEFAULT 0 NOT NULL,
    endoscopetype character varying DEFAULT ''::character varying NOT NULL,
    oldtransponderid character varying DEFAULT ''::character varying NOT NULL,
    internalnumber character varying DEFAULT ''::character varying NOT NULL,
    hasalbaranchannel boolean DEFAULT false NOT NULL,
    flowcontrolsctive boolean DEFAULT false NOT NULL,
    endoscope_id integer
);


ALTER TABLE public.etdendoscope OWNER TO postgres;

--
-- Name: etdendoscope_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etdendoscope_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etdendoscope_id_seq OWNER TO postgres;

--
-- Name: etdendoscope_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etdendoscope_id_seq OWNED BY public.etdendoscope.id;


--
-- Name: etdminiconfig; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etdminiconfig (
    reprocessingdevice_id integer NOT NULL,
    ipadress character varying,
    port integer,
    mergedata boolean NOT NULL,
    hasendoscopeauthorisation boolean DEFAULT false NOT NULL,
    messageacknowledgemandatory boolean DEFAULT false NOT NULL
);


ALTER TABLE public.etdminiconfig OWNER TO postgres;

--
-- Name: etdminicyclephaseinterrupttype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etdminicyclephaseinterrupttype (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.etdminicyclephaseinterrupttype OWNER TO postgres;

--
-- Name: etdminicyclephaseinterrupttype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etdminicyclephaseinterrupttype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etdminicyclephaseinterrupttype_id_seq OWNER TO postgres;

--
-- Name: etdminicyclephaseinterrupttype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etdminicyclephaseinterrupttype_id_seq OWNED BY public.etdminicyclephaseinterrupttype.id;


--
-- Name: etdminicyclephasetype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etdminicyclephasetype (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.etdminicyclephasetype OWNER TO postgres;

--
-- Name: etdminicyclephasetype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etdminicyclephasetype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etdminicyclephasetype_id_seq OWNER TO postgres;

--
-- Name: etdminicyclephasetype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etdminicyclephasetype_id_seq OWNED BY public.etdminicyclephasetype.id;


--
-- Name: etdminiprobedata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etdminiprobedata (
    id integer NOT NULL,
    reprocessinghistoryitem_id integer,
    lastedit timestamp without time zone NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    tanktemperature1 integer NOT NULL,
    tanktemperature2 integer NOT NULL,
    washpressurebasket integer NOT NULL,
    washflowrate integer NOT NULL,
    leaktestpressureinstrument1 integer NOT NULL,
    leaktestpressureinstrument2 integer NOT NULL
);


ALTER TABLE public.etdminiprobedata OWNER TO postgres;

--
-- Name: etdminiprobedata_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etdminiprobedata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etdminiprobedata_id_seq OWNER TO postgres;

--
-- Name: etdminiprobedata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etdminiprobedata_id_seq OWNED BY public.etdminiprobedata.id;


--
-- Name: etdminiprocessdata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etdminiprocessdata (
    id integer NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    etdminicyclephasetype_id integer NOT NULL,
    etdminicyclephaseinterrupttype_id integer NOT NULL,
    deviceserialnumber integer,
    phaseindex integer,
    phasename character varying,
    progressivephaseeventnumber integer,
    phaseendtime timestamp without time zone,
    tanktemperature1 integer,
    tanktemperature2 integer,
    executedproductquantitydosingselection1 integer,
    executedproductquantitydosingselection2 integer,
    a0valueprobe1 integer,
    a0valueprobe2 integer,
    chemcicalproductokstatusselection1 integer,
    chemcicalproductokstatusselection2 integer,
    chemcicalproducttypeselection1 integer,
    chemcicalproducttypeselection2 integer,
    excutedproductquantityredundancyselection1 integer,
    executedproductquantityredundancyselection2 integer,
    executedthermoregulationtime integer,
    executedwaterquantitydosingselection1 integer,
    executedwaterquantitydosingselection2 integer,
    executedwaterquantityredundancyselection1 integer,
    executedwaterquantityredundancyselection2 integer,
    maxcundictivityvalue integer,
    maxdryingtemperatur integer,
    programmedproductquantityselection1 integer,
    programmedproductquantityselection2 integer,
    programmedthermoregulationtime integer,
    programmedwaterquantityselection2 integer,
    tanktemperature1atthermoregulationtime integer,
    tanktemperature2atthermoregulationtime integer,
    temperaturesetpoint integer,
    watertypeselection1 integer,
    watertypeselection2 integer,
    rawdata character varying NOT NULL,
    reprocessinghistoryitem_id integer,
    programmedwaterquantityselection1 integer,
    phaseinterruptdescription character varying,
    phaseinterruptalarmcode integer
);


ALTER TABLE public.etdminiprocessdata OWNER TO postgres;

--
-- Name: etdminiprocessdata_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etdminiprocessdata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etdminiprocessdata_id_seq OWNER TO postgres;

--
-- Name: etdminiprocessdata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etdminiprocessdata_id_seq OWNED BY public.etdminiprocessdata.id;


--
-- Name: etdminiprotocoltype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etdminiprotocoltype (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.etdminiprotocoltype OWNER TO postgres;

--
-- Name: etdminiprotocoltype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etdminiprotocoltype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etdminiprotocoltype_id_seq OWNER TO postgres;

--
-- Name: etdminiprotocoltype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etdminiprotocoltype_id_seq OWNED BY public.etdminiprotocoltype.id;


--
-- Name: etdminireprocessingprotocol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etdminireprocessingprotocol (
    id integer NOT NULL,
    reprocessinghistoryitem_id integer NOT NULL,
    endoscope1barcode character varying NOT NULL,
    endoscope1name1 character varying DEFAULT ''::character varying NOT NULL,
    endoscope1name2 character varying DEFAULT ''::character varying NOT NULL,
    endoscope1name3 character varying DEFAULT ''::character varying NOT NULL,
    endoscope2barcode character varying NOT NULL,
    endoscope2name1 character varying DEFAULT ''::character varying NOT NULL,
    endoscope2name2 character varying DEFAULT ''::character varying NOT NULL,
    endoscope2name3 character varying DEFAULT ''::character varying NOT NULL,
    startuserbarcode character varying DEFAULT ''::character varying NOT NULL,
    startusername character varying DEFAULT ''::character varying NOT NULL,
    enduserbarcode character varying DEFAULT ''::character varying NOT NULL,
    endusername character varying DEFAULT ''::character varying NOT NULL,
    model character varying DEFAULT ''::character varying NOT NULL,
    machineserialnumber character varying DEFAULT ''::character varying NOT NULL,
    etdminiprotocoltype_id integer NOT NULL,
    cyclestarttime timestamp without time zone,
    cycleendtime timestamp without time zone,
    machineunloadingtime timestamp without time zone,
    cycleregistrationnumber integer NOT NULL,
    cycleindex integer NOT NULL,
    cyclename character varying DEFAULT ''::character varying NOT NULL,
    cycleresultcode character varying DEFAULT ''::character varying NOT NULL,
    rawdata character varying DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.etdminireprocessingprotocol OWNER TO postgres;

--
-- Name: etdminireprocessingprotocol_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etdminireprocessingprotocol_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etdminireprocessingprotocol_id_seq OWNER TO postgres;

--
-- Name: etdminireprocessingprotocol_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etdminireprocessingprotocol_id_seq OWNED BY public.etdminireprocessingprotocol.id;


--
-- Name: etdplusconfig; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etdplusconfig (
    reprocessingdevice_id integer NOT NULL,
    ipadress character varying NOT NULL,
    mergedata boolean NOT NULL,
    port smallint NOT NULL,
    tosegosoft boolean NOT NULL,
    newendoidversion boolean NOT NULL,
    portforsegosoft integer
);


ALTER TABLE public.etdplusconfig OWNER TO postgres;

--
-- Name: etduser; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etduser (
    id integer NOT NULL,
    currentdata_reprocessingdevice_id integer NOT NULL,
    transponder character varying,
    lastname character varying,
    firstname character varying,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    userrights character varying,
    internalno character varying,
    useraccount_id integer
);


ALTER TABLE public.etduser OWNER TO postgres;

--
-- Name: etduser_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etduser_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etduser_id_seq OWNER TO postgres;

--
-- Name: etduser_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etduser_id_seq OWNED BY public.etduser.id;


--
-- Name: etdv3reprocessingprotocol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etdv3reprocessingprotocol (
    id integer NOT NULL,
    reprocessinghistoryitem_id integer NOT NULL,
    endoscopetransponder character varying NOT NULL,
    endoscopetype character varying DEFAULT ''::character varying NOT NULL,
    endoscopeserialnumber character varying DEFAULT ''::character varying NOT NULL,
    endoscopeinternalnumber character varying DEFAULT ''::character varying NOT NULL,
    endoscopenumberofchannels integer DEFAULT 0 NOT NULL,
    endoscopecounter integer DEFAULT 0 NOT NULL,
    endoscopeisloanerdevice boolean DEFAULT false NOT NULL,
    endoscopeoldtransponderid character varying DEFAULT ''::character varying NOT NULL,
    endoscopehasalbaranchannel boolean NOT NULL,
    endoscopeflowcontrolactive boolean NOT NULL,
    endoscopereferencetype character varying DEFAULT ''::character varying NOT NULL,
    usertransponder character varying NOT NULL,
    userlastname character varying DEFAULT ''::character varying NOT NULL,
    userfirstname character varying DEFAULT ''::character varying NOT NULL,
    userinternalno character varying DEFAULT ''::character varying NOT NULL,
    userrights character varying DEFAULT ''::character varying NOT NULL,
    etdtransponder character varying NOT NULL,
    etdtype character varying DEFAULT ''::character varying NOT NULL,
    etdserialnumber character varying DEFAULT ''::character varying NOT NULL,
    etdinterfaceno integer DEFAULT 0 NOT NULL,
    etdlocation character varying DEFAULT ''::character varying NOT NULL,
    etdv3reprocessingprotocoltype_id integer CONSTRAINT etdv3reprocessingprotocol_etdv3reprocessingprotocoltyp_not_null NOT NULL,
    protocolnumber character varying DEFAULT ''::character varying NOT NULL,
    protocolbasedata character varying DEFAULT ''::character varying NOT NULL,
    protocoldata character varying DEFAULT ''::character varying NOT NULL,
    protocolstarttime timestamp without time zone NOT NULL,
    protocolendtime timestamp without time zone,
    protocolprogramname character varying DEFAULT ''::character varying NOT NULL,
    protocolresultcode character varying DEFAULT ''::character varying NOT NULL,
    protocolsuccess boolean NOT NULL,
    rawdata character varying DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.etdv3reprocessingprotocol OWNER TO postgres;

--
-- Name: etdv3reprocessingprotocol_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etdv3reprocessingprotocol_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etdv3reprocessingprotocol_id_seq OWNER TO postgres;

--
-- Name: etdv3reprocessingprotocol_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etdv3reprocessingprotocol_id_seq OWNED BY public.etdv3reprocessingprotocol.id;


--
-- Name: etdv3reprocessingprotocoltype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etdv3reprocessingprotocoltype (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.etdv3reprocessingprotocoltype OWNER TO postgres;

--
-- Name: etdv3reprocessingprotocoltype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etdv3reprocessingprotocoltype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etdv3reprocessingprotocoltype_id_seq OWNER TO postgres;

--
-- Name: etdv3reprocessingprotocoltype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etdv3reprocessingprotocoltype_id_seq OWNED BY public.etdv3reprocessingprotocoltype.id;


--
-- Name: expansionunit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.expansionunit (
    reprocessingdevice_id integer NOT NULL,
    ipaddress character varying NOT NULL,
    port smallint NOT NULL,
    isdisabled boolean NOT NULL
);


ALTER TABLE public.expansionunit OWNER TO postgres;

--
-- Name: exportfilehistory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exportfilehistory (
    id integer NOT NULL,
    reprocessinghistoryitem_id integer NOT NULL,
    exportfolderpath character varying,
    filename character varying,
    creationdate timestamp without time zone NOT NULL
);


ALTER TABLE public.exportfilehistory OWNER TO postgres;

--
-- Name: exportfilehistory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.exportfilehistory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.exportfilehistory_id_seq OWNER TO postgres;

--
-- Name: exportfilehistory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.exportfilehistory_id_seq OWNED BY public.exportfilehistory.id;


--
-- Name: f_deviceuseredc; Type: FOREIGN TABLE; Schema: public; Owner: postgres
--

CREATE FOREIGN TABLE public.f_deviceuseredc (
    useraccount_id integer NOT NULL,
    staffpin character varying,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean NOT NULL,
    isincomplete boolean NOT NULL
)
SERVER foreign_server
OPTIONS (
    schema_name 'public',
    table_name 'f_deviceuseredc'
);


ALTER FOREIGN TABLE public.f_deviceuseredc OWNER TO postgres;

--
-- Name: f_deviceuseretd34; Type: FOREIGN TABLE; Schema: public; Owner: postgres
--

CREATE FOREIGN TABLE public.f_deviceuseretd34 (
    useraccount_id integer NOT NULL,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean NOT NULL,
    isincomplete boolean NOT NULL
)
SERVER foreign_server
OPTIONS (
    schema_name 'public',
    table_name 'f_deviceuseretd34'
);


ALTER FOREIGN TABLE public.f_deviceuseretd34 OWNER TO postgres;

--
-- Name: f_deviceuseretddouble; Type: FOREIGN TABLE; Schema: public; Owner: postgres
--

CREATE FOREIGN TABLE public.f_deviceuseretddouble (
    useraccount_id integer NOT NULL,
    username character varying,
    accesscode character varying,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean NOT NULL,
    isincomplete boolean NOT NULL
)
SERVER foreign_server
OPTIONS (
    schema_name 'public',
    table_name 'f_deviceuseretddouble'
);


ALTER FOREIGN TABLE public.f_deviceuseretddouble OWNER TO postgres;

--
-- Name: f_etddoubleuser; Type: FOREIGN TABLE; Schema: public; Owner: postgres
--

CREATE FOREIGN TABLE public.f_etddoubleuser (
    id integer NOT NULL,
    currentdata_id integer NOT NULL,
    transponder character varying,
    lastname character varying,
    firstname character varying,
    employeenumber character varying,
    username character varying,
    userrights character varying,
    accesscode character varying,
    updatetime timestamp without time zone,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean NOT NULL,
    isdisabled boolean NOT NULL
)
SERVER foreign_server
OPTIONS (
    schema_name 'public',
    table_name 'f_etddoubleuser'
);


ALTER FOREIGN TABLE public.f_etddoubleuser OWNER TO postgres;

--
-- Name: f_etddoubleuserinfo; Type: FOREIGN TABLE; Schema: public; Owner: postgres
--

CREATE FOREIGN TABLE public.f_etddoubleuserinfo (
    id integer NOT NULL,
    useridstatus character varying,
    username character varying,
    firstname character varying,
    userid integer,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL
)
SERVER foreign_server
OPTIONS (
    schema_name 'public',
    table_name 'f_etddoubleuserinfo'
);


ALTER FOREIGN TABLE public.f_etddoubleuserinfo OWNER TO postgres;

--
-- Name: f_etduser; Type: FOREIGN TABLE; Schema: public; Owner: postgres
--

CREATE FOREIGN TABLE public.f_etduser (
    id integer NOT NULL,
    currentdata_reprocessingdevice_id integer NOT NULL,
    transponder character varying,
    lastname character varying,
    firstname character varying,
    username character varying,
    updatetime timestamp without time zone,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    userrights character varying,
    internalno character varying
)
SERVER foreign_server
OPTIONS (
    schema_name 'public',
    table_name 'f_etduser'
);


ALTER FOREIGN TABLE public.f_etduser OWNER TO postgres;

--
-- Name: f_person; Type: FOREIGN TABLE; Schema: public; Owner: postgres
--

CREATE FOREIGN TABLE public.f_person (
    useraccount_id integer NOT NULL,
    username character varying,
    firstname character varying,
    lastname character varying,
    dateofbirth date,
    employeenumber character varying,
    socialsecurityno character varying,
    localpassword character varying,
    distinguishedname character varying,
    customfield1 character varying,
    customfield2 character varying,
    customfield3 character varying,
    customfield4 character varying,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean NOT NULL,
    isincomplete boolean NOT NULL,
    middlename character varying
)
SERVER foreign_server
OPTIONS (
    schema_name 'public',
    table_name 'f_person'
);


ALTER FOREIGN TABLE public.f_person OWNER TO postgres;

--
-- Name: flow_batch; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flow_batch (
    id integer NOT NULL,
    reprocessingdevice_id integer NOT NULL
);


ALTER TABLE public.flow_batch OWNER TO postgres;

--
-- Name: flow_batch_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.flow_batch_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.flow_batch_id_seq OWNER TO postgres;

--
-- Name: flow_batch_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.flow_batch_id_seq OWNED BY public.flow_batch.id;


--
-- Name: flow_statistics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flow_statistics (
    id integer NOT NULL,
    flow_batch_id integer NOT NULL,
    type integer DEFAULT 0,
    nr integer DEFAULT 0,
    "timestamp" timestamp without time zone NOT NULL,
    sn_endoid character varying(50),
    sn_profitronic character varying(50),
    endoscopetype character varying(50),
    endoscope_sn character varying(50),
    endoscope_referencetype character varying(50),
    min_1 integer DEFAULT 0,
    max_1 integer DEFAULT 0,
    flow_1 integer DEFAULT 0,
    min_2 integer DEFAULT 0,
    max_2 integer DEFAULT 0,
    flow_2 integer DEFAULT 0,
    min_3 integer DEFAULT 0,
    max_3 integer DEFAULT 0,
    flow_3 integer DEFAULT 0,
    total_flow integer DEFAULT 0,
    albaran_channel smallint DEFAULT 0,
    "position" character varying(10),
    program character varying(80),
    temperature real
);


ALTER TABLE public.flow_statistics OWNER TO postgres;

--
-- Name: flow_statistics_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.flow_statistics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.flow_statistics_id_seq OWNER TO postgres;

--
-- Name: flow_statistics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.flow_statistics_id_seq OWNED BY public.flow_statistics.id;


--
-- Name: hsttversion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hsttversion (
    id integer NOT NULL,
    hsttversionnumber character varying NOT NULL,
    isdeleted boolean NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL
);


ALTER TABLE public.hsttversion OWNER TO postgres;

--
-- Name: hsttversion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hsttversion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.hsttversion_id_seq OWNER TO postgres;

--
-- Name: hsttversion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.hsttversion_id_seq OWNED BY public.hsttversion.id;


--
-- Name: identifier_has_logbook; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identifier_has_logbook (
    identifier_id integer NOT NULL,
    logbook_id integer NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL
);


ALTER TABLE public.identifier_has_logbook OWNER TO postgres;

--
-- Name: identifier_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.identifier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.identifier_id_seq OWNER TO postgres;

--
-- Name: identifier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.identifier_id_seq OWNED BY public.identifier.id;


--
-- Name: identifiertype_has_logbook; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identifiertype_has_logbook (
    identifiertype_id integer NOT NULL,
    logbook_id integer NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL
);


ALTER TABLE public.identifiertype_has_logbook OWNER TO postgres;

--
-- Name: identifiertype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.identifiertype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.identifiertype_id_seq OWNER TO postgres;

--
-- Name: identifiertype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.identifiertype_id_seq OWNED BY public.identifiertype.id;


--
-- Name: ifxversion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ifxversion (
    version integer NOT NULL
);


ALTER TABLE public.ifxversion OWNER TO postgres;

--
-- Name: knownpeer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.knownpeer (
    id integer NOT NULL,
    peername character varying,
    peertype integer,
    systemid character varying,
    lastusedip character varying,
    lastusedhostname character varying,
    physicallocation character varying,
    lastconnected timestamp without time zone,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean NOT NULL,
    isdisabled boolean NOT NULL
);


ALTER TABLE public.knownpeer OWNER TO postgres;

--
-- Name: knownpeer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.knownpeer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.knownpeer_id_seq OWNER TO postgres;

--
-- Name: knownpeer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.knownpeer_id_seq OWNED BY public.knownpeer.id;


--
-- Name: license; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.license (
    id integer NOT NULL,
    licensekey character varying,
    appliedonsystemid integer NOT NULL,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean NOT NULL,
    isdisabled boolean NOT NULL,
    isvisible boolean DEFAULT true NOT NULL
);


ALTER TABLE public.license OWNER TO postgres;

--
-- Name: license_appliedonsystemid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.license_appliedonsystemid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.license_appliedonsystemid_seq OWNER TO postgres;

--
-- Name: license_appliedonsystemid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.license_appliedonsystemid_seq OWNED BY public.license.appliedonsystemid;


--
-- Name: license_has_logbook; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.license_has_logbook (
    license_id integer NOT NULL,
    logbook_id integer NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL,
    isdisabled boolean NOT NULL
);


ALTER TABLE public.license_has_logbook OWNER TO postgres;

--
-- Name: license_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.license_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.license_id_seq OWNER TO postgres;

--
-- Name: license_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.license_id_seq OWNED BY public.license.id;


--
-- Name: logbook; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.logbook (
    id integer NOT NULL,
    logbookcategory_id integer NOT NULL,
    useraccount_id integer,
    reprocessinghistoryitem_id integer,
    reprocessingdevice_id integer,
    "timestamp" timestamp without time zone NOT NULL,
    textualcontent text,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean DEFAULT false NOT NULL,
    ismanualentry boolean DEFAULT false NOT NULL,
    tobeconfirmed boolean DEFAULT false NOT NULL,
    confirmationdate timestamp without time zone,
    confirmation_useraccount_id integer,
    logbookobjecttype_id integer DEFAULT 1 NOT NULL,
    logbookevent_id integer,
    logbooksource_id integer,
    markasread boolean DEFAULT false NOT NULL,
    markedasreaddate timestamp without time zone,
    markedasreaduseraccountid integer,
    logbookmessagetype_id integer
);


ALTER TABLE public.logbook OWNER TO postgres;

--
-- Name: logbook_has_attachment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.logbook_has_attachment (
    id integer NOT NULL,
    attachment_id integer NOT NULL,
    logbook_id integer NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL
);


ALTER TABLE public.logbook_has_attachment OWNER TO postgres;

--
-- Name: logbook_has_attachment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.logbook_has_attachment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.logbook_has_attachment_id_seq OWNER TO postgres;

--
-- Name: logbook_has_attachment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.logbook_has_attachment_id_seq OWNED BY public.logbook_has_attachment.id;


--
-- Name: logbook_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.logbook_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.logbook_id_seq OWNER TO postgres;

--
-- Name: logbook_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.logbook_id_seq OWNED BY public.logbook.id;


--
-- Name: logbookcategory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.logbookcategory (
    id integer CONSTRAINT logbooktype_id_not_null NOT NULL,
    categoryname character varying,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean DEFAULT false NOT NULL,
    isdisabled boolean DEFAULT false NOT NULL,
    displayname character varying,
    iscustom boolean DEFAULT false NOT NULL
);


ALTER TABLE public.logbookcategory OWNER TO postgres;

--
-- Name: logbookmessagetypeid; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.logbookmessagetypeid (
    id integer NOT NULL,
    messagetypeid character varying NOT NULL
);


ALTER TABLE public.logbookmessagetypeid OWNER TO postgres;

--
-- Name: reprocessingdevice; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reprocessingdevice (
    id integer NOT NULL,
    reprocessingdevicetype_id integer CONSTRAINT reprocessingdevice_reporcessingdevicetype_id_not_null NOT NULL,
    serialnumber character varying,
    location character varying,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone,
    isdeleted boolean NOT NULL,
    isdisabled boolean NOT NULL,
    name character varying,
    customdescription character varying,
    purchaseddate date,
    retiredate date,
    customcolumn1 character varying,
    customcolumn2 character varying,
    customcolumn3 character varying,
    customcolumn4 character varying,
    customcolumn5 character varying,
    customcolumn6 character varying,
    customcolumn7 character varying,
    customcolumn8 character varying,
    customcolumn9 character varying,
    customcolumn10 character varying,
    udi character varying,
    isquarantine boolean NOT NULL,
    firmwareversion character varying,
    printsettings_id integer,
    mappinggroup_id integer DEFAULT 0 NOT NULL,
    chemicalstype_id integer DEFAULT 0 NOT NULL,
    defectdate date
);


ALTER TABLE public.reprocessingdevice OWNER TO postgres;

--
-- Name: reprocessingdevice_has_logbook; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reprocessingdevice_has_logbook (
    reprocessingdevice_id integer NOT NULL,
    logbook_id integer NOT NULL,
    lastedit timestamp without time zone,
    isdeleted boolean,
    isdisabled boolean,
    creationdate timestamp without time zone
);


ALTER TABLE public.reprocessingdevice_has_logbook OWNER TO postgres;

--
-- Name: reprocessingdevicetype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reprocessingdevicetype (
    id integer CONSTRAINT reporcessingdevicetype_id_not_null NOT NULL,
    typename character varying,
    devicetype integer,
    maximunload integer NOT NULL,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean,
    isdisabled boolean,
    deviceuserleveltype integer,
    isrdge boolean DEFAULT false NOT NULL
);


ALTER TABLE public.reprocessingdevicetype OWNER TO postgres;

--
-- Name: reprocessinginstruction_has_logbook; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reprocessinginstruction_has_logbook (
    reprocessinginstruction_id integer CONSTRAINT reprocessinginstruction_has_reprocessinginstruction_id_not_null NOT NULL,
    logbook_id integer NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL
);


ALTER TABLE public.reprocessinginstruction_has_logbook OWNER TO postgres;

--
-- Name: useraccount; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.useraccount (
    id integer NOT NULL,
    ldapobjectguid character varying,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean NOT NULL,
    isdisabled boolean NOT NULL,
    isquarantined boolean NOT NULL,
    quarantinedbysourceid integer DEFAULT 0 CONSTRAINT useraccount_quarantinedbyid_not_null NOT NULL,
    quarantinecausinguserid integer DEFAULT 0 CONSTRAINT useraccount_quarantinedrelatedid_not_null NOT NULL,
    userguid character varying,
    quarantineparentuserid integer DEFAULT 0 CONSTRAINT useraccount_quarantineparentid_not_null NOT NULL,
    quarantinedbysourcetypeid integer DEFAULT 0 NOT NULL,
    quarantinereasonresultid integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.useraccount OWNER TO postgres;

--
-- Name: useraccount_has_logbook; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.useraccount_has_logbook (
    useraccount_id integer NOT NULL,
    logbook_id integer NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL
);


ALTER TABLE public.useraccount_has_logbook OWNER TO postgres;

--
-- Name: userdevicelevelgroup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.userdevicelevelgroup (
    id integer NOT NULL,
    name character varying,
    description character varying,
    ldapobjectguid character varying,
    distinguishedname character varying,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean NOT NULL,
    isdisabled boolean NOT NULL,
    userdevicefamily integer DEFAULT 0 NOT NULL,
    ldapname character varying,
    userlevel integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.userdevicelevelgroup OWNER TO postgres;

--
-- Name: userdevicelevelgroup_has_logbook; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.userdevicelevelgroup_has_logbook (
    userdevicelevelgroup_id integer CONSTRAINT userdevicelevelgroup_has_logbo_userdevicelevelgroup_id_not_null NOT NULL,
    logbook_id integer NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL
);


ALTER TABLE public.userdevicelevelgroup_has_logbook OWNER TO postgres;

--
-- Name: usergroup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usergroup (
    id integer NOT NULL,
    name character varying,
    description character varying,
    ldapobjectguid character varying,
    distinguishedname character varying,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean NOT NULL,
    isdisabled boolean NOT NULL,
    ldapname character varying
);


ALTER TABLE public.usergroup OWNER TO postgres;

--
-- Name: usergroup_has_logbook; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usergroup_has_logbook (
    usergroup_id integer NOT NULL,
    logbook_id integer NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL
);


ALTER TABLE public.usergroup_has_logbook OWNER TO postgres;

--
-- Name: logbook_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.logbook_view AS
 SELECT row_number() OVER (ORDER BY logbook.id, endoscope.id, reprocessingdevice.id, author.id, useraccount.id, identifier.id, usergroup.id, userdevicelevelgroup.id, identifiertype.id, reprocessinginstruction.id, endoscopetype.id, logbook_has_attachment.id, logbookcategory.id) AS id,
    logbook.id AS logbook_id,
    logbook."timestamp",
    concat_ws(', '::text,
        CASE
            WHEN (NULLIF((authorperson.lastname)::text, ''::text) IS NOT NULL) THEN concat_ws(', '::text, NULLIF((authorperson.lastname)::text, ''::text), NULLIF((authorperson.firstname)::text, ''::text))
            ELSE
            CASE
                WHEN (NULLIF((authorperson.username)::text, ''::text) IS NOT NULL) THEN NULLIF((authorperson.username)::text, ''::text)
                ELSE NULLIF((reprocessingdevice.name)::text, ''::text)
            END
        END) AS author,
    concat_ws(', '::text,
        CASE
            WHEN (NULLIF((useritem.lastname)::text, ''::text) IS NOT NULL) THEN concat_ws(', '::text, NULLIF((useritem.lastname)::text, ''::text), NULLIF((useritem.firstname)::text, ''::text))
            ELSE
            CASE
                WHEN (NULLIF((useritem.username)::text, ''::text) IS NOT NULL) THEN NULLIF((useritem.username)::text, ''::text)
                ELSE
                CASE
                    WHEN (NULLIF((etd5useritem.username)::text, ''::text) IS NOT NULL) THEN NULLIF((etd5useritem.username)::text, ''::text)
                    ELSE NULLIF((etdduseritem.username)::text, ''::text)
                END
            END
        END) AS "user",
    concat_ws(', '::text, NULLIF((manufacturer.name)::text, ''::text), NULLIF((endotype.typename)::text, ''::text), NULLIF((reprocessingdevicetype.typename)::text, ''::text)) AS objectsubtype,
        CASE
            WHEN (logbookcategory.iscustom IS TRUE) THEN
            CASE
                WHEN (NULLIF((logbookcategory.displayname)::text, ''::text) IS NOT NULL) THEN (logbookcategory.displayname)::text
                ELSE NULLIF((logbookcategory.categoryname)::text, ''::text)
            END
            ELSE NULLIF((logbookcategory.categoryname)::text, ''::text)
        END AS logbookcategoryname,
    concat_ws(', '::text, NULLIF((endoscope.serialnumber)::text, ''::text), NULLIF((endoscope.internalid)::text, ''::text), NULLIF((reprocessingdevice.serialnumber)::text, ''::text), NULLIF((reprocessingdevice.name)::text, ''::text),
        CASE
            WHEN (NULLIF((useritem.lastname)::text, ''::text) IS NOT NULL) THEN concat_ws(', '::text, NULLIF((useritem.lastname)::text, ''::text), NULLIF((useritem.firstname)::text, ''::text))
            ELSE
            CASE
                WHEN (NULLIF((useritem.username)::text, ''::text) IS NOT NULL) THEN NULLIF((useritem.username)::text, ''::text)
                ELSE
                CASE
                    WHEN (NULLIF((etd5useritem.username)::text, ''::text) IS NOT NULL) THEN NULLIF((etd5useritem.username)::text, ''::text)
                    ELSE NULLIF((etdduseritem.username)::text, ''::text)
                END
            END
        END, NULLIF((identifieridentifiertype.typename)::text, ''::text), NULLIF((identifier.value)::text, ''::text), NULLIF((usergroup.name)::text, ''::text), NULLIF((userdevicelevelgroup.name)::text, ''::text), NULLIF((identifiertype.givenname)::text, ''::text), NULLIF((reprocessinginstruction.name)::text, ''::text), NULLIF((endoscopetype.typename)::text, ''::text)) AS objectattributes,
        CASE
            WHEN (logbook_has_attachment.logbook_id IS NULL) THEN false
            ELSE true
        END AS has_attachments,
    privatecontent.textualcontent AS content,
    logbook.tobeconfirmed,
    logbook.logbookcategory_id,
    logbook.logbookobjecttype_id,
    logbook.logbooksource_id,
    logbook.logbookevent_id,
    logbook.confirmationdate AS confirmedon,
    logbook.ismanualentry,
    logbook.logbookmessagetype_id,
    logbook.markasread,
    logbook.markedasreaddate,
    logbookmessagetypeid.messagetypeid,
    endoscope_has_logbook.endoscope_id,
    reprocessingdevice_has_logbook.reprocessingdevice_id,
    logbook.isdeleted,
        CASE
            WHEN (logbook.confirmationdate IS NOT NULL) THEN 'AlreadyConfirmed'::text
            WHEN (logbook.markedasreaddate IS NOT NULL) THEN 'AlreadyMarkedAsRead'::text
            WHEN (logbook.tobeconfirmed IS TRUE) THEN 'ToBeConfirmed'::text
            WHEN (logbook.markasread IS TRUE) THEN 'ToBeMarkedAsRead'::text
            ELSE 'NoConfirmationRequired'::text
        END AS confirmation
   FROM (((((((((((((((((((((((((((((((public.logbook
     LEFT JOIN private.p_logbook privatecontent ON ((privatecontent.logbook_id = logbook.id)))
     LEFT JOIN public.useraccount author ON ((author.id = logbook.useraccount_id)))
     LEFT JOIN private.p_person authorperson ON ((authorperson.useraccount_id = author.id)))
     LEFT JOIN public.endoscope_has_logbook ON ((endoscope_has_logbook.logbook_id = logbook.id)))
     LEFT JOIN public.endoscope ON ((endoscope.id = endoscope_has_logbook.endoscope_id)))
     LEFT JOIN public.endoscopetype endotype ON ((endotype.id = endoscope.endoscopetype_id)))
     LEFT JOIN public.manufacturer ON ((manufacturer.id = endotype.manufacturer_id)))
     LEFT JOIN public.reprocessingdevice_has_logbook ON ((reprocessingdevice_has_logbook.logbook_id = logbook.id)))
     LEFT JOIN public.reprocessingdevice ON ((reprocessingdevice.id = reprocessingdevice_has_logbook.reprocessingdevice_id)))
     LEFT JOIN public.reprocessingdevicetype ON ((reprocessingdevicetype.id = reprocessingdevice.reprocessingdevicetype_id)))
     LEFT JOIN public.useraccount_has_logbook ON ((useraccount_has_logbook.logbook_id = logbook.id)))
     LEFT JOIN public.useraccount ON ((useraccount.id = useraccount_has_logbook.useraccount_id)))
     LEFT JOIN private.p_person useritem ON ((useritem.useraccount_id = useraccount.id)))
     LEFT JOIN private.p_deviceuseretd5 etd5useritem ON ((etd5useritem.useraccount_id = useraccount.id)))
     LEFT JOIN public.deviceuseretddouble etdduseritem ON ((etdduseritem.useraccount_id = useraccount.id)))
     LEFT JOIN public.identifier_has_logbook ON ((identifier_has_logbook.logbook_id = logbook.id)))
     LEFT JOIN public.identifier ON ((identifier.id = identifier_has_logbook.identifier_id)))
     LEFT JOIN public.identifiertype identifieridentifiertype ON ((identifieridentifiertype.id = identifier.identifiertype_id)))
     LEFT JOIN public.usergroup_has_logbook ON ((usergroup_has_logbook.logbook_id = logbook.id)))
     LEFT JOIN public.usergroup ON ((usergroup.id = usergroup_has_logbook.usergroup_id)))
     LEFT JOIN public.userdevicelevelgroup_has_logbook ON ((userdevicelevelgroup_has_logbook.logbook_id = logbook.id)))
     LEFT JOIN public.userdevicelevelgroup ON ((userdevicelevelgroup.id = userdevicelevelgroup_has_logbook.userdevicelevelgroup_id)))
     LEFT JOIN public.identifiertype_has_logbook ON ((identifiertype_has_logbook.logbook_id = logbook.id)))
     LEFT JOIN public.identifiertype ON ((identifiertype.id = identifiertype_has_logbook.identifiertype_id)))
     LEFT JOIN public.reprocessinginstruction_has_logbook ON ((reprocessinginstruction_has_logbook.logbook_id = logbook.id)))
     LEFT JOIN public.reprocessinginstruction ON ((reprocessinginstruction.id = reprocessinginstruction_has_logbook.reprocessinginstruction_id)))
     LEFT JOIN public.endoscopetype_has_logbook ON ((endoscopetype_has_logbook.logbook_id = logbook.id)))
     LEFT JOIN public.endoscopetype ON ((endoscopetype.id = endoscopetype_has_logbook.endoscopetype_id)))
     LEFT JOIN public.logbook_has_attachment ON ((logbook_has_attachment.logbook_id = logbook.id)))
     LEFT JOIN public.logbookcategory ON ((logbookcategory.id = logbook.logbookcategory_id)))
     LEFT JOIN public.logbookmessagetypeid ON ((logbookmessagetypeid.id = logbook.logbookmessagetype_id)));


ALTER VIEW public.logbook_view OWNER TO postgres;

--
-- Name: logbookevent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.logbookevent (
    id integer NOT NULL,
    name character varying,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL
);


ALTER TABLE public.logbookevent OWNER TO postgres;

--
-- Name: logbookevent_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.logbookevent_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.logbookevent_id_seq OWNER TO postgres;

--
-- Name: logbookevent_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.logbookevent_id_seq OWNED BY public.logbookevent.id;


--
-- Name: logbookobjecttype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.logbookobjecttype (
    id integer NOT NULL,
    name character varying,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL
);


ALTER TABLE public.logbookobjecttype OWNER TO postgres;

--
-- Name: logbookobjecttype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.logbookobjecttype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.logbookobjecttype_id_seq OWNER TO postgres;

--
-- Name: logbookobjecttype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.logbookobjecttype_id_seq OWNED BY public.logbookobjecttype.id;


--
-- Name: logbooksource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.logbooksource (
    id integer NOT NULL,
    name character varying,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL
);


ALTER TABLE public.logbooksource OWNER TO postgres;

--
-- Name: logbooksource_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.logbooksource_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.logbooksource_id_seq OWNER TO postgres;

--
-- Name: logbooksource_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.logbooksource_id_seq OWNED BY public.logbooksource.id;


--
-- Name: logbooktype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.logbooktype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.logbooktype_id_seq OWNER TO postgres;

--
-- Name: logbooktype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.logbooktype_id_seq OWNED BY public.logbookcategory.id;


--
-- Name: manualprotocol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.manualprotocol (
    id integer NOT NULL,
    reprocessinghistoryitem_id integer NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL,
    checklist_id integer
);


ALTER TABLE public.manualprotocol OWNER TO postgres;

--
-- Name: manualprotocol_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.manualprotocol_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.manualprotocol_id_seq OWNER TO postgres;

--
-- Name: manualprotocol_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.manualprotocol_id_seq OWNED BY public.manualprotocol.id;


--
-- Name: manualprotocolitem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.manualprotocolitem (
    id integer NOT NULL,
    manualprotocol_id integer NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL,
    ischecked boolean NOT NULL,
    checklistitem_id integer NOT NULL,
    checklistitem_checklist_id integer NOT NULL,
    checktime timestamp without time zone
);


ALTER TABLE public.manualprotocolitem OWNER TO postgres;

--
-- Name: manualprotocolitem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.manualprotocolitem_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.manualprotocolitem_id_seq OWNER TO postgres;

--
-- Name: manualprotocolitem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.manualprotocolitem_id_seq OWNED BY public.manualprotocolitem.id;


--
-- Name: manufacturer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.manufacturer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.manufacturer_id_seq OWNER TO postgres;

--
-- Name: manufacturer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.manufacturer_id_seq OWNED BY public.manufacturer.id;


--
-- Name: mappinggroup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mappinggroup (
    id integer NOT NULL,
    name character varying NOT NULL,
    reprocessingdevicetype_id integer
);


ALTER TABLE public.mappinggroup OWNER TO postgres;

--
-- Name: printsettings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.printsettings (
    id integer NOT NULL,
    isdeleted boolean NOT NULL,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    configname character varying,
    autoprint boolean NOT NULL,
    autoexport boolean NOT NULL,
    exportpath character varying,
    printername character varying,
    printtemplate character varying,
    exporttemplate character varying,
    numberofcopies integer
);


ALTER TABLE public.printsettings OWNER TO postgres;

--
-- Name: printsettings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.printsettings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.printsettings_id_seq OWNER TO postgres;

--
-- Name: printsettings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.printsettings_id_seq OWNED BY public.printsettings.id;


--
-- Name: procedure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.procedure (
    id integer NOT NULL,
    proceduretype_id integer,
    dicomstudyinstanceuid character varying,
    dicomprocedurestepid character varying,
    starttime timestamp without time zone,
    physician character varying,
    room character varying,
    comment text,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    sourcetypeid integer DEFAULT 0 NOT NULL,
    departmentname character varying,
    accessionnumber character varying,
    customfield character varying,
    dicomprocedurestepdescription character varying
);


ALTER TABLE public.procedure OWNER TO postgres;

--
-- Name: procedure_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.procedure_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.procedure_id_seq OWNER TO postgres;

--
-- Name: procedure_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.procedure_id_seq OWNED BY public.procedure.id;


--
-- Name: proceduretype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.proceduretype (
    id integer NOT NULL,
    name character varying,
    dicomprocedurestepdescription character varying,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL,
    comment character varying
);


ALTER TABLE public.proceduretype OWNER TO postgres;

--
-- Name: proceduretype_has_logbook; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.proceduretype_has_logbook (
    proceduretype_id integer NOT NULL,
    logbook_id integer NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL
);


ALTER TABLE public.proceduretype_has_logbook OWNER TO postgres;

--
-- Name: proceduretype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.proceduretype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.proceduretype_id_seq OWNER TO postgres;

--
-- Name: proceduretype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.proceduretype_id_seq OWNED BY public.proceduretype.id;


--
-- Name: profil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profil (
    id integer NOT NULL,
    name character varying,
    description text,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean NOT NULL,
    isdefaultprofile boolean DEFAULT false NOT NULL,
    defaultposition integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.profil OWNER TO postgres;

--
-- Name: profil_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.profil_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.profil_id_seq OWNER TO postgres;

--
-- Name: profil_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.profil_id_seq OWNED BY public.profil.id;


--
-- Name: protocol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol (
    id integer NOT NULL,
    reprocessingdevice_id integer NOT NULL,
    starttime timestamp without time zone,
    endtime timestamp without time zone,
    errorcode integer,
    protocolrawdata text,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean,
    isdisabled boolean
);


ALTER TABLE public.protocol OWNER TO postgres;

--
-- Name: protocol_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.protocol_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.protocol_id_seq OWNER TO postgres;

--
-- Name: protocol_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.protocol_id_seq OWNED BY public.protocol.id;


--
-- Name: reprocessinghistoryitem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reprocessinghistoryitem (
    id integer NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL,
    startuseraccount_id integer,
    enduseraccount_id integer,
    reprocessingdevice_id integer,
    starttime timestamp without time zone NOT NULL,
    endtime timestamp without time zone,
    timeincludesseconds boolean NOT NULL,
    success boolean NOT NULL,
    reprocessinghistoryitemeventtype_id integer DEFAULT 1 CONSTRAINT reprocessinghistoryitem_reprocessinghistoryitemeventty_not_null NOT NULL,
    starttimereceived timestamp without time zone NOT NULL,
    endtimereceived timestamp without time zone,
    batch_id integer,
    startdeviceusername character varying,
    enddeviceusername character varying
);


ALTER TABLE public.reprocessinghistoryitem OWNER TO postgres;

--
-- Name: reprocessinghistoryitem_profil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reprocessinghistoryitem_profil (
    idprofile_reprocessinghistoryitem integer CONSTRAINT reprocessinghistoryitem_pro_idprofile_reprocessinghist_not_null NOT NULL,
    reprocessinghistoryitem_id integer CONSTRAINT reprocessinghistoryitem_pro_reprocessinghistoryitem_id_not_null NOT NULL,
    profil_id integer NOT NULL,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean,
    isdisabled boolean
);


ALTER TABLE public.reprocessinghistoryitem_profil OWNER TO postgres;

--
-- Name: reprocessinghistoryitemeventtype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reprocessinghistoryitemeventtype (
    id integer NOT NULL,
    typename character varying NOT NULL,
    creatiiondate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean
);


ALTER TABLE public.reprocessinghistoryitemeventtype OWNER TO postgres;

--
-- Name: protocol_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.protocol_view AS
 SELECT endoscope_has_reprocessighistoryitems.id,
    rep.id AS protocol_id,
    endoscope.id AS endoscope_id,
    rep.batch_id,
    batch.devicebatchid AS devicebatch_id,
    ( SELECT string_agg((profil.name)::text, ', '::text) AS string_agg
           FROM public.reprocessinghistoryitem,
            public.profil,
            public.reprocessinghistoryitem_profil
          WHERE ((reprocessinghistoryitem.id = rep.id) AND (reprocessinghistoryitem_profil.reprocessinghistoryitem_id = reprocessinghistoryitem.id) AND (profil.id = reprocessinghistoryitem_profil.profil_id))
         LIMIT 2) AS profile,
        CASE
            WHEN (rep.endtime IS NULL) THEN true
            ELSE false
        END AS isrunning,
    rep.success AS is_success,
    reprocessinghistoryitemeventtype.id AS reprocessinghistoryitemeventtype_id,
    rep.endtime AS finished_at,
    rep.starttime AS started_at,
    reprocessinghistoryitemeventtype.typename AS description,
    concat_ws(', '::text, NULLIF((manufacturer.name)::text, ''::text), NULLIF((endoscopetype.typename)::text, ''::text), NULLIF((endoscope.serialnumber)::text, ''::text), NULLIF((endoscope.internalid)::text, ''::text)) AS endoscopedisplayname,
        CASE
            WHEN (rep.endtime IS NOT NULL) THEN
            CASE
                WHEN ((COALESCE(concat_ws(', '::text, NULLIF((endperson.lastname)::text, ''::text), NULLIF((endperson.firstname)::text, ''::text), NULLIF((endperson.employeenumber)::text, ''::text)), ''::text) = ''::text) IS FALSE) THEN ((concat_ws(', '::text, NULLIF((endperson.lastname)::text, ''::text), NULLIF((endperson.firstname)::text, ''::text), NULLIF((endperson.employeenumber)::text, ''::text)))::character varying)::text
                WHEN (rep.enddeviceusername IS NOT NULL) THEN concat_ws(': '::text, NULLIF((enduser.id)::text, ''::text), NULLIF((rep.enddeviceusername)::text, ''::text))
                WHEN (endperson.username IS NOT NULL) THEN (endperson.username)::text
                ELSE (enduser.id)::text
            END
            ELSE NULL::text
        END AS finished_by,
        CASE
            WHEN ((COALESCE(concat_ws(', '::text, NULLIF((startperson.lastname)::text, ''::text), NULLIF((startperson.firstname)::text, ''::text), NULLIF((startperson.employeenumber)::text, ''::text)), ''::text) = ''::text) IS FALSE) THEN (concat_ws(', '::text, NULLIF((startperson.lastname)::text, ''::text), NULLIF((startperson.firstname)::text, ''::text), NULLIF((startperson.employeenumber)::text, ''::text)))::character varying
            WHEN (rep.startdeviceusername IS NOT NULL) THEN (concat_ws(': '::text, NULLIF((startuser.id)::text, ''::text), NULLIF((rep.startdeviceusername)::text, ''::text)))::character varying
            WHEN (startperson.username IS NOT NULL) THEN startperson.username
            ELSE (startuser.id)::character varying
        END AS started_by,
        CASE
            WHEN (minfo.etd5maschinevariant_id IS NOT NULL) THEN
            CASE
                WHEN starts_with((mvar.name)::text, 'BASIC'::text) THEN concat_ws(', '::text, 'ETD Basic', NULLIF((reprocessingdevice.customdescription)::text, ''::text), NULLIF((reprocessingdevice.serialnumber)::text, ''::text))
                ELSE concat_ws(', '::text, 'ETD Premium', NULLIF((reprocessingdevice.customdescription)::text, ''::text), NULLIF((reprocessingdevice.serialnumber)::text, ''::text))
            END
            ELSE concat_ws(', '::text, NULLIF((reprocessingdevicetype.typename)::text, ''::text), NULLIF((reprocessingdevice.customdescription)::text, ''::text), NULLIF((reprocessingdevice.serialnumber)::text, ''::text))
        END AS reprocessingdevice_display_name,
    reprocessingdevicetype.devicetype,
    ct.enumchemicalname AS processchemicals,
        CASE
            WHEN ((rep.endtime IS NOT NULL) AND rep.success) THEN true
            ELSE false
        END AS isfinished,
    reprocessingdevice.id AS reprocessingdevice_id,
    ( SELECT logbook.id
           FROM public.logbook,
            public.reprocessinghistoryitem
          WHERE ((reprocessinghistoryitem.id = logbook.reprocessinghistoryitem_id) AND (reprocessinghistoryitem.id = rep.id))
         LIMIT 1) AS logbook_id,
    concat_ws(''::text, ( SELECT etddoublereprocessingprotocol.programname
           FROM public.etddoublereprocessingprotocol
          WHERE (etddoublereprocessingprotocol.reprocessinghistoryitem_id = rep.id)
          ORDER BY etddoublereprocessingprotocol.id DESC
         LIMIT 1), ( SELECT etdv3reprocessingprotocol.protocolprogramname
           FROM public.etdv3reprocessingprotocol
          WHERE (etdv3reprocessingprotocol.reprocessinghistoryitem_id = rep.id)
          ORDER BY etdv3reprocessingprotocol.id DESC
         LIMIT 1), ( SELECT etdminireprocessingprotocol.cyclename
           FROM public.etdminireprocessingprotocol
          WHERE (etdminireprocessingprotocol.reprocessinghistoryitem_id = rep.id)
          ORDER BY etdminireprocessingprotocol.id DESC
         LIMIT 1), ( SELECT etd5reprocessingprotocol.programname
           FROM public.etd5reprocessingprotocol
          WHERE (etd5reprocessingprotocol.reprocessinghistoryitem_id = rep.id)
          ORDER BY etd5reprocessingprotocol.id DESC
         LIMIT 1)) AS programname,
    concat_ws(''::text, ( SELECT etddoublereprocessingprotocol.errornumber
           FROM public.etddoublereprocessingprotocol
          WHERE (etddoublereprocessingprotocol.reprocessinghistoryitem_id = rep.id)
          ORDER BY etddoublereprocessingprotocol.id DESC
         LIMIT 1), ( SELECT etdv3reprocessingprotocol.protocolresultcode
           FROM public.etdv3reprocessingprotocol
          WHERE (etdv3reprocessingprotocol.reprocessinghistoryitem_id = rep.id)
          ORDER BY etdv3reprocessingprotocol.id DESC
         LIMIT 1), ( SELECT edcreprocessingprotocol.result
           FROM public.edcreprocessingprotocol
          WHERE (edcreprocessingprotocol.reprocessinghistoryitem_id = rep.id)
          ORDER BY edcreprocessingprotocol.id DESC
         LIMIT 1), ( SELECT etdminireprocessingprotocol.cycleresultcode
           FROM public.etdminireprocessingprotocol
          WHERE (etdminireprocessingprotocol.reprocessinghistoryitem_id = rep.id)
          ORDER BY etdminireprocessingprotocol.id DESC
         LIMIT 1), ( SELECT etd5reprocessingprotocol.errornumber
           FROM public.etd5reprocessingprotocol
          WHERE (etd5reprocessingprotocol.reprocessinghistoryitem_id = rep.id)
          ORDER BY etd5reprocessingprotocol.id DESC
         LIMIT 1)) AS resultcode,
    ( SELECT cycle.id
           FROM (public.cyclestep
             JOIN public.cycle ON ((cycle.id = cyclestep.cycle_id)))
          WHERE ((cyclestep.reprocessinghistoryitem_id = rep.id) AND (cycle.endoscope_id = endoscope.id))
         LIMIT 1) AS cycle_id,
    ( SELECT string_agg((reprocessingstation.name)::text, ', '::text) AS string_agg
           FROM ((public.cyclestep
             JOIN public.reprocessingstation ON ((reprocessingstation.id = cyclestep.reprocessingstation_id)))
             JOIN public.cycle ON ((cycle.id = cyclestep.cycle_id)))
          WHERE ((cycle.endoscope_id = endoscope.id) AND (cyclestep.reprocessinghistoryitem_id = rep.id))) AS stationname
   FROM (((((((((((((((public.reprocessinghistoryitem rep
     LEFT JOIN public.reprocessinghistoryitemeventtype ON ((reprocessinghistoryitemeventtype.id = rep.reprocessinghistoryitemeventtype_id)))
     LEFT JOIN public.useraccount enduser ON ((enduser.id = rep.enduseraccount_id)))
     LEFT JOIN private.p_person endperson ON ((endperson.useraccount_id = enduser.id)))
     LEFT JOIN public.useraccount startuser ON ((startuser.id = rep.startuseraccount_id)))
     LEFT JOIN private.p_person startperson ON ((startperson.useraccount_id = startuser.id)))
     LEFT JOIN public.endoscope_has_reprocessighistoryitems ON ((endoscope_has_reprocessighistoryitems.reprocessinghistoryitem_id = rep.id)))
     LEFT JOIN public.endoscope ON ((endoscope.id = endoscope_has_reprocessighistoryitems.endoscope_id)))
     LEFT JOIN public.endoscopetype ON ((endoscopetype.id = endoscope.endoscopetype_id)))
     LEFT JOIN public.manufacturer ON ((manufacturer.id = endoscopetype.manufacturer_id)))
     LEFT JOIN public.reprocessingdevice ON ((reprocessingdevice.id = rep.reprocessingdevice_id)))
     LEFT JOIN public.chemicalstype ct ON ((ct.id = reprocessingdevice.chemicalstype_id)))
     LEFT JOIN public.etd5machineinfo minfo ON ((minfo.reprocessingdevice_id = rep.reprocessingdevice_id)))
     LEFT JOIN public.etd5maschinevariant mvar ON ((mvar.id = minfo.etd5maschinevariant_id)))
     LEFT JOIN public.reprocessingdevicetype ON ((reprocessingdevicetype.id = reprocessingdevice.reprocessingdevicetype_id)))
     LEFT JOIN public.batch ON ((batch.id = rep.batch_id)))
  WHERE (endoscope_has_reprocessighistoryitems.isdeleted = false);


ALTER VIEW public.protocol_view OWNER TO postgres;

--
-- Name: reprocessingconstraint; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reprocessingconstraint (
    id integer NOT NULL,
    reprocessinginstruction_id integer NOT NULL,
    sequencenumber smallint NOT NULL,
    name character varying NOT NULL,
    timespan integer NOT NULL,
    timeunit integer NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL,
    reprocessingstationfrom_id integer,
    reprocessingstationto_id integer,
    reprocessingstationcompensation_id integer CONSTRAINT reprocessingconstraint_reprocessingstationcompensation_not_null NOT NULL
);


ALTER TABLE public.reprocessingconstraint OWNER TO postgres;

--
-- Name: reprocessingconstraint_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reprocessingconstraint_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reprocessingconstraint_id_seq OWNER TO postgres;

--
-- Name: reprocessingconstraint_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reprocessingconstraint_id_seq OWNED BY public.reprocessingconstraint.id;


--
-- Name: reprocessingdevice_has_department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reprocessingdevice_has_department (
    id integer NOT NULL,
    reprocessingdevice_id integer CONSTRAINT reprocessingdevice_has_departmen_reprocessingdevice_id_not_null NOT NULL,
    department_id integer NOT NULL,
    startdate timestamp without time zone,
    enddate timestamp without time zone,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL
);


ALTER TABLE public.reprocessingdevice_has_department OWNER TO postgres;

--
-- Name: reprocessingdevice_has_department_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reprocessingdevice_has_department_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reprocessingdevice_has_department_id_seq OWNER TO postgres;

--
-- Name: reprocessingdevice_has_department_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reprocessingdevice_has_department_id_seq OWNED BY public.reprocessingdevice_has_department.id;


--
-- Name: reprocessingdevice_has_identifier; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reprocessingdevice_has_identifier (
    id integer NOT NULL,
    reprocessingdevice_id integer CONSTRAINT reprocessingdevice_has_identifie_reprocessingdevice_id_not_null NOT NULL,
    identifier_id integer NOT NULL,
    startdate timestamp without time zone,
    enddate timestamp without time zone,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean NOT NULL
);


ALTER TABLE public.reprocessingdevice_has_identifier OWNER TO postgres;

--
-- Name: reprocessingdevice_has_identifier_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reprocessingdevice_has_identifier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reprocessingdevice_has_identifier_id_seq OWNER TO postgres;

--
-- Name: reprocessingdevice_has_identifier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reprocessingdevice_has_identifier_id_seq OWNED BY public.reprocessingdevice_has_identifier.id;


--
-- Name: reprocessingdevice_has_task; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reprocessingdevice_has_task (
    id integer NOT NULL,
    task_id integer NOT NULL,
    reprocessingdevice_id integer NOT NULL,
    startmaintenancedate timestamp without time zone NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL,
    isdisabled boolean NOT NULL
);


ALTER TABLE public.reprocessingdevice_has_task OWNER TO postgres;

--
-- Name: reprocessingdevice_has_task_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reprocessingdevice_has_task_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reprocessingdevice_has_task_id_seq OWNER TO postgres;

--
-- Name: reprocessingdevice_has_task_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reprocessingdevice_has_task_id_seq OWNED BY public.reprocessingdevice_has_task.id;


--
-- Name: reprocessingdevice_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reprocessingdevice_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reprocessingdevice_id_seq OWNER TO postgres;

--
-- Name: reprocessingdevice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reprocessingdevice_id_seq OWNED BY public.reprocessingdevice.id;


--
-- Name: reprocessingdevicetype_has_identifiertype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reprocessingdevicetype_has_identifiertype (
    reprocessingdevicetype_id integer CONSTRAINT reprocessingdevicetype_has_i_reprocessingdevicetype_id_not_null NOT NULL,
    identifiertype_id integer CONSTRAINT reprocessingdevicetype_has_identifie_identifiertype_id_not_null NOT NULL,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone
);


ALTER TABLE public.reprocessingdevicetype_has_identifiertype OWNER TO postgres;

--
-- Name: reprocessingdevicetype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reprocessingdevicetype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reprocessingdevicetype_id_seq OWNER TO postgres;

--
-- Name: reprocessinghistoryitem_has_department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reprocessinghistoryitem_has_department (
    id integer NOT NULL,
    reprocessinghistoryitem_id integer CONSTRAINT reprocessinghistoryitem_has_reprocessinghistoryitem_id_not_null NOT NULL,
    department_id integer NOT NULL,
    creationdate timestamp without time zone DEFAULT now() NOT NULL,
    lastedit timestamp without time zone DEFAULT now() NOT NULL,
    isdeleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public.reprocessinghistoryitem_has_department OWNER TO postgres;

--
-- Name: reprocessinghistoryitem_has_department_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reprocessinghistoryitem_has_department_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reprocessinghistoryitem_has_department_id_seq OWNER TO postgres;

--
-- Name: reprocessinghistoryitem_has_department_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reprocessinghistoryitem_has_department_id_seq OWNED BY public.reprocessinghistoryitem_has_department.id;


--
-- Name: reprocessinghistoryitem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reprocessinghistoryitem_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reprocessinghistoryitem_id_seq OWNER TO postgres;

--
-- Name: reprocessinghistoryitem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reprocessinghistoryitem_id_seq OWNED BY public.reprocessinghistoryitem.id;


--
-- Name: reprocessinghistoryitem_profi_idprofile_reprocessinghistory_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reprocessinghistoryitem_profi_idprofile_reprocessinghistory_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reprocessinghistoryitem_profi_idprofile_reprocessinghistory_seq OWNER TO postgres;

--
-- Name: reprocessinghistoryitem_profi_idprofile_reprocessinghistory_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reprocessinghistoryitem_profi_idprofile_reprocessinghistory_seq OWNED BY public.reprocessinghistoryitem_profil.idprofile_reprocessinghistoryitem;


--
-- Name: reprocessinghistoryitemeventtype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reprocessinghistoryitemeventtype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reprocessinghistoryitemeventtype_id_seq OWNER TO postgres;

--
-- Name: reprocessinghistoryitemeventtype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reprocessinghistoryitemeventtype_id_seq OWNED BY public.reprocessinghistoryitemeventtype.id;


--
-- Name: reprocessinginstruction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reprocessinginstruction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reprocessinginstruction_id_seq OWNER TO postgres;

--
-- Name: reprocessinginstruction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reprocessinginstruction_id_seq OWNED BY public.reprocessinginstruction.id;


--
-- Name: reprocessingstation_has_attachment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reprocessingstation_has_attachment (
    id integer NOT NULL,
    attachment_id integer NOT NULL,
    reprocessingstation_id integer CONSTRAINT reprocessingstation_has_attachm_reprocessingstation_id_not_null NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL
);


ALTER TABLE public.reprocessingstation_has_attachment OWNER TO postgres;

--
-- Name: reprocessingstation_has_attachment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reprocessingstation_has_attachment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reprocessingstation_has_attachment_id_seq OWNER TO postgres;

--
-- Name: reprocessingstation_has_attachment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reprocessingstation_has_attachment_id_seq OWNED BY public.reprocessingstation_has_attachment.id;


--
-- Name: reprocessingstation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reprocessingstation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reprocessingstation_id_seq OWNER TO postgres;

--
-- Name: reprocessingstation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reprocessingstation_id_seq OWNED BY public.reprocessingstation.id;


--
-- Name: reprocessingstatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reprocessingstatus (
    id integer NOT NULL,
    reprocessingstate character varying,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean,
    isdisabled boolean
);


ALTER TABLE public.reprocessingstatus OWNER TO postgres;

--
-- Name: reprocessingstatus_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reprocessingstatus_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reprocessingstatus_id_seq OWNER TO postgres;

--
-- Name: reprocessingstatus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reprocessingstatus_id_seq OWNED BY public.reprocessingstatus.id;


--
-- Name: setting_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.setting_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.setting_id_seq OWNER TO postgres;

--
-- Name: setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.setting_id_seq OWNED BY public.setting.id;


--
-- Name: synchronizestatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.synchronizestatus (
    id integer NOT NULL,
    synchronizestate character varying,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL,
    isdisabled boolean NOT NULL
);


ALTER TABLE public.synchronizestatus OWNER TO postgres;

--
-- Name: synchronizestatus_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.synchronizestatus_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.synchronizestatus_id_seq OWNER TO postgres;

--
-- Name: synchronizestatus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.synchronizestatus_id_seq OWNED BY public.synchronizestatus.id;


--
-- Name: task; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task (
    id integer NOT NULL,
    name character varying,
    description text,
    istaskbytimeenabled boolean NOT NULL,
    tasktimevalue integer NOT NULL,
    tasktimenotifyatvalue integer NOT NULL,
    istaskbyusagecounter boolean NOT NULL,
    taskmaximumcount integer NOT NULL,
    tasknotifyatcount integer NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL,
    isdisabled boolean NOT NULL
);


ALTER TABLE public.task OWNER TO postgres;

--
-- Name: task_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.task_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.task_id_seq OWNER TO postgres;

--
-- Name: task_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.task_id_seq OWNED BY public.task.id;


--
-- Name: thirdparty_protocol_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.thirdparty_protocol_view AS
 SELECT rep.id,
    rep.endtime AS finished_at,
    rep.starttime AS started_at,
    reprocessinghistoryitemeventtype.typename AS description,
    rep.success AS is_successful,
    rep.reprocessingdevice_id,
    concat_ws(', '::text, NULLIF((manufacturer.name)::text, ''::text), NULLIF((endoscopetype.typename)::text, ''::text), NULLIF((endoscope.serialnumber)::text, ''::text), NULLIF((endoscope.internalid)::text, ''::text)) AS endoscope_display_name,
    endoscope.id AS endoscope_id,
    endperson.firstname AS finished_by_user_firstname,
    endperson.middlename AS finished_by_user_middlename,
    endperson.lastname AS finished_by_user_lastname,
    enduser.ldapobjectguid AS finished_by_user_ldap,
    enduser.id AS finished_by_user_id,
    startperson.firstname AS started_by_user_firstname,
    startperson.middlename AS started_by_user_middlename,
    startperson.lastname AS started_by_user_lastname,
    startuser.ldapobjectguid AS started_by_user_ldap,
    startuser.id AS started_by_user_id,
    (EXISTS ( SELECT 1
           FROM public.reprocessinghistoryitem_profil prof
          WHERE ((prof.reprocessinghistoryitem_id = rep.id) AND (prof.isdeleted = false) AND (prof.profil_id = 1)))) AS is_drying,
    (EXISTS ( SELECT 1
           FROM public.reprocessinghistoryitem_profil prof
          WHERE ((prof.reprocessinghistoryitem_id = rep.id) AND (prof.isdeleted = false) AND (prof.profil_id = 2)))) AS is_disinfection,
    (EXISTS ( SELECT 1
           FROM public.reprocessinghistoryitem_profil prof
          WHERE ((prof.reprocessinghistoryitem_id = rep.id) AND (prof.isdeleted = false) AND (prof.profil_id = 3)))) AS is_custom,
    (EXISTS ( SELECT 1
           FROM public.reprocessinghistoryitem_profil prof
          WHERE ((prof.reprocessinghistoryitem_id = rep.id) AND (prof.isdeleted = false) AND (prof.profil_id = 4)))) AS is_release,
    (EXISTS ( SELECT 1
           FROM public.reprocessinghistoryitem_profil prof
          WHERE ((prof.reprocessinghistoryitem_id = rep.id) AND (prof.isdeleted = false) AND (prof.profil_id = 5)))) AS is_precleaning,
    (EXISTS ( SELECT 1
           FROM public.reprocessinghistoryitem_profil prof
          WHERE ((prof.reprocessinghistoryitem_id = rep.id) AND (prof.isdeleted = false) AND (prof.profil_id = 6)))) AS is_leakagetest,
    (EXISTS ( SELECT 1
           FROM public.reprocessinghistoryitem_profil prof
          WHERE ((prof.reprocessinghistoryitem_id = rep.id) AND (prof.isdeleted = false) AND (prof.profil_id = 7)))) AS is_manualcleaning,
    (EXISTS ( SELECT 1
           FROM public.reprocessinghistoryitem_profil prof
          WHERE ((prof.reprocessinghistoryitem_id = rep.id) AND (prof.isdeleted = false) AND (prof.profil_id = 8)))) AS is_sterilization,
    (EXISTS ( SELECT 1
           FROM public.reprocessinghistoryitem_profil prof
          WHERE ((prof.reprocessinghistoryitem_id = rep.id) AND (prof.isdeleted = false) AND (prof.profil_id = 9)))) AS is_storage,
        CASE
            WHEN (NOT (EXISTS ( SELECT 1
               FROM public.etd5reprocessingprotocol etd5prot
              WHERE (etd5prot.reprocessinghistoryitem_id = rep.id)))) THEN NULL::boolean
            WHEN (EXISTS ( SELECT 1
               FROM public.etd5reprocessingprotocol etd5prot
              WHERE ((etd5prot.reprocessinghistoryitem_id = rep.id) AND (etd5prot.programprofile = 0)))) THEN true
            ELSE false
        END AS is_selfdisinfection,
        CASE
            WHEN (minfo.etd5maschinevariant_id IS NOT NULL) THEN
            CASE
                WHEN starts_with((mvar.name)::text, 'BASIC'::text) THEN concat_ws(', '::text, 'ETD Basic', NULLIF((device.name)::text, ''::text), NULLIF((device.serialnumber)::text, ''::text))
                ELSE concat_ws(', '::text, 'ETD Premium', NULLIF((device.name)::text, ''::text), NULLIF((device.serialnumber)::text, ''::text))
            END
            ELSE concat_ws(', '::text, NULLIF((devicetype.typename)::text, ''::text), NULLIF((device.name)::text, ''::text), NULLIF((device.serialnumber)::text, ''::text))
        END AS reprocessing_device_display_name,
    rep.lastedit,
    concat_ws(''::text, ( SELECT etddoublereprocessingprotocol.programname
           FROM public.etddoublereprocessingprotocol
          WHERE (etddoublereprocessingprotocol.reprocessinghistoryitem_id = rep.id)
          ORDER BY etddoublereprocessingprotocol.id DESC
         LIMIT 1), ( SELECT etdv3reprocessingprotocol.protocolprogramname
           FROM public.etdv3reprocessingprotocol
          WHERE (etdv3reprocessingprotocol.reprocessinghistoryitem_id = rep.id)
          ORDER BY etdv3reprocessingprotocol.id DESC
         LIMIT 1), ( SELECT etdminireprocessingprotocol.cyclename
           FROM public.etdminireprocessingprotocol
          WHERE (etdminireprocessingprotocol.reprocessinghistoryitem_id = rep.id)
          ORDER BY etdminireprocessingprotocol.id DESC
         LIMIT 1), ( SELECT etd5reprocessingprotocol.programname
           FROM public.etd5reprocessingprotocol
          WHERE (etd5reprocessingprotocol.reprocessinghistoryitem_id = rep.id)
          ORDER BY etd5reprocessingprotocol.id DESC
         LIMIT 1)) AS programname,
    concat_ws(''::text, ( SELECT etddoublereprocessingprotocol.errornumber
           FROM public.etddoublereprocessingprotocol
          WHERE (etddoublereprocessingprotocol.reprocessinghistoryitem_id = rep.id)
          ORDER BY etddoublereprocessingprotocol.id DESC
         LIMIT 1), ( SELECT etdv3reprocessingprotocol.protocolresultcode
           FROM public.etdv3reprocessingprotocol
          WHERE (etdv3reprocessingprotocol.reprocessinghistoryitem_id = rep.id)
          ORDER BY etdv3reprocessingprotocol.id DESC
         LIMIT 1), ( SELECT edcreprocessingprotocol.result
           FROM public.edcreprocessingprotocol
          WHERE (edcreprocessingprotocol.reprocessinghistoryitem_id = rep.id)
          ORDER BY edcreprocessingprotocol.id DESC
         LIMIT 1), ( SELECT etdminireprocessingprotocol.cycleresultcode
           FROM public.etdminireprocessingprotocol
          WHERE (etdminireprocessingprotocol.reprocessinghistoryitem_id = rep.id)
          ORDER BY etdminireprocessingprotocol.id DESC
         LIMIT 1), ( SELECT etd5reprocessingprotocol.resultcode
           FROM public.etd5reprocessingprotocol
          WHERE (etd5reprocessingprotocol.reprocessinghistoryitem_id = rep.id)
          ORDER BY etd5reprocessingprotocol.id DESC
         LIMIT 1)) AS resultcode
   FROM (((((((((((((public.reprocessinghistoryitem rep
     LEFT JOIN public.reprocessinghistoryitemeventtype ON ((reprocessinghistoryitemeventtype.id = rep.reprocessinghistoryitemeventtype_id)))
     LEFT JOIN public.useraccount enduser ON ((enduser.id = rep.enduseraccount_id)))
     LEFT JOIN private.p_person endperson ON ((endperson.useraccount_id = enduser.id)))
     LEFT JOIN public.useraccount startuser ON ((startuser.id = rep.startuseraccount_id)))
     LEFT JOIN private.p_person startperson ON ((startperson.useraccount_id = startuser.id)))
     LEFT JOIN public.endoscope_has_reprocessighistoryitems ehri ON (((ehri.reprocessinghistoryitem_id = rep.id) AND (ehri.isdeleted = false))))
     LEFT JOIN public.endoscope ON ((endoscope.id = ehri.endoscope_id)))
     LEFT JOIN public.endoscopetype ON ((endoscopetype.id = endoscope.endoscopetype_id)))
     LEFT JOIN public.etd5machineinfo minfo ON ((minfo.reprocessingdevice_id = rep.reprocessingdevice_id)))
     LEFT JOIN public.etd5maschinevariant mvar ON ((mvar.id = minfo.etd5maschinevariant_id)))
     LEFT JOIN public.manufacturer ON ((manufacturer.id = endoscopetype.manufacturer_id)))
     LEFT JOIN public.reprocessingdevice device ON ((device.id = rep.reprocessingdevice_id)))
     LEFT JOIN public.reprocessingdevicetype devicetype ON ((devicetype.id = device.reprocessingdevicetype_id)));


ALTER VIEW public.thirdparty_protocol_view OWNER TO postgres;

--
-- Name: user_has_department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_has_department (
    id integer NOT NULL,
    useraccount_id integer NOT NULL,
    department_id integer NOT NULL,
    startdate timestamp without time zone,
    enddate timestamp without time zone,
    creationdate timestamp without time zone NOT NULL,
    lastedit timestamp without time zone NOT NULL,
    isdeleted boolean NOT NULL
);


ALTER TABLE public.user_has_department OWNER TO postgres;

--
-- Name: user_has_department_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_has_department_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_has_department_id_seq OWNER TO postgres;

--
-- Name: user_has_department_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_has_department_id_seq OWNED BY public.user_has_department.id;


--
-- Name: user_has_identifier; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_has_identifier (
    id integer NOT NULL,
    useraccount_id integer NOT NULL,
    identifier_id integer NOT NULL,
    startdate timestamp without time zone,
    enddate timestamp without time zone,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean NOT NULL
);


ALTER TABLE public.user_has_identifier OWNER TO postgres;

--
-- Name: user_has_identifier_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_has_identifier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_has_identifier_id_seq OWNER TO postgres;

--
-- Name: user_has_identifier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_has_identifier_id_seq OWNED BY public.user_has_identifier.id;


--
-- Name: useraccount_has_userdevicelevelgroup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.useraccount_has_userdevicelevelgroup (
    id integer NOT NULL,
    useraccount_id integer NOT NULL,
    userdevicelevelgroup_id integer CONSTRAINT useraccount_has_userdeviceleve_userdevicelevelgroup_id_not_null NOT NULL,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean NOT NULL
);


ALTER TABLE public.useraccount_has_userdevicelevelgroup OWNER TO postgres;

--
-- Name: useraccount_has_userdevicelevelgroup_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.useraccount_has_userdevicelevelgroup_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.useraccount_has_userdevicelevelgroup_id_seq OWNER TO postgres;

--
-- Name: useraccount_has_userdevicelevelgroup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.useraccount_has_userdevicelevelgroup_id_seq OWNED BY public.useraccount_has_userdevicelevelgroup.id;


--
-- Name: useraccount_has_usergroup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.useraccount_has_usergroup (
    id integer NOT NULL,
    useraccount_id integer NOT NULL,
    usergroup_id integer NOT NULL,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean NOT NULL
);


ALTER TABLE public.useraccount_has_usergroup OWNER TO postgres;

--
-- Name: useraccount_has_usergroup_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.useraccount_has_usergroup_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.useraccount_has_usergroup_id_seq OWNER TO postgres;

--
-- Name: useraccount_has_usergroup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.useraccount_has_usergroup_id_seq OWNED BY public.useraccount_has_usergroup.id;


--
-- Name: useraccount_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.useraccount_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.useraccount_id_seq OWNER TO postgres;

--
-- Name: useraccount_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.useraccount_id_seq OWNED BY public.useraccount.id;


--
-- Name: userdevicelevelgroup_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.userdevicelevelgroup_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.userdevicelevelgroup_id_seq OWNER TO postgres;

--
-- Name: userdevicelevelgroup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.userdevicelevelgroup_id_seq OWNED BY public.userdevicelevelgroup.id;


--
-- Name: usergroup_has_userrole; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usergroup_has_userrole (
    id integer NOT NULL,
    usergroup_id integer NOT NULL,
    userrole_id integer NOT NULL,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean NOT NULL
);


ALTER TABLE public.usergroup_has_userrole OWNER TO postgres;

--
-- Name: usergroup_has_userrole_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usergroup_has_userrole_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usergroup_has_userrole_id_seq OWNER TO postgres;

--
-- Name: usergroup_has_userrole_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usergroup_has_userrole_id_seq OWNED BY public.usergroup_has_userrole.id;


--
-- Name: usergroup_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usergroup_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usergroup_id_seq OWNER TO postgres;

--
-- Name: usergroup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usergroup_id_seq OWNED BY public.usergroup.id;


--
-- Name: userrole; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.userrole (
    id integer NOT NULL,
    name character varying,
    creationdate timestamp without time zone,
    lastedit timestamp without time zone,
    isdeleted boolean NOT NULL
);


ALTER TABLE public.userrole OWNER TO postgres;

--
-- Name: userrole_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.userrole_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.userrole_id_seq OWNER TO postgres;

--
-- Name: userrole_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.userrole_id_seq OWNED BY public.userrole.id;


--
-- Name: v2_0_cycles; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v2_0_cycles AS
 SELECT cycle.id AS cycle_id,
    cycle.endoscope_id,
    reprocessinginstruction.name AS reprocessing_instruction_name,
    reprocessinginstruction.description AS reprocessing_instruction_description,
    date_trunc('seconds'::text, cycle.reprocessingstart) AS reprocessing_start,
    date_trunc('seconds'::text, cycle.reprocessingend) AS reprocessing_end,
    (date_trunc('minute'::text, cycle.reprocessingend) - date_trunc('minute'::text, cycle.reprocessingstart)) AS reprocessing_duration,
    cycle.ispending AS is_cycle_pending,
    cyclestate.name AS cycle_state,
    cyclefinishedreason.name AS cycle_end_reason
   FROM (((public.cycle
     LEFT JOIN public.reprocessinginstruction ON ((cycle.reprocessinginstruction_id = reprocessinginstruction.id)))
     JOIN public.cyclestate ON ((cycle.cyclestate_id = cyclestate.id)))
     LEFT JOIN public.cyclefinishedreason ON ((cycle.cyclefinishedreason_id = cyclefinishedreason.id)));


ALTER VIEW public.v2_0_cycles OWNER TO postgres;

--
-- Name: v2_0_department; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v2_0_department AS
 SELECT id,
    departmentname AS department_name
   FROM public.department dep
  WHERE (isdeleted = false);


ALTER VIEW public.v2_0_department OWNER TO postgres;

--
-- Name: v2_0_department_devices; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v2_0_department_devices AS
 SELECT reprocessingdevice_id,
    department_id,
    startdate AS start_date,
    enddate AS end_date
   FROM public.reprocessingdevice_has_department rep_dep;


ALTER VIEW public.v2_0_department_devices OWNER TO postgres;

--
-- Name: v2_0_department_endoscopes; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v2_0_department_endoscopes AS
 SELECT endoscope_id,
    department_id,
    startdate AS start_date,
    enddate AS end_date
   FROM public.endoscope_has_department end_dep;


ALTER VIEW public.v2_0_department_endoscopes OWNER TO postgres;

--
-- Name: v2_0_dosagevalues; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v2_0_dosagevalues AS
 SELECT reprocessinghistoryitem.id AS reprocessinghistoryitem_id,
    date_trunc('second'::text, reprocessinghistoryitem.creationdate) AS creation_date,
    device.id AS reprocessingdevice_id,
        CASE
            WHEN (etdmini.programmedwaterquantityselection1 IS NOT NULL) THEN etdmini.programmedwaterquantityselection1
            ELSE NULL::integer
        END AS waterdosage1_set,
        CASE
            WHEN (etdmini.executedwaterquantitydosingselection1 IS NOT NULL) THEN etdmini.executedwaterquantitydosingselection1
            ELSE NULL::integer
        END AS waterdosage1_actual,
        CASE
            WHEN (etdmini.programmedwaterquantityselection2 IS NOT NULL) THEN etdmini.programmedwaterquantityselection2
            ELSE NULL::integer
        END AS waterdosage2_set,
        CASE
            WHEN (etdmini.executedwaterquantitydosingselection2 IS NOT NULL) THEN etdmini.executedwaterquantitydosingselection2
            ELSE NULL::integer
        END AS waterdosage2_actual,
        CASE
            WHEN (etdmini.chemcicalproducttypeselection1 IS NOT NULL) THEN etdmini.chemcicalproducttypeselection1
            ELSE NULL::integer
        END AS producttype1,
        CASE
            WHEN (etdmini.programmedproductquantityselection1 IS NOT NULL) THEN etdmini.programmedproductquantityselection1
            ELSE NULL::integer
        END AS productdosage1_set,
        CASE
            WHEN (etdmini.executedproductquantitydosingselection1 IS NOT NULL) THEN etdmini.executedproductquantitydosingselection1
            ELSE NULL::integer
        END AS productdosage1_actual,
        CASE
            WHEN (etdmini.chemcicalproducttypeselection2 IS NOT NULL) THEN etdmini.chemcicalproducttypeselection2
            ELSE NULL::integer
        END AS producttype2,
        CASE
            WHEN (etdmini.programmedproductquantityselection2 IS NOT NULL) THEN etdmini.programmedproductquantityselection2
            ELSE NULL::integer
        END AS productdosage2_set,
        CASE
            WHEN (etdmini.executedproductquantitydosingselection2 IS NOT NULL) THEN etdmini.executedproductquantitydosingselection2
            ELSE NULL::integer
        END AS productdosage12_actual
   FROM ((public.reprocessinghistoryitem
     JOIN public.reprocessingdevice device ON ((device.id = reprocessinghistoryitem.reprocessingdevice_id)))
     LEFT JOIN public.etdminiprocessdata etdmini ON ((etdmini.reprocessinghistoryitem_id = reprocessinghistoryitem.id)))
  WHERE ((reprocessinghistoryitem.reprocessinghistoryitemeventtype_id = 2) AND (device.reprocessingdevicetype_id = 17));


ALTER VIEW public.v2_0_dosagevalues OWNER TO postgres;

--
-- Name: v2_0_endoscope_reprocessings; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v2_0_endoscope_reprocessings AS
 SELECT reprocessinghistoryitem.id AS reprocessinghistoryitem_id,
    endoscope.id AS endoscope_id,
    endoscope_has_reprocessighistoryitems.level AS loading_position
   FROM ((public.reprocessinghistoryitem
     JOIN public.endoscope_has_reprocessighistoryitems ON ((endoscope_has_reprocessighistoryitems.reprocessinghistoryitem_id = reprocessinghistoryitem.id)))
     JOIN public.endoscope ON ((endoscope.id = endoscope_has_reprocessighistoryitems.endoscope_id)));


ALTER VIEW public.v2_0_endoscope_reprocessings OWNER TO postgres;

--
-- Name: v2_0_endoscopes; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v2_0_endoscopes AS
 SELECT endoscope.id AS endoscope_id,
    endoscope.serialnumber AS serial_number,
    endoscope.isloanerdevice AS is_loanerdevice,
    endoscope.purchaseddate AS purchase_date,
    endoscope.retiredate AS retire_date,
    endoscope.customdescription AS custom_description,
    date_trunc('second'::text, endoscope.creationdate) AS creation_date,
    date_trunc('second'::text, endoscope.lastedit) AS lastedit_date,
    endoscope.isdisabled AS is_disabled,
    endoscope.isdeleted AS is_deleted,
    endoscope.isquarantine AS is_quarantine,
    endoscopetype.id AS endoscopetype_id,
    endoscopetype.typename AS endoscope_type,
    endoscopetype.articlenumber AS article_number,
    endoscopetype.numberofchannels AS number_of_channels,
    endoscopetype.hasalbaranchannel AS has_albaran_channel,
    manufacturer.id AS manufacturer_id,
    manufacturer.name AS manufacturer
   FROM ((public.endoscope
     LEFT JOIN public.endoscopetype ON ((endoscopetype.id = endoscope.endoscopetype_id)))
     LEFT JOIN public.manufacturer ON ((endoscopetype.manufacturer_id = manufacturer.id)));


ALTER VIEW public.v2_0_endoscopes OWNER TO postgres;

--
-- Name: v2_0_flow_statistics; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v2_0_flow_statistics AS
 SELECT fl.id AS flowstatistic_id,
    flow_batch.id AS flow_batch_id,
    flow_batch.reprocessingdevice_id,
    fl.type,
    fl.nr,
    fl."timestamp",
    fl.sn_endoid,
    fl.sn_profitronic,
    fl.endoscopetype AS endoscope_type,
    fl.endoscope_sn,
    fl.endoscope_referencetype,
    fl.min_1,
    fl.max_1,
    fl.flow_1,
    fl.min_2,
    fl.max_2,
    fl.flow_2,
    fl.min_3,
    fl.max_3,
    fl.flow_3,
    fl.total_flow,
    fl.albaran_channel,
    fl."position",
    fl.program,
    fl.temperature AS temperature_c
   FROM (public.flow_statistics fl
     JOIN public.flow_batch ON ((flow_batch.id = fl.flow_batch_id)));


ALTER VIEW public.v2_0_flow_statistics OWNER TO postgres;

--
-- Name: v2_0_protocol_errorinformation; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v2_0_protocol_errorinformation AS
 SELECT rep.id AS reprocessinghistoryitem_id,
        CASE
            WHEN (etddoubleerror.errornumber IS NOT NULL) THEN etddoubleerror.errornumber
            WHEN (edc.result IS NOT NULL) THEN edc.result
            WHEN (etdminiprocess.phaseinterruptalarmcode IS NOT NULL) THEN etdminiprocess.phaseinterruptalarmcode
            ELSE NULL::integer
        END AS protocol_result_code,
        CASE
            WHEN (etddoubleerror.errordescription IS NOT NULL) THEN etddoubleerror.errordescription
            WHEN (etdminiprocess.phaseinterruptdescription IS NOT NULL) THEN etdminiprocess.phaseinterruptdescription
            ELSE NULL::character varying
        END AS protocol_result_code_meaning,
        CASE
            WHEN (etddoubleerror.blocknumber IS NOT NULL) THEN (etddoubleerror.blocknumber)::character varying
            WHEN (etdminiprocess.phasename IS NOT NULL) THEN etdminiprocess.phasename
            ELSE NULL::character varying
        END AS program_step,
        CASE
            WHEN (etddoubleerror.stepnumber IS NOT NULL) THEN (etddoubleerror.stepnumber)::character varying
            ELSE NULL::character varying
        END AS step_number
   FROM ((((public.reprocessinghistoryitem rep
     JOIN public.reprocessingdevice device ON ((device.id = rep.reprocessingdevice_id)))
     LEFT JOIN public.etddoubleerrorprotocol etddoubleerror ON ((etddoubleerror.reprocessinghistoryitem_id = rep.id)))
     LEFT JOIN public.etdminiprocessdata etdminiprocess ON ((etdminiprocess.reprocessinghistoryitem_id = rep.id)))
     LEFT JOIN public.edcreprocessingprotocol edc ON ((edc.reprocessinghistoryitem_id = rep.id)))
  WHERE ((rep.endtime IS NOT NULL) AND (rep.success = false) AND (rep.reprocessinghistoryitemeventtype_id = 2) AND (((device.reprocessingdevicetype_id = 5) AND (etddoubleerror.* IS NOT NULL)) OR ((device.reprocessingdevicetype_id = 17) AND ((etdminiprocess.phaseinterruptdescription)::text <> ''::text)) OR (((device.reprocessingdevicetype_id = 3) OR (device.reprocessingdevicetype_id = 4)) AND (edc.result IS NOT NULL))));


ALTER VIEW public.v2_0_protocol_errorinformation OWNER TO postgres;

--
-- Name: v2_0_protocols; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v2_0_protocols AS
 SELECT rep.id AS reprocessinghistoryitem_id,
    date_trunc('seconds'::text, rep.starttime) AS protocol_start_date,
    date_trunc('seconds'::text, rep.endtime) AS protocol_end_date,
    rep.success AS is_success,
    reprocessinghistoryitemeventtype.typename AS event_type,
    reprocessingdevice.id AS reprocessingdevice_id,
    rep.batch_id,
    batch.devicebatchid AS device_batch_id,
        CASE
            WHEN (( SELECT etddoublereprocessingprotocol.id
               FROM public.etddoublereprocessingprotocol
              WHERE (etddoublereprocessingprotocol.reprocessinghistoryitem_id = rep.id)
             LIMIT 1) IS NOT NULL) THEN ( SELECT etddoublereprocessingprotocol.errornumber
               FROM public.etddoublereprocessingprotocol
              WHERE (etddoublereprocessingprotocol.reprocessinghistoryitem_id = rep.id)
              ORDER BY etddoublereprocessingprotocol.id DESC
             LIMIT 1)
            WHEN (( SELECT edcreprocessingprotocol.id
               FROM public.edcreprocessingprotocol
              WHERE (edcreprocessingprotocol.reprocessinghistoryitem_id = rep.id)
             LIMIT 1) IS NOT NULL) THEN (( SELECT (edcreprocessingprotocol.result)::text AS result
               FROM public.edcreprocessingprotocol
              WHERE (edcreprocessingprotocol.reprocessinghistoryitem_id = rep.id)
              ORDER BY edcreprocessingprotocol.id DESC
             LIMIT 1))::character varying
            WHEN (( SELECT etdminireprocessingprotocol.id
               FROM public.etdminireprocessingprotocol
              WHERE (etdminireprocessingprotocol.reprocessinghistoryitem_id = rep.id)
             LIMIT 1) IS NOT NULL) THEN ( SELECT etdminireprocessingprotocol.cycleresultcode
               FROM public.etdminireprocessingprotocol
              WHERE (etdminireprocessingprotocol.reprocessinghistoryitem_id = rep.id)
              ORDER BY etdminireprocessingprotocol.id DESC
             LIMIT 1)
            ELSE NULL::character varying
        END AS protocol_result_code,
        CASE
            WHEN (( SELECT etddoublereprocessingprotocol.id
               FROM public.etddoublereprocessingprotocol
              WHERE (etddoublereprocessingprotocol.reprocessinghistoryitem_id = rep.id)
              ORDER BY etddoublereprocessingprotocol.id DESC
             LIMIT 1) IS NOT NULL) THEN ( SELECT etddoublereprocessingprotocol.programname
               FROM public.etddoublereprocessingprotocol
              WHERE (etddoublereprocessingprotocol.reprocessinghistoryitem_id = rep.id)
              ORDER BY etddoublereprocessingprotocol.id DESC
             LIMIT 1)
            WHEN (( SELECT etdv3reprocessingprotocol.id
               FROM public.etdv3reprocessingprotocol
              WHERE (etdv3reprocessingprotocol.reprocessinghistoryitem_id = rep.id)
              ORDER BY etdv3reprocessingprotocol.id DESC
             LIMIT 1) IS NOT NULL) THEN ( SELECT etdv3reprocessingprotocol.protocolprogramname
               FROM public.etdv3reprocessingprotocol
              WHERE (etdv3reprocessingprotocol.reprocessinghistoryitem_id = rep.id)
              ORDER BY etdv3reprocessingprotocol.id DESC
             LIMIT 1)
            WHEN (( SELECT etdminireprocessingprotocol.id
               FROM public.etdminireprocessingprotocol
              WHERE (etdminireprocessingprotocol.reprocessinghistoryitem_id = rep.id)
              ORDER BY etdminireprocessingprotocol.id DESC
             LIMIT 1) IS NOT NULL) THEN ( SELECT etdminireprocessingprotocol.cyclename
               FROM public.etdminireprocessingprotocol
              WHERE (etdminireprocessingprotocol.reprocessinghistoryitem_id = rep.id)
              ORDER BY etdminireprocessingprotocol.id DESC
             LIMIT 1)
            ELSE ''::character varying
        END AS protocol_program_name,
        CASE
            WHEN (( SELECT etddoublereprocessingprotocol.id
               FROM public.etddoublereprocessingprotocol
              WHERE ((etddoublereprocessingprotocol.reprocessinghistoryitem_id = rep.id) AND (((etddoublereprocessingprotocol.errornumber)::text = '3368'::text) OR ((etddoublereprocessingprotocol.errornumber)::text = '3221'::text)))
              ORDER BY etddoublereprocessingprotocol.id DESC
             LIMIT 1) IS NOT NULL) THEN true
            WHEN (( SELECT etdminiprocessdata.id
               FROM public.etdminiprocessdata
              WHERE ((etdminiprocessdata.reprocessinghistoryitem_id = rep.id) AND (etdminiprocessdata.etdminicyclephaseinterrupttype_id = 5))
              ORDER BY etdminiprocessdata.id DESC
             LIMIT 1) IS NOT NULL) THEN true
            ELSE false
        END AS is_canceled_by_user
   FROM ((((public.reprocessinghistoryitem rep
     JOIN public.reprocessinghistoryitemeventtype ON ((reprocessinghistoryitemeventtype.id = rep.reprocessinghistoryitemeventtype_id)))
     LEFT JOIN public.reprocessingdevice ON ((reprocessingdevice.id = rep.reprocessingdevice_id)))
     LEFT JOIN public.reprocessingdevicetype ON ((reprocessingdevicetype.id = reprocessingdevice.reprocessingdevicetype_id)))
     LEFT JOIN public.batch ON ((batch.id = rep.batch_id)))
  WHERE (rep.endtime IS NOT NULL);


ALTER VIEW public.v2_0_protocols OWNER TO postgres;

--
-- Name: v2_0_reprocessingdevices; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v2_0_reprocessingdevices AS
 SELECT rep.id AS reprocessingdevice_id,
    reprocessingdevicetype.id AS reprocessingdevicetype_id,
    rep.serialnumber AS serial_number,
    rep.location,
    rep.name,
    date_trunc('second'::text, rep.creationdate) AS creation_date,
    date_trunc('second'::text, rep.lastedit) AS lastedit_date,
    date_trunc('second'::text, (rep.purchaseddate)::timestamp with time zone) AS purchase_date,
    date_trunc('second'::text, (rep.retiredate)::timestamp with time zone) AS retire_date,
    rep.isdeleted AS is_deleted,
    rep.isdisabled AS is_disabled,
    rep.isquarantine AS is_quarantine,
    rep.firmwareversion AS firmware_version,
    reprocessingdevicetype.typename AS reprocessingdevice_type,
    reprocessingdevicetype.maximunload AS maximum_load,
    connectionstatus.connectionstate AS connection_state,
    reprocessingstatus.reprocessingstate AS reprocessing_state
   FROM ((((public.reprocessingdevice rep
     LEFT JOIN public.reprocessingdevicetype ON ((rep.reprocessingdevicetype_id = reprocessingdevicetype.id)))
     LEFT JOIN public.currentdata ON ((rep.id = currentdata.reprocessingdevice_id)))
     JOIN public.connectionstatus ON ((currentdata.connectionstatus_id = connectionstatus.id)))
     JOIN public.reprocessingstatus ON ((currentdata.reprocessingstatus_id = reprocessingstatus.id)));


ALTER VIEW public.v2_0_reprocessingdevices OWNER TO postgres;

--
-- Name: v2_0_reprocessingstation_info; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v2_0_reprocessingstation_info AS
 SELECT cyclestationinfo.cycle_id,
    profil.id AS profil_id,
    profil.name AS profil_name,
    reprocessingstation.sequencenumber AS sequence_number,
    cyclestep.starttime AS start_time,
    cyclestep.endtime,
        CASE
            WHEN (lag(cyclestationinfo.cycle_id, '-1'::integer) OVER (ORDER BY cyclestationinfo.id) = cyclestationinfo.cycle_id) THEN (lag(cyclestep.starttime, '-1'::integer) OVER (ORDER BY cyclestationinfo.id) - cyclestep.endtime)
            ELSE NULL::interval
        END AS timediff_to_next_ste
   FROM (((public.cyclestationinfo
     JOIN public.reprocessingstation ON ((cyclestationinfo.reprocessingstation_id = reprocessingstation.id)))
     JOIN public.cyclestep ON ((cyclestationinfo.cyclestep_id = cyclestep.id)))
     JOIN public.profil ON ((reprocessingstation.profil_id = profil.id)))
  WHERE (cyclestationinfo.cyclestationstate_id = 4)
  ORDER BY cyclestationinfo.id;


ALTER VIEW public.v2_0_reprocessingstation_info OWNER TO postgres;

--
-- Name: v2_0_sensorvalues; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v2_0_sensorvalues AS
 SELECT reprocessinghistoryitem.id AS reprocessinghistoryitem_id,
    date_trunc('second'::text, reprocessinghistoryitem.creationdate) AS creation_date,
    device.id AS reprocessingdevice_id,
        CASE
            WHEN (etdddata.watertemperature IS NOT NULL) THEN ((etdddata.watertemperature)::double precision / (100)::double precision)
            WHEN (etdbasic.watertemperature IS NOT NULL) THEN ((etdbasic.watertemperature)::double precision / (10)::double precision)
            WHEN (etdmini.tanktemperature1 IS NOT NULL) THEN ((etdmini.tanktemperature1)::double precision * (10)::double precision)
            ELSE NULL::double precision
        END AS water_temperature1_c,
        CASE
            WHEN (etdmini.tanktemperature2 IS NOT NULL) THEN ((etdmini.tanktemperature2)::double precision * (10)::double precision)
            ELSE NULL::double precision
        END AS water_temperature2_c,
        CASE
            WHEN (etdddata.airtemperature IS NOT NULL) THEN ((etdddata.airtemperature)::double precision / (100)::double precision)
            WHEN (etdbasic.airtemperature IS NOT NULL) THEN ((etdbasic.airtemperature)::double precision / (10)::double precision)
            ELSE NULL::double precision
        END AS air_temperature_c,
        CASE
            WHEN (etdddata.scavengingpressureupper IS NOT NULL) THEN etdddata.scavengingpressureupper
            WHEN (etdbasic.pressure1_mpa IS NOT NULL) THEN etdbasic.pressure1_mpa
            WHEN (etdmini.leaktestpressureinstrument1 IS NOT NULL) THEN etdmini.leaktestpressureinstrument1
            ELSE NULL::integer
        END AS pressure_1_mbar,
        CASE
            WHEN (etdddata.scavengingpressuremiddle IS NOT NULL) THEN etdddata.scavengingpressuremiddle
            WHEN (etdbasic.pressure2_mpa IS NOT NULL) THEN etdbasic.pressure2_mpa
            WHEN (etdmini.washpressurebasket IS NOT NULL) THEN etdmini.washpressurebasket
            ELSE NULL::integer
        END AS pressure_2_mbar,
        CASE
            WHEN (etdddata.scavengingpressurelower IS NOT NULL) THEN etdddata.scavengingpressurelower
            ELSE NULL::integer
        END AS pressure_lower_mbar,
        CASE
            WHEN (etdddata."timestamp" IS NOT NULL) THEN etdddata."timestamp"
            WHEN (etdbasic."timestamp" IS NOT NULL) THEN etdbasic."timestamp"
            WHEN (etdmini."timestamp" IS NOT NULL) THEN etdmini."timestamp"
            ELSE NULL::timestamp without time zone
        END AS "timestamp"
   FROM (((((public.reprocessinghistoryitem
     LEFT JOIN public.etddoubleprocessdata etdddata ON ((etdddata.reprocessinghistoryitem_id = reprocessinghistoryitem.id)))
     LEFT JOIN public.etdbasicprocessdata etdbasic ON ((etdbasic.reprocessinghistoryitem_id = reprocessinghistoryitem.id)))
     LEFT JOIN public.etdminiprobedata etdmini ON ((etdmini.reprocessinghistoryitem_id = reprocessinghistoryitem.id)))
     LEFT JOIN public.reprocessingdevice device ON ((device.id = reprocessinghistoryitem.reprocessingdevice_id)))
     LEFT JOIN public.reprocessingdevicetype ON ((reprocessingdevicetype.id = device.reprocessingdevicetype_id)))
  WHERE (reprocessinghistoryitem.reprocessinghistoryitemeventtype_id = 2);


ALTER VIEW public.v2_0_sensorvalues OWNER TO postgres;

--
-- Name: v2_1_cycles; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v2_1_cycles AS
 SELECT cycle.id AS cycle_id,
    cycle.endoscope_id,
    reprocessinginstruction.name AS reprocessing_instruction_name,
    reprocessinginstruction.description AS reprocessing_instruction_description,
    date_trunc('seconds'::text, cycle.reprocessingstart) AS reprocessing_start,
    date_trunc('seconds'::text, cycle.reprocessingend) AS reprocessing_end,
    (date_trunc('minute'::text, cycle.reprocessingend) - date_trunc('minute'::text, cycle.reprocessingstart)) AS reprocessing_duration,
    cycle.ispending AS is_cycle_pending,
    cyclestate.name AS cycle_state,
    cyclefinishedreason.name AS cycle_end_reason
   FROM (((public.cycle
     LEFT JOIN public.reprocessinginstruction ON ((cycle.reprocessinginstruction_id = reprocessinginstruction.id)))
     JOIN public.cyclestate ON ((cycle.cyclestate_id = cyclestate.id)))
     LEFT JOIN public.cyclefinishedreason ON ((cycle.cyclefinishedreason_id = cyclefinishedreason.id)));


ALTER VIEW public.v2_1_cycles OWNER TO postgres;

--
-- Name: v2_1_department; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v2_1_department AS
 SELECT id,
    departmentname AS department_name
   FROM public.department dep
  WHERE (isdeleted = false);


ALTER VIEW public.v2_1_department OWNER TO postgres;

--
-- Name: v2_1_department_devices; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v2_1_department_devices AS
 SELECT reprocessingdevice_id,
    department_id,
    startdate AS start_date,
    enddate AS end_date
   FROM public.reprocessingdevice_has_department rep_dep;


ALTER VIEW public.v2_1_department_devices OWNER TO postgres;

--
-- Name: v2_1_department_endoscopes; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v2_1_department_endoscopes AS
 SELECT endoscope_id,
    department_id,
    startdate AS start_date,
    enddate AS end_date
   FROM public.endoscope_has_department end_dep;


ALTER VIEW public.v2_1_department_endoscopes OWNER TO postgres;

--
-- Name: v2_1_dosagevalues_etd5; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v2_1_dosagevalues_etd5 AS
 SELECT protocol.reprocessinghistoryitem_id,
    dosage.etd5blockinfo_id,
    block.blockstarttime,
    block.watervalvalue,
    block.watervalrequiredmin,
    block.watervalrequiredmax,
    row_number() OVER (PARTITION BY dosage.etd5blockinfo_id ORDER BY dosage.id) AS dos_n,
    dosage.dosagevalvalue,
    dosage.dosagevalrequiredmin,
    dosage.dosagevalrequiredmax
   FROM ((public.etd5dosageinfo dosage
     JOIN public.etd5blockinfo block ON ((dosage.etd5blockinfo_id = block.id)))
     JOIN public.etd5reprocessingprotocol protocol ON ((protocol.id = block.etd5reprocessingprotocol_id)))
  ORDER BY dosage.id;


ALTER VIEW public.v2_1_dosagevalues_etd5 OWNER TO postgres;

--
-- Name: v2_1_dosagevalues_etddouble; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v2_1_dosagevalues_etddouble AS
 SELECT protocol.reprocessinghistoryitem_id,
    protocol.id AS protocol_id,
    block.id AS block_id,
    block.blockstartactual,
    block.blockname,
    (split_part(NULLIF(regexp_replace((block.waterquantintynominal)::text, '(^[^0-9]+$|Nicht zutreffend|n/a)'::text, ''::text, 'g'::text), ''::text), ' - '::text, 1))::double precision AS min_waterquantitynominal,
    (split_part(NULLIF(regexp_replace((block.waterquantintynominal)::text, '(^[^0-9]+$|Nicht zutreffend|n/a| l)'::text, ''::text, 'g'::text), ''::text), ' - '::text, 2))::double precision AS max_waterquantitynominal,
    (NULLIF(regexp_replace((block.waterquantityactual)::text, '(^[^0-9]+$|Nicht zutreffend|n/a| l)'::text, ''::text, 'g'::text), ''::text))::double precision AS waterquantityactual,
    dosage.dosingmedium,
    (split_part(NULLIF(regexp_replace((dosage.dosingquantitynominal)::text, '(^[^0-9]+$|Nicht zutreffend|n/a)'::text, ''::text, 'g'::text), ''::text), ' - '::text, 1))::double precision AS min_dosingquantitynominal,
    (split_part(NULLIF(regexp_replace((dosage.dosingquantitynominal)::text, '(^[^0-9]+$|Nicht zutreffend|n/a| ml)'::text, ''::text, 'g'::text), ''::text), ' - '::text, 2))::double precision AS max_dosingquantitynominal,
    (split_part(NULLIF(regexp_replace((dosage.dosingquantityactual)::text, '(^[^0-9]+$|Nicht zutreffend|n/a| ml)'::text, ''::text, 'g'::text), ''::text), ' - '::text, 1))::double precision AS dosingquantityactual
   FROM ((public.etddoublereprocessingprotocol protocol
     LEFT JOIN public.etddoubleblockinfo block ON ((block.etddoublereprocessingprotocol_id = protocol.id)))
     LEFT JOIN public.etddoubledosinginfo dosage ON ((dosage.etddoubleblockinfo_id = block.id)))
  ORDER BY block.id;


ALTER VIEW public.v2_1_dosagevalues_etddouble OWNER TO postgres;

--
-- Name: v2_1_dosagevalues_etdmini; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v2_1_dosagevalues_etdmini AS
 SELECT rep.id AS reprocessinghistoryitem_id,
        CASE
            WHEN (etdmini.id IS NOT NULL) THEN etdmini.id
            ELSE NULL::integer
        END AS block_id,
        CASE
            WHEN (device.reprocessingdevicetype_id = 17) THEN date_trunc('second'::text, etdmini.phaseendtime)
            ELSE NULL::timestamp without time zone
        END AS time_stamp,
    device.id AS reprocessingdevice_id,
        CASE
            WHEN ((etdmini.programmedwaterquantityselection1 IS NOT NULL) AND (etdmini.programmedwaterquantityselection1 <> 32766)) THEN etdmini.programmedwaterquantityselection1
            ELSE NULL::integer
        END AS waterdosage1_set,
        CASE
            WHEN ((etdmini.executedwaterquantitydosingselection1 IS NOT NULL) AND (etdmini.executedwaterquantitydosingselection1 <> 32766)) THEN etdmini.executedwaterquantitydosingselection1
            ELSE NULL::integer
        END AS waterdosage1_actual,
        CASE
            WHEN ((etdmini.programmedwaterquantityselection2 IS NOT NULL) AND (etdmini.programmedwaterquantityselection2 <> 32766)) THEN etdmini.programmedwaterquantityselection2
            ELSE NULL::integer
        END AS waterdosage2_set,
        CASE
            WHEN ((etdmini.executedwaterquantitydosingselection2 IS NOT NULL) AND (etdmini.executedwaterquantitydosingselection2 <> 32766)) THEN etdmini.executedwaterquantitydosingselection2
            ELSE NULL::integer
        END AS waterdosage2_actual,
        CASE
            WHEN (etdmini.chemcicalproducttypeselection1 IS NOT NULL) THEN etdmini.chemcicalproducttypeselection1
            ELSE NULL::integer
        END AS producttype1,
        CASE
            WHEN ((etdmini.programmedproductquantityselection1 IS NOT NULL) AND (etdmini.programmedproductquantityselection1 <> 32766)) THEN etdmini.programmedproductquantityselection1
            ELSE NULL::integer
        END AS productdosage1_set,
        CASE
            WHEN ((etdmini.executedproductquantitydosingselection1 IS NOT NULL) AND (etdmini.executedproductquantitydosingselection1 <> 32766)) THEN etdmini.executedproductquantitydosingselection1
            ELSE NULL::integer
        END AS productdosage1_actual,
        CASE
            WHEN (etdmini.chemcicalproducttypeselection2 IS NOT NULL) THEN etdmini.chemcicalproducttypeselection2
            ELSE NULL::integer
        END AS producttype2,
        CASE
            WHEN ((etdmini.programmedproductquantityselection2 IS NOT NULL) AND (etdmini.programmedproductquantityselection2 <> 32766)) THEN etdmini.programmedproductquantityselection2
            ELSE NULL::integer
        END AS productdosage2_set,
        CASE
            WHEN ((etdmini.executedproductquantitydosingselection2 IS NOT NULL) AND (etdmini.executedproductquantitydosingselection2 <> 32766)) THEN etdmini.executedproductquantitydosingselection2
            ELSE NULL::integer
        END AS productdosage2_actual
   FROM ((public.reprocessinghistoryitem rep
     JOIN public.reprocessingdevice device ON ((device.id = rep.reprocessingdevice_id)))
     LEFT JOIN public.etdminiprocessdata etdmini ON ((etdmini.reprocessinghistoryitem_id = rep.id)))
  WHERE ((rep.reprocessinghistoryitemeventtype_id = 2) AND (device.reprocessingdevicetype_id = 17))
  ORDER BY rep.id;


ALTER VIEW public.v2_1_dosagevalues_etdmini OWNER TO postgres;

--
-- Name: v2_1_endoscope_reprocessings; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v2_1_endoscope_reprocessings AS
 SELECT reprocessinghistoryitem.id AS reprocessinghistoryitem_id,
    endoscope.id AS endoscope_id,
    endoscope_has_reprocessighistoryitems.level AS loading_position
   FROM ((public.reprocessinghistoryitem
     JOIN public.endoscope_has_reprocessighistoryitems ON ((endoscope_has_reprocessighistoryitems.reprocessinghistoryitem_id = reprocessinghistoryitem.id)))
     JOIN public.endoscope ON ((endoscope.id = endoscope_has_reprocessighistoryitems.endoscope_id)));


ALTER VIEW public.v2_1_endoscope_reprocessings OWNER TO postgres;

--
-- Name: v2_1_endoscopes; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v2_1_endoscopes AS
 SELECT endoscope.id AS endoscope_id,
    endoscope.serialnumber AS serial_number,
    endoscope.isloanerdevice AS is_loanerdevice,
    endoscope.purchaseddate AS purchase_date,
    endoscope.retiredate AS retire_date,
    endoscope.customdescription AS custom_description,
    endoscope.internalid AS internal_id,
    date_trunc('second'::text, endoscope.creationdate) AS creation_date,
    date_trunc('second'::text, endoscope.lastedit) AS lastedit_date,
    endoscope.isdisabled AS is_disabled,
    endoscope.isdeleted AS is_deleted,
    endoscope.isquarantine AS is_quarantine,
    endoscopetype.id AS endoscopetype_id,
    endoscopetype.typename AS endoscope_type,
    endoscopetype.articlenumber AS article_number,
    endoscopetype.numberofchannels AS number_of_channels,
    endoscopetype.hasalbaranchannel AS has_albaran_channel,
    manufacturer.id AS manufacturer_id,
    manufacturer.name AS manufacturer
   FROM ((public.endoscope
     LEFT JOIN public.endoscopetype ON ((endoscopetype.id = endoscope.endoscopetype_id)))
     LEFT JOIN public.manufacturer ON ((endoscopetype.manufacturer_id = manufacturer.id)));


ALTER VIEW public.v2_1_endoscopes OWNER TO postgres;

--
-- Name: v2_1_protocol_errorinformation; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v2_1_protocol_errorinformation AS
 SELECT rep.id AS reprocessinghistoryitem_id,
        CASE
            WHEN (etddoubleerror.errornumber IS NOT NULL) THEN etddoubleerror.errornumber
            WHEN ((edc.result IS NOT NULL) AND (edc.protocolend IS NOT NULL)) THEN edc.result
            WHEN (etdminiprocess.phaseinterruptalarmcode IS NOT NULL) THEN etdminiprocess.phaseinterruptalarmcode
            WHEN (etd5protocol.errornumber IS NOT NULL) THEN etd5protocol.errornumber
            ELSE NULL::integer
        END AS protocol_result_code,
        CASE
            WHEN (etddoubleerror.errordescription IS NOT NULL) THEN etddoubleerror.errordescription
            WHEN (etdminiprocess.phaseinterruptdescription IS NOT NULL) THEN etdminiprocess.phaseinterruptdescription
            WHEN (etd5protocol.errorshorttext IS NOT NULL) THEN etd5protocol.errorshorttext
            ELSE NULL::character varying
        END AS protocol_result_code_meaning,
        CASE
            WHEN (etddoubleerror.blocknumber IS NOT NULL) THEN (etddoubleerror.blocknumber)::character varying
            WHEN (etdminiprocess.phasename IS NOT NULL) THEN etdminiprocess.phasename
            WHEN (device.reprocessingdevicetype_id = 18) THEN (( SELECT etd5blockinfo.blockname
               FROM public.etd5blockinfo
              WHERE (etd5blockinfo.etd5reprocessingprotocol_id = etd5protocol.id)
              ORDER BY etd5blockinfo.id DESC
             LIMIT 1))::character varying
            WHEN ((device.reprocessingdevicetype_id = 3) OR (device.reprocessingdevicetype_id = 4)) THEN (
            CASE
                WHEN ((EXTRACT(epoch FROM (edc.protocolend - edc.protocolstart)) / (60)::numeric) < (edc.dryingtime)::numeric) THEN 'drying'::text
                ELSE 'storage'::text
            END)::character varying
            ELSE NULL::character varying
        END AS program_step,
        CASE
            WHEN (etddoubleerror.stepnumber IS NOT NULL) THEN (etddoubleerror.stepnumber)::character varying
            WHEN (etdminiprocess.phasename IS NOT NULL) THEN (etdminiprocess.phaseindex)::character varying
            WHEN (device.reprocessingdevicetype_id = 18) THEN (( SELECT count(etd5blockinfo.id) AS count
               FROM public.etd5blockinfo
              WHERE (etd5blockinfo.etd5reprocessingprotocol_id = etd5protocol.id)))::character varying
            ELSE NULL::character varying
        END AS step_number,
    device.name AS device_name
   FROM ((((((public.reprocessinghistoryitem rep
     JOIN public.reprocessingdevice device ON ((device.id = rep.reprocessingdevice_id)))
     LEFT JOIN public.etddoubleerrorprotocol etddoubleerror ON ((etddoubleerror.reprocessinghistoryitem_id = rep.id)))
     LEFT JOIN public.etdminiprocessdata etdminiprocess ON ((etdminiprocess.reprocessinghistoryitem_id = rep.id)))
     LEFT JOIN public.edcreprocessingprotocol edc ON ((edc.reprocessinghistoryitem_id = rep.id)))
     LEFT JOIN public.etd5reprocessingprotocol etd5protocol ON ((etd5protocol.reprocessinghistoryitem_id = rep.id)))
     LEFT JOIN public.etd5blockinfo etd5block ON ((etd5block.etd5reprocessingprotocol_id = etd5protocol.id)))
  WHERE ((rep.endtime IS NOT NULL) AND (rep.reprocessinghistoryitemeventtype_id = 2) AND (((device.reprocessingdevicetype_id = 5) AND (rep.success = false) AND (etddoubleerror.* IS NOT NULL)) OR ((device.reprocessingdevicetype_id = 17) AND (rep.success = false) AND ((etdminiprocess.phaseinterruptdescription)::text <> ''::text)) OR (((device.reprocessingdevicetype_id = 3) OR (device.reprocessingdevicetype_id = 4)) AND (edc.result IS NOT NULL) AND (edc.result <> 0) AND (edc.protocolend IS NOT NULL)) OR ((device.reprocessingdevicetype_id = 18) AND (etd5protocol.errornumber IS NOT NULL) AND (rep.success = false))))
  GROUP BY rep.id,
        CASE
            WHEN (etddoubleerror.errornumber IS NOT NULL) THEN etddoubleerror.errornumber
            WHEN ((edc.result IS NOT NULL) AND (edc.protocolend IS NOT NULL)) THEN edc.result
            WHEN (etdminiprocess.phaseinterruptalarmcode IS NOT NULL) THEN etdminiprocess.phaseinterruptalarmcode
            WHEN (etd5protocol.errornumber IS NOT NULL) THEN etd5protocol.errornumber
            ELSE NULL::integer
        END,
        CASE
            WHEN (etddoubleerror.errordescription IS NOT NULL) THEN etddoubleerror.errordescription
            WHEN (etdminiprocess.phaseinterruptdescription IS NOT NULL) THEN etdminiprocess.phaseinterruptdescription
            WHEN (etd5protocol.errorshorttext IS NOT NULL) THEN etd5protocol.errorshorttext
            ELSE NULL::character varying
        END,
        CASE
            WHEN (etddoubleerror.blocknumber IS NOT NULL) THEN (etddoubleerror.blocknumber)::character varying
            WHEN (etdminiprocess.phasename IS NOT NULL) THEN etdminiprocess.phasename
            WHEN (device.reprocessingdevicetype_id = 18) THEN (( SELECT etd5blockinfo.blockname
               FROM public.etd5blockinfo
              WHERE (etd5blockinfo.etd5reprocessingprotocol_id = etd5protocol.id)
              ORDER BY etd5blockinfo.id DESC
             LIMIT 1))::character varying
            WHEN ((device.reprocessingdevicetype_id = 3) OR (device.reprocessingdevicetype_id = 4)) THEN (
            CASE
                WHEN ((EXTRACT(epoch FROM (edc.protocolend - edc.protocolstart)) / (60)::numeric) < (edc.dryingtime)::numeric) THEN 'drying'::text
                ELSE 'storage'::text
            END)::character varying
            ELSE NULL::character varying
        END,
        CASE
            WHEN (etddoubleerror.stepnumber IS NOT NULL) THEN (etddoubleerror.stepnumber)::character varying
            WHEN (etdminiprocess.phasename IS NOT NULL) THEN (etdminiprocess.phaseindex)::character varying
            WHEN (device.reprocessingdevicetype_id = 18) THEN (( SELECT count(etd5blockinfo.id) AS count
               FROM public.etd5blockinfo
              WHERE (etd5blockinfo.etd5reprocessingprotocol_id = etd5protocol.id)))::character varying
            ELSE NULL::character varying
        END, device.name
  ORDER BY rep.id;


ALTER VIEW public.v2_1_protocol_errorinformation OWNER TO postgres;

--
-- Name: v2_1_protocols; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v2_1_protocols AS
 SELECT rep.id AS reprocessinghistoryitem_id,
    date_trunc('seconds'::text, rep.starttime) AS protocol_start_date,
    date_trunc('seconds'::text, rep.endtime) AS protocol_end_date,
    rep.success AS is_success,
    reprocessinghistoryitemeventtype.typename AS event_type,
    reprocessingdevice.id AS reprocessingdevice_id,
    rep.batch_id,
    batch.devicebatchid AS device_batch_id,
        CASE
            WHEN (( SELECT etddoublereprocessingprotocol.id
               FROM public.etddoublereprocessingprotocol
              WHERE (etddoublereprocessingprotocol.reprocessinghistoryitem_id = rep.id)
             LIMIT 1) IS NOT NULL) THEN ( SELECT etddoublereprocessingprotocol.errornumber
               FROM public.etddoublereprocessingprotocol
              WHERE (etddoublereprocessingprotocol.reprocessinghistoryitem_id = rep.id)
              ORDER BY etddoublereprocessingprotocol.id DESC
             LIMIT 1)
            WHEN (( SELECT edcreprocessingprotocol.id
               FROM public.edcreprocessingprotocol
              WHERE (edcreprocessingprotocol.reprocessinghistoryitem_id = rep.id)
             LIMIT 1) IS NOT NULL) THEN (( SELECT (edcreprocessingprotocol.result)::text AS result
               FROM public.edcreprocessingprotocol
              WHERE (edcreprocessingprotocol.reprocessinghistoryitem_id = rep.id)
              ORDER BY edcreprocessingprotocol.id DESC
             LIMIT 1))::character varying
            WHEN (( SELECT etdminireprocessingprotocol.id
               FROM public.etdminireprocessingprotocol
              WHERE (etdminireprocessingprotocol.reprocessinghistoryitem_id = rep.id)
             LIMIT 1) IS NOT NULL) THEN ( SELECT etdminireprocessingprotocol.cycleresultcode
               FROM public.etdminireprocessingprotocol
              WHERE (etdminireprocessingprotocol.reprocessinghistoryitem_id = rep.id)
              ORDER BY etdminireprocessingprotocol.id DESC
             LIMIT 1)
            WHEN (( SELECT etd5reprocessingprotocol.id
               FROM public.etd5reprocessingprotocol
              WHERE ((etd5reprocessingprotocol.reprocessinghistoryitem_id = rep.id) AND (etd5reprocessingprotocol.errornumber IS NOT NULL))
             LIMIT 1) IS NOT NULL) THEN (( SELECT (etd5reprocessingprotocol.errornumber)::text AS errornumber
               FROM public.etd5reprocessingprotocol
              WHERE ((etd5reprocessingprotocol.reprocessinghistoryitem_id = rep.id) AND (etd5reprocessingprotocol.errornumber IS NOT NULL))
             LIMIT 1))::character varying
            ELSE NULL::character varying
        END AS protocol_result_code,
        CASE
            WHEN (( SELECT etddoublereprocessingprotocol.id
               FROM public.etddoublereprocessingprotocol
              WHERE (etddoublereprocessingprotocol.reprocessinghistoryitem_id = rep.id)
              ORDER BY etddoublereprocessingprotocol.id DESC
             LIMIT 1) IS NOT NULL) THEN ( SELECT etddoublereprocessingprotocol.programname
               FROM public.etddoublereprocessingprotocol
              WHERE (etddoublereprocessingprotocol.reprocessinghistoryitem_id = rep.id)
              ORDER BY etddoublereprocessingprotocol.id DESC
             LIMIT 1)
            WHEN (( SELECT etdv3reprocessingprotocol.id
               FROM public.etdv3reprocessingprotocol
              WHERE (etdv3reprocessingprotocol.reprocessinghistoryitem_id = rep.id)
              ORDER BY etdv3reprocessingprotocol.id DESC
             LIMIT 1) IS NOT NULL) THEN ( SELECT etdv3reprocessingprotocol.protocolprogramname
               FROM public.etdv3reprocessingprotocol
              WHERE (etdv3reprocessingprotocol.reprocessinghistoryitem_id = rep.id)
              ORDER BY etdv3reprocessingprotocol.id DESC
             LIMIT 1)
            WHEN (( SELECT etdminireprocessingprotocol.id
               FROM public.etdminireprocessingprotocol
              WHERE (etdminireprocessingprotocol.reprocessinghistoryitem_id = rep.id)
              ORDER BY etdminireprocessingprotocol.id DESC
             LIMIT 1) IS NOT NULL) THEN ( SELECT etdminireprocessingprotocol.cyclename
               FROM public.etdminireprocessingprotocol
              WHERE (etdminireprocessingprotocol.reprocessinghistoryitem_id = rep.id)
              ORDER BY etdminireprocessingprotocol.id DESC
             LIMIT 1)
            WHEN (( SELECT etd5reprocessingprotocol.id
               FROM public.etd5reprocessingprotocol
              WHERE (etd5reprocessingprotocol.reprocessinghistoryitem_id = rep.id)
             LIMIT 1) IS NOT NULL) THEN ( SELECT etd5reprocessingprotocol.programname
               FROM public.etd5reprocessingprotocol
              WHERE (etd5reprocessingprotocol.reprocessinghistoryitem_id = rep.id)
             LIMIT 1)
            ELSE ''::character varying
        END AS protocol_program_name,
        CASE
            WHEN (( SELECT etddoublereprocessingprotocol.id
               FROM public.etddoublereprocessingprotocol
              WHERE ((etddoublereprocessingprotocol.reprocessinghistoryitem_id = rep.id) AND (((etddoublereprocessingprotocol.errornumber)::text = '3368'::text) OR ((etddoublereprocessingprotocol.errornumber)::text = '3221'::text)))
              ORDER BY etddoublereprocessingprotocol.id DESC
             LIMIT 1) IS NOT NULL) THEN true
            WHEN (( SELECT etdminiprocessdata.id
               FROM public.etdminiprocessdata
              WHERE ((etdminiprocessdata.reprocessinghistoryitem_id = rep.id) AND (etdminiprocessdata.etdminicyclephaseinterrupttype_id = 5))
              ORDER BY etdminiprocessdata.id DESC
             LIMIT 1) IS NOT NULL) THEN true
            WHEN (( SELECT etd5reprocessingprotocol.id
               FROM public.etd5reprocessingprotocol
              WHERE ((etd5reprocessingprotocol.reprocessinghistoryitem_id = rep.id) AND ((etd5reprocessingprotocol.errornumber = 3916) OR (etd5reprocessingprotocol.errornumber = 3862)))
             LIMIT 1) IS NOT NULL) THEN true
            WHEN (( SELECT edcreprocessingprotocol.id
               FROM public.edcreprocessingprotocol
              WHERE ((edcreprocessingprotocol.reprocessinghistoryitem_id = rep.id) AND (edcreprocessingprotocol.result = 2))
             LIMIT 1) IS NOT NULL) THEN true
            ELSE false
        END AS is_canceled_by_user,
        CASE
            WHEN (( SELECT edcreprocessingprotocol.reprocessinghistoryitem_id
               FROM public.edcreprocessingprotocol
              WHERE (edcreprocessingprotocol.reprocessinghistoryitem_id = rep.id)
             LIMIT 1) IS NOT NULL) THEN ( SELECT edcreprocessingprotocol.dryingtime
               FROM public.edcreprocessingprotocol
              WHERE (edcreprocessingprotocol.reprocessinghistoryitem_id = rep.id)
             LIMIT 1)
            ELSE NULL::integer
        END AS drying_time_set_edc
   FROM ((((public.reprocessinghistoryitem rep
     JOIN public.reprocessinghistoryitemeventtype ON ((reprocessinghistoryitemeventtype.id = rep.reprocessinghistoryitemeventtype_id)))
     LEFT JOIN public.reprocessingdevice ON ((reprocessingdevice.id = rep.reprocessingdevice_id)))
     LEFT JOIN public.reprocessingdevicetype ON ((reprocessingdevicetype.id = reprocessingdevice.reprocessingdevicetype_id)))
     LEFT JOIN public.batch ON ((batch.id = rep.batch_id)))
  WHERE (rep.endtime IS NOT NULL)
  ORDER BY rep.id;


ALTER VIEW public.v2_1_protocols OWNER TO postgres;

--
-- Name: v2_1_reprocessingdevices; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v2_1_reprocessingdevices AS
 SELECT rep.id AS reprocessingdevice_id,
    reprocessingdevicetype.id AS reprocessingdevicetype_id,
    rep.serialnumber AS serial_number,
    rep.location,
    rep.name,
    date_trunc('second'::text, rep.creationdate) AS creation_date,
    date_trunc('second'::text, rep.lastedit) AS lastedit_date,
    date_trunc('second'::text, (rep.purchaseddate)::timestamp with time zone) AS purchase_date,
    date_trunc('second'::text, (rep.retiredate)::timestamp with time zone) AS retire_date,
    rep.isdeleted AS is_deleted,
    rep.isdisabled AS is_disabled,
    rep.isquarantine AS is_quarantine,
    rep.firmwareversion AS firmware_version,
    reprocessingdevicetype.typename AS reprocessingdevice_type,
    reprocessingdevicetype.maximunload AS maximum_load,
    connectionstatus.connectionstate AS connection_state,
    reprocessingstatus.reprocessingstate AS reprocessing_state
   FROM ((((public.reprocessingdevice rep
     LEFT JOIN public.reprocessingdevicetype ON ((rep.reprocessingdevicetype_id = reprocessingdevicetype.id)))
     LEFT JOIN public.currentdata ON ((rep.id = currentdata.reprocessingdevice_id)))
     JOIN public.connectionstatus ON ((currentdata.connectionstatus_id = connectionstatus.id)))
     JOIN public.reprocessingstatus ON ((currentdata.reprocessingstatus_id = reprocessingstatus.id)));


ALTER VIEW public.v2_1_reprocessingdevices OWNER TO postgres;

--
-- Name: v2_1_reprocessingstation_info; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v2_1_reprocessingstation_info AS
 SELECT cyclestationinfo.cycle_id,
    profil.id AS profil_id,
    profil.name AS profil_name,
    reprocessingstation.sequencenumber AS sequence_number,
    cyclestep.starttime AS start_time,
    cyclestep.endtime,
        CASE
            WHEN (lag(cyclestationinfo.cycle_id, '-1'::integer) OVER (ORDER BY cyclestationinfo.id) = cyclestationinfo.cycle_id) THEN (lag(cyclestep.starttime, '-1'::integer) OVER (ORDER BY cyclestationinfo.id) - cyclestep.endtime)
            ELSE NULL::interval
        END AS timediff_to_next_ste
   FROM (((public.cyclestationinfo
     JOIN public.reprocessingstation ON ((cyclestationinfo.reprocessingstation_id = reprocessingstation.id)))
     JOIN public.cyclestep ON ((cyclestationinfo.cyclestep_id = cyclestep.id)))
     JOIN public.profil ON ((reprocessingstation.profil_id = profil.id)))
  WHERE (cyclestationinfo.cyclestationstate_id = 4)
  ORDER BY cyclestationinfo.id;


ALTER VIEW public.v2_1_reprocessingstation_info OWNER TO postgres;

--
-- Name: v2_1_sensorvalues; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v2_1_sensorvalues AS
 SELECT reprocessinghistoryitem.id AS reprocessinghistoryitem_id,
    date_trunc('second'::text, reprocessinghistoryitem.creationdate) AS creation_date,
    device.id AS reprocessingdevice_id,
        CASE
            WHEN (etdddata.watertemperature IS NOT NULL) THEN ((etdddata.watertemperature)::double precision / (100)::double precision)
            WHEN (etdbasic.watertemperature IS NOT NULL) THEN ((etdbasic.watertemperature)::double precision / (10)::double precision)
            WHEN (etdmini.tanktemperature1 IS NOT NULL) THEN ((etdmini.tanktemperature1)::double precision * (10)::double precision)
            ELSE NULL::double precision
        END AS water_temperature1_c,
        CASE
            WHEN (etdmini.tanktemperature2 IS NOT NULL) THEN ((etdmini.tanktemperature2)::double precision * (10)::double precision)
            ELSE NULL::double precision
        END AS water_temperature2_c,
        CASE
            WHEN (etdddata.airtemperature IS NOT NULL) THEN ((etdddata.airtemperature)::double precision / (100)::double precision)
            WHEN (etdbasic.airtemperature IS NOT NULL) THEN ((etdbasic.airtemperature)::double precision / (10)::double precision)
            ELSE NULL::double precision
        END AS air_temperature_c,
        CASE
            WHEN (etdddata.scavengingpressureupper IS NOT NULL) THEN etdddata.scavengingpressureupper
            WHEN (etdbasic.pressure1_mpa IS NOT NULL) THEN etdbasic.pressure1_mpa
            WHEN (etdmini.leaktestpressureinstrument1 IS NOT NULL) THEN etdmini.leaktestpressureinstrument1
            ELSE NULL::integer
        END AS pressure_1_mbar,
        CASE
            WHEN (etdddata.scavengingpressuremiddle IS NOT NULL) THEN etdddata.scavengingpressuremiddle
            WHEN (etdbasic.pressure2_mpa IS NOT NULL) THEN etdbasic.pressure2_mpa
            WHEN (etdmini.washpressurebasket IS NOT NULL) THEN etdmini.washpressurebasket
            ELSE NULL::integer
        END AS pressure_2_mbar,
        CASE
            WHEN (etdddata.scavengingpressurelower IS NOT NULL) THEN etdddata.scavengingpressurelower
            ELSE NULL::integer
        END AS pressure_lower_mbar,
        CASE
            WHEN (etdddata."timestamp" IS NOT NULL) THEN etdddata."timestamp"
            WHEN (etdbasic."timestamp" IS NOT NULL) THEN etdbasic."timestamp"
            WHEN (etdmini."timestamp" IS NOT NULL) THEN etdmini."timestamp"
            ELSE NULL::timestamp without time zone
        END AS "timestamp"
   FROM (((((public.reprocessinghistoryitem
     LEFT JOIN public.etddoubleprocessdata etdddata ON ((etdddata.reprocessinghistoryitem_id = reprocessinghistoryitem.id)))
     LEFT JOIN public.etdbasicprocessdata etdbasic ON ((etdbasic.reprocessinghistoryitem_id = reprocessinghistoryitem.id)))
     LEFT JOIN public.etdminiprobedata etdmini ON ((etdmini.reprocessinghistoryitem_id = reprocessinghistoryitem.id)))
     LEFT JOIN public.reprocessingdevice device ON ((device.id = reprocessinghistoryitem.reprocessingdevice_id)))
     LEFT JOIN public.reprocessingdevicetype ON ((reprocessingdevicetype.id = device.reprocessingdevicetype_id)))
  WHERE (reprocessinghistoryitem.reprocessinghistoryitemeventtype_id = 2);


ALTER VIEW public.v2_1_sensorvalues OWNER TO postgres;

--
-- Name: v2_1_sensorvalues_etd5; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v2_1_sensorvalues_etd5 AS
 SELECT rep.id AS reprocessinghistoryitem_id,
    etd5block.id AS block_id,
    etd5block.blockname,
    etd5block.blockstarttime,
    etd5block.tempvalminvalue AS temp_min_actual,
    etd5block.tempvalmaxvalue AS temp_max_actual,
    etd5block.tempvalrequiredvalue AS temp_set,
    etd5pressure.pressureval1min AS pressure_1_min_actual,
    etd5pressure.pressureval1max AS pressure_1_max_actual,
    etd5pressure.pressureval2min AS pressure_2_min_actual,
    etd5pressure.pressureval2max AS pressure_2_max_actual,
    etd5pressure.pressurevalrequiredmin AS pressure_min_set,
    etd5pressure.pressurevalrequiredmax AS pressure_max_set
   FROM ((((public.reprocessinghistoryitem rep
     LEFT JOIN public.reprocessingdevice device ON ((device.id = rep.reprocessingdevice_id)))
     LEFT JOIN public.etd5reprocessingprotocol etd5protocol ON ((etd5protocol.reprocessinghistoryitem_id = rep.id)))
     LEFT JOIN public.etd5blockinfo etd5block ON ((etd5block.etd5reprocessingprotocol_id = etd5protocol.id)))
     LEFT JOIN public.etd5pressure ON ((etd5pressure.etd5blockinfo_id = etd5block.id)))
  WHERE ((device.reprocessingdevicetype_id = 18) AND (etd5block.id IS NOT NULL))
  ORDER BY etd5block.blockstarttime, rep.id;


ALTER VIEW public.v2_1_sensorvalues_etd5 OWNER TO postgres;

--
-- Name: v2_3_endoscopes_productivityreport; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v2_3_endoscopes_productivityreport AS
 SELECT et.id AS endoscope_type_id,
    et.typename AS endoscope_type_name,
    e.serialnumber AS endoscope_serial_number,
    rs.name AS station_name,
    rhi.starttime AS started_at,
    rhi.endtime AS finished_at
   FROM (((((public.reprocessinghistoryitem rhi
     JOIN public.cyclestep cs ON ((cs.reprocessinghistoryitem_id = rhi.id)))
     JOIN public.cycle c ON ((c.id = cs.cycle_id)))
     JOIN public.endoscope e ON ((e.id = c.endoscope_id)))
     JOIN public.endoscopetype et ON ((et.id = e.endoscopetype_id)))
     JOIN public.reprocessingstation rs ON ((rs.id = cs.reprocessingstation_id)))
  GROUP BY et.id, et.typename, e.serialnumber, rs.name, rhi.starttime, rhi.endtime;


ALTER VIEW public.v2_3_endoscopes_productivityreport OWNER TO postgres;

--
-- Name: v2_3_users_productivityreport; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v2_3_users_productivityreport AS
 SELECT COALESCE(
        CASE
            WHEN (rep.endtime IS NOT NULL) THEN
            CASE
                WHEN ((COALESCE(concat_ws(', '::text, NULLIF((endperson.lastname)::text, ''::text), NULLIF((endperson.firstname)::text, ''::text), NULLIF((endperson.employeenumber)::text, ''::text)), ''::text) = ''::text) IS FALSE) THEN ((concat_ws(', '::text, NULLIF((endperson.lastname)::text, ''::text), NULLIF((endperson.firstname)::text, ''::text), NULLIF((endperson.employeenumber)::text, ''::text)))::character varying)::text
                WHEN (rep.enddeviceusername IS NOT NULL) THEN concat_ws(': '::text, NULLIF((enduser.id)::text, ''::text), NULLIF((rep.enddeviceusername)::text, ''::text))
                WHEN (endperson.username IS NOT NULL) THEN (endperson.username)::text
                ELSE (enduser.id)::text
            END
            ELSE NULL::text
        END, (
        CASE
            WHEN ((COALESCE(concat_ws(', '::text, NULLIF((startperson.lastname)::text, ''::text), NULLIF((startperson.firstname)::text, ''::text), NULLIF((startperson.employeenumber)::text, ''::text)), ''::text) = ''::text) IS FALSE) THEN (concat_ws(', '::text, NULLIF((startperson.lastname)::text, ''::text), NULLIF((startperson.firstname)::text, ''::text), NULLIF((startperson.employeenumber)::text, ''::text)))::character varying
            WHEN (rep.startdeviceusername IS NOT NULL) THEN (concat_ws(': '::text, NULLIF((startuser.id)::text, ''::text), NULLIF((rep.startdeviceusername)::text, ''::text)))::character varying
            WHEN (startperson.username IS NOT NULL) THEN startperson.username
            ELSE (startuser.id)::character varying
        END)::text) AS user_name,
    rep.id AS reprocessinghistoryitem_id,
    rs.name AS station_name,
    rtype.typename AS description,
    rep.starttime AS started_at,
    rep.endtime AS finished_at
   FROM ((((((((((public.reprocessinghistoryitem rep
     LEFT JOIN public.reprocessinghistoryitemeventtype rtype ON ((rtype.id = rep.reprocessinghistoryitemeventtype_id)))
     LEFT JOIN public.useraccount startuser ON ((startuser.id = rep.startuseraccount_id)))
     LEFT JOIN private.p_person startperson ON ((startperson.useraccount_id = startuser.id)))
     LEFT JOIN public.useraccount enduser ON ((enduser.id = rep.enduseraccount_id)))
     LEFT JOIN private.p_person endperson ON ((endperson.useraccount_id = enduser.id)))
     LEFT JOIN public.endoscope_has_reprocessighistoryitems ehr ON ((ehr.reprocessinghistoryitem_id = rep.id)))
     LEFT JOIN public.endoscope ON ((endoscope.id = ehr.endoscope_id)))
     JOIN public.cyclestep cs ON ((cs.reprocessinghistoryitem_id = rep.id)))
     JOIN public.cycle ON (((cycle.id = cs.cycle_id) AND (cycle.endoscope_id = endoscope.id))))
     JOIN public.reprocessingstation rs ON ((rs.id = cs.reprocessingstation_id)))
  GROUP BY rep.id, rep.starttime, rep.endtime, COALESCE(
        CASE
            WHEN (rep.endtime IS NOT NULL) THEN
            CASE
                WHEN ((COALESCE(concat_ws(', '::text, NULLIF((endperson.lastname)::text, ''::text), NULLIF((endperson.firstname)::text, ''::text), NULLIF((endperson.employeenumber)::text, ''::text)), ''::text) = ''::text) IS FALSE) THEN ((concat_ws(', '::text, NULLIF((endperson.lastname)::text, ''::text), NULLIF((endperson.firstname)::text, ''::text), NULLIF((endperson.employeenumber)::text, ''::text)))::character varying)::text
                WHEN (rep.enddeviceusername IS NOT NULL) THEN concat_ws(': '::text, NULLIF((enduser.id)::text, ''::text), NULLIF((rep.enddeviceusername)::text, ''::text))
                WHEN (endperson.username IS NOT NULL) THEN (endperson.username)::text
                ELSE (enduser.id)::text
            END
            ELSE NULL::text
        END, (
        CASE
            WHEN ((COALESCE(concat_ws(', '::text, NULLIF((startperson.lastname)::text, ''::text), NULLIF((startperson.firstname)::text, ''::text), NULLIF((startperson.employeenumber)::text, ''::text)), ''::text) = ''::text) IS FALSE) THEN (concat_ws(', '::text, NULLIF((startperson.lastname)::text, ''::text), NULLIF((startperson.firstname)::text, ''::text), NULLIF((startperson.employeenumber)::text, ''::text)))::character varying
            WHEN (rep.startdeviceusername IS NOT NULL) THEN (concat_ws(': '::text, NULLIF((startuser.id)::text, ''::text), NULLIF((rep.startdeviceusername)::text, ''::text)))::character varying
            WHEN (startperson.username IS NOT NULL) THEN startperson.username
            ELSE (startuser.id)::character varying
        END)::text), rs.name, rtype.typename
  ORDER BY rep.id, rep.starttime, rep.endtime, COALESCE(
        CASE
            WHEN (rep.endtime IS NOT NULL) THEN
            CASE
                WHEN ((COALESCE(concat_ws(', '::text, NULLIF((endperson.lastname)::text, ''::text), NULLIF((endperson.firstname)::text, ''::text), NULLIF((endperson.employeenumber)::text, ''::text)), ''::text) = ''::text) IS FALSE) THEN ((concat_ws(', '::text, NULLIF((endperson.lastname)::text, ''::text), NULLIF((endperson.firstname)::text, ''::text), NULLIF((endperson.employeenumber)::text, ''::text)))::character varying)::text
                WHEN (rep.enddeviceusername IS NOT NULL) THEN concat_ws(': '::text, NULLIF((enduser.id)::text, ''::text), NULLIF((rep.enddeviceusername)::text, ''::text))
                WHEN (endperson.username IS NOT NULL) THEN (endperson.username)::text
                ELSE (enduser.id)::text
            END
            ELSE NULL::text
        END, (
        CASE
            WHEN ((COALESCE(concat_ws(', '::text, NULLIF((startperson.lastname)::text, ''::text), NULLIF((startperson.firstname)::text, ''::text), NULLIF((startperson.employeenumber)::text, ''::text)), ''::text) = ''::text) IS FALSE) THEN (concat_ws(', '::text, NULLIF((startperson.lastname)::text, ''::text), NULLIF((startperson.firstname)::text, ''::text), NULLIF((startperson.employeenumber)::text, ''::text)))::character varying
            WHEN (rep.startdeviceusername IS NOT NULL) THEN (concat_ws(': '::text, NULLIF((startuser.id)::text, ''::text), NULLIF((rep.startdeviceusername)::text, ''::text)))::character varying
            WHEN (startperson.username IS NOT NULL) THEN startperson.username
            ELSE (startuser.id)::character varying
        END)::text), rs.name, rtype.typename;


ALTER VIEW public.v2_3_users_productivityreport OWNER TO postgres;

--
-- Name: attachment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attachment ALTER COLUMN id SET DEFAULT nextval('public.attachment_id_seq'::regclass);


--
-- Name: batch id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.batch ALTER COLUMN id SET DEFAULT nextval('public.batch_id_seq'::regclass);


--
-- Name: checklist id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checklist ALTER COLUMN id SET DEFAULT nextval('public.checklist_id_seq'::regclass);


--
-- Name: checklistitem id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checklistitem ALTER COLUMN id SET DEFAULT nextval('public.checklistitem_id_seq'::regclass);


--
-- Name: checklistitem_has_attachment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checklistitem_has_attachment ALTER COLUMN id SET DEFAULT nextval('public.checklistitem_has_attachment_id_seq'::regclass);


--
-- Name: confirmationprotocol id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.confirmationprotocol ALTER COLUMN id SET DEFAULT nextval('public.confirmationprotocol_id_seq'::regclass);


--
-- Name: contamination id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contamination ALTER COLUMN id SET DEFAULT nextval('public.contamination_id_seq'::regclass);


--
-- Name: cycle id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cycle ALTER COLUMN id SET DEFAULT nextval('public.cycle_id_seq'::regclass);


--
-- Name: cyclefinishedreason id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cyclefinishedreason ALTER COLUMN id SET DEFAULT nextval('public.cyclefinishedreason_id_seq'::regclass);


--
-- Name: cyclelog id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cyclelog ALTER COLUMN id SET DEFAULT nextval('public.cyclelog_id_seq'::regclass);


--
-- Name: cyclestate id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cyclestate ALTER COLUMN id SET DEFAULT nextval('public.cyclestate_id_seq'::regclass);


--
-- Name: cyclestationinfo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cyclestationinfo ALTER COLUMN id SET DEFAULT nextval('public.cyclestationinfo_id_seq'::regclass);


--
-- Name: cyclestep id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cyclestep ALTER COLUMN id SET DEFAULT nextval('public.cyclestep_id_seq'::regclass);


--
-- Name: cyclestepqueue id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cyclestepqueue ALTER COLUMN id SET DEFAULT nextval('public.cyclestepqueue_id_seq'::regclass);


--
-- Name: department id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department ALTER COLUMN id SET DEFAULT nextval('public.department_id_seq'::regclass);


--
-- Name: department_endoscopetype_instruction id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department_endoscopetype_instruction ALTER COLUMN id SET DEFAULT nextval('public.department_endoscopetype_instruction_id_seq'::regclass);


--
-- Name: edcadaptergroup id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edcadaptergroup ALTER COLUMN id SET DEFAULT nextval('public.edcadaptergroup_id_seq'::regclass);


--
-- Name: edcreprocessingprotocol id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edcreprocessingprotocol ALTER COLUMN id SET DEFAULT nextval('public.edcreprocessingprotocol_id_seq'::regclass);


--
-- Name: endoscope id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscope ALTER COLUMN id SET DEFAULT nextval('public.endoscope_id_seq'::regclass);


--
-- Name: endoscope_has_department id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscope_has_department ALTER COLUMN id SET DEFAULT nextval('public.endoscope_has_department_id_seq'::regclass);


--
-- Name: endoscope_has_identifier id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscope_has_identifier ALTER COLUMN id SET DEFAULT nextval('public.endoscope_has_identifier_id_seq'::regclass);


--
-- Name: endoscope_has_reprocessighistoryitems id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscope_has_reprocessighistoryitems ALTER COLUMN id SET DEFAULT nextval('public.endoscope_has_reprocessighistoryitems_id_seq'::regclass);


--
-- Name: endoscope_has_task id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscope_has_task ALTER COLUMN id SET DEFAULT nextval('public.endoscope_has_task_id_seq'::regclass);


--
-- Name: endoscopedashboardconfig id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopedashboardconfig ALTER COLUMN id SET DEFAULT nextval('public.endoscopedashboardconfig_id_seq'::regclass);


--
-- Name: endoscopelocation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopelocation ALTER COLUMN id SET DEFAULT nextval('public.endoscopelocation_id_seq'::regclass);


--
-- Name: endoscopetype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopetype ALTER COLUMN id SET DEFAULT nextval('public.endoscopetype_id_seq'::regclass);


--
-- Name: endoscopetype_has_etd5referencetype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopetype_has_etd5referencetype ALTER COLUMN id SET DEFAULT nextval('public.endoscopetype_has_etd5referencetype_id_seq'::regclass);


--
-- Name: endoscopetype_has_etddoublereferencetype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopetype_has_etddoublereferencetype ALTER COLUMN id SET DEFAULT nextval('public.endoscopetype_has_etddoublereferencetype_id_seq'::regclass);


--
-- Name: endoscopetype_has_proceduretype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopetype_has_proceduretype ALTER COLUMN id SET DEFAULT nextval('public.endoscopetype_has_proceduretype_id_seq'::regclass);


--
-- Name: endoscopetype_has_task id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopetype_has_task ALTER COLUMN id SET DEFAULT nextval('public.endoscopetype_has_task_id_seq'::regclass);


--
-- Name: etd5blockinfo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5blockinfo ALTER COLUMN id SET DEFAULT nextval('public.etd5blockinfo_id_seq'::regclass);


--
-- Name: etd5dosageinfo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5dosageinfo ALTER COLUMN id SET DEFAULT nextval('public.etd5dosageinfo_id_seq'::regclass);


--
-- Name: etd5endoscope id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5endoscope ALTER COLUMN id SET DEFAULT nextval('public.etd5endoscope_id_seq'::regclass);


--
-- Name: etd5endoscopeinfo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5endoscopeinfo ALTER COLUMN id SET DEFAULT nextval('public.etd5endoscopeinfo_id_seq'::regclass);


--
-- Name: etd5endoscopetype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5endoscopetype ALTER COLUMN id SET DEFAULT nextval('public.etd5endoscopetype_id_seq'::regclass);


--
-- Name: etd5errorprotocol id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5errorprotocol ALTER COLUMN id SET DEFAULT nextval('public.etd5errorprotocol_id_seq'::regclass);


--
-- Name: etd5maschinevariant id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5maschinevariant ALTER COLUMN id SET DEFAULT nextval('public.etd5maschinevariant_id_seq'::regclass);


--
-- Name: etd5message id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5message ALTER COLUMN id SET DEFAULT nextval('public.etd5message_id_seq'::regclass);


--
-- Name: etd5pressure id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5pressure ALTER COLUMN id SET DEFAULT nextval('public.etd5pressure_id_seq'::regclass);


--
-- Name: etd5processdatadetailed id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5processdatadetailed ALTER COLUMN id SET DEFAULT nextval('public.etd5processdatadetailed_id_seq'::regclass);


--
-- Name: etd5referencetypeitem id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5referencetypeitem ALTER COLUMN id SET DEFAULT nextval('public.etd5referencetypeitem_id_seq'::regclass);


--
-- Name: etd5referencetypelist id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5referencetypelist ALTER COLUMN id SET DEFAULT nextval('public.etd5referencetypelist_id_seq'::regclass);


--
-- Name: etd5reprocessingprotocol id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5reprocessingprotocol ALTER COLUMN id SET DEFAULT nextval('public.etd5reprocessingprotocol_id_seq'::regclass);


--
-- Name: etd5rotation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5rotation ALTER COLUMN id SET DEFAULT nextval('public.etd5rotation_id_seq'::regclass);


--
-- Name: etd5user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5user ALTER COLUMN id SET DEFAULT nextval('public.etd5user_id_seq'::regclass);


--
-- Name: etd5userinfo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5userinfo ALTER COLUMN id SET DEFAULT nextval('public.etd5userinfo_id_seq'::regclass);


--
-- Name: etdbasicprocessdata id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdbasicprocessdata ALTER COLUMN id SET DEFAULT nextval('public.etdbasicprocessdata_id_seq'::regclass);


--
-- Name: etddoubleapcinfo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoubleapcinfo ALTER COLUMN id SET DEFAULT nextval('public.etddoubleapcinfo_id_seq'::regclass);


--
-- Name: etddoubleblockinfo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoubleblockinfo ALTER COLUMN id SET DEFAULT nextval('public.etddoubleblockinfo_id_seq'::regclass);


--
-- Name: etddoubledosinginfo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoubledosinginfo ALTER COLUMN id SET DEFAULT nextval('public.etddoubledosinginfo_id_seq'::regclass);


--
-- Name: etddoubleendoscope id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoubleendoscope ALTER COLUMN id SET DEFAULT nextval('public.etddoubleendoscope_id_seq'::regclass);


--
-- Name: etddoubleendoscopeinfo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoubleendoscopeinfo ALTER COLUMN id SET DEFAULT nextval('public.etddoubleendoscopeinfo_id_seq'::regclass);


--
-- Name: etddoubleerrorprotocol id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoubleerrorprotocol ALTER COLUMN id SET DEFAULT nextval('public.etddoubleerrorprotocol_id_seq'::regclass);


--
-- Name: etddoublepressure id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoublepressure ALTER COLUMN id SET DEFAULT nextval('public.etddoublepressure_id_seq'::regclass);


--
-- Name: etddoubleprocessdata id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoubleprocessdata ALTER COLUMN id SET DEFAULT nextval('public.etddoubleprocessdata_id_seq'::regclass);


--
-- Name: etddoublereferencetypeitem id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoublereferencetypeitem ALTER COLUMN id SET DEFAULT nextval('public.etddoublereferencetypeitem_id_seq'::regclass);


--
-- Name: etddoublereferencetypelist id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoublereferencetypelist ALTER COLUMN id SET DEFAULT nextval('public.etddoublereferencetypelist_id_seq'::regclass);


--
-- Name: etddoublereprocessingprotocol id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoublereprocessingprotocol ALTER COLUMN id SET DEFAULT nextval('public.etddoublereprocessingprotocol_id_seq'::regclass);


--
-- Name: etddoublerotation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoublerotation ALTER COLUMN id SET DEFAULT nextval('public.etddoublerotation_id_seq'::regclass);


--
-- Name: etddoubleuser id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoubleuser ALTER COLUMN id SET DEFAULT nextval('public.etddoubleuser_id_seq'::regclass);


--
-- Name: etddoubleuserinfo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoubleuserinfo ALTER COLUMN id SET DEFAULT nextval('public.etddoubleuserinfo_id_seq'::regclass);


--
-- Name: etdendoscope id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdendoscope ALTER COLUMN id SET DEFAULT nextval('public.etdendoscope_id_seq'::regclass);


--
-- Name: etdminicyclephaseinterrupttype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdminicyclephaseinterrupttype ALTER COLUMN id SET DEFAULT nextval('public.etdminicyclephaseinterrupttype_id_seq'::regclass);


--
-- Name: etdminicyclephasetype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdminicyclephasetype ALTER COLUMN id SET DEFAULT nextval('public.etdminicyclephasetype_id_seq'::regclass);


--
-- Name: etdminiprobedata id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdminiprobedata ALTER COLUMN id SET DEFAULT nextval('public.etdminiprobedata_id_seq'::regclass);


--
-- Name: etdminiprocessdata id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdminiprocessdata ALTER COLUMN id SET DEFAULT nextval('public.etdminiprocessdata_id_seq'::regclass);


--
-- Name: etdminiprotocoltype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdminiprotocoltype ALTER COLUMN id SET DEFAULT nextval('public.etdminiprotocoltype_id_seq'::regclass);


--
-- Name: etdminireprocessingprotocol id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdminireprocessingprotocol ALTER COLUMN id SET DEFAULT nextval('public.etdminireprocessingprotocol_id_seq'::regclass);


--
-- Name: etduser id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etduser ALTER COLUMN id SET DEFAULT nextval('public.etduser_id_seq'::regclass);


--
-- Name: etdv3reprocessingprotocol id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdv3reprocessingprotocol ALTER COLUMN id SET DEFAULT nextval('public.etdv3reprocessingprotocol_id_seq'::regclass);


--
-- Name: etdv3reprocessingprotocoltype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdv3reprocessingprotocoltype ALTER COLUMN id SET DEFAULT nextval('public.etdv3reprocessingprotocoltype_id_seq'::regclass);


--
-- Name: exportfilehistory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exportfilehistory ALTER COLUMN id SET DEFAULT nextval('public.exportfilehistory_id_seq'::regclass);


--
-- Name: flow_batch id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flow_batch ALTER COLUMN id SET DEFAULT nextval('public.flow_batch_id_seq'::regclass);


--
-- Name: flow_statistics id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flow_statistics ALTER COLUMN id SET DEFAULT nextval('public.flow_statistics_id_seq'::regclass);


--
-- Name: hsttversion id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hsttversion ALTER COLUMN id SET DEFAULT nextval('public.hsttversion_id_seq'::regclass);


--
-- Name: identifier id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identifier ALTER COLUMN id SET DEFAULT nextval('public.identifier_id_seq'::regclass);


--
-- Name: identifiertype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identifiertype ALTER COLUMN id SET DEFAULT nextval('public.identifiertype_id_seq'::regclass);


--
-- Name: knownpeer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.knownpeer ALTER COLUMN id SET DEFAULT nextval('public.knownpeer_id_seq'::regclass);


--
-- Name: license id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.license ALTER COLUMN id SET DEFAULT nextval('public.license_id_seq'::regclass);


--
-- Name: license appliedonsystemid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.license ALTER COLUMN appliedonsystemid SET DEFAULT nextval('public.license_appliedonsystemid_seq'::regclass);


--
-- Name: logbook id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logbook ALTER COLUMN id SET DEFAULT nextval('public.logbook_id_seq'::regclass);


--
-- Name: logbook_has_attachment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logbook_has_attachment ALTER COLUMN id SET DEFAULT nextval('public.logbook_has_attachment_id_seq'::regclass);


--
-- Name: logbookcategory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logbookcategory ALTER COLUMN id SET DEFAULT nextval('public.logbooktype_id_seq'::regclass);


--
-- Name: logbookevent id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logbookevent ALTER COLUMN id SET DEFAULT nextval('public.logbookevent_id_seq'::regclass);


--
-- Name: logbookobjecttype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logbookobjecttype ALTER COLUMN id SET DEFAULT nextval('public.logbookobjecttype_id_seq'::regclass);


--
-- Name: logbooksource id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logbooksource ALTER COLUMN id SET DEFAULT nextval('public.logbooksource_id_seq'::regclass);


--
-- Name: manualprotocol id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manualprotocol ALTER COLUMN id SET DEFAULT nextval('public.manualprotocol_id_seq'::regclass);


--
-- Name: manualprotocolitem id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manualprotocolitem ALTER COLUMN id SET DEFAULT nextval('public.manualprotocolitem_id_seq'::regclass);


--
-- Name: manufacturer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manufacturer ALTER COLUMN id SET DEFAULT nextval('public.manufacturer_id_seq'::regclass);


--
-- Name: printsettings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.printsettings ALTER COLUMN id SET DEFAULT nextval('public.printsettings_id_seq'::regclass);


--
-- Name: procedure id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.procedure ALTER COLUMN id SET DEFAULT nextval('public.procedure_id_seq'::regclass);


--
-- Name: proceduretype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proceduretype ALTER COLUMN id SET DEFAULT nextval('public.proceduretype_id_seq'::regclass);


--
-- Name: profil id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profil ALTER COLUMN id SET DEFAULT nextval('public.profil_id_seq'::regclass);


--
-- Name: protocol id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol ALTER COLUMN id SET DEFAULT nextval('public.protocol_id_seq'::regclass);


--
-- Name: reprocessingconstraint id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingconstraint ALTER COLUMN id SET DEFAULT nextval('public.reprocessingconstraint_id_seq'::regclass);


--
-- Name: reprocessingdevice id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingdevice ALTER COLUMN id SET DEFAULT nextval('public.reprocessingdevice_id_seq'::regclass);


--
-- Name: reprocessingdevice_has_department id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingdevice_has_department ALTER COLUMN id SET DEFAULT nextval('public.reprocessingdevice_has_department_id_seq'::regclass);


--
-- Name: reprocessingdevice_has_identifier id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingdevice_has_identifier ALTER COLUMN id SET DEFAULT nextval('public.reprocessingdevice_has_identifier_id_seq'::regclass);


--
-- Name: reprocessingdevice_has_task id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingdevice_has_task ALTER COLUMN id SET DEFAULT nextval('public.reprocessingdevice_has_task_id_seq'::regclass);


--
-- Name: reprocessinghistoryitem id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessinghistoryitem ALTER COLUMN id SET DEFAULT nextval('public.reprocessinghistoryitem_id_seq'::regclass);


--
-- Name: reprocessinghistoryitem_has_department id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessinghistoryitem_has_department ALTER COLUMN id SET DEFAULT nextval('public.reprocessinghistoryitem_has_department_id_seq'::regclass);


--
-- Name: reprocessinghistoryitem_profil idprofile_reprocessinghistoryitem; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessinghistoryitem_profil ALTER COLUMN idprofile_reprocessinghistoryitem SET DEFAULT nextval('public.reprocessinghistoryitem_profi_idprofile_reprocessinghistory_seq'::regclass);


--
-- Name: reprocessinghistoryitemeventtype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessinghistoryitemeventtype ALTER COLUMN id SET DEFAULT nextval('public.reprocessinghistoryitemeventtype_id_seq'::regclass);


--
-- Name: reprocessinginstruction id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessinginstruction ALTER COLUMN id SET DEFAULT nextval('public.reprocessinginstruction_id_seq'::regclass);


--
-- Name: reprocessingstation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingstation ALTER COLUMN id SET DEFAULT nextval('public.reprocessingstation_id_seq'::regclass);


--
-- Name: reprocessingstation_has_attachment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingstation_has_attachment ALTER COLUMN id SET DEFAULT nextval('public.reprocessingstation_has_attachment_id_seq'::regclass);


--
-- Name: reprocessingstatus id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingstatus ALTER COLUMN id SET DEFAULT nextval('public.reprocessingstatus_id_seq'::regclass);


--
-- Name: setting id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.setting ALTER COLUMN id SET DEFAULT nextval('public.setting_id_seq'::regclass);


--
-- Name: synchronizestatus id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.synchronizestatus ALTER COLUMN id SET DEFAULT nextval('public.synchronizestatus_id_seq'::regclass);


--
-- Name: task id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task ALTER COLUMN id SET DEFAULT nextval('public.task_id_seq'::regclass);


--
-- Name: user_has_department id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_has_department ALTER COLUMN id SET DEFAULT nextval('public.user_has_department_id_seq'::regclass);


--
-- Name: user_has_identifier id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_has_identifier ALTER COLUMN id SET DEFAULT nextval('public.user_has_identifier_id_seq'::regclass);


--
-- Name: useraccount id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.useraccount ALTER COLUMN id SET DEFAULT nextval('public.useraccount_id_seq'::regclass);


--
-- Name: useraccount_has_userdevicelevelgroup id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.useraccount_has_userdevicelevelgroup ALTER COLUMN id SET DEFAULT nextval('public.useraccount_has_userdevicelevelgroup_id_seq'::regclass);


--
-- Name: useraccount_has_usergroup id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.useraccount_has_usergroup ALTER COLUMN id SET DEFAULT nextval('public.useraccount_has_usergroup_id_seq'::regclass);


--
-- Name: userdevicelevelgroup id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userdevicelevelgroup ALTER COLUMN id SET DEFAULT nextval('public.userdevicelevelgroup_id_seq'::regclass);


--
-- Name: usergroup id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usergroup ALTER COLUMN id SET DEFAULT nextval('public.usergroup_id_seq'::regclass);


--
-- Name: usergroup_has_userrole id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usergroup_has_userrole ALTER COLUMN id SET DEFAULT nextval('public.usergroup_has_userrole_id_seq'::regclass);


--
-- Name: userrole id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userrole ALTER COLUMN id SET DEFAULT nextval('public.userrole_id_seq'::regclass);


--
-- Name: p_deviceuseretd5 p_deviceuseretd5_pkey; Type: CONSTRAINT; Schema: private; Owner: postgres
--

ALTER TABLE ONLY private.p_deviceuseretd5
    ADD CONSTRAINT p_deviceuseretd5_pkey PRIMARY KEY (useraccount_id);


--
-- Name: p_logbook p_logbook_pkey; Type: CONSTRAINT; Schema: private; Owner: postgres
--

ALTER TABLE ONLY private.p_logbook
    ADD CONSTRAINT p_logbook_pkey PRIMARY KEY (logbook_id);


--
-- Name: p_person p_person_pkey; Type: CONSTRAINT; Schema: private; Owner: postgres
--

ALTER TABLE ONLY private.p_person
    ADD CONSTRAINT p_person_pkey PRIMARY KEY (useraccount_id);


--
-- Name: actionreason actionreason_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actionreason
    ADD CONSTRAINT actionreason_pkey PRIMARY KEY (id);


--
-- Name: attachment attachment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attachment
    ADD CONSTRAINT attachment_pkey PRIMARY KEY (id);


--
-- Name: batch_has_endoscope batch_has_endoscope_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.batch_has_endoscope
    ADD CONSTRAINT batch_has_endoscope_pkey PRIMARY KEY (batch_id, endoscope_id);


--
-- Name: batch batch_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.batch
    ADD CONSTRAINT batch_pkey PRIMARY KEY (id);


--
-- Name: checklist checklist_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checklist
    ADD CONSTRAINT checklist_pkey PRIMARY KEY (id);


--
-- Name: checklistitem_has_attachment checklistitem_has_attachment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checklistitem_has_attachment
    ADD CONSTRAINT checklistitem_has_attachment_pkey PRIMARY KEY (id);


--
-- Name: checklistitem checklistitem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checklistitem
    ADD CONSTRAINT checklistitem_pkey PRIMARY KEY (id, checklist_id);


--
-- Name: chemicalstype chemicalstype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chemicalstype
    ADD CONSTRAINT chemicalstype_pkey PRIMARY KEY (id);


--
-- Name: confirmationprotocol confirmationprotocol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.confirmationprotocol
    ADD CONSTRAINT confirmationprotocol_pkey PRIMARY KEY (id);


--
-- Name: connectionstatus connectionstatus_connectionstate_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.connectionstatus
    ADD CONSTRAINT connectionstatus_connectionstate_key UNIQUE (connectionstate);


--
-- Name: connectionstatus connectionstatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.connectionstatus
    ADD CONSTRAINT connectionstatus_pkey PRIMARY KEY (id);


--
-- Name: contamination contamination_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contamination
    ADD CONSTRAINT contamination_pkey PRIMARY KEY (id);


--
-- Name: currentdata currentdata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.currentdata
    ADD CONSTRAINT currentdata_pkey PRIMARY KEY (reprocessingdevice_id);


--
-- Name: cycle cycle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cycle
    ADD CONSTRAINT cycle_pkey PRIMARY KEY (id);


--
-- Name: cyclefinishedreason cyclefinishedreason_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cyclefinishedreason
    ADD CONSTRAINT cyclefinishedreason_pkey PRIMARY KEY (id);


--
-- Name: cyclelog cyclelog_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cyclelog
    ADD CONSTRAINT cyclelog_pkey PRIMARY KEY (id);


--
-- Name: cyclestate cyclestate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cyclestate
    ADD CONSTRAINT cyclestate_pkey PRIMARY KEY (id);


--
-- Name: cyclestationinfo cyclestationinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cyclestationinfo
    ADD CONSTRAINT cyclestationinfo_pkey PRIMARY KEY (id);


--
-- Name: cyclestationstate cyclestationstate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cyclestationstate
    ADD CONSTRAINT cyclestationstate_pkey PRIMARY KEY (id);


--
-- Name: cyclestep cyclestep_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cyclestep
    ADD CONSTRAINT cyclestep_pkey PRIMARY KEY (id);


--
-- Name: cyclestependstate cyclestependstate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cyclestependstate
    ADD CONSTRAINT cyclestependstate_pkey PRIMARY KEY (id);


--
-- Name: cyclestepqueue cyclestepqueue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cyclestepqueue
    ADD CONSTRAINT cyclestepqueue_pkey PRIMARY KEY (id);


--
-- Name: department_endoscopetype_instruction department_endoscopetype_instruction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department_endoscopetype_instruction
    ADD CONSTRAINT department_endoscopetype_instruction_pkey PRIMARY KEY (id);


--
-- Name: department department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (id);


--
-- Name: deviceuseredc deviceuseredc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deviceuseredc
    ADD CONSTRAINT deviceuseredc_pkey PRIMARY KEY (useraccount_id);


--
-- Name: deviceuseretd34 deviceuseretd34_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deviceuseretd34
    ADD CONSTRAINT deviceuseretd34_pkey PRIMARY KEY (useraccount_id);


--
-- Name: deviceuseretddouble deviceuseretddouble_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deviceuseretddouble
    ADD CONSTRAINT deviceuseretddouble_pkey PRIMARY KEY (useraccount_id);


--
-- Name: edcadaptergroup edcadaptergroup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edcadaptergroup
    ADD CONSTRAINT edcadaptergroup_pkey PRIMARY KEY (id);


--
-- Name: edcconfig edcconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edcconfig
    ADD CONSTRAINT edcconfig_pkey PRIMARY KEY (reprocessingdevice_id);


--
-- Name: edcreprocessingprotocol edcreprocessingprotocol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edcreprocessingprotocol
    ADD CONSTRAINT edcreprocessingprotocol_pkey PRIMARY KEY (id);


--
-- Name: endoscan_has_reprocessingdevice endoscan_has_reprocessingdevice_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscan_has_reprocessingdevice
    ADD CONSTRAINT endoscan_has_reprocessingdevice_pkey PRIMARY KEY (endoscan_id, reprocessingdevice_id);


--
-- Name: endoscanconfig endoscanconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscanconfig
    ADD CONSTRAINT endoscanconfig_pkey PRIMARY KEY (reprocessingdevice_id);


--
-- Name: endoscope_has_department endoscope_has_department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscope_has_department
    ADD CONSTRAINT endoscope_has_department_pkey PRIMARY KEY (id);


--
-- Name: endoscope_has_identifier endoscope_has_identifier_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscope_has_identifier
    ADD CONSTRAINT endoscope_has_identifier_pkey PRIMARY KEY (id);


--
-- Name: endoscope_has_logbook endoscope_has_logbook_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscope_has_logbook
    ADD CONSTRAINT endoscope_has_logbook_pkey PRIMARY KEY (endoscope_id, logbook_id);


--
-- Name: endoscope_has_reprocessighistoryitems endoscope_has_reprocessighistoryitems_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscope_has_reprocessighistoryitems
    ADD CONSTRAINT endoscope_has_reprocessighistoryitems_pkey PRIMARY KEY (id);


--
-- Name: endoscope_has_task endoscope_has_task_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscope_has_task
    ADD CONSTRAINT endoscope_has_task_pkey PRIMARY KEY (id);


--
-- Name: endoscope endoscope_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscope
    ADD CONSTRAINT endoscope_pkey PRIMARY KEY (id);


--
-- Name: endoscopedashboardconfig endoscopedashboardconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopedashboardconfig
    ADD CONSTRAINT endoscopedashboardconfig_pkey PRIMARY KEY (id);


--
-- Name: endoscopelocation endoscopelocation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopelocation
    ADD CONSTRAINT endoscopelocation_pkey PRIMARY KEY (id);


--
-- Name: endoscopereprocessingstatus endoscopereprocessingstatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopereprocessingstatus
    ADD CONSTRAINT endoscopereprocessingstatus_pkey PRIMARY KEY (endoscope_id);


--
-- Name: endoscopetype_has_etd5referencetype endoscopetype_has_etd5referencetype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopetype_has_etd5referencetype
    ADD CONSTRAINT endoscopetype_has_etd5referencetype_pkey PRIMARY KEY (id);


--
-- Name: endoscopetype_has_etddoublereferencetype endoscopetype_has_etddoublereferencetype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopetype_has_etddoublereferencetype
    ADD CONSTRAINT endoscopetype_has_etddoublereferencetype_pkey PRIMARY KEY (id);


--
-- Name: endoscopetype_has_logbook endoscopetype_has_logbook_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopetype_has_logbook
    ADD CONSTRAINT endoscopetype_has_logbook_pkey PRIMARY KEY (endoscopetype_id, logbook_id);


--
-- Name: endoscopetype_has_proceduretype endoscopetype_has_proceduretype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopetype_has_proceduretype
    ADD CONSTRAINT endoscopetype_has_proceduretype_pkey PRIMARY KEY (id);


--
-- Name: endoscopetype_has_reprocessingdevicetype endoscopetype_has_reprocessingdevicetype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopetype_has_reprocessingdevicetype
    ADD CONSTRAINT endoscopetype_has_reprocessingdevicetype_pkey PRIMARY KEY (endoscopetype_id, reprocessingdevicetype_id, mappinggroup_id);


--
-- Name: endoscopetype_has_task endoscopetype_has_task_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopetype_has_task
    ADD CONSTRAINT endoscopetype_has_task_pkey PRIMARY KEY (id);


--
-- Name: endoscopetype endoscopetype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopetype
    ADD CONSTRAINT endoscopetype_pkey PRIMARY KEY (id);


--
-- Name: etd5blockinfo etd5blockinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5blockinfo
    ADD CONSTRAINT etd5blockinfo_pkey PRIMARY KEY (id);


--
-- Name: etd5config etd5config_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5config
    ADD CONSTRAINT etd5config_pkey PRIMARY KEY (reprocessingdevice_id);


--
-- Name: etd5dosageinfo etd5dosageinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5dosageinfo
    ADD CONSTRAINT etd5dosageinfo_pkey PRIMARY KEY (id);


--
-- Name: etd5endoscope etd5endoscope_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5endoscope
    ADD CONSTRAINT etd5endoscope_pkey PRIMARY KEY (id);


--
-- Name: etd5endoscopeinfo etd5endoscopeinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5endoscopeinfo
    ADD CONSTRAINT etd5endoscopeinfo_pkey PRIMARY KEY (id);


--
-- Name: etd5endoscopetype etd5endoscopetype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5endoscopetype
    ADD CONSTRAINT etd5endoscopetype_pkey PRIMARY KEY (id);


--
-- Name: etd5errorprotocol etd5errorprotocol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5errorprotocol
    ADD CONSTRAINT etd5errorprotocol_pkey PRIMARY KEY (id);


--
-- Name: etd5machineinfo etd5machineinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5machineinfo
    ADD CONSTRAINT etd5machineinfo_pkey PRIMARY KEY (reprocessingdevice_id);


--
-- Name: etd5maschinevariant etd5maschinevariant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5maschinevariant
    ADD CONSTRAINT etd5maschinevariant_pkey PRIMARY KEY (id);


--
-- Name: etd5message etd5message_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5message
    ADD CONSTRAINT etd5message_pkey PRIMARY KEY (id);


--
-- Name: etd5pressure etd5pressure_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5pressure
    ADD CONSTRAINT etd5pressure_pkey PRIMARY KEY (id);


--
-- Name: etd5processdatadetailed etd5processdatadetailed_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5processdatadetailed
    ADD CONSTRAINT etd5processdatadetailed_pkey PRIMARY KEY (id);


--
-- Name: etd5referencetypeitem etd5referencetypeitem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5referencetypeitem
    ADD CONSTRAINT etd5referencetypeitem_pkey PRIMARY KEY (id);


--
-- Name: etd5referencetypelist etd5referencetypelist_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5referencetypelist
    ADD CONSTRAINT etd5referencetypelist_pkey PRIMARY KEY (id);


--
-- Name: etd5reprocessingprotocol etd5reprocessingprotocol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5reprocessingprotocol
    ADD CONSTRAINT etd5reprocessingprotocol_pkey PRIMARY KEY (id);


--
-- Name: etd5rotation etd5rotation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5rotation
    ADD CONSTRAINT etd5rotation_pkey PRIMARY KEY (id);


--
-- Name: etd5user etd5user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5user
    ADD CONSTRAINT etd5user_pkey PRIMARY KEY (id);


--
-- Name: etd5userinfo etd5userinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5userinfo
    ADD CONSTRAINT etd5userinfo_pkey PRIMARY KEY (id);


--
-- Name: etdbasicprocessdata etdbasicprocessdata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdbasicprocessdata
    ADD CONSTRAINT etdbasicprocessdata_pkey PRIMARY KEY (id);


--
-- Name: etdconfig etdconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdconfig
    ADD CONSTRAINT etdconfig_pkey PRIMARY KEY (reprocessingdevice_id);


--
-- Name: etddconfig etddconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddconfig
    ADD CONSTRAINT etddconfig_pkey PRIMARY KEY (reprocessingdevice_id);


--
-- Name: etddoubleapcinfo etddoubleapcinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoubleapcinfo
    ADD CONSTRAINT etddoubleapcinfo_pkey PRIMARY KEY (id);


--
-- Name: etddoubleblockinfo etddoubleblockinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoubleblockinfo
    ADD CONSTRAINT etddoubleblockinfo_pkey PRIMARY KEY (id);


--
-- Name: etddoubledosinginfo etddoubledosinginfo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoubledosinginfo
    ADD CONSTRAINT etddoubledosinginfo_pkey PRIMARY KEY (id);


--
-- Name: etddoubleendoscope_has_endoscope etddoubleendoscope_has_endoscope_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoubleendoscope_has_endoscope
    ADD CONSTRAINT etddoubleendoscope_has_endoscope_pkey PRIMARY KEY (etddoubleendoscope_id, endoscope_id);


--
-- Name: etddoubleendoscope etddoubleendoscope_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoubleendoscope
    ADD CONSTRAINT etddoubleendoscope_pkey PRIMARY KEY (id);


--
-- Name: etddoubleendoscopeinfo etddoubleendoscopeinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoubleendoscopeinfo
    ADD CONSTRAINT etddoubleendoscopeinfo_pkey PRIMARY KEY (id);


--
-- Name: etddoubleerrorprotocol etddoubleerrorprotocol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoubleerrorprotocol
    ADD CONSTRAINT etddoubleerrorprotocol_pkey PRIMARY KEY (id);


--
-- Name: etddoublepressure etddoublepressure_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoublepressure
    ADD CONSTRAINT etddoublepressure_pkey PRIMARY KEY (id);


--
-- Name: etddoubleprocessdata etddoubleprocessdata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoubleprocessdata
    ADD CONSTRAINT etddoubleprocessdata_pkey PRIMARY KEY (id);


--
-- Name: etddoublereferencetypeitem etddoublereferencetypeitem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoublereferencetypeitem
    ADD CONSTRAINT etddoublereferencetypeitem_pkey PRIMARY KEY (id);


--
-- Name: etddoublereferencetypelist etddoublereferencetypelist_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoublereferencetypelist
    ADD CONSTRAINT etddoublereferencetypelist_pkey PRIMARY KEY (id);


--
-- Name: etddoublereprocessingprotocol etddoublereprocessingprotocol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoublereprocessingprotocol
    ADD CONSTRAINT etddoublereprocessingprotocol_pkey PRIMARY KEY (id);


--
-- Name: etddoublerotation etddoublerotation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoublerotation
    ADD CONSTRAINT etddoublerotation_pkey PRIMARY KEY (id);


--
-- Name: etddoubleuser_has_useraccount etddoubleuser_has_useraccount_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoubleuser_has_useraccount
    ADD CONSTRAINT etddoubleuser_has_useraccount_pkey PRIMARY KEY (etddoubleuser_id, useraccount_id);


--
-- Name: etddoubleuser etddoubleuser_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoubleuser
    ADD CONSTRAINT etddoubleuser_pkey PRIMARY KEY (id);


--
-- Name: etddoubleuserinfo etddoubleuserinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoubleuserinfo
    ADD CONSTRAINT etddoubleuserinfo_pkey PRIMARY KEY (id);


--
-- Name: etdendoscope etdendoscope_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdendoscope
    ADD CONSTRAINT etdendoscope_pkey PRIMARY KEY (id);


--
-- Name: etdminiconfig etdminiconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdminiconfig
    ADD CONSTRAINT etdminiconfig_pkey PRIMARY KEY (reprocessingdevice_id);


--
-- Name: etdminicyclephaseinterrupttype etdminicyclephaseinterrupttype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdminicyclephaseinterrupttype
    ADD CONSTRAINT etdminicyclephaseinterrupttype_pkey PRIMARY KEY (id);


--
-- Name: etdminicyclephasetype etdminicyclephasetype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdminicyclephasetype
    ADD CONSTRAINT etdminicyclephasetype_pkey PRIMARY KEY (id);


--
-- Name: etdminiprobedata etdminiprobedata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdminiprobedata
    ADD CONSTRAINT etdminiprobedata_pkey PRIMARY KEY (id);


--
-- Name: etdminiprocessdata etdminiprocessdata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdminiprocessdata
    ADD CONSTRAINT etdminiprocessdata_pkey PRIMARY KEY (id);


--
-- Name: etdminiprotocoltype etdminiprotocoltype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdminiprotocoltype
    ADD CONSTRAINT etdminiprotocoltype_pkey PRIMARY KEY (id);


--
-- Name: etdminireprocessingprotocol etdminireprocessingprotocol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdminireprocessingprotocol
    ADD CONSTRAINT etdminireprocessingprotocol_pkey PRIMARY KEY (id);


--
-- Name: etdplusconfig etdplusconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdplusconfig
    ADD CONSTRAINT etdplusconfig_pkey PRIMARY KEY (reprocessingdevice_id);


--
-- Name: etduser etduser_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etduser
    ADD CONSTRAINT etduser_pkey PRIMARY KEY (id);


--
-- Name: etdv3reprocessingprotocol etdv3reprocessingprotocol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdv3reprocessingprotocol
    ADD CONSTRAINT etdv3reprocessingprotocol_pkey PRIMARY KEY (id);


--
-- Name: etdv3reprocessingprotocoltype etdv3reprocessingprotocoltype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdv3reprocessingprotocoltype
    ADD CONSTRAINT etdv3reprocessingprotocoltype_pkey PRIMARY KEY (id);


--
-- Name: expansionunit expansionunit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expansionunit
    ADD CONSTRAINT expansionunit_pkey PRIMARY KEY (reprocessingdevice_id);


--
-- Name: exportfilehistory exportfilehistory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exportfilehistory
    ADD CONSTRAINT exportfilehistory_pkey PRIMARY KEY (id);


--
-- Name: flow_batch flow_batch_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flow_batch
    ADD CONSTRAINT flow_batch_pkey PRIMARY KEY (id);


--
-- Name: flow_statistics flow_statistics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flow_statistics
    ADD CONSTRAINT flow_statistics_pkey PRIMARY KEY (id);


--
-- Name: hsttversion hsttversion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hsttversion
    ADD CONSTRAINT hsttversion_pkey PRIMARY KEY (id);


--
-- Name: identifier_has_logbook identifier_has_logbook_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identifier_has_logbook
    ADD CONSTRAINT identifier_has_logbook_pkey PRIMARY KEY (identifier_id, logbook_id);


--
-- Name: identifier identifier_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identifier
    ADD CONSTRAINT identifier_pkey PRIMARY KEY (id);


--
-- Name: identifiertype_has_logbook identifiertype_has_logbook_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identifiertype_has_logbook
    ADD CONSTRAINT identifiertype_has_logbook_pkey PRIMARY KEY (identifiertype_id, logbook_id);


--
-- Name: identifiertype identifiertype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identifiertype
    ADD CONSTRAINT identifiertype_pkey PRIMARY KEY (id);


--
-- Name: identifiertype identifiertype_typename_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identifiertype
    ADD CONSTRAINT identifiertype_typename_key UNIQUE (typename);


--
-- Name: ifxversion ifxversion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ifxversion
    ADD CONSTRAINT ifxversion_pkey PRIMARY KEY (version);


--
-- Name: knownpeer knownpeer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.knownpeer
    ADD CONSTRAINT knownpeer_pkey PRIMARY KEY (id);


--
-- Name: license_has_logbook license_has_logbook_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.license_has_logbook
    ADD CONSTRAINT license_has_logbook_pkey PRIMARY KEY (license_id, logbook_id);


--
-- Name: license license_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.license
    ADD CONSTRAINT license_pkey PRIMARY KEY (id);


--
-- Name: logbook_has_attachment logbook_has_attachment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logbook_has_attachment
    ADD CONSTRAINT logbook_has_attachment_pkey PRIMARY KEY (id);


--
-- Name: logbook logbook_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logbook
    ADD CONSTRAINT logbook_pkey PRIMARY KEY (id);


--
-- Name: logbookevent logbookevent_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logbookevent
    ADD CONSTRAINT logbookevent_pkey PRIMARY KEY (id);


--
-- Name: logbookmessagetypeid logbookmessagetypeid_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logbookmessagetypeid
    ADD CONSTRAINT logbookmessagetypeid_pkey PRIMARY KEY (id);


--
-- Name: logbookobjecttype logbookobjecttype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logbookobjecttype
    ADD CONSTRAINT logbookobjecttype_pkey PRIMARY KEY (id);


--
-- Name: logbooksource logbooksource_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logbooksource
    ADD CONSTRAINT logbooksource_pkey PRIMARY KEY (id);


--
-- Name: logbookcategory logbooktype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logbookcategory
    ADD CONSTRAINT logbooktype_pkey PRIMARY KEY (id);


--
-- Name: manualprotocol manualprotocol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manualprotocol
    ADD CONSTRAINT manualprotocol_pkey PRIMARY KEY (id);


--
-- Name: manualprotocolitem manualprotocolitem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manualprotocolitem
    ADD CONSTRAINT manualprotocolitem_pkey PRIMARY KEY (id, manualprotocol_id);


--
-- Name: manufacturer manufacturer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manufacturer
    ADD CONSTRAINT manufacturer_pkey PRIMARY KEY (id);


--
-- Name: mappinggroup mappinggroup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mappinggroup
    ADD CONSTRAINT mappinggroup_pkey PRIMARY KEY (id);


--
-- Name: printsettings printsettings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.printsettings
    ADD CONSTRAINT printsettings_pkey PRIMARY KEY (id);


--
-- Name: procedure procedure_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.procedure
    ADD CONSTRAINT procedure_pkey PRIMARY KEY (id);


--
-- Name: proceduretype_has_logbook proceduretype_has_logbook_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proceduretype_has_logbook
    ADD CONSTRAINT proceduretype_has_logbook_pkey PRIMARY KEY (proceduretype_id, logbook_id);


--
-- Name: proceduretype proceduretype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proceduretype
    ADD CONSTRAINT proceduretype_pkey PRIMARY KEY (id);


--
-- Name: profil profil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profil
    ADD CONSTRAINT profil_pkey PRIMARY KEY (id);


--
-- Name: protocol protocol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol
    ADD CONSTRAINT protocol_pkey PRIMARY KEY (id);


--
-- Name: reprocessingdevicetype reporcessingdevicetype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingdevicetype
    ADD CONSTRAINT reporcessingdevicetype_pkey PRIMARY KEY (id);


--
-- Name: reprocessingconstraint reprocessingconstraint_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingconstraint
    ADD CONSTRAINT reprocessingconstraint_pkey PRIMARY KEY (id);


--
-- Name: reprocessingdevice_has_department reprocessingdevice_has_department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingdevice_has_department
    ADD CONSTRAINT reprocessingdevice_has_department_pkey PRIMARY KEY (id);


--
-- Name: reprocessingdevice_has_identifier reprocessingdevice_has_identifier_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingdevice_has_identifier
    ADD CONSTRAINT reprocessingdevice_has_identifier_pkey PRIMARY KEY (id);


--
-- Name: reprocessingdevice_has_logbook reprocessingdevice_has_logbook_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingdevice_has_logbook
    ADD CONSTRAINT reprocessingdevice_has_logbook_pkey PRIMARY KEY (reprocessingdevice_id, logbook_id);


--
-- Name: reprocessingdevice_has_task reprocessingdevice_has_task_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingdevice_has_task
    ADD CONSTRAINT reprocessingdevice_has_task_pkey PRIMARY KEY (id);


--
-- Name: reprocessingdevice reprocessingdevice_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingdevice
    ADD CONSTRAINT reprocessingdevice_pkey PRIMARY KEY (id);


--
-- Name: reprocessingdevicetype_has_identifiertype reprocessingdevicetype_has_identifiertype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingdevicetype_has_identifiertype
    ADD CONSTRAINT reprocessingdevicetype_has_identifiertype_pkey PRIMARY KEY (reprocessingdevicetype_id, identifiertype_id);


--
-- Name: reprocessinghistoryitem_has_department reprocessinghistoryitem_has_department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessinghistoryitem_has_department
    ADD CONSTRAINT reprocessinghistoryitem_has_department_pkey PRIMARY KEY (id);


--
-- Name: reprocessinghistoryitem reprocessinghistoryitem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessinghistoryitem
    ADD CONSTRAINT reprocessinghistoryitem_pkey PRIMARY KEY (id);


--
-- Name: reprocessinghistoryitem_profil reprocessinghistoryitem_profil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessinghistoryitem_profil
    ADD CONSTRAINT reprocessinghistoryitem_profil_pkey PRIMARY KEY (idprofile_reprocessinghistoryitem);


--
-- Name: reprocessinghistoryitemeventtype reprocessinghistoryitemeventtype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessinghistoryitemeventtype
    ADD CONSTRAINT reprocessinghistoryitemeventtype_pkey PRIMARY KEY (id);


--
-- Name: reprocessinginstruction_has_logbook reprocessinginstruction_has_logbook_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessinginstruction_has_logbook
    ADD CONSTRAINT reprocessinginstruction_has_logbook_pkey PRIMARY KEY (reprocessinginstruction_id, logbook_id);


--
-- Name: reprocessinginstruction reprocessinginstruction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessinginstruction
    ADD CONSTRAINT reprocessinginstruction_pkey PRIMARY KEY (id);


--
-- Name: reprocessingstation_has_attachment reprocessingstation_has_attachment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingstation_has_attachment
    ADD CONSTRAINT reprocessingstation_has_attachment_pkey PRIMARY KEY (id);


--
-- Name: reprocessingstation reprocessingstation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingstation
    ADD CONSTRAINT reprocessingstation_pkey PRIMARY KEY (id);


--
-- Name: reprocessingstatus reprocessingstatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingstatus
    ADD CONSTRAINT reprocessingstatus_pkey PRIMARY KEY (id);


--
-- Name: reprocessingstatus reprocessingstatus_reprocessingstate_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingstatus
    ADD CONSTRAINT reprocessingstatus_reprocessingstate_key UNIQUE (reprocessingstate);


--
-- Name: setting setting_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.setting
    ADD CONSTRAINT setting_pkey PRIMARY KEY (id);


--
-- Name: synchronizestatus synchronizestatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.synchronizestatus
    ADD CONSTRAINT synchronizestatus_pkey PRIMARY KEY (id);


--
-- Name: task task_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT task_pkey PRIMARY KEY (id);


--
-- Name: reprocessinghistoryitem_has_department unique_rhi_department; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessinghistoryitem_has_department
    ADD CONSTRAINT unique_rhi_department UNIQUE (reprocessinghistoryitem_id, department_id);


--
-- Name: user_has_department user_has_department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_has_department
    ADD CONSTRAINT user_has_department_pkey PRIMARY KEY (id);


--
-- Name: user_has_identifier user_has_identifier_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_has_identifier
    ADD CONSTRAINT user_has_identifier_pkey PRIMARY KEY (id);


--
-- Name: useraccount_has_logbook useraccount_has_logbook_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.useraccount_has_logbook
    ADD CONSTRAINT useraccount_has_logbook_pkey PRIMARY KEY (useraccount_id, logbook_id);


--
-- Name: useraccount_has_userdevicelevelgroup useraccount_has_userdevicelevelgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.useraccount_has_userdevicelevelgroup
    ADD CONSTRAINT useraccount_has_userdevicelevelgroup_pkey PRIMARY KEY (id);


--
-- Name: useraccount_has_usergroup useraccount_has_usergroup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.useraccount_has_usergroup
    ADD CONSTRAINT useraccount_has_usergroup_pkey PRIMARY KEY (id);


--
-- Name: useraccount useraccount_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.useraccount
    ADD CONSTRAINT useraccount_pkey PRIMARY KEY (id);


--
-- Name: userdevicelevelgroup_has_logbook userdevicelevelgroup_has_logbook_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userdevicelevelgroup_has_logbook
    ADD CONSTRAINT userdevicelevelgroup_has_logbook_pkey PRIMARY KEY (userdevicelevelgroup_id, logbook_id);


--
-- Name: userdevicelevelgroup userdevicelevelgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userdevicelevelgroup
    ADD CONSTRAINT userdevicelevelgroup_pkey PRIMARY KEY (id);


--
-- Name: usergroup_has_logbook usergroup_has_logbook_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usergroup_has_logbook
    ADD CONSTRAINT usergroup_has_logbook_pkey PRIMARY KEY (usergroup_id, logbook_id);


--
-- Name: usergroup_has_userrole usergroup_has_userrole_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usergroup_has_userrole
    ADD CONSTRAINT usergroup_has_userrole_pkey PRIMARY KEY (id);


--
-- Name: usergroup usergroup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usergroup
    ADD CONSTRAINT usergroup_pkey PRIMARY KEY (id);


--
-- Name: userrole userrole_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userrole
    ADD CONSTRAINT userrole_pkey PRIMARY KEY (id);


--
-- Name: batch_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX batch_fkindex1 ON public.batch USING btree (reprocessingdevice_id);


--
-- Name: batch_has_endoscope_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX batch_has_endoscope_fkindex1 ON public.batch_has_endoscope USING btree (batch_id);


--
-- Name: batch_has_endoscope_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX batch_has_endoscope_fkindex2 ON public.batch_has_endoscope USING btree (endoscope_id);


--
-- Name: checklist_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX checklist_fkindex1 ON public.checklist USING btree (reprocessingstation_id);


--
-- Name: checklistitem_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX checklistitem_fkindex1 ON public.checklistitem USING btree (checklist_id);


--
-- Name: checklistitem_has_attachment_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX checklistitem_has_attachment_fkindex1 ON public.checklistitem_has_attachment USING btree (checklistitem_id);


--
-- Name: checklistitem_has_attachment_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX checklistitem_has_attachment_fkindex2 ON public.checklistitem_has_attachment USING btree (attachment_id);


--
-- Name: confirmationprotocol_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX confirmationprotocol_fkindex1 ON public.confirmationprotocol USING btree (reprocessinghistoryitem_id);


--
-- Name: confirmationprotocol_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX confirmationprotocol_fkindex2 ON public.confirmationprotocol USING btree (reprocessingstation_id);


--
-- Name: contamination_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX contamination_fkindex1 ON public.contamination USING btree (reprocessinghistoryitem_id);


--
-- Name: cycle_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cycle_fkindex1 ON public.cycle USING btree (endoscope_id);


--
-- Name: cycle_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cycle_fkindex2 ON public.cycle USING btree (reprocessinginstruction_id);


--
-- Name: cyclestationinfo_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cyclestationinfo_fkindex1 ON public.cyclestationinfo USING btree (cycle_id);


--
-- Name: cyclestationinfo_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cyclestationinfo_fkindex2 ON public.cyclestationinfo USING btree (cyclestep_id);


--
-- Name: cyclestep_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cyclestep_fkindex1 ON public.cyclestep USING btree (cycle_id);


--
-- Name: cyclestep_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cyclestep_fkindex2 ON public.cyclestep USING btree (reprocessingstation_id);


--
-- Name: cyclestep_fkindex3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cyclestep_fkindex3 ON public.cyclestep USING btree (reprocessinghistoryitem_id);


--
-- Name: deviceuseredc_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX deviceuseredc_fkindex1 ON public.deviceuseredc USING btree (useraccount_id);


--
-- Name: deviceuseretd34_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX deviceuseretd34_fkindex1 ON public.deviceuseretd34 USING btree (useraccount_id);


--
-- Name: deviceuseretddouble_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX deviceuseretddouble_fkindex1 ON public.deviceuseretddouble USING btree (useraccount_id);


--
-- Name: edcadaptergroup_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX edcadaptergroup_fkindex1 ON public.edcadaptergroup USING btree (edcconfig_reprocessingdevice_id);


--
-- Name: edcconfig_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX edcconfig_fkindex1 ON public.edcconfig USING btree (reprocessingdevice_id);


--
-- Name: edcreprocessingprotocol_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX edcreprocessingprotocol_fkindex1 ON public.edcreprocessingprotocol USING btree (reprocessinghistoryitem_id);


--
-- Name: endoscan_has_reprocessingdevice_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX endoscan_has_reprocessingdevice_fkindex1 ON public.endoscan_has_reprocessingdevice USING btree (endoscan_id);


--
-- Name: endoscan_has_reprocessingdevice_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX endoscan_has_reprocessingdevice_fkindex2 ON public.endoscan_has_reprocessingdevice USING btree (reprocessingdevice_id);


--
-- Name: endoscanconfig_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX endoscanconfig_fkindex1 ON public.endoscanconfig USING btree (reprocessingdevice_id);


--
-- Name: endoscope_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX endoscope_fkindex1 ON public.endoscope USING btree (endoscopetype_id);


--
-- Name: endoscope_has_department_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX endoscope_has_department_fkindex1 ON public.endoscope_has_department USING btree (department_id);


--
-- Name: endoscope_has_department_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX endoscope_has_department_fkindex2 ON public.endoscope_has_department USING btree (endoscope_id);


--
-- Name: endoscope_has_logbook_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX endoscope_has_logbook_fkindex1 ON public.endoscope_has_logbook USING btree (endoscope_id);


--
-- Name: endoscope_has_logbook_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX endoscope_has_logbook_fkindex2 ON public.endoscope_has_logbook USING btree (logbook_id);


--
-- Name: endoscope_has_reprocessighistoryitems_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX endoscope_has_reprocessighistoryitems_fkindex1 ON public.endoscope_has_reprocessighistoryitems USING btree (reprocessinghistoryitem_id);


--
-- Name: endoscope_has_reprocessighistoryitems_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX endoscope_has_reprocessighistoryitems_fkindex2 ON public.endoscope_has_reprocessighistoryitems USING btree (endoscope_id);


--
-- Name: endoscope_has_task_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX endoscope_has_task_fkindex2 ON public.endoscope_has_task USING btree (endoscope_id);


--
-- Name: endoscope_identifier_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX endoscope_identifier_fkindex1 ON public.endoscope_has_identifier USING btree (endoscope_id);


--
-- Name: endoscope_identifier_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX endoscope_identifier_fkindex2 ON public.endoscope_has_identifier USING btree (identifier_id);


--
-- Name: endoscopereprocessingstatus_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX endoscopereprocessingstatus_fkindex1 ON public.endoscopereprocessingstatus USING btree (endoscope_id);


--
-- Name: endoscopetype_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX endoscopetype_fkindex1 ON public.endoscopetype USING btree (manufacturer_id);


--
-- Name: endoscopetype_has_logbook_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX endoscopetype_has_logbook_fkindex1 ON public.endoscopetype_has_logbook USING btree (endoscopetype_id);


--
-- Name: endoscopetype_has_logbook_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX endoscopetype_has_logbook_fkindex2 ON public.endoscopetype_has_logbook USING btree (logbook_id);


--
-- Name: endoscopetype_has_proceduretype_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX endoscopetype_has_proceduretype_fkindex1 ON public.endoscopetype_has_proceduretype USING btree (endoscopetype_id);


--
-- Name: endoscopetype_has_proceduretype_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX endoscopetype_has_proceduretype_fkindex2 ON public.endoscopetype_has_proceduretype USING btree (proceduretype_id);


--
-- Name: endoscopetype_has_reprocessingdevicetype_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX endoscopetype_has_reprocessingdevicetype_fkindex1 ON public.endoscopetype_has_reprocessingdevicetype USING btree (endoscopetype_id);


--
-- Name: endoscopetype_has_reprocessingdevicetype_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX endoscopetype_has_reprocessingdevicetype_fkindex2 ON public.endoscopetype_has_reprocessingdevicetype USING btree (reprocessingdevicetype_id);


--
-- Name: endoscopetype_has_task_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX endoscopetype_has_task_fkindex1 ON public.endoscopetype_has_task USING btree (endoscopetype_id);


--
-- Name: endoscopetype_has_task_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX endoscopetype_has_task_fkindex2 ON public.endoscopetype_has_task USING btree (task_id);


--
-- Name: etd5config_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX etd5config_fkindex1 ON public.etd5config USING btree (reprocessingdevice_id);


--
-- Name: etd5endoscope_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX etd5endoscope_fkindex1 ON public.etd5endoscope USING btree (currentdata_reprocessingdevice_id);


--
-- Name: etd5endoscope_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX etd5endoscope_fkindex2 ON public.etd5endoscope USING btree (endoscope_id);


--
-- Name: etd5endoscopeinfo_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX etd5endoscopeinfo_fkindex1 ON public.etd5endoscopeinfo USING btree (etd5reprocessingprotocol_id);


--
-- Name: etd5machineinfo_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX etd5machineinfo_fkindex1 ON public.etd5machineinfo USING btree (reprocessingdevice_id);


--
-- Name: etd5processdatadetailed_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX etd5processdatadetailed_fkindex1 ON public.etd5processdatadetailed USING btree (reprocessinghistoryitem_id);


--
-- Name: etd5user_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX etd5user_fkindex1 ON public.etd5user USING btree (currentdata_reprocessingdevice_id);


--
-- Name: etd5user_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX etd5user_fkindex2 ON public.etd5user USING btree (useraccount_id);


--
-- Name: etdbasicprocessdata_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX etdbasicprocessdata_fkindex1 ON public.etdbasicprocessdata USING btree (reprocessinghistoryitem_id);


--
-- Name: etdconfig_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX etdconfig_fkindex1 ON public.etdconfig USING btree (reprocessingdevice_id);


--
-- Name: etddconfig_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX etddconfig_fkindex2 ON public.etddconfig USING btree (reprocessingdevice_id);


--
-- Name: etddcurrentdata_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX etddcurrentdata_fkindex1 ON public.currentdata USING btree (reprocessingdevice_id);


--
-- Name: etddcurrentdata_fkindex4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX etddcurrentdata_fkindex4 ON public.currentdata USING btree (connectionstatus_id);


--
-- Name: etddoubleendoscope_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX etddoubleendoscope_fkindex1 ON public.etddoubleendoscope USING btree (currentdata_id);


--
-- Name: etddoubleendoscope_has_endoscope_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX etddoubleendoscope_has_endoscope_fkindex1 ON public.etddoubleendoscope_has_endoscope USING btree (etddoubleendoscope_id);


--
-- Name: etddoubleendoscope_has_endoscope_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX etddoubleendoscope_has_endoscope_fkindex2 ON public.etddoubleendoscope_has_endoscope USING btree (endoscope_id);


--
-- Name: etddoubleendoscopeinfo_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX etddoubleendoscopeinfo_fkindex1 ON public.etddoubleendoscopeinfo USING btree (etddoublereprocessingprotocol_id);


--
-- Name: etddoubleprocessdata_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX etddoubleprocessdata_fkindex1 ON public.etddoubleprocessdata USING btree (reprocessinghistoryitem_id);


--
-- Name: etddoublereprocessingprotocol_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX etddoublereprocessingprotocol_fkindex1 ON public.etddoublereprocessingprotocol USING btree (reprocessinghistoryitem_id);


--
-- Name: etddoublereprocessingprotocol_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX etddoublereprocessingprotocol_fkindex2 ON public.etddoublereprocessingprotocol USING btree (etddoubleuserinfostart_id);


--
-- Name: etddoublereprocessingprotocol_fkindex3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX etddoublereprocessingprotocol_fkindex3 ON public.etddoublereprocessingprotocol USING btree (etddoubleuserinfoend_id);


--
-- Name: etddoubleuser_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX etddoubleuser_fkindex1 ON public.etddoubleuser USING btree (currentdata_id);


--
-- Name: etddoubleuser_has_useraccount_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX etddoubleuser_has_useraccount_fkindex1 ON public.etddoubleuser_has_useraccount USING btree (etddoubleuser_id);


--
-- Name: etddoubleuser_has_useraccount_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX etddoubleuser_has_useraccount_fkindex2 ON public.etddoubleuser_has_useraccount USING btree (useraccount_id);


--
-- Name: etdendoscope_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX etdendoscope_fkindex1 ON public.etdendoscope USING btree (currentdata_reprocessingdevice_id);


--
-- Name: etdendoscope_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX etdendoscope_fkindex2 ON public.etdendoscope USING btree (endoscope_id);


--
-- Name: etdminiconfig_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX etdminiconfig_fkindex1 ON public.etdminiconfig USING btree (reprocessingdevice_id);


--
-- Name: etdminiprocessdata_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX etdminiprocessdata_fkindex1 ON public.etdminiprocessdata USING btree (reprocessinghistoryitem_id);


--
-- Name: etdminiprocessdata_reprocessinghistoryitem_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX etdminiprocessdata_reprocessinghistoryitem_id_idx ON public.etdminiprocessdata USING btree (reprocessinghistoryitem_id);


--
-- Name: etdminireprocessingprotocol_fk1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX etdminireprocessingprotocol_fk1 ON public.etdminireprocessingprotocol USING btree (reprocessinghistoryitem_id);


--
-- Name: etdplusconfig_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX etdplusconfig_fkindex1 ON public.etdplusconfig USING btree (reprocessingdevice_id);


--
-- Name: etduser_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX etduser_fkindex1 ON public.etduser USING btree (currentdata_reprocessingdevice_id);


--
-- Name: etduser_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX etduser_fkindex2 ON public.etduser USING btree (useraccount_id);


--
-- Name: etdv3reprocessingprotocol_fk1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX etdv3reprocessingprotocol_fk1 ON public.etdv3reprocessingprotocol USING btree (reprocessinghistoryitem_id);


--
-- Name: expansionunit_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX expansionunit_fkindex1 ON public.expansionunit USING btree (reprocessingdevice_id);


--
-- Name: exportfilehistory_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX exportfilehistory_fkindex1 ON public.exportfilehistory USING btree (reprocessinghistoryitem_id);


--
-- Name: identifier_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX identifier_fkindex1 ON public.identifier USING btree (identifiertype_id);


--
-- Name: identifier_has_logbook_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX identifier_has_logbook_fkindex1 ON public.identifier_has_logbook USING btree (identifier_id);


--
-- Name: identifier_has_logbook_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX identifier_has_logbook_fkindex2 ON public.identifier_has_logbook USING btree (logbook_id);


--
-- Name: identifiertype_has_logbook_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX identifiertype_has_logbook_fkindex1 ON public.identifiertype_has_logbook USING btree (identifiertype_id);


--
-- Name: identifiertype_has_logbook_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX identifiertype_has_logbook_fkindex2 ON public.identifiertype_has_logbook USING btree (logbook_id);


--
-- Name: idx_department_endoscopetype_instruction_dept; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_department_endoscopetype_instruction_dept ON public.department_endoscopetype_instruction USING btree (department_id);


--
-- Name: idx_department_endoscopetype_instruction_endo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_department_endoscopetype_instruction_endo ON public.department_endoscopetype_instruction USING btree (endoscopetype_id);


--
-- Name: idx_department_endoscopetype_instruction_instr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_department_endoscopetype_instruction_instr ON public.department_endoscopetype_instruction USING btree (reprocessinginstruction_id);


--
-- Name: idx_ehd_endo_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ehd_endo_time ON public.endoscope_has_department USING btree (endoscope_id, startdate, enddate, department_id);


--
-- Name: idx_ehrhi_rhi; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ehrhi_rhi ON public.endoscope_has_reprocessighistoryitems USING btree (reprocessinghistoryitem_id, endoscope_id);


--
-- Name: ifk_etddoubleproto_scopeinfo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ifk_etddoubleproto_scopeinfo ON public.etddoubleendoscopeinfo USING btree (etddoublereprocessingprotocol_id);


--
-- Name: ifk_rel_83; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ifk_rel_83 ON public.etddoublereprocessingprotocol USING btree (reprocessinghistoryitem_id);


--
-- Name: ifk_rel_85; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ifk_rel_85 ON public.etddoublereprocessingprotocol USING btree (etddoubleuserinfostart_id);


--
-- Name: ifk_rel_86; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ifk_rel_86 ON public.endoscope_has_reprocessighistoryitems USING btree (reprocessinghistoryitem_id);


--
-- Name: ifk_rel_87; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ifk_rel_87 ON public.endoscope_has_reprocessighistoryitems USING btree (endoscope_id);


--
-- Name: ifk_rel_88; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ifk_rel_88 ON public.edcreprocessingprotocol USING btree (reprocessinghistoryitem_id);


--
-- Name: ifk_rel_90; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ifk_rel_90 ON public.etddoublereprocessingprotocol USING btree (etddoubleuserinfoend_id);


--
-- Name: ifk_rel_91; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ifk_rel_91 ON public.etddoubleprocessdata USING btree (reprocessinghistoryitem_id);


--
-- Name: ifk_rel_92; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ifk_rel_92 ON public.etdbasicprocessdata USING btree (reprocessinghistoryitem_id);


--
-- Name: ifk_rel_edcconf_reprodevice; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ifk_rel_edcconf_reprodevice ON public.edcconfig USING btree (reprocessingdevice_id);


--
-- Name: ifk_rel_edcconfig_edcadapter; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ifk_rel_edcconfig_edcadapter ON public.edcadaptergroup USING btree (edcconfig_reprocessingdevice_id);


--
-- Name: ifk_rel_historyitem_eventtype; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ifk_rel_historyitem_eventtype ON public.reprocessinghistoryitem USING btree (reprocessinghistoryitemeventtype_id);


--
-- Name: ifk_rel_manualprotocol_item; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ifk_rel_manualprotocol_item ON public.manualprotocolitem USING btree (manualprotocol_id);


--
-- Name: license_has_logbook_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX license_has_logbook_fkindex1 ON public.license_has_logbook USING btree (license_id);


--
-- Name: license_has_logbook_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX license_has_logbook_fkindex2 ON public.license_has_logbook USING btree (logbook_id);


--
-- Name: logbook_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX logbook_fkindex1 ON public.logbook USING btree (logbookcategory_id);


--
-- Name: logbook_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX logbook_fkindex2 ON public.logbook USING btree (useraccount_id);


--
-- Name: logbook_fkindex3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX logbook_fkindex3 ON public.logbook USING btree (reprocessinghistoryitem_id);


--
-- Name: logbook_fkindex4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX logbook_fkindex4 ON public.logbook USING btree (reprocessingdevice_id);


--
-- Name: logbook_has_attachment_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX logbook_has_attachment_fkindex1 ON public.logbook_has_attachment USING btree (logbook_id);


--
-- Name: logbook_has_attachment_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX logbook_has_attachment_fkindex2 ON public.logbook_has_attachment USING btree (attachment_id);


--
-- Name: manualprotocol_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX manualprotocol_fkindex1 ON public.manualprotocol USING btree (reprocessinghistoryitem_id);


--
-- Name: manualprotocol_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX manualprotocol_fkindex2 ON public.manualprotocol USING btree (checklist_id);


--
-- Name: manualprotocolitem_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX manualprotocolitem_fkindex1 ON public.manualprotocolitem USING btree (manualprotocol_id);


--
-- Name: proceduretype_has_logbook_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX proceduretype_has_logbook_fkindex1 ON public.proceduretype_has_logbook USING btree (proceduretype_id);


--
-- Name: proceduretype_has_logbook_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX proceduretype_has_logbook_fkindex2 ON public.proceduretype_has_logbook USING btree (logbook_id);


--
-- Name: profile_reprocessinghistoryitem_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX profile_reprocessinghistoryitem_fkindex1 ON public.reprocessinghistoryitem_profil USING btree (profil_id);


--
-- Name: profile_reprocessinghistoryitem_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX profile_reprocessinghistoryitem_fkindex2 ON public.reprocessinghistoryitem_profil USING btree (reprocessinghistoryitem_id);


--
-- Name: protocol_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX protocol_fkindex1 ON public.protocol USING btree (reprocessingdevice_id);


--
-- Name: rel_checklistitem_checklist; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX rel_checklistitem_checklist ON public.checklistitem USING btree (checklist_id);


--
-- Name: rel_contamination_historyitem; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX rel_contamination_historyitem ON public.contamination USING btree (reprocessinghistoryitem_id);


--
-- Name: reprocessingconstraint_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reprocessingconstraint_fkindex1 ON public.reprocessingconstraint USING btree (reprocessinginstruction_id);


--
-- Name: reprocessingdevice_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reprocessingdevice_fkindex2 ON public.reprocessingdevice USING btree (printsettings_id);


--
-- Name: reprocessingdevice_has_department_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reprocessingdevice_has_department_fkindex1 ON public.reprocessingdevice_has_department USING btree (department_id);


--
-- Name: reprocessingdevice_has_department_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reprocessingdevice_has_department_fkindex2 ON public.reprocessingdevice_has_department USING btree (reprocessingdevice_id);


--
-- Name: reprocessingdevice_has_identifier_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reprocessingdevice_has_identifier_fkindex1 ON public.reprocessingdevice_has_identifier USING btree (identifier_id);


--
-- Name: reprocessingdevice_has_identifier_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reprocessingdevice_has_identifier_fkindex2 ON public.reprocessingdevice_has_identifier USING btree (reprocessingdevice_id);


--
-- Name: reprocessingdevice_has_logbook_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reprocessingdevice_has_logbook_fkindex1 ON public.reprocessingdevice_has_logbook USING btree (reprocessingdevice_id);


--
-- Name: reprocessingdevice_has_logbook_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reprocessingdevice_has_logbook_fkindex2 ON public.reprocessingdevice_has_logbook USING btree (logbook_id);


--
-- Name: reprocessingdevicetype_has_identifiertype_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reprocessingdevicetype_has_identifiertype_fkindex1 ON public.reprocessingdevicetype_has_identifiertype USING btree (reprocessingdevicetype_id);


--
-- Name: reprocessingdevicetype_has_identifiertype_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reprocessingdevicetype_has_identifiertype_fkindex2 ON public.reprocessingdevicetype_has_identifiertype USING btree (identifiertype_id);


--
-- Name: reprocessinghistoryitem_fkindex5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reprocessinghistoryitem_fkindex5 ON public.reprocessinghistoryitem USING btree (batch_id);


--
-- Name: reprocessinginstruction_has_logbook_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reprocessinginstruction_has_logbook_fkindex1 ON public.reprocessinginstruction_has_logbook USING btree (reprocessinginstruction_id);


--
-- Name: reprocessinginstruction_has_logbook_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reprocessinginstruction_has_logbook_fkindex2 ON public.reprocessinginstruction_has_logbook USING btree (logbook_id);


--
-- Name: reprocessingstation_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reprocessingstation_fkindex1 ON public.reprocessingstation USING btree (reprocessinginstruction_id);


--
-- Name: reprocessingstation_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reprocessingstation_fkindex2 ON public.reprocessingstation USING btree (profil_id);


--
-- Name: reprocessingstation_fkindex3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reprocessingstation_fkindex3 ON public.reprocessingstation USING btree (printsettings_id);


--
-- Name: reprocessingstation_has_attachment_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reprocessingstation_has_attachment_fkindex1 ON public.reprocessingstation_has_attachment USING btree (reprocessingstation_id);


--
-- Name: reprocessingstation_has_attachment_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reprocessingstation_has_attachment_fkindex2 ON public.reprocessingstation_has_attachment USING btree (attachment_id);


--
-- Name: setting_key_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX setting_key_unique ON public.setting USING btree (key);


--
-- Name: user_has_department_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_has_department_fkindex1 ON public.user_has_department USING btree (department_id);


--
-- Name: user_has_department_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_has_department_fkindex2 ON public.user_has_department USING btree (useraccount_id);


--
-- Name: user_has_identifier_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_has_identifier_fkindex1 ON public.user_has_identifier USING btree (identifier_id);


--
-- Name: user_has_identifier_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_has_identifier_fkindex2 ON public.user_has_identifier USING btree (useraccount_id);


--
-- Name: useraccount_has_logbook_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX useraccount_has_logbook_fkindex1 ON public.useraccount_has_logbook USING btree (useraccount_id);


--
-- Name: useraccount_has_logbook_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX useraccount_has_logbook_fkindex2 ON public.useraccount_has_logbook USING btree (logbook_id);


--
-- Name: useraccount_has_userdevicelevelgroup_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX useraccount_has_userdevicelevelgroup_fkindex1 ON public.useraccount_has_userdevicelevelgroup USING btree (useraccount_id);


--
-- Name: useraccount_has_userdevicelevelgroup_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX useraccount_has_userdevicelevelgroup_fkindex2 ON public.useraccount_has_userdevicelevelgroup USING btree (userdevicelevelgroup_id);


--
-- Name: useraccount_has_usergroup_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX useraccount_has_usergroup_fkindex1 ON public.useraccount_has_usergroup USING btree (useraccount_id);


--
-- Name: useraccount_has_usergroup_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX useraccount_has_usergroup_fkindex2 ON public.useraccount_has_usergroup USING btree (usergroup_id);


--
-- Name: userdevicelevelgroup_has_logbook_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX userdevicelevelgroup_has_logbook_fkindex1 ON public.userdevicelevelgroup_has_logbook USING btree (userdevicelevelgroup_id);


--
-- Name: userdevicelevelgroup_has_logbook_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX userdevicelevelgroup_has_logbook_fkindex2 ON public.userdevicelevelgroup_has_logbook USING btree (logbook_id);


--
-- Name: usergroup_has_logbook_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX usergroup_has_logbook_fkindex1 ON public.usergroup_has_logbook USING btree (usergroup_id);


--
-- Name: usergroup_has_logbook_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX usergroup_has_logbook_fkindex2 ON public.usergroup_has_logbook USING btree (logbook_id);


--
-- Name: usergroup_has_userrole_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX usergroup_has_userrole_fkindex1 ON public.usergroup_has_userrole USING btree (usergroup_id);


--
-- Name: usergroup_has_userrole_fkindex2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX usergroup_has_userrole_fkindex2 ON public.usergroup_has_userrole USING btree (userrole_id);


--
-- Name: p_deviceuseretd5 p_deviceuseretd5_useraccount_id_fkey; Type: FK CONSTRAINT; Schema: private; Owner: postgres
--

ALTER TABLE ONLY private.p_deviceuseretd5
    ADD CONSTRAINT p_deviceuseretd5_useraccount_id_fkey FOREIGN KEY (useraccount_id) REFERENCES public.useraccount(id);


--
-- Name: p_logbook p_logbook_logbook_id_fkey; Type: FK CONSTRAINT; Schema: private; Owner: postgres
--

ALTER TABLE ONLY private.p_logbook
    ADD CONSTRAINT p_logbook_logbook_id_fkey FOREIGN KEY (logbook_id) REFERENCES public.logbook(id);


--
-- Name: p_person p_person_useraccount_id_fkey; Type: FK CONSTRAINT; Schema: private; Owner: postgres
--

ALTER TABLE ONLY private.p_person
    ADD CONSTRAINT p_person_useraccount_id_fkey FOREIGN KEY (useraccount_id) REFERENCES public.useraccount(id);


--
-- Name: batch_has_endoscope batch_has_endoscope_batch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.batch_has_endoscope
    ADD CONSTRAINT batch_has_endoscope_batch_id_fkey FOREIGN KEY (batch_id) REFERENCES public.batch(id);


--
-- Name: batch_has_endoscope batch_has_endoscope_endoscope_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.batch_has_endoscope
    ADD CONSTRAINT batch_has_endoscope_endoscope_id_fkey FOREIGN KEY (endoscope_id) REFERENCES public.endoscope(id);


--
-- Name: batch batch_reprocessingdevice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.batch
    ADD CONSTRAINT batch_reprocessingdevice_id_fkey FOREIGN KEY (reprocessingdevice_id) REFERENCES public.reprocessingdevice(id);


--
-- Name: checklist checklist_reprocessingstation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checklist
    ADD CONSTRAINT checklist_reprocessingstation_id_fkey FOREIGN KEY (reprocessingstation_id) REFERENCES public.reprocessingstation(id);


--
-- Name: checklistitem checklistitem_checklist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checklistitem
    ADD CONSTRAINT checklistitem_checklist_id_fkey FOREIGN KEY (checklist_id) REFERENCES public.checklist(id);


--
-- Name: checklistitem_has_attachment checklistitem_has_attachment_attachment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checklistitem_has_attachment
    ADD CONSTRAINT checklistitem_has_attachment_attachment_id_fkey FOREIGN KEY (attachment_id) REFERENCES public.attachment(id);


--
-- Name: checklistitem_has_attachment checklistitem_has_attachment_checklistitem_id_checklistite_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checklistitem_has_attachment
    ADD CONSTRAINT checklistitem_has_attachment_checklistitem_id_checklistite_fkey FOREIGN KEY (checklistitem_id, checklistitem_checklist_id) REFERENCES public.checklistitem(id, checklist_id);


--
-- Name: confirmationprotocol confirmationprotocol_reprocessinghistoryitem_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.confirmationprotocol
    ADD CONSTRAINT confirmationprotocol_reprocessinghistoryitem_id_fkey FOREIGN KEY (reprocessinghistoryitem_id) REFERENCES public.reprocessinghistoryitem(id);


--
-- Name: confirmationprotocol confirmationprotocol_reprocessingstation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.confirmationprotocol
    ADD CONSTRAINT confirmationprotocol_reprocessingstation_id_fkey FOREIGN KEY (reprocessingstation_id) REFERENCES public.reprocessingstation(id);


--
-- Name: contamination contamination_reprocessinghistoryitem_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contamination
    ADD CONSTRAINT contamination_reprocessinghistoryitem_id_fkey FOREIGN KEY (reprocessinghistoryitem_id) REFERENCES public.reprocessinghistoryitem(id);


--
-- Name: currentdata currentdata_connectionstatus_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.currentdata
    ADD CONSTRAINT currentdata_connectionstatus_id_fkey FOREIGN KEY (connectionstatus_id) REFERENCES public.connectionstatus(id);


--
-- Name: currentdata currentdata_endoscopesynchstatus_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.currentdata
    ADD CONSTRAINT currentdata_endoscopesynchstatus_id_fkey FOREIGN KEY (endoscopesynchstatus_id) REFERENCES public.synchronizestatus(id);


--
-- Name: currentdata currentdata_reprocessingdevice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.currentdata
    ADD CONSTRAINT currentdata_reprocessingdevice_id_fkey FOREIGN KEY (reprocessingdevice_id) REFERENCES public.reprocessingdevice(id);


--
-- Name: currentdata currentdata_reprocessingstatus_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.currentdata
    ADD CONSTRAINT currentdata_reprocessingstatus_id_fkey FOREIGN KEY (reprocessingstatus_id) REFERENCES public.reprocessingstatus(id);


--
-- Name: currentdata currentdata_usersynchstatus_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.currentdata
    ADD CONSTRAINT currentdata_usersynchstatus_id_fkey FOREIGN KEY (usersynchstatus_id) REFERENCES public.synchronizestatus(id);


--
-- Name: cycle cycle_cyclefinishedreason_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cycle
    ADD CONSTRAINT cycle_cyclefinishedreason_id_fkey FOREIGN KEY (cyclefinishedreason_id) REFERENCES public.cyclefinishedreason(id);


--
-- Name: cycle cycle_cyclestate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cycle
    ADD CONSTRAINT cycle_cyclestate_id_fkey FOREIGN KEY (cyclestate_id) REFERENCES public.cyclestate(id);


--
-- Name: cycle cycle_endoscope_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cycle
    ADD CONSTRAINT cycle_endoscope_id_fkey FOREIGN KEY (endoscope_id) REFERENCES public.endoscope(id);


--
-- Name: cycle cycle_reprocessinginstruction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cycle
    ADD CONSTRAINT cycle_reprocessinginstruction_id_fkey FOREIGN KEY (reprocessinginstruction_id) REFERENCES public.reprocessinginstruction(id);


--
-- Name: cycle cycle_startcontamination_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cycle
    ADD CONSTRAINT cycle_startcontamination_id_fkey FOREIGN KEY (startcontamination_id) REFERENCES public.reprocessinghistoryitem(id);


--
-- Name: cycle cycle_startcyclestate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cycle
    ADD CONSTRAINT cycle_startcyclestate_id_fkey FOREIGN KEY (startcyclestate_id) REFERENCES public.cyclestate(id);


--
-- Name: cyclelog cyclelog_constraint_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cyclelog
    ADD CONSTRAINT cyclelog_constraint_id_fkey FOREIGN KEY (constraint_id) REFERENCES public.reprocessingconstraint(id);


--
-- Name: cyclelog cyclelog_cycle_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cyclelog
    ADD CONSTRAINT cyclelog_cycle_id_fkey FOREIGN KEY (cycle_id) REFERENCES public.cycle(id);


--
-- Name: cyclelog cyclelog_cyclestependstate_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cyclelog
    ADD CONSTRAINT cyclelog_cyclestependstate_fkey FOREIGN KEY (cyclestependstate) REFERENCES public.cyclestependstate(id);


--
-- Name: cyclelog cyclelog_endoscope_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cyclelog
    ADD CONSTRAINT cyclelog_endoscope_id_fkey FOREIGN KEY (endoscope_id) REFERENCES public.endoscope(id);


--
-- Name: cyclelog cyclelog_instruction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cyclelog
    ADD CONSTRAINT cyclelog_instruction_id_fkey FOREIGN KEY (instruction_id) REFERENCES public.reprocessinginstruction(id);


--
-- Name: cyclelog cyclelog_logbook_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cyclelog
    ADD CONSTRAINT cyclelog_logbook_id_fkey FOREIGN KEY (logbook_id) REFERENCES public.logbook(id);


--
-- Name: cyclelog cyclelog_protocol_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cyclelog
    ADD CONSTRAINT cyclelog_protocol_id_fkey FOREIGN KEY (protocol_id) REFERENCES public.reprocessinghistoryitem(id);


--
-- Name: cyclelog cyclelog_reprocessingdevice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cyclelog
    ADD CONSTRAINT cyclelog_reprocessingdevice_id_fkey FOREIGN KEY (reprocessingdevice_id) REFERENCES public.reprocessingdevice(id);


--
-- Name: cyclelog cyclelog_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cyclelog
    ADD CONSTRAINT cyclelog_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.useraccount(id);


--
-- Name: cyclestationinfo cyclestationinfo_cycle_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cyclestationinfo
    ADD CONSTRAINT cyclestationinfo_cycle_id_fkey FOREIGN KEY (cycle_id) REFERENCES public.cycle(id);


--
-- Name: cyclestationinfo cyclestationinfo_cyclestationstate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cyclestationinfo
    ADD CONSTRAINT cyclestationinfo_cyclestationstate_id_fkey FOREIGN KEY (cyclestationstate_id) REFERENCES public.cyclestationstate(id);


--
-- Name: cyclestationinfo cyclestationinfo_cyclestep_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cyclestationinfo
    ADD CONSTRAINT cyclestationinfo_cyclestep_id_fkey FOREIGN KEY (cyclestep_id) REFERENCES public.cyclestep(id);


--
-- Name: cyclestationinfo cyclestationinfo_reprocessingstation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cyclestationinfo
    ADD CONSTRAINT cyclestationinfo_reprocessingstation_id_fkey FOREIGN KEY (reprocessingstation_id) REFERENCES public.reprocessingstation(id);


--
-- Name: cyclestep cyclestep_cycle_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cyclestep
    ADD CONSTRAINT cyclestep_cycle_id_fkey FOREIGN KEY (cycle_id) REFERENCES public.cycle(id);


--
-- Name: cyclestep cyclestep_reprocessinghistoryitem_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cyclestep
    ADD CONSTRAINT cyclestep_reprocessinghistoryitem_id_fkey FOREIGN KEY (reprocessinghistoryitem_id) REFERENCES public.reprocessinghistoryitem(id);


--
-- Name: cyclestep cyclestep_reprocessingstation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cyclestep
    ADD CONSTRAINT cyclestep_reprocessingstation_id_fkey FOREIGN KEY (reprocessingstation_id) REFERENCES public.reprocessingstation(id);


--
-- Name: cyclestepqueue cyclestepqueue_endoscope_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cyclestepqueue
    ADD CONSTRAINT cyclestepqueue_endoscope_id_fkey FOREIGN KEY (endoscope_id) REFERENCES public.endoscope(id);


--
-- Name: cyclestepqueue cyclestepqueue_reprocessinghistoryitem_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cyclestepqueue
    ADD CONSTRAINT cyclestepqueue_reprocessinghistoryitem_id_fkey FOREIGN KEY (reprocessinghistoryitem_id) REFERENCES public.reprocessinghistoryitem(id);


--
-- Name: deviceuseredc deviceuseredc_useraccount_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deviceuseredc
    ADD CONSTRAINT deviceuseredc_useraccount_id_fkey FOREIGN KEY (useraccount_id) REFERENCES public.useraccount(id);


--
-- Name: deviceuseretd34 deviceuseretd34_useraccount_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deviceuseretd34
    ADD CONSTRAINT deviceuseretd34_useraccount_id_fkey FOREIGN KEY (useraccount_id) REFERENCES public.useraccount(id);


--
-- Name: deviceuseretddouble deviceuseretddouble_useraccount_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deviceuseretddouble
    ADD CONSTRAINT deviceuseretddouble_useraccount_id_fkey FOREIGN KEY (useraccount_id) REFERENCES public.useraccount(id);


--
-- Name: edcadaptergroup edcadaptergroup_edcconfig_reprocessingdevice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edcadaptergroup
    ADD CONSTRAINT edcadaptergroup_edcconfig_reprocessingdevice_id_fkey FOREIGN KEY (edcconfig_reprocessingdevice_id) REFERENCES public.edcconfig(reprocessingdevice_id);


--
-- Name: edcconfig edcconfig_reprocessingdevice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edcconfig
    ADD CONSTRAINT edcconfig_reprocessingdevice_id_fkey FOREIGN KEY (reprocessingdevice_id) REFERENCES public.reprocessingdevice(id);


--
-- Name: edcreprocessingprotocol edcreprocessingprotocol_reprocessinghistoryitem_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edcreprocessingprotocol
    ADD CONSTRAINT edcreprocessingprotocol_reprocessinghistoryitem_id_fkey FOREIGN KEY (reprocessinghistoryitem_id) REFERENCES public.reprocessinghistoryitem(id);


--
-- Name: endoscan_has_reprocessingdevice endoscan_has_reprocessingdevice_endoscan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscan_has_reprocessingdevice
    ADD CONSTRAINT endoscan_has_reprocessingdevice_endoscan_id_fkey FOREIGN KEY (endoscan_id) REFERENCES public.reprocessingdevice(id);


--
-- Name: endoscan_has_reprocessingdevice endoscan_has_reprocessingdevice_reprocessingdevice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscan_has_reprocessingdevice
    ADD CONSTRAINT endoscan_has_reprocessingdevice_reprocessingdevice_id_fkey FOREIGN KEY (reprocessingdevice_id) REFERENCES public.reprocessingdevice(id);


--
-- Name: endoscanconfig endoscanconfig_reprocessingdevice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscanconfig
    ADD CONSTRAINT endoscanconfig_reprocessingdevice_id_fkey FOREIGN KEY (reprocessingdevice_id) REFERENCES public.reprocessingdevice(id);


--
-- Name: endoscope endoscope_endoscopetype_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscope
    ADD CONSTRAINT endoscope_endoscopetype_id_fkey FOREIGN KEY (endoscopetype_id) REFERENCES public.endoscopetype(id);


--
-- Name: endoscope_has_department endoscope_has_department_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscope_has_department
    ADD CONSTRAINT endoscope_has_department_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.department(id);


--
-- Name: endoscope_has_department endoscope_has_department_endoscope_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscope_has_department
    ADD CONSTRAINT endoscope_has_department_endoscope_id_fkey FOREIGN KEY (endoscope_id) REFERENCES public.endoscope(id);


--
-- Name: endoscope_has_identifier endoscope_has_identifier_endoscope_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscope_has_identifier
    ADD CONSTRAINT endoscope_has_identifier_endoscope_id_fkey FOREIGN KEY (endoscope_id) REFERENCES public.endoscope(id);


--
-- Name: endoscope_has_identifier endoscope_has_identifier_identifier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscope_has_identifier
    ADD CONSTRAINT endoscope_has_identifier_identifier_id_fkey FOREIGN KEY (identifier_id) REFERENCES public.identifier(id);


--
-- Name: endoscope_has_logbook endoscope_has_logbook_endoscope_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscope_has_logbook
    ADD CONSTRAINT endoscope_has_logbook_endoscope_id_fkey FOREIGN KEY (endoscope_id) REFERENCES public.endoscope(id);


--
-- Name: endoscope_has_logbook endoscope_has_logbook_logbook_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscope_has_logbook
    ADD CONSTRAINT endoscope_has_logbook_logbook_id_fkey FOREIGN KEY (logbook_id) REFERENCES public.logbook(id);


--
-- Name: endoscope_has_reprocessighistoryitems endoscope_has_reprocessighistor_reprocessinghistoryitem_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscope_has_reprocessighistoryitems
    ADD CONSTRAINT endoscope_has_reprocessighistor_reprocessinghistoryitem_id_fkey FOREIGN KEY (reprocessinghistoryitem_id) REFERENCES public.reprocessinghistoryitem(id);


--
-- Name: endoscope_has_reprocessighistoryitems endoscope_has_reprocessighistoryitems_endoscope_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscope_has_reprocessighistoryitems
    ADD CONSTRAINT endoscope_has_reprocessighistoryitems_endoscope_id_fkey FOREIGN KEY (endoscope_id) REFERENCES public.endoscope(id);


--
-- Name: endoscope_has_task endoscope_has_task_endoscope_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscope_has_task
    ADD CONSTRAINT endoscope_has_task_endoscope_id_fkey FOREIGN KEY (endoscope_id) REFERENCES public.endoscope(id);


--
-- Name: endoscope_has_task endoscope_has_task_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscope_has_task
    ADD CONSTRAINT endoscope_has_task_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.task(id);


--
-- Name: endoscopereprocessingstatus endoscopereprocessingstatus_cyclestate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopereprocessingstatus
    ADD CONSTRAINT endoscopereprocessingstatus_cyclestate_id_fkey FOREIGN KEY (cyclestate_id) REFERENCES public.cyclestate(id);


--
-- Name: endoscopereprocessingstatus endoscopereprocessingstatus_endoscope_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopereprocessingstatus
    ADD CONSTRAINT endoscopereprocessingstatus_endoscope_id_fkey FOREIGN KEY (endoscope_id) REFERENCES public.endoscope(id);


--
-- Name: endoscopereprocessingstatus endoscopereprocessingstatus_laststation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopereprocessingstatus
    ADD CONSTRAINT endoscopereprocessingstatus_laststation_id_fkey FOREIGN KEY (laststation_id) REFERENCES public.reprocessingstation(id);


--
-- Name: endoscopereprocessingstatus endoscopereprocessingstatus_pendingstation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopereprocessingstatus
    ADD CONSTRAINT endoscopereprocessingstatus_pendingstation_id_fkey FOREIGN KEY (pendingstation_id) REFERENCES public.reprocessingstation(id);


--
-- Name: endoscopereprocessingstatus endoscopereprocessingstatus_runningstation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopereprocessingstatus
    ADD CONSTRAINT endoscopereprocessingstatus_runningstation_id_fkey FOREIGN KEY (runningstation_id) REFERENCES public.reprocessingstation(id);


--
-- Name: endoscopetype endoscopetype_actionreason_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopetype
    ADD CONSTRAINT endoscopetype_actionreason_id_fkey FOREIGN KEY (actionreason_id) REFERENCES public.actionreason(id);


--
-- Name: endoscopetype_has_etd5referencetype endoscopetype_has_etd5referencetype_endoscopetype_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopetype_has_etd5referencetype
    ADD CONSTRAINT endoscopetype_has_etd5referencetype_endoscopetype_id_fkey FOREIGN KEY (endoscopetype_id) REFERENCES public.endoscopetype(id);


--
-- Name: endoscopetype_has_etd5referencetype endoscopetype_has_etd5referencetype_etd5referencetype_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopetype_has_etd5referencetype
    ADD CONSTRAINT endoscopetype_has_etd5referencetype_etd5referencetype_id_fkey FOREIGN KEY (etd5referencetype_id) REFERENCES public.etd5referencetypeitem(id);


--
-- Name: endoscopetype_has_etd5referencetype endoscopetype_has_etd5referencetype_mappinggroup_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopetype_has_etd5referencetype
    ADD CONSTRAINT endoscopetype_has_etd5referencetype_mappinggroup_id_fkey FOREIGN KEY (mappinggroup_id) REFERENCES public.mappinggroup(id);


--
-- Name: endoscopetype_has_etddoublereferencetype endoscopetype_has_etddoublerefer_etddoublereferencetype_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopetype_has_etddoublereferencetype
    ADD CONSTRAINT endoscopetype_has_etddoublerefer_etddoublereferencetype_id_fkey FOREIGN KEY (etddoublereferencetype_id) REFERENCES public.etddoublereferencetypeitem(id) ON DELETE CASCADE;


--
-- Name: endoscopetype_has_etddoublereferencetype endoscopetype_has_etddoublereferencetype_endoscopetype_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopetype_has_etddoublereferencetype
    ADD CONSTRAINT endoscopetype_has_etddoublereferencetype_endoscopetype_id_fkey FOREIGN KEY (endoscopetype_id) REFERENCES public.endoscopetype(id);


--
-- Name: endoscopetype_has_etddoublereferencetype endoscopetype_has_etddoublereferencetype_mappinggroup_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopetype_has_etddoublereferencetype
    ADD CONSTRAINT endoscopetype_has_etddoublereferencetype_mappinggroup_id_fkey FOREIGN KEY (mappinggroup_id) REFERENCES public.mappinggroup(id);


--
-- Name: endoscopetype_has_logbook endoscopetype_has_logbook_endoscopetype_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopetype_has_logbook
    ADD CONSTRAINT endoscopetype_has_logbook_endoscopetype_id_fkey FOREIGN KEY (endoscopetype_id) REFERENCES public.endoscopetype(id);


--
-- Name: endoscopetype_has_logbook endoscopetype_has_logbook_logbook_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopetype_has_logbook
    ADD CONSTRAINT endoscopetype_has_logbook_logbook_id_fkey FOREIGN KEY (logbook_id) REFERENCES public.logbook(id);


--
-- Name: endoscopetype_has_proceduretype endoscopetype_has_proceduretype_endoscopetype_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopetype_has_proceduretype
    ADD CONSTRAINT endoscopetype_has_proceduretype_endoscopetype_id_fkey FOREIGN KEY (endoscopetype_id) REFERENCES public.endoscopetype(id);


--
-- Name: endoscopetype_has_proceduretype endoscopetype_has_proceduretype_proceduretype_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopetype_has_proceduretype
    ADD CONSTRAINT endoscopetype_has_proceduretype_proceduretype_id_fkey FOREIGN KEY (proceduretype_id) REFERENCES public.proceduretype(id);


--
-- Name: endoscopetype_has_reprocessingdevicetype endoscopetype_has_reporcessingde_reporcessingdevicetype_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopetype_has_reprocessingdevicetype
    ADD CONSTRAINT endoscopetype_has_reporcessingde_reporcessingdevicetype_id_fkey FOREIGN KEY (reprocessingdevicetype_id) REFERENCES public.reprocessingdevicetype(id);


--
-- Name: endoscopetype_has_reprocessingdevicetype endoscopetype_has_reporcessingdevicetype_endoscopetype_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopetype_has_reprocessingdevicetype
    ADD CONSTRAINT endoscopetype_has_reporcessingdevicetype_endoscopetype_id_fkey FOREIGN KEY (endoscopetype_id) REFERENCES public.endoscopetype(id);


--
-- Name: endoscopetype_has_reprocessingdevicetype endoscopetype_has_reprocessingdevicetype_mappinggroup_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopetype_has_reprocessingdevicetype
    ADD CONSTRAINT endoscopetype_has_reprocessingdevicetype_mappinggroup_id_fkey FOREIGN KEY (mappinggroup_id) REFERENCES public.mappinggroup(id);


--
-- Name: endoscopetype_has_task endoscopetype_has_task_endoscopetype_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopetype_has_task
    ADD CONSTRAINT endoscopetype_has_task_endoscopetype_id_fkey FOREIGN KEY (endoscopetype_id) REFERENCES public.endoscopetype(id);


--
-- Name: endoscopetype_has_task endoscopetype_has_task_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopetype_has_task
    ADD CONSTRAINT endoscopetype_has_task_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.task(id);


--
-- Name: endoscopetype endoscopetype_manufacturer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopetype
    ADD CONSTRAINT endoscopetype_manufacturer_id_fkey FOREIGN KEY (manufacturer_id) REFERENCES public.manufacturer(id);


--
-- Name: etd5blockinfo etd5blockinfo_etd5reprocessingprotocol_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5blockinfo
    ADD CONSTRAINT etd5blockinfo_etd5reprocessingprotocol_id_fkey FOREIGN KEY (etd5reprocessingprotocol_id) REFERENCES public.etd5reprocessingprotocol(id);


--
-- Name: etd5config etd5config_reprocessingdevice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5config
    ADD CONSTRAINT etd5config_reprocessingdevice_id_fkey FOREIGN KEY (reprocessingdevice_id) REFERENCES public.reprocessingdevice(id);


--
-- Name: etd5dosageinfo etd5dosageinfo_etd5blockinfo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5dosageinfo
    ADD CONSTRAINT etd5dosageinfo_etd5blockinfo_id_fkey FOREIGN KEY (etd5blockinfo_id) REFERENCES public.etd5blockinfo(id);


--
-- Name: etd5endoscope etd5endoscope_currentdata_reprocessingdevice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5endoscope
    ADD CONSTRAINT etd5endoscope_currentdata_reprocessingdevice_id_fkey FOREIGN KEY (currentdata_reprocessingdevice_id) REFERENCES public.currentdata(reprocessingdevice_id);


--
-- Name: etd5endoscope etd5endoscope_endoscope_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5endoscope
    ADD CONSTRAINT etd5endoscope_endoscope_id_fkey FOREIGN KEY (endoscope_id) REFERENCES public.endoscope(id);


--
-- Name: etd5endoscopeinfo etd5endoscopeinfo_etd5reprocessingprotocol_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5endoscopeinfo
    ADD CONSTRAINT etd5endoscopeinfo_etd5reprocessingprotocol_id_fkey FOREIGN KEY (etd5reprocessingprotocol_id) REFERENCES public.etd5reprocessingprotocol(id);


--
-- Name: etd5endoscopetype etd5endoscopetype_currentdata_reprocessingdevice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5endoscopetype
    ADD CONSTRAINT etd5endoscopetype_currentdata_reprocessingdevice_id_fkey FOREIGN KEY (currentdata_reprocessingdevice_id) REFERENCES public.currentdata(reprocessingdevice_id);


--
-- Name: etd5endoscopetype etd5endoscopetype_endoscopetype_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5endoscopetype
    ADD CONSTRAINT etd5endoscopetype_endoscopetype_id_fkey FOREIGN KEY (endoscopetype_id) REFERENCES public.endoscopetype(id);


--
-- Name: etd5errorprotocol etd5errorprotocol_reprocessingdevice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5errorprotocol
    ADD CONSTRAINT etd5errorprotocol_reprocessingdevice_id_fkey FOREIGN KEY (reprocessingdevice_id) REFERENCES public.reprocessingdevice(id);


--
-- Name: etd5errorprotocol etd5errorprotocol_reprocessinghistoryitem_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5errorprotocol
    ADD CONSTRAINT etd5errorprotocol_reprocessinghistoryitem_id_fkey FOREIGN KEY (reprocessinghistoryitem_id) REFERENCES public.reprocessinghistoryitem(id);


--
-- Name: etd5machineinfo etd5machineinfo_etd5maschinevariant_id_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5machineinfo
    ADD CONSTRAINT etd5machineinfo_etd5maschinevariant_id_id_fkey FOREIGN KEY (etd5maschinevariant_id) REFERENCES public.etd5maschinevariant(id);


--
-- Name: etd5machineinfo etd5machineinfo_reprocessingdevice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5machineinfo
    ADD CONSTRAINT etd5machineinfo_reprocessingdevice_id_fkey FOREIGN KEY (reprocessingdevice_id) REFERENCES public.reprocessingdevice(id);


--
-- Name: etd5message etd5message_reprocessingdevice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5message
    ADD CONSTRAINT etd5message_reprocessingdevice_id_fkey FOREIGN KEY (reprocessingdevice_id) REFERENCES public.reprocessingdevice(id);


--
-- Name: etd5pressure etd5pressure_etd5blockinfo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5pressure
    ADD CONSTRAINT etd5pressure_etd5blockinfo_id_fkey FOREIGN KEY (etd5blockinfo_id) REFERENCES public.etd5blockinfo(id);


--
-- Name: etd5processdatadetailed etd5processdatadetailed_reprocessinghistoryitem_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5processdatadetailed
    ADD CONSTRAINT etd5processdatadetailed_reprocessinghistoryitem_id_fkey FOREIGN KEY (reprocessinghistoryitem_id) REFERENCES public.reprocessinghistoryitem(id);


--
-- Name: etd5referencetypeitem etd5referencetypeitem_etd5referencetypelist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5referencetypeitem
    ADD CONSTRAINT etd5referencetypeitem_etd5referencetypelist_id_fkey FOREIGN KEY (etd5referencetypelist_id) REFERENCES public.etd5referencetypelist(id);


--
-- Name: etd5reprocessingprotocol etd5reprocessingprotocol_etd5userinfoend_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5reprocessingprotocol
    ADD CONSTRAINT etd5reprocessingprotocol_etd5userinfoend_id_fkey FOREIGN KEY (etd5userinfoend_id) REFERENCES public.etd5userinfo(id);


--
-- Name: etd5reprocessingprotocol etd5reprocessingprotocol_etd5userinfostart_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5reprocessingprotocol
    ADD CONSTRAINT etd5reprocessingprotocol_etd5userinfostart_id_fkey FOREIGN KEY (etd5userinfostart_id) REFERENCES public.etd5userinfo(id);


--
-- Name: etd5reprocessingprotocol etd5reprocessingprotocol_reprocessinghistoryitem_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5reprocessingprotocol
    ADD CONSTRAINT etd5reprocessingprotocol_reprocessinghistoryitem_id_fkey FOREIGN KEY (reprocessinghistoryitem_id) REFERENCES public.reprocessinghistoryitem(id);


--
-- Name: etd5rotation etd5rotation_etd5blockinfo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5rotation
    ADD CONSTRAINT etd5rotation_etd5blockinfo_id_fkey FOREIGN KEY (etd5blockinfo_id) REFERENCES public.etd5blockinfo(id);


--
-- Name: etd5user etd5user_currentdata_reprocessingdevice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5user
    ADD CONSTRAINT etd5user_currentdata_reprocessingdevice_id_fkey FOREIGN KEY (currentdata_reprocessingdevice_id) REFERENCES public.currentdata(reprocessingdevice_id);


--
-- Name: etd5user etd5user_useraccount_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etd5user
    ADD CONSTRAINT etd5user_useraccount_id_fkey FOREIGN KEY (useraccount_id) REFERENCES public.useraccount(id);


--
-- Name: etdbasicprocessdata etdbasicprocessdata_reprocessinghistoryitem_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdbasicprocessdata
    ADD CONSTRAINT etdbasicprocessdata_reprocessinghistoryitem_id_fkey FOREIGN KEY (reprocessinghistoryitem_id) REFERENCES public.reprocessinghistoryitem(id);


--
-- Name: etdconfig etdconfig_reprocessingdevice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdconfig
    ADD CONSTRAINT etdconfig_reprocessingdevice_id_fkey FOREIGN KEY (reprocessingdevice_id) REFERENCES public.reprocessingdevice(id);


--
-- Name: etddconfig etddconfig_reprocessingdevice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddconfig
    ADD CONSTRAINT etddconfig_reprocessingdevice_id_fkey FOREIGN KEY (reprocessingdevice_id) REFERENCES public.reprocessingdevice(id);


--
-- Name: etddoubleapcinfo etddoubleapcinfo_etddoubleblockinfo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoubleapcinfo
    ADD CONSTRAINT etddoubleapcinfo_etddoubleblockinfo_id_fkey FOREIGN KEY (etddoubleblockinfo_id) REFERENCES public.etddoubleblockinfo(id);


--
-- Name: etddoubleblockinfo etddoubleblockinfo_etddoublereprocessingprotocol_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoubleblockinfo
    ADD CONSTRAINT etddoubleblockinfo_etddoublereprocessingprotocol_id_fkey FOREIGN KEY (etddoublereprocessingprotocol_id) REFERENCES public.etddoublereprocessingprotocol(id);


--
-- Name: etddoubledosinginfo etddoubledosinginfo_etddoubleblockinfo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoubledosinginfo
    ADD CONSTRAINT etddoubledosinginfo_etddoubleblockinfo_id_fkey FOREIGN KEY (etddoubleblockinfo_id) REFERENCES public.etddoubleblockinfo(id);


--
-- Name: etddoubleendoscope etddoubleendoscope_currentdata_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoubleendoscope
    ADD CONSTRAINT etddoubleendoscope_currentdata_id_fkey FOREIGN KEY (currentdata_id) REFERENCES public.currentdata(reprocessingdevice_id);


--
-- Name: etddoubleendoscope_has_endoscope etddoubleendoscope_has_endoscope_endoscope_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoubleendoscope_has_endoscope
    ADD CONSTRAINT etddoubleendoscope_has_endoscope_endoscope_id_fkey FOREIGN KEY (endoscope_id) REFERENCES public.endoscope(id);


--
-- Name: etddoubleendoscope_has_endoscope etddoubleendoscope_has_endoscope_etddoubleendoscope_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoubleendoscope_has_endoscope
    ADD CONSTRAINT etddoubleendoscope_has_endoscope_etddoubleendoscope_id_fkey FOREIGN KEY (etddoubleendoscope_id) REFERENCES public.etddoubleendoscope(id);


--
-- Name: etddoubleendoscopeinfo etddoubleendoscopeinfo_etddoublereprocessingprotocol_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoubleendoscopeinfo
    ADD CONSTRAINT etddoubleendoscopeinfo_etddoublereprocessingprotocol_id_fkey FOREIGN KEY (etddoublereprocessingprotocol_id) REFERENCES public.etddoublereprocessingprotocol(id);


--
-- Name: etddoubleerrorprotocol etddoubleerrorprotocol_reprocessingdevice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoubleerrorprotocol
    ADD CONSTRAINT etddoubleerrorprotocol_reprocessingdevice_id_fkey FOREIGN KEY (reprocessingdevice_id) REFERENCES public.reprocessingdevice(id);


--
-- Name: etddoubleerrorprotocol etddoubleerrorprotocol_reprocessinghistoryitem_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoubleerrorprotocol
    ADD CONSTRAINT etddoubleerrorprotocol_reprocessinghistoryitem_id_fkey FOREIGN KEY (reprocessinghistoryitem_id) REFERENCES public.reprocessinghistoryitem(id);


--
-- Name: etddoublepressure etddoublepressure_etddoubleblockinfo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoublepressure
    ADD CONSTRAINT etddoublepressure_etddoubleblockinfo_id_fkey FOREIGN KEY (etddoubleblockinfo_id) REFERENCES public.etddoubleblockinfo(id);


--
-- Name: etddoubleprocessdata etddoubleprocessdata_reprocessinghistoryitem_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoubleprocessdata
    ADD CONSTRAINT etddoubleprocessdata_reprocessinghistoryitem_id_fkey FOREIGN KEY (reprocessinghistoryitem_id) REFERENCES public.reprocessinghistoryitem(id);


--
-- Name: etddoublereferencetypeitem etddoublereferencetypeitem_etddoublereferencetypelist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoublereferencetypeitem
    ADD CONSTRAINT etddoublereferencetypeitem_etddoublereferencetypelist_id_fkey FOREIGN KEY (etddoublereferencetypelist_id) REFERENCES public.etddoublereferencetypelist(id);


--
-- Name: etddoublereprocessingprotocol etddoublereprocessingprotocol_etddoubleuserinfoend_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoublereprocessingprotocol
    ADD CONSTRAINT etddoublereprocessingprotocol_etddoubleuserinfoend_id_fkey FOREIGN KEY (etddoubleuserinfoend_id) REFERENCES public.etddoubleuserinfo(id);


--
-- Name: etddoublereprocessingprotocol etddoublereprocessingprotocol_etddoubleuserinfostart_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoublereprocessingprotocol
    ADD CONSTRAINT etddoublereprocessingprotocol_etddoubleuserinfostart_id_fkey FOREIGN KEY (etddoubleuserinfostart_id) REFERENCES public.etddoubleuserinfo(id);


--
-- Name: etddoublereprocessingprotocol etddoublereprocessingprotocol_reprocessinghistoryitem_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoublereprocessingprotocol
    ADD CONSTRAINT etddoublereprocessingprotocol_reprocessinghistoryitem_id_fkey FOREIGN KEY (reprocessinghistoryitem_id) REFERENCES public.reprocessinghistoryitem(id);


--
-- Name: etddoublerotation etddoublerotation_etddoubleblockinfo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoublerotation
    ADD CONSTRAINT etddoublerotation_etddoubleblockinfo_id_fkey FOREIGN KEY (etddoubleblockinfo_id) REFERENCES public.etddoubleblockinfo(id);


--
-- Name: etddoubleuser etddoubleuser_currentdata_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoubleuser
    ADD CONSTRAINT etddoubleuser_currentdata_id_fkey FOREIGN KEY (currentdata_id) REFERENCES public.currentdata(reprocessingdevice_id);


--
-- Name: etddoubleuser_has_useraccount etddoubleuser_has_useraccount_etddoubleuser_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoubleuser_has_useraccount
    ADD CONSTRAINT etddoubleuser_has_useraccount_etddoubleuser_id_fkey FOREIGN KEY (etddoubleuser_id) REFERENCES public.etddoubleuser(id);


--
-- Name: etddoubleuser_has_useraccount etddoubleuser_has_useraccount_useraccount_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etddoubleuser_has_useraccount
    ADD CONSTRAINT etddoubleuser_has_useraccount_useraccount_id_fkey FOREIGN KEY (useraccount_id) REFERENCES public.useraccount(id);


--
-- Name: etdendoscope etdendoscope_currentdata_reprocessingdevice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdendoscope
    ADD CONSTRAINT etdendoscope_currentdata_reprocessingdevice_id_fkey FOREIGN KEY (currentdata_reprocessingdevice_id) REFERENCES public.currentdata(reprocessingdevice_id);


--
-- Name: etdendoscope etdendoscope_endoscope_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdendoscope
    ADD CONSTRAINT etdendoscope_endoscope_id_fkey FOREIGN KEY (endoscope_id) REFERENCES public.endoscope(id);


--
-- Name: etdminiconfig etdminiconfig_reprocessingdevice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdminiconfig
    ADD CONSTRAINT etdminiconfig_reprocessingdevice_id_fkey FOREIGN KEY (reprocessingdevice_id) REFERENCES public.reprocessingdevice(id);


--
-- Name: etdminiprobedata etdminiprobedata_reprocessinghistoryitem_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdminiprobedata
    ADD CONSTRAINT etdminiprobedata_reprocessinghistoryitem_id_fkey FOREIGN KEY (reprocessinghistoryitem_id) REFERENCES public.reprocessinghistoryitem(id);


--
-- Name: etdminiprocessdata etdminiprocessdata_etdminicyclephaseinterrupttype_id_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdminiprocessdata
    ADD CONSTRAINT etdminiprocessdata_etdminicyclephaseinterrupttype_id_id_fkey FOREIGN KEY (etdminicyclephaseinterrupttype_id) REFERENCES public.etdminicyclephaseinterrupttype(id);


--
-- Name: etdminiprocessdata etdminiprocessdata_etdminicyclephasetype_id_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdminiprocessdata
    ADD CONSTRAINT etdminiprocessdata_etdminicyclephasetype_id_id_fkey FOREIGN KEY (etdminicyclephasetype_id) REFERENCES public.etdminicyclephasetype(id);


--
-- Name: etdminiprocessdata etdminiprocessdata_reprocessinghistoryitem_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdminiprocessdata
    ADD CONSTRAINT etdminiprocessdata_reprocessinghistoryitem_id_fkey FOREIGN KEY (reprocessinghistoryitem_id) REFERENCES public.reprocessinghistoryitem(id) ON DELETE CASCADE;


--
-- Name: etdminireprocessingprotocol etdminireprocessingprotocol_etdminiprotocoltype_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdminireprocessingprotocol
    ADD CONSTRAINT etdminireprocessingprotocol_etdminiprotocoltype_id_fkey FOREIGN KEY (etdminiprotocoltype_id) REFERENCES public.etdminiprotocoltype(id);


--
-- Name: etdminireprocessingprotocol etdminireprocessingprotocol_reprocessinghistoryitem_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdminireprocessingprotocol
    ADD CONSTRAINT etdminireprocessingprotocol_reprocessinghistoryitem_id_fkey FOREIGN KEY (reprocessinghistoryitem_id) REFERENCES public.reprocessinghistoryitem(id);


--
-- Name: etdplusconfig etdplusconfig_reprocessingdevice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdplusconfig
    ADD CONSTRAINT etdplusconfig_reprocessingdevice_id_fkey FOREIGN KEY (reprocessingdevice_id) REFERENCES public.reprocessingdevice(id);


--
-- Name: etduser etduser_currentdata_reprocessingdevice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etduser
    ADD CONSTRAINT etduser_currentdata_reprocessingdevice_id_fkey FOREIGN KEY (currentdata_reprocessingdevice_id) REFERENCES public.currentdata(reprocessingdevice_id);


--
-- Name: etduser etduser_useraccount_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etduser
    ADD CONSTRAINT etduser_useraccount_id_fkey FOREIGN KEY (useraccount_id) REFERENCES public.useraccount(id);


--
-- Name: etdv3reprocessingprotocol etdv3reprocessingprotocol_etdv3reprocessingprotocoltype_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdv3reprocessingprotocol
    ADD CONSTRAINT etdv3reprocessingprotocol_etdv3reprocessingprotocoltype_id_fkey FOREIGN KEY (etdv3reprocessingprotocoltype_id) REFERENCES public.etdv3reprocessingprotocoltype(id);


--
-- Name: etdv3reprocessingprotocol etdv3reprocessingprotocol_reprocessinghistoryitem_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etdv3reprocessingprotocol
    ADD CONSTRAINT etdv3reprocessingprotocol_reprocessinghistoryitem_id_fkey FOREIGN KEY (reprocessinghistoryitem_id) REFERENCES public.reprocessinghistoryitem(id);


--
-- Name: expansionunit expansionunit_reprocessingdevice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expansionunit
    ADD CONSTRAINT expansionunit_reprocessingdevice_id_fkey FOREIGN KEY (reprocessingdevice_id) REFERENCES public.reprocessingdevice(id);


--
-- Name: exportfilehistory exportfilehistory_reprocessinghistoryitem_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exportfilehistory
    ADD CONSTRAINT exportfilehistory_reprocessinghistoryitem_id_fkey FOREIGN KEY (reprocessinghistoryitem_id) REFERENCES public.reprocessinghistoryitem(id);


--
-- Name: department_endoscopetype_instruction fk_dep_endo_instr_department; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department_endoscopetype_instruction
    ADD CONSTRAINT fk_dep_endo_instr_department FOREIGN KEY (department_id) REFERENCES public.department(id) ON DELETE CASCADE;


--
-- Name: department_endoscopetype_instruction fk_dep_endo_instr_endoscopetype; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department_endoscopetype_instruction
    ADD CONSTRAINT fk_dep_endo_instr_endoscopetype FOREIGN KEY (endoscopetype_id) REFERENCES public.endoscopetype(id) ON DELETE CASCADE;


--
-- Name: department_endoscopetype_instruction fk_dep_endo_instr_instruction; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department_endoscopetype_instruction
    ADD CONSTRAINT fk_dep_endo_instr_instruction FOREIGN KEY (reprocessinginstruction_id) REFERENCES public.reprocessinginstruction(id) ON DELETE CASCADE;


--
-- Name: endoscopelocation fk_endoscopelocation_endoscope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endoscopelocation
    ADD CONSTRAINT fk_endoscopelocation_endoscope FOREIGN KEY (endoscopeid) REFERENCES public.endoscope(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: reprocessinghistoryitem_has_department fk_rhi_dep_department; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessinghistoryitem_has_department
    ADD CONSTRAINT fk_rhi_dep_department FOREIGN KEY (department_id) REFERENCES public.department(id);


--
-- Name: reprocessinghistoryitem_has_department fk_rhi_dep_rhi; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessinghistoryitem_has_department
    ADD CONSTRAINT fk_rhi_dep_rhi FOREIGN KEY (reprocessinghistoryitem_id) REFERENCES public.reprocessinghistoryitem(id);


--
-- Name: flow_batch flow_batch_reprocessingdevice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flow_batch
    ADD CONSTRAINT flow_batch_reprocessingdevice_id_fkey FOREIGN KEY (reprocessingdevice_id) REFERENCES public.reprocessingdevice(id);


--
-- Name: flow_statistics flow_statistics_flow_batch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flow_statistics
    ADD CONSTRAINT flow_statistics_flow_batch_id_fkey FOREIGN KEY (flow_batch_id) REFERENCES public.flow_batch(id);


--
-- Name: identifier_has_logbook identifier_has_logbook_identifier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identifier_has_logbook
    ADD CONSTRAINT identifier_has_logbook_identifier_id_fkey FOREIGN KEY (identifier_id) REFERENCES public.identifier(id);


--
-- Name: identifier_has_logbook identifier_has_logbook_logbook_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identifier_has_logbook
    ADD CONSTRAINT identifier_has_logbook_logbook_id_fkey FOREIGN KEY (logbook_id) REFERENCES public.logbook(id);


--
-- Name: identifier identifier_identifiertype_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identifier
    ADD CONSTRAINT identifier_identifiertype_id_fkey FOREIGN KEY (identifiertype_id) REFERENCES public.identifiertype(id);


--
-- Name: identifiertype_has_logbook identifiertype_has_logbook_identifiertype_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identifiertype_has_logbook
    ADD CONSTRAINT identifiertype_has_logbook_identifiertype_id_fkey FOREIGN KEY (identifiertype_id) REFERENCES public.identifiertype(id);


--
-- Name: identifiertype_has_logbook identifiertype_has_logbook_logbook_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identifiertype_has_logbook
    ADD CONSTRAINT identifiertype_has_logbook_logbook_id_fkey FOREIGN KEY (logbook_id) REFERENCES public.logbook(id);


--
-- Name: reprocessinghistoryitem ifk_rel_81; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessinghistoryitem
    ADD CONSTRAINT ifk_rel_81 FOREIGN KEY (reprocessingdevice_id) REFERENCES public.reprocessingdevice(id);


--
-- Name: reprocessinghistoryitem ifk_rel_82; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessinghistoryitem
    ADD CONSTRAINT ifk_rel_82 FOREIGN KEY (enduseraccount_id) REFERENCES public.useraccount(id);


--
-- Name: reprocessinghistoryitem ifk_rel_83; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessinghistoryitem
    ADD CONSTRAINT ifk_rel_83 FOREIGN KEY (startuseraccount_id) REFERENCES public.useraccount(id);


--
-- Name: license license_appliedonsystemid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.license
    ADD CONSTRAINT license_appliedonsystemid_fkey FOREIGN KEY (appliedonsystemid) REFERENCES public.knownpeer(id);


--
-- Name: license_has_logbook license_has_logbook_license_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.license_has_logbook
    ADD CONSTRAINT license_has_logbook_license_id_fkey FOREIGN KEY (license_id) REFERENCES public.license(id);


--
-- Name: license_has_logbook license_has_logbook_logbook_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.license_has_logbook
    ADD CONSTRAINT license_has_logbook_logbook_id_fkey FOREIGN KEY (logbook_id) REFERENCES public.logbook(id);


--
-- Name: logbook_has_attachment logbook_has_attachment_attachment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logbook_has_attachment
    ADD CONSTRAINT logbook_has_attachment_attachment_id_fkey FOREIGN KEY (attachment_id) REFERENCES public.attachment(id);


--
-- Name: logbook_has_attachment logbook_has_attachment_logbook_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logbook_has_attachment
    ADD CONSTRAINT logbook_has_attachment_logbook_id_fkey FOREIGN KEY (logbook_id) REFERENCES public.logbook(id);


--
-- Name: logbook logbook_logbookcategory_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logbook
    ADD CONSTRAINT logbook_logbookcategory_id_fkey FOREIGN KEY (logbookcategory_id) REFERENCES public.logbookcategory(id);


--
-- Name: logbook logbook_logbookevent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logbook
    ADD CONSTRAINT logbook_logbookevent_id_fkey FOREIGN KEY (logbookevent_id) REFERENCES public.logbookevent(id);


--
-- Name: logbook logbook_logbookmessagetype_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logbook
    ADD CONSTRAINT logbook_logbookmessagetype_id_fkey FOREIGN KEY (logbookmessagetype_id) REFERENCES public.logbookmessagetypeid(id);


--
-- Name: logbook logbook_logbookobjecttype_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logbook
    ADD CONSTRAINT logbook_logbookobjecttype_id_fkey FOREIGN KEY (logbookobjecttype_id) REFERENCES public.logbookobjecttype(id);


--
-- Name: logbook logbook_logbooksource_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logbook
    ADD CONSTRAINT logbook_logbooksource_id_fkey FOREIGN KEY (logbooksource_id) REFERENCES public.logbooksource(id);


--
-- Name: logbook logbook_reprocessingdevice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logbook
    ADD CONSTRAINT logbook_reprocessingdevice_id_fkey FOREIGN KEY (reprocessingdevice_id) REFERENCES public.reprocessingdevice(id);


--
-- Name: logbook logbook_reprocessinghistoryitem_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logbook
    ADD CONSTRAINT logbook_reprocessinghistoryitem_id_fkey FOREIGN KEY (reprocessinghistoryitem_id) REFERENCES public.reprocessinghistoryitem(id);


--
-- Name: logbook logbook_useraccount_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logbook
    ADD CONSTRAINT logbook_useraccount_id_fkey FOREIGN KEY (useraccount_id) REFERENCES public.useraccount(id);


--
-- Name: manualprotocol manualprotocol_checklist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manualprotocol
    ADD CONSTRAINT manualprotocol_checklist_id_fkey FOREIGN KEY (checklist_id) REFERENCES public.checklist(id);


--
-- Name: manualprotocol manualprotocol_reprocessinghistoryitem_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manualprotocol
    ADD CONSTRAINT manualprotocol_reprocessinghistoryitem_id_fkey FOREIGN KEY (reprocessinghistoryitem_id) REFERENCES public.reprocessinghistoryitem(id);


--
-- Name: manualprotocolitem manualprotocolitem_checklistitem_id_checklistitem_checklis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manualprotocolitem
    ADD CONSTRAINT manualprotocolitem_checklistitem_id_checklistitem_checklis_fkey FOREIGN KEY (checklistitem_id, checklistitem_checklist_id) REFERENCES public.checklistitem(id, checklist_id);


--
-- Name: manualprotocolitem manualprotocolitem_manualprotocol_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manualprotocolitem
    ADD CONSTRAINT manualprotocolitem_manualprotocol_id_fkey FOREIGN KEY (manualprotocol_id) REFERENCES public.manualprotocol(id);


--
-- Name: mappinggroup mappinggroup_reprocessingdevicetype_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mappinggroup
    ADD CONSTRAINT mappinggroup_reprocessingdevicetype_id_fkey FOREIGN KEY (reprocessingdevicetype_id) REFERENCES public.reprocessingdevicetype(id);


--
-- Name: procedure procedure_proceduretype_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.procedure
    ADD CONSTRAINT procedure_proceduretype_id_fkey FOREIGN KEY (proceduretype_id) REFERENCES public.proceduretype(id);


--
-- Name: proceduretype_has_logbook proceduretype_has_logbook_logbook_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proceduretype_has_logbook
    ADD CONSTRAINT proceduretype_has_logbook_logbook_id_fkey FOREIGN KEY (logbook_id) REFERENCES public.logbook(id);


--
-- Name: proceduretype_has_logbook proceduretype_has_logbook_proceduretype_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proceduretype_has_logbook
    ADD CONSTRAINT proceduretype_has_logbook_proceduretype_id_fkey FOREIGN KEY (proceduretype_id) REFERENCES public.proceduretype(id);


--
-- Name: protocol protocol_reprocessingdevice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol
    ADD CONSTRAINT protocol_reprocessingdevice_id_fkey FOREIGN KEY (reprocessingdevice_id) REFERENCES public.reprocessingdevice(id);


--
-- Name: reprocessingconstraint reprocessingconstraint_reprocessinginstruction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingconstraint
    ADD CONSTRAINT reprocessingconstraint_reprocessinginstruction_id_fkey FOREIGN KEY (reprocessinginstruction_id) REFERENCES public.reprocessinginstruction(id);


--
-- Name: reprocessingconstraint reprocessingconstraint_reprocessingstationcompensation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingconstraint
    ADD CONSTRAINT reprocessingconstraint_reprocessingstationcompensation_id_fkey FOREIGN KEY (reprocessingstationcompensation_id) REFERENCES public.reprocessingstation(id);


--
-- Name: reprocessingconstraint reprocessingconstraint_reprocessingstationfrom_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingconstraint
    ADD CONSTRAINT reprocessingconstraint_reprocessingstationfrom_id_fkey FOREIGN KEY (reprocessingstationfrom_id) REFERENCES public.reprocessingstation(id);


--
-- Name: reprocessingconstraint reprocessingconstraint_reprocessingstationto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingconstraint
    ADD CONSTRAINT reprocessingconstraint_reprocessingstationto_id_fkey FOREIGN KEY (reprocessingstationto_id) REFERENCES public.reprocessingstation(id);


--
-- Name: reprocessingdevice reprocessingdevice_chemicalstype_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingdevice
    ADD CONSTRAINT reprocessingdevice_chemicalstype_id_fkey FOREIGN KEY (chemicalstype_id) REFERENCES public.chemicalstype(id);


--
-- Name: reprocessingdevice_has_department reprocessingdevice_has_department_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingdevice_has_department
    ADD CONSTRAINT reprocessingdevice_has_department_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.department(id);


--
-- Name: reprocessingdevice_has_department reprocessingdevice_has_department_reprocessingdevice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingdevice_has_department
    ADD CONSTRAINT reprocessingdevice_has_department_reprocessingdevice_id_fkey FOREIGN KEY (reprocessingdevice_id) REFERENCES public.reprocessingdevice(id);


--
-- Name: reprocessingdevice_has_identifier reprocessingdevice_has_identifier_identifier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingdevice_has_identifier
    ADD CONSTRAINT reprocessingdevice_has_identifier_identifier_id_fkey FOREIGN KEY (identifier_id) REFERENCES public.identifier(id);


--
-- Name: reprocessingdevice_has_identifier reprocessingdevice_has_identifier_reprocessingdevice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingdevice_has_identifier
    ADD CONSTRAINT reprocessingdevice_has_identifier_reprocessingdevice_id_fkey FOREIGN KEY (reprocessingdevice_id) REFERENCES public.reprocessingdevice(id);


--
-- Name: reprocessingdevice_has_logbook reprocessingdevice_has_logbook_logbook_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingdevice_has_logbook
    ADD CONSTRAINT reprocessingdevice_has_logbook_logbook_id_fkey FOREIGN KEY (logbook_id) REFERENCES public.logbook(id);


--
-- Name: reprocessingdevice_has_logbook reprocessingdevice_has_logbook_reprocessingdevice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingdevice_has_logbook
    ADD CONSTRAINT reprocessingdevice_has_logbook_reprocessingdevice_id_fkey FOREIGN KEY (reprocessingdevice_id) REFERENCES public.reprocessingdevice(id);


--
-- Name: reprocessingdevice_has_task reprocessingdevice_has_task_reprocessingdevice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingdevice_has_task
    ADD CONSTRAINT reprocessingdevice_has_task_reprocessingdevice_id_fkey FOREIGN KEY (reprocessingdevice_id) REFERENCES public.reprocessingdevice(id);


--
-- Name: reprocessingdevice_has_task reprocessingdevice_has_task_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingdevice_has_task
    ADD CONSTRAINT reprocessingdevice_has_task_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.task(id);


--
-- Name: reprocessingdevice reprocessingdevice_mappinggroup_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingdevice
    ADD CONSTRAINT reprocessingdevice_mappinggroup_id_fkey FOREIGN KEY (mappinggroup_id) REFERENCES public.mappinggroup(id);


--
-- Name: reprocessingdevice reprocessingdevice_printsettings_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingdevice
    ADD CONSTRAINT reprocessingdevice_printsettings_id_fkey FOREIGN KEY (printsettings_id) REFERENCES public.printsettings(id);


--
-- Name: reprocessingdevice reprocessingdevice_reporcessingdevicetype_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingdevice
    ADD CONSTRAINT reprocessingdevice_reporcessingdevicetype_id_fkey FOREIGN KEY (reprocessingdevicetype_id) REFERENCES public.reprocessingdevicetype(id);


--
-- Name: reprocessingdevicetype_has_identifiertype reprocessingdevicetype_has_ident_reprocessingdevicetype_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingdevicetype_has_identifiertype
    ADD CONSTRAINT reprocessingdevicetype_has_ident_reprocessingdevicetype_id_fkey FOREIGN KEY (reprocessingdevicetype_id) REFERENCES public.reprocessingdevicetype(id);


--
-- Name: reprocessingdevicetype_has_identifiertype reprocessingdevicetype_has_identifiertyp_identifiertype_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingdevicetype_has_identifiertype
    ADD CONSTRAINT reprocessingdevicetype_has_identifiertyp_identifiertype_id_fkey FOREIGN KEY (identifiertype_id) REFERENCES public.identifiertype(id);


--
-- Name: reprocessinghistoryitem reprocessinghistoryitem_batch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessinghistoryitem
    ADD CONSTRAINT reprocessinghistoryitem_batch_id_fkey FOREIGN KEY (batch_id) REFERENCES public.batch(id);


--
-- Name: reprocessinghistoryitem_profil reprocessinghistoryitem_profil_profil_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessinghistoryitem_profil
    ADD CONSTRAINT reprocessinghistoryitem_profil_profil_id_fkey FOREIGN KEY (profil_id) REFERENCES public.profil(id);


--
-- Name: reprocessinghistoryitem_profil reprocessinghistoryitem_profil_reprocessinghistoryitem_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessinghistoryitem_profil
    ADD CONSTRAINT reprocessinghistoryitem_profil_reprocessinghistoryitem_id_fkey FOREIGN KEY (reprocessinghistoryitem_id) REFERENCES public.reprocessinghistoryitem(id);


--
-- Name: reprocessinghistoryitem reprocessinghistoryitem_reprocessinghistoryitemeventtype_i_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessinghistoryitem
    ADD CONSTRAINT reprocessinghistoryitem_reprocessinghistoryitemeventtype_i_fkey FOREIGN KEY (reprocessinghistoryitemeventtype_id) REFERENCES public.reprocessinghistoryitemeventtype(id);


--
-- Name: reprocessinginstruction_has_logbook reprocessinginstruction_has_log_reprocessinginstruction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessinginstruction_has_logbook
    ADD CONSTRAINT reprocessinginstruction_has_log_reprocessinginstruction_id_fkey FOREIGN KEY (reprocessinginstruction_id) REFERENCES public.reprocessinginstruction(id);


--
-- Name: reprocessinginstruction_has_logbook reprocessinginstruction_has_logbook_logbook_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessinginstruction_has_logbook
    ADD CONSTRAINT reprocessinginstruction_has_logbook_logbook_id_fkey FOREIGN KEY (logbook_id) REFERENCES public.logbook(id);


--
-- Name: reprocessingstation reprocessingstation_compensationstation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingstation
    ADD CONSTRAINT reprocessingstation_compensationstation_id_fkey FOREIGN KEY (compensationstation_id) REFERENCES public.reprocessingstation(id);


--
-- Name: reprocessingstation_has_attachment reprocessingstation_has_attachment_attachment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingstation_has_attachment
    ADD CONSTRAINT reprocessingstation_has_attachment_attachment_id_fkey FOREIGN KEY (attachment_id) REFERENCES public.attachment(id);


--
-- Name: reprocessingstation_has_attachment reprocessingstation_has_attachment_reprocessingstation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingstation_has_attachment
    ADD CONSTRAINT reprocessingstation_has_attachment_reprocessingstation_id_fkey FOREIGN KEY (reprocessingstation_id) REFERENCES public.reprocessingstation(id);


--
-- Name: reprocessingstation reprocessingstation_printsettings_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingstation
    ADD CONSTRAINT reprocessingstation_printsettings_id_fkey FOREIGN KEY (printsettings_id) REFERENCES public.printsettings(id);


--
-- Name: reprocessingstation reprocessingstation_profil_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingstation
    ADD CONSTRAINT reprocessingstation_profil_id_fkey FOREIGN KEY (profil_id) REFERENCES public.profil(id);


--
-- Name: reprocessingstation reprocessingstation_reprocessinginstruction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reprocessingstation
    ADD CONSTRAINT reprocessingstation_reprocessinginstruction_id_fkey FOREIGN KEY (reprocessinginstruction_id) REFERENCES public.reprocessinginstruction(id);


--
-- Name: user_has_department user_has_department_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_has_department
    ADD CONSTRAINT user_has_department_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.department(id);


--
-- Name: user_has_department user_has_department_useraccount_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_has_department
    ADD CONSTRAINT user_has_department_useraccount_id_fkey FOREIGN KEY (useraccount_id) REFERENCES public.useraccount(id);


--
-- Name: user_has_identifier user_has_identifier_identifier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_has_identifier
    ADD CONSTRAINT user_has_identifier_identifier_id_fkey FOREIGN KEY (identifier_id) REFERENCES public.identifier(id);


--
-- Name: user_has_identifier user_has_identifier_useraccount_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_has_identifier
    ADD CONSTRAINT user_has_identifier_useraccount_id_fkey FOREIGN KEY (useraccount_id) REFERENCES public.useraccount(id);


--
-- Name: useraccount_has_logbook useraccount_has_logbook_logbook_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.useraccount_has_logbook
    ADD CONSTRAINT useraccount_has_logbook_logbook_id_fkey FOREIGN KEY (logbook_id) REFERENCES public.logbook(id);


--
-- Name: useraccount_has_logbook useraccount_has_logbook_useraccount_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.useraccount_has_logbook
    ADD CONSTRAINT useraccount_has_logbook_useraccount_id_fkey FOREIGN KEY (useraccount_id) REFERENCES public.useraccount(id);


--
-- Name: useraccount_has_userdevicelevelgroup useraccount_has_userdevicelevelgro_userdevicelevelgroup_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.useraccount_has_userdevicelevelgroup
    ADD CONSTRAINT useraccount_has_userdevicelevelgro_userdevicelevelgroup_id_fkey FOREIGN KEY (userdevicelevelgroup_id) REFERENCES public.userdevicelevelgroup(id);


--
-- Name: useraccount_has_userdevicelevelgroup useraccount_has_userdevicelevelgroup_useraccount_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.useraccount_has_userdevicelevelgroup
    ADD CONSTRAINT useraccount_has_userdevicelevelgroup_useraccount_id_fkey FOREIGN KEY (useraccount_id) REFERENCES public.useraccount(id);


--
-- Name: useraccount_has_usergroup useraccount_has_usergroup_useraccount_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.useraccount_has_usergroup
    ADD CONSTRAINT useraccount_has_usergroup_useraccount_id_fkey FOREIGN KEY (useraccount_id) REFERENCES public.useraccount(id);


--
-- Name: useraccount_has_usergroup useraccount_has_usergroup_usergroup_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.useraccount_has_usergroup
    ADD CONSTRAINT useraccount_has_usergroup_usergroup_id_fkey FOREIGN KEY (usergroup_id) REFERENCES public.usergroup(id);


--
-- Name: userdevicelevelgroup_has_logbook userdevicelevelgroup_has_logbook_logbook_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userdevicelevelgroup_has_logbook
    ADD CONSTRAINT userdevicelevelgroup_has_logbook_logbook_id_fkey FOREIGN KEY (logbook_id) REFERENCES public.logbook(id);


--
-- Name: userdevicelevelgroup_has_logbook userdevicelevelgroup_has_logbook_userdevicelevelgroup_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userdevicelevelgroup_has_logbook
    ADD CONSTRAINT userdevicelevelgroup_has_logbook_userdevicelevelgroup_id_fkey FOREIGN KEY (userdevicelevelgroup_id) REFERENCES public.userdevicelevelgroup(id);


--
-- Name: usergroup_has_logbook usergroup_has_logbook_logbook_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usergroup_has_logbook
    ADD CONSTRAINT usergroup_has_logbook_logbook_id_fkey FOREIGN KEY (logbook_id) REFERENCES public.logbook(id);


--
-- Name: usergroup_has_logbook usergroup_has_logbook_usergroup_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usergroup_has_logbook
    ADD CONSTRAINT usergroup_has_logbook_usergroup_id_fkey FOREIGN KEY (usergroup_id) REFERENCES public.usergroup(id);


--
-- Name: usergroup_has_userrole usergroup_has_userrole_usergroup_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usergroup_has_userrole
    ADD CONSTRAINT usergroup_has_userrole_usergroup_id_fkey FOREIGN KEY (usergroup_id) REFERENCES public.usergroup(id);


--
-- Name: usergroup_has_userrole usergroup_has_userrole_userrole_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usergroup_has_userrole
    ADD CONSTRAINT usergroup_has_userrole_userrole_id_fkey FOREIGN KEY (userrole_id) REFERENCES public.userrole(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

\unrestrict UXnMPFBLlmAk8UnUqZQSA46ehOc2Yd1f6wh8OhYaXJ6d7wrc7KrSvC0tReeB6YJ

