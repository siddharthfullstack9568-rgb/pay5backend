--
-- PostgreSQL database dump
--

-- Dumped from database version 13.16 (Ubuntu 13.16-1.pgdg20.04+1)
-- Dumped by pg_dump version 15.12 (Ubuntu 15.12-1.pgdg20.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: account_transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_transactions (
    id bigint NOT NULL,
    txn_id character varying,
    amount numeric,
    reason character varying,
    user_code character varying,
    mobile character varying,
    txn_type character varying,
    user_type character varying,
    user_name character varying,
    status character varying,
    parent_id integer,
    user_id bigint NOT NULL,
    wallet_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.account_transactions OWNER TO postgres;

--
-- Name: account_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_transactions_id_seq OWNER TO postgres;

--
-- Name: account_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_transactions_id_seq OWNED BY public.account_transactions.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO postgres;

--
-- Name: banks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.banks (
    id bigint NOT NULL,
    bank_name character varying,
    account_name character varying,
    ifsc_code character varying,
    account_number character varying,
    account_type character varying,
    first_name character varying,
    last_name character varying,
    initial_balance numeric,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.banks OWNER TO postgres;

--
-- Name: banks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.banks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.banks_id_seq OWNER TO postgres;

--
-- Name: banks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.banks_id_seq OWNED BY public.banks.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    title character varying,
    image character varying,
    status boolean,
    service_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: commissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.commissions (
    id bigint NOT NULL,
    commission_type character varying,
    from_role character varying,
    to_role character varying,
    value numeric,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    service_product_item_id bigint NOT NULL,
    scheme_id bigint
);


ALTER TABLE public.commissions OWNER TO postgres;

--
-- Name: commissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.commissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.commissions_id_seq OWNER TO postgres;

--
-- Name: commissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.commissions_id_seq OWNED BY public.commissions.id;


--
-- Name: enquiries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enquiries (
    id bigint NOT NULL,
    first_name character varying,
    last_name character varying,
    email character varying,
    phone_number character varying,
    aadhaar_number character varying,
    pan_card character varying,
    status boolean DEFAULT false,
    role_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.enquiries OWNER TO postgres;

--
-- Name: enquiries_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.enquiries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.enquiries_id_seq OWNER TO postgres;

--
-- Name: enquiries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.enquiries_id_seq OWNED BY public.enquiries.id;


--
-- Name: fund_requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fund_requests (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    requested_by integer,
    amount numeric,
    status character varying,
    approved_by integer,
    approved_at timestamp(6) without time zone,
    remark character varying,
    image character varying,
    transaction_type character varying,
    mode character varying,
    bank_reference_no character varying,
    payment_mode character varying,
    deposit_bank character varying,
    your_bank character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.fund_requests OWNER TO postgres;

--
-- Name: fund_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fund_requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fund_requests_id_seq OWNER TO postgres;

--
-- Name: fund_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fund_requests_id_seq OWNED BY public.fund_requests.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    title character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: schemes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schemes (
    id bigint NOT NULL,
    scheme_name character varying,
    scheme_type character varying,
    commision_rate numeric,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.schemes OWNER TO postgres;

--
-- Name: schemes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.schemes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.schemes_id_seq OWNER TO postgres;

--
-- Name: schemes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.schemes_id_seq OWNED BY public.schemes.id;


--
-- Name: service_product_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.service_product_items (
    id bigint NOT NULL,
    service_product_id bigint NOT NULL,
    name character varying,
    oprator_type character varying,
    status character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.service_product_items OWNER TO postgres;

--
-- Name: service_product_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.service_product_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.service_product_items_id_seq OWNER TO postgres;

--
-- Name: service_product_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.service_product_items_id_seq OWNED BY public.service_product_items.id;


--
-- Name: service_products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.service_products (
    id bigint NOT NULL,
    company_name character varying,
    admin_commission numeric,
    master_commission numeric,
    dealer_commission numeric,
    retailer_commission numeric,
    category_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.service_products OWNER TO postgres;

--
-- Name: service_products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.service_products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.service_products_id_seq OWNER TO postgres;

--
-- Name: service_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.service_products_id_seq OWNED BY public.service_products.id;


--
-- Name: services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.services (
    id bigint NOT NULL,
    title character varying,
    status boolean,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    logo character varying,
    "position" integer
);


ALTER TABLE public.services OWNER TO postgres;

--
-- Name: services_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.services_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.services_id_seq OWNER TO postgres;

--
-- Name: services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.services_id_seq OWNED BY public.services.id;


--
-- Name: transaction_commissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transaction_commissions (
    id bigint NOT NULL,
    transaction_id bigint NOT NULL,
    user_id bigint NOT NULL,
    role integer,
    commission_amount numeric,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    service_product_item_id bigint
);


ALTER TABLE public.transaction_commissions OWNER TO postgres;

--
-- Name: transaction_commissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transaction_commissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transaction_commissions_id_seq OWNER TO postgres;

--
-- Name: transaction_commissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transaction_commissions_id_seq OWNED BY public.transaction_commissions.id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transactions (
    id bigint NOT NULL,
    tx_id character varying,
    operator character varying,
    transaction_type character varying,
    account_or_mobile character varying,
    amount numeric,
    status character varying,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    service_product_id bigint
);


ALTER TABLE public.transactions OWNER TO postgres;

--
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transactions_id_seq OWNER TO postgres;

--
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;


--
-- Name: user_services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_services (
    id bigint NOT NULL,
    assigner_id bigint NOT NULL,
    assignee_id bigint NOT NULL,
    service_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.user_services OWNER TO postgres;

--
-- Name: user_services_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_services_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_services_id_seq OWNER TO postgres;

--
-- Name: user_services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_services_id_seq OWNED BY public.user_services.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    first_name character varying,
    last_name character varying,
    email character varying,
    password_digest character varying,
    role integer,
    otp integer,
    verify_otp integer,
    otp_expires_at timestamp(6) without time zone,
    phone_number character varying,
    country_code character varying,
    alternative_number character varying,
    aadhaar_number character varying,
    pan_card character varying,
    date_of_birth date,
    gender character varying,
    business_name character varying,
    business_owner_type character varying,
    business_nature_type character varying,
    business_registration_number character varying,
    gst_number character varying,
    pan_number character varying,
    address text,
    city character varying,
    state character varying,
    pincode character varying,
    landmark character varying,
    username character varying,
    scheme character varying,
    referred_by character varying,
    bank_name character varying,
    account_number character varying,
    ifsc_code character varying,
    account_holder_name character varying,
    notes text,
    session_token text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    role_id bigint DEFAULT 1 NOT NULL,
    status boolean DEFAULT false,
    company_type character varying,
    company_name character varying,
    cin_number character varying,
    registration_certificate character varying,
    user_admin_id integer,
    confirm_password character varying,
    domain_name character varying,
    scheme_id bigint,
    service_id bigint,
    pan_card_image character varying,
    aadhaar_image character varying,
    passport_photo character varying,
    store_shop_photo character varying,
    address_proof_photo character varying,
    parent_id integer,
    set_pin character varying,
    confirm_pin character varying
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: wallet_transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wallet_transactions (
    id bigint NOT NULL,
    wallet_id bigint NOT NULL,
    tx_id character varying(50) NOT NULL,
    mode character varying NOT NULL,
    transaction_type character varying NOT NULL,
    amount numeric(12,2) NOT NULL,
    status character varying DEFAULT 'pending'::character varying,
    description text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    fund_request_id bigint NOT NULL
);


ALTER TABLE public.wallet_transactions OWNER TO postgres;

--
-- Name: wallet_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wallet_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wallet_transactions_id_seq OWNER TO postgres;

--
-- Name: wallet_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wallet_transactions_id_seq OWNED BY public.wallet_transactions.id;


--
-- Name: wallets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wallets (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    balance numeric,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.wallets OWNER TO postgres;

--
-- Name: wallets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wallets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wallets_id_seq OWNER TO postgres;

--
-- Name: wallets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wallets_id_seq OWNED BY public.wallets.id;


--
-- Name: account_transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_transactions ALTER COLUMN id SET DEFAULT nextval('public.account_transactions_id_seq'::regclass);


--
-- Name: banks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.banks ALTER COLUMN id SET DEFAULT nextval('public.banks_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: commissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commissions ALTER COLUMN id SET DEFAULT nextval('public.commissions_id_seq'::regclass);


--
-- Name: enquiries id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enquiries ALTER COLUMN id SET DEFAULT nextval('public.enquiries_id_seq'::regclass);


--
-- Name: fund_requests id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fund_requests ALTER COLUMN id SET DEFAULT nextval('public.fund_requests_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: schemes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schemes ALTER COLUMN id SET DEFAULT nextval('public.schemes_id_seq'::regclass);


--
-- Name: service_product_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_product_items ALTER COLUMN id SET DEFAULT nextval('public.service_product_items_id_seq'::regclass);


--
-- Name: service_products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_products ALTER COLUMN id SET DEFAULT nextval('public.service_products_id_seq'::regclass);


--
-- Name: services id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services ALTER COLUMN id SET DEFAULT nextval('public.services_id_seq'::regclass);


--
-- Name: transaction_commissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_commissions ALTER COLUMN id SET DEFAULT nextval('public.transaction_commissions_id_seq'::regclass);


--
-- Name: transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);


--
-- Name: user_services id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_services ALTER COLUMN id SET DEFAULT nextval('public.user_services_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: wallet_transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallet_transactions ALTER COLUMN id SET DEFAULT nextval('public.wallet_transactions_id_seq'::regclass);


--
-- Name: wallets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallets ALTER COLUMN id SET DEFAULT nextval('public.wallets_id_seq'::regclass);


--
-- Data for Name: account_transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_transactions (id, txn_id, amount, reason, user_code, mobile, txn_type, user_type, user_name, status, parent_id, user_id, wallet_id, created_at, updated_at) FROM stdin;
1	TXN927104	2.0	Reason 1	\N	323243434343	Credit	\N	\N	success	104	127	8	2025-09-15 06:38:25.675895	2025-09-15 06:38:25.675895
2	TXN778846	2.0	Reason 1	\N	323243434343	Debit	\N	\N	success	104	127	8	2025-09-15 06:39:18.562588	2025-09-15 06:39:18.562588
3	TXN734549	2.0	Reason 1	\N	323243434343	Credit	\N	\N	success	104	127	8	2025-09-15 06:43:02.435203	2025-09-15 06:43:02.435203
4	TXN433798	2.0	Reason 1	\N	323243434343	Debit	\N	\N	success	104	127	8	2025-09-15 06:43:38.828927	2025-09-15 06:43:38.828927
5	TXN505620	2.0	Reason 1	\N	323243434343	Debit	\N	\N	success	104	127	8	2025-09-15 06:45:00.906546	2025-09-15 06:45:00.906546
6	TXN102263	5.0	Reason 1	\N	323243434343	Debit	\N	\N	success	104	127	8	2025-09-15 06:45:30.808059	2025-09-15 06:45:30.808059
7	TXN260008	5.0	Reason 1	\N	323243434343	Credit	\N	\N	success	104	127	8	2025-09-15 06:46:23.242174	2025-09-15 06:46:23.242174
8	TXN541011	5.0	Reason 1	\N	323243434343	Credit	\N	\N	success	104	127	8	2025-09-15 06:48:36.899376	2025-09-15 06:48:36.899376
9	TXN151049	5.0	Reason 1	\N	323243434343	Debit	\N	\N	success	104	127	8	2025-09-15 06:49:14.379198	2025-09-15 06:49:14.379198
10	TXN179949	5.0	Reason 1	\N	94434349494	Credit	\N	\N	success	\N	104	7	2025-09-15 06:51:02.519043	2025-09-15 06:51:02.519043
11	TXN182174	5.0	Reason 1	\N	94434349494	Credit	\N	\N	success	136	104	7	2025-09-15 06:52:13.362436	2025-09-15 06:52:13.362436
12	TXN139539	5.0	Reason 1	\N	94434349494	Debit	\N	\N	success	136	104	7	2025-09-15 06:53:48.242601	2025-09-15 06:53:48.242601
13	TXN579314	120.0	Reason 1	\N	9568773855	Credit	\N	\N	success	104	134	10	2025-09-15 13:04:00.408368	2025-09-15 13:04:00.408368
14	TXN657453	8.0	Reason 1	\N	9568773855	Debit	\N	\N	success	104	134	10	2025-09-15 13:04:42.802394	2025-09-15 13:04:42.802394
15	TXN676719	100.0	Reason 1	\N	9568773855	Debit	\N	\N	success	104	134	10	2025-09-15 13:42:54.72828	2025-09-15 13:42:54.72828
16	TXN512730	120.0	Reason 1	\N	9568773855	Credit	\N	\N	success	104	134	10	2025-09-15 13:43:52.551655	2025-09-15 13:43:52.551655
17	TXN668514	2.0	Reason 1	\N	94434349494	Credit	\N	\N	success	136	104	7	2025-09-15 17:26:29.17496	2025-09-15 17:26:29.17496
18	TXN532510	50000.0	Reason 1	\N	9568773855	Credit	\N	\N	success	104	134	10	2025-09-16 13:23:25.848647	2025-09-16 13:23:25.848647
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2025-08-19 11:00:42.469236	2025-08-19 11:00:42.469242
\.


--
-- Data for Name: banks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.banks (id, bank_name, account_name, ifsc_code, account_number, account_type, first_name, last_name, initial_balance, created_at, updated_at) FROM stdin;
1	ds	\N	ds	ds		\N	\N	23232.0	2025-09-01 11:11:59.373553	2025-09-01 11:11:59.373553
2	Axis	\N	AXIS89SX	779776876567576576	savings	Siddharth Gautam		1000.0	2025-09-01 11:13:25.981914	2025-09-01 11:58:37.973077
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, title, image, status, service_id, created_at, updated_at) FROM stdin;
14	Utility Bills	\N	\N	7	2025-09-04 06:56:51.899042	2025-09-09 04:59:00.092412
15	Telecom & DTH	\N	\N	7	2025-09-04 06:57:05.940464	2025-09-09 04:59:10.380441
19	Broadband Recharge	\N	\N	7	2025-09-09 06:16:44.383822	2025-09-09 06:16:44.383822
16	Financial Service	\N	\N	7	2025-09-04 06:57:22.614	2025-09-09 13:02:44.18975
17	Gov Payments	\N	\N	7	2025-09-04 06:57:35.120447	2025-09-09 13:04:20.275432
18	Subscription & Offers	\N	\N	7	2025-09-09 05:04:50.414025	2025-09-09 13:05:33.000885
20	Utility Bills	\N	\N	8	2025-09-10 04:42:27.417519	2025-09-10 04:42:27.417519
21	Telecom & DTH	\N	\N	8	2025-09-10 04:42:38.665596	2025-09-10 04:42:38.665596
22	Financial Service	\N	\N	8	2025-09-10 04:42:48.938126	2025-09-10 04:42:48.938126
23	Gov Payments	\N	\N	8	2025-09-10 04:43:01.593211	2025-09-10 04:43:01.593211
26	Flight Booking	\N	\N	1	2025-09-16 05:51:17.413975	2025-09-16 05:51:17.413975
27	Bus Booking	\N	\N	1	2025-09-16 05:51:33.662226	2025-09-16 05:51:33.662226
13	Hotel Booking	\N	\N	1	2025-09-04 06:52:47.257969	2025-09-16 14:15:22.007462
25	test	\N	\N	7	2025-09-10 13:15:08.646132	2025-09-19 05:51:29.427621
\.


--
-- Data for Name: commissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.commissions (id, commission_type, from_role, to_role, value, created_at, updated_at, service_product_item_id, scheme_id) FROM stdin;
75	commission	superadmin	admin	8.0	2025-09-18 05:54:41.807196	2025-09-18 05:54:41.807196	1	5
76	commission	admin	retailer	5.0	2025-09-18 05:55:47.07042	2025-09-18 05:55:47.07042	1	5
\.


--
-- Data for Name: enquiries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enquiries (id, first_name, last_name, email, phone_number, aadhaar_number, pan_card, status, role_id, created_at, updated_at) FROM stdin;
1	Siddharth	gautam	sid12321@gmail.com	7879879879	987969668768	\N	t	5	2025-08-28 07:40:17.022381	2025-08-28 07:44:12.203754
2	Mohammad	Aamir	aman@gmail.com	6776767687	557686757858	\N	f	5	2025-08-28 08:39:51.331706	2025-08-28 08:39:51.331706
3	Gulshan	Gautam	gulshan@gmail.com	9877987879	687856567576	\N	t	5	2025-08-28 08:48:28.503893	2025-08-28 09:04:36.911381
4	Satish	kumar	satish@gmail.com	9877989879	789789879877	\N	t	5	2025-08-28 09:06:59.523494	2025-08-28 09:08:17.361513
5	khalid	abdul	khalid@gmail.com	7886867869	689676785768	\N	t	5	2025-08-28 09:15:50.225575	2025-08-28 09:18:02.941339
6	sandeep	kumar	sandeep@gmail.com	9877987798	987797987987	\N	t	5	2025-08-28 10:04:15.383853	2025-08-28 10:10:56.088823
7	Sameer	khsn	sameer@gmail.com	4354354364	837583465724	\N	t	7	2025-08-28 10:32:03.86179	2025-08-28 10:34:33.231633
9	Manoj	kumar	manoj@gmail.com	9877987979	087987979868	\N	t	5	2025-08-28 13:40:17.14873	2025-08-28 13:42:05.492517
10	Anurag	singh	anurag@gmail.com	7686868686	879878797987	\N	f	5	2025-09-17 07:00:57.252527	2025-09-17 07:00:57.252527
11	Mohammad	Aamir	f@jjh	0875685476	\N	YUUYY4545J	f	6	2025-09-17 07:44:48.337068	2025-09-17 07:44:48.337068
\.


--
-- Data for Name: fund_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fund_requests (id, user_id, requested_by, amount, status, approved_by, approved_at, remark, image, transaction_type, mode, bank_reference_no, payment_mode, deposit_bank, your_bank, created_at, updated_at) FROM stdin;
11	127	104	10.0	\N	\N	\N	test	\N	UPI	credit	879879ds787878	\N	Axis	HDFC	2025-09-06 10:53:22.238745	2025-09-06 10:53:22.238745
12	127	104	10.0	\N	\N	\N	test	\N	UPI	credit	879879ds787878	\N	Axis	HDFC	2025-09-06 10:58:12.306457	2025-09-06 10:58:12.306457
13	127	104	10.0	\N	\N	\N	test	\N	UPI	credit	879879ds787878	\N	Axis	HDFC	2025-09-06 10:58:36.043983	2025-09-06 10:58:36.043983
15	127	104	10.0	\N	\N	\N	bhej do bhai	null	CashInBank	credit	208987	\N	SBI	HDFC	2025-09-06 11:01:16.175689	2025-09-06 11:01:16.175689
16	127	104	20.0	\N	\N	\N	de do na	null	NEFT	credit	43543	\N	SBI	SBI	2025-09-06 11:08:17.288251	2025-09-06 11:08:17.288251
17	127	104	5.0	\N	\N	\N	dfgd	null	UPI	credit	454353435	\N	HDFC	ICICI	2025-09-06 11:10:11.793622	2025-09-06 11:10:11.793622
18	127	104	20.0	\N	\N	\N	de do mera paisa	null	Cheque	credit	86876876	\N	SBI	HDFC	2025-09-06 11:15:13.014605	2025-09-06 11:15:13.014605
19	127	104	40.0	\N	\N	\N		null	CashInBank	credit	45	\N	SBI	ICICI	2025-09-06 11:20:57.526698	2025-09-06 11:20:57.526698
20	127	104	400.0	\N	\N	\N		null	CashInBank	credit	86876876	\N	HDFC	HDFC	2025-09-06 11:22:08.43994	2025-09-06 11:22:08.43994
21	127	104	600.0	\N	\N	\N		null	Netbanking	credit	86876876	\N	SBI	SBI	2025-09-06 11:27:09.982909	2025-09-06 11:27:09.982909
22	127	104	1.0	\N	\N	\N		null	Cash	credit	2332	\N	HDFC	SBI	2025-09-06 11:32:10.205525	2025-09-06 11:32:10.205525
23	127	104	500.0	\N	\N	\N		null	Cheque	credit	897987	\N	HDFC	HDFC	2025-09-06 11:37:10.679613	2025-09-06 11:37:10.679613
24	127	104	500.0	\N	\N	\N		null	Cheque	credit	897987	\N	HDFC	HDFC	2025-09-06 11:37:53.467712	2025-09-06 11:37:53.467712
25	127	104	500.0	\N	\N	\N		null	Cheque	credit	897987	\N	HDFC	HDFC	2025-09-06 11:38:34.42233	2025-09-06 11:38:34.42233
26	127	104	200.0	\N	\N	\N		null	CashInBank	credit	87	\N	HDFC	AXIS	2025-09-06 11:39:25.212643	2025-09-06 11:39:25.212643
27	127	104	76.0	\N	\N	\N		null	NEFT	credit	769	\N	HDFC	ICICI	2025-09-06 11:57:13.457331	2025-09-06 11:57:13.457331
28	127	104	300.0	\N	\N	\N		null	CashInBank	credit	34534	\N	HDFC	HDFC	2025-09-06 12:03:54.839562	2025-09-06 12:03:54.839562
29	127	104	2.0	\N	\N	\N		null	Netbanking	credit	86876876	\N	HDFC	ICICI	2025-09-06 12:09:59.78103	2025-09-06 12:09:59.78103
30	127	104	1.0	\N	\N	\N		null	CashInBank	credit	86876876	\N	HDFC	SBI	2025-09-06 12:14:14.926249	2025-09-06 12:14:14.926249
32	127	104	31.0	\N	\N	\N	test	null	UPI	credit	ghhg566556	\N	HDFC	HDFC	2025-09-06 12:20:08.384143	2025-09-06 12:20:08.384143
33	127	104	35.0	\N	\N	\N		null	Cheque	credit	89698	\N	HDFC	SBI	2025-09-06 12:25:32.369262	2025-09-06 12:25:32.369262
34	127	104	70.0	\N	\N	\N		null	UPI	credit	233	\N	SBI	ICICI	2025-09-06 12:26:55.606828	2025-09-06 12:26:55.606828
35	127	104	7.0	\N	\N	\N		null	UPI	credit	233	\N	SBI	ICICI	2025-09-06 12:28:15.177185	2025-09-06 12:28:15.177185
39	127	104	93.0	\N	\N	\N		null	NEFT	credit	1	\N	SBI	SBI	2025-09-06 12:35:37.104368	2025-09-06 12:35:37.104368
40	127	104	400.0	\N	\N	\N		null	CashInBank	credit	86876876	\N	HDFC	PNB	2025-09-06 12:36:21.959471	2025-09-06 12:36:21.959471
43	127	104	100.0	\N	\N	\N		null	NEFT	credit	86876876	\N	SBI	HDFC	2025-09-06 12:52:53.423225	2025-09-06 12:52:53.423225
45	127	104	100.0	\N	\N	\N		null	Cheque	credit	86876876	\N	SBI	AXIS	2025-09-06 13:02:08.8759	2025-09-06 13:02:08.8759
46	127	104	1000.0	\N	\N	\N		null	CashInBank	credit	56757	\N	ICICI	AXIS	2025-09-08 04:47:39.042799	2025-09-08 04:47:39.042799
47	127	104	100.0	\N	\N	\N		null	IMPS	credit	4534	\N	SBI	SBI	2025-09-08 05:38:42.852321	2025-09-08 05:38:42.852321
48	139	\N	200.0	\N	\N	\N	malik	null	NEFT	credit	32444435	\N	SBI	HDFC	2025-09-08 05:43:00.558427	2025-09-08 05:43:00.558427
49	139	104	299.0	\N	\N	\N	malik	null	NEFT	credit	32444435	\N	SBI	HDFC	2025-09-08 05:44:50.488068	2025-09-08 05:44:50.488068
50	134	104	399.0	\N	\N	\N	test	null	NEFT	credit	100dsdddsds	\N	HDFC	ICICI	2025-09-08 06:37:14.65265	2025-09-08 06:37:14.65265
51	134	104	100.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	SBI	2025-09-08 07:28:52.968781	2025-09-08 07:28:52.968781
52	134	104	120.0	\N	\N	\N	test	null	NEFT	credit	100dsdddsds	\N	ICICI	HDFC	2025-09-08 07:45:11.344586	2025-09-08 07:45:11.344586
57	139	104	997.0	\N	\N	\N	malik	null	Netbanking	credit	32444435	\N	HDFC	SBI	2025-09-08 12:31:35.781488	2025-09-08 12:31:35.781488
58	139	104	500.0	\N	\N	\N	malik	null	Netbanking	credit	32444435	\N	SBI	SBI	2025-09-08 12:34:09.578595	2025-09-08 12:34:09.578595
60	127	104	100.0	\N	\N	\N		null	Cash	credit	564	\N	SBI	SBI	2025-09-10 13:31:42.342144	2025-09-10 13:31:42.342144
61	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 06:42:27.945305	2025-09-11 06:42:27.945305
62	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 07:38:16.938037	2025-09-11 07:38:16.938037
63	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 07:39:29.96736	2025-09-11 07:39:29.96736
64	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 07:40:27.444735	2025-09-11 07:40:27.444735
65	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 07:56:25.320924	2025-09-11 07:56:25.320924
66	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 08:38:21.030052	2025-09-11 08:38:21.030052
67	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 08:40:14.005162	2025-09-11 08:40:14.005162
69	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 08:45:56.258823	2025-09-11 08:45:56.258823
71	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 09:16:37.343503	2025-09-11 09:16:37.343503
6	104	136	12.0	success	\N	\N	test	\N	UPI	credit	hjkh978787879879	\N	SBI	SBI	2025-09-06 09:24:59.568809	2025-09-12 12:43:28.294395
9	104	136	20.0	success	\N	\N	test	\N	UPI	credit	hjhjhdjs766868	\N	SBI	AXIS	2025-09-06 09:57:23.541551	2025-09-12 12:43:28.296918
73	127	104	10000.0	\N	\N	\N		null	UPI	credit	4565465465464564645	\N	SBI	SBI	2025-09-11 09:56:48.199583	2025-09-11 09:56:48.199583
74	139	104	10000.0	\N	\N	\N		null	UPI	credit	32444435	\N	HDFC	ICICI	2025-09-11 09:56:48.428133	2025-09-11 09:56:48.428133
75	127	104	1000.0	\N	\N	\N		null	Netbanking	credit	2	\N	HDFC	SBI	2025-09-11 09:59:40.800117	2025-09-11 09:59:40.800117
76	139	104	90000.0	\N	\N	\N		null	Cheque	credit	32444435	\N	SBI	ICICI	2025-09-11 11:04:05.638344	2025-09-11 11:04:05.638344
77	134	104	120.0	\N	\N	\N	test	null	UPI	credit	Upi79879897csd	\N	HDFC	ICICI	2025-09-11 12:55:29.635289	2025-09-11 12:55:29.635289
79	139	104	333.0	\N	\N	\N		null	Cash	credit	32444435	\N	HDFC	HDFC	2025-09-11 14:12:28.311338	2025-09-11 14:12:28.311338
90	139	104	44.0	\N	\N	\N		null	Cheque	credit	32444435	\N	HDFC	SBI	2025-09-12 10:56:50.797145	2025-09-12 10:56:50.797145
91	127	104	2000.0	\N	\N	\N		null	Netbanking	credit	d	\N	SBI	SBI	2025-09-12 10:58:46.382606	2025-09-12 10:58:46.382606
98	139	104	85.0	\N	\N	\N		null	Cash	credit	32444435	\N	SBI	ICICI	2025-09-12 12:05:31.001945	2025-09-12 12:05:31.001945
99	138	\N	100.0	pending	\N	\N		\N	IMPS	\N	87	\N	SBI	SBI	2025-09-12 12:06:33.52371	2025-09-12 12:06:33.52371
31	104	136	30.0	success	\N	\N	test	\N	NEFT	credit	hjkh978787879879	\N	SBI	HDFC	2025-09-06 12:19:01.760776	2025-09-12 12:43:28.299106
36	104	136	100.0	success	\N	\N	test	\N	UPI	credit	lkjdshd79887687	\N	SBI	SBI	2025-09-06 12:32:32.729136	2025-09-12 12:43:28.301199
37	104	136	100.0	success	\N	\N	test	\N	NEFT	credit	jjdsh7686887	\N	SBI	SBI	2025-09-06 12:34:04.571712	2025-09-12 12:43:28.303474
38	104	136	100.0	success	\N	\N	test	\N	UPI	credit	sdsdsds	\N	SBI	HDFC	2025-09-06 12:34:52.777219	2025-09-12 12:43:28.305685
41	104	136	1000.0	success	\N	\N	test	\N	UPI	credit	hjkh978787879879	\N	HDFC	HDFC	2025-09-06 12:36:50.754006	2025-09-12 12:43:28.308021
42	104	136	100.0	success	\N	\N	Test	\N	UPI	credit	jHJKJHH787987	\N	HDFC	PNB	2025-09-06 12:50:35.90369	2025-09-12 12:43:28.31011
44	104	136	100.0	success	\N	\N	test	\N	UPI	credit	UPI95687586867	\N	SBI	SBI	2025-09-06 12:59:23.04227	2025-09-12 12:43:28.312366
53	104	136	100.0	success	\N	\N	test	\N	NEFT	credit	33232332	\N	SBI	SBI	2025-09-08 07:53:10.183143	2025-09-12 12:43:28.314382
54	104	136	100.0	success	\N	\N	test	\N	NEFT	credit	hjkh978787879879	\N	ICICI	HDFC	2025-09-08 08:30:37.275921	2025-09-12 12:43:28.316729
55	104	136	100.0	success	\N	\N	test	\N	CashInBank	credit	hjkh9787878798792222	\N	ICICI	HDFC	2025-09-08 08:32:27.761322	2025-09-12 12:43:28.319255
56	104	136	100.0	success	\N	\N	test	\N	UPI	credit	hjkh9787878798792222	\N	ICICI	ICICI	2025-09-08 08:33:58.913333	2025-09-12 12:43:28.321487
59	104	136	1000.0	success	\N	\N	test	\N	UPI	credit	hjkh978787879879	\N	ICICI	ICICI	2025-09-08 13:22:27.727574	2025-09-12 12:43:28.323919
68	104	136	300000.0	success	\N	\N	test	\N	UPI	credit	hjkh978787879879	\N	SBI	SBI	2025-09-11 08:41:07.372091	2025-09-12 12:43:28.327345
70	104	136	1000.0	success	\N	\N	test	\N	UPI	credit	jjkjds89809	\N	SBI	HDFC	2025-09-11 09:16:03.652824	2025-09-12 12:43:28.33054
72	104	136	100.0	success	\N	\N	test	\N	UPI	credit	hjkh978787879879	\N	HDFC	AXIS	2025-09-11 09:46:31.307035	2025-09-12 12:43:28.333577
78	104	136	100.0	success	\N	\N	test	\N	UPI	credit	Appim77987n	\N	SBI	HDFC	2025-09-11 12:56:20.453078	2025-09-12 12:43:28.336067
80	104	136	1089.0	success	\N	\N	test	\N	UPI	credit	SSid89897676	\N	HDFC	HDFC	2025-09-11 14:13:40.673541	2025-09-12 12:43:28.338282
81	104	136	5.0	success	\N	\N	test	\N	UPI	\N	hjkh978787879879	\N	SBI	SBI	2025-09-12 10:33:14.196391	2025-09-12 12:43:28.340767
82	104	136	5.0	success	\N	\N	test	\N	NEFT	\N	hjkh978787879879	\N	HDFC	HDFC	2025-09-12 10:35:42.102839	2025-09-12 12:43:28.343657
83	104	136	5.0	success	\N	\N	test	\N	UPI	\N	hjkh978787879879	\N	HDFC	SBI	2025-09-12 10:36:44.718712	2025-09-12 12:43:28.346525
84	104	136	5.0	success	\N	\N	test	\N	UPI	\N	hjkh978787879879	\N	SBI	HDFC	2025-09-12 10:39:31.020996	2025-09-12 12:43:28.3496
85	104	136	1.0	success	\N	\N		\N	NEFT	\N	hjkh978787879879	\N	SBI	SBI	2025-09-12 10:42:38.385524	2025-09-12 12:43:28.352403
86	104	136	3.0	success	\N	\N		\N	IMPS	\N	hjkh978787879879	\N	SBI	HDFC	2025-09-12 10:45:43.800779	2025-09-12 12:43:28.355145
87	104	136	5.0	success	\N	\N	test	\N	UPI	\N	hjkh978787879879	\N	ICICI	AXIS	2025-09-12 10:48:09.017809	2025-09-12 12:43:28.357609
88	104	136	5.0	success	\N	\N	test	\N	UPI	\N	hjkh978787879879	\N	HDFC	ICICI	2025-09-12 10:49:33.146204	2025-09-12 12:43:28.360077
89	104	136	5.0	success	\N	\N	test	\N	CashInBank	\N	hjkh978787879879	\N	HDFC	SBI	2025-09-12 10:56:10.923195	2025-09-12 12:43:28.362274
92	104	136	9.0	success	\N	\N	test	\N	NEFT	\N	33232332	\N	SBI	HDFC	2025-09-12 11:04:17.82122	2025-09-12 12:43:28.364573
93	104	136	5.0	success	\N	\N	test	\N	UPI	\N	hjkh978787879879	\N	SBI	SBI	2025-09-12 11:07:46.064179	2025-09-12 12:43:28.36684
94	104	136	5.0	success	\N	\N	test	\N	NEFT	\N	hjkh978787879879	\N	HDFC	HDFC	2025-09-12 11:09:37.755661	2025-09-12 12:43:28.368906
95	104	136	5.0	success	\N	\N	test	\N	UPI	\N	hjkh9787878798792222	\N	HDFC	HDFC	2025-09-12 11:41:44.662777	2025-09-12 12:43:28.372248
96	104	136	5.0	success	\N	\N	test	\N	UPI	\N	ddd	\N	HDFC	HDFC	2025-09-12 11:44:37.158235	2025-09-12 12:43:28.374441
97	104	136	5.0	success	\N	\N	test	\N	UPI	\N	hjkh978787879879	\N	ICICI	HDFC	2025-09-12 11:46:17.530108	2025-09-12 12:43:28.376855
100	104	136	5.0	success	\N	\N		\N	NEFT	\N	hjkh978787879879	\N	HDFC	HDFC	2025-09-12 12:07:09.153851	2025-09-12 12:43:28.379102
101	138	136	100.0	success	\N	\N		\N	IMPS	\N	1	\N	SBI	SBI	2025-09-12 12:10:10.589275	2025-09-12 12:43:28.381597
102	141	136	85.0	success	\N	\N	...	\N	UPI	\N	8888	\N	HDFC	HDFC	2025-09-12 12:11:31.792498	2025-09-12 12:43:28.383783
103	141	136	90.0	success	\N	\N	mm	\N	Cash	\N	8888	\N	HDFC	AXIS	2025-09-12 12:41:03.003884	2025-09-12 12:43:28.385955
104	141	136	100.0	pending	\N	\N	malik	\N	Cash	\N	8888	\N	HDFC	AXIS	2025-09-12 12:47:36.187494	2025-09-12 12:47:36.187494
105	134	104	100.0	\N	\N	\N	test	null	NEFT	credit	Upi79879897csd	\N	SBI	HDFC	2025-09-15 17:29:52.85102	2025-09-15 17:29:52.85102
106	127	104	50000.0	\N	\N	\N	ret	null	UPI	credit	34534	\N	HDFC	HDFC	2025-09-18 07:03:50.157983	2025-09-18 07:03:50.157983
107	127	104	2000.0	\N	\N	\N	dfg	null	CashInBank	credit	345	\N	SBI	HDFC	2025-09-18 07:13:36.791823	2025-09-18 07:13:36.791823
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, title, created_at, updated_at) FROM stdin;
5	retailer	2025-08-27 05:50:00.645062	2025-08-27 05:50:00.645062
6	master	2025-08-27 05:50:06.010086	2025-08-27 05:50:06.010086
7	dealer	2025-08-27 05:50:11.616887	2025-08-27 05:50:11.616887
9	admin	2025-08-29 16:08:23.094433	2025-08-29 16:08:23.094433
10	superadmin	2025-09-04 07:51:41.59287	2025-09-04 07:51:41.59287
11	customer	2025-09-19 06:29:00.92764	2025-09-19 06:29:00.92764
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (version) FROM stdin;
20250823112328
20250823114245
20250823114620
20250827114427
20250830054607
20250830055652
20250830112731
20250830113511
20250901104230
20250902060329
20250902095209
20250902111639
20250903064239
20250903092958
20250903113045
20250904180442
20250905054404
20250905091838
20250906054117
20250906061333
20250908095353
20250909105011
20250912074440
20250915085332
20250915104110
20250915105112
20250916103844
20250917051630
20250919105236
\.


--
-- Data for Name: schemes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schemes (id, scheme_name, scheme_type, commision_rate, created_at, updated_at) FROM stdin;
5	Gold	Flat	10.0	2025-08-30 07:44:33.414877	2025-08-30 07:44:33.414877
16	Silver	Percentage	5.0	2025-09-15 18:36:11.457301	2025-09-15 18:36:11.457301
17	Platinam	Percentage	7.0	2025-09-15 18:36:21.455747	2025-09-15 18:36:21.455747
\.


--
-- Data for Name: service_product_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.service_product_items (id, service_product_id, name, oprator_type, status, created_at, updated_at) FROM stdin;
1	11	Airtel	Prepaid	\N	2025-09-15 18:11:48.643332	2025-09-15 18:11:48.643332
2	11	Jio	Prepaid	\N	2025-09-15 18:11:54.866692	2025-09-15 18:11:54.866692
\.


--
-- Data for Name: service_products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.service_products (id, company_name, admin_commission, master_commission, dealer_commission, retailer_commission, category_id, created_at, updated_at) FROM stdin;
6	Water Bill	\N	\N	\N	\N	14	2025-09-09 05:04:17.791811	2025-09-09 05:04:17.791811
11	Mobile Recharge	\N	\N	\N	\N	15	2025-09-09 13:01:30.906028	2025-09-09 13:01:30.906028
12	Broadband Recharge	\N	\N	\N	\N	15	2025-09-09 13:01:45.694013	2025-09-09 13:01:45.694013
13	DTH Recharge	\N	\N	\N	\N	15	2025-09-09 13:01:56.85302	2025-09-09 13:01:56.85302
14	Loan EMI Payment	\N	\N	\N	\N	16	2025-09-09 13:02:59.61586	2025-09-09 13:02:59.61586
15	FASTag Recharge	\N	\N	\N	\N	16	2025-09-09 13:03:13.656487	2025-09-09 13:03:13.656487
16	Google Play Recharge	\N	\N	\N	\N	16	2025-09-09 13:03:29.658199	2025-09-09 13:03:29.658199
17	Credit Card Bill Payment	\N	\N	\N	\N	16	2025-09-09 13:03:41.353764	2025-09-09 13:03:41.353764
18	Rent Bill Payment	\N	\N	\N	\N	16	2025-09-09 13:03:53.033764	2025-09-09 13:03:53.033764
19	Municipal Tax	\N	\N	\N	\N	17	2025-09-09 13:04:34.037688	2025-09-09 13:04:34.037688
20	Society Maintenance	\N	\N	\N	\N	17	2025-09-09 13:04:45.989233	2025-09-09 13:04:45.989233
21	Traffic Challan	\N	\N	\N	\N	17	2025-09-09 13:04:59.070005	2025-09-09 13:04:59.070005
22	Education Fee	\N	\N	\N	\N	17	2025-09-09 13:05:11.874499	2025-09-09 13:05:11.874499
23	OTT Subscription	\N	\N	\N	\N	18	2025-09-09 13:05:50.521149	2025-09-09 13:05:50.521149
8	Electricity Bill	\N	\N	\N	\N	14	2025-09-09 12:59:13.972532	2025-09-10 06:05:59.00958
10	Gas Bill	\N	\N	\N	\N	14	2025-09-09 13:00:21.120867	2025-09-10 06:06:26.645656
\.


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.services (id, title, status, created_at, updated_at, logo, "position") FROM stdin;
5	Investment	\N	2025-09-02 09:42:13.772699	2025-09-02 10:42:35.890712	\N	\N
12	Entertainment	\N	2025-09-08 09:21:34.550596	2025-09-08 09:21:34.550596	\N	\N
2	Insurance	\N	2025-08-30 11:30:35.42947	2025-09-08 09:23:54.613638	\N	\N
13	Investment	\N	2025-09-08 09:24:30.191817	2025-09-08 09:24:30.191817	\N	\N
14	Electric Vehicle	\N	2025-09-08 09:24:46.678428	2025-09-08 09:24:46.678428	\N	\N
8	Electric Vehicle	\N	2025-09-02 10:32:29.211247	2025-09-10 05:35:38.826592	\N	\N
7	BBPS	\N	2025-09-02 10:32:03.5864	2025-09-10 05:37:38.66016	\N	1
1	Travel & Stay	\N	2025-08-30 11:29:51.960729	2025-09-10 05:37:57.448955	\N	2
4	Loan & credit	\N	2025-08-30 11:31:03.70829	2025-09-10 05:38:12.295214	\N	3
15	DMT	\N	2025-09-19 14:19:31.086059	2025-09-19 14:19:31.086059	\N	\N
\.


--
-- Data for Name: transaction_commissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transaction_commissions (id, transaction_id, user_id, role, commission_amount, created_at, updated_at, service_product_item_id) FROM stdin;
1	262	104	0	6.0	2025-09-17 06:54:00.756407	2025-09-17 06:54:00.756407	\N
2	262	136	0	6.0	2025-09-17 06:54:00.777619	2025-09-17 06:54:00.777619	\N
3	262	134	0	3.0	2025-09-17 06:54:00.794945	2025-09-17 06:54:00.794945	\N
4	263	104	0	10.0	2025-09-17 07:20:05.692672	2025-09-17 07:20:05.692672	\N
5	263	136	0	10.0	2025-09-17 07:20:05.712628	2025-09-17 07:20:05.712628	\N
7	264	104	0	10.0	2025-09-17 07:22:58.442122	2025-09-17 07:22:58.442122	\N
8	264	136	0	10.0	2025-09-17 07:22:58.467338	2025-09-17 07:22:58.467338	\N
10	265	104	0	10.0	2025-09-17 07:23:39.619173	2025-09-17 07:23:39.619173	\N
11	265	136	0	10.0	2025-09-17 07:23:39.636901	2025-09-17 07:23:39.636901	\N
13	266	104	0	10.0	2025-09-17 07:25:57.985627	2025-09-17 07:25:57.985627	\N
14	266	136	0	10.0	2025-09-17 07:25:58.002815	2025-09-17 07:25:58.002815	\N
16	267	104	0	10.0	2025-09-17 07:27:40.882781	2025-09-17 07:27:40.882781	\N
17	267	136	0	10.0	2025-09-17 07:27:40.898656	2025-09-17 07:27:40.898656	\N
18	267	139	0	5.0	2025-09-17 07:27:40.910141	2025-09-17 07:27:40.910141	\N
19	268	104	0	10.0	2025-09-17 07:54:09.168493	2025-09-17 07:54:09.168493	\N
20	268	136	0	10.0	2025-09-17 07:54:09.1875	2025-09-17 07:54:09.1875	\N
22	269	104	0	10.0	2025-09-17 07:55:10.736533	2025-09-17 07:55:10.736533	\N
23	269	136	0	10.0	2025-09-17 07:55:10.752645	2025-09-17 07:55:10.752645	\N
25	270	104	0	0.0	2025-09-17 08:33:26.721564	2025-09-17 08:33:26.721564	\N
26	270	136	0	0.0	2025-09-17 08:33:26.737724	2025-09-17 08:33:26.737724	\N
28	271	104	0	2.0	2025-09-17 08:33:45.043765	2025-09-17 08:33:45.043765	\N
29	271	136	0	2.0	2025-09-17 08:33:45.063137	2025-09-17 08:33:45.063137	\N
31	272	104	0	2.0	2025-09-17 08:44:53.688615	2025-09-17 08:44:53.688615	\N
32	272	136	0	2.0	2025-09-17 08:44:53.711011	2025-09-17 08:44:53.711011	\N
34	274	104	0	2.0	2025-09-17 08:48:03.659955	2025-09-17 08:48:03.659955	\N
35	274	136	0	2.0	2025-09-17 08:48:03.68063	2025-09-17 08:48:03.68063	\N
37	275	104	0	6.0	2025-09-17 08:49:14.119937	2025-09-17 08:49:14.119937	\N
38	275	136	0	6.0	2025-09-17 08:49:14.13562	2025-09-17 08:49:14.13562	\N
40	276	104	0	6.0	2025-09-17 08:51:14.266306	2025-09-17 08:51:14.266306	\N
41	276	136	0	6.0	2025-09-17 08:51:14.280459	2025-09-17 08:51:14.280459	\N
43	277	104	0	0.0	2025-09-17 08:51:57.637777	2025-09-17 08:51:57.637777	\N
44	277	136	0	0.0	2025-09-17 08:51:57.649785	2025-09-17 08:51:57.649785	\N
46	278	104	0	3.0	2025-09-17 08:53:05.45421	2025-09-17 08:53:05.45421	\N
47	278	136	0	3.0	2025-09-17 08:53:05.47256	2025-09-17 08:53:05.47256	\N
49	279	104	0	2.92	2025-09-17 08:56:17.167034	2025-09-17 08:56:17.167034	\N
50	279	136	0	2.92	2025-09-17 08:56:17.182747	2025-09-17 08:56:17.182747	\N
51	279	139	0	2.92	2025-09-17 08:56:17.202606	2025-09-17 08:56:17.202606	\N
52	280	104	0	3.0	2025-09-17 08:57:43.980662	2025-09-17 08:57:43.980662	\N
53	280	136	0	3.0	2025-09-17 08:57:43.995718	2025-09-17 08:57:43.995718	\N
54	280	139	0	3.0	2025-09-17 08:57:44.0074	2025-09-17 08:57:44.0074	\N
55	281	104	0	0.15	2025-09-17 09:19:00.942087	2025-09-17 09:19:00.942087	\N
56	281	136	0	0.15	2025-09-17 09:19:00.955257	2025-09-17 09:19:00.955257	\N
58	282	104	0	4.0	2025-09-17 09:35:50.951673	2025-09-17 09:35:50.951673	\N
59	282	136	0	4.0	2025-09-17 09:35:50.966139	2025-09-17 09:35:50.966139	\N
61	283	104	0	0.1	2025-09-17 09:46:34.636874	2025-09-17 09:46:34.636874	\N
62	283	136	0	0.1	2025-09-17 09:46:34.651838	2025-09-17 09:46:34.651838	\N
64	284	104	0	1.0	2025-09-17 09:48:16.290699	2025-09-17 09:48:16.290699	\N
65	284	136	0	1.0	2025-09-17 09:48:16.304674	2025-09-17 09:48:16.304674	\N
67	285	104	0	6.0	2025-09-17 10:13:05.975461	2025-09-17 10:13:05.975461	\N
68	285	136	0	2.0	2025-09-17 10:13:06.005328	2025-09-17 10:13:06.005328	\N
70	286	104	0	1.0	2025-09-17 10:26:43.718438	2025-09-17 10:26:43.718438	\N
71	286	136	0	2.0	2025-09-17 10:26:43.732116	2025-09-17 10:26:43.732116	\N
73	295	104	0	6.0	2025-09-17 10:41:26.698608	2025-09-17 10:41:26.698608	\N
74	295	136	0	39.0	2025-09-17 10:41:26.743935	2025-09-17 10:41:26.743935	\N
76	296	104	0	0.1	2025-09-17 10:41:58.377241	2025-09-17 10:41:58.377241	\N
77	296	136	0	1.1	2025-09-17 10:41:58.472987	2025-09-17 10:41:58.472987	\N
79	297	104	0	1.2	2025-09-17 10:42:40.042242	2025-09-17 10:42:40.042242	\N
80	297	136	0	13.2	2025-09-17 10:42:40.060887	2025-09-17 10:42:40.060887	\N
82	308	104	0	6.0	2025-09-17 10:51:05.249987	2025-09-17 10:51:05.249987	\N
83	308	136	0	39.0	2025-09-17 10:51:05.274124	2025-09-17 10:51:05.274124	\N
85	309	104	0	0.0	2025-09-17 10:51:19.648853	2025-09-17 10:51:19.648853	\N
86	309	136	0	1.0	2025-09-17 10:51:19.666491	2025-09-17 10:51:19.666491	\N
88	310	104	0	0.12	2025-09-17 10:51:49.518206	2025-09-17 10:51:49.518206	\N
89	310	136	0	1.32	2025-09-17 10:51:49.538305	2025-09-17 10:51:49.538305	\N
91	311	104	0	1.0	2025-09-17 10:52:17.985026	2025-09-17 10:52:17.985026	\N
92	311	136	0	6.5	2025-09-17 10:52:18.004836	2025-09-17 10:52:18.004836	\N
94	312	104	0	6.0	2025-09-17 10:54:47.916788	2025-09-17 10:54:47.916788	\N
95	312	136	0	39.0	2025-09-17 10:54:47.947326	2025-09-17 10:54:47.947326	\N
97	313	104	0	0.02	2025-09-17 10:57:09.382441	2025-09-17 10:57:09.382441	\N
98	313	136	0	0.03	2025-09-17 10:57:09.405376	2025-09-17 10:57:09.405376	\N
100	314	104	0	0.02	2025-09-17 10:58:01.855614	2025-09-17 10:58:01.855614	\N
101	314	136	0	0.13	2025-09-17 10:58:01.879188	2025-09-17 10:58:01.879188	\N
103	315	104	0	0.02	2025-09-17 10:59:57.700488	2025-09-17 10:59:57.700488	\N
104	315	136	0	0.03	2025-09-17 10:59:57.722951	2025-09-17 10:59:57.722951	\N
106	316	104	0	6.0	2025-09-17 11:00:17.232575	2025-09-17 11:00:17.232575	\N
107	316	136	0	9.0	2025-09-17 11:00:17.258883	2025-09-17 11:00:17.258883	\N
109	317	104	0	2.0	2025-09-17 11:26:43.776033	2025-09-17 11:26:43.776033	\N
110	317	136	0	14.0	2025-09-17 11:26:43.797815	2025-09-17 11:26:43.797815	\N
112	318	104	0	0.02	2025-09-17 11:36:04.071622	2025-09-17 11:36:04.071622	\N
113	318	136	0	0.03	2025-09-17 11:36:04.108124	2025-09-17 11:36:04.108124	\N
115	319	104	0	4.0	2025-09-17 11:37:06.531907	2025-09-17 11:37:06.531907	\N
116	319	136	0	6.0	2025-09-17 11:37:06.562225	2025-09-17 11:37:06.562225	\N
118	320	104	0	4.0	2025-09-17 11:37:27.303787	2025-09-17 11:37:27.303787	\N
119	320	136	0	6.0	2025-09-17 11:37:27.328214	2025-09-17 11:37:27.328214	\N
121	321	104	0	1.0	2025-09-17 11:39:20.123529	2025-09-17 11:39:20.123529	\N
122	321	136	0	7.000000000000001	2025-09-17 11:39:20.143977	2025-09-17 11:39:20.143977	\N
124	322	104	0	2.0	2025-09-17 11:41:47.533451	2025-09-17 11:41:47.533451	\N
125	322	136	0	3.0	2025-09-17 11:41:47.557659	2025-09-17 11:41:47.557659	\N
127	323	104	0	1.0	2025-09-17 11:43:19.851087	2025-09-17 11:43:19.851087	\N
128	323	136	0	7.000000000000001	2025-09-17 11:43:19.873797	2025-09-17 11:43:19.873797	\N
130	324	104	0	2.0	2025-09-17 11:48:12.240287	2025-09-17 11:48:12.240287	\N
131	324	136	0	3.0	2025-09-17 11:48:12.257577	2025-09-17 11:48:12.257577	\N
133	325	104	0	0.0	2025-09-17 12:28:54.99915	2025-09-17 12:28:54.99915	\N
134	325	136	0	10.0	2025-09-17 12:28:55.021218	2025-09-17 12:28:55.021218	\N
136	326	104	0	16.0	2025-09-17 12:29:36.361306	2025-09-17 12:29:36.361306	\N
137	326	136	0	-6.0	2025-09-17 12:29:36.383947	2025-09-17 12:29:36.383947	\N
139	327	104	0	16.0	2025-09-17 12:31:10.374482	2025-09-17 12:31:10.374482	\N
140	327	136	0	-6.0	2025-09-17 12:31:10.392562	2025-09-17 12:31:10.392562	\N
142	328	104	0	8.0	2025-09-17 12:32:22.411307	2025-09-17 12:32:22.411307	\N
143	328	136	0	-3.0	2025-09-17 12:32:22.427943	2025-09-17 12:32:22.427943	\N
145	329	104	0	2.0	2025-09-17 13:07:40.865449	2025-09-17 13:07:40.865449	\N
146	329	136	0	3.0	2025-09-17 13:07:40.888348	2025-09-17 13:07:40.888348	\N
148	330	104	0	0.0	2025-09-17 13:21:12.860413	2025-09-17 13:21:12.860413	\N
149	330	136	0	10.0	2025-09-17 13:21:12.878353	2025-09-17 13:21:12.878353	\N
151	331	104	0	2.0	2025-09-17 13:21:37.314623	2025-09-17 13:21:37.314623	\N
152	331	136	0	14.0	2025-09-17 13:21:37.332832	2025-09-17 13:21:37.332832	\N
154	332	104	0	2.0	2025-09-17 13:27:11.719489	2025-09-17 13:27:11.719489	\N
155	332	136	0	3.0	2025-09-17 13:27:11.741367	2025-09-17 13:27:11.741367	\N
157	333	104	0	2.0	2025-09-17 13:32:55.565135	2025-09-17 13:32:55.565135	\N
158	333	136	0	3.0	2025-09-17 13:32:55.609415	2025-09-17 13:32:55.609415	\N
160	334	104	0	1.0	2025-09-17 13:56:34.172706	2025-09-17 13:56:34.172706	\N
161	334	136	0	7.000000000000001	2025-09-17 13:56:34.190328	2025-09-17 13:56:34.190328	\N
163	335	104	0	2.0	2025-09-17 13:57:11.859187	2025-09-17 13:57:11.859187	\N
164	335	136	0	3.0	2025-09-17 13:57:11.874827	2025-09-17 13:57:11.874827	\N
166	336	104	0	8.0	2025-09-18 06:55:53.734859	2025-09-18 06:55:53.734859	\N
167	336	136	0	2.0	2025-09-18 06:55:53.754771	2025-09-18 06:55:53.754771	\N
169	338	104	0	15.92	2025-09-18 07:17:06.607021	2025-09-18 07:17:06.607021	\N
170	338	136	0	3.98	2025-09-18 07:17:06.629304	2025-09-18 07:17:06.629304	\N
172	339	104	0	0.08	2025-09-18 07:23:23.786791	2025-09-18 07:23:23.786791	\N
173	339	136	0	-0.03	2025-09-18 07:23:23.805711	2025-09-18 07:23:23.805711	\N
175	340	104	0	0.08	2025-09-18 07:24:08.937225	2025-09-18 07:24:08.937225	\N
176	340	136	0	0.02	2025-09-18 07:24:08.960801	2025-09-18 07:24:08.960801	\N
178	341	104	0	0.0	2025-09-18 07:33:40.693861	2025-09-18 07:33:40.693861	\N
179	341	136	0	0.02	2025-09-18 07:33:40.715084	2025-09-18 07:33:40.715084	\N
181	342	104	0	0.03	2025-09-18 07:34:19.089978	2025-09-18 07:34:19.089978	\N
182	342	136	0	0.02	2025-09-18 07:34:19.114597	2025-09-18 07:34:19.114597	\N
184	343	104	0	0.03	2025-09-18 07:36:21.401638	2025-09-18 07:36:21.401638	\N
185	343	136	0	0.02	2025-09-18 07:36:21.433107	2025-09-18 07:36:21.433107	\N
187	344	104	0	6.0	2025-09-18 07:50:43.364086	2025-09-18 07:50:43.364086	\N
188	344	136	0	4.0	2025-09-18 07:50:43.384716	2025-09-18 07:50:43.384716	\N
190	345	104	0	0.0	2025-09-18 08:37:43.526667	2025-09-18 08:37:43.526667	\N
191	345	136	0	10.0	2025-09-18 08:37:43.546197	2025-09-18 08:37:43.546197	\N
192	345	139	0	0.0	2025-09-18 08:37:43.560503	2025-09-18 08:37:43.560503	\N
193	346	104	0	3.0	2025-09-18 11:23:48.971227	2025-09-18 11:23:48.971227	\N
194	346	136	0	2.0	2025-09-18 11:23:49.018126	2025-09-18 11:23:49.018126	\N
196	347	104	0	0.0	2025-09-18 13:10:04.678112	2025-09-18 13:10:04.678112	\N
197	347	136	0	15.0	2025-09-18 13:10:04.699788	2025-09-18 13:10:04.699788	\N
198	347	139	0	0.0	2025-09-18 13:10:04.71781	2025-09-18 13:10:04.71781	\N
199	348	104	0	6.0	2025-09-19 10:56:34.432637	2025-09-19 10:56:34.432637	1
200	348	136	0	4.0	2025-09-19 10:56:34.457974	2025-09-19 10:56:34.457974	1
202	349	104	0	6.0	2025-09-19 11:07:44.423616	2025-09-19 11:07:44.423616	1
203	349	136	0	4.0	2025-09-19 11:07:44.456632	2025-09-19 11:07:44.456632	1
205	350	104	0	6.0	2025-09-19 11:08:08.974241	2025-09-19 11:08:08.974241	1
206	350	136	0	4.0	2025-09-19 11:08:09.015665	2025-09-19 11:08:09.015665	1
208	351	104	0	6.0	2025-09-19 11:12:30.701089	2025-09-19 11:12:30.701089	1
209	351	136	0	4.0	2025-09-19 11:12:30.726126	2025-09-19 11:12:30.726126	1
211	352	104	0	6.0	2025-09-19 11:49:50.227056	2025-09-19 11:49:50.227056	1
212	352	136	0	4.0	2025-09-19 11:49:50.247777	2025-09-19 11:49:50.247777	1
213	352	127	0	0.0	2025-09-19 11:49:50.26609	2025-09-19 11:49:50.26609	1
214	353	104	0	11.96999999999999	2025-09-19 11:50:50.78489	2025-09-19 11:50:50.78489	1
215	353	136	0	7.98	2025-09-19 11:50:50.810948	2025-09-19 11:50:50.810948	1
216	353	127	0	19.95	2025-09-19 11:50:50.82812	2025-09-19 11:50:50.82812	1
217	354	104	0	0.0	2025-09-19 12:06:30.411115	2025-09-19 12:06:30.411115	1
218	354	136	0	10.0	2025-09-19 12:06:30.455102	2025-09-19 12:06:30.455102	1
219	354	134	0	0.0	2025-09-19 12:06:30.485716	2025-09-19 12:06:30.485716	1
220	355	104	0	6.0	2025-09-19 12:23:12.01258	2025-09-19 12:23:12.01258	1
221	355	136	0	4.0	2025-09-19 12:23:12.034006	2025-09-19 12:23:12.034006	1
222	355	127	0	10.0	2025-09-19 12:23:12.050474	2025-09-19 12:23:12.050474	1
223	356	104	0	5.97	2025-09-19 14:06:31.489469	2025-09-19 14:06:31.489469	1
224	356	136	0	3.98	2025-09-19 14:06:31.509015	2025-09-19 14:06:31.509015	1
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactions (id, tx_id, operator, transaction_type, account_or_mobile, amount, status, user_id, created_at, updated_at, service_product_id) FROM stdin;
128	TXN756047	Airtel	ONLINE	7056858674	3.0	SUCCESS	127	2025-09-08 10:50:32.396033	2025-09-08 10:50:32.396033	\N
1	TXN281668	Jio	Mobile Recharge	8967896789	400.0	\N	118	2025-09-03 12:05:03.351194	2025-09-08 10:22:52.2069	\N
56	TXN259615	Jio	ONLINE	9845634853	299.0	SUCCESS	127	2025-09-04 10:57:47.23236	2025-09-08 10:22:52.221127	\N
57	TXN625882	Jio	ONLINE	8458975789	299.0	SUCCESS	127	2025-09-04 11:01:24.17657	2025-09-08 10:22:52.223234	\N
68	TXN648821	Jio	ONLINE	9987575469	299.0	SUCCESS	127	2025-09-04 13:21:22.687494	2025-09-08 10:22:52.225411	\N
69	TXN627123	Jio	ONLINE	8786756756	299.0	SUCCESS	127	2025-09-04 14:00:45.73664	2025-09-08 10:22:52.227873	\N
70	TXN895988	Jio	ONLINE	7656756565	199.0	SUCCESS	127	2025-09-04 14:01:34.089607	2025-09-08 10:22:52.230946	\N
71	TXN862023	Jio	Mobile Recharge	9009090909	399.0	SUCCESS	142	2025-09-04 18:43:16.937956	2025-09-08 10:22:52.233913	\N
72	TXN635460	Jio	Mobile Recharge	9009090909	399.0	SUCCESS	142	2025-09-04 18:46:40.329555	2025-09-08 10:22:52.237142	\N
73	TXN343801	Jio	Mobile Recharge	9009090922	399.0	SUCCESS	142	2025-09-04 18:53:20.244303	2025-09-08 10:22:52.24002	\N
74	TXN346260	Jio	Mobile Recharge	9009090922	399.0	SUCCESS	127	2025-09-04 18:54:51.550782	2025-09-08 10:22:52.242907	\N
75	TXN711768	Jio	Mobile Recharge	9009090922	399.0	SUCCESS	127	2025-09-04 18:57:00.347102	2025-09-08 10:22:52.24524	\N
76	TXN506209	Vi	ONLINE	9239878327	229.0	SUCCESS	139	2025-09-05 05:44:18.037868	2025-09-08 10:22:52.247392	\N
77	TXN674407	Jio	ONLINE	9887734764	199.0	SUCCESS	139	2025-09-05 05:48:02.704505	2025-09-08 10:22:52.249639	\N
78	TXN424671	Jio	ONLINE	9877636355	199.0	SUCCESS	139	2025-09-05 06:23:03.721722	2025-09-08 10:22:52.251834	\N
79	TXN276375	Airtel	ONLINE	9999999998	399.0	SUCCESS	139	2025-09-05 06:25:10.37026	2025-09-08 10:22:52.254192	\N
80	TXN644975	BSNL	ONLINE	9878378237	397.0	SUCCESS	139	2025-09-05 06:28:47.145921	2025-09-08 10:22:52.25682	\N
81	TXN257987	Jio	ONLINE	9238942783	199.0	SUCCESS	139	2025-09-05 06:30:14.234533	2025-09-08 10:22:52.259246	\N
82	TXN900769	BSNL	ONLINE	9857894576	397.0	SUCCESS	127	2025-09-05 07:13:50.99573	2025-09-08 10:22:52.261821	\N
83	TXN524375	Jio	Mobile Recharge	9009090922	50.0	SUCCESS	127	2025-09-05 08:41:22.391336	2025-09-08 10:22:52.26518	\N
84	TXN857294	Jio	Mobile Recharge	9009090922	50.0	SUCCESS	127	2025-09-05 08:42:16.040326	2025-09-08 10:22:52.268759	\N
85	TXN204140	Jio	Mobile Recharge	9009090922	50.0	SUCCESS	127	2025-09-05 08:44:43.684339	2025-09-08 10:22:52.27196	\N
86	TXN537108	Jio	Mobile Recharge	9009090922	50.0	SUCCESS	127	2025-09-05 08:45:03.448304	2025-09-08 10:22:52.27508	\N
87	TXN464003	Jio	ONLINE	0878756854	50.0	SUCCESS	127	2025-09-05 08:45:52.606187	2025-09-08 10:22:52.277363	\N
88	TXN222500	Jio	ONLINE	0576075896	100.0	SUCCESS	127	2025-09-05 08:46:34.81119	2025-09-08 10:22:52.279392	\N
89	TXN662309	Vi	ONLINE	0960975609	379.0	SUCCESS	127	2025-09-05 08:55:37.184347	2025-09-08 10:22:52.281628	\N
90	TXN447288	Airtel	ONLINE	7897485675	21.0	SUCCESS	127	2025-09-05 08:58:47.425191	2025-09-08 10:22:52.284238	\N
91	TXN661745	Jio	ONLINE	9840675867	199.0	SUCCESS	127	2025-09-05 09:23:34.62912	2025-09-08 10:22:52.286774	\N
92	TXN436882	Jio	ONLINE	8945867586	50.0	SUCCESS	127	2025-09-05 09:28:11.394245	2025-09-08 10:22:52.28987	\N
93	TXN394010	BSNL	ONLINE	7684567857	149.0	SUCCESS	127	2025-09-05 09:39:07.585305	2025-09-08 10:22:52.293139	\N
94	TXN108180	Airtel	ONLINE	9075867546	20.0	SUCCESS	127	2025-09-05 09:49:19.078264	2025-09-08 10:22:52.296696	\N
95	TXN115835	Airtel	ONLINE	5654645645	2.0	SUCCESS	127	2025-09-05 11:15:30.230462	2025-09-08 10:22:52.30065	\N
96	TXN494233	Jio	ONLINE	9789787878	50.0	SUCCESS	127	2025-09-05 11:16:31.28945	2025-09-08 10:22:52.303791	\N
97	TXN618429	Airtel	ONLINE	9856846785	20.0	SUCCESS	127	2025-09-05 11:18:47.089867	2025-09-08 10:22:52.30624	\N
98	TXN592478	Jio	Mobile Recharge	9009090922	299.0	SUCCESS	127	2025-09-05 11:24:44.197048	2025-09-08 10:22:52.308538	\N
99	TXN482133	Jio	Mobile Recharge	9009090922	299.0	SUCCESS	127	2025-09-05 11:24:48.92322	2025-09-08 10:22:52.312191	\N
100	TXN787813	Jio	Mobile Recharge	9009090922	299.0	SUCCESS	127	2025-09-05 11:24:55.301585	2025-09-08 10:22:52.314931	\N
101	TXN930654	Vi	ONLINE	0945609576	10.0	SUCCESS	127	2025-09-05 11:25:44.790708	2025-09-08 10:22:52.317497	\N
102	TXN385095	Vi	ONLINE	0875867567	400.0	SUCCESS	127	2025-09-05 11:26:16.087155	2025-09-08 10:22:52.319957	\N
103	TXN334195	Jio	Mobile Recharge	9009090922	299.0	SUCCESS	127	2025-09-05 11:33:22.569956	2025-09-08 10:22:52.3223	\N
104	TXN338812	Jio	Mobile Recharge	9009090922	299.0	SUCCESS	127	2025-09-05 11:34:24.48861	2025-09-08 10:22:52.324545	\N
105	TXN269233	Jio	Mobile Recharge	9009090922	299.0	SUCCESS	127	2025-09-05 11:34:34.120231	2025-09-08 10:22:52.327183	\N
106	TXN846137	Vi	ONLINE	7858967856	249.0	SUCCESS	127	2025-09-05 12:07:38.333002	2025-09-08 10:22:52.330655	\N
107	TXN190902	Airtel	ONLINE	0878586666	87.0	SUCCESS	127	2025-09-05 12:20:42.904552	2025-09-08 10:22:52.333906	\N
108	TXN169040	Jio	ONLINE	8708578954	87.0	SUCCESS	127	2025-09-05 12:21:36.303358	2025-09-08 10:22:52.33662	\N
109	TXN496480	Airtel	ONLINE	0707098787	11.0	SUCCESS	127	2025-09-05 12:22:13.879889	2025-09-08 10:22:52.339104	\N
110	TXN810013	Jio	ONLINE	9895671000	20.0	SUCCESS	127	2025-09-05 12:47:27.214822	2025-09-08 10:22:52.341523	\N
111	TXN641850	Jio	Mobile Recharge	9009090922	299.0	SUCCESS	127	2025-09-05 13:06:22.936565	2025-09-08 10:22:52.344146	\N
112	TXN912535	Airtel	ONLINE	9745489679	6.0	SUCCESS	127	2025-09-05 13:13:12.180993	2025-09-08 10:22:52.347472	\N
113	TXN231637	Airtel	ONLINE	8798586488	399.0	SUCCESS	127	2025-09-05 13:16:28.43975	2025-09-08 10:22:52.353644	\N
114	TXN229026	Airtel	ONLINE	8979897565	296.0	SUCCESS	127	2025-09-05 13:34:07.647398	2025-09-08 10:22:52.356519	\N
115	TXN832761	Airtel	ONLINE	9998899988	5.0	SUCCESS	127	2025-09-06 11:16:32.272829	2025-09-08 10:22:52.359376	\N
116	TXN475640	BSNL	ONLINE	0970870709	99.0	SUCCESS	127	2025-09-06 12:37:36.255575	2025-09-08 10:22:52.364047	\N
117	TXN658998	Airtel	ONLINE	8798768967	194.0	SUCCESS	127	2025-09-06 13:03:10.251816	2025-09-08 10:22:52.367709	\N
118	TXN762371	Jio	ONLINE	7867867856	299.0	SUCCESS	127	2025-09-08 04:46:48.019377	2025-09-08 10:22:52.370379	\N
119	TXN431538	Airtel	ONLINE	8779878989	39.0	SUCCESS	127	2025-09-08 06:25:19.941011	2025-09-08 10:22:52.372862	\N
120	TXN815653	Jio	ONLINE	9809809898	299.0	SUCCESS	134	2025-09-08 06:38:39.303612	2025-09-08 10:22:52.375543	\N
121	TXN470060	Jio	ONLINE	9887273276	199.0	SUCCESS	139	2025-09-08 06:42:13.18747	2025-09-08 10:22:52.377878	\N
122	TXN819087	Airtel	ONLINE	9843847847	50.0	SUCCESS	139	2025-09-08 06:48:08.879054	2025-09-08 10:22:52.380177	\N
123	TXN620063	Airtel	ONLINE	9879879879	50.0	SUCCESS	134	2025-09-08 09:43:13.55077	2025-09-08 10:22:52.382613	\N
124	TXN463554	Airtel	ONLINE	9098097798	70.0	SUCCESS	134	2025-09-08 09:43:30.569204	2025-09-08 10:22:52.385305	\N
125	TXN854120	Jio	Mobile Recharge	9009090922	2.0	SUCCESS	134	2025-09-08 10:00:26.922384	2025-09-08 10:22:52.38799	\N
126	TXN914289	Jio	ONLINE	0934085758	199.0	SUCCESS	127	2025-09-08 10:11:49.967456	2025-09-08 10:22:52.39063	\N
140	TXN535305	Vi	ONLINE	2434343432	1.0	SUCCESS	134	2025-09-08 11:33:49.07642	2025-09-08 11:33:49.07642	\N
141	TXN355074	Airtel	ONLINE	0987086566	20.0	SUCCESS	127	2025-09-08 12:27:39.957225	2025-09-08 12:27:39.957225	\N
142	TXN151842	Vi	ONLINE	8750675867	10.0	SUCCESS	127	2025-09-08 13:14:56.993997	2025-09-08 13:14:56.993997	\N
143	TXN553175	Jio	ONLINE	0857067456	10.0	SUCCESS	127	2025-09-08 13:21:49.664094	2025-09-08 13:21:49.664094	\N
144	TXN234735	Airtel	ONLINE	8658567567	20.0	SUCCESS	127	2025-09-09 05:18:48.394867	2025-09-09 05:18:48.394867	\N
145	TXN532198	Airtel	ONLINE	8956754765	399.0	SUCCESS	127	2025-09-09 05:24:22.449339	2025-09-09 05:24:22.449339	\N
146	TXN869761	Airtel	ONLINE	8098098098	1.0	SUCCESS	134	2025-09-09 06:18:01.443742	2025-09-09 06:18:01.443742	\N
147	TXN882975	Airtel	ONLINE	0988098098	1.0	SUCCESS	134	2025-09-09 06:23:20.171762	2025-09-09 06:23:20.171762	\N
148	TXN588595	Jio	ONLINE	5645654645	1.0	SUCCESS	127	2025-09-09 06:23:42.38084	2025-09-09 06:23:42.38084	\N
149	TXN474624	Airtel	ONLINE	5645645645	1.0	SUCCESS	127	2025-09-09 06:24:17.013129	2025-09-09 06:24:17.013129	\N
150	TXN259000	Airtel	ONLINE	4567546456	24.0	SUCCESS	127	2025-09-09 06:26:29.10355	2025-09-09 06:26:29.10355	\N
151	TXN112533	Jio	ONLINE	7685763476	2.0	SUCCESS	127	2025-09-09 06:48:28.538808	2025-09-09 06:48:28.538808	\N
152	TXN166438	Jio	ONLINE	8768456758	11.0	SUCCESS	127	2025-09-09 06:52:25.368241	2025-09-09 06:52:25.368241	\N
153	TXN421433	Jio	ONLINE	9090998778	1.0	SUCCESS	127	2025-09-09 08:05:14.835729	2025-09-09 08:05:14.835729	\N
154	TXN989068	Vi	ONLINE	8873743264	229.0	SUCCESS	139	2025-09-09 09:00:04.916378	2025-09-09 09:00:04.916378	\N
155	TXN252515	Jio	ONLINE	7676767676	10.0	SUCCESS	127	2025-09-09 13:10:00.134472	2025-09-09 13:10:00.134472	\N
156	TXN713549	Jio	ONLINE	9978787676	299.0	SUCCESS	139	2025-09-09 13:11:04.824057	2025-09-09 13:11:04.824057	\N
157	TXN249751	Jio	ONLINE	7697677698	199.0	SUCCESS	127	2025-09-09 13:54:42.225975	2025-09-09 13:54:42.225975	\N
158	TXN120346	Jio	ONLINE	9034984798	299.0	SUCCESS	139	2025-09-09 13:55:11.517	2025-09-09 13:55:11.517	\N
159	TXN685312	Jio	ONLINE	8969767687	20.0	SUCCESS	127	2025-09-09 13:56:46.749001	2025-09-09 13:56:46.749001	\N
160	TXN501124	Jio	ONLINE	7897787787	1.0	SUCCESS	134	2025-09-09 14:12:39.059523	2025-09-09 14:12:39.059523	\N
161	TXN639201	Jio	ONLINE	9879779787	12.0	SUCCESS	134	2025-09-09 16:38:51.449622	2025-09-09 16:38:51.449622	\N
162	TXN248001	Jio	Mobile Recharge	787987778787	2.0	SUCCESS	134	2025-09-10 05:47:38.238908	2025-09-10 05:47:38.238908	11
163	TXN124168	Jio	Mobile Recharge	787987778787	2.0	SUCCESS	134	2025-09-10 05:53:43.171169	2025-09-10 05:53:43.171169	11
164	TXN668614	Jio	Mobile Recharge	787987778787	2.0	SUCCESS	134	2025-09-10 06:51:23.336111	2025-09-10 06:51:23.336111	11
165	TXN294955	Airtel	ONLINE	0978907898	2.0	SUCCESS	127	2025-09-10 06:57:55.166792	2025-09-10 06:57:55.166792	11
166	TXN212475	Jio	Mobile Recharge	787987778787	2.0	SUCCESS	134	2025-09-10 07:04:24.891643	2025-09-10 07:04:24.891643	11
167	TXN581251	Jio	Mobile Recharge	787987778787	0.5	SUCCESS	134	2025-09-10 07:54:37.976986	2025-09-10 07:54:37.976986	11
168	TXN879441	Jio	Mobile Recharge	89898877878	0.5	SUCCESS	134	2025-09-10 08:45:06.920316	2025-09-10 08:45:06.920316	11
169	TXN933030	Jio	Mobile Recharge	89898877878	0.5	SUCCESS	134	2025-09-10 08:52:55.857724	2025-09-10 08:52:55.857724	11
170	TXN931271	Jio	Mobile Recharge	89898877878	0.5	SUCCESS	134	2025-09-10 09:13:14.279833	2025-09-10 09:13:14.279833	11
171	TXN734167	Jio	Mobile Recharge	89898877878	0.5	SUCCESS	134	2025-09-10 09:34:46.744849	2025-09-10 09:34:46.744849	11
172	TXN755654	Jio	Mobile Recharge	89898977777	0.5	SUCCESS	134	2025-09-10 10:17:43.769943	2025-09-10 10:17:43.769943	11
173	TXN814227	Jio	Mobile Recharge	90900990909	0.5	SUCCESS	134	2025-09-10 10:38:27.425217	2025-09-10 10:38:27.425217	11
174	TXN228474	Airtel	\N	0988088098	2.0	SUCCESS	134	2025-09-10 12:21:21.90358	2025-09-10 12:21:21.90358	11
175	TXN203982	Airtel	\N	8765645645	22.0	SUCCESS	127	2025-09-10 12:29:34.652818	2025-09-10 12:29:34.652818	11
176	TXN889945	Jio	\N	7586758896	11.0	SUCCESS	127	2025-09-10 12:57:43.454721	2025-09-10 12:57:43.454721	11
177	TXN575336	Airtel	\N	7586758675	11.0	SUCCESS	127	2025-09-10 12:59:29.002969	2025-09-10 12:59:29.002969	11
178	TXN615156	Airtel	\N	9869869869	10.0	SUCCESS	127	2025-09-10 13:07:20.884092	2025-09-10 13:07:20.884092	11
179	TXN844985	Jio	\N	7697698689	8.0	SUCCESS	127	2025-09-10 13:11:29.503531	2025-09-10 13:11:29.503531	11
180	TXN869309	Jio	\N	5464646464	7.0	SUCCESS	127	2025-09-11 05:41:06.551229	2025-09-11 05:41:06.551229	11
181	TXN378844	Jio	\N	5765756756	1.0	SUCCESS	127	2025-09-11 06:51:20.978864	2025-09-11 06:51:20.978864	11
182	TXN328446	Jio	\N	5745756746	4.0	SUCCESS	127	2025-09-11 07:00:30.9748	2025-09-11 07:00:30.9748	11
183	TXN101178	Jio	\N	8768969869	1.0	SUCCESS	127	2025-09-11 07:03:06.255595	2025-09-11 07:03:06.255595	11
184	TXN613670	Jio	\N	7458697560	1.0	SUCCESS	127	2025-09-11 07:10:00.37594	2025-09-11 07:10:00.37594	11
185	TXN285126	Jio	\N	5464564556	1.0	SUCCESS	127	2025-09-11 07:26:50.256178	2025-09-11 07:26:50.256178	11
186	TXN451227	Vi	\N	7664567458	1.0	SUCCESS	127	2025-09-11 07:31:13.033061	2025-09-11 07:31:13.033061	11
187	TXN786844	Jio	\N	8798796986	1.0	SUCCESS	127	2025-09-11 07:35:38.454368	2025-09-11 07:35:38.454368	11
188	TXN450168	Jio	\N	7438578347	1.0	SUCCESS	127	2025-09-11 07:40:28.559514	2025-09-11 07:40:28.559514	11
189	TXN141978	Jio	\N	8756875465	1.0	SUCCESS	127	2025-09-11 07:41:36.377643	2025-09-11 07:41:36.377643	11
190	TXN730547	Jio	\N	9070979709	1.0	SUCCESS	127	2025-09-11 07:54:59.352708	2025-09-11 07:54:59.352708	11
191	TXN939768	Jio	\N	9070979709	1.0	SUCCESS	127	2025-09-11 07:56:05.821882	2025-09-11 07:56:05.821882	11
192	TXN391513	Jio	\N	9070979709	1.0	SUCCESS	127	2025-09-11 07:56:24.619032	2025-09-11 07:56:24.619032	11
193	TXN492587	Jio	\N	5565464654	1.0	SUCCESS	127	2025-09-11 08:39:25.227632	2025-09-11 08:39:25.227632	11
194	TXN397223	Jio	\N	5565464654	1.0	SUCCESS	127	2025-09-11 08:41:28.840778	2025-09-11 08:41:28.840778	11
195	TXN808869	Jio	\N	8787897878	1.0	SUCCESS	127	2025-09-11 08:44:47.812085	2025-09-11 08:44:47.812085	11
196	TXN873058	Jio	\N	8787987987	1.0	SUCCESS	127	2025-09-11 08:46:06.238012	2025-09-11 08:46:06.238012	11
197	TXN676243	Jio	\N	8787987987	1.0	SUCCESS	127	2025-09-11 08:46:33.148985	2025-09-11 08:46:33.148985	11
198	TXN521952	Jio	\N	8787987987	1.0	SUCCESS	127	2025-09-11 08:50:27.020339	2025-09-11 08:50:27.020339	11
199	TXN884495	Jio	\N	9076095807	1.0	SUCCESS	127	2025-09-11 08:51:39.268617	2025-09-11 08:51:39.268617	11
200	TXN257119	Airtel	RECHARGE	5687567567	1.0	SUCCESS	127	2025-09-11 10:58:28.876792	2025-09-11 10:58:28.876792	11
201	TXN205641	Jio	RECHARGE	6756757575	1.0	SUCCESS	127	2025-09-11 11:05:38.886778	2025-09-11 11:05:38.886778	11
202	TXN467878	Vi	RECHARGE	8778789789	19.0	SUCCESS	127	2025-09-11 12:29:53.212623	2025-09-11 12:29:53.212623	11
203	TXN482109	Jio	RECHARGE	6574657574	111.0	SUCCESS	127	2025-09-11 12:55:41.412242	2025-09-11 12:55:41.412242	11
204	TXN764000	Jio	RECHARGE	8769697677	1.0	SUCCESS	127	2025-09-11 13:33:13.689056	2025-09-11 13:33:13.689056	11
205	TXN722700	Airtel	RECHARGE	5475675757	249.0	SUCCESS	127	2025-09-11 13:51:22.509643	2025-09-11 13:51:22.509643	11
206	TXN948113	Airtel	RECHARGE	3453453535	11.0	SUCCESS	127	2025-09-12 07:06:53.361775	2025-09-12 07:06:53.361775	11
207	TXN668264	Jio	RECHARGE	8578978968	10.0	SUCCESS	127	2025-09-12 12:52:30.369447	2025-09-12 12:52:30.369447	11
208	TXN354579	Jio	RECHARGE	7999998897	78.0	SUCCESS	127	2025-09-15 05:32:09.762417	2025-09-15 05:32:09.762417	11
209	TXN134956	Airtel	RECHARGE	7989798789	249.0	SUCCESS	134	2025-09-15 17:31:19.254578	2025-09-15 17:31:19.254578	11
210	TXN722079	Jio	RECHARGE	9877987987	199.0	SUCCESS	134	2025-09-15 17:32:14.626233	2025-09-15 17:32:14.626233	11
211	TXN461921	Jio	Mobile Recharge	90900990909	0.5	SUCCESS	134	2025-09-16 11:49:52.933333	2025-09-16 11:49:52.933333	11
212	TXN787631	Jio	Mobile Recharge	90900990909	0.5	SUCCESS	134	2025-09-16 11:51:46.530596	2025-09-16 11:51:46.530596	11
214	TXN737928	Jio	Mobile Recharge	90900990909	0.5	SUCCESS	134	2025-09-16 12:14:40.142912	2025-09-16 12:14:40.142912	11
215	TXN317855	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 12:15:04.40333	2025-09-16 12:15:04.40333	11
216	TXN300830	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 12:21:57.758636	2025-09-16 12:21:57.758636	11
217	TXN645259	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 12:26:38.88992	2025-09-16 12:26:38.88992	11
218	TXN339807	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 12:34:46.87571	2025-09-16 12:34:46.87571	11
219	TXN398013	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 12:36:23.533953	2025-09-16 12:36:23.533953	11
222	TXN239080	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 12:47:18.865088	2025-09-16 12:47:18.865088	11
223	TXN519196	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 12:48:08.002008	2025-09-16 12:48:08.002008	11
224	TXN709457	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 12:49:56.624078	2025-09-16 12:49:56.624078	11
225	TXN613455	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 13:23:35.873272	2025-09-16 13:23:35.873272	11
226	TXN837690	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 13:25:41.610225	2025-09-16 13:25:41.610225	11
227	TXN226369	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-16 13:26:10.871114	2025-09-16 13:26:10.871114	11
228	TXN735894	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-16 13:26:53.523648	2025-09-16 13:26:53.523648	11
229	TXN800767	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-16 13:28:18.75625	2025-09-16 13:28:18.75625	11
230	TXN794781	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-16 13:30:11.323746	2025-09-16 13:30:11.323746	11
231	TXN534069	Airtel	RECHARGE	0567506756	300.0	SUCCESS	127	2025-09-16 13:44:22.113514	2025-09-16 13:44:22.113514	11
233	TXN713846	Jio	Mobile Recharge	90900990909	56.0	SUCCESS	127	2025-09-16 13:46:47.474368	2025-09-16 13:46:47.474368	11
234	TXN842391	Jio	RECHARGE	8758646754	300.0	SUCCESS	127	2025-09-16 13:52:52.408975	2025-09-16 13:52:52.408975	11
235	TXN704415	Jio	RECHARGE	7796769669	300.0	SUCCESS	127	2025-09-16 13:55:46.961427	2025-09-16 13:55:46.961427	11
236	TXN202588	Jio	RECHARGE	8945689456	300.0	SUCCESS	127	2025-09-16 13:57:09.975787	2025-09-16 13:57:09.975787	11
250	TXN816699	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 18:27:19.635547	2025-09-16 18:27:19.635547	11
251	TXN774851	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 18:27:28.360533	2025-09-16 18:27:28.360533	11
252	TXN617962	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 18:27:43.614023	2025-09-16 18:27:43.614023	11
255	TXN406027	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 18:37:51.654406	2025-09-16 18:37:51.654406	11
257	TXN180359	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 18:41:26.852442	2025-09-16 18:41:26.852442	11
258	TXN842031	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 18:42:35.236836	2025-09-16 18:42:35.236836	11
259	TXN882156	Jio	RECHARGE	5657567576	200.0	SUCCESS	127	2025-09-17 04:47:49.450049	2025-09-17 04:47:49.450049	11
260	TXN838072	Jio	RECHARGE	0856745769	200.0	SUCCESS	127	2025-09-17 05:04:20.218995	2025-09-17 05:04:20.218995	11
261	TXN295166	Jio	RECHARGE	0947695479	52.0	SUCCESS	127	2025-09-17 05:12:23.77691	2025-09-17 05:12:23.77691	11
262	TXN958369	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-17 06:54:00.706193	2025-09-17 06:54:00.706193	11
263	TXN833807	Jio	RECHARGE	8934589436	200.0	SUCCESS	127	2025-09-17 07:20:05.650515	2025-09-17 07:20:05.650515	11
264	TXN622002	Jio	RECHARGE	5654645645	200.0	SUCCESS	127	2025-09-17 07:22:58.424074	2025-09-17 07:22:58.424074	11
265	TXN807687	Airtel	RECHARGE	5745675467	500.0	SUCCESS	127	2025-09-17 07:23:39.606543	2025-09-17 07:23:39.606543	11
266	TXN319177	Airtel	RECHARGE	8687966796	500.0	SUCCESS	127	2025-09-17 07:25:57.970954	2025-09-17 07:25:57.970954	11
267	TXN295019	Airtel	RECHARGE	5656765756	500.0	SUCCESS	139	2025-09-17 07:27:40.871936	2025-09-17 07:27:40.871936	11
268	TXN784529	Airtel	RECHARGE	8787878978	500.0	SUCCESS	127	2025-09-17 07:54:09.134099	2025-09-17 07:54:09.134099	11
269	TXN465639	Airtel	RECHARGE	7456756756	500.0	SUCCESS	127	2025-09-17 07:55:10.723613	2025-09-17 07:55:10.723613	11
270	TXN672407	Jio	Mobile Recharge	90900990909	100.0	SUCCESS	127	2025-09-17 08:33:26.703938	2025-09-17 08:33:26.703938	11
271	TXN740032	Airtel	Mobile Recharge	90900990909	100.0	SUCCESS	127	2025-09-17 08:33:45.028439	2025-09-17 08:33:45.028439	11
272	TXN258651	Airtel	Mobile Recharge	90900990909	100.0	SUCCESS	127	2025-09-17 08:44:53.65969	2025-09-17 08:44:53.65969	11
274	TXN811268	Airtel	Mobile Recharge	90900990909	100.0	SUCCESS	127	2025-09-17 08:48:03.601258	2025-09-17 08:48:03.601258	11
275	TXN596076	Airtel	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-17 08:49:14.105294	2025-09-17 08:49:14.105294	11
276	TXN599264	Airtel	RECHARGE	4645654654	300.0	SUCCESS	127	2025-09-17 08:51:14.251345	2025-09-17 08:51:14.251345	11
277	TXN364943	Jio	RECHARGE	8789758675	300.0	SUCCESS	127	2025-09-17 08:51:57.624669	2025-09-17 08:51:57.624669	11
278	TXN607953	Jio	RECHARGE	8785658765	300.0	SUCCESS	127	2025-09-17 08:53:05.440148	2025-09-17 08:53:05.440148	11
279	TXN420215	Airtel	RECHARGE	8966986896	292.0	SUCCESS	139	2025-09-17 08:56:17.15513	2025-09-17 08:56:17.15513	11
280	TXN208381	Jio	RECHARGE	8697697787	300.0	SUCCESS	139	2025-09-17 08:57:43.969877	2025-09-17 08:57:43.969877	11
281	TXN834330	Jio	RECHARGE	7764567056	15.0	SUCCESS	127	2025-09-17 09:19:00.912416	2025-09-17 09:19:00.912416	11
282	TXN122653	Airtel	RECHARGE	8767867867	200.0	SUCCESS	127	2025-09-17 09:35:50.907701	2025-09-17 09:35:50.907701	11
283	TXN832440	Jio	RECHARGE	8976695656	10.0	SUCCESS	127	2025-09-17 09:46:34.617237	2025-09-17 09:46:34.617237	11
284	TXN489650	Jio	RECHARGE	7567586975	100.0	SUCCESS	127	2025-09-17 09:48:16.278247	2025-09-17 09:48:16.278247	11
285	TXN214259	Airtel	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-17 10:13:05.935248	2025-09-17 10:13:05.935248	11
286	TXN593081	Jio	RECHARGE	3454534534	100.0	SUCCESS	127	2025-09-17 10:26:43.701329	2025-09-17 10:26:43.701329	11
295	TXN903636	Airtel	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-17 10:41:26.622673	2025-09-17 10:41:26.622673	11
296	TXN433465	Jio	RECHARGE	5686585685	10.0	SUCCESS	127	2025-09-17 10:41:58.333323	2025-09-17 10:41:58.333323	11
297	TXN737030	Jio	RECHARGE	3423423423	120.0	SUCCESS	127	2025-09-17 10:42:39.982348	2025-09-17 10:42:39.982348	11
308	TXN722291	Airtel	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-17 10:51:05.168523	2025-09-17 10:51:05.168523	11
309	TXN364761	Vi	RECHARGE	5654656456	10.0	SUCCESS	127	2025-09-17 10:51:19.628799	2025-09-17 10:51:19.628799	11
310	TXN315212	Jio	RECHARGE	9845867567	12.0	SUCCESS	127	2025-09-17 10:51:49.49754	2025-09-17 10:51:49.49754	11
311	TXN143694	Airtel	RECHARGE	8687658785	50.0	SUCCESS	127	2025-09-17 10:52:17.969768	2025-09-17 10:52:17.969768	11
312	TXN689981	Airtel	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-17 10:54:47.842512	2025-09-17 10:54:47.842512	11
313	TXN258064	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-17 10:57:09.312588	2025-09-17 10:57:09.312588	11
314	TXN269648	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-17 10:58:01.783852	2025-09-17 10:58:01.783852	11
315	TXN724817	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-17 10:59:57.631788	2025-09-17 10:59:57.631788	11
316	TXN615646	Airtel	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-17 11:00:17.213265	2025-09-17 11:00:17.213265	11
317	TXN214319	Jio	RECHARGE	0958765675	200.0	SUCCESS	127	2025-09-17 11:26:43.713611	2025-09-17 11:26:43.713611	11
318	TXN256499	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-17 11:36:04.041119	2025-09-17 11:36:04.041119	11
319	TXN159094	Airtel	Mobile Recharge	90900990909	200.0	SUCCESS	127	2025-09-17 11:37:06.513151	2025-09-17 11:37:06.513151	11
320	TXN669987	Airtel	Mobile Recharge	90900990909	200.0	SUCCESS	127	2025-09-17 11:37:27.281698	2025-09-17 11:37:27.281698	11
321	TXN625722	Jio	RECHARGE	9876896869	100.0	SUCCESS	127	2025-09-17 11:39:20.104412	2025-09-17 11:39:20.104412	11
322	TXN400351	Airtel	Mobile Recharge	90900990909	100.0	SUCCESS	127	2025-09-17 11:41:47.51083	2025-09-17 11:41:47.51083	11
324	TXN888029	Airtel	RECHARGE	9097689768	100.0	SUCCESS	127	2025-09-17 11:48:12.222171	2025-09-17 11:48:12.222171	11
323	TXN616112	Jio	RECHARGE	7687676767	100.0	SUCCESS	127	2025-09-17 11:43:19.831598	2025-09-17 11:43:19.831598	11
325	TXN103156	Jio	RECHARGE	9789669767	100.0	SUCCESS	127	2025-09-17 12:28:54.970953	2025-09-17 12:28:54.970953	11
326	TXN609571	Airtel	RECHARGE	8784685486	200.0	SUCCESS	127	2025-09-17 12:29:36.34278	2025-09-17 12:29:36.34278	11
327	TXN564454	Airtel	RECHARGE	1000789789	200.0	SUCCESS	127	2025-09-17 12:31:10.357063	2025-09-17 12:31:10.357063	11
328	TXN399632	Airtel	RECHARGE	8968776587	100.0	SUCCESS	127	2025-09-17 12:32:22.390778	2025-09-17 12:32:22.390778	11
329	TXN806740	Airtel	RECHARGE	6796986976	100.0	SUCCESS	127	2025-09-17 13:07:40.843607	2025-09-17 13:07:40.843607	11
330	TXN956273	Vi	RECHARGE	5465464565	100.0	SUCCESS	127	2025-09-17 13:21:12.841464	2025-09-17 13:21:12.841464	11
331	TXN546292	Jio	RECHARGE	6585675675	200.0	SUCCESS	127	2025-09-17 13:21:37.296395	2025-09-17 13:21:37.296395	11
332	TXN258548	Airtel	Mobile Recharge	90900990909	100.0	SUCCESS	127	2025-09-17 13:27:11.700797	2025-09-17 13:27:11.700797	11
333	TXN961809	Airtel	Mobile Recharge	90900990909	100.0	SUCCESS	127	2025-09-17 13:32:55.517983	2025-09-17 13:32:55.517983	11
334	TXN381293	Jio	RECHARGE	6796786786	100.0	SUCCESS	127	2025-09-17 13:56:34.152287	2025-09-17 13:56:34.152287	11
335	TXN210593	Airtel	RECHARGE	6786786787	100.0	SUCCESS	127	2025-09-17 13:57:11.842682	2025-09-17 13:57:11.842682	11
336	TXN431514	Jio	RECHARGE	0947569697	100.0	SUCCESS	127	2025-09-18 06:55:53.673028	2025-09-18 06:55:53.673028	11
338	TXN413777	Jio	RECHARGE	4645645645	199.0	SUCCESS	127	2025-09-18 07:17:06.526147	2025-09-18 07:17:06.526147	11
339	TXN837088	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-18 07:23:23.735867	2025-09-18 07:23:23.735867	11
340	TXN275214	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-18 07:24:08.868119	2025-09-18 07:24:08.868119	11
341	TXN335281	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-18 07:33:40.636773	2025-09-18 07:33:40.636773	11
342	TXN476639	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-18 07:34:19.027779	2025-09-18 07:34:19.027779	11
343	TXN654151	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-18 07:36:21.332997	2025-09-18 07:36:21.332997	11
344	TXN557708	Airtel	Mobile Recharge	90900990909	200.0	SUCCESS	127	2025-09-18 07:50:43.336924	2025-09-18 07:50:43.336924	11
345	TXN920846	Airtel	RECHARGE	9893738632	200.0	SUCCESS	139	2025-09-18 08:37:43.504628	2025-09-18 08:37:43.504628	11
346	TXN857094	Airtel	RECHARGE	7867876868	100.0	SUCCESS	127	2025-09-18 11:23:48.925907	2025-09-18 11:23:48.925907	11
347	TXN126455	Jio	RECHARGE	9878867676	300.0	SUCCESS	139	2025-09-18 13:10:04.597224	2025-09-18 13:10:04.597224	11
348	TXN373443	Airtel	Mobile Recharge	90900990909	200.0	SUCCESS	127	2025-09-19 10:56:34.351964	2025-09-19 10:56:34.351964	11
349	TXN866337	Airtel	Mobile Recharge	90900990909	200.0	SUCCESS	127	2025-09-19 11:07:44.341036	2025-09-19 11:07:44.341036	11
350	TXN581792	Airtel	Mobile Recharge	90900990909	200.0	SUCCESS	127	2025-09-19 11:08:08.930916	2025-09-19 11:08:08.930916	11
351	TXN950125	Airtel	Mobile Recharge	90900990909	200.0	SUCCESS	127	2025-09-19 11:12:30.625876	2025-09-19 11:12:30.625876	11
352	TXN111597	Jio	RECHARGE	8789795666	200.0	SUCCESS	127	2025-09-19 11:49:50.1497	2025-09-19 11:49:50.1497	11
353	TXN873815	Airtel	RECHARGE	6756756756	399.0	SUCCESS	127	2025-09-19 11:50:50.760418	2025-09-19 11:50:50.760418	11
354	TXN174533	Airtel	Mobile Recharge	90900990909	200.0	SUCCESS	134	2025-09-19 12:06:30.304773	2025-09-19 12:06:30.304773	11
355	TXN832000	Airtel	RECHARGE	9079675870	200.0	SUCCESS	127	2025-09-19 12:23:11.994069	2025-09-19 12:23:11.994069	11
356	TXN912606	Jio	RECHARGE	9856709480	199.0	SUCCESS	127	2025-09-19 14:06:31.428042	2025-09-19 14:06:31.428042	11
\.


--
-- Data for Name: user_services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_services (id, assigner_id, assignee_id, service_id, created_at, updated_at) FROM stdin;
1	104	118	1	2025-09-02 07:20:02.736088	2025-09-02 07:20:02.736088
2	104	118	2	2025-09-02 07:20:02.74618	2025-09-02 07:20:02.74618
4	104	119	1	2025-09-02 07:38:16.845599	2025-09-02 07:38:16.845599
5	104	120	1	2025-09-02 09:12:04.754181	2025-09-02 09:12:04.754181
6	104	120	2	2025-09-02 09:12:04.768069	2025-09-02 09:12:04.768069
7	104	125	1	2025-09-02 09:26:07.006615	2025-09-02 09:26:07.006615
8	104	125	2	2025-09-02 09:26:07.019803	2025-09-02 09:26:07.019803
9	104	126	1	2025-09-02 09:33:16.816745	2025-09-02 09:33:16.816745
10	104	126	2	2025-09-02 09:33:16.829728	2025-09-02 09:33:16.829728
11	104	127	1	2025-09-02 09:38:43.057328	2025-09-02 09:38:43.057328
12	104	127	2	2025-09-02 09:38:43.068864	2025-09-02 09:38:43.068864
14	104	127	4	2025-09-02 09:38:43.089523	2025-09-02 09:38:43.089523
16	104	134	2	2025-09-02 11:52:46.169279	2025-09-02 11:52:46.169279
19	104	134	1	2025-09-02 11:52:46.197359	2025-09-02 11:52:46.197359
20	104	134	4	2025-09-02 11:52:46.20663	2025-09-02 11:52:46.20663
21	104	134	5	2025-09-02 11:52:46.217381	2025-09-02 11:52:46.217381
22	104	134	7	2025-09-02 11:52:46.226589	2025-09-02 11:52:46.226589
23	104	134	8	2025-09-02 11:52:46.236134	2025-09-02 11:52:46.236134
24	104	127	7	2025-09-04 06:56:06.333176	2025-09-04 06:56:06.333176
26	136	138	1	2025-09-04 08:45:42.541177	2025-09-04 08:45:42.541177
27	136	138	4	2025-09-04 08:45:42.552069	2025-09-04 08:45:42.552069
28	136	138	8	2025-09-04 08:45:42.562555	2025-09-04 08:45:42.562555
29	136	138	2	2025-09-04 08:45:42.572578	2025-09-04 08:45:42.572578
30	136	138	7	2025-09-04 08:45:42.586653	2025-09-04 08:45:42.586653
32	138	139	1	2025-09-04 09:05:42.93893	2025-09-04 09:05:42.93893
33	138	139	4	2025-09-04 09:05:42.950946	2025-09-04 09:05:42.950946
34	138	139	2	2025-09-04 09:05:42.960377	2025-09-04 09:05:42.960377
35	138	139	7	2025-09-04 09:05:42.969305	2025-09-04 09:05:42.969305
37	136	140	1	2025-09-04 18:29:32.039959	2025-09-04 18:29:32.039959
38	136	140	4	2025-09-04 18:29:32.050901	2025-09-04 18:29:32.050901
39	136	140	2	2025-09-04 18:29:32.062535	2025-09-04 18:29:32.062535
40	136	140	7	2025-09-04 18:29:32.071386	2025-09-04 18:29:32.071386
42	136	141	1	2025-09-04 18:35:04.279798	2025-09-04 18:35:04.279798
43	136	141	4	2025-09-04 18:35:04.301142	2025-09-04 18:35:04.301142
44	136	141	2	2025-09-04 18:35:04.31442	2025-09-04 18:35:04.31442
45	136	141	7	2025-09-04 18:35:04.32646	2025-09-04 18:35:04.32646
47	141	142	1	2025-09-04 18:41:03.664784	2025-09-04 18:41:03.664784
48	141	142	4	2025-09-04 18:41:03.689181	2025-09-04 18:41:03.689181
49	141	142	2	2025-09-04 18:41:03.704711	2025-09-04 18:41:03.704711
50	141	142	7	2025-09-04 18:41:03.718926	2025-09-04 18:41:03.718926
51	104	127	12	2025-09-08 09:23:03.02828	2025-09-08 09:23:03.02828
52	104	127	13	2025-09-08 09:24:54.030865	2025-09-08 09:24:54.030865
53	104	127	14	2025-09-08 09:24:55.732181	2025-09-08 09:24:55.732181
54	104	127	15	2025-09-19 14:21:36.57837	2025-09-19 14:21:36.57837
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, first_name, last_name, email, password_digest, role, otp, verify_otp, otp_expires_at, phone_number, country_code, alternative_number, aadhaar_number, pan_card, date_of_birth, gender, business_name, business_owner_type, business_nature_type, business_registration_number, gst_number, pan_number, address, city, state, pincode, landmark, username, scheme, referred_by, bank_name, account_number, ifsc_code, account_holder_name, notes, session_token, created_at, updated_at, role_id, status, company_type, company_name, cin_number, registration_certificate, user_admin_id, confirm_password, domain_name, scheme_id, service_id, pan_card_image, aadhaar_image, passport_photo, store_shop_photo, address_proof_photo, parent_id, set_pin, confirm_pin) FROM stdin;
114	Ishu	Dhariya	ishuadmin@gmail.com	$2a$12$T/n5QlXtlBYeDotJWBdBJOVk/ijEce5jj291F/HcLEmZNhSg7kcaq	\N	\N	\N	\N	89798798783	\N	03443434334	876876876867233	JKGJGHJ688978	2025-09-04		Credit card sales	Credit Business slove	buessiness s Nature Type	Credit Business Registration Number	986857644645cddsds	\N		noida	Uttar Pradesh	201301	\N	ishu8789	\N	HGG7897897	Axis	7988757678hgg	IFDD&775655	Retailers	\N	\N	2025-09-01 08:41:59.561116	2025-09-02 06:17:34.681616	9	f	\N	\N	\N	\N	\N	ishu4748	ishu123	5	\N	\N	\N	\N	\N	\N	\N	\N	\N
104	admin1	\N	admin@gmail.com	$2a$12$kErLz3zyOm2dKeb11Zeup.21bAp10.0P7qtUmICDK6J2JYyvg6yB.	\N	\N	\N	\N	94434349494	\N	11123232			\N				\N			\N		\N	\N		\N	admin225	\N	\N			\N		\N	\N	2025-08-29 16:09:27.246126	2025-09-19 09:06:35.20568	9	f	\N	\N	\N	\N	\N	\N	\N	5	\N	\N	\N	\N	\N	\N	136	123456	\N
136	super admin	ssk	superadmin@gmail.com	$2a$12$9PhXGyiAk9XMpOw2kXoPCujbwiPUi4Skx1ljbLDE/Dtr4Yvk6h5Yi	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-04 07:52:52.668874	2025-09-11 09:02:41.975324	10	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	123456	\N
145	\N	\N	\N	\N	\N	123456	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-19 06:57:28.114985	2025-09-19 06:58:31.945025	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
148	\N	\N	\N	\N	\N	\N	1	\N	68787676676	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	DPa27Kak5BHTa3MqDcJ1j1A1	2025-09-19 13:41:38.241268	2025-09-19 13:46:45.805757	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
112	Last check Amdin	done	check@gmail.com	$2a$12$Bjh7riJIdvYTdz/sw92mCeOzCLSuKbpPJQiXJ6ORd5quezZJRN.He	\N	\N	\N	\N	79879779887987	\N	8979878798798798798	876876876867233	JKGJGHJ688978	2025-08-23	Male	lkjljkjlkjlkjlkj	lkjljkjlkjlkjlkj	lkjljkjlkjlkjlkj	lkjljkjlkjlkjlkj	76867687	\N	noida 121	noida	Uttar Pradesh	201301	\N	sidtech78678	\N	HGG7897897	Axis	7988757678hgg	IFDD96875	Sidddddddd	\N	\N	2025-08-30 12:36:49.720661	2025-09-02 06:17:35.187671	9	t	\N	\N	\N	\N	\N	123456	sam	5	\N	\N	\N	\N	\N	\N	\N	\N	\N
63	Siddharth	gautam	sid20319@gmail.com	$2a$12$JO8REGKj60NcWybSym0soe/g4XTaretunZjlatQtzicy5OgcnnoUi	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-08-27 05:58:33.297504	2025-09-02 06:17:35.442908	5	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
113	Alim Admin3	Khan	Alimadmin@gmail.com	$2a$12$On5F4IEhPEr.PL6Fm4RTxeKFE7fv1E4dgf2.RVhBKr0fEUJWBwY4K	\N	\N	\N	\N	8908099089898	\N	+919568773855	9867676757656	JKGJGHJ68768	2025-08-21		IT LOAN SOULTION	IT BUSINES LOAN SOLUTION	Business Nature Type	989878967678dsds	986857644645cddsds	\N		noida	Uttar Pradesh	201301	\N	Amir323	\N	123223	HDFC	687687676776876	IFDD96875	Alim Admin	\N	\N	2025-08-30 13:17:19.343681	2025-09-02 06:17:33.411207	9	f	\N	\N	\N	\N	\N	232323	aalimadmin	5	\N	\N	\N	\N	\N	\N	\N	\N	\N
120	tetdsh	jdshdkhj	jkhjds9876876@gmai.com	$2a$12$xMdDNNMXc3SVwoTbqcVFEelMsXolKH0AF/w32okDTm7EYbyQg0guW	\N	\N	\N	\N	03443434334	\N	03443434334	9867676757656	JKGJGHJ688978	2025-09-01	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd	986857644645cddsds	\N	noida 121	noida	Uttar Pradesh	201301	\N	aaisihi	\N						\N	\N	2025-09-02 09:12:04.737004	2025-09-02 09:12:04.737004	9	f	\N	\N	\N	\N	\N		namesing	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
106	Saurav	\N	saurav@gmailcom	$2a$12$wIM6HuqbUxTEFYaLY9KFgOplYERTByO98kLvtapktuQFH8NoTXvgm	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-08-30 06:01:17.85221	2025-09-02 06:17:35.696542	9	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
107	dsds	\N	sam@gmail.com	$2a$12$Hv.Ohx3z53IyUtDSxDAqk.TyvwDRegxSf65iMOtMTCTWBI2hT4cvO	\N	\N	\N	\N	+919568773855	\N	\N	98798798798687	\N	\N	\N	\N	\N	\N	\N	4343	HJHJK87797J	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-08-30 06:36:54.886138	2025-09-02 06:17:35.951099	9	f	\N	fdd	\N	dfdss	0	123	sam	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
103	Master	kumar	master@gmail.com	$2a$12$/UeN5ofRoHdl30iPr1yLjOPBxHJK7yJnuVT3r1aqvKEAAT.fdULs2	\N	\N	\N	\N	77879987979	\N	78098798687	7987687576457476	JKGJGHJ688978	2025-08-22	Male	Insurance Business	Insurance Business Ownership Type	Insurance Business Nature Type	98789798798787	986857644645cddsds	\N	noida 121	noida	Uttar Pradesh	201301	\N	maste7879879	paid	HGG7897897	Axis	7988757678hgg	IFDD&775655	master	\N	\N	2025-08-29 05:50:45.95782	2025-09-02 06:17:36.204055	6	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
116	Siddharth admin	gautam	sid20319@gmail.com	$2a$12$oipaiZHpfbOVAw21Vbx0CuiLKB.Jr2Dao1PT5hO8mQ8sUxGbG2kcy	\N	\N	\N	\N	+919568773855	\N	03443434334	98798798798687	JKGJGHJ688978	\N	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd	986857644645cddsds	\N	noida 121	noida	Uttar Pradesh	201301	\N	sidtech78678	\N	HGG7897897					\N	\N	2025-09-02 06:57:13.265005	2025-09-02 06:57:13.265005	9	f	\N	\N	\N	\N	\N	123456	sidadmin	5	\N	\N	\N	\N	\N	\N	\N	\N	\N
119	alminadmin	admin	lkjkljds@gmail.com	$2a$12$vWexdLFBSIC0IQHkUQV/Eez5mK4.Mih0h9vhPrynLAm4RMa/IVbb.	\N	\N	\N	\N	90990988433	\N	03443434334	7328728367	JKGJGHJ68768	2025-09-01	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd	986857644645cddsds	\N	noida 121	noida	Uttar Pradesh	201301	\N	siddharth343443	\N	HGG7897897	Axis	687687676776876	IFDD&775655		\N	\N	2025-09-02 07:38:16.83295	2025-09-02 07:39:10.796858	5	f	\N	\N	\N	\N	\N	123456	LK	5	\N	\N	\N	\N	\N	\N	\N	\N	\N
121	dds	dsds	ddsds@gmail.com	\N	\N	\N	\N	\N	9879798787798	\N	33232323232443	9867676757656	JKGJGHJ688978	2025-09-01	Male						\N					\N								\N	\N	2025-09-02 09:16:50.279226	2025-09-02 09:16:50.279226	6	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
117	tetdsh admin	jdshdkhj	hjkhdkjshs@gmai.com	$2a$12$CTes.77NLRMBi14MAOTzpO7xjXKzM/koG9FrjrA2noQnEgGqLCovC	\N	\N	\N	\N	03443434334	\N	+919568773855	9867676757656	dskjds	2025-10-04	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd	986857644645cddsds	\N	noida 121	noida	Uttar Pradesh	201301	\N	siddharth23232	\N		Axis	7988757678hgg	IFDD96875		\N	528bfc6ca23e1aec5b80e7ee858a5cb02bf3e74c	2025-09-02 07:00:17.967209	2025-09-02 07:39:52.558184	9	t	\N	\N	\N	\N	\N	123456	LK	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
122	Siddharth	gautam	sid20319@gmail.com	\N	\N	\N	\N	\N	+919568773855	\N	03443434334			\N	Select gender						\N					\N								\N	\N	2025-09-02 09:17:38.186319	2025-09-02 09:17:38.186319	5	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
64	Siddharth	gautam	sid203191@gmail.com	$2a$12$LqHXjK1ApiWq3Hdtiz3mxuMPapt7f27NScf4vRz1eQTSPpPgtoV/a	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-08-27 06:06:23.479823	2025-09-02 06:17:34.174339	6	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
115	Siddharth	gautam	sid20319@gmail.com	$2a$12$vgdMQ.nVQ3v5Opf7PO.MKe9Ir9F2vKLvWk/.u.hW7jw6OPDEyl8xm	\N	\N	\N	\N	+919568773855	\N	+919568773855	876876876867233	JKGJGHJ68768	2025-09-05	Select gender						\N					\N								\N	\N	2025-09-01 12:11:36.6599	2025-09-02 06:17:34.428781	5	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
123	Ashok kumar	sing	ashok@gmail.com	$2a$12$6Bufd22R0bN7CqzzJvsSceaKNWhFmEWcBN.EPGtc.UuHh58VotZuK	\N	\N	\N	\N	7897879879	\N	98797987979	876876876867233	JKGJGHJ688978	2025-09-01	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd	986857644645cddsds	\N	Noida, Uttar Pradesh, India	Noida	Uttar Pradesh	ds233232	\N	ashok79798	paid	HGG7897897	Axis	7988757678hgg	IFDD96875	Ashok	\N	\N	2025-09-02 09:21:22.367274	2025-09-02 09:21:22.367274	5	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
124	dsds	dsds	dsds1111@gmail.com	$2a$12$I7eTYPo.Ih4CecQlup87LewDGANadhCEDdUo2.eAKu/C9OmdGmE12	\N	\N	\N	\N	dsds	\N	dsds	dsds	dsds	\N	Select gender	dddfdffd	dddfdffd	dddfdffd	dddfdffd		\N	noida 121	noida	Uttar Pradesh	201301	\N	sidtech78678							\N	\N	2025-09-02 09:23:42.407569	2025-09-02 09:23:42.407569	5	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
126	don11	kumar	don11@gmail.com	$2a$12$GLHjSzVQr78G0W9erfWnzesHakQN4bSMj3HwMyOQvwkopolO1xpNS	\N	\N	\N	\N	876876876786	\N	03443434334	986767675765622	JKGJGHJ688978	2025-09-01	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd		\N	noida 121	noida	Uttar Pradesh	201301	\N	don11	\N		Axis	7988757678hgg	IFDD&775655	don11	\N	\N	2025-09-02 09:33:16.802674	2025-09-02 09:33:16.802674	9	f	\N	\N	\N	\N	\N	123456		5	\N	\N	\N	\N	\N	\N	\N	\N	\N
125	tetdsh	jdshdkhj	hjkhdkjshs@gmai.com	$2a$12$Pmx8LzTfUgrLFuvjmMugO.BDDK11lPhWZl85hHztxVBgEUaQroU4C	\N	\N	\N	\N	03443434334	\N	+919568773855		JKGJGHJ68768	\N	Female						\N					\N		\N		Axis	7988757678hgg	IFDD&775655		\N	\N	2025-09-02 09:26:06.988697	2025-09-02 09:26:06.988697	9	f	\N	\N	\N	\N	\N			\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
118	Siddharth	gautam	sidtest@gmail.com	$2a$12$bScG9DTUcClpOFLZQsW4rulxWA5d1Fpr7VysITYFhasLWn5qV/5nS	\N	\N	\N	\N	+919568773855	\N	+919568773855	9867676757656	JKGJGHJ68768	\N	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd	986857644645cddsds	\N	Gawalira	Saharanpur	Uttar Pradesh	247001	\N		\N						\N	47473b45a624cbf222a2f9a0dac6877bc37326f6	2025-09-02 07:20:02.690017	2025-09-04 06:17:17.446234	5	t	\N	\N	\N	\N	\N	123456	amdin788	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
141	Shek	aalam	shek@gmail.com	$2a$12$eaEveK9bW2pC14ehDryUyeDBStZ8dShiTOSolTBmEgNuChyAMvGZG	\N	\N	\N	\N	9568773855	\N	9568773855	98798798798687	JKGJGHJ68768DD	2025-09-03	Male						\N					\N	Shak344343	\N		Axis	7988757678hgg	IFDD&775655	Alim	\N	\N	2025-09-04 18:35:04.24181	2025-09-04 18:37:01.728801	9	f	\N	\N	\N	\N	\N	shak123		5	\N	\N	\N	\N	\N	\N	136	\N	\N
128	Deepak	Kumar	deepak@gmail.com	$2a$12$Y2XkV2FZJtmtIP7yaWTI2.8ew.bgSdhtd6BsYc.CAgepA9xhro9Ni	\N	\N	\N	\N	897988798743	\N	89798879872	897988798712	JKGJGHJ68768DD	2025-09-01	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd		\N	Noida, Uttar Pradesh, India	Noida	Uttar Pradesh	ds233232	\N	deepak989	paid	HGG7897897	\N	\N	\N	\N		ed55c486a63ceb93078fe6db507c241a1613898e	2025-09-02 11:37:19.658725	2025-09-02 11:42:17.407239	5	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
129	mona	singh4	mona@gmail.com	$2a$12$GjElBj/SIW.avp5470ajG.lV6BnFnlY3TQ7s7MkoO6hIVWghO2pda	\N	\N	\N	\N		\N	65656565655	9877987877787	JKGJGHJ68768	2025-09-02	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd		\N	noida 121	noida	Uttar Pradesh	201301	\N	mona7768798	paid	HGG7897897	Axis	7988757678hgg	IFDD&775655	Alim	\N	1b057f28b4e935c66ab752e3839c07afa468158e	2025-09-02 11:43:35.893844	2025-09-02 11:44:42.105716	5	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
142	shek khan	Retailer	shekkhan@gmail.com	$2a$12$2nrtTrbL1IIh8t/wGGEP1egNqMkPL/4/EARaLsOdF0z/V0Dmr3yeS	\N	\N	\N	\N	+919568773855	\N	+919568773855	7328728367	JKGJGHJ688978	2025-09-03	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd		\N	noida 121	noida	Uttar Pradesh	201301	\N	shekkhan123	\N		Axis	7988757678hgg			\N	14acdc9b6da431369b865cb50874268cb315a0fb	2025-09-04 18:41:03.59699	2025-09-04 18:42:56.490229	5	t	\N	\N	\N	\N	\N	123456	\N	5	\N	\N	\N	\N	\N	\N	141	\N	\N
138	Mohammad Admin	8989898989	mohammad@gmail.com	$2a$12$4jWbmFwYnqIlkWx8QC9vLuPPEmNT.UaBis5VRhtMdUAx8tHcIrQ4u	\N	\N	\N	\N	787987987988	\N	89798787783	7788978798334	JKGJGHJ68768DD	2025-09-03	Male	Credit card sales	Credit Business slove	Credit Business Nature Type	Credit Business Registration Number	798797d87ds797ds987987	\N	noida 121	noida	Uttar Pradesh	201301	\N	mohd28982	\N	HGG789789778	Axis	687687676776876	IFDD&775655	mohd787	\N	\N	2025-09-04 08:45:42.495292	2025-09-12 12:09:43.049315	9	f	\N	\N	\N	\N	\N	mohd123	mohdshek	5	\N	\N	\N	\N	\N	\N	136	\N	\N
140	admin2	gautam	admin2@gmail.com	$2a$12$9WcYcbPvfwTR8r4ns5Fi7eQQ6LnaCIUZkiUj9vQAycYH.Pv8TvD9.	\N	\N	\N	\N	89898808888	\N	89898808888	9867676757656	JKGJGHJ688978	\N	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd		\N	noida 121	noida	Uttar Pradesh	201301	\N	sidtech78678	\N		Axis				\N	\N	2025-09-04 18:29:32.002565	2025-09-04 18:29:32.002565	9	f	\N	\N	\N	\N	\N	123456		5	\N	\N	\N	\N	\N	\N	\N	\N	\N
139	Tej	singh	tej@gmail.com	$2a$12$sr2e3Chig0WLaaZyX7edIepMg2nEOi4QrLcDlnXaxpTuH.kPgUFXK	\N	\N	\N	\N	90898798788	\N	90889798798	787898779797977	JKGJGHJ688978	2025-09-02	Male	LOAN SOULUTION	Loan Business Ownership	Loan Nature Type	328987097ds979d89787	986857644645cddsds	\N	noida 121	noida	Uttar Pradesh	201301	\N	tej88989	\N	tej87787	HDFC	687687676776876	IFDD&775655	Tej	\N	6df9e3f719c900dd5fab81a051db5412722556b1	2025-09-04 09:05:42.906747	2025-09-19 05:22:50.384881	5	t	\N	\N	\N	\N	\N	tej123	\N	16	\N	\N	\N	\N	\N	\N	104	123123	123123
147	\N	\N	\N	\N	\N	\N	1	\N	123456	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6ePqqfFnT29yH3G51Dp315mk	2025-09-19 07:09:44.153081	2025-09-19 07:14:34.989503	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
146	\N	\N	\N	\N	\N	123456	0	\N	98797979798	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-19 07:04:43.110042	2025-09-19 07:18:30.274639	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
127	jon11	wim	jon11@gmail.com	$2a$12$IHLSFihyx6LpPyMj7sxVzuOjBX1.uWoM.9Xs6Ere.JXqT76bIZxW6	\N	\N	\N	\N	323243434343	\N	03443434334	876876876867233	JKGJGHJ688978	2025-09-01		dddfdffd	dddfdffd	dddfdffd	dddfdffd	986857644645cddsds	\N		noida	Uttar Pradesh	201301	\N	lastadmin223	\N						\N	20ab4427f039b667d077f437e1d833b3f66693f5	2025-09-02 09:38:43.044029	2025-09-19 09:20:02.914018	5	t	\N	\N	\N	\N	\N	123456	late22	5	\N	\N	\N	\N	\N	\N	104	123123	123123
134	Siddharth	gautam	sid20312229@gmail.com	$2a$12$lrXflu..qyuzpcCmyJ.QeuOyWbRfzWaZ4mW6a4nJ6GDK705C8smum	\N	\N	\N	\N	9568773855	\N				\N	Select gender	dddfdffd	dddfdffd	dddfdffd	dddfdffd		\N	noida 121	noida	Uttar Pradesh	201301	\N	siddharth	\N		HDFC				\N	bca6e4a1a997af7cab95c78b6c22452f122e544e	2025-09-02 11:52:46.12845	2025-09-19 12:05:13.940195	5	t	\N	\N	\N	\N	\N	123456		16	\N	\N	\N	\N	\N	\N	104	123456	123456
\.


--
-- Data for Name: wallet_transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wallet_transactions (id, wallet_id, tx_id, mode, transaction_type, amount, status, description, created_at, updated_at, fund_request_id) FROM stdin;
33	7	TXN260275	credit	UPI	100.00	success	Fund request created by admin 104	2025-09-06 12:32:32.759583	2025-09-06 12:32:42.141969	36
34	7	TXN652712	credit	NEFT	100.00	success	Fund request created by admin 104	2025-09-06 12:34:04.588085	2025-09-06 12:34:09.857552	37
35	7	TXN311087	credit	UPI	100.00	success	Fund request created by admin 104	2025-09-06 12:34:52.807495	2025-09-06 12:34:57.990391	38
36	8	TXN205966	credit	NEFT	93.00	success	Fund request created by user 127	2025-09-06 12:35:37.133478	2025-09-06 12:35:43.846227	39
38	7	TXN815102	credit	UPI	1000.00	success	Fund request created by admin 104	2025-09-06 12:36:50.773044	2025-09-06 12:36:55.856664	41
37	8	TXN731009	credit	CashInBank	400.00	success	Fund request created by user 127	2025-09-06 12:36:21.973743	2025-09-06 12:37:04.573244	40
39	7	TXN657825	credit	UPI	100.00	success	Fund request created by admin 104	2025-09-06 12:50:35.924536	2025-09-06 12:50:43.761079	42
40	8	TXN741310	credit	NEFT	100.00	success	Fund request created by user 127	2025-09-06 12:52:53.435952	2025-09-06 12:53:35.352903	43
41	7	TXN216166	credit	UPI	100.00	success	Fund request created by admin 104	2025-09-06 12:59:23.060039	2025-09-06 12:59:40.814622	44
42	8	TXN921061	credit	Cheque	100.00	success	Fund request created by user 127	2025-09-06 13:02:08.890079	2025-09-06 13:02:21.415649	45
43	8	TXN278044	credit	CashInBank	1000.00	success	Fund request created by user 127	2025-09-08 04:47:39.065245	2025-09-08 04:48:00.600174	46
44	8	TXN777359	credit	IMPS	100.00	success	Fund request created by user 127	2025-09-08 05:38:42.866442	2025-09-08 05:38:48.103136	47
45	9	TXN929523	credit	NEFT	200.00	pending	Fund request created by user 139	2025-09-08 05:43:00.602515	2025-09-08 05:43:00.602515	48
46	9	TXN204726	credit	NEFT	299.00	success	Fund request created by user 139	2025-09-08 05:44:50.501907	2025-09-08 05:44:55.907098	49
47	10	TXN504986	credit	NEFT	399.00	success	Fund request created by user 134	2025-09-08 06:37:14.710744	2025-09-08 06:37:47.176799	50
48	10	TXN553011	credit	UPI	100.00	success	Fund request created by user 134	2025-09-08 07:28:53.011439	2025-09-08 07:29:22.174865	51
49	10	TXN988040	credit	NEFT	120.00	success	Fund request created by user 134	2025-09-08 07:45:11.383965	2025-09-08 07:45:20.505088	52
50	7	TXN304406	credit	NEFT	100.00	success	Fund request created by admin 104	2025-09-08 07:53:10.203717	2025-09-08 07:53:45.357626	53
51	7	TXN615493	credit	NEFT	100.00	success	Fund request created by admin 104	2025-09-08 08:30:37.311863	2025-09-08 08:30:46.83055	54
52	7	TXN129506	credit	CashInBank	100.00	success	Fund request created by admin 104	2025-09-08 08:32:27.800666	2025-09-08 08:32:37.465641	55
54	9	TXN524545	credit	Netbanking	997.00	success	Fund request created by user 139	2025-09-08 12:31:35.799431	2025-09-08 12:31:46.119127	57
55	9	TXN117497	credit	Netbanking	500.00	success	Fund request created by user 139	2025-09-08 12:34:09.596441	2025-09-08 12:34:23.76643	58
56	7	TXN906689	credit	UPI	1000.00	success	Fund request created by admin 104	2025-09-08 13:22:27.758074	2025-09-08 13:22:38.45312	59
57	8	TXN855302	credit	Cash	100.00	success	Fund request created by user 127	2025-09-10 13:31:42.363873	2025-09-11 07:35:41.520124	60
58	10	TXN973247	credit	UPI	300.00	success	Fund request created by user 134	2025-09-11 06:42:27.994446	2025-09-11 07:37:22.381013	61
59	10	TXN575575	credit	UPI	300.00	success	Fund request created by user 134	2025-09-11 07:38:16.985531	2025-09-11 07:38:35.314701	62
60	10	TXN282061	credit	UPI	300.00	success	Fund request created by user 134	2025-09-11 07:39:29.99097	2025-09-11 07:40:10.645672	63
53	7	TXN554071	credit	UPI	100.00	success	Fund request created by admin 104	2025-09-08 08:33:58.92784	2025-09-11 07:40:44.459161	56
61	10	TXN395543	credit	UPI	300.00	success	Fund request created by user 134	2025-09-11 07:40:27.474232	2025-09-11 07:41:10.807213	64
62	10	TXN263296	credit	UPI	300.00	success	Fund request created by user 134	2025-09-11 07:56:25.347379	2025-09-11 07:57:29.385367	65
63	10	TXN429176	credit	UPI	300.00	success	Fund request created by user 134	2025-09-11 08:38:21.066238	2025-09-11 08:38:50.562914	66
65	7	TXN574662	credit	UPI	300000.00	success	Fund request created by admin 104	2025-09-11 08:41:07.390151	2025-09-11 08:41:13.494075	68
64	10	TXN864120	credit	UPI	300.00	success	Fund request created by user 134	2025-09-11 08:40:14.029634	2025-09-11 08:45:43.187823	67
68	10	TXN709876	credit	UPI	300.00	pending	Fund request created by user 134	2025-09-11 09:16:37.371668	2025-09-11 09:16:37.371668	71
66	10	TXN925880	credit	UPI	300.00	success	Fund request created by user 134	2025-09-11 08:45:56.284176	2025-09-11 09:17:31.603568	69
67	7	TXN403626	credit	UPI	1000.00	success	Fund request created by admin 104	2025-09-11 09:16:03.667316	2025-09-11 09:30:58.389928	70
69	7	TXN642414	credit	UPI	100.00	success	Fund request created by admin 104	2025-09-11 09:46:31.334899	2025-09-11 09:53:51.629337	72
71	9	TXN622919	credit	UPI	10000.00	success	Fund request created by user 139	2025-09-11 09:56:48.441851	2025-09-11 09:57:09.955905	74
70	8	TXN134405	credit	UPI	10000.00	success	Fund request created by user 127	2025-09-11 09:56:48.246996	2025-09-11 09:57:32.159716	73
73	9	TXN736741	credit	Cheque	90000.00	success	Fund request created by user 139	2025-09-11 11:04:05.655865	2025-09-11 11:04:54.951083	76
74	10	TXN570781	credit	UPI	120.00	success	Fund request created by user 134	2025-09-11 12:55:29.695447	2025-09-11 12:55:54.552283	77
75	7	TXN965686	credit	UPI	100.00	success	Fund request created by admin 104	2025-09-11 12:56:20.475226	2025-09-11 12:56:39.814303	78
76	9	TXN947096	credit	Cash	333.00	success	Fund request created by user 139	2025-09-11 14:12:28.325684	2025-09-11 14:12:55.431009	79
77	7	TXN811393	credit	UPI	1089.00	success	Fund request created by admin 104	2025-09-11 14:13:40.697548	2025-09-11 14:16:24.323171	80
86	7	TXN722060	dsswefedsc	IMPS	3.00	success	Fund request created by admin 104	2025-09-12 10:45:43.832027	2025-09-12 10:46:02.708676	86
87	7	TXN498882	dsswefedsc	UPI	5.00	success	Fund request created by admin 104	2025-09-12 10:48:09.100852	2025-09-12 10:48:22.079924	87
88	7	TXN490834	dsswefedsc	UPI	5.00	success	Fund request created by admin 104	2025-09-12 10:49:33.185904	2025-09-12 10:51:01.197241	88
89	7	TXN480005	dsswefedsc	CashInBank	5.00	success	Fund request created by admin 104	2025-09-12 10:56:10.965736	2025-09-12 10:56:19.609449	89
90	9	TXN295751	credit	Cheque	44.00	success	Fund request created by user 139	2025-09-12 10:56:50.812884	2025-09-12 10:57:39.117474	90
72	8	TXN258373	credit	Netbanking	1000.00	success	Fund request created by user 127	2025-09-11 09:59:40.812424	2025-09-12 10:58:18.916405	75
91	8	TXN540327	credit	Netbanking	2000.00	success	Fund request created by user 127	2025-09-12 10:58:46.394786	2025-09-12 10:59:05.680502	91
92	7	TXN652823	dsswefedsc	NEFT	9.00	success	Fund request created by admin 104	2025-09-12 11:04:17.838631	2025-09-12 11:04:33.521854	92
93	7	TXN410031	dsswefedsc	UPI	5.00	success	Fund request created by admin 104	2025-09-12 11:07:46.11619	2025-09-12 11:08:10.921689	93
94	7	TXN567087	dsswefedsc	NEFT	5.00	success	Fund request created by admin 104	2025-09-12 11:09:37.774559	2025-09-12 11:10:34.721447	94
95	7	TXN886693	dsswefedsc	UPI	5.00	success	Fund request created by admin 104	2025-09-12 11:41:44.681578	2025-09-12 11:41:55.047594	95
96	7	TXN565285	dsswefedsc	UPI	5.00	success	Fund request created by admin 104	2025-09-12 11:44:37.185358	2025-09-12 11:45:23.947889	96
97	7	TXN323962	dsswefedsc	UPI	5.00	success	Fund request created by admin 104	2025-09-12 11:46:17.549363	2025-09-12 11:46:37.374574	97
98	9	TXN612223	credit	Cash	85.00	pending	Fund request created by user 139	2025-09-12 12:05:31.133304	2025-09-12 12:05:31.133304	98
99	59	TXN812583	dsswefedsc	IMPS	100.00	pending	Fund request created by admin 138	2025-09-12 12:06:33.559885	2025-09-12 12:06:33.559885	99
100	7	TXN124316	dsswefedsc	NEFT	5.00	success	Fund request created by admin 104	2025-09-12 12:07:09.183112	2025-09-12 12:10:01.965463	100
102	60	TXN586796	dsswefedsc	UPI	85.00	success	Fund request created by admin 141	2025-09-12 12:11:31.819465	2025-09-12 12:11:48.913497	102
101	59	TXN743709	dsswefedsc	IMPS	100.00	success	Fund request created by admin 138	2025-09-12 12:10:10.606201	2025-09-12 12:12:04.079765	101
103	60	TXN750109	dsswefedsc	Cash	90.00	success	Fund request created by admin 141	2025-09-12 12:41:03.050582	2025-09-12 12:43:28.28125	103
104	60	TXN431985	dsswefedsc	Cash	100.00	pending	Fund request created by admin 141	2025-09-12 12:47:36.205737	2025-09-12 12:47:36.205737	104
105	10	TXN365606	credit	NEFT	100.00	success	Fund request created by user 134	2025-09-15 17:29:52.918407	2025-09-15 17:30:20.993213	105
106	8	TXN929664	credit	UPI	50000.00	success	Fund request created by user 127	2025-09-18 07:03:50.192273	2025-09-18 07:04:06.024179	106
107	8	TXN695220	credit	CashInBank	2000.00	success	Fund request created by user 127	2025-09-18 07:13:36.806511	2025-09-18 07:13:48.146447	107
\.


--
-- Data for Name: wallets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wallets (id, user_id, balance, created_at, updated_at) FROM stdin;
9	139	99515.92	2025-09-08 05:43:00.575812	2025-09-18 13:10:04.566271
60	141	230.0	2025-09-12 12:11:31.809681	2025-09-12 12:49:13.271991
10	134	47264.0	2025-09-08 06:37:14.67418	2025-09-19 12:06:30.273708
8	127	51351.76	2025-09-06 12:35:37.121371	2025-09-19 14:06:31.412242
7	104	86393.26999999999999	2025-09-06 12:32:32.749727	2025-09-19 14:06:31.492497
58	136	499868.330000000000003	2025-09-12 10:29:25.138537	2025-09-19 14:06:31.51287
59	138	100.0	2025-09-12 12:06:33.547259	2025-09-12 12:22:20.631315
\.


--
-- Name: account_transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_transactions_id_seq', 18, true);


--
-- Name: banks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.banks_id_seq', 3, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 58, true);


--
-- Name: commissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.commissions_id_seq', 76, true);


--
-- Name: enquiries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enquiries_id_seq', 11, true);


--
-- Name: fund_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fund_requests_id_seq', 107, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 11, true);


--
-- Name: schemes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.schemes_id_seq', 17, true);


--
-- Name: service_product_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.service_product_items_id_seq', 2, true);


--
-- Name: service_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.service_products_id_seq', 23, true);


--
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.services_id_seq', 15, true);


--
-- Name: transaction_commissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transaction_commissions_id_seq', 225, true);


--
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transactions_id_seq', 356, true);


--
-- Name: user_services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_services_id_seq', 54, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 148, true);


--
-- Name: wallet_transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wallet_transactions_id_seq', 107, true);


--
-- Name: wallets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wallets_id_seq', 60, true);


--
-- Name: account_transactions account_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_transactions
    ADD CONSTRAINT account_transactions_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: banks banks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.banks
    ADD CONSTRAINT banks_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: commissions commissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commissions
    ADD CONSTRAINT commissions_pkey PRIMARY KEY (id);


--
-- Name: enquiries enquiries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enquiries
    ADD CONSTRAINT enquiries_pkey PRIMARY KEY (id);


--
-- Name: fund_requests fund_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fund_requests
    ADD CONSTRAINT fund_requests_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: schemes schemes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schemes
    ADD CONSTRAINT schemes_pkey PRIMARY KEY (id);


--
-- Name: service_product_items service_product_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_product_items
    ADD CONSTRAINT service_product_items_pkey PRIMARY KEY (id);


--
-- Name: service_products service_products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_products
    ADD CONSTRAINT service_products_pkey PRIMARY KEY (id);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- Name: transaction_commissions transaction_commissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_commissions
    ADD CONSTRAINT transaction_commissions_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: user_services user_services_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_services
    ADD CONSTRAINT user_services_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: wallet_transactions wallet_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallet_transactions
    ADD CONSTRAINT wallet_transactions_pkey PRIMARY KEY (id);


--
-- Name: wallets wallets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT wallets_pkey PRIMARY KEY (id);


--
-- Name: idx_on_assigner_id_assignee_id_service_id_befeb9b84f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_on_assigner_id_assignee_id_service_id_befeb9b84f ON public.user_services USING btree (assigner_id, assignee_id, service_id);


--
-- Name: index_account_transactions_on_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_account_transactions_on_parent_id ON public.account_transactions USING btree (parent_id);


--
-- Name: index_account_transactions_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_account_transactions_on_user_id ON public.account_transactions USING btree (user_id);


--
-- Name: index_account_transactions_on_wallet_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_account_transactions_on_wallet_id ON public.account_transactions USING btree (wallet_id);


--
-- Name: index_categories_on_service_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_categories_on_service_id ON public.categories USING btree (service_id);


--
-- Name: index_commissions_on_scheme_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_commissions_on_scheme_id ON public.commissions USING btree (scheme_id);


--
-- Name: index_commissions_on_service_product_item_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_commissions_on_service_product_item_id ON public.commissions USING btree (service_product_item_id);


--
-- Name: index_enquiries_on_role_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_enquiries_on_role_id ON public.enquiries USING btree (role_id);


--
-- Name: index_fund_requests_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_fund_requests_on_user_id ON public.fund_requests USING btree (user_id);


--
-- Name: index_service_product_items_on_service_product_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_service_product_items_on_service_product_id ON public.service_product_items USING btree (service_product_id);


--
-- Name: index_service_products_on_category_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_service_products_on_category_id ON public.service_products USING btree (category_id);


--
-- Name: index_transaction_commissions_on_service_product_item_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_transaction_commissions_on_service_product_item_id ON public.transaction_commissions USING btree (service_product_item_id);


--
-- Name: index_transaction_commissions_on_transaction_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_transaction_commissions_on_transaction_id ON public.transaction_commissions USING btree (transaction_id);


--
-- Name: index_transaction_commissions_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_transaction_commissions_on_user_id ON public.transaction_commissions USING btree (user_id);


--
-- Name: index_transactions_on_service_product_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_transactions_on_service_product_id ON public.transactions USING btree (service_product_id);


--
-- Name: index_transactions_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_transactions_on_user_id ON public.transactions USING btree (user_id);


--
-- Name: index_user_services_on_assignee_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_user_services_on_assignee_id ON public.user_services USING btree (assignee_id);


--
-- Name: index_user_services_on_assigner_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_user_services_on_assigner_id ON public.user_services USING btree (assigner_id);


--
-- Name: index_user_services_on_service_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_user_services_on_service_id ON public.user_services USING btree (service_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_on_parent_id ON public.users USING btree (parent_id);


--
-- Name: index_users_on_role_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_on_role_id ON public.users USING btree (role_id);


--
-- Name: index_users_on_scheme_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_on_scheme_id ON public.users USING btree (scheme_id);


--
-- Name: index_users_on_service_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_on_service_id ON public.users USING btree (service_id);


--
-- Name: index_wallet_transactions_on_fund_request_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_wallet_transactions_on_fund_request_id ON public.wallet_transactions USING btree (fund_request_id);


--
-- Name: index_wallet_transactions_on_wallet_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_wallet_transactions_on_wallet_id ON public.wallet_transactions USING btree (wallet_id);


--
-- Name: index_wallets_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_wallets_on_user_id ON public.wallets USING btree (user_id);


--
-- Name: user_services fk_rails_061e6d355b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_services
    ADD CONSTRAINT fk_rails_061e6d355b FOREIGN KEY (service_id) REFERENCES public.services(id);


--
-- Name: users fk_rails_093eb6ba73; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_rails_093eb6ba73 FOREIGN KEY (service_id) REFERENCES public.services(id);


--
-- Name: user_services fk_rails_1e86d8b9bb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_services
    ADD CONSTRAINT fk_rails_1e86d8b9bb FOREIGN KEY (assignee_id) REFERENCES public.users(id);


--
-- Name: transaction_commissions fk_rails_29f6867058; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_commissions
    ADD CONSTRAINT fk_rails_29f6867058 FOREIGN KEY (service_product_item_id) REFERENCES public.service_product_items(id);


--
-- Name: commissions fk_rails_53adc51571; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commissions
    ADD CONSTRAINT fk_rails_53adc51571 FOREIGN KEY (scheme_id) REFERENCES public.schemes(id);


--
-- Name: account_transactions fk_rails_5ab9b90923; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_transactions
    ADD CONSTRAINT fk_rails_5ab9b90923 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: transactions fk_rails_62d1c06ac1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT fk_rails_62d1c06ac1 FOREIGN KEY (service_product_id) REFERENCES public.service_products(id);


--
-- Name: users fk_rails_642f17018b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_rails_642f17018b FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- Name: wallets fk_rails_732f6628c4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT fk_rails_732f6628c4 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: service_product_items fk_rails_74d0229327; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_product_items
    ADD CONSTRAINT fk_rails_74d0229327 FOREIGN KEY (service_product_id) REFERENCES public.service_products(id);


--
-- Name: wallet_transactions fk_rails_75f8c7a2b1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallet_transactions
    ADD CONSTRAINT fk_rails_75f8c7a2b1 FOREIGN KEY (fund_request_id) REFERENCES public.fund_requests(id);


--
-- Name: transactions fk_rails_77364e6416; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT fk_rails_77364e6416 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: service_products fk_rails_785be14229; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_products
    ADD CONSTRAINT fk_rails_785be14229 FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: users fk_rails_7a9470eedc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_rails_7a9470eedc FOREIGN KEY (scheme_id) REFERENCES public.schemes(id);


--
-- Name: fund_requests fk_rails_7b9fe539a7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fund_requests
    ADD CONSTRAINT fk_rails_7b9fe539a7 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: transaction_commissions fk_rails_888daafe72; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_commissions
    ADD CONSTRAINT fk_rails_888daafe72 FOREIGN KEY (transaction_id) REFERENCES public.transactions(id);


--
-- Name: user_services fk_rails_8f67a55a7f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_services
    ADD CONSTRAINT fk_rails_8f67a55a7f FOREIGN KEY (assigner_id) REFERENCES public.users(id);


--
-- Name: commissions fk_rails_ab2512c4b8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commissions
    ADD CONSTRAINT fk_rails_ab2512c4b8 FOREIGN KEY (service_product_item_id) REFERENCES public.service_product_items(id);


--
-- Name: account_transactions fk_rails_acd948a9c0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_transactions
    ADD CONSTRAINT fk_rails_acd948a9c0 FOREIGN KEY (wallet_id) REFERENCES public.wallets(id);


--
-- Name: transaction_commissions fk_rails_c4902f43b3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_commissions
    ADD CONSTRAINT fk_rails_c4902f43b3 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: enquiries fk_rails_cd530b6036; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enquiries
    ADD CONSTRAINT fk_rails_cd530b6036 FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- Name: wallet_transactions fk_rails_d07bc24ce3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallet_transactions
    ADD CONSTRAINT fk_rails_d07bc24ce3 FOREIGN KEY (wallet_id) REFERENCES public.wallets(id);


--
-- Name: categories fk_rails_db8b64c2f7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT fk_rails_db8b64c2f7 FOREIGN KEY (service_id) REFERENCES public.services(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

