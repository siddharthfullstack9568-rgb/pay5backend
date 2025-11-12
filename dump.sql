--
-- PostgreSQL database dump
--

\restrict 24YCf9sccdWcf7xosjo2uwfryxkVm4iph6YgxPyGeHgjQRSt7VV0tpvOU4n3OIs

-- Dumped from database version 14.19 (Ubuntu 14.19-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.19 (Ubuntu 14.19-0ubuntu0.22.04.1)

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
-- Name: instant_loans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instant_loans (
    id bigint NOT NULL,
    first_name character varying,
    last_name character varying,
    email character varying,
    employee_status character varying,
    mobile character varying,
    dob date,
    pan_number character varying,
    aadhaar_number character varying,
    monthly_income numeric,
    credit_score integer,
    fetch_credit_score boolean,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.instant_loans OWNER TO postgres;

--
-- Name: instant_loans_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.instant_loans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.instant_loans_id_seq OWNER TO postgres;

--
-- Name: instant_loans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.instant_loans_id_seq OWNED BY public.instant_loans.id;


--
-- Name: personal_loans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personal_loans (
    id bigint NOT NULL,
    first_name character varying,
    last_name character varying,
    email character varying,
    mobile character varying,
    dob date,
    pan_number character varying,
    aadhaar_number character varying,
    employee_status character varying,
    employer_name character varying,
    office_pin_code character varying,
    monthly_income numeric,
    credit_score integer,
    fetch_credit_score boolean,
    pincode character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.personal_loans OWNER TO postgres;

--
-- Name: personal_loans_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personal_loans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personal_loans_id_seq OWNER TO postgres;

--
-- Name: personal_loans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personal_loans_id_seq OWNED BY public.personal_loans.id;


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
    service_product_id bigint,
    consumer_name character varying,
    subscriber_or_vc_number character varying,
    bill_no character varying,
    landline_no character varying,
    std_code character varying,
    consumer_no character varying,
    bank character varying,
    mobile character varying,
    vehicle_no character varying,
    payment_method character varying,
    ifsc_code character varying,
    pan character varying,
    upi_id character varying,
    receiver_name character varying,
    card_number character varying
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
    confirm_pin character varying,
    latitude numeric(10,6),
    longitude numeric(10,6),
    captured_at timestamp(6) without time zone,
    last_seen_at timestamp(6) without time zone,
    ip_address character varying,
    location character varying,
    kyc_status character varying DEFAULT 'not_started'::character varying,
    kyc_method character varying,
    aadhaar_front_image character varying,
    aadhaar_back_image character varying,
    aadhaar_otp character varying,
    pan_otp character varying,
    pan_status character varying DEFAULT 'not_started'::character varying,
    aadhaar_status character varying DEFAULT 'not_started'::character varying,
    image character varying,
    kyc_verifications boolean DEFAULT false,
    kyc_verified_at timestamp(6) without time zone,
    kyc_data jsonb DEFAULT '{}'::jsonb NOT NULL,
    email_otp character varying,
    email_otp_sent_at timestamp(6) without time zone,
    set_mpin character varying,
    confirm_mpin character varying,
    status_mpin boolean DEFAULT false,
    status_pin boolean DEFAULT false,
    email_otp_status boolean DEFAULT false NOT NULL,
    email_otp_verified_at timestamp(6) without time zone,
    set_pin_status boolean DEFAULT false
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
-- Name: instant_loans id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instant_loans ALTER COLUMN id SET DEFAULT nextval('public.instant_loans_id_seq'::regclass);


--
-- Name: personal_loans id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_loans ALTER COLUMN id SET DEFAULT nextval('public.personal_loans_id_seq'::regclass);


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
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2025-09-18 12:08:09.826461	2025-09-18 12:08:09.826466
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
\.


--
-- Data for Name: commissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.commissions (id, commission_type, from_role, to_role, value, created_at, updated_at, service_product_item_id, scheme_id) FROM stdin;
\.


--
-- Data for Name: enquiries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enquiries (id, first_name, last_name, email, phone_number, aadhaar_number, pan_card, status, role_id, created_at, updated_at) FROM stdin;
1	Aamir	Khan	aamir@gmail.com	9078097987	887787079790	\N	t	5	2025-09-19 06:00:34.131949	2025-09-19 06:03:29.515866
\.


--
-- Data for Name: fund_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fund_requests (id, user_id, requested_by, amount, status, approved_by, approved_at, remark, image, transaction_type, mode, bank_reference_no, payment_mode, deposit_bank, your_bank, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: instant_loans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instant_loans (id, first_name, last_name, email, employee_status, mobile, dob, pan_number, aadhaar_number, monthly_income, credit_score, fetch_credit_score, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: personal_loans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personal_loans (id, first_name, last_name, email, mobile, dob, pan_number, aadhaar_number, employee_status, employer_name, office_pin_code, monthly_income, credit_score, fetch_credit_score, pincode, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, title, created_at, updated_at) FROM stdin;
1	superadmin	2025-09-19 05:59:07.23293	2025-09-19 05:59:07.23293
2	admin	2025-09-19 05:59:12.642239	2025-09-19 05:59:12.642239
3	master	2025-09-19 05:59:20.179881	2025-09-19 05:59:20.179881
4	dealer	2025-09-19 05:59:26.063302	2025-09-19 05:59:26.063302
5	retailer	2025-09-19 05:59:40.274349	2025-09-19 05:59:40.274349
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
20250923062805
20250925072715
20250926121901
20250930052835
20250930104451
20251001100711
20251006072915
20251010060045
20251011064553
20251017054243
20251023105604
20251027120924
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
\.


--
-- Data for Name: service_products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.service_products (id, company_name, admin_commission, master_commission, dealer_commission, retailer_commission, category_id, created_at, updated_at) FROM stdin;
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
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactions (id, tx_id, operator, transaction_type, account_or_mobile, amount, status, user_id, created_at, updated_at, service_product_id, consumer_name, subscriber_or_vc_number, bill_no, landline_no, std_code, consumer_no, bank, mobile, vehicle_no, payment_method, ifsc_code, pan, upi_id, receiver_name, card_number) FROM stdin;
\.


--
-- Data for Name: user_services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_services (id, assigner_id, assignee_id, service_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, first_name, last_name, email, password_digest, role, otp, verify_otp, otp_expires_at, phone_number, country_code, alternative_number, aadhaar_number, pan_card, date_of_birth, gender, business_name, business_owner_type, business_nature_type, business_registration_number, gst_number, pan_number, address, city, state, pincode, landmark, username, scheme, referred_by, bank_name, account_number, ifsc_code, account_holder_name, notes, session_token, created_at, updated_at, role_id, status, company_type, company_name, cin_number, registration_certificate, user_admin_id, confirm_password, domain_name, scheme_id, service_id, pan_card_image, aadhaar_image, passport_photo, store_shop_photo, address_proof_photo, parent_id, set_pin, confirm_pin, latitude, longitude, captured_at, last_seen_at, ip_address, location, kyc_status, kyc_method, aadhaar_front_image, aadhaar_back_image, aadhaar_otp, pan_otp, pan_status, aadhaar_status, image, kyc_verifications, kyc_verified_at, kyc_data, email_otp, email_otp_sent_at, set_mpin, confirm_mpin, status_mpin, status_pin, email_otp_status, email_otp_verified_at, set_pin_status) FROM stdin;
1	Amir	Khan	aamir@gmail.com	$2a$12$5gXMPe3yC6Sm47JTjzvT3uetSFP98CsHVCOWr5NWPBYBGvHgI6QjC	\N	\N	\N	\N	899877979789	\N	870979879877	0980980988898980	JKGJGHJ688978	2000-01-11	Male	Business Name	Business Ownership Type	Business Nature Type	79879879798	986857644645cddsds	\N	noida 121	noida	Uttar Pradesh	201301	\N	amir786	paid	HGG7897897	Axis	7988757678hgg	IFDD&775655	Aamir	\N	7107869eb18b070713af8302d89a76658daca80c	2025-09-19 06:02:56.156694	2025-09-19 06:03:35.981355	5	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
\.


--
-- Data for Name: wallet_transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wallet_transactions (id, wallet_id, tx_id, mode, transaction_type, amount, status, description, created_at, updated_at, fund_request_id) FROM stdin;
\.


--
-- Data for Name: wallets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wallets (id, user_id, balance, created_at, updated_at) FROM stdin;
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
-- Name: instant_loans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.instant_loans_id_seq', 1, false);


--
-- Name: personal_loans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personal_loans_id_seq', 1, false);


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
-- Name: instant_loans instant_loans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instant_loans
    ADD CONSTRAINT instant_loans_pkey PRIMARY KEY (id);


--
-- Name: personal_loans personal_loans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_loans
    ADD CONSTRAINT personal_loans_pkey PRIMARY KEY (id);


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
-- PostgreSQL database dump complete
--

\unrestrict 24YCf9sccdWcf7xosjo2uwfryxkVm4iph6YgxPyGeHgjQRSt7VV0tpvOU4n3OIs

