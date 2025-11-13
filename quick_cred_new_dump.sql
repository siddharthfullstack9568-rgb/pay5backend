--
-- PostgreSQL database dump
--

\restrict fWsyGh7dyg4XYwg1ZJgRYAMMv315MzYGbkpVTxNJ0jQ2sWuPxbvbgPnk8MIcQoA

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
    updated_at timestamp(6) without time zone NOT NULL,
    user_id bigint
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
-- Name: dmt_transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dmt_transactions (
    id bigint NOT NULL,
    dmt_id bigint NOT NULL,
    user_id bigint NOT NULL,
    status character varying,
    txn_id character varying,
    sender_mobile_number character varying,
    bank_name character varying,
    account_number character varying,
    amount character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    parent_id integer
);


ALTER TABLE public.dmt_transactions OWNER TO postgres;

--
-- Name: dmt_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dmt_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dmt_transactions_id_seq OWNER TO postgres;

--
-- Name: dmt_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dmt_transactions_id_seq OWNED BY public.dmt_transactions.id;


--
-- Name: dmts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dmts (
    id bigint NOT NULL,
    full_name character varying,
    account_number character varying,
    confirm_account_number character varying,
    phone_number character varying,
    bank_name character varying,
    branch_name character varying,
    ifsc_code character varying,
    sender_full_name character varying,
    sender_phone_number character varying,
    sender_aadhar_number character varying,
    sender_aadhar_otp_email character varying,
    beneficiaries_status boolean DEFAULT false,
    sender_name character varying,
    receiver_name character varying,
    sender_mobile_number character varying,
    receiver_mobile_number character varying,
    status character varying,
    aadhaar_number_otp character varying,
    aadhaar_number_otp_expriry character varying,
    datetime character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    amount numeric,
    parent_id integer
);


ALTER TABLE public.dmts OWNER TO postgres;

--
-- Name: dmts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dmts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dmts_id_seq OWNER TO postgres;

--
-- Name: dmts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dmts_id_seq OWNED BY public.dmts.id;


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
    updated_at timestamp(6) without time zone NOT NULL,
    reject_note character varying,
    account_number character varying
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
    card_number character varying,
    state character varying
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
-- Name: dmt_transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dmt_transactions ALTER COLUMN id SET DEFAULT nextval('public.dmt_transactions_id_seq'::regclass);


--
-- Name: dmts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dmts ALTER COLUMN id SET DEFAULT nextval('public.dmts_id_seq'::regclass);


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
19	TXN118699	57.0	Reason 1	\N	323243434343	Debit	\N	\N	success	104	127	8	2025-11-04 12:30:49.977588	2025-11-04 12:30:49.977588
20	TXN304864	57.0	Reason 1	\N	323243434343	Credit	\N	\N	success	104	127	8	2025-11-04 12:31:50.908514	2025-11-04 12:31:50.908514
21	TXN609580	43.0	Reason 1	\N	323243434343	Credit	\N	\N	success	104	127	8	2025-11-04 12:33:25.068221	2025-11-04 12:33:25.068221
22	TXN964340	11.0	Reason 2	\N	323243434343	Credit	\N	\N	success	104	127	8	2025-11-04 13:12:47.874701	2025-11-04 13:12:47.874701
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

COPY public.banks (id, bank_name, account_name, ifsc_code, account_number, account_type, first_name, last_name, initial_balance, created_at, updated_at, user_id) FROM stdin;
1	ds	\N	ds	ds		\N	\N	2.0	2025-09-01 11:11:59.373553	2025-10-27 09:29:28.312202	\N
2	Axis	\N	AXIS89SX	779776876567576576	savings	Siddharth Gautam		2.0	2025-09-01 11:13:25.981914	2025-10-27 09:29:28.31618	\N
4		\N					\N	2.0	2025-10-25 09:39:26.030131	2025-10-27 09:29:28.319257	\N
5	Axis	\N	\N	\N	\N	\N	\N	2.0	2025-10-27 09:28:07.220424	2025-10-27 09:29:28.322277	\N
6	Axis	\N	AXIS675	7668686667686	savings	Admin	\N	0.0	2025-11-03 09:13:34.404762	2025-11-03 09:13:34.404762	104
7	HDFC	\N	HDFC3232	9877979787897	savings	Admin	\N	0.0	2025-11-03 09:14:15.227678	2025-11-03 09:14:15.227678	104
8	HDFC	\N	HDFC68783	779776876567576576	savings	Axis	\N	0.0	2025-11-11 10:11:11.12425	2025-11-11 10:11:11.12425	224
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, title, image, status, service_id, created_at, updated_at) FROM stdin;
14	Utility Bills	\N	\N	7	2025-09-04 06:56:51.899042	2025-09-09 04:59:00.092412
15	Telecom & DTH	\N	\N	7	2025-09-04 06:57:05.940464	2025-09-09 04:59:10.380441
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
59	Apply Credit card	\N	\N	4	2025-09-24 04:55:48.226983	2025-09-24 04:55:48.226983
61	Personal Loan	\N	\N	4	2025-09-24 04:58:10.279369	2025-09-24 04:58:10.279369
62	Car Loan	\N	\N	4	2025-09-24 04:58:27.54729	2025-09-24 04:58:27.54729
63	Home Loan	\N	\N	4	2025-09-24 04:58:53.373839	2025-09-24 04:58:53.373839
64	Business Loan	\N	\N	4	2025-09-24 04:59:00.826174	2025-09-24 04:59:00.826174
65	Student Loan	\N	\N	4	2025-09-24 04:59:12.679623	2025-09-24 04:59:12.679623
60	Instant Loan	\N	\N	4	2025-09-24 04:56:07.398354	2025-09-27 07:42:04.179747
66	Gold Loan	\N	\N	4	2025-10-07 05:13:11.245842	2025-10-07 05:13:11.245842
67	Health Insurance	\N	\N	2	2025-10-14 06:20:50.371344	2025-10-14 06:20:50.371344
68	Life Insurance	\N	\N	2	2025-10-14 06:21:14.554288	2025-10-14 06:21:14.554288
69	Travel Insurance	\N	\N	2	2025-10-14 06:21:32.637494	2025-10-14 06:21:32.637494
70	Vehicle Insurance	\N	\N	2	2025-10-14 06:21:45.982361	2025-10-14 06:21:45.982361
71	Home Insurance	\N	\N	2	2025-10-14 06:22:07.02327	2025-10-14 06:22:07.02327
72	EV Insurance	\N	\N	2	2025-10-14 06:22:27.056291	2025-10-14 06:22:27.056291
73	Business Insurance	\N	\N	2	2025-10-14 06:22:39.708094	2025-10-14 06:22:39.708094
74	Shop Insurance	\N	\N	2	2025-10-14 06:23:03.010053	2025-10-14 06:23:03.010053
\.


--
-- Data for Name: commissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.commissions (id, commission_type, from_role, to_role, value, created_at, updated_at, service_product_item_id, scheme_id) FROM stdin;
78	\N	\N	\N	\N	2025-11-11 09:52:52.42544	2025-11-11 09:52:52.42544	4	\N
79	\N	\N	\N	\N	2025-11-11 09:53:03.197674	2025-11-11 09:53:03.197674	5	\N
80	\N	\N	\N	\N	2025-11-11 09:57:30.523378	2025-11-11 09:57:30.523378	6	\N
81	\N	\N	\N	\N	2025-11-11 09:57:38.585129	2025-11-11 09:57:38.585129	7	\N
82	\N	\N	\N	\N	2025-11-11 09:57:48.12418	2025-11-11 09:57:48.12418	8	\N
83	\N	\N	\N	\N	2025-11-11 09:58:25.649027	2025-11-11 09:58:25.649027	9	\N
84	\N	\N	\N	\N	2025-11-11 09:58:36.904418	2025-11-11 09:58:36.904418	10	\N
85	\N	\N	\N	\N	2025-11-11 09:58:46.619831	2025-11-11 09:58:46.619831	11	\N
86	\N	\N	\N	\N	2025-11-11 09:59:00.79822	2025-11-11 09:59:00.79822	12	\N
87	\N	\N	\N	\N	2025-11-11 10:00:00.812	2025-11-11 10:00:00.812	13	\N
88	\N	\N	\N	\N	2025-11-11 10:00:09.88427	2025-11-11 10:00:09.88427	14	\N
89	\N	\N	\N	\N	2025-11-11 10:01:22.638452	2025-11-11 10:01:22.638452	15	\N
90	\N	\N	\N	\N	2025-11-11 10:01:34.674459	2025-11-11 10:01:34.674459	16	\N
91	\N	\N	\N	\N	2025-11-11 10:02:12.126081	2025-11-11 10:02:12.126081	17	\N
92	\N	\N	\N	\N	2025-11-11 10:02:22.547607	2025-11-11 10:02:22.547607	18	\N
93	\N	\N	\N	\N	2025-11-11 10:02:34.547689	2025-11-11 10:02:34.547689	19	\N
77	commission	superadmin	retailer	0.0	2025-10-30 12:28:40.395734	2025-11-11 10:03:20.046123	3	16
\.


--
-- Data for Name: dmt_transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dmt_transactions (id, dmt_id, user_id, status, txn_id, sender_mobile_number, bank_name, account_number, amount, created_at, updated_at, parent_id) FROM stdin;
1	10	127	pending	TXND8DB68FC3CE2	\N	dfdd	56546	11.0	2025-11-07 06:50:13.492373	2025-11-07 06:50:13.492373	\N
3	12	127	pending	TXN8D68E8DE6A29	\N	SBI	888888888888888888	0.0	2025-11-07 07:37:49.744184	2025-11-07 07:37:49.744184	\N
4	13	127	pending	TXN22B68886DCE3	\N	SBI	888888888888888888	0.0	2025-11-07 07:40:45.143289	2025-11-07 07:40:45.143289	\N
5	14	127	pending	TXN7DFA43B721F3	\N	SBI	888888888888888888	0.0	2025-11-07 07:41:55.603703	2025-11-07 07:41:55.603703	\N
6	15	127	pending	TXN9A577EC4933F	\N	SBI	888888888888888888	0.0	2025-11-07 07:43:39.274105	2025-11-07 07:43:39.274105	\N
7	16	127	pending	TXN7E5987C637B2	\N	SBI	888888888888888888	0.0	2025-11-07 07:44:23.305692	2025-11-07 07:44:23.305692	\N
8	17	127	pending	TXN69108D9E8655	\N	SBI	888888888888888888	0.0	2025-11-07 08:55:41.158164	2025-11-07 08:55:41.158164	\N
9	18	127	pending	TXNE1311F50A7F9	\N	SBI	888888888888888888	0.0	2025-11-07 08:56:18.678573	2025-11-07 08:56:18.678573	\N
10	19	127	pending	TXNE281B477EE27	\N	SBI	888888888888888888	0.0	2025-11-07 09:08:05.167355	2025-11-07 09:08:05.167355	\N
11	20	127	pending	TXN81A19DB2B178	\N	HDFC	888888888888888888	0.0	2025-11-07 09:10:32.153398	2025-11-07 09:10:32.153398	\N
12	21	127	pending	TXN2214B443FEAA	\N	HDFC	888888888888888888	0.0	2025-11-07 09:12:01.60441	2025-11-07 09:12:01.60441	\N
13	22	127	pending	TXNB91300C9DBD9	\N	SBI	888888888888888888	0.0	2025-11-07 09:23:07.556528	2025-11-07 09:23:07.556528	\N
14	23	127	pending	TXNC657D2FFA2C3	\N	SBI	888888888888888888	0.0	2025-11-07 09:39:55.534433	2025-11-07 09:39:55.534433	\N
15	24	127	pending	TXND1A9F03B43BE	\N	SBI	888888888888888888	0.0	2025-11-07 09:41:07.967676	2025-11-07 09:41:07.967676	\N
16	25	127	pending	TXNAE5CEBF97A4B	\N	HDFC	888888888888888888	0.0	2025-11-07 09:46:33.75682	2025-11-07 09:46:33.75682	\N
17	26	127	pending	TXN1F405C8B7165	\N	SBI	888888888888888888	0.0	2025-11-07 09:58:02.676664	2025-11-07 09:58:02.676664	\N
18	27	127	pending	TXNBB496299D644	\N	HDFC	888888888888888888	0.0	2025-11-07 10:04:34.750666	2025-11-07 10:04:34.750666	\N
19	28	127	pending	TXN34B5CE3A0013	\N	SBI	888888888888888888	0.0	2025-11-07 10:25:11.870211	2025-11-07 10:25:11.870211	\N
20	29	127	pending	TXNF0059E2116AD	\N	SBI	888888888888888888	0.0	2025-11-07 10:36:57.031124	2025-11-07 10:36:57.031124	\N
21	30	127	pending	TXN91DC2FC812A8	\N	SBI	888888888888888888	0.0	2025-11-07 10:46:55.570794	2025-11-07 10:46:55.570794	\N
22	31	127	pending	TXNA13F4E77FF51	\N	SBI	888888888888888888	0.0	2025-11-07 10:50:43.322978	2025-11-07 10:50:43.322978	\N
23	32	127	pending	TXNB39D5B24C03F	\N	SBI	888888888888888888	0.0	2025-11-07 10:52:24.586771	2025-11-07 10:52:24.586771	\N
24	33	127	pending	TXNE11A9ED42550	\N	SBI	888888888888888888	0.0	2025-11-07 10:54:36.090094	2025-11-07 10:54:36.090094	\N
25	34	127	pending	TXNC60D4CEAFBB5	\N	SBI	888888888888888888	0.0	2025-11-07 11:01:19.204602	2025-11-07 11:01:19.204602	\N
26	35	127	pending	TXN2EFC8DFF1E3C	\N	SBI	888888888888888888	0.0	2025-11-07 11:02:47.176845	2025-11-07 11:02:47.176845	\N
27	36	127	pending	TXNB452050D0B86	\N	HDFC	888888888888888888	0.0	2025-11-07 11:04:06.034232	2025-11-07 11:04:06.034232	\N
28	37	127	pending	TXND6844EB21057	\N	SBI	888888888888888888	0.0	2025-11-07 11:07:41.687369	2025-11-07 11:07:41.687369	\N
29	38	127	pending	TXN8CD7C8308F3F	\N	SBI	888888888888888888	0.0	2025-11-07 11:09:42.520198	2025-11-07 11:09:42.520198	\N
30	39	127	pending	TXN9735EAF3CA15	\N	HDFC	888888888888888888	0.0	2025-11-07 11:20:00.307758	2025-11-07 11:20:00.307758	\N
32	41	127	pending	TXN4330E8DB3F72	\N	SBI	888888888888888888	0.0	2025-11-07 12:04:06.838024	2025-11-07 12:04:06.838024	\N
33	42	127	pending	TXNB2BF04BAF270	\N	HDFC	888888888888888888	0.0	2025-11-07 12:12:00.604836	2025-11-07 12:12:00.604836	\N
34	43	127	pending	TXN56D8743FAAD1	\N	SBI	888888888888888888	0.0	2025-11-07 12:12:57.894547	2025-11-07 12:12:57.894547	\N
35	44	127	pending	TXNA2392EA3C68B	\N	SBI	888888888888888888	0.0	2025-11-07 12:15:30.869981	2025-11-07 12:15:30.869981	\N
36	45	127	pending	TXNBABB853A6683	\N	SBI	888888888888888888	0.0	2025-11-07 12:16:54.754047	2025-11-07 12:16:54.754047	\N
37	46	127	pending	TXNF1A423638752	\N	HDFC	888888888888888888	0.0	2025-11-07 12:24:59.261587	2025-11-07 12:24:59.261587	\N
2	11	127	success	TXNA7A82F682574	\N	SBI	888888888888888888	0.0	2025-11-07 07:24:36.854689	2025-11-07 12:32:06.423652	\N
31	40	127	success	TXN16C1BA2F64D0	\N	HDFC	888888888888888888	0.0	2025-11-07 11:23:03.14967	2025-11-07 12:34:12.663181	\N
38	47	127	pending	TXN684C312A6216	\N	SBI	888888888888888888	0.0	2025-11-07 12:37:24.652073	2025-11-07 12:37:24.652073	\N
39	48	127	pending	TXNC81744CA1ED2	\N	HDFC	888888888888888888	0.0	2025-11-07 12:38:30.078294	2025-11-07 12:38:30.078294	\N
40	49	127	pending	TXN1E0D5143396E	\N	SBI	888888888888888888	0.0	2025-11-07 12:44:38.246631	2025-11-07 12:44:38.246631	\N
41	50	127	pending	TXN94A1AC045203	\N	HDFC	888888888888888888	0.0	2025-11-07 12:47:01.097557	2025-11-07 12:47:01.097557	\N
42	51	127	pending	TXN9E0F6338A2CA	\N	SBI	888888888888888888	0.0	2025-11-07 12:51:38.728422	2025-11-07 12:51:38.728422	\N
43	52	127	pending	TXN34E7C41862A9	\N	HDFC	888888888888888888	0.0	2025-11-07 13:06:14.527409	2025-11-07 13:06:14.527409	\N
44	53	127	pending	TXN2F8EFF83058C	\N	HDFC	888888888888888888	0.0	2025-11-07 13:16:01.008187	2025-11-07 13:16:01.008187	\N
45	54	127	pending	TXN1D49C1F6A689	\N	SBI	888888888888888888	0.0	2025-11-07 13:19:09.314104	2025-11-07 13:19:09.314104	\N
46	55	127	pending	TXN3752013C81FB	\N	SBI	888888888888888888	0.0	2025-11-07 13:21:41.42943	2025-11-07 13:21:41.42943	\N
47	56	127	pending	TXN49F41E5092F3	\N	SBI	888888888888888888	0.0	2025-11-07 13:25:11.40319	2025-11-07 13:25:11.40319	\N
48	57	127	pending	TXNA0BC6A389594	\N	SBI	888888888888888888	0.0	2025-11-07 13:28:52.175124	2025-11-07 13:28:52.175124	\N
49	58	127	pending	TXN6425A71089F9	\N	SBI	888888888888888888	0.0	2025-11-07 13:33:41.578388	2025-11-07 13:33:41.578388	\N
50	59	127	success	TXNF5679FF6D47D	\N	SBI	888888888888888888	0.0	2025-11-07 13:36:22.986435	2025-11-07 13:38:55.616185	\N
51	60	127	pending	TXND469C4BF9B64	\N	SBI	888888888888888888	0.0	2025-11-07 13:50:14.638844	2025-11-07 13:50:14.638844	\N
52	61	127	pending	TXNCA17B222B9AE	\N	Axis Bank	435345	0.0	2025-11-08 12:23:48.676727	2025-11-08 12:23:48.676727	\N
53	62	127	pending	TXN47FBFF491B78	\N	Axis Bank	1234	0.0	2025-11-08 12:28:07.847235	2025-11-08 12:28:07.847235	\N
54	63	127	pending	TXN6680E37937A9	\N	Axis Bank	435345	0.0	2025-11-08 12:32:12.946388	2025-11-08 12:32:12.946388	\N
55	64	127	pending	TXN0D7685E20D54	\N	Axis Bank	435345	0.0	2025-11-08 12:37:07.145451	2025-11-08 12:37:07.145451	\N
56	65	127	pending	TXNA23B871FD3FE	\N	Axis Bank	435345	0.0	2025-11-08 12:38:27.822189	2025-11-08 12:38:27.822189	\N
57	66	127	success	TXND17C162FA568	\N	HDFC	888888888888888888	0.0	2025-11-10 04:47:03.007195	2025-11-10 04:47:29.406718	\N
58	67	127	pending	TXNF61EA3F3EAB6	\N	ICICI	111111111111111111	0.0	2025-11-10 05:30:05.231651	2025-11-10 05:30:05.231651	\N
59	68	127	success	TXN7D05FA9AD3BA	\N	SBI	888888888888888888	0.0	2025-11-10 05:42:52.877118	2025-11-10 05:43:15.60139	\N
60	69	127	success	TXNAA2E8C25B9AD	6546456464	SBI	111111111111111111	0.0	2025-11-10 06:08:48.214112	2025-11-10 06:09:13.892317	\N
61	70	127	success	TXN4071DA375091	9999999999	SBI	888888888888888888	0.0	2025-11-10 06:17:43.261144	2025-11-10 06:18:03.185534	\N
62	71	127	success	TXN03A91BFF6B6C	9899898989	SBI	888888888888888888	0.0	2025-11-10 06:32:08.913648	2025-11-10 06:33:18.566774	\N
63	72	127	success	TXN9E462A00EAC7	8888888888	HDFC	888888888888888888	0.0	2025-11-10 06:45:15.700617	2025-11-10 06:45:29.839466	\N
64	73	127	success	TXN249881BA20E4	6546456464	HDFC	888888888888888888	0.0	2025-11-10 12:25:12.684308	2025-11-10 12:25:32.52182	\N
65	74	127	success	TXN60428E9E2547	6546456464	HDFC	888888888888888888	0.0	2025-11-10 13:09:13.203259	2025-11-10 13:09:31.309597	\N
66	75	127	pending	TXN6B49AC071CB5	\N	Axis Bank	1234567890	0.0	2025-11-12 06:28:38.405491	2025-11-12 06:28:38.405491	\N
67	76	127	success	TXN8ED43ADAC1D1	6767676767	Axis Bank	1234567890	0.0	2025-11-12 06:33:04.87916	2025-11-12 06:33:22.039558	\N
68	77	127	success	TXN13CC4C1E0EEE	6546456464	Axis Bank	1234567890	0.0	2025-11-12 07:17:35.68713	2025-11-12 07:24:44.89386	\N
69	78	127	success	TXN5EE10020F36C	8787979798	HDFC	1234567890	0.0	2025-11-12 07:37:13.185902	2025-11-12 07:37:29.059088	\N
70	79	127	success	TXN8A4CDFEFB8D0	6546456464	HDFC	111111111111111111	0.0	2025-11-12 07:47:20.72741	2025-11-12 07:47:30.100486	\N
71	80	127	pending	TXN6C1E13046290	\N	reena	435345	0.0	2025-11-12 09:25:15.211456	2025-11-12 09:25:15.211456	\N
72	81	127	pending	TXN246C6AD679EB	\N	Axis Bank	111	0.0	2025-11-12 09:30:13.674173	2025-11-12 09:30:13.674173	\N
73	82	127	success	TXN5226914257F1	9878979898	Axis Bank	111111111111111111	0.0	2025-11-12 10:10:32.989186	2025-11-12 10:10:43.059792	\N
74	83	127	success	TXN46EE67BB44D1	6786786867	Axis Bank	1234567890	0.0	2025-11-12 10:56:05.084417	2025-11-12 10:56:24.911607	\N
75	84	127	success	TXN0B5936F9093C	6546456464	reena	4353456565556556	0.0	2025-11-12 11:03:40.869972	2025-11-12 11:03:53.529421	\N
76	85	127	pending	TXN3D88AB61E93F	5675675676	Axis Bank	1234567890	0.0	2025-11-12 11:07:12.485148	2025-11-12 11:07:12.485148	\N
77	86	127	success	TXNE5B03129DC64	6546456464	HDFC	888888888888888888	0.0	2025-11-12 11:46:57.385482	2025-11-12 11:47:20.527841	\N
78	87	127	success	TXN33EC62CD94BA	7987989787998	test bank	8778798777898	100.0	2025-11-12 11:50:46.593259	2025-11-12 11:51:21.834536	\N
79	88	127	success	TXNAA7D64171839	7987989787998	test bank	8778798777898	100.0	2025-11-12 11:51:48.452157	2025-11-12 11:52:00.322431	\N
80	89	127	success	TXN8F48F974DE42	6546456464	Axis Bank	1234567890	0.0	2025-11-12 12:18:58.566867	2025-11-12 12:19:25.96815	\N
81	90	127	success	TXN272179572721	7987989787998	test bank	8778798777898	100.0	2025-11-12 12:20:15.337636	2025-11-12 12:20:42.70119	\N
82	91	127	pending	TXNABD5B91F2E74	7987989787998	test bank	8778798777898	0.0	2025-11-12 12:23:41.660764	2025-11-12 12:23:41.660764	\N
83	92	127	success	TXNB6404548D483	7686867868	Axis Bank	1234567890	0.0	2025-11-12 12:33:20.3975	2025-11-12 12:33:37.185337	\N
84	93	127	pending	TXN7AFEA1C84BA6	6546456464	HDFC	888888888888888888	0.0	2025-11-12 12:36:39.256275	2025-11-12 12:36:39.256275	\N
85	94	127	success	TXNB85957962800	8789345345	Axis Bank	1234567890	0.0	2025-11-12 12:48:35.155056	2025-11-12 12:49:44.663805	\N
86	95	127	pending	TXNC17D03D8596D	5675675676	AXIS	888888888888888888	0.0	2025-11-12 13:03:17.561006	2025-11-12 13:03:17.561006	\N
87	96	127	success	TXN5993047919DD	8789345345	Axis Bank	1234567890	0.0	2025-11-12 13:07:50.565259	2025-11-12 13:19:51.183283	\N
88	97	127	success	TXNC04ADA37CC96	8789345345	AXIS	1234567890	0.0	2025-11-12 13:29:49.373679	2025-11-12 13:32:17.89696	\N
\.


--
-- Data for Name: dmts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dmts (id, full_name, account_number, confirm_account_number, phone_number, bank_name, branch_name, ifsc_code, sender_full_name, sender_phone_number, sender_aadhar_number, sender_aadhar_otp_email, beneficiaries_status, sender_name, receiver_name, sender_mobile_number, receiver_mobile_number, status, aadhaar_number_otp, aadhaar_number_otp_expriry, datetime, created_at, updated_at, amount, parent_id) FROM stdin;
1	\N	56546	56546	\N	dfdd	\N	fsdfs	\N	\N	\N	\N	f	\N	ghf	\N	fdffd	pending	\N	\N	2025-11-05 17:49:06 +0530	2025-11-05 12:19:06.643503	2025-11-05 12:19:06.643503	\N	\N
2	\N	123	123	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	www	\N	565	pending	\N	\N	2025-11-05 18:07:16 +0530	2025-11-05 12:37:16.110234	2025-11-05 12:37:16.110234	\N	\N
3	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	9193050964	pending	\N	\N	2025-11-05 18:32:18 +0530	2025-11-05 13:02:18.031696	2025-11-05 13:02:18.031696	\N	\N
4	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	9193050964	pending	\N	\N	2025-11-05 18:36:43 +0530	2025-11-05 13:06:43.476695	2025-11-05 13:06:43.476695	\N	\N
5	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	9193050964	pending	\N	\N	2025-11-05 18:38:13 +0530	2025-11-05 13:08:13.463756	2025-11-05 13:08:13.463756	\N	\N
6	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	fdgdfgfdgddfg	\N	9193050964	pending	\N	\N	2025-11-05 18:45:31 +0530	2025-11-05 13:15:31.127412	2025-11-05 13:15:31.127412	\N	\N
7	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	fdgdfgfdgddfg	\N	9193050964	pending	\N	\N	2025-11-05 18:52:15 +0530	2025-11-05 13:22:15.400256	2025-11-05 13:22:15.400256	\N	\N
8	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	9193050964	pending	\N	\N	2025-11-05 19:02:34 +0530	2025-11-05 13:32:34.855061	2025-11-05 13:32:34.855061	\N	\N
9	\N	888888888888888888	888888888888888888	\N	HDFC	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	9193050964	pending	\N	\N	2025-11-06 14:22:18 +0530	2025-11-06 08:52:18.779869	2025-11-06 08:52:18.779869	\N	\N
10	\N	56546	56546	\N	dfdd	\N	fsdfs	\N	\N	\N	\N	f	\N	ghf	\N	fdffd	pending	\N	\N	2025-11-07 12:20:13 +0530	2025-11-07 06:50:13.457471	2025-11-07 06:50:13.457471	\N	\N
12	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	9193050964	pending	\N	\N	2025-11-07 13:07:49 +0530	2025-11-07 07:37:49.711308	2025-11-07 07:37:49.711308	\N	\N
13	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	9193050964	pending	\N	\N	2025-11-07 13:10:45 +0530	2025-11-07 07:40:45.132367	2025-11-07 07:40:45.132367	\N	\N
14	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	8979707098	pending	\N	\N	2025-11-07 13:11:55 +0530	2025-11-07 07:41:55.594371	2025-11-07 07:41:55.594371	\N	\N
15	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	8979707098	pending	\N	\N	2025-11-07 13:13:39 +0530	2025-11-07 07:43:39.264105	2025-11-07 07:43:39.264105	\N	\N
16	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	8979707098	pending	\N	\N	2025-11-07 13:14:23 +0530	2025-11-07 07:44:23.295755	2025-11-07 07:44:23.295755	\N	\N
17	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	6786868678	pending	\N	\N	2025-11-07 14:25:41 +0530	2025-11-07 08:55:41.148954	2025-11-07 08:55:41.148954	\N	\N
18	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	6786868678	pending	\N	\N	2025-11-07 14:26:18 +0530	2025-11-07 08:56:18.669977	2025-11-07 08:56:18.669977	\N	\N
19	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	6786868678	pending	\N	\N	2025-11-07 14:38:05 +0530	2025-11-07 09:08:05.158566	2025-11-07 09:08:05.158566	\N	\N
20	\N	888888888888888888	888888888888888888	\N	HDFC	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	9879879868	pending	\N	\N	2025-11-07 14:40:32 +0530	2025-11-07 09:10:32.143816	2025-11-07 09:10:32.143816	\N	\N
21	\N	888888888888888888	888888888888888888	\N	HDFC	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	9879879868	pending	\N	\N	2025-11-07 14:42:01 +0530	2025-11-07 09:12:01.594539	2025-11-07 09:12:01.594539	\N	\N
11	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	9193050964	pending	\N	\N	2025-11-07 12:54:36 +0530	2025-11-07 07:24:36.819309	2025-11-07 09:19:30.886887	11.0	\N
22	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	9193050964	pending	\N	\N	2025-11-07 14:53:07 +0530	2025-11-07 09:23:07.546966	2025-11-07 09:23:07.546966	\N	\N
23	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	dfdg	\N	6786868678	pending	\N	\N	2025-11-07 15:09:55 +0530	2025-11-07 09:39:55.524232	2025-11-07 09:39:55.524232	\N	\N
24	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	dfvgdfgfbg	\N	9879879868	pending	\N	\N	2025-11-07 15:11:07 +0530	2025-11-07 09:41:07.95885	2025-11-07 09:41:07.95885	\N	\N
25	\N	888888888888888888	888888888888888888	\N	HDFC	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	9879879868	pending	\N	\N	2025-11-07 15:16:33 +0530	2025-11-07 09:46:33.748787	2025-11-07 09:46:33.748787	\N	\N
26	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	9879879868	pending	\N	\N	2025-11-07 15:28:02 +0530	2025-11-07 09:58:02.667062	2025-11-07 09:58:02.667062	\N	\N
27	\N	888888888888888888	888888888888888888	\N	HDFC	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	ewrwerwe	\N	9879879868	pending	\N	\N	2025-11-07 15:34:34 +0530	2025-11-07 10:04:34.742028	2025-11-07 10:04:34.742028	\N	\N
28	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	dfdg	\N	6575757567	pending	\N	\N	2025-11-07 15:55:11 +0530	2025-11-07 10:25:11.860713	2025-11-07 10:25:11.860713	\N	\N
29	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	9879879868	pending	\N	\N	2025-11-07 16:06:57 +0530	2025-11-07 10:36:57.021019	2025-11-07 10:36:57.021019	\N	\N
30	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	dfgfdgdfg	\N	6757567567	pending	\N	\N	2025-11-07 16:16:55 +0530	2025-11-07 10:46:55.559569	2025-11-07 10:46:55.559569	\N	\N
31	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	9879879868	pending	\N	\N	2025-11-07 16:20:43 +0530	2025-11-07 10:50:43.314387	2025-11-07 10:50:43.314387	\N	\N
32	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	9879879868	pending	\N	\N	2025-11-07 16:22:24 +0530	2025-11-07 10:52:24.577592	2025-11-07 10:52:24.577592	\N	\N
33	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	9879879868	pending	\N	\N	2025-11-07 16:24:36 +0530	2025-11-07 10:54:36.081059	2025-11-07 10:54:36.081059	\N	\N
34	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	sdfsd	\N	9878998798	pending	\N	\N	2025-11-07 16:31:19 +0530	2025-11-07 11:01:19.194642	2025-11-07 11:01:19.194642	\N	\N
35	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	9879879868	pending	\N	\N	2025-11-07 16:32:47 +0530	2025-11-07 11:02:47.166988	2025-11-07 11:02:47.166988	\N	\N
36	\N	888888888888888888	888888888888888888	\N	HDFC	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	ewrwerwe	\N	9879879868	pending	\N	\N	2025-11-07 16:34:06 +0530	2025-11-07 11:04:06.025351	2025-11-07 11:04:06.025351	\N	\N
37	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	6786868678	pending	\N	\N	2025-11-07 16:37:41 +0530	2025-11-07 11:07:41.678988	2025-11-07 11:07:41.678988	\N	\N
38	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	6786868678	pending	\N	\N	2025-11-07 16:39:42 +0530	2025-11-07 11:09:42.510402	2025-11-07 11:09:42.510402	\N	\N
39	\N	888888888888888888	888888888888888888	\N	HDFC	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	6786868678	pending	\N	\N	2025-11-07 16:50:00 +0530	2025-11-07 11:20:00.296388	2025-11-07 11:20:00.296388	\N	\N
41	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	9879879868	pending	\N	\N	2025-11-07 17:34:06 +0530	2025-11-07 12:04:06.827724	2025-11-07 12:04:11.298566	12.0	\N
40	\N	888888888888888888	888888888888888888	\N	HDFC	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	ddf	\N	8979707098	pending	\N	\N	2025-11-07 16:53:03 +0530	2025-11-07 11:23:03.140831	2025-11-07 11:37:15.148299	11.0	\N
42	\N	888888888888888888	888888888888888888	\N	HDFC	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	9879879868	pending	\N	\N	2025-11-07 17:42:00 +0530	2025-11-07 12:12:00.596059	2025-11-07 12:12:06.343351	11.0	\N
43	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	ewrwerwe	\N	9879879868	pending	\N	\N	2025-11-07 17:42:57 +0530	2025-11-07 12:12:57.885146	2025-11-07 12:13:02.772925	11.0	\N
44	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	9879879868	pending	\N	\N	2025-11-07 17:45:30 +0530	2025-11-07 12:15:30.86136	2025-11-07 12:15:35.634057	11.0	\N
45	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	9879879868	pending	\N	\N	2025-11-07 17:46:54 +0530	2025-11-07 12:16:54.744507	2025-11-07 12:16:58.296695	1.0	\N
46	\N	888888888888888888	888888888888888888	\N	HDFC	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	8979707098	pending	\N	\N	2025-11-07 17:54:59 +0530	2025-11-07 12:24:59.251052	2025-11-07 12:25:11.660867	11.0	\N
47	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	9879879868	pending	\N	\N	2025-11-07 18:07:24 +0530	2025-11-07 12:37:24.643225	2025-11-07 12:37:24.643225	\N	\N
48	\N	888888888888888888	888888888888888888	\N	HDFC	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	8979707098	pending	\N	\N	2025-11-07 18:08:30 +0530	2025-11-07 12:38:30.069541	2025-11-07 12:38:40.186079	11.0	\N
49	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	9879879868	pending	\N	\N	2025-11-07 18:14:38 +0530	2025-11-07 12:44:38.236777	2025-11-07 12:44:50.276861	34.0	\N
50	\N	888888888888888888	888888888888888888	\N	HDFC	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	8979707098	pending	\N	\N	2025-11-07 18:17:01 +0530	2025-11-07 12:47:01.087342	2025-11-07 12:47:07.308749	13.0	\N
51	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	9879879868	pending	\N	\N	2025-11-07 18:21:38 +0530	2025-11-07 12:51:38.71886	2025-11-07 12:51:43.663211	11111.0	\N
52	\N	888888888888888888	888888888888888888	\N	HDFC	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	8979707098	pending	\N	\N	2025-11-07 18:36:14 +0530	2025-11-07 13:06:14.517733	2025-11-07 13:06:31.763019	11.0	\N
53	\N	888888888888888888	888888888888888888	\N	HDFC	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	9879879868	pending	\N	\N	2025-11-07 18:46:00 +0530	2025-11-07 13:16:00.997388	2025-11-07 13:16:18.585221	111.0	\N
54	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	9879879868	pending	\N	\N	2025-11-07 18:49:09 +0530	2025-11-07 13:19:09.304579	2025-11-07 13:19:15.132093	1234.0	\N
55	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	9879879868	pending	\N	\N	2025-11-07 18:51:41 +0530	2025-11-07 13:21:41.419845	2025-11-07 13:21:46.071208	123.0	\N
56	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	www	\N	9193050964	pending	\N	\N	2025-11-07 18:55:11 +0530	2025-11-07 13:25:11.393307	2025-11-07 13:25:20.205505	1234.0	\N
57	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	hjkh	\N	8979707098	pending	\N	\N	2025-11-07 18:58:52 +0530	2025-11-07 13:28:52.165197	2025-11-07 13:29:02.047637	11.0	\N
58	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	9879879868	pending	\N	\N	2025-11-07 19:03:41 +0530	2025-11-07 13:33:41.568805	2025-11-07 13:33:54.101465	12.0	\N
59	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	9879879868	pending	\N	\N	2025-11-07 19:06:22 +0530	2025-11-07 13:36:22.976931	2025-11-07 13:36:31.252718	11.0	\N
60	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	9879879868	pending	\N	\N	2025-11-07 19:20:14 +0530	2025-11-07 13:50:14.626994	2025-11-07 13:50:22.009691	11.0	\N
61	\N	435345	435345	\N	Axis Bank	\N	UTIB0001234	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	7658767578	pending	\N	\N	2025-11-08 17:53:48 +0530	2025-11-08 12:23:48.650497	2025-11-08 12:23:48.650497	\N	104
62	\N	1234	1234	\N	Axis Bank	\N	UTIB0001234	\N	\N	\N	\N	t	\N	Mohammad Aamir	\N	9305096443	pending	\N	\N	2025-11-08 17:58:07 +0530	2025-11-08 12:28:07.802769	2025-11-08 12:28:07.802769	\N	104
63	\N	435345	435345	\N	Axis Bank	\N	UTIB0001234	\N	\N	\N	\N	t	\N	Mohammad Aamir	\N	7658767578	pending	\N	\N	2025-11-08 18:02:12 +0530	2025-11-08 12:32:12.937964	2025-11-08 12:32:12.937964	\N	104
64	\N	435345	435345	\N	Axis Bank	\N	UTIB0001234	\N	\N	\N	\N	t	\N	Mohammad Aamir	\N	9305096443	pending	\N	\N	2025-11-08 18:07:07 +0530	2025-11-08 12:37:07.136773	2025-11-08 12:37:07.136773	\N	104
65	\N	435345	435345	\N	Axis Bank	\N	UTIB0001234	\N	\N	\N	\N	t	\N	Mohammad Aamir	\N	9305096443	pending	\N	\N	2025-11-08 18:08:27 +0530	2025-11-08 12:38:27.811146	2025-11-08 12:38:27.811146	\N	104
66	\N	888888888888888888	888888888888888888	\N	HDFC	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	ewrwerwe	\N	6786868678	pending	\N	\N	2025-11-10 10:17:02 +0530	2025-11-10 04:47:02.981187	2025-11-10 04:47:14.885181	77.0	104
67	\N	111111111111111111	111111111111111111	\N	ICICI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	9999999999	pending	\N	\N	2025-11-10 11:00:05 +0530	2025-11-10 05:30:05.221195	2025-11-10 05:31:30.822459	112.0	104
68	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	\N	8979707098	pending	\N	\N	2025-11-10 11:12:52 +0530	2025-11-10 05:42:52.865485	2025-11-10 05:42:57.094726	12.0	104
69	\N	111111111111111111	111111111111111111	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	Mohammad Aamir	6546456464	8979707098	pending	\N	\N	2025-11-10 11:38:48 +0530	2025-11-10 06:08:48.203633	2025-11-10 06:09:05.329627	11.0	104
70	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	\N	\N	\N	\N	f	\N	sid yarr	9999999999	8979707098	pending	\N	\N	2025-11-10 11:47:43 +0530	2025-11-10 06:17:43.236875	2025-11-10 06:17:54.030927	111.0	104
71	\N	888888888888888888	888888888888888888	\N	SBI	\N	BARB0PANDEY	mani	\N	\N	\N	f	\N	Mohammad Aamir	9899898989	7777777777	pending	\N	\N	2025-11-10 12:02:08 +0530	2025-11-10 06:32:08.900406	2025-11-10 06:33:00.617471	44.0	104
72	\N	888888888888888888	888888888888888888	\N	HDFC	\N	BARB0PANDEY	prit	\N	\N	\N	f	\N	sidd	8888888888	9999999999	pending	\N	\N	2025-11-10 12:15:15 +0530	2025-11-10 06:45:15.688179	2025-11-10 06:45:19.316523	11.0	104
73	\N	888888888888888888	888888888888888888	\N	HDFC	\N	BARB0PANDEY	wewe	\N	\N	\N	f	\N	Mohammad Aamir	6546456464	9879879868	pending	\N	\N	2025-11-10 17:55:12 +0530	2025-11-10 12:25:12.649258	2025-11-10 12:25:19.633375	78.0	104
74	\N	888888888888888888	888888888888888888	\N	HDFC	\N	BARB0PANDEY	aamir	\N	\N	\N	f	\N	Mohammad Aamir	6546456464	9999999999	pending	\N	\N	2025-11-10 18:39:13 +0530	2025-11-10 13:09:13.172733	2025-11-10 13:09:19.192614	12.0	104
75	\N	1234567890	1234567890	\N	Axis Bank	\N	UTIB0001234	\N	\N	\N	\N	t	\N	sidwa	\N	7778887777	pending	\N	\N	2025-11-12 11:58:38 +0530	2025-11-12 06:28:38.3932	2025-11-12 06:28:38.3932	\N	104
76	\N	1234567890	1234567890	\N	Axis Bank	\N	UTIB0001234	sidwa	\N	\N	\N	f	\N	sidwa	6767676767	7778887777	pending	\N	\N	2025-11-12 12:03:04 +0530	2025-11-12 06:33:04.869138	2025-11-12 06:33:10.05976	22.0	104
77	\N	1234567890	1234567890	\N	Axis Bank	\N	UTIB0001234	aamir	\N	\N	\N	f	\N	sidwa	6546456464	7778887777	pending	\N	\N	2025-11-12 12:47:35 +0530	2025-11-12 07:17:35.655491	2025-11-12 07:20:37.947597	11.0	104
78	\N	1234567890	1234567890	\N	HDFC	\N	UTIB0001234	sjsjd	\N	\N	\N	f	\N	sidwa	8787979798	7778887777	pending	\N	\N	2025-11-12 13:07:13 +0530	2025-11-12 07:37:13.148172	2025-11-12 07:37:22.006413	12.0	104
79	\N	111111111111111111	111111111111111111	\N	HDFC	\N	BARB0PANDEY	dddd	\N	\N	\N	f	\N	Mohammad Aamir	6546456464	9193050964	pending	\N	\N	2025-11-12 13:17:20 +0530	2025-11-12 07:47:20.716546	2025-11-12 07:47:24.24454	12.0	104
80	\N	435345	435345	\N	reena	\N	UTIB0001234	\N	\N	\N	\N	t	\N	Akhggjh	\N	7658767578	pending	\N	\N	2025-11-12 14:55:15 +0530	2025-11-12 09:25:15.185577	2025-11-12 09:25:15.185577	\N	104
81	\N	111	111	\N	Axis Bank	\N	UTIB0001234	\N	\N	\N	\N	t	\N	Mohammad Aamir	\N	9878796898	pending	\N	\N	2025-11-12 15:00:13 +0530	2025-11-12 09:30:13.664873	2025-11-12 09:30:13.664873	\N	104
82	\N	111111111111111111	111111111111111111	\N	Axis Bank	\N	UTIB0001234	Manikant	\N	\N	\N	f	\N	Mohammad Aamir	9878979898	9878796898	pending	\N	\N	2025-11-12 15:40:32 +0530	2025-11-12 10:10:32.980818	2025-11-12 10:10:36.730942	11.0	104
83	\N	1234567890	1234567890	\N	Axis Bank	\N	UTIB0001234	ff	\N	\N	\N	f	\N	sidwa	6786786867	7778887777	pending	\N	\N	2025-11-12 16:26:05 +0530	2025-11-12 10:56:05.071497	2025-11-12 10:56:12.665109	11.0	104
84	\N	4353456565556556	4353456565556556	\N	reena	\N	UTIB0001234	aamir	\N	\N	\N	f	\N	Akhggjh	6546456464	7658767578	pending	\N	\N	2025-11-12 16:33:40 +0530	2025-11-12 11:03:40.860439	2025-11-12 11:03:46.449701	21.0	104
85	\N	1234567890	1234567890	\N	Axis Bank	\N	UTIB0001234	aamir	\N	\N	\N	f	\N	sidwa	5675675676	7778887777	pending	\N	\N	2025-11-12 16:37:12 +0530	2025-11-12 11:07:12.449702	2025-11-12 11:07:16.761036	21.0	104
86	\N	888888888888888888	888888888888888888	\N	HDFC	\N	BARB0PANDEY	aamir	\N	\N	\N	f	\N	Mohammad Aamir	6546456464	9999999999	pending	\N	\N	2025-11-12 17:16:57 +0530	2025-11-12 11:46:57.353223	2025-11-12 11:47:07.673115	65.0	104
87	\N	8778798777898	8778798777898	\N	test bank	\N	bamnds787	kill name	\N	\N	\N	t	\N	sid test	7987989787998	7676767767667	pending	\N	\N	2025-11-12 17:20:46 +0530	2025-11-12 11:50:46.550803	2025-11-12 11:50:46.550803	100.0	104
88	\N	8778798777898	8778798777898	\N	test bank	\N	bamnds787	kill name	\N	\N	\N	t	\N	sid test	7987989787998	7676767767667	pending	\N	\N	2025-11-12 17:21:48 +0530	2025-11-12 11:51:48.442027	2025-11-12 11:51:48.442027	100.0	104
89	\N	1234567890	1234567890	\N	Axis Bank	\N	UTIB0001234	aamir	\N	\N	\N	f	\N	sidwa	6546456464	7778887777	pending	\N	\N	2025-11-12 17:48:58 +0530	2025-11-12 12:18:58.555757	2025-11-12 12:19:09.873735	65.0	104
90	\N	8778798777898	8778798777898	\N	test bank	\N	bamnds787	kill name	\N	\N	\N	t	\N	sid test	7987989787998	7676767767667	pending	\N	\N	2025-11-12 17:50:15 +0530	2025-11-12 12:20:15.32774	2025-11-12 12:20:15.32774	100.0	104
91	\N	8778798777898	8778798777898	\N	test bank	\N	bamnds787	kill name	\N	\N	\N	t	\N	sid test	7987989787998	7676767767667	pending	\N	\N	2025-11-12 17:53:41 +0530	2025-11-12 12:23:41.651615	2025-11-12 12:23:41.651615	\N	104
92	\N	1234567890	1234567890	\N	Axis Bank	\N	UTIB0001234	fdssd	\N	\N	\N	f	\N	sidwa	7686867868	7778887777	pending	\N	\N	2025-11-12 18:03:20 +0530	2025-11-12 12:33:20.368126	2025-11-12 12:33:27.691063	12.0	104
93	\N	888888888888888888	888888888888888888	\N	HDFC	\N	BARB0PANDEY	aamir	\N	\N	\N	f	\N	Mohammad Aamir	6546456464	9879879868	pending	\N	\N	2025-11-12 18:06:39 +0530	2025-11-12 12:36:39.246076	2025-11-12 12:37:48.410197	11.0	104
94	\N	1234567890	1234567890	\N	Axis Bank	\N	UTIB0001234	897897897897998	\N	\N	\N	f	\N	sidwa	8789345345	7778887777	pending	\N	\N	2025-11-12 18:18:35 +0530	2025-11-12 12:48:35.122625	2025-11-12 12:49:33.189117	11.0	104
95	\N	888888888888888888	888888888888888888	\N	AXIS	\N	BARB0PANDEY	aamir	\N	\N	\N	f	\N	Mohammad Aamir	5675675676	9879879868	pending	\N	\N	2025-11-12 18:33:17 +0530	2025-11-12 13:03:17.552663	2025-11-12 13:03:17.552663	\N	104
96	\N	1234567890	1234567890	\N	Axis Bank	\N	UTIB0001234	aamir	\N	\N	\N	f	\N	sidwa	8789345345	7778887777	pending	\N	\N	2025-11-12 18:37:50 +0530	2025-11-12 13:07:50.556289	2025-11-12 13:12:56.139595	500.0	104
97	\N	1234567890	1234567890	\N	AXIS	\N	UTIB0001234	aamir	\N	\N	\N	f	\N	sidwa	8789345345	7778887777	pending	\N	\N	2025-11-12 18:59:49 +0530	2025-11-12 13:29:49.36525	2025-11-12 13:31:41.48695	44.0	104
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
12	sidwa	sidwa	sidwa@gmail.com	8788676867	986876969868	\N	f	5	2025-10-29 05:23:21.067178	2025-10-29 05:23:21.067178
13	ss	dd	ss@d	9878968986	564564363464	\N	f	5	2025-10-29 05:49:57.022257	2025-10-29 05:49:57.022257
14	kjdfvkjds	dskjf	dsmf@dfmn	0875786585	567576845897	\N	f	5	2025-10-29 05:51:00.987861	2025-10-29 05:51:00.987861
15	Mohammad	Aamir	j@hj	9698698678	879878787897	\N	f	5	2025-10-29 05:57:26.169907	2025-10-29 05:57:26.169907
16	oiioh	kjhj	jkh@hbjk	8689689679	897878978789	\N	f	6	2025-10-29 05:58:04.714396	2025-10-29 05:58:04.714396
17	sid	singh	sid@gmail.com	8568756784	856785864587	\N	t	5	2025-10-29 09:40:47.593145	2025-10-29 09:52:51.424466
18	Mohammad	Aamir	uyu@gmail.com	8979867676	879897987878	\N	f	5	2025-10-29 13:42:49.435486	2025-10-29 13:42:49.435486
19	aajhjg	bgg	ddd@vg	4655675747	576757567567	\N	f	5	2025-10-30 11:53:55.569888	2025-10-30 11:53:55.569888
\.


--
-- Data for Name: fund_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fund_requests (id, user_id, requested_by, amount, status, approved_by, approved_at, remark, image, transaction_type, mode, bank_reference_no, payment_mode, deposit_bank, your_bank, created_at, updated_at, reject_note, account_number) FROM stdin;
11	127	104	10.0	\N	\N	\N	test	\N	UPI	credit	879879ds787878	\N	Axis	HDFC	2025-09-06 10:53:22.238745	2025-09-06 10:53:22.238745	\N	\N
12	127	104	10.0	\N	\N	\N	test	\N	UPI	credit	879879ds787878	\N	Axis	HDFC	2025-09-06 10:58:12.306457	2025-09-06 10:58:12.306457	\N	\N
13	127	104	10.0	\N	\N	\N	test	\N	UPI	credit	879879ds787878	\N	Axis	HDFC	2025-09-06 10:58:36.043983	2025-09-06 10:58:36.043983	\N	\N
15	127	104	10.0	\N	\N	\N	bhej do bhai	null	CashInBank	credit	208987	\N	SBI	HDFC	2025-09-06 11:01:16.175689	2025-09-06 11:01:16.175689	\N	\N
16	127	104	20.0	\N	\N	\N	de do na	null	NEFT	credit	43543	\N	SBI	SBI	2025-09-06 11:08:17.288251	2025-09-06 11:08:17.288251	\N	\N
17	127	104	5.0	\N	\N	\N	dfgd	null	UPI	credit	454353435	\N	HDFC	ICICI	2025-09-06 11:10:11.793622	2025-09-06 11:10:11.793622	\N	\N
18	127	104	20.0	\N	\N	\N	de do mera paisa	null	Cheque	credit	86876876	\N	SBI	HDFC	2025-09-06 11:15:13.014605	2025-09-06 11:15:13.014605	\N	\N
19	127	104	40.0	\N	\N	\N		null	CashInBank	credit	45	\N	SBI	ICICI	2025-09-06 11:20:57.526698	2025-09-06 11:20:57.526698	\N	\N
20	127	104	400.0	\N	\N	\N		null	CashInBank	credit	86876876	\N	HDFC	HDFC	2025-09-06 11:22:08.43994	2025-09-06 11:22:08.43994	\N	\N
21	127	104	600.0	\N	\N	\N		null	Netbanking	credit	86876876	\N	SBI	SBI	2025-09-06 11:27:09.982909	2025-09-06 11:27:09.982909	\N	\N
22	127	104	1.0	\N	\N	\N		null	Cash	credit	2332	\N	HDFC	SBI	2025-09-06 11:32:10.205525	2025-09-06 11:32:10.205525	\N	\N
23	127	104	500.0	\N	\N	\N		null	Cheque	credit	897987	\N	HDFC	HDFC	2025-09-06 11:37:10.679613	2025-09-06 11:37:10.679613	\N	\N
24	127	104	500.0	\N	\N	\N		null	Cheque	credit	897987	\N	HDFC	HDFC	2025-09-06 11:37:53.467712	2025-09-06 11:37:53.467712	\N	\N
25	127	104	500.0	\N	\N	\N		null	Cheque	credit	897987	\N	HDFC	HDFC	2025-09-06 11:38:34.42233	2025-09-06 11:38:34.42233	\N	\N
26	127	104	200.0	\N	\N	\N		null	CashInBank	credit	87	\N	HDFC	AXIS	2025-09-06 11:39:25.212643	2025-09-06 11:39:25.212643	\N	\N
27	127	104	76.0	\N	\N	\N		null	NEFT	credit	769	\N	HDFC	ICICI	2025-09-06 11:57:13.457331	2025-09-06 11:57:13.457331	\N	\N
28	127	104	300.0	\N	\N	\N		null	CashInBank	credit	34534	\N	HDFC	HDFC	2025-09-06 12:03:54.839562	2025-09-06 12:03:54.839562	\N	\N
29	127	104	2.0	\N	\N	\N		null	Netbanking	credit	86876876	\N	HDFC	ICICI	2025-09-06 12:09:59.78103	2025-09-06 12:09:59.78103	\N	\N
30	127	104	1.0	\N	\N	\N		null	CashInBank	credit	86876876	\N	HDFC	SBI	2025-09-06 12:14:14.926249	2025-09-06 12:14:14.926249	\N	\N
32	127	104	31.0	\N	\N	\N	test	null	UPI	credit	ghhg566556	\N	HDFC	HDFC	2025-09-06 12:20:08.384143	2025-09-06 12:20:08.384143	\N	\N
33	127	104	35.0	\N	\N	\N		null	Cheque	credit	89698	\N	HDFC	SBI	2025-09-06 12:25:32.369262	2025-09-06 12:25:32.369262	\N	\N
34	127	104	70.0	\N	\N	\N		null	UPI	credit	233	\N	SBI	ICICI	2025-09-06 12:26:55.606828	2025-09-06 12:26:55.606828	\N	\N
35	127	104	7.0	\N	\N	\N		null	UPI	credit	233	\N	SBI	ICICI	2025-09-06 12:28:15.177185	2025-09-06 12:28:15.177185	\N	\N
39	127	104	93.0	\N	\N	\N		null	NEFT	credit	1	\N	SBI	SBI	2025-09-06 12:35:37.104368	2025-09-06 12:35:37.104368	\N	\N
40	127	104	400.0	\N	\N	\N		null	CashInBank	credit	86876876	\N	HDFC	PNB	2025-09-06 12:36:21.959471	2025-09-06 12:36:21.959471	\N	\N
43	127	104	100.0	\N	\N	\N		null	NEFT	credit	86876876	\N	SBI	HDFC	2025-09-06 12:52:53.423225	2025-09-06 12:52:53.423225	\N	\N
45	127	104	100.0	\N	\N	\N		null	Cheque	credit	86876876	\N	SBI	AXIS	2025-09-06 13:02:08.8759	2025-09-06 13:02:08.8759	\N	\N
46	127	104	1000.0	\N	\N	\N		null	CashInBank	credit	56757	\N	ICICI	AXIS	2025-09-08 04:47:39.042799	2025-09-08 04:47:39.042799	\N	\N
47	127	104	100.0	\N	\N	\N		null	IMPS	credit	4534	\N	SBI	SBI	2025-09-08 05:38:42.852321	2025-09-08 05:38:42.852321	\N	\N
48	139	\N	200.0	\N	\N	\N	malik	null	NEFT	credit	32444435	\N	SBI	HDFC	2025-09-08 05:43:00.558427	2025-09-08 05:43:00.558427	\N	\N
49	139	104	299.0	\N	\N	\N	malik	null	NEFT	credit	32444435	\N	SBI	HDFC	2025-09-08 05:44:50.488068	2025-09-08 05:44:50.488068	\N	\N
50	134	104	399.0	\N	\N	\N	test	null	NEFT	credit	100dsdddsds	\N	HDFC	ICICI	2025-09-08 06:37:14.65265	2025-09-08 06:37:14.65265	\N	\N
51	134	104	100.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	SBI	2025-09-08 07:28:52.968781	2025-09-08 07:28:52.968781	\N	\N
52	134	104	120.0	\N	\N	\N	test	null	NEFT	credit	100dsdddsds	\N	ICICI	HDFC	2025-09-08 07:45:11.344586	2025-09-08 07:45:11.344586	\N	\N
57	139	104	997.0	\N	\N	\N	malik	null	Netbanking	credit	32444435	\N	HDFC	SBI	2025-09-08 12:31:35.781488	2025-09-08 12:31:35.781488	\N	\N
58	139	104	500.0	\N	\N	\N	malik	null	Netbanking	credit	32444435	\N	SBI	SBI	2025-09-08 12:34:09.578595	2025-09-08 12:34:09.578595	\N	\N
60	127	104	100.0	\N	\N	\N		null	Cash	credit	564	\N	SBI	SBI	2025-09-10 13:31:42.342144	2025-09-10 13:31:42.342144	\N	\N
61	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 06:42:27.945305	2025-09-11 06:42:27.945305	\N	\N
62	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 07:38:16.938037	2025-09-11 07:38:16.938037	\N	\N
63	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 07:39:29.96736	2025-09-11 07:39:29.96736	\N	\N
64	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 07:40:27.444735	2025-09-11 07:40:27.444735	\N	\N
65	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 07:56:25.320924	2025-09-11 07:56:25.320924	\N	\N
66	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 08:38:21.030052	2025-09-11 08:38:21.030052	\N	\N
67	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 08:40:14.005162	2025-09-11 08:40:14.005162	\N	\N
69	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 08:45:56.258823	2025-09-11 08:45:56.258823	\N	\N
71	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 09:16:37.343503	2025-09-11 09:16:37.343503	\N	\N
6	104	136	12.0	success	\N	\N	test	\N	UPI	credit	hjkh978787879879	\N	SBI	SBI	2025-09-06 09:24:59.568809	2025-09-12 12:43:28.294395	\N	\N
9	104	136	20.0	success	\N	\N	test	\N	UPI	credit	hjhjhdjs766868	\N	SBI	AXIS	2025-09-06 09:57:23.541551	2025-09-12 12:43:28.296918	\N	\N
73	127	104	10000.0	\N	\N	\N		null	UPI	credit	4565465465464564645	\N	SBI	SBI	2025-09-11 09:56:48.199583	2025-09-11 09:56:48.199583	\N	\N
74	139	104	10000.0	\N	\N	\N		null	UPI	credit	32444435	\N	HDFC	ICICI	2025-09-11 09:56:48.428133	2025-09-11 09:56:48.428133	\N	\N
75	127	104	1000.0	\N	\N	\N		null	Netbanking	credit	2	\N	HDFC	SBI	2025-09-11 09:59:40.800117	2025-09-11 09:59:40.800117	\N	\N
76	139	104	90000.0	\N	\N	\N		null	Cheque	credit	32444435	\N	SBI	ICICI	2025-09-11 11:04:05.638344	2025-09-11 11:04:05.638344	\N	\N
77	134	104	120.0	\N	\N	\N	test	null	UPI	credit	Upi79879897csd	\N	HDFC	ICICI	2025-09-11 12:55:29.635289	2025-09-11 12:55:29.635289	\N	\N
79	139	104	333.0	\N	\N	\N		null	Cash	credit	32444435	\N	HDFC	HDFC	2025-09-11 14:12:28.311338	2025-09-11 14:12:28.311338	\N	\N
90	139	104	44.0	\N	\N	\N		null	Cheque	credit	32444435	\N	HDFC	SBI	2025-09-12 10:56:50.797145	2025-09-12 10:56:50.797145	\N	\N
91	127	104	2000.0	\N	\N	\N		null	Netbanking	credit	d	\N	SBI	SBI	2025-09-12 10:58:46.382606	2025-09-12 10:58:46.382606	\N	\N
98	139	104	85.0	\N	\N	\N		null	Cash	credit	32444435	\N	SBI	ICICI	2025-09-12 12:05:31.001945	2025-09-12 12:05:31.001945	\N	\N
99	138	\N	100.0	pending	\N	\N		\N	IMPS	\N	87	\N	SBI	SBI	2025-09-12 12:06:33.52371	2025-09-12 12:06:33.52371	\N	\N
31	104	136	30.0	success	\N	\N	test	\N	NEFT	credit	hjkh978787879879	\N	SBI	HDFC	2025-09-06 12:19:01.760776	2025-09-12 12:43:28.299106	\N	\N
36	104	136	100.0	success	\N	\N	test	\N	UPI	credit	lkjdshd79887687	\N	SBI	SBI	2025-09-06 12:32:32.729136	2025-09-12 12:43:28.301199	\N	\N
37	104	136	100.0	success	\N	\N	test	\N	NEFT	credit	jjdsh7686887	\N	SBI	SBI	2025-09-06 12:34:04.571712	2025-09-12 12:43:28.303474	\N	\N
38	104	136	100.0	success	\N	\N	test	\N	UPI	credit	sdsdsds	\N	SBI	HDFC	2025-09-06 12:34:52.777219	2025-09-12 12:43:28.305685	\N	\N
41	104	136	1000.0	success	\N	\N	test	\N	UPI	credit	hjkh978787879879	\N	HDFC	HDFC	2025-09-06 12:36:50.754006	2025-09-12 12:43:28.308021	\N	\N
42	104	136	100.0	success	\N	\N	Test	\N	UPI	credit	jHJKJHH787987	\N	HDFC	PNB	2025-09-06 12:50:35.90369	2025-09-12 12:43:28.31011	\N	\N
44	104	136	100.0	success	\N	\N	test	\N	UPI	credit	UPI95687586867	\N	SBI	SBI	2025-09-06 12:59:23.04227	2025-09-12 12:43:28.312366	\N	\N
53	104	136	100.0	success	\N	\N	test	\N	NEFT	credit	33232332	\N	SBI	SBI	2025-09-08 07:53:10.183143	2025-09-12 12:43:28.314382	\N	\N
54	104	136	100.0	success	\N	\N	test	\N	NEFT	credit	hjkh978787879879	\N	ICICI	HDFC	2025-09-08 08:30:37.275921	2025-09-12 12:43:28.316729	\N	\N
55	104	136	100.0	success	\N	\N	test	\N	CashInBank	credit	hjkh9787878798792222	\N	ICICI	HDFC	2025-09-08 08:32:27.761322	2025-09-12 12:43:28.319255	\N	\N
56	104	136	100.0	success	\N	\N	test	\N	UPI	credit	hjkh9787878798792222	\N	ICICI	ICICI	2025-09-08 08:33:58.913333	2025-09-12 12:43:28.321487	\N	\N
59	104	136	1000.0	success	\N	\N	test	\N	UPI	credit	hjkh978787879879	\N	ICICI	ICICI	2025-09-08 13:22:27.727574	2025-09-12 12:43:28.323919	\N	\N
68	104	136	300000.0	success	\N	\N	test	\N	UPI	credit	hjkh978787879879	\N	SBI	SBI	2025-09-11 08:41:07.372091	2025-09-12 12:43:28.327345	\N	\N
70	104	136	1000.0	success	\N	\N	test	\N	UPI	credit	jjkjds89809	\N	SBI	HDFC	2025-09-11 09:16:03.652824	2025-09-12 12:43:28.33054	\N	\N
72	104	136	100.0	success	\N	\N	test	\N	UPI	credit	hjkh978787879879	\N	HDFC	AXIS	2025-09-11 09:46:31.307035	2025-09-12 12:43:28.333577	\N	\N
78	104	136	100.0	success	\N	\N	test	\N	UPI	credit	Appim77987n	\N	SBI	HDFC	2025-09-11 12:56:20.453078	2025-09-12 12:43:28.336067	\N	\N
80	104	136	1089.0	success	\N	\N	test	\N	UPI	credit	SSid89897676	\N	HDFC	HDFC	2025-09-11 14:13:40.673541	2025-09-12 12:43:28.338282	\N	\N
81	104	136	5.0	success	\N	\N	test	\N	UPI	\N	hjkh978787879879	\N	SBI	SBI	2025-09-12 10:33:14.196391	2025-09-12 12:43:28.340767	\N	\N
82	104	136	5.0	success	\N	\N	test	\N	NEFT	\N	hjkh978787879879	\N	HDFC	HDFC	2025-09-12 10:35:42.102839	2025-09-12 12:43:28.343657	\N	\N
83	104	136	5.0	success	\N	\N	test	\N	UPI	\N	hjkh978787879879	\N	HDFC	SBI	2025-09-12 10:36:44.718712	2025-09-12 12:43:28.346525	\N	\N
84	104	136	5.0	success	\N	\N	test	\N	UPI	\N	hjkh978787879879	\N	SBI	HDFC	2025-09-12 10:39:31.020996	2025-09-12 12:43:28.3496	\N	\N
85	104	136	1.0	success	\N	\N		\N	NEFT	\N	hjkh978787879879	\N	SBI	SBI	2025-09-12 10:42:38.385524	2025-09-12 12:43:28.352403	\N	\N
86	104	136	3.0	success	\N	\N		\N	IMPS	\N	hjkh978787879879	\N	SBI	HDFC	2025-09-12 10:45:43.800779	2025-09-12 12:43:28.355145	\N	\N
87	104	136	5.0	success	\N	\N	test	\N	UPI	\N	hjkh978787879879	\N	ICICI	AXIS	2025-09-12 10:48:09.017809	2025-09-12 12:43:28.357609	\N	\N
88	104	136	5.0	success	\N	\N	test	\N	UPI	\N	hjkh978787879879	\N	HDFC	ICICI	2025-09-12 10:49:33.146204	2025-09-12 12:43:28.360077	\N	\N
89	104	136	5.0	success	\N	\N	test	\N	CashInBank	\N	hjkh978787879879	\N	HDFC	SBI	2025-09-12 10:56:10.923195	2025-09-12 12:43:28.362274	\N	\N
92	104	136	9.0	success	\N	\N	test	\N	NEFT	\N	33232332	\N	SBI	HDFC	2025-09-12 11:04:17.82122	2025-09-12 12:43:28.364573	\N	\N
93	104	136	5.0	success	\N	\N	test	\N	UPI	\N	hjkh978787879879	\N	SBI	SBI	2025-09-12 11:07:46.064179	2025-09-12 12:43:28.36684	\N	\N
94	104	136	5.0	success	\N	\N	test	\N	NEFT	\N	hjkh978787879879	\N	HDFC	HDFC	2025-09-12 11:09:37.755661	2025-09-12 12:43:28.368906	\N	\N
95	104	136	5.0	success	\N	\N	test	\N	UPI	\N	hjkh9787878798792222	\N	HDFC	HDFC	2025-09-12 11:41:44.662777	2025-09-12 12:43:28.372248	\N	\N
96	104	136	5.0	success	\N	\N	test	\N	UPI	\N	ddd	\N	HDFC	HDFC	2025-09-12 11:44:37.158235	2025-09-12 12:43:28.374441	\N	\N
97	104	136	5.0	success	\N	\N	test	\N	UPI	\N	hjkh978787879879	\N	ICICI	HDFC	2025-09-12 11:46:17.530108	2025-09-12 12:43:28.376855	\N	\N
100	104	136	5.0	success	\N	\N		\N	NEFT	\N	hjkh978787879879	\N	HDFC	HDFC	2025-09-12 12:07:09.153851	2025-09-12 12:43:28.379102	\N	\N
101	138	136	100.0	success	\N	\N		\N	IMPS	\N	1	\N	SBI	SBI	2025-09-12 12:10:10.589275	2025-09-12 12:43:28.381597	\N	\N
102	141	136	85.0	success	\N	\N	...	\N	UPI	\N	8888	\N	HDFC	HDFC	2025-09-12 12:11:31.792498	2025-09-12 12:43:28.383783	\N	\N
103	141	136	90.0	success	\N	\N	mm	\N	Cash	\N	8888	\N	HDFC	AXIS	2025-09-12 12:41:03.003884	2025-09-12 12:43:28.385955	\N	\N
104	141	136	100.0	pending	\N	\N	malik	\N	Cash	\N	8888	\N	HDFC	AXIS	2025-09-12 12:47:36.187494	2025-09-12 12:47:36.187494	\N	\N
105	134	104	100.0	\N	\N	\N	test	null	NEFT	credit	Upi79879897csd	\N	SBI	HDFC	2025-09-15 17:29:52.85102	2025-09-15 17:29:52.85102	\N	\N
106	127	104	50000.0	\N	\N	\N	ret	null	UPI	credit	34534	\N	HDFC	HDFC	2025-09-18 07:03:50.157983	2025-09-18 07:03:50.157983	\N	\N
107	127	104	2000.0	\N	\N	\N	dfg	null	CashInBank	credit	345	\N	SBI	HDFC	2025-09-18 07:13:36.791823	2025-09-18 07:13:36.791823	\N	\N
108	232	104	40000.0	\N	\N	\N	dedo bhai	null	NEFT	credit	2332	\N	HDFC	HDFC	2025-11-01 06:57:27.224395	2025-11-01 06:57:27.224395	\N	\N
109	230	104	10000.0	\N	\N	\N	dd	\N	Netbanking	credit	e3434	\N	SBI	ICICI	2025-11-01 14:03:08.646545	2025-11-01 14:03:08.646545	\N	\N
110	127	104	111.0	\N	\N	\N		null	Netbanking	credit	sdf324	\N	SBI	HDFC	2025-11-03 07:49:24.357265	2025-11-03 07:49:24.357265	\N	\N
111	127	104	55.0	\N	\N	\N	dede bhai	\N	NEFT	credit	12345568	\N	7	HDFC	2025-11-03 12:04:21.276667	2025-11-03 12:04:21.276667	\N	\N
112	127	104	55.0	\N	\N	\N	hh	null	UPI	credit	86876876	\N	7	HDFC	2025-11-03 12:04:55.464381	2025-11-03 12:04:55.464381	\N	\N
113	127	104	55.0	\N	\N	\N	hh	null	UPI	credit	86876876	\N	7	HDFC	2025-11-03 12:05:16.20943	2025-11-03 12:05:16.20943	\N	\N
114	127	104	55.0	\N	\N	\N	hh	null	UPI	credit	86876876	\N	7	HDFC	2025-11-03 12:05:18.872379	2025-11-03 12:05:18.872379	\N	\N
115	127	104	55.0	\N	\N	\N	hh	null	UPI	credit	86876876	\N	7	HDFC	2025-11-03 12:05:22.809339	2025-11-03 12:05:22.809339	\N	\N
116	127	104	55.0	\N	\N	\N	hh	null	UPI	credit	86876876	\N	7	HDFC	2025-11-03 12:06:09.025781	2025-11-03 12:06:09.025781	\N	\N
117	127	104	55.0	\N	\N	\N	hh	null	UPI	credit	86876876	\N	7	HDFC	2025-11-03 12:06:43.333589	2025-11-03 12:06:43.333589	\N	\N
118	127	104	118.0	\N	\N	\N	asq	\N	Netbanking	credit	ddd	\N	7	HDFC	2025-11-03 12:09:46.392081	2025-11-03 12:09:46.392081	\N	\N
119	127	104	118.0	\N	\N	\N	asq	\N	Netbanking	credit	ddd	\N	7	HDFC	2025-11-03 12:10:40.030317	2025-11-03 12:10:40.030317	\N	\N
120	127	104	118.0	\N	\N	\N	asq	\N	Netbanking	credit	ddd	\N	7	HDFC	2025-11-03 12:11:51.018828	2025-11-03 12:11:51.018828	\N	\N
121	127	104	118.0	\N	\N	\N	asq	\N	Netbanking	credit	ddd	\N	7	HDFC	2025-11-03 12:11:55.201265	2025-11-03 12:11:55.201265	\N	\N
122	127	104	894.0	rejected	104	2025-11-03 12:13:57.182847	jarurat h	\N	CashInBank	credit	asdff	\N	7	SBI	2025-11-03 12:13:00.564839	2025-11-03 12:13:57.183303	bank deatils not correct	\N
123	127	104	9.0	\N	\N	\N	d	null	UPI	credit	jjkg8967	\N	6	ICICI	2025-11-03 12:48:50.16022	2025-11-03 12:48:50.16022	\N	\N
124	127	104	8.0	\N	\N	\N	dd	null	CashInBank	credit	22332	\N	Axis	HDFC	2025-11-03 13:03:02.412179	2025-11-03 13:03:02.412179	\N	\N
125	127	104	111.0	\N	\N	\N	vv	null	NEFT	credit	ddd	\N	7	ICICI	2025-11-03 13:05:08.248497	2025-11-03 13:05:08.248497	\N	\N
126	127	104	888.0	\N	\N	\N	hh	null	IMPS	credit	jj	\N	Axis	PNB	2025-11-03 13:14:49.45963	2025-11-03 13:14:49.45963	\N	\N
127	127	104	1223.0	\N	\N	\N	ssad	null	NEFT	credit	dfds433	\N	HDFC	SBI	2025-11-03 13:17:10.652318	2025-11-03 13:17:10.652318	\N	\N
128	127	104	22.0	\N	\N	\N	t	null	NEFT	credit	8977777777777777777777777777777777777777777777777777777777777777777777777	\N	Axis	SBI	2025-11-04 05:24:28.099123	2025-11-04 05:24:28.099123	\N	\N
129	127	104	121.0	\N	\N	\N	dedo bhai	\N	Cash	credit	fdssds	\N	HDFC	PNB	2025-11-04 09:42:23.311194	2025-11-04 09:42:23.311194	\N	\N
130	127	104	4.0	\N	\N	\N	dede	\N	Cash	credit	86876876	\N	HDFC	AXIS	2025-11-04 09:44:38.93433	2025-11-04 09:44:38.93433	\N	\N
131	127	104	109.0	\N	\N	\N	sss	\N	NEFT	credit	2332	\N	Axis	SBI	2025-11-04 09:51:09.982331	2025-11-04 09:51:09.982331	\N	\N
132	127	104	3.0	\N	\N	\N	dd	\N	CashInBank	credit	dfsdf	\N	6	defe	2025-11-04 10:14:26.418929	2025-11-04 10:14:26.418929	\N	\N
133	127	104	8.0	\N	\N	\N	dd	\N	Cash	credit	dssfds	\N	HDFC	SBI	2025-11-04 10:15:09.228278	2025-11-04 10:15:09.228278	\N	\N
134	127	104	1.0	\N	\N	\N	frf	https://res.cloudinary.com/siddtec/image/upload/v1762251966/mwbxufgzi8g8hvkjcofo.jpg	CashInBank	credit	ddddd	\N	Axis	SBI	2025-11-04 10:26:07.296012	2025-11-04 10:26:07.296012	\N	\N
135	127	104	222.0	rejected	104	2025-11-04 11:10:24.701001	ff	https://res.cloudinary.com/siddtec/image/upload/v1762254453/hrgcpddokg4c6rbtf7nu.jpg	Cash	credit	66556	\N	HDFC	HDFC	2025-11-04 11:07:34.167463	2025-11-04 11:10:24.701424	test	\N
136	127	104	9.0	\N	\N	\N	fdc	https://res.cloudinary.com/siddtec/image/upload/v1762255937/lcldqfxvrqnlrabsjtvr.jpg	CashInBank	fund	444444	\N	Axis	ICICI	2025-11-04 11:32:17.826602	2025-11-04 11:32:17.826602	\N	\N
137	127	104	121.0	\N	\N	\N	fdg	https://res.cloudinary.com/siddtec/image/upload/v1762258428/lkdls7gkaslnhz6fbzu9.jpg	CashInBank	fund	2332	\N	Axis	SBI	2025-11-04 12:13:48.708485	2025-11-04 12:13:48.708485	\N	\N
138	127	104	400.0	\N	\N	\N	f	https://res.cloudinary.com/siddtec/image/upload/v1762258505/s8jdiebzqyg1rapufvhi.jpg	UPI	fund	2332	\N	Axis	HDFC	2025-11-04 12:15:05.911376	2025-11-04 12:15:05.911376	\N	\N
139	127	104	566.0	\N	\N	\N	dd	https://res.cloudinary.com/siddtec/image/upload/v1762261037/ijmzj5qlrabxchr5tzn1.jpg	Netbanking	fund	43543	\N	Axis	HDFC	2025-11-04 12:57:18.431816	2025-11-04 12:57:18.431816	\N	\N
140	127	104	39.0	\N	\N	\N	ff	https://res.cloudinary.com/siddtec/image/upload/v1762261365/lofjhga0eh1u9x35xzpi.png	NEFT	fund	ddd	\N	Axis	SBI	2025-11-04 13:02:46.52479	2025-11-04 13:02:46.52479	\N	\N
141	127	104	11.0	\N	\N	\N	df	https://res.cloudinary.com/siddtec/image/upload/v1762261467/lnq6yhqm9bwictjbpaxy.png	Cash	fund	456654	\N	HDFC	AXIS	2025-11-04 13:04:27.955779	2025-11-04 13:04:27.955779	\N	9877979787897
142	236	104	100.0	pending	\N	\N	test remark	\N	UPI	fund	BANK6786786	\N	Axis	Axis Bank	2025-11-11 11:25:46.341368	2025-11-11 11:25:46.341368	\N	7668686667686
143	236	104	20.0	rejected	104	2025-11-11 11:46:52.153491	test 2	\N	NEFT	fund	HJ7887987	\N	Axis	Axis Bank	2025-11-11 11:26:07.84972	2025-11-11 11:46:52.154418	test reject	7668686667686
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
20251102202413
20251103071536
20251104124908
20251105062051
20251105064724
20251105111424
20251107073517
20251107174754
\.


--
-- Data for Name: schemes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schemes (id, scheme_name, scheme_type, commision_rate, created_at, updated_at) FROM stdin;
5	Gold	Flat	10.0	2025-08-30 07:44:33.414877	2025-08-30 07:44:33.414877
16	Silver	Percentage	10.0	2025-09-15 18:36:11.457301	2025-11-11 10:10:28.598177
\.


--
-- Data for Name: service_product_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.service_product_items (id, service_product_id, name, oprator_type, status, created_at, updated_at) FROM stdin;
3	6	Delhi Water Bill	\N	\N	2025-10-30 12:27:03.609221	2025-10-30 12:27:03.609221
4	11	Airtel	\N	\N	2025-11-11 09:52:52.416272	2025-11-11 09:52:52.416272
5	11	Jio	\N	\N	2025-11-11 09:53:03.193032	2025-11-11 09:53:03.193032
6	12	Airtel	\N	\N	2025-11-11 09:57:30.518385	2025-11-11 09:57:30.518385
7	12	JioFiber	\N	\N	2025-11-11 09:57:38.580148	2025-11-11 09:57:38.580148
8	12	BSNL	\N	\N	2025-11-11 09:57:48.119564	2025-11-11 09:57:48.119564
9	13	Tata Play	\N	\N	2025-11-11 09:58:25.644342	2025-11-11 09:58:25.644342
10	13	Dish TV	\N	\N	2025-11-11 09:58:36.899608	2025-11-11 09:58:36.899608
11	13	Airtel Digital TV	\N	\N	2025-11-11 09:58:46.615273	2025-11-11 09:58:46.615273
12	13	Videocon d2h	\N	\N	2025-11-11 09:59:00.793501	2025-11-11 09:59:00.793501
13	6	Bangalore Water Supply	\N	\N	2025-11-11 10:00:00.807327	2025-11-11 10:00:00.807327
14	6	Kerala Water Authority	\N	\N	2025-11-11 10:00:09.879295	2025-11-11 10:00:09.879295
15	8	Kerala State Electricity Board Ltd. (KSEBL)	\N	\N	2025-11-11 10:01:22.633693	2025-11-11 10:01:22.633693
16	8	Uttar Pradesh Power Corporation Limited (UPPCL)	\N	\N	2025-11-11 10:01:34.669622	2025-11-11 10:01:34.669622
17	10	Indane Gas	\N	\N	2025-11-11 10:02:12.121119	2025-11-11 10:02:12.121119
18	10	Bharat Gas	\N	\N	2025-11-11 10:02:22.543052	2025-11-11 10:02:22.543052
19	10	HP Gas:	\N	\N	2025-11-11 10:02:34.543101	2025-11-11 10:02:34.543101
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
19	Municipal Tax	\N	\N	\N	\N	17	2025-09-09 13:04:34.037688	2025-09-09 13:04:34.037688
20	Society Maintenance	\N	\N	\N	\N	17	2025-09-09 13:04:45.989233	2025-09-09 13:04:45.989233
21	Traffic Challan	\N	\N	\N	\N	17	2025-09-09 13:04:59.070005	2025-09-09 13:04:59.070005
22	Education Fee	\N	\N	\N	\N	17	2025-09-09 13:05:11.874499	2025-09-09 13:05:11.874499
23	OTT Subscription	\N	\N	\N	\N	18	2025-09-09 13:05:50.521149	2025-09-09 13:05:50.521149
8	Electricity Bill	\N	\N	\N	\N	14	2025-09-09 12:59:13.972532	2025-09-10 06:05:59.00958
10	Gas Bill	\N	\N	\N	\N	14	2025-09-09 13:00:21.120867	2025-09-10 06:06:26.645656
17	Credit Card Bill RePayment	\N	\N	\N	\N	16	2025-09-09 13:03:41.353764	2025-10-27 14:15:43.02257
18	Rent Bill RePayment	\N	\N	\N	\N	16	2025-09-09 13:03:53.033764	2025-10-27 14:17:10.359267
\.


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.services (id, title, status, created_at, updated_at, logo, "position") FROM stdin;
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
541	475	136	\N	19.9	2025-11-12 06:36:08.93075	2025-11-12 06:36:08.93075	5
542	475	127	0	0.0	2025-11-12 06:36:08.941297	2025-11-12 06:36:08.941297	5
543	476	136	\N	9.600000000000001	2025-11-12 10:59:56.590136	2025-11-12 10:59:56.590136	4
544	476	127	0	0.0	2025-11-12 10:59:56.600214	2025-11-12 10:59:56.600214	4
545	477	136	\N	1.2	2025-11-12 11:00:39.740816	2025-11-12 11:00:39.740816	8
546	477	127	0	0.0	2025-11-12 11:00:39.751194	2025-11-12 11:00:39.751194	8
547	478	136	\N	1.2	2025-11-12 11:01:33.615749	2025-11-12 11:01:33.615749	5
548	478	127	0	0.0	2025-11-12 11:01:33.62632	2025-11-12 11:01:33.62632	5
549	479	136	\N	65.60000000000001	2025-11-12 11:02:04.104211	2025-11-12 11:02:04.104211	4
550	479	127	0	0.0	2025-11-12 11:02:04.115217	2025-11-12 11:02:04.115217	4
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactions (id, tx_id, operator, transaction_type, account_or_mobile, amount, status, user_id, created_at, updated_at, service_product_id, consumer_name, subscriber_or_vc_number, bill_no, landline_no, std_code, consumer_no, bank, mobile, vehicle_no, payment_method, ifsc_code, pan, upi_id, receiver_name, card_number, state) FROM stdin;
128	TXN756047	Airtel	ONLINE	7056858674	3.0	SUCCESS	127	2025-09-08 10:50:32.396033	2025-09-08 10:50:32.396033	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1	TXN281668	Jio	Mobile Recharge	8967896789	400.0	\N	118	2025-09-03 12:05:03.351194	2025-09-08 10:22:52.2069	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
56	TXN259615	Jio	ONLINE	9845634853	299.0	SUCCESS	127	2025-09-04 10:57:47.23236	2025-09-08 10:22:52.221127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
57	TXN625882	Jio	ONLINE	8458975789	299.0	SUCCESS	127	2025-09-04 11:01:24.17657	2025-09-08 10:22:52.223234	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
68	TXN648821	Jio	ONLINE	9987575469	299.0	SUCCESS	127	2025-09-04 13:21:22.687494	2025-09-08 10:22:52.225411	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
69	TXN627123	Jio	ONLINE	8786756756	299.0	SUCCESS	127	2025-09-04 14:00:45.73664	2025-09-08 10:22:52.227873	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
70	TXN895988	Jio	ONLINE	7656756565	199.0	SUCCESS	127	2025-09-04 14:01:34.089607	2025-09-08 10:22:52.230946	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
71	TXN862023	Jio	Mobile Recharge	9009090909	399.0	SUCCESS	142	2025-09-04 18:43:16.937956	2025-09-08 10:22:52.233913	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
72	TXN635460	Jio	Mobile Recharge	9009090909	399.0	SUCCESS	142	2025-09-04 18:46:40.329555	2025-09-08 10:22:52.237142	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
73	TXN343801	Jio	Mobile Recharge	9009090922	399.0	SUCCESS	142	2025-09-04 18:53:20.244303	2025-09-08 10:22:52.24002	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
74	TXN346260	Jio	Mobile Recharge	9009090922	399.0	SUCCESS	127	2025-09-04 18:54:51.550782	2025-09-08 10:22:52.242907	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
75	TXN711768	Jio	Mobile Recharge	9009090922	399.0	SUCCESS	127	2025-09-04 18:57:00.347102	2025-09-08 10:22:52.24524	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
76	TXN506209	Vi	ONLINE	9239878327	229.0	SUCCESS	139	2025-09-05 05:44:18.037868	2025-09-08 10:22:52.247392	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
77	TXN674407	Jio	ONLINE	9887734764	199.0	SUCCESS	139	2025-09-05 05:48:02.704505	2025-09-08 10:22:52.249639	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
78	TXN424671	Jio	ONLINE	9877636355	199.0	SUCCESS	139	2025-09-05 06:23:03.721722	2025-09-08 10:22:52.251834	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
79	TXN276375	Airtel	ONLINE	9999999998	399.0	SUCCESS	139	2025-09-05 06:25:10.37026	2025-09-08 10:22:52.254192	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
80	TXN644975	BSNL	ONLINE	9878378237	397.0	SUCCESS	139	2025-09-05 06:28:47.145921	2025-09-08 10:22:52.25682	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
81	TXN257987	Jio	ONLINE	9238942783	199.0	SUCCESS	139	2025-09-05 06:30:14.234533	2025-09-08 10:22:52.259246	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
82	TXN900769	BSNL	ONLINE	9857894576	397.0	SUCCESS	127	2025-09-05 07:13:50.99573	2025-09-08 10:22:52.261821	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
83	TXN524375	Jio	Mobile Recharge	9009090922	50.0	SUCCESS	127	2025-09-05 08:41:22.391336	2025-09-08 10:22:52.26518	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
84	TXN857294	Jio	Mobile Recharge	9009090922	50.0	SUCCESS	127	2025-09-05 08:42:16.040326	2025-09-08 10:22:52.268759	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
85	TXN204140	Jio	Mobile Recharge	9009090922	50.0	SUCCESS	127	2025-09-05 08:44:43.684339	2025-09-08 10:22:52.27196	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
86	TXN537108	Jio	Mobile Recharge	9009090922	50.0	SUCCESS	127	2025-09-05 08:45:03.448304	2025-09-08 10:22:52.27508	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
87	TXN464003	Jio	ONLINE	0878756854	50.0	SUCCESS	127	2025-09-05 08:45:52.606187	2025-09-08 10:22:52.277363	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
88	TXN222500	Jio	ONLINE	0576075896	100.0	SUCCESS	127	2025-09-05 08:46:34.81119	2025-09-08 10:22:52.279392	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
89	TXN662309	Vi	ONLINE	0960975609	379.0	SUCCESS	127	2025-09-05 08:55:37.184347	2025-09-08 10:22:52.281628	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
90	TXN447288	Airtel	ONLINE	7897485675	21.0	SUCCESS	127	2025-09-05 08:58:47.425191	2025-09-08 10:22:52.284238	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
91	TXN661745	Jio	ONLINE	9840675867	199.0	SUCCESS	127	2025-09-05 09:23:34.62912	2025-09-08 10:22:52.286774	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
92	TXN436882	Jio	ONLINE	8945867586	50.0	SUCCESS	127	2025-09-05 09:28:11.394245	2025-09-08 10:22:52.28987	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
93	TXN394010	BSNL	ONLINE	7684567857	149.0	SUCCESS	127	2025-09-05 09:39:07.585305	2025-09-08 10:22:52.293139	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
94	TXN108180	Airtel	ONLINE	9075867546	20.0	SUCCESS	127	2025-09-05 09:49:19.078264	2025-09-08 10:22:52.296696	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
95	TXN115835	Airtel	ONLINE	5654645645	2.0	SUCCESS	127	2025-09-05 11:15:30.230462	2025-09-08 10:22:52.30065	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
96	TXN494233	Jio	ONLINE	9789787878	50.0	SUCCESS	127	2025-09-05 11:16:31.28945	2025-09-08 10:22:52.303791	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
97	TXN618429	Airtel	ONLINE	9856846785	20.0	SUCCESS	127	2025-09-05 11:18:47.089867	2025-09-08 10:22:52.30624	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
98	TXN592478	Jio	Mobile Recharge	9009090922	299.0	SUCCESS	127	2025-09-05 11:24:44.197048	2025-09-08 10:22:52.308538	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
99	TXN482133	Jio	Mobile Recharge	9009090922	299.0	SUCCESS	127	2025-09-05 11:24:48.92322	2025-09-08 10:22:52.312191	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
100	TXN787813	Jio	Mobile Recharge	9009090922	299.0	SUCCESS	127	2025-09-05 11:24:55.301585	2025-09-08 10:22:52.314931	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
101	TXN930654	Vi	ONLINE	0945609576	10.0	SUCCESS	127	2025-09-05 11:25:44.790708	2025-09-08 10:22:52.317497	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
102	TXN385095	Vi	ONLINE	0875867567	400.0	SUCCESS	127	2025-09-05 11:26:16.087155	2025-09-08 10:22:52.319957	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
103	TXN334195	Jio	Mobile Recharge	9009090922	299.0	SUCCESS	127	2025-09-05 11:33:22.569956	2025-09-08 10:22:52.3223	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
104	TXN338812	Jio	Mobile Recharge	9009090922	299.0	SUCCESS	127	2025-09-05 11:34:24.48861	2025-09-08 10:22:52.324545	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
105	TXN269233	Jio	Mobile Recharge	9009090922	299.0	SUCCESS	127	2025-09-05 11:34:34.120231	2025-09-08 10:22:52.327183	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
106	TXN846137	Vi	ONLINE	7858967856	249.0	SUCCESS	127	2025-09-05 12:07:38.333002	2025-09-08 10:22:52.330655	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
107	TXN190902	Airtel	ONLINE	0878586666	87.0	SUCCESS	127	2025-09-05 12:20:42.904552	2025-09-08 10:22:52.333906	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
108	TXN169040	Jio	ONLINE	8708578954	87.0	SUCCESS	127	2025-09-05 12:21:36.303358	2025-09-08 10:22:52.33662	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
109	TXN496480	Airtel	ONLINE	0707098787	11.0	SUCCESS	127	2025-09-05 12:22:13.879889	2025-09-08 10:22:52.339104	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
110	TXN810013	Jio	ONLINE	9895671000	20.0	SUCCESS	127	2025-09-05 12:47:27.214822	2025-09-08 10:22:52.341523	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
111	TXN641850	Jio	Mobile Recharge	9009090922	299.0	SUCCESS	127	2025-09-05 13:06:22.936565	2025-09-08 10:22:52.344146	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
112	TXN912535	Airtel	ONLINE	9745489679	6.0	SUCCESS	127	2025-09-05 13:13:12.180993	2025-09-08 10:22:52.347472	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
113	TXN231637	Airtel	ONLINE	8798586488	399.0	SUCCESS	127	2025-09-05 13:16:28.43975	2025-09-08 10:22:52.353644	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
114	TXN229026	Airtel	ONLINE	8979897565	296.0	SUCCESS	127	2025-09-05 13:34:07.647398	2025-09-08 10:22:52.356519	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
115	TXN832761	Airtel	ONLINE	9998899988	5.0	SUCCESS	127	2025-09-06 11:16:32.272829	2025-09-08 10:22:52.359376	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
116	TXN475640	BSNL	ONLINE	0970870709	99.0	SUCCESS	127	2025-09-06 12:37:36.255575	2025-09-08 10:22:52.364047	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
117	TXN658998	Airtel	ONLINE	8798768967	194.0	SUCCESS	127	2025-09-06 13:03:10.251816	2025-09-08 10:22:52.367709	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
118	TXN762371	Jio	ONLINE	7867867856	299.0	SUCCESS	127	2025-09-08 04:46:48.019377	2025-09-08 10:22:52.370379	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
119	TXN431538	Airtel	ONLINE	8779878989	39.0	SUCCESS	127	2025-09-08 06:25:19.941011	2025-09-08 10:22:52.372862	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
120	TXN815653	Jio	ONLINE	9809809898	299.0	SUCCESS	134	2025-09-08 06:38:39.303612	2025-09-08 10:22:52.375543	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
121	TXN470060	Jio	ONLINE	9887273276	199.0	SUCCESS	139	2025-09-08 06:42:13.18747	2025-09-08 10:22:52.377878	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
122	TXN819087	Airtel	ONLINE	9843847847	50.0	SUCCESS	139	2025-09-08 06:48:08.879054	2025-09-08 10:22:52.380177	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
123	TXN620063	Airtel	ONLINE	9879879879	50.0	SUCCESS	134	2025-09-08 09:43:13.55077	2025-09-08 10:22:52.382613	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
124	TXN463554	Airtel	ONLINE	9098097798	70.0	SUCCESS	134	2025-09-08 09:43:30.569204	2025-09-08 10:22:52.385305	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
125	TXN854120	Jio	Mobile Recharge	9009090922	2.0	SUCCESS	134	2025-09-08 10:00:26.922384	2025-09-08 10:22:52.38799	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
126	TXN914289	Jio	ONLINE	0934085758	199.0	SUCCESS	127	2025-09-08 10:11:49.967456	2025-09-08 10:22:52.39063	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
140	TXN535305	Vi	ONLINE	2434343432	1.0	SUCCESS	134	2025-09-08 11:33:49.07642	2025-09-08 11:33:49.07642	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
141	TXN355074	Airtel	ONLINE	0987086566	20.0	SUCCESS	127	2025-09-08 12:27:39.957225	2025-09-08 12:27:39.957225	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
142	TXN151842	Vi	ONLINE	8750675867	10.0	SUCCESS	127	2025-09-08 13:14:56.993997	2025-09-08 13:14:56.993997	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
143	TXN553175	Jio	ONLINE	0857067456	10.0	SUCCESS	127	2025-09-08 13:21:49.664094	2025-09-08 13:21:49.664094	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
144	TXN234735	Airtel	ONLINE	8658567567	20.0	SUCCESS	127	2025-09-09 05:18:48.394867	2025-09-09 05:18:48.394867	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
145	TXN532198	Airtel	ONLINE	8956754765	399.0	SUCCESS	127	2025-09-09 05:24:22.449339	2025-09-09 05:24:22.449339	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
146	TXN869761	Airtel	ONLINE	8098098098	1.0	SUCCESS	134	2025-09-09 06:18:01.443742	2025-09-09 06:18:01.443742	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
147	TXN882975	Airtel	ONLINE	0988098098	1.0	SUCCESS	134	2025-09-09 06:23:20.171762	2025-09-09 06:23:20.171762	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
148	TXN588595	Jio	ONLINE	5645654645	1.0	SUCCESS	127	2025-09-09 06:23:42.38084	2025-09-09 06:23:42.38084	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
149	TXN474624	Airtel	ONLINE	5645645645	1.0	SUCCESS	127	2025-09-09 06:24:17.013129	2025-09-09 06:24:17.013129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
150	TXN259000	Airtel	ONLINE	4567546456	24.0	SUCCESS	127	2025-09-09 06:26:29.10355	2025-09-09 06:26:29.10355	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
151	TXN112533	Jio	ONLINE	7685763476	2.0	SUCCESS	127	2025-09-09 06:48:28.538808	2025-09-09 06:48:28.538808	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
152	TXN166438	Jio	ONLINE	8768456758	11.0	SUCCESS	127	2025-09-09 06:52:25.368241	2025-09-09 06:52:25.368241	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
153	TXN421433	Jio	ONLINE	9090998778	1.0	SUCCESS	127	2025-09-09 08:05:14.835729	2025-09-09 08:05:14.835729	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
154	TXN989068	Vi	ONLINE	8873743264	229.0	SUCCESS	139	2025-09-09 09:00:04.916378	2025-09-09 09:00:04.916378	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
155	TXN252515	Jio	ONLINE	7676767676	10.0	SUCCESS	127	2025-09-09 13:10:00.134472	2025-09-09 13:10:00.134472	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
156	TXN713549	Jio	ONLINE	9978787676	299.0	SUCCESS	139	2025-09-09 13:11:04.824057	2025-09-09 13:11:04.824057	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
157	TXN249751	Jio	ONLINE	7697677698	199.0	SUCCESS	127	2025-09-09 13:54:42.225975	2025-09-09 13:54:42.225975	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
158	TXN120346	Jio	ONLINE	9034984798	299.0	SUCCESS	139	2025-09-09 13:55:11.517	2025-09-09 13:55:11.517	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
159	TXN685312	Jio	ONLINE	8969767687	20.0	SUCCESS	127	2025-09-09 13:56:46.749001	2025-09-09 13:56:46.749001	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
160	TXN501124	Jio	ONLINE	7897787787	1.0	SUCCESS	134	2025-09-09 14:12:39.059523	2025-09-09 14:12:39.059523	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
161	TXN639201	Jio	ONLINE	9879779787	12.0	SUCCESS	134	2025-09-09 16:38:51.449622	2025-09-09 16:38:51.449622	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
162	TXN248001	Jio	Mobile Recharge	787987778787	2.0	SUCCESS	134	2025-09-10 05:47:38.238908	2025-09-10 05:47:38.238908	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
163	TXN124168	Jio	Mobile Recharge	787987778787	2.0	SUCCESS	134	2025-09-10 05:53:43.171169	2025-09-10 05:53:43.171169	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
164	TXN668614	Jio	Mobile Recharge	787987778787	2.0	SUCCESS	134	2025-09-10 06:51:23.336111	2025-09-10 06:51:23.336111	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
165	TXN294955	Airtel	ONLINE	0978907898	2.0	SUCCESS	127	2025-09-10 06:57:55.166792	2025-09-10 06:57:55.166792	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
166	TXN212475	Jio	Mobile Recharge	787987778787	2.0	SUCCESS	134	2025-09-10 07:04:24.891643	2025-09-10 07:04:24.891643	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
167	TXN581251	Jio	Mobile Recharge	787987778787	0.5	SUCCESS	134	2025-09-10 07:54:37.976986	2025-09-10 07:54:37.976986	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
168	TXN879441	Jio	Mobile Recharge	89898877878	0.5	SUCCESS	134	2025-09-10 08:45:06.920316	2025-09-10 08:45:06.920316	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
169	TXN933030	Jio	Mobile Recharge	89898877878	0.5	SUCCESS	134	2025-09-10 08:52:55.857724	2025-09-10 08:52:55.857724	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
170	TXN931271	Jio	Mobile Recharge	89898877878	0.5	SUCCESS	134	2025-09-10 09:13:14.279833	2025-09-10 09:13:14.279833	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
171	TXN734167	Jio	Mobile Recharge	89898877878	0.5	SUCCESS	134	2025-09-10 09:34:46.744849	2025-09-10 09:34:46.744849	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
172	TXN755654	Jio	Mobile Recharge	89898977777	0.5	SUCCESS	134	2025-09-10 10:17:43.769943	2025-09-10 10:17:43.769943	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
173	TXN814227	Jio	Mobile Recharge	90900990909	0.5	SUCCESS	134	2025-09-10 10:38:27.425217	2025-09-10 10:38:27.425217	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
174	TXN228474	Airtel	\N	0988088098	2.0	SUCCESS	134	2025-09-10 12:21:21.90358	2025-09-10 12:21:21.90358	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
175	TXN203982	Airtel	\N	8765645645	22.0	SUCCESS	127	2025-09-10 12:29:34.652818	2025-09-10 12:29:34.652818	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
176	TXN889945	Jio	\N	7586758896	11.0	SUCCESS	127	2025-09-10 12:57:43.454721	2025-09-10 12:57:43.454721	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
177	TXN575336	Airtel	\N	7586758675	11.0	SUCCESS	127	2025-09-10 12:59:29.002969	2025-09-10 12:59:29.002969	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
178	TXN615156	Airtel	\N	9869869869	10.0	SUCCESS	127	2025-09-10 13:07:20.884092	2025-09-10 13:07:20.884092	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
179	TXN844985	Jio	\N	7697698689	8.0	SUCCESS	127	2025-09-10 13:11:29.503531	2025-09-10 13:11:29.503531	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
180	TXN869309	Jio	\N	5464646464	7.0	SUCCESS	127	2025-09-11 05:41:06.551229	2025-09-11 05:41:06.551229	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
181	TXN378844	Jio	\N	5765756756	1.0	SUCCESS	127	2025-09-11 06:51:20.978864	2025-09-11 06:51:20.978864	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
182	TXN328446	Jio	\N	5745756746	4.0	SUCCESS	127	2025-09-11 07:00:30.9748	2025-09-11 07:00:30.9748	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
183	TXN101178	Jio	\N	8768969869	1.0	SUCCESS	127	2025-09-11 07:03:06.255595	2025-09-11 07:03:06.255595	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
184	TXN613670	Jio	\N	7458697560	1.0	SUCCESS	127	2025-09-11 07:10:00.37594	2025-09-11 07:10:00.37594	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
185	TXN285126	Jio	\N	5464564556	1.0	SUCCESS	127	2025-09-11 07:26:50.256178	2025-09-11 07:26:50.256178	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
186	TXN451227	Vi	\N	7664567458	1.0	SUCCESS	127	2025-09-11 07:31:13.033061	2025-09-11 07:31:13.033061	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
187	TXN786844	Jio	\N	8798796986	1.0	SUCCESS	127	2025-09-11 07:35:38.454368	2025-09-11 07:35:38.454368	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
188	TXN450168	Jio	\N	7438578347	1.0	SUCCESS	127	2025-09-11 07:40:28.559514	2025-09-11 07:40:28.559514	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
189	TXN141978	Jio	\N	8756875465	1.0	SUCCESS	127	2025-09-11 07:41:36.377643	2025-09-11 07:41:36.377643	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
190	TXN730547	Jio	\N	9070979709	1.0	SUCCESS	127	2025-09-11 07:54:59.352708	2025-09-11 07:54:59.352708	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
191	TXN939768	Jio	\N	9070979709	1.0	SUCCESS	127	2025-09-11 07:56:05.821882	2025-09-11 07:56:05.821882	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
192	TXN391513	Jio	\N	9070979709	1.0	SUCCESS	127	2025-09-11 07:56:24.619032	2025-09-11 07:56:24.619032	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
193	TXN492587	Jio	\N	5565464654	1.0	SUCCESS	127	2025-09-11 08:39:25.227632	2025-09-11 08:39:25.227632	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
194	TXN397223	Jio	\N	5565464654	1.0	SUCCESS	127	2025-09-11 08:41:28.840778	2025-09-11 08:41:28.840778	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
195	TXN808869	Jio	\N	8787897878	1.0	SUCCESS	127	2025-09-11 08:44:47.812085	2025-09-11 08:44:47.812085	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
196	TXN873058	Jio	\N	8787987987	1.0	SUCCESS	127	2025-09-11 08:46:06.238012	2025-09-11 08:46:06.238012	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
197	TXN676243	Jio	\N	8787987987	1.0	SUCCESS	127	2025-09-11 08:46:33.148985	2025-09-11 08:46:33.148985	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
198	TXN521952	Jio	\N	8787987987	1.0	SUCCESS	127	2025-09-11 08:50:27.020339	2025-09-11 08:50:27.020339	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
199	TXN884495	Jio	\N	9076095807	1.0	SUCCESS	127	2025-09-11 08:51:39.268617	2025-09-11 08:51:39.268617	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
200	TXN257119	Airtel	RECHARGE	5687567567	1.0	SUCCESS	127	2025-09-11 10:58:28.876792	2025-09-11 10:58:28.876792	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
201	TXN205641	Jio	RECHARGE	6756757575	1.0	SUCCESS	127	2025-09-11 11:05:38.886778	2025-09-11 11:05:38.886778	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
202	TXN467878	Vi	RECHARGE	8778789789	19.0	SUCCESS	127	2025-09-11 12:29:53.212623	2025-09-11 12:29:53.212623	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
203	TXN482109	Jio	RECHARGE	6574657574	111.0	SUCCESS	127	2025-09-11 12:55:41.412242	2025-09-11 12:55:41.412242	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
204	TXN764000	Jio	RECHARGE	8769697677	1.0	SUCCESS	127	2025-09-11 13:33:13.689056	2025-09-11 13:33:13.689056	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
205	TXN722700	Airtel	RECHARGE	5475675757	249.0	SUCCESS	127	2025-09-11 13:51:22.509643	2025-09-11 13:51:22.509643	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
206	TXN948113	Airtel	RECHARGE	3453453535	11.0	SUCCESS	127	2025-09-12 07:06:53.361775	2025-09-12 07:06:53.361775	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
207	TXN668264	Jio	RECHARGE	8578978968	10.0	SUCCESS	127	2025-09-12 12:52:30.369447	2025-09-12 12:52:30.369447	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
208	TXN354579	Jio	RECHARGE	7999998897	78.0	SUCCESS	127	2025-09-15 05:32:09.762417	2025-09-15 05:32:09.762417	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
209	TXN134956	Airtel	RECHARGE	7989798789	249.0	SUCCESS	134	2025-09-15 17:31:19.254578	2025-09-15 17:31:19.254578	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
210	TXN722079	Jio	RECHARGE	9877987987	199.0	SUCCESS	134	2025-09-15 17:32:14.626233	2025-09-15 17:32:14.626233	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
211	TXN461921	Jio	Mobile Recharge	90900990909	0.5	SUCCESS	134	2025-09-16 11:49:52.933333	2025-09-16 11:49:52.933333	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
212	TXN787631	Jio	Mobile Recharge	90900990909	0.5	SUCCESS	134	2025-09-16 11:51:46.530596	2025-09-16 11:51:46.530596	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
214	TXN737928	Jio	Mobile Recharge	90900990909	0.5	SUCCESS	134	2025-09-16 12:14:40.142912	2025-09-16 12:14:40.142912	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
215	TXN317855	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 12:15:04.40333	2025-09-16 12:15:04.40333	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
216	TXN300830	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 12:21:57.758636	2025-09-16 12:21:57.758636	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
217	TXN645259	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 12:26:38.88992	2025-09-16 12:26:38.88992	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
218	TXN339807	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 12:34:46.87571	2025-09-16 12:34:46.87571	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
219	TXN398013	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 12:36:23.533953	2025-09-16 12:36:23.533953	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
222	TXN239080	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 12:47:18.865088	2025-09-16 12:47:18.865088	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
223	TXN519196	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 12:48:08.002008	2025-09-16 12:48:08.002008	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
224	TXN709457	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 12:49:56.624078	2025-09-16 12:49:56.624078	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
225	TXN613455	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 13:23:35.873272	2025-09-16 13:23:35.873272	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
226	TXN837690	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 13:25:41.610225	2025-09-16 13:25:41.610225	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
227	TXN226369	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-16 13:26:10.871114	2025-09-16 13:26:10.871114	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
228	TXN735894	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-16 13:26:53.523648	2025-09-16 13:26:53.523648	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
229	TXN800767	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-16 13:28:18.75625	2025-09-16 13:28:18.75625	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
230	TXN794781	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-16 13:30:11.323746	2025-09-16 13:30:11.323746	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
231	TXN534069	Airtel	RECHARGE	0567506756	300.0	SUCCESS	127	2025-09-16 13:44:22.113514	2025-09-16 13:44:22.113514	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
233	TXN713846	Jio	Mobile Recharge	90900990909	56.0	SUCCESS	127	2025-09-16 13:46:47.474368	2025-09-16 13:46:47.474368	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
234	TXN842391	Jio	RECHARGE	8758646754	300.0	SUCCESS	127	2025-09-16 13:52:52.408975	2025-09-16 13:52:52.408975	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
235	TXN704415	Jio	RECHARGE	7796769669	300.0	SUCCESS	127	2025-09-16 13:55:46.961427	2025-09-16 13:55:46.961427	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
236	TXN202588	Jio	RECHARGE	8945689456	300.0	SUCCESS	127	2025-09-16 13:57:09.975787	2025-09-16 13:57:09.975787	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
250	TXN816699	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 18:27:19.635547	2025-09-16 18:27:19.635547	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
251	TXN774851	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 18:27:28.360533	2025-09-16 18:27:28.360533	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
252	TXN617962	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 18:27:43.614023	2025-09-16 18:27:43.614023	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
255	TXN406027	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 18:37:51.654406	2025-09-16 18:37:51.654406	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
257	TXN180359	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 18:41:26.852442	2025-09-16 18:41:26.852442	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
258	TXN842031	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 18:42:35.236836	2025-09-16 18:42:35.236836	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
259	TXN882156	Jio	RECHARGE	5657567576	200.0	SUCCESS	127	2025-09-17 04:47:49.450049	2025-09-17 04:47:49.450049	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
260	TXN838072	Jio	RECHARGE	0856745769	200.0	SUCCESS	127	2025-09-17 05:04:20.218995	2025-09-17 05:04:20.218995	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
261	TXN295166	Jio	RECHARGE	0947695479	52.0	SUCCESS	127	2025-09-17 05:12:23.77691	2025-09-17 05:12:23.77691	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
262	TXN958369	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-17 06:54:00.706193	2025-09-17 06:54:00.706193	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
263	TXN833807	Jio	RECHARGE	8934589436	200.0	SUCCESS	127	2025-09-17 07:20:05.650515	2025-09-17 07:20:05.650515	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
264	TXN622002	Jio	RECHARGE	5654645645	200.0	SUCCESS	127	2025-09-17 07:22:58.424074	2025-09-17 07:22:58.424074	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
265	TXN807687	Airtel	RECHARGE	5745675467	500.0	SUCCESS	127	2025-09-17 07:23:39.606543	2025-09-17 07:23:39.606543	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
266	TXN319177	Airtel	RECHARGE	8687966796	500.0	SUCCESS	127	2025-09-17 07:25:57.970954	2025-09-17 07:25:57.970954	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
267	TXN295019	Airtel	RECHARGE	5656765756	500.0	SUCCESS	139	2025-09-17 07:27:40.871936	2025-09-17 07:27:40.871936	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
268	TXN784529	Airtel	RECHARGE	8787878978	500.0	SUCCESS	127	2025-09-17 07:54:09.134099	2025-09-17 07:54:09.134099	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
269	TXN465639	Airtel	RECHARGE	7456756756	500.0	SUCCESS	127	2025-09-17 07:55:10.723613	2025-09-17 07:55:10.723613	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
270	TXN672407	Jio	Mobile Recharge	90900990909	100.0	SUCCESS	127	2025-09-17 08:33:26.703938	2025-09-17 08:33:26.703938	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
271	TXN740032	Airtel	Mobile Recharge	90900990909	100.0	SUCCESS	127	2025-09-17 08:33:45.028439	2025-09-17 08:33:45.028439	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
272	TXN258651	Airtel	Mobile Recharge	90900990909	100.0	SUCCESS	127	2025-09-17 08:44:53.65969	2025-09-17 08:44:53.65969	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
274	TXN811268	Airtel	Mobile Recharge	90900990909	100.0	SUCCESS	127	2025-09-17 08:48:03.601258	2025-09-17 08:48:03.601258	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
275	TXN596076	Airtel	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-17 08:49:14.105294	2025-09-17 08:49:14.105294	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
276	TXN599264	Airtel	RECHARGE	4645654654	300.0	SUCCESS	127	2025-09-17 08:51:14.251345	2025-09-17 08:51:14.251345	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
277	TXN364943	Jio	RECHARGE	8789758675	300.0	SUCCESS	127	2025-09-17 08:51:57.624669	2025-09-17 08:51:57.624669	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
278	TXN607953	Jio	RECHARGE	8785658765	300.0	SUCCESS	127	2025-09-17 08:53:05.440148	2025-09-17 08:53:05.440148	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
279	TXN420215	Airtel	RECHARGE	8966986896	292.0	SUCCESS	139	2025-09-17 08:56:17.15513	2025-09-17 08:56:17.15513	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
280	TXN208381	Jio	RECHARGE	8697697787	300.0	SUCCESS	139	2025-09-17 08:57:43.969877	2025-09-17 08:57:43.969877	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
281	TXN834330	Jio	RECHARGE	7764567056	15.0	SUCCESS	127	2025-09-17 09:19:00.912416	2025-09-17 09:19:00.912416	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
282	TXN122653	Airtel	RECHARGE	8767867867	200.0	SUCCESS	127	2025-09-17 09:35:50.907701	2025-09-17 09:35:50.907701	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
283	TXN832440	Jio	RECHARGE	8976695656	10.0	SUCCESS	127	2025-09-17 09:46:34.617237	2025-09-17 09:46:34.617237	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
284	TXN489650	Jio	RECHARGE	7567586975	100.0	SUCCESS	127	2025-09-17 09:48:16.278247	2025-09-17 09:48:16.278247	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
285	TXN214259	Airtel	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-17 10:13:05.935248	2025-09-17 10:13:05.935248	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
286	TXN593081	Jio	RECHARGE	3454534534	100.0	SUCCESS	127	2025-09-17 10:26:43.701329	2025-09-17 10:26:43.701329	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
295	TXN903636	Airtel	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-17 10:41:26.622673	2025-09-17 10:41:26.622673	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
296	TXN433465	Jio	RECHARGE	5686585685	10.0	SUCCESS	127	2025-09-17 10:41:58.333323	2025-09-17 10:41:58.333323	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
297	TXN737030	Jio	RECHARGE	3423423423	120.0	SUCCESS	127	2025-09-17 10:42:39.982348	2025-09-17 10:42:39.982348	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
308	TXN722291	Airtel	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-17 10:51:05.168523	2025-09-17 10:51:05.168523	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
309	TXN364761	Vi	RECHARGE	5654656456	10.0	SUCCESS	127	2025-09-17 10:51:19.628799	2025-09-17 10:51:19.628799	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
310	TXN315212	Jio	RECHARGE	9845867567	12.0	SUCCESS	127	2025-09-17 10:51:49.49754	2025-09-17 10:51:49.49754	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
311	TXN143694	Airtel	RECHARGE	8687658785	50.0	SUCCESS	127	2025-09-17 10:52:17.969768	2025-09-17 10:52:17.969768	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
312	TXN689981	Airtel	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-17 10:54:47.842512	2025-09-17 10:54:47.842512	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
313	TXN258064	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-17 10:57:09.312588	2025-09-17 10:57:09.312588	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
314	TXN269648	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-17 10:58:01.783852	2025-09-17 10:58:01.783852	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
315	TXN724817	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-17 10:59:57.631788	2025-09-17 10:59:57.631788	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
316	TXN615646	Airtel	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-17 11:00:17.213265	2025-09-17 11:00:17.213265	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
317	TXN214319	Jio	RECHARGE	0958765675	200.0	SUCCESS	127	2025-09-17 11:26:43.713611	2025-09-17 11:26:43.713611	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
318	TXN256499	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-17 11:36:04.041119	2025-09-17 11:36:04.041119	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
319	TXN159094	Airtel	Mobile Recharge	90900990909	200.0	SUCCESS	127	2025-09-17 11:37:06.513151	2025-09-17 11:37:06.513151	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
320	TXN669987	Airtel	Mobile Recharge	90900990909	200.0	SUCCESS	127	2025-09-17 11:37:27.281698	2025-09-17 11:37:27.281698	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
321	TXN625722	Jio	RECHARGE	9876896869	100.0	SUCCESS	127	2025-09-17 11:39:20.104412	2025-09-17 11:39:20.104412	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
322	TXN400351	Airtel	Mobile Recharge	90900990909	100.0	SUCCESS	127	2025-09-17 11:41:47.51083	2025-09-17 11:41:47.51083	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
324	TXN888029	Airtel	RECHARGE	9097689768	100.0	SUCCESS	127	2025-09-17 11:48:12.222171	2025-09-17 11:48:12.222171	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
323	TXN616112	Jio	RECHARGE	7687676767	100.0	SUCCESS	127	2025-09-17 11:43:19.831598	2025-09-17 11:43:19.831598	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
325	TXN103156	Jio	RECHARGE	9789669767	100.0	SUCCESS	127	2025-09-17 12:28:54.970953	2025-09-17 12:28:54.970953	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
326	TXN609571	Airtel	RECHARGE	8784685486	200.0	SUCCESS	127	2025-09-17 12:29:36.34278	2025-09-17 12:29:36.34278	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
327	TXN564454	Airtel	RECHARGE	1000789789	200.0	SUCCESS	127	2025-09-17 12:31:10.357063	2025-09-17 12:31:10.357063	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
328	TXN399632	Airtel	RECHARGE	8968776587	100.0	SUCCESS	127	2025-09-17 12:32:22.390778	2025-09-17 12:32:22.390778	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
329	TXN806740	Airtel	RECHARGE	6796986976	100.0	SUCCESS	127	2025-09-17 13:07:40.843607	2025-09-17 13:07:40.843607	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
330	TXN956273	Vi	RECHARGE	5465464565	100.0	SUCCESS	127	2025-09-17 13:21:12.841464	2025-09-17 13:21:12.841464	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
331	TXN546292	Jio	RECHARGE	6585675675	200.0	SUCCESS	127	2025-09-17 13:21:37.296395	2025-09-17 13:21:37.296395	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
332	TXN258548	Airtel	Mobile Recharge	90900990909	100.0	SUCCESS	127	2025-09-17 13:27:11.700797	2025-09-17 13:27:11.700797	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
333	TXN961809	Airtel	Mobile Recharge	90900990909	100.0	SUCCESS	127	2025-09-17 13:32:55.517983	2025-09-17 13:32:55.517983	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
334	TXN381293	Jio	RECHARGE	6796786786	100.0	SUCCESS	127	2025-09-17 13:56:34.152287	2025-09-17 13:56:34.152287	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
335	TXN210593	Airtel	RECHARGE	6786786787	100.0	SUCCESS	127	2025-09-17 13:57:11.842682	2025-09-17 13:57:11.842682	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
336	TXN431514	Jio	RECHARGE	0947569697	100.0	SUCCESS	127	2025-09-18 06:55:53.673028	2025-09-18 06:55:53.673028	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
338	TXN413777	Jio	RECHARGE	4645645645	199.0	SUCCESS	127	2025-09-18 07:17:06.526147	2025-09-18 07:17:06.526147	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
339	TXN837088	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-18 07:23:23.735867	2025-09-18 07:23:23.735867	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
340	TXN275214	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-18 07:24:08.868119	2025-09-18 07:24:08.868119	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
341	TXN335281	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-18 07:33:40.636773	2025-09-18 07:33:40.636773	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
342	TXN476639	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-18 07:34:19.027779	2025-09-18 07:34:19.027779	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
343	TXN654151	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-18 07:36:21.332997	2025-09-18 07:36:21.332997	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
344	TXN557708	Airtel	Mobile Recharge	90900990909	200.0	SUCCESS	127	2025-09-18 07:50:43.336924	2025-09-18 07:50:43.336924	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
345	TXN920846	Airtel	RECHARGE	9893738632	200.0	SUCCESS	139	2025-09-18 08:37:43.504628	2025-09-18 08:37:43.504628	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
346	TXN857094	Airtel	RECHARGE	7867876868	100.0	SUCCESS	127	2025-09-18 11:23:48.925907	2025-09-18 11:23:48.925907	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
347	TXN126455	Jio	RECHARGE	9878867676	300.0	SUCCESS	139	2025-09-18 13:10:04.597224	2025-09-18 13:10:04.597224	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
348	TXN373443	Airtel	Mobile Recharge	90900990909	200.0	SUCCESS	127	2025-09-19 10:56:34.351964	2025-09-19 10:56:34.351964	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
349	TXN866337	Airtel	Mobile Recharge	90900990909	200.0	SUCCESS	127	2025-09-19 11:07:44.341036	2025-09-19 11:07:44.341036	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
350	TXN581792	Airtel	Mobile Recharge	90900990909	200.0	SUCCESS	127	2025-09-19 11:08:08.930916	2025-09-19 11:08:08.930916	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
351	TXN950125	Airtel	Mobile Recharge	90900990909	200.0	SUCCESS	127	2025-09-19 11:12:30.625876	2025-09-19 11:12:30.625876	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
352	TXN111597	Jio	RECHARGE	8789795666	200.0	SUCCESS	127	2025-09-19 11:49:50.1497	2025-09-19 11:49:50.1497	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
353	TXN873815	Airtel	RECHARGE	6756756756	399.0	SUCCESS	127	2025-09-19 11:50:50.760418	2025-09-19 11:50:50.760418	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
354	TXN174533	Airtel	Mobile Recharge	90900990909	200.0	SUCCESS	134	2025-09-19 12:06:30.304773	2025-09-19 12:06:30.304773	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
355	TXN832000	Airtel	RECHARGE	9079675870	200.0	SUCCESS	127	2025-09-19 12:23:11.994069	2025-09-19 12:23:11.994069	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
356	TXN912606	Jio	RECHARGE	9856709480	199.0	SUCCESS	127	2025-09-19 14:06:31.428042	2025-09-19 14:06:31.428042	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
357	TXN287868	Jio	RECHARGE	4353453453	100.0	SUCCESS	127	2025-09-24 07:37:18.809668	2025-09-24 07:37:18.809668	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
358	TXN996254	airtel	Recharge	9305096443	799.0	SUCCESS	127	2025-09-24 12:54:55.426881	2025-09-24 12:54:55.426881	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
359	TXN405396	tatasky	Recharge	9305096443	399.0	SUCCESS	127	2025-09-24 12:58:09.910643	2025-09-24 12:58:09.910643	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
360	TXN986772	tatasky	Recharge	9305096443	499.0	SUCCESS	127	2025-09-24 14:32:26.078191	2025-09-24 14:32:26.078191	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
361	TXN296237	tatasky	Recharge	9878796898	399.0	SUCCESS	127	2025-09-25 07:54:48.233748	2025-09-25 07:54:48.233748	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
362	TXN849464	airtel	Recharge	9305096443	299.0	SUCCESS	127	2025-09-25 08:36:54.831628	2025-09-25 08:36:54.831628	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
363	TXN440668	tatasky	Recharge	9305096443	199.0	SUCCESS	127	2025-09-25 08:38:52.016752	2025-09-25 08:38:52.016752	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
364	TXN935740	tatasky	Recharge	788078978	199.0	SUCCESS	127	2025-09-25 08:49:39.374175	2025-09-25 08:49:39.374175	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
365	TXN256178	airtel	Recharge	9305096443	199.0	SUCCESS	127	2025-09-25 08:54:52.334843	2025-09-25 08:54:52.334843	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
366	TXN501798	airtel	Recharge	9305096443	199.0	SUCCESS	127	2025-09-25 08:58:41.095111	2025-09-25 08:58:41.095111	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
367	TXN667914	343	Recharge	7658767578	150.0	SUCCESS	127	2025-09-25 09:03:30.582016	2025-09-25 09:03:30.582016	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
368	TXN608988	dish	Recharge	65757576657	299.0	SUCCESS	127	2025-09-25 09:25:40.299742	2025-09-25 09:25:40.299742	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
369	TXN185703	airtel	Recharge	7658767578	299.0	SUCCESS	127	2025-09-25 09:30:19.218521	2025-09-25 09:30:19.218521	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
370	TXN512884	dish	Recharge	9878796898	399.0	SUCCESS	127	2025-09-25 09:31:43.786601	2025-09-25 09:31:43.786601	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
371	TXN997225	dish	Recharge	435345345435	199.0	SUCCESS	127	2025-09-25 09:48:12.279033	2025-09-25 09:48:12.279033	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
372	TXN639659	dish	Recharge	34534545435	499.0	SUCCESS	127	2025-09-25 09:48:59.572063	2025-09-25 09:48:59.572063	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
373	TXN223396	tatasky	Recharge	324223432	399.0	SUCCESS	127	2025-09-25 09:49:44.976578	2025-09-25 09:49:44.976578	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
374	TXN766271	tatasky	Recharge	324223432	399.0	SUCCESS	127	2025-09-25 09:51:13.473817	2025-09-25 09:51:13.473817	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
375	TXN936250	dish	Recharge	7658767578	299.0	SUCCESS	127	2025-09-25 09:54:58.832889	2025-09-25 09:54:58.832889	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
376	TXN767632	dish	Recharge	7658767578	299.0	SUCCESS	127	2025-09-25 09:55:58.38661	2025-09-25 09:55:58.38661	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
377	TXN403896	tatasky	Recharge	65757576657	299.0	SUCCESS	127	2025-09-25 10:03:15.976385	2025-09-25 10:03:15.976385	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
378	TXN388851	tatasky	Recharge	65757576657	299.0	SUCCESS	127	2025-09-25 10:06:44.615996	2025-09-25 10:06:44.615996	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
379	TXN175747	tatasky	Recharge	7658767578	299.0	SUCCESS	127	2025-09-25 10:19:49.256391	2025-09-25 10:19:49.256391	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
380	TXN414922	tatasky	Recharge	9878796898	299.0	SUCCESS	127	2025-09-25 10:29:18.387558	2025-09-25 10:29:18.387558	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
381	TXN591762	dish	Recharge	9878796898	299.0	SUCCESS	127	2025-09-25 10:44:16.337209	2025-09-25 10:44:16.337209	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
382	TXN928532	e	Recharge	9878796898	250.0	SUCCESS	127	2025-09-25 10:46:01.726481	2025-09-25 10:46:01.726481	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
383	TXN472558	airtel	Recharge	65757576657	299.0	SUCCESS	127	2025-09-25 10:50:55.411201	2025-09-25 10:50:55.411201	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
384	TXN319865	tatasky	Recharge	9878796898	399.0	SUCCESS	127	2025-09-25 12:01:17.928764	2025-09-25 12:01:17.928764	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
385	TXN773775	tatasky	Recharge	75675675675	299.0	SUCCESS	127	2025-09-25 13:08:42.646666	2025-09-25 13:08:42.646666	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
386	TXN544221	tatasky	Recharge	9305096443	299.0	SUCCESS	127	2025-09-26 04:56:11.685618	2025-09-26 04:56:11.685618	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
387	TXN824597	airtel	Recharge	9878796898	299.0	SUCCESS	127	2025-09-26 04:58:05.379309	2025-09-26 04:58:05.379309	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
388	TXN629760	den	Recharge	7658767578	250.0	SUCCESS	127	2025-09-26 05:00:02.765609	2025-09-26 05:00:02.765609	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
389	TXN556390	Tata Sky	DTH Recharge	90900990909	1.0	SUCCESS	134	2025-09-26 06:56:02.625193	2025-09-26 06:56:02.625193	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
390	TXN518021	Airtel	Recharge	6456564564	45.0	SUCCESS	127	2025-09-26 10:53:56.946153	2025-09-26 10:53:56.946153	12	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
391	TXN684126	Jio	Recharge	4353443534	34.0	SUCCESS	127	2025-09-26 11:02:59.732322	2025-09-26 11:02:59.732322	12	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
392	TXN200574	dish	Recharge	234324	399.0	SUCCESS	127	2025-09-27 07:18:33.838204	2025-09-27 07:18:33.838204	13	Manikant	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
393	TXN770353	Airtel	Recharge	4534543534	566.0	SUCCESS	127	2025-09-27 08:55:57.893639	2025-09-27 08:55:57.893639	12	Sid	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
394	TXN229674	Delhi Water Board	Recharge	6435654645	1089.54	SUCCESS	127	2025-09-27 09:34:43.397665	2025-09-27 09:34:43.397665	6	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
395	TXN296109	Kolkata Water Board	Recharge	4353453453	1089.54	SUCCESS	127	2025-09-27 10:48:49.92605	2025-09-27 10:48:49.92605	6	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
396	TXN767449	Mumbai Water Board	Recharge	8787897896	1089.54	SUCCESS	127	2025-09-27 10:59:59.105598	2025-09-27 10:59:59.105598	6	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
397	TXN333519	Delhi Water Board	Recharge	3453454353	1089.54	SUCCESS	127	2025-09-27 14:03:24.310151	2025-09-27 14:03:24.310151	6	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
398	TXN485020	Mumbai Water Board	Recharge	5464645654	1089.54	SUCCESS	127	2025-09-29 04:55:03.208821	2025-09-29 04:55:03.208821	6	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
399	TXN768202	BSES	Recharge	9956895609	1089.54	SUCCESS	127	2025-09-29 06:08:31.361769	2025-09-29 06:08:31.361769	8	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
400	TXN949351	BSES	Recharge	5654645645	1089.54	SUCCESS	127	2025-09-29 06:18:09.81567	2025-09-29 06:18:09.81567	8	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
401	TXN347877	Bharat Gas	Recharge	4534543534	250.0	SUCCESS	127	2025-09-29 07:20:45.134093	2025-09-29 07:20:45.134093	10	John Doe	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
402	TXN713040	HP Gas	Recharge	9879889789	1.0	SUCCESS	127	2025-09-29 07:21:40.728668	2025-09-29 07:21:40.728668	10	John Doe	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
403	TXN301549	BSES	Recharge	8897879878	1089.54	SUCCESS	127	2025-09-29 08:53:21.33866	2025-09-29 08:53:21.33866	8	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
404	TXN645581	Indian Gas	Recharge	6575675675	12.0	SUCCESS	127	2025-09-29 09:02:32.495987	2025-09-29 09:02:32.495987	10	John Doe	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
405	TXN238236	airtel	Recharge	9305096443	499.0	SUCCESS	127	2025-09-29 09:34:00.678735	2025-09-29 09:34:00.678735	13	Manikant12	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
406	TXN337085	Jio	Recharge	8798697697	566.0	SUCCESS	127	2025-09-29 09:35:06.795761	2025-09-29 09:35:06.795761	12	Mohammad Aamir	\N	324	123123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
407	TXN170951	BSES	Recharge	6576575675	1089.54	SUCCESS	127	2025-09-29 13:20:24.968886	2025-09-29 13:20:24.968886	8	Sumit Kumar	\N	3215483	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
408	TXN618857	HP Gas	Recharge	6575675675	566.0	SUCCESS	127	2025-09-29 13:21:03.721546	2025-09-29 13:21:03.721546	10	John Doe	\N	GB2025001	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
409	TXN301624	Kolkata Water Board	Recharge	6767575756	1089.54	SUCCESS	127	2025-10-01 09:18:13.689198	2025-10-01 09:18:13.689198	6	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
410	TXN374205	Jio	Recharge	7658959758	11.0	SUCCESS	127	2025-10-06 08:59:15.809286	2025-10-06 08:59:15.809286	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
411	TXN754928	Airtel	Recharge	7878787987	399.0	SUCCESS	127	2025-10-08 06:35:39.674211	2025-10-08 06:35:39.674211	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
412	TXN431765	Vi	Recharge	5436758689	399.0	SUCCESS	127	2025-10-16 06:23:52.71457	2025-10-16 06:23:52.71457	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
413	TXN750067	Airtel	Recharge	5756756756	7.0	SUCCESS	127	2025-10-16 11:35:49.78606	2025-10-16 11:35:49.78606	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
414	TXN898363	N/A	Recharge	\N	300.0	SUCCESS	127	2025-10-24 06:01:17.532968	2025-10-24 06:01:17.532968	17	gfhfh	\N	\N	\N	\N	\N	fghfh	N/A	\N	\N	\N	\N	\N	\N	\N	\N
415	TXN317313	home	Recharge	6765765756756765	0.0	SUCCESS	127	2025-10-24 06:05:51.547001	2025-10-24 06:05:51.547001	14	\N	\N	\N	\N	\N	\N	\N	6576575675	\N	\N	\N	\N	\N	\N	\N	\N
416	TXN233407	N/A	Recharge	\N	1089.54	SUCCESS	127	2025-10-24 18:44:23.441545	2025-10-24 18:44:23.441545	6	Sumit Kumar	\N	\N	\N	\N	\N	\N	8758675867	\N	\N	\N	\N	\N	\N	\N	\N
417	TXN857296	N/A	Recharge	\N	1089.54	SUCCESS	127	2025-10-24 18:46:36.686578	2025-10-24 18:46:36.686578	8	Sumit Kumar	\N	3215483	\N	\N	8798789787	\N	7897878978	\N	\N	\N	\N	\N	\N	\N	\N
418	TXN274049	N/A	Recharge	\N	11.0	SUCCESS	127	2025-10-24 18:52:12.624243	2025-10-24 18:52:12.624243	10	John Doe	\N	GB2025001	\N	\N	45345	\N	6575675675	\N	\N	\N	\N	\N	\N	\N	\N
419	TXN901477	Jio	Recharge	\N	11.0	SUCCESS	127	2025-10-24 18:54:44.201979	2025-10-24 18:54:44.201979	11	\N	\N	\N	\N	\N	\N	\N	8798787897	\N	\N	\N	\N	\N	\N	\N	\N
420	TXN965052	Jio	Recharge	\N	11.0	SUCCESS	127	2025-10-24 18:59:02.745703	2025-10-24 18:59:02.745703	11	\N	\N	\N	\N	\N	\N	\N	3243543543	\N	\N	\N	\N	\N	\N	\N	\N
421	TXN714694	Jio	Recharge	\N	11.0	SUCCESS	127	2025-10-24 19:15:44.95801	2025-10-24 19:15:44.95801	11	\N	\N	\N	\N	\N	\N	\N	8789789787	\N	\N	\N	\N	\N	\N	\N	\N
422	TXN260619	Jio	Recharge	\N	600.0	SUCCESS	127	2025-10-24 19:50:52.807724	2025-10-24 19:50:52.807724	12	sdsfdsf	\N	11	435345	\N	\N	\N	6575675675	\N	\N	\N	\N	\N	\N	\N	\N
423	TXN164724	tatasky	Recharge	\N	199.0	SUCCESS	127	2025-10-24 19:51:47.686778	2025-10-24 19:51:47.686778	13	dsgdsg	\N	\N	\N	\N	\N	\N	7658767578	\N	\N	\N	\N	\N	\N	\N	\N
424	TXN224439	car	Recharge	45646	0.0	SUCCESS	127	2025-10-24 20:13:36.662069	2025-10-24 20:13:36.662069	14	\N	\N	\N	\N	\N	\N	\N	5646546546	\N	\N	\N	\N	\N	\N	\N	\N
425	TXN975491	personal	Recharge	4534	0.0	SUCCESS	127	2025-10-24 20:14:47.934203	2025-10-24 20:14:47.934203	14	\N	\N	\N	\N	\N	\N	\N	4353453453	\N	\N	\N	\N	\N	\N	\N	\N
426	TXN227508	home	Recharge	456	0.0	SUCCESS	127	2025-10-24 20:17:07.483635	2025-10-24 20:17:07.483635	14	\N	\N	\N	\N	\N	\N	\N	5464565464	\N	\N	\N	\N	\N	\N	\N	\N
427	TXN509068	N/A	Recharge	\N	300.0	SUCCESS	127	2025-10-24 20:20:37.315125	2025-10-24 20:20:37.315125	17	hhh	\N	\N	\N	\N	\N	jj	N/A	\N	\N	\N	\N	\N	\N	\N	\N
428	TXN699774	N/A	Recharge	\N	300.0	SUCCESS	127	2025-10-27 08:25:54.891563	2025-10-27 08:25:54.891563	17	dhbdh	\N	\N	\N	\N	\N	hdbhfb	N/A	\N	\N	\N	\N	\N	\N	\N	\N
429	TXN468251	N/A	Recharge	\N	300.0	SUCCESS	127	2025-10-27 08:38:10.566215	2025-10-27 08:38:10.566215	17	sid	\N	\N	\N	\N	\N	hdfc	N/A	\N	\N	\N	\N	\N	\N	\N	\N
430	TXN931782	N/A	Recharge	\N	400.0	SUCCESS	127	2025-10-27 08:40:20.89126	2025-10-27 08:40:20.89126	18	\N	\N	\N	\N	\N	\N	\N	N/A	\N	\N	\N	\N	\N	\N	\N	\N
431	TXN396682	N/A	Recharge	420	22.0	SUCCESS	127	2025-10-27 08:49:44.814573	2025-10-27 08:49:44.814573	18	sid	\N	\N	\N	\N	\N	\N	N/A	\N	\N	\N	\N	\N	\N	\N	\N
432	TXN578355	N/A	Recharge	\N	300.0	SUCCESS	127	2025-10-27 12:31:10.990648	2025-10-27 12:31:10.990648	17	pri	\N	\N	\N	\N	\N	bob	N/A	\N	\N	\N	\N	\N	\N	5467676787676876	\N
433	TXN416540	N/A	Recharge	\N	55.0	SUCCESS	127	2025-10-27 12:56:01.949276	2025-10-27 12:56:01.949276	15	\N	\N	\N	\N	\N	\N	\N	9879889789	\N	\N	\N	\N	\N	\N	\N	\N
434	TXN603200	personal	Recharge	867897689768968	0.0	SUCCESS	127	2025-10-27 13:03:11.321457	2025-10-27 13:03:11.321457	14	\N	\N	\N	\N	\N	\N	\N	8789789789	\N	\N	\N	\N	\N	\N	\N	\N
435	TXN660878	home	Recharge	68679868688	0.0	SUCCESS	127	2025-10-27 13:10:12.102205	2025-10-27 13:10:12.102205	14	\N	\N	\N	\N	\N	\N	\N	8798798798	\N	\N	\N	\N	\N	\N	\N	\N
436	TXN456382	N/A	Recharge	\N	300.0	SUCCESS	127	2025-10-27 13:44:20.926484	2025-10-27 13:44:20.926484	17	test	\N	\N	\N	\N	\N	bob	N/A	\N	\N	\N	\N	\N	\N	7987897897897897	\N
437	TXN426761	N/A	Recharge	76767678678676	250.0	SUCCESS	127	2025-10-27 13:48:13.918715	2025-10-27 13:48:13.918715	18	869987789888	\N	\N	\N	\N	\N	\N	N/A	\N	\N	\N	BAJPC4350M	\N	\N	\N	\N
438	TXN855071	car	Recharge	4353454343	0.0	SUCCESS	127	2025-10-28 07:11:45.547326	2025-10-28 07:11:45.547326	14	\N	\N	\N	\N	\N	\N	\N	4353453453	\N	\N	\N	\N	\N	\N	\N	\N
439	TXN460861	N/A	Recharge	\N	11.0	SUCCESS	127	2025-10-28 07:41:37.007725	2025-10-28 07:41:37.007725	15	\N	\N	\N	\N	\N	\N	\N	6767567567	\N	\N	\N	\N	\N	\N	\N	\N
440	TXN607785	N/A	Recharge	\N	76.0	SUCCESS	127	2025-10-28 07:48:26.572836	2025-10-28 07:48:26.572836	15	\N	\N	\N	\N	\N	\N	HDFC	7687686786	\N	\N	\N	\N	\N	\N	\N	\N
441	TXN965332	N/A	Recharge	\N	11.0	SUCCESS	127	2025-10-28 09:00:58.675737	2025-10-28 09:00:58.675737	17	dsfhvds	\N	\N	\N	\N	\N	axis	9305096443	\N	\N	\N	\N	\N	\N	8989789789787987	\N
442	TXN417756	N/A	Recharge	1234	33.0	SUCCESS	127	2025-10-28 09:49:08.025425	2025-10-28 09:49:08.025425	18	sidwa	\N	\N	\N	\N	\N	\N	N/A	\N	\N	\N	UUIHJG8987	\N	\N	\N	\N
443	TXN896749	N/A	Recharge	6767	12.0	SUCCESS	127	2025-10-28 09:55:32.223218	2025-10-28 09:55:32.223218	18	sidmalik	\N	\N	\N	\N	\N	\N	N/A	\N	\N	\N	UUIHJG8987	\N	\N	\N	\N
444	TXN551873	N/A	Recharge	\N	11.0	SUCCESS	127	2025-10-28 10:39:02.724231	2025-10-28 10:39:02.724231	17	sidwa	\N	\N	\N	\N	\N	bob	9879878789	\N	\N	\N	\N	\N	\N	8908978987897878	\N
445	TXN653937	N/A	Recharge	\N	11.0	SUCCESS	127	2025-10-28 10:45:54.445516	2025-10-28 10:45:54.445516	17	pritesh	\N	\N	\N	\N	\N	klndfgfd	9875609547	\N	\N	\N	\N	\N	\N	8789789797979700	\N
446	TXN691846	N/A	Recharge	\N	121.0	SUCCESS	127	2025-10-28 10:49:44.541537	2025-10-28 10:49:44.541537	17	likl	\N	\N	\N	\N	\N	bob	8879878978	\N	\N	\N	\N	\N	\N	7969768696988989	\N
447	TXN271950	N/A	Recharge	\N	11.0	SUCCESS	127	2025-10-28 10:58:26.805533	2025-10-28 10:58:26.805533	17	sidwa	\N	\N	\N	\N	\N	axis	7658767786	\N	\N	\N	\N	\N	\N	9879878789797979	\N
448	TXN785129	Airtel	Recharge	\N	249.0	SUCCESS	127	2025-10-28 12:02:07.79604	2025-10-28 12:02:07.79604	11	\N	\N	\N	\N	\N	\N	\N	7987896868	\N	\N	\N	\N	\N	\N	\N	\N
449	TXN133642	Airtel	Recharge	\N	6.0	SUCCESS	127	2025-10-28 12:06:09.443838	2025-10-28 12:06:09.443838	11	\N	\N	\N	\N	\N	\N	\N	8698676786	\N	\N	\N	\N	\N	\N	\N	\N
450	TXN107624	Vi	Recharge	\N	11.0	SUCCESS	127	2025-10-28 12:23:29.524357	2025-10-28 12:23:29.524357	11	\N	\N	\N	\N	\N	\N	\N	7875968758	\N	\N	\N	\N	\N	\N	\N	\N
451	TXN436947	Jio	Recharge	\N	1.0	SUCCESS	127	2025-10-28 12:35:18.135299	2025-10-28 12:35:18.135299	11	\N	\N	\N	\N	\N	\N	\N	8989898998	\N	\N	\N	\N	\N	\N	\N	\N
452	TXN165114	N/A	Recharge	23323232	11.0	SUCCESS	127	2025-10-28 13:59:51.221221	2025-10-28 13:59:51.221221	18	sidmalik	\N	\N	\N	\N	\N	\N	54654656566645	\N	\N	\N	BAJPC4350M	\N	\N	\N	\N
453	TXN775959	Jio	Recharge	\N	200.0	SUCCESS	127	2025-10-28 14:03:23.992615	2025-10-28 14:03:23.992615	11	\N	\N	\N	\N	\N	\N	\N	6456456456	\N	\N	\N	\N	\N	\N	\N	\N
454	TXN538166	Airtel	Recharge	\N	200.0	SUCCESS	127	2025-10-28 14:04:10.546982	2025-10-28 14:04:10.546982	11	\N	\N	\N	\N	\N	\N	\N	7878685685	\N	\N	\N	\N	\N	\N	\N	\N
455	TXN811654	Airtel	Recharge	\N	100.0	SUCCESS	127	2025-10-28 14:05:56.573968	2025-10-28 14:05:56.573968	11	\N	\N	\N	\N	\N	\N	\N	5676576576	\N	\N	\N	\N	\N	\N	\N	\N
456	TXN771381	N/A	Recharge	\N	77.0	SUCCESS	127	2025-11-04 10:50:01.118479	2025-11-04 10:50:01.118479	15	\N	\N	\N	\N	\N	\N	SBI	9879889789	\N	\N	\N	\N	\N	\N	\N	\N
457	TXN161070	N/A	Recharge	\N	111.0	SUCCESS	127	2025-11-04 10:51:04.016315	2025-11-04 10:51:04.016315	15	\N	\N	\N	\N	\N	\N	SBI	9834543534	\N	\N	\N	\N	\N	\N	\N	\N
469	TXN225515	home	Recharge	6796986866967676	11.0	SUCCESS	127	2025-11-06 06:00:06.672882	2025-11-06 06:00:06.672882	14	\N	\N	\N	\N	\N	\N	\N	7679689696	\N	\N	\N	\N	\N	\N	\N	\N
470	TXN449919	personal	Recharge	67867867867867	11.0	SUCCESS	127	2025-11-06 07:52:31.837262	2025-11-06 07:52:31.837262	14	\N	\N	\N	\N	\N	\N	\N	7876868686	\N	\N	\N	\N	\N	\N	\N	\N
471	3df072c6c525c6ca	jio	\N	\N	299.0	SUCCESS	233	2025-11-08 04:59:52.805701	2025-11-08 04:59:52.805701	11	\N	\N	\N	\N	\N	\N	\N	9613689900	\N	\N	\N	\N	\N	\N	\N	bihar
472	117bf5525f97f542	jio	\N	\N	299.0	SUCCESS	233	2025-11-08 05:01:14.309048	2025-11-08 05:01:14.309048	11	\N	\N	\N	\N	\N	\N	\N	9631689900	\N	\N	\N	\N	\N	\N	\N	bihar
473	TXN344170	Airtel	Recharge	\N	249.0	SUCCESS	127	2025-11-10 12:03:17.91929	2025-11-10 12:03:17.91929	11	\N	\N	\N	\N	\N	\N	\N	8678678678	\N	\N	\N	\N	\N	\N	\N	\N
474	TXN332902	N/A	Recharge	\N	33.0	SUCCESS	139	2025-11-11 05:39:56.085117	2025-11-11 05:39:56.085117	15	\N	\N	\N	\N	\N	\N	HDFC	8754387534	\N	\N	\N	\N	\N	\N	\N	\N
475	TXN945730	Jio	Recharge	\N	199.0	SUCCESS	127	2025-11-12 06:36:08.865976	2025-11-12 06:36:08.865976	11	\N	\N	\N	\N	\N	\N	\N	8787897979	\N	\N	\N	\N	\N	\N	\N	\N
476	TXN408504	Airtel	Recharge	\N	96.0	SUCCESS	127	2025-11-12 10:59:56.52366	2025-11-12 10:59:56.52366	11	\N	\N	\N	\N	\N	\N	\N	8787897878	\N	\N	\N	\N	\N	\N	\N	\N
477	TXN849663	BSNL	Recharge	\N	12.0	SUCCESS	127	2025-11-12 11:00:39.713298	2025-11-12 11:00:39.713298	11	\N	\N	\N	\N	\N	\N	\N	7867876867	\N	\N	\N	\N	\N	\N	\N	\N
478	TXN174829	Jio	Recharge	\N	12.0	SUCCESS	127	2025-11-12 11:01:33.588223	2025-11-12 11:01:33.588223	12	sdsfdsf	\N	1111	65765756765	\N	\N	\N	9879889789	\N	\N	\N	\N	\N	\N	\N	\N
479	TXN362662	Airtel	Recharge	\N	656.0	SUCCESS	127	2025-11-12 11:02:04.074983	2025-11-12 11:02:04.074983	12	wd	\N	121	435345	\N	\N	\N	9879889789	\N	\N	\N	\N	\N	\N	\N	\N
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
55	136	104	12	2025-10-29 09:51:12.779138	2025-10-29 09:51:12.779138
56	136	104	2	2025-10-29 09:51:12.790613	2025-10-29 09:51:12.790613
57	136	104	13	2025-10-29 09:51:12.797809	2025-10-29 09:51:12.797809
58	136	104	14	2025-10-29 09:51:12.805512	2025-10-29 09:51:12.805512
59	136	104	8	2025-10-29 09:51:12.812467	2025-10-29 09:51:12.812467
60	136	104	7	2025-10-29 09:51:12.819839	2025-10-29 09:51:12.819839
61	136	104	1	2025-10-29 09:51:12.82694	2025-10-29 09:51:12.82694
62	136	104	4	2025-10-29 09:51:12.833687	2025-10-29 09:51:12.833687
63	136	104	15	2025-10-29 09:51:12.840656	2025-10-29 09:51:12.840656
64	104	222	12	2025-10-29 09:52:24.267332	2025-10-29 09:52:24.267332
65	104	222	2	2025-10-29 09:52:24.277156	2025-10-29 09:52:24.277156
66	104	222	13	2025-10-29 09:52:24.28638	2025-10-29 09:52:24.28638
67	104	222	14	2025-10-29 09:52:24.296195	2025-10-29 09:52:24.296195
68	104	222	8	2025-10-29 09:52:24.305329	2025-10-29 09:52:24.305329
69	104	222	7	2025-10-29 09:52:24.314914	2025-10-29 09:52:24.314914
70	104	222	1	2025-10-29 09:52:24.324017	2025-10-29 09:52:24.324017
71	104	222	4	2025-10-29 09:52:24.333572	2025-10-29 09:52:24.333572
72	104	223	12	2025-10-29 11:01:14.970861	2025-10-29 11:01:14.970861
73	104	223	13	2025-10-29 11:01:14.982089	2025-10-29 11:01:14.982089
74	104	223	14	2025-10-29 11:01:14.993397	2025-10-29 11:01:14.993397
75	104	223	7	2025-10-29 11:01:15.008287	2025-10-29 11:01:15.008287
77	104	230	2	2025-11-01 04:46:10.559007	2025-11-01 04:46:10.559007
78	104	230	13	2025-11-01 04:46:10.569673	2025-11-01 04:46:10.569673
81	104	230	7	2025-11-01 04:46:10.600977	2025-11-01 04:46:10.600977
82	104	230	1	2025-11-01 04:46:10.611626	2025-11-01 04:46:10.611626
83	104	230	4	2025-11-01 04:46:10.621656	2025-11-01 04:46:10.621656
84	104	230	15	2025-11-01 04:46:10.631704	2025-11-01 04:46:10.631704
85	104	232	2	2025-11-01 05:07:14.694878	2025-11-01 05:07:14.694878
86	104	232	13	2025-11-01 05:07:14.707563	2025-11-01 05:07:14.707563
88	104	232	7	2025-11-01 05:07:14.733047	2025-11-01 05:07:14.733047
89	104	232	1	2025-11-01 05:07:14.745212	2025-11-01 05:07:14.745212
90	104	232	4	2025-11-01 05:07:14.75725	2025-11-01 05:07:14.75725
91	104	232	15	2025-11-01 05:07:14.769463	2025-11-01 05:07:14.769463
92	104	232	12	2025-11-01 05:09:00.532317	2025-11-01 05:09:00.532317
93	104	232	14	2025-11-01 05:09:00.542955	2025-11-01 05:09:00.542955
99	104	236	8	2025-11-11 10:29:00.496871	2025-11-11 10:29:00.496871
100	104	236	7	2025-11-11 10:29:00.50766	2025-11-11 10:29:00.50766
101	104	236	1	2025-11-11 10:29:00.517692	2025-11-11 10:29:00.517692
102	104	236	4	2025-11-11 10:29:00.527595	2025-11-11 10:29:00.527595
103	104	236	15	2025-11-11 10:29:00.54739	2025-11-11 10:29:00.54739
104	236	237	8	2025-11-11 11:55:34.284487	2025-11-11 11:55:34.284487
105	236	237	7	2025-11-11 11:55:34.29504	2025-11-11 11:55:34.29504
106	236	237	1	2025-11-11 11:55:34.305107	2025-11-11 11:55:34.305107
107	236	237	4	2025-11-11 11:55:34.31553	2025-11-11 11:55:34.31553
108	236	237	15	2025-11-11 11:55:34.325777	2025-11-11 11:55:34.325777
109	103	238	8	2025-11-11 11:58:44.652865	2025-11-11 11:58:44.652865
110	103	238	7	2025-11-11 11:58:44.664028	2025-11-11 11:58:44.664028
111	103	238	1	2025-11-11 11:58:44.675383	2025-11-11 11:58:44.675383
112	103	238	4	2025-11-11 11:58:44.686223	2025-11-11 11:58:44.686223
113	103	238	15	2025-11-11 11:58:44.696722	2025-11-11 11:58:44.696722
114	237	239	7	2025-11-11 12:00:53.327557	2025-11-11 12:00:53.327557
115	237	239	1	2025-11-11 12:00:53.337986	2025-11-11 12:00:53.337986
116	237	239	4	2025-11-11 12:00:53.348718	2025-11-11 12:00:53.348718
117	237	239	15	2025-11-11 12:00:53.358974	2025-11-11 12:00:53.358974
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, first_name, last_name, email, password_digest, role, otp, verify_otp, otp_expires_at, phone_number, country_code, alternative_number, aadhaar_number, pan_card, date_of_birth, gender, business_name, business_owner_type, business_nature_type, business_registration_number, gst_number, pan_number, address, city, state, pincode, landmark, username, scheme, referred_by, bank_name, account_number, ifsc_code, account_holder_name, notes, session_token, created_at, updated_at, role_id, status, company_type, company_name, cin_number, registration_certificate, user_admin_id, confirm_password, domain_name, scheme_id, service_id, pan_card_image, aadhaar_image, passport_photo, store_shop_photo, address_proof_photo, parent_id, set_pin, confirm_pin, latitude, longitude, captured_at, last_seen_at, ip_address, location, kyc_status, kyc_method, aadhaar_front_image, aadhaar_back_image, aadhaar_otp, pan_otp, pan_status, aadhaar_status, image, kyc_verifications, kyc_verified_at, kyc_data, email_otp, email_otp_sent_at, set_mpin, confirm_mpin, status_mpin, status_pin, email_otp_status, email_otp_verified_at, set_pin_status) FROM stdin;
114	Ishu	Dhariya	ishuadmin@gmail.com	$2a$12$T/n5QlXtlBYeDotJWBdBJOVk/ijEce5jj291F/HcLEmZNhSg7kcaq	\N	\N	\N	\N	89798798783	\N	03443434334	876876876867233	JKGJGHJ688978	2025-09-04		Credit card sales	Credit Business slove	buessiness s Nature Type	Credit Business Registration Number	986857644645cddsds	\N		noida	Uttar Pradesh	201301	\N	ishu8789	\N	HGG7897897	Axis	7988757678hgg	IFDD&775655	Retailers	\N	\N	2025-09-01 08:41:59.561116	2025-09-02 06:17:34.681616	9	f	\N	\N	\N	\N	\N	ishu4748	ishu123	5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
112	Last check Amdin	done	check@gmail.com	$2a$12$Bjh7riJIdvYTdz/sw92mCeOzCLSuKbpPJQiXJ6ORd5quezZJRN.He	\N	\N	\N	\N	79879779887987	\N	8979878798798798798	876876876867233	JKGJGHJ688978	2025-08-23	Male	lkjljkjlkjlkjlkj	lkjljkjlkjlkjlkj	lkjljkjlkjlkjlkj	lkjljkjlkjlkjlkj	76867687	\N	noida 121	noida	Uttar Pradesh	201301	\N	sidtech78678	\N	HGG7897897	Axis	7988757678hgg	IFDD96875	Sidddddddd	\N	\N	2025-08-30 12:36:49.720661	2025-09-02 06:17:35.187671	9	t	\N	\N	\N	\N	\N	123456	sam	5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
113	Alim Admin3	Khan	Alimadmin@gmail.com	$2a$12$On5F4IEhPEr.PL6Fm4RTxeKFE7fv1E4dgf2.RVhBKr0fEUJWBwY4K	\N	\N	\N	\N	8908099089898	\N	+919568773855	9867676757656	JKGJGHJ68768	2025-08-21		IT LOAN SOULTION	IT BUSINES LOAN SOLUTION	Business Nature Type	989878967678dsds	986857644645cddsds	\N		noida	Uttar Pradesh	201301	\N	Amir323	\N	123223	HDFC	687687676776876	IFDD96875	Alim Admin	\N	\N	2025-08-30 13:17:19.343681	2025-09-02 06:17:33.411207	9	f	\N	\N	\N	\N	\N	232323	aalimadmin	5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
120	tetdsh	jdshdkhj	jkhjds9876876@gmai.com	$2a$12$xMdDNNMXc3SVwoTbqcVFEelMsXolKH0AF/w32okDTm7EYbyQg0guW	\N	\N	\N	\N	03443434334	\N	03443434334	9867676757656	JKGJGHJ688978	2025-09-01	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd	986857644645cddsds	\N	noida 121	noida	Uttar Pradesh	201301	\N	aaisihi	\N						\N	\N	2025-09-02 09:12:04.737004	2025-09-02 09:12:04.737004	9	f	\N	\N	\N	\N	\N		namesing	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
106	Saurav	\N	saurav@gmailcom	$2a$12$wIM6HuqbUxTEFYaLY9KFgOplYERTByO98kLvtapktuQFH8NoTXvgm	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-08-30 06:01:17.85221	2025-09-02 06:17:35.696542	9	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
107	dsds	\N	sam@gmail.com	$2a$12$Hv.Ohx3z53IyUtDSxDAqk.TyvwDRegxSf65iMOtMTCTWBI2hT4cvO	\N	\N	\N	\N	+919568773855	\N	\N	98798798798687	\N	\N	\N	\N	\N	\N	\N	4343	HJHJK87797J	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-08-30 06:36:54.886138	2025-09-02 06:17:35.951099	9	f	\N	fdd	\N	dfdss	0	123	sam	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
116	Siddharth admin	gautam	sid20319@gmail.com	$2a$12$oipaiZHpfbOVAw21Vbx0CuiLKB.Jr2Dao1PT5hO8mQ8sUxGbG2kcy	\N	\N	\N	\N	+919568773855	\N	03443434334	98798798798687	JKGJGHJ688978	\N	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd	986857644645cddsds	\N	noida 121	noida	Uttar Pradesh	201301	\N	sidtech78678	\N	HGG7897897					\N	\N	2025-09-02 06:57:13.265005	2025-09-02 06:57:13.265005	9	f	\N	\N	\N	\N	\N	123456	sidadmin	5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
119	alminadmin	admin	lkjkljds@gmail.com	$2a$12$vWexdLFBSIC0IQHkUQV/Eez5mK4.Mih0h9vhPrynLAm4RMa/IVbb.	\N	\N	\N	\N	90990988433	\N	03443434334	7328728367	JKGJGHJ68768	2025-09-01	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd	986857644645cddsds	\N	noida 121	noida	Uttar Pradesh	201301	\N	siddharth343443	\N	HGG7897897	Axis	687687676776876	IFDD&775655		\N	\N	2025-09-02 07:38:16.83295	2025-09-02 07:39:10.796858	5	f	\N	\N	\N	\N	\N	123456	LK	5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
121	dds	dsds	ddsds@gmail.com	\N	\N	\N	\N	\N	9879798787798	\N	33232323232443	9867676757656	JKGJGHJ688978	2025-09-01	Male						\N					\N								\N	\N	2025-09-02 09:16:50.279226	2025-09-02 09:16:50.279226	6	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
117	tetdsh admin	jdshdkhj	hjkhdkjshs@gmai.com	$2a$12$CTes.77NLRMBi14MAOTzpO7xjXKzM/koG9FrjrA2noQnEgGqLCovC	\N	\N	\N	\N	03443434334	\N	+919568773855	9867676757656	dskjds	2025-10-04	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd	986857644645cddsds	\N	noida 121	noida	Uttar Pradesh	201301	\N	siddharth23232	\N		Axis	7988757678hgg	IFDD96875		\N	528bfc6ca23e1aec5b80e7ee858a5cb02bf3e74c	2025-09-02 07:00:17.967209	2025-09-02 07:39:52.558184	9	t	\N	\N	\N	\N	\N	123456	LK	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
64	Siddharth	gautam	sid203191@gmail.com	$2a$12$LqHXjK1ApiWq3Hdtiz3mxuMPapt7f27NScf4vRz1eQTSPpPgtoV/a	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-08-27 06:06:23.479823	2025-09-02 06:17:34.174339	6	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
123	Ashok kumar	sing	ashok@gmail.com	$2a$12$6Bufd22R0bN7CqzzJvsSceaKNWhFmEWcBN.EPGtc.UuHh58VotZuK	\N	\N	\N	\N	7897879879	\N	98797987979	876876876867233	JKGJGHJ688978	2025-09-01	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd	986857644645cddsds	\N	Noida, Uttar Pradesh, India	Noida	Uttar Pradesh	ds233232	\N	ashok79798	paid	HGG7897897	Axis	7988757678hgg	IFDD96875	Ashok	\N	\N	2025-09-02 09:21:22.367274	2025-09-02 09:21:22.367274	5	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
124	dsds	dsds	dsds1111@gmail.com	$2a$12$I7eTYPo.Ih4CecQlup87LewDGANadhCEDdUo2.eAKu/C9OmdGmE12	\N	\N	\N	\N	dsds	\N	dsds	dsds	dsds	\N	Select gender	dddfdffd	dddfdffd	dddfdffd	dddfdffd		\N	noida 121	noida	Uttar Pradesh	201301	\N	sidtech78678							\N	\N	2025-09-02 09:23:42.407569	2025-09-02 09:23:42.407569	5	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
126	don11	kumar	don11@gmail.com	$2a$12$GLHjSzVQr78G0W9erfWnzesHakQN4bSMj3HwMyOQvwkopolO1xpNS	\N	\N	\N	\N	876876876786	\N	03443434334	986767675765622	JKGJGHJ688978	2025-09-01	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd		\N	noida 121	noida	Uttar Pradesh	201301	\N	don11	\N		Axis	7988757678hgg	IFDD&775655	don11	\N	\N	2025-09-02 09:33:16.802674	2025-09-02 09:33:16.802674	9	f	\N	\N	\N	\N	\N	123456		5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
125	tetdsh	jdshdkhj	hjkhdkjshs@gmai.com	$2a$12$Pmx8LzTfUgrLFuvjmMugO.BDDK11lPhWZl85hHztxVBgEUaQroU4C	\N	\N	\N	\N	03443434334	\N	+919568773855		JKGJGHJ68768	\N	Female						\N					\N		\N		Axis	7988757678hgg	IFDD&775655		\N	\N	2025-09-02 09:26:06.988697	2025-09-02 09:26:06.988697	9	f	\N	\N	\N	\N	\N			\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
118	Siddharth	gautam	sidtest@gmail.com	$2a$12$bScG9DTUcClpOFLZQsW4rulxWA5d1Fpr7VysITYFhasLWn5qV/5nS	\N	\N	\N	\N	+919568773855	\N	+919568773855	9867676757656	JKGJGHJ68768	\N	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd	986857644645cddsds	\N	Gawalira	Saharanpur	Uttar Pradesh	247001	\N		\N						\N	47473b45a624cbf222a2f9a0dac6877bc37326f6	2025-09-02 07:20:02.690017	2025-09-04 06:17:17.446234	5	t	\N	\N	\N	\N	\N	123456	amdin788	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
128	Deepak	Kumar	deepak@gmail.com	$2a$12$Y2XkV2FZJtmtIP7yaWTI2.8ew.bgSdhtd6BsYc.CAgepA9xhro9Ni	\N	\N	\N	\N	897988798743	\N	89798879872	897988798712	JKGJGHJ68768DD	2025-09-01	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd		\N	Noida, Uttar Pradesh, India	Noida	Uttar Pradesh	ds233232	\N	deepak989	paid	HGG7897897	\N	\N	\N	\N		ed55c486a63ceb93078fe6db507c241a1613898e	2025-09-02 11:37:19.658725	2025-09-02 11:42:17.407239	5	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
104	admin1	\N	admin@gmail.com	$2a$12$/T94tRAECVmn.0TW43ossuDCsea86xRm9ju56XdC9A6cQQ3In2c7W	\N	\N	\N	\N	94434349494	\N	11123232			\N				\N			\N		\N	\N		\N	admin225	\N	\N			\N		\N	\N	2025-08-29 16:09:27.246126	2025-11-11 10:27:22.814504	9	f	\N	\N	\N	\N	\N	\N	\N	5	\N	\N	\N	\N	\N	\N	136	123456	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
145	\N	\N	\N	\N	\N	123456	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	49061650505ad25c4e947f922678b4e5	2025-09-19 06:57:28.114985	2025-10-17 07:31:46.694847	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	1234	\N	t	f	f	\N	f
63	Siddharth	gautam	sid20319@gmail.com	$2a$12$JO8REGKj60NcWybSym0soe/g4XTaretunZjlatQtzicy5OgcnnoUi	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-08-27 05:58:33.297504	2025-10-07 12:27:18.115682	5	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	707450	2025-10-07 12:27:18.115055	\N	\N	f	f	f	\N	f
122	Siddharth	gautam	sid20319@gmail.com	\N	\N	\N	\N	\N	+919568773855	\N	03443434334			\N	Select gender						\N					\N								\N	\N	2025-09-02 09:17:38.186319	2025-10-07 12:28:07.753059	5	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	481651	2025-10-07 12:28:07.752491	\N	\N	f	f	f	\N	f
181	\N	\N	\N	\N	\N	\N	1	\N	9665588888	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	259e7596f20dbb9caf642646d96e4ce1	2025-09-30 11:59:09.725177	2025-10-16 11:16:13.967758	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	123456	\N	t	f	f	\N	f
136	super admin	ssk	superadmin@gmail.com	$2a$12$WE4ZNE8X92ge2z9tKLv5ZuY9rZWfMKJc59EV5zMrPmzxQjGS9Nimi	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-04 07:52:52.668874	2025-11-04 12:42:59.926163	10	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	123456	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
129	mona	singh4	mona@gmail.com	$2a$12$GjElBj/SIW.avp5470ajG.lV6BnFnlY3TQ7s7MkoO6hIVWghO2pda	\N	\N	\N	\N		\N	65656565655	9877987877787	JKGJGHJ68768	2025-09-02	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd		\N	noida 121	noida	Uttar Pradesh	201301	\N	mona7768798	paid	HGG7897897	Axis	7988757678hgg	IFDD&775655	Alim	\N	1b057f28b4e935c66ab752e3839c07afa468158e	2025-09-02 11:43:35.893844	2025-09-02 11:44:42.105716	5	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
142	shek khan	Retailer	shekkhan@gmail.com	$2a$12$2nrtTrbL1IIh8t/wGGEP1egNqMkPL/4/EARaLsOdF0z/V0Dmr3yeS	\N	\N	\N	\N	+919568773855	\N	+919568773855	7328728367	JKGJGHJ688978	2025-09-03	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd		\N	noida 121	noida	Uttar Pradesh	201301	\N	shekkhan123	\N		Axis	7988757678hgg			\N	14acdc9b6da431369b865cb50874268cb315a0fb	2025-09-04 18:41:03.59699	2025-09-04 18:42:56.490229	5	t	\N	\N	\N	\N	\N	123456	\N	5	\N	\N	\N	\N	\N	\N	141	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
138	Mohammad Admin	8989898989	mohammad@gmail.com	$2a$12$4jWbmFwYnqIlkWx8QC9vLuPPEmNT.UaBis5VRhtMdUAx8tHcIrQ4u	\N	\N	\N	\N	787987987988	\N	89798787783	7788978798334	JKGJGHJ68768DD	2025-09-03	Male	Credit card sales	Credit Business slove	Credit Business Nature Type	Credit Business Registration Number	798797d87ds797ds987987	\N	noida 121	noida	Uttar Pradesh	201301	\N	mohd28982	\N	HGG789789778	Axis	687687676776876	IFDD&775655	mohd787	\N	\N	2025-09-04 08:45:42.495292	2025-09-12 12:09:43.049315	9	f	\N	\N	\N	\N	\N	mohd123	mohdshek	5	\N	\N	\N	\N	\N	\N	136	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
140	admin2	gautam	admin2@gmail.com	$2a$12$9WcYcbPvfwTR8r4ns5Fi7eQQ6LnaCIUZkiUj9vQAycYH.Pv8TvD9.	\N	\N	\N	\N	89898808888	\N	89898808888	9867676757656	JKGJGHJ688978	\N	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd		\N	noida 121	noida	Uttar Pradesh	201301	\N	sidtech78678	\N		Axis				\N	\N	2025-09-04 18:29:32.002565	2025-09-04 18:29:32.002565	9	f	\N	\N	\N	\N	\N	123456		5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
147	\N	\N	\N	\N	\N	\N	1	\N	123456	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6ePqqfFnT29yH3G51Dp315mk	2025-09-19 07:09:44.153081	2025-09-19 07:14:34.989503	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
146	\N	\N	\N	\N	\N	123456	0	\N	98797979798	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-19 07:04:43.110042	2025-09-19 07:18:30.274639	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
162	\N	\N	\N	\N	\N	123456	0	\N	778306530555	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	rRkg6eaSi4eFEiYQY3cZby7D	2025-09-22 06:02:52.052293	2025-09-22 06:02:52.057724	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
169	\N	\N	\N	\N	\N	\N	1	\N	5568885555	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	MwNgpmNUP1LFaVKxScmkPP42	2025-09-29 07:37:51.957179	2025-09-29 07:38:01.411199	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
150	\N	\N	\N	\N	\N	\N	\N	\N	9631689907	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	BapCqdznkiGpX5mtkM3Suydo	2025-09-21 05:37:48.703763	2025-09-21 05:37:48.703763	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
157	\N	\N	\N	\N	\N	123456	0	\N	3456	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	QsfAZMThdE3zoNFuArY32YSj	2025-09-22 03:35:02.146	2025-09-22 03:35:02.152641	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
158	\N	\N	\N	\N	\N	123456	0	\N	3456876587	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	RNcCXvK8fqP6mANduA6HHePb	2025-09-22 03:36:03.135809	2025-09-22 03:36:03.141727	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
163	\N	\N	\N	\N	\N	\N	\N	\N	9264104704	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	yFAH2o6oK4kvAXhVsMQ91mUj	2025-09-22 06:14:26.58257	2025-09-22 06:14:26.58257	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
165	\N	\N	\N	\N	\N	\N	1	\N	9631689990	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	d2PGsApuHrEYbdkRiuDYKeSQ	2025-09-22 09:31:04.757135	2025-09-22 09:32:04.975122	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
151	\N	\N	\N	\N	\N	123456	0	\N	32546547	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Fnsan1y7CLE4TEhaRuqGp7WA	2025-09-22 03:26:04.895097	2025-09-22 03:26:04.901255	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
152	\N	\N	\N	\N	\N	123456	0	\N	3254	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	MM5benTVk4oYnn69spzPeWHG	2025-09-22 03:26:15.822324	2025-09-22 03:26:15.830586	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
153	\N	\N	\N	\N	\N	123456	0	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	RodKSN7Bc2kYPEmEfPwjqGb8	2025-09-22 03:26:31.391827	2025-09-22 03:26:31.397536	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
154	\N	\N	\N	\N	\N	123456	0	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	oojTijJAJwWZ3aqi9ibE8LHK	2025-09-22 03:26:49.591236	2025-09-22 03:26:49.597866	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
155	\N	\N	\N	\N	\N	123456	0	\N	7	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	PFS99UGPSWGTAU95BYSpYR3d	2025-09-22 03:27:09.627736	2025-09-22 03:27:09.633614	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
159	\N	\N	\N	\N	\N	\N	\N	\N	7583065335	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	vMgAVuxj1iUAjX4WZgaU8nNx	2025-09-22 03:41:58.909475	2025-09-22 03:41:58.909475	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
160	\N	\N	\N	\N	\N	\N	1	\N	7783065305	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	rPiHPrBRe5afsWti24F1g5JC	2025-09-22 03:44:03.283245	2025-09-22 08:55:01.877339	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
167	\N	\N	\N	\N	\N	\N	1	\N	9631558988	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2Shoi2xVajkE2Ddje3X6hSAB	2025-09-22 12:15:02.169332	2025-09-22 12:15:18.716458	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
127	jon11	wim	jon11@gmail.com	$2a$12$0phmUcO74blvebm2ZoJcCO4y2lEjift9L1DLEK5n.bch1wWF/sM5y	\N	\N	\N	\N	323243434343	\N	03443434334	876876876867233	JKGJGHJ688978	2025-09-01		dddfdffd	dddfdffd	dddfdffd	dddfdffd	986857644645cddsds	\N		noida	Uttar Pradesh	201301	\N	lastadmin223	\N						\N	4c6e2c8d9b8d755b91963b1c00b115f018df1d9b	2025-09-02 09:38:43.044029	2025-11-11 13:24:30.582723	5	t	\N	\N	\N	\N	\N	123456	late22	16	\N	\N	\N	\N	\N	\N	104	123456	123456	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	2025-10-30 07:14:58.921056	\N	\N	t	f	t	2025-11-11 13:24:30.582176	f
156	\N	\N	\N	\N	\N	\N	1	\N	7783065335	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	SEkRMFmVkLyZhavT4KwwwVXv	2025-09-22 03:27:38.54738	2025-09-22 03:43:34.220695	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
166	\N	\N	\N	\N	\N	\N	1	\N	9631689956	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	4cKGUdMW9witFnWsj1adYeES	2025-09-22 09:42:00.60404	2025-09-22 09:42:31.937739	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
161	\N	\N	\N	\N	\N	123456	0	\N	8999898988	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	gyd79buYdFvwGshmMxPJfcvx	2025-09-22 05:35:11.621726	2025-09-22 05:35:11.629491	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
170	\N	\N	\N	\N	\N	\N	1	\N	9663565555	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	EgN1wasfRKRrGcWGB7k5bnAy	2025-09-29 07:54:42.483145	2025-09-29 07:54:51.771984	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
168	\N	\N	\N	\N	\N	\N	1	\N	9632665566	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	jr1YDETr4xiKYMrsKEz64kot	2025-09-29 07:27:30.648055	2025-09-29 07:27:43.257024	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
171	\N	\N	\N	\N	\N	\N	1	\N	6586656655	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	AFPP32BKXxR3NcknYVYNReDn	2025-09-29 11:38:52.133494	2025-09-29 11:38:58.489971	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
164	\N	\N	\N	\N	\N	123456	0	\N	12	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	PLiwRqhs686tvZg534pJA1Xs	2025-09-22 09:20:08.711795	2025-09-22 09:20:08.717368	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
172	\N	\N	\N	\N	\N	\N	1	\N	2559589889	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	P6yXbHTvCELTt4nviqQgFhZ6	2025-09-29 11:39:56.443935	2025-09-29 11:40:04.312177	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
134	Siddharth	gautam	sid20312229@gmail.com	$2a$12$lrXflu..qyuzpcCmyJ.QeuOyWbRfzWaZ4mW6a4nJ6GDK705C8smum	\N	364891	0	\N	9568773855	\N				\N	Select gender	dddfdffd	dddfdffd	dddfdffd	dddfdffd		\N	noida 121	noida	Uttar Pradesh	201301	\N	siddharth	\N		HDFC				\N	390412e89527c9d6bffb28d16702fb15bdafa859	2025-09-02 11:52:46.12845	2025-10-29 05:09:14.814063	5	t	\N	\N	\N	\N	\N	123456		16	\N	\N	\N	\N	\N	\N	104	123456	123456	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
173	\N	\N	\N	\N	\N	\N	1	\N	2566666666	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	DXgz6JKAYvZhrQyiB5ZQBEzg	2025-09-30 09:03:48.057315	2025-09-30 09:03:56.964492	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
175	\N	\N	\N	\N	\N	\N	1	\N	9631698800	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	rChNzCYfHecoURyaHkPyjt9d	2025-09-30 09:55:46.158052	2025-09-30 09:55:53.192034	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
174	\N	\N	\N	\N	\N	\N	1	\N	9635688888	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	18TUccrUzftNyAtZvgzyXWaR	2025-09-30 09:50:12.619525	2025-09-30 09:50:20.432679	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
176	\N	\N	\N	\N	\N	\N	1	\N	5556656666	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	kGkTmWyuRtTKxAdHGiTJ6qVi	2025-09-30 10:59:25.418873	2025-09-30 10:59:32.931821	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
177	\N	\N	\N	\N	\N	\N	1	\N	5856658658	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N6SWCZo5Y4cZHVv96pe6y5aV	2025-09-30 11:11:11.104831	2025-09-30 11:11:17.01645	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
178	\N	\N	\N	\N	\N	\N	1	\N	9631689985	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Mg5NV8q7j47yiuzjxBU3jZfj	2025-09-30 11:29:01.221127	2025-09-30 11:29:07.440629	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
179	\N	\N	\N	\N	\N	\N	1	\N	9631689988	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	JznQaKaJJxAHrTqwWBvcN8ye	2025-09-30 11:34:43.619815	2025-09-30 11:34:50.710094	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
180	\N	\N	\N	\N	\N	\N	1	\N	5666889586	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	vL5WfAcSuv3zxpixzLHhRunP	2025-09-30 11:52:19.936076	2025-09-30 11:52:38.143133	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
182	\N	\N	\N	\N	\N	\N	1	\N	5665666599	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	xKqwX9KoJT9zhgxv4uCPP4q2	2025-09-30 12:01:48.350381	2025-09-30 12:01:55.046253	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
183	\N	\N	\N	\N	\N	\N	1	\N	6588955658	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	AQSMEYrP5xWMd3cQweKK2DWS	2025-09-30 12:35:21.830254	2025-09-30 12:35:29.194849	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
184	\N	\N	\N	\N	\N	\N	1	\N	9658888888	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	p9xQ47Vgx3iFfC41SpcjPoCn	2025-09-30 12:56:46.364403	2025-09-30 12:56:55.127584	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
186	\N	\N	\N	\N	\N	\N	1	\N	9631688998	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	MF8tLwygsdTywVRzNTZmbHSZ	2025-10-01 05:14:51.466093	2025-10-01 05:15:02.406837	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
149	raushsn kimat	\N	raushan@gmail.com	\N	\N	\N	1	\N	9631689900	\N	\N	549350654722	\N	2003-01-01	male	\N	\N	\N	\N	24425454	\N	dhhchhj	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	QH7fBzm1UjuSFH6dzy3pKKa2	2025-09-20 06:08:30.317063	2025-10-10 05:36:25.325026	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	verified	\N	\N	\N	\N	\N	not_started	not_started	\N	t	2025-10-01 05:17:01.285208	{"dob": "1990-05-10", "name": "Rahul Sharma", "gender": "M", "address": "123, MG Road, Delhi", "aadhaar_last4": "4722"}	\N	\N	\N	\N	f	f	f	\N	f
199	\N	\N	\N	\N	\N	\N	1	\N	9631689555	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8eW4RKVvQ3N5P5jQEaGcgLsr	2025-10-02 06:01:33.97907	2025-10-02 06:01:42.67259	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
188	\N	\N	\N	\N	\N	\N	1	\N	9880878787	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	UTiRmENG4f2J6mi8MLbH9JVa	2025-10-01 06:57:36.456443	2025-10-01 07:08:18.362582	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
185	\N	\N	\N	\N	\N	\N	1	\N	9335555565	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	KrRBExqHa8tQBavBoF1GU3KR	2025-10-01 05:01:33.930579	2025-10-01 05:01:41.355307	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
187	\N	\N	\N	\N	\N	\N	1	\N	6201029702	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	4xpKVUEkt8dBcgRktb5Mdi2k	2025-10-01 05:35:32.03695	2025-10-01 05:35:53.660301	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
115	Siddharth	gautam	sid20319@gmail.com	$2a$12$vgdMQ.nVQ3v5Opf7PO.MKe9Ir9F2vKLvWk/.u.hW7jw6OPDEyl8xm	\N	\N	\N	\N	+919568773855	\N	+919568773855	876876876867233	JKGJGHJ68768	2025-09-05	Select gender						\N					\N								\N	\N	2025-09-01 12:11:36.6599	2025-10-07 12:05:35.54525	5	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
192	\N	\N	\N	\N	\N	\N	1	\N	6268075961	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	g2CgrpxZEa86RSRgtThTGD8R	2025-10-01 07:50:56.413796	2025-10-01 07:51:00.801109	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
193	\N	\N	\N	\N	\N	\N	1	\N	9631688898	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	HhnDTUdwUCHS98NjvEGzFbdw	2025-10-01 10:01:36.168084	2025-10-01 10:01:45.21556	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
190	\N	\N	\N	\N	\N	\N	1	\N	9631689898	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	sspDfqPShgZJYXBYAb9HxBMv	2025-10-01 07:31:33.95299	2025-10-01 07:31:43.675866	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
212	test email	jdshdkhj	aleemdglyf@gmail.com	$2a$12$khLg9tQHteHHJhXqFHEwF.Rb1cd31L4gsQcigMg2gb5iDLtw68lni	\N	\N	\N	\N	03443434334	\N	03443434334			\N	Select gender	dddfdffd	dddfdffd	dddfdffd	dddfdffd		\N	noida 121	noida	Uttar Pradesh	201301	\N	aleem test			Axis	7988757678hgg			\N	fbf36b6e8402bfc08c34b1de0f23a438f6cbc19d	2025-10-11 07:06:29.076662	2025-10-16 06:52:44.873722	5	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	111111	111111	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	105398	\N	\N	\N	f	f	f	2025-10-16 07:02:44.872913	f
191	\N	\N	\N	\N	\N	\N	1	\N	6268075916	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	ugTLgCGVKkc9HmZ3ihJeMfh5	2025-10-01 07:49:10.28745	2025-10-01 08:04:16.622021	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
201	\N	\N	\N	\N	\N	\N	1	\N	9632658688	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	TKGHQNd5bUXBpV1Qwoj7tQLY	2025-10-02 08:38:21.33048	2025-10-02 08:38:28.059156	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
207	Guest User	\N	sonam.gsmartindia@gmail.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9b3a07e2539423a9ba8acf9021b70ffe	2025-10-07 12:42:39.727573	2025-10-07 12:43:00.176369	5	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
237	Dealer	Singh	dealer@gmail.com	$2a$12$jKcBO9fcGRS/sDn5AdAR7.NCpiF7Q.8Yc1o27LIVtoR0UBf4eA7Gi	\N	\N	\N	\N	98798789787	\N	98889787878	979897987987879	CTHHJ8767868	2025-11-10	Male	Business Name	Business Ownership Type	Up	Business Registration Number		\N	Noida	Up		201301	\N		\N						\N	iWYvXY1UaRc4AAmNZbSsAHXc	2025-11-11 11:55:34.268785	2025-11-11 11:59:07.673935	7	f	\N	\N	\N	\N	\N	123456		16	\N	\N	\N	\N	\N	\N	236	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
194	\N	\N	\N	\N	\N	\N	1	\N	9631689858	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	hvumcFvWieoKuQ3PqU2TgM1s	2025-10-01 10:13:30.558561	2025-10-01 10:13:35.175251	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
205	Guest User	\N	riteshkumar8411460@gmail.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9055f2d2957da0aa89bfe3e92b292bda	2025-10-07 05:44:06.662707	2025-10-07 08:07:37.501571	5	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
208	\N	\N	\N	\N	\N	136822	0	\N	7381669592	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	tpvbjpzw8nvxZ5YHSq2CUto6	2025-10-07 14:05:55.79512	2025-10-30 12:07:37.210606	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
200	\N	\N	\N	\N	\N	\N	1	\N	9625565886	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6gYr51hvE4qLby1DNvNkwSM7	2025-10-02 06:44:57.392662	2025-10-02 06:45:04.056516	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
202	\N	\N	\N	\N	\N	123456	0	\N	raushan@gmail.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	nZB235MQF474Pw1WEWr4dre3	2025-10-02 09:21:26.905241	2025-10-02 09:21:26.912379	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
206	Guest User	\N	gupta.sonam979@gmail.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	e0755fcda2955de73e0148b8521f0697	2025-10-07 11:39:10.904162	2025-10-07 13:16:08.394182	5	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
204	Guest User	\N	indianravi7294@gmail.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	698ca855c0da7da9ae3a5d50e39bfed8	2025-10-07 04:59:57.822588	2025-10-07 10:40:04.18728	5	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
203	Guest User	\N	semrahiyan.cafe@gmail.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Y5DP7BBF3WiGRz5CSJZ5e2CQ	2025-10-06 16:29:33.460006	2025-10-06 16:56:45.056217	5	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	296007	2025-10-06 16:56:45.0556	\N	\N	f	f	f	\N	f
209	Guest User	\N	xys@gmail.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S7i9tzCMw8Tby4YahBYrmLZ9	2025-10-07 14:07:32.553162	2025-10-07 14:07:32.559324	5	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	204076	2025-10-07 14:07:32.559037	\N	\N	f	f	f	\N	f
211	Guest User	\N	1233@gmail.con	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	97mmvGzUjeBgigksDZKyarbq	2025-10-09 18:36:55.947862	2025-10-09 18:36:55.95565	5	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	535482	2025-10-09 18:36:55.955326	\N	\N	f	f	f	\N	f
210	Guest User	\N	xyz@gmail.con	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	DwvxH3QLXyidks4dRjC1jYq9	2025-10-07 14:14:24.922701	2025-10-07 14:17:10.159211	5	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	864247	2025-10-07 14:17:10.158653	\N	\N	f	f	f	\N	f
213	\N	\N	\N	\N	\N	123456	0	\N	9568773855	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	NgqEf49YhSZk5BDh5bhCqrst	2025-10-13 04:46:40.119256	2025-10-16 05:13:21.140538	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
239	retailer	sonu	retailer@gmail.com	$2a$12$dD70rsTFEg3M9lqI37VTeu6NxemnOHXXxA9kPYOtt53ZoiAqrcF5e	\N	\N	\N	\N	897897878787	\N	33244343332	897787979789	CTHJJ6876767	2025-11-10	Male	Business Name	Business Name				\N	Noida	Noida	Up	201301	\N		\N						\N	QExaBcNvjFwSBsF5cDfB8msS	2025-11-11 12:00:53.313988	2025-11-11 12:00:53.313988	5	f	\N	\N	\N	\N	\N	123456		16	\N	\N	\N	\N	\N	\N	237	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
214	Guest User	\N	pintukumarpandit944@gmail.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Qbmz7ZD89wMpHxLPyUm1vfGu	2025-10-13 05:46:40.11171	2025-10-13 05:46:51.466019	5	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	518453	2025-10-13 05:46:51.465443	\N	\N	f	f	f	\N	f
215	Guest User	\N	121pintup@gmail.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	QjHmUD1WmYaBg1edSCxGdMdd	2025-10-13 05:47:07.218828	2025-10-13 05:47:07.224953	5	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	649894	2025-10-13 05:47:07.224595	\N	\N	f	f	f	\N	f
148	\N	\N	\N	\N	\N	\N	1	\N	68787676676	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	243d85cbc48c9d20fecc6e11a79b5d93	2025-09-19 13:41:38.241268	2025-10-16 05:19:32.783451	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	123456	\N	t	f	f	\N	f
216	Guest User	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	zFdodxQ3WdM2rvu8RybJ9gdT	2025-10-23 10:30:24.414976	2025-10-23 10:30:26.966278	5	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	888529	2025-10-23 10:30:26.965672	\N	\N	f	f	f	\N	f
141	Shek	aalam	shek@gmail.com	$2a$12$eaEveK9bW2pC14ehDryUyeDBStZ8dShiTOSolTBmEgNuChyAMvGZG	\N	228019	0	\N	9568773855	\N	9568773855	98798798798687	JKGJGHJ68768DD	2025-09-03	Male						\N					\N	Shak344343	\N		Axis	7988757678hgg	IFDD&775655	Alim	\N	\N	2025-09-04 18:35:04.24181	2025-10-23 10:31:06.784477	9	f	\N	\N	\N	\N	\N	shak123		5	\N	\N	\N	\N	\N	\N	136	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
103	Master	kumar	master@gmail.com	$2a$12$/UeN5ofRoHdl30iPr1yLjOPBxHJK7yJnuVT3r1aqvKEAAT.fdULs2	\N	\N	\N	\N	77879987979	\N	78098798687	7987687576457476	JKGJGHJ688978	2025-08-22	Male	Insurance Business	Insurance Business Ownership Type	Insurance Business Nature Type	98789798798787	986857644645cddsds	\N	noida 121	noida	Uttar Pradesh	201301	\N	maste7879879	paid	HGG7897897	Axis	7988757678hgg	IFDD&775655	master	\N	\N	2025-08-29 05:50:45.95782	2025-11-11 11:57:03.122109	6	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
232	Aamir	mohd	mohammadaamir2002@gmail.com	$2a$12$PpLXA29ThF4O.tdvM4V.6uGOGIQC4YsXcyeRBO/6Xw5Nonq8BKjZ6	\N	\N	\N	\N	9877877779	\N	9877877779	876876876867233	JKGJGHJ688978	2025-11-07		dddfdffd	dddfdffd	dddfdffd	dddfdffd	986857644645cddsds	\N		noida	Uttar Pradesh	201301	\N	mohd123	\N	HGG7897897	Axis		IFDD96875		\N	144cc9de40a622c9b567cf5db7aa53b2706fc13a	2025-11-01 05:07:14.679307	2025-11-01 07:06:43.993674	9	t	\N	\N	\N	\N	\N	123456	mohd	5	\N	\N	\N	\N	\N	\N	104	123456	123456	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	158944	2025-11-01 07:16:43.993016	\N	\N	t	f	t	2025-11-01 06:56:02.768388	f
225	Guest User	\N	priteshrao3@gmail.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1b820ac7a72f2eb2b1dbb504356c47a2	2025-10-30 11:13:45.379794	2025-10-30 13:59:28.663526	5	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	001235	\N	t	f	f	\N	f
228	\N	\N	\N	\N	\N	458576	0	\N	9170852984	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	mzGUNinQ9BGb1gKQVxHEgoFP	2025-10-30 14:06:25.232015	2025-10-30 14:06:25.507687	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
223	khan	mailk	khan@gmail.com	$2a$12$auKZzoQLPvjF7ooCvtwrF.GK8HyDenrfgES42Z5g4Dl9sXtjNGcLW	\N	\N	\N	\N	03443434334	\N	03443434334	7328728367	JKGJGHJ68768	2025-10-23	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd		\N	noida 121	noida	Uttar Pradesh	201301	\N		\N						\N	1b90029e79c6265d80933e3005153ef0783c365a	2025-10-29 11:01:14.955284	2025-10-29 11:04:30.038478	5	t	\N	\N	\N	\N	\N	123456	\N	\N	\N	\N	\N	\N	\N	\N	104	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	t	2025-10-29 11:04:30.03794	f
222	sid	wa	sid@gmail.com	$2a$12$TqbeEYi21Kjxbeqxf9tl6uTDMxybiJH1zc4JvlXvqePiDqWW9KIn6	\N	\N	\N	\N	03443434334	\N	+919568773855	9867676757656	JKGJGHJ688978	2025-10-23	Select gender						\N	noida 121	noida	Uttar Pradesh	201301	\N	siddharth	\N		Axis				\N	ffb6d6ef7dbcdf94eae2aef107347c783bb25e91	2025-10-29 09:52:24.254563	2025-10-29 10:57:04.145912	5	t	\N	\N	\N	\N	\N	123456	\N	\N	\N	\N	\N	\N	\N	\N	104	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	t	2025-10-29 10:57:04.145342	f
229	\N	\N	\N	\N	\N	797329	0	\N	9170475552	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	JrS4f1ooSocarKwHc5ruryu6	2025-10-30 14:06:42.061004	2025-10-30 14:06:42.201108	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
227	Guest User	\N	prem100000@gmail.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	5f6f89a26c936fd328f8e601dbcddd85	2025-10-30 12:11:48.278286	2025-10-30 15:44:34.551093	5	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	009699	\N	t	f	f	\N	f
221	\N	\N	superadmin@gmail.com	$2a$12$A1peLyuPnzZEe7pT3rreaeh/AMCwY2OaUs8xDpry2w6yQAGIXcIKi	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	LwuzaTMHV1PxQune4rLZT9EF	2025-10-28 11:57:52.699289	2025-10-28 11:57:52.699289	10	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
226	\N	\N	\N	\N	\N	328762	0	\N	9699321444	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	pmHnFfkBzC8Q7YXeHZvBhELZ	2025-10-30 12:07:16.016249	2025-10-30 12:07:16.300036	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
224	\N	\N	gschangemaker@gmail.com	$2a$12$MF8LkrrIH6g4rAoS1cMBW.xTOt/cWIaBTl4OcDcQ04Wtn166HaqBO	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	4DefmcPdssRxCwdHMdRukqB8	2025-10-30 10:25:21.406347	2025-11-10 11:24:52.555076	10	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
230	sonam		Bharatgrowsocial@gmail.com	$2a$12$eA3UDoQaZtXbajPgaUrpJeOOfrNfvF7OCBNd3T/RKUecrDMz5RguC	\N	\N	\N	\N	79897878778	\N	7989787877	9867676757656	JKGJGHJ68768	2025-11-14		dddfdffd	dddfdffd	dddfdffd	dddfdffd		\N		noida	Uttar Pradesh	201301	\N	sonam123	\N		Axis		IFDD&775655		\N	32879b17a1856b69f8bc84b6dd5355c46c6d0537	2025-11-01 04:46:10.524921	2025-11-06 08:34:41.640715	9	t	\N	\N	\N	\N	\N	123456		5	\N	\N	\N	\N	\N	\N	104	123456	123456	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	t	f	t	2025-11-06 08:34:41.640159	f
234	Sanju	\N	sanju20319@gmail.com	\N	\N	\N	\N	2025-11-08 04:09:18.866924	\N	\N	\N	789798797862	\N	2000-01-09	male	\N	\N	\N	\N		CTJKH1812M	Noida 121 secotor 63	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7bb61d3106b5d23116a0cc41584f94cb	2025-11-06 09:42:22.753567	2025-11-08 04:04:36.21863	5	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	send_by	\N	\N	\N	\N	123456	pending	not_started	#<ActionDispatch::Http::UploadedFile:0x000073be01d0f308>	t	2025-11-07 08:54:47.408816	{"dob": "1990-05-10", "name": "Rahul Sharma", "gender": "M", "address": "123, MG Road, Delhi", "aadhaar_last4": "7862"}	\N	\N	009999	\N	t	f	f	\N	f
139	Tej	singh	tej@gmail.com	$2a$12$sr2e3Chig0WLaaZyX7edIepMg2nEOi4QrLcDlnXaxpTuH.kPgUFXK	\N	\N	\N	\N	90898798788	\N	90889798798	787898779797977	JKGJGHJ688978	2025-09-02	Male	LOAN SOULUTION	Loan Business Ownership	Loan Nature Type	328987097ds979d89787	986857644645cddsds	\N	noida 121	noida	Uttar Pradesh	201301	\N	tej88989	\N	tej87787	HDFC	687687676776876	IFDD&775655	Tej	\N	0bf6ed70763d56e0781844e35209ae8789688c68	2025-09-04 09:05:42.906747	2025-11-11 05:39:00.065732	5	t	\N	\N	\N	\N	\N	tej123	\N	16	\N	\N	\N	\N	\N	\N	104	123123	123123	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	t	2025-11-11 05:39:00.065167	f
236	master	singh	master12@gmail.com	$2a$12$P3Eedw/qcrV2z1dee/.w5.OUry1xabskB8xy/RqJzfTbpn944nkBu	\N	\N	\N	\N	33433434332	\N	3878768683	323232323232	CHJK876876	2025-11-07	Male						\N	Noida	sre		3232	\N		\N						\N	4UmJYZ61v7NpVgc2J5XqEUQV	2025-11-11 10:29:00.474267	2025-11-11 11:14:41.95122	6	f	\N	\N	\N	\N	\N	123456		16	\N	\N	\N	\N	\N	\N	104	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
219	\N	\N	dealer@gmail.com	$2a$12$gZN9HAakXVDHqra1XCwjhOhBtgeCwXE6Tm/v0VlSYiuFK2mQbDfXm	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	v6KpfeJg2mTw3KJXsn89mMG2	2025-10-25 07:45:31.640012	2025-11-11 11:55:53.79449	7	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	461852	\N	\N	\N	f	f	f	2025-11-11 12:05:53.793353	f
238	dealer	Singh	dealer@gmail.com	$2a$12$vGsLF45GAkB0qiEqj5kJeewmTQYRbc/DcZisxfYkI9rz7Uuja0A5W	\N	\N	\N	\N	78787897787	\N	78787897782	87797987879798	HJHJ787687	2025-11-10	Male	Business Name	Business Ownership Type	Business Nature Type	Business Registration Number	KJHJK9809	\N	Noida	Noida121		779879	\N		\N						\N	XrqT25FpkAQYr1cV6Fd5tRkm	2025-11-11 11:58:44.63886	2025-11-11 11:58:44.63886	7	f	\N	\N	\N	\N	\N	123456	dealer	16	\N	\N	\N	\N	\N	\N	103	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
241	Guest User	\N	sidd20319@gmail.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	018094c999a3fef857719f914dfc9cf7	2025-11-12 04:54:44.059508	2025-11-12 04:56:30.084942	5	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	004748	\N	t	f	f	\N	f
242	\N	\N	\N	\N	\N	418961	0	\N	4555555852	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	smaqu7vvAmh266NsdTNjbwXk	2025-11-12 05:01:08.807296	2025-11-12 05:01:09.075059	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f
233	Raushan kumar	\N	raushan.edu121@gmail.com	\N	\N	\N	\N	2025-11-08 04:29:38.694264	\N	\N	\N	549380649484	\N	2000-01-01	male	\N	\N	\N	\N		CTJKH1812M	bajitpur	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	fe9987b3e1355860cbbbd7fc85848d88	2025-11-05 11:38:36.544322	2025-11-12 12:37:57.572293	5	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	#<ActionDispatch::Http::UploadedFile:0x000072556f715d68>	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	verified	\N	\N	\N	\N	123456	pending	not_started	#<ActionDispatch::Http::UploadedFile:0x00007642958524f8>	t	2025-11-11 12:53:07.68478	{"dob": "1990-05-10", "name": "Rahul Sharma", "gender": "M", "address": "123, MG Road, Delhi", "aadhaar_last4": "9484"}	\N	\N	000000	\N	t	f	f	\N	f
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
108	61	TXN802335	credit	NEFT	40000.00	success	Fund request created by user 232	2025-11-01 06:57:27.282277	2025-11-01 06:58:09.713984	108
109	62	TXN472766	credit	Netbanking	10000.00	success	Fund request created by user 230	2025-11-01 14:03:08.66807	2025-11-01 14:08:48.113858	109
110	8	TXN498736	credit	Netbanking	111.00	success	Fund request created by user 127	2025-11-03 07:49:24.397264	2025-11-03 12:02:48.328214	110
111	8	TXN695439	credit	NEFT	55.00	pending	Fund request created by user 127	2025-11-03 12:04:21.29154	2025-11-03 12:04:21.29154	111
112	8	TXN779909	credit	UPI	55.00	pending	Fund request created by user 127	2025-11-03 12:04:55.477884	2025-11-03 12:04:55.477884	112
113	8	TXN543606	credit	UPI	55.00	pending	Fund request created by user 127	2025-11-03 12:05:16.223305	2025-11-03 12:05:16.223305	113
114	8	TXN964767	credit	UPI	55.00	pending	Fund request created by user 127	2025-11-03 12:05:18.886971	2025-11-03 12:05:18.886971	114
115	8	TXN682455	credit	UPI	55.00	pending	Fund request created by user 127	2025-11-03 12:05:22.822839	2025-11-03 12:05:22.822839	115
116	8	TXN167056	credit	UPI	55.00	pending	Fund request created by user 127	2025-11-03 12:06:09.039157	2025-11-03 12:06:09.039157	116
117	8	TXN455134	credit	UPI	55.00	pending	Fund request created by user 127	2025-11-03 12:06:43.346096	2025-11-03 12:06:43.346096	117
118	8	TXN703715	credit	Netbanking	118.00	pending	Fund request created by user 127	2025-11-03 12:09:46.403438	2025-11-03 12:09:46.403438	118
119	8	TXN869151	credit	Netbanking	118.00	pending	Fund request created by user 127	2025-11-03 12:10:40.058227	2025-11-03 12:10:40.058227	119
120	8	TXN265550	credit	Netbanking	118.00	pending	Fund request created by user 127	2025-11-03 12:11:51.031741	2025-11-03 12:11:51.031741	120
121	8	TXN187750	credit	Netbanking	118.00	pending	Fund request created by user 127	2025-11-03 12:11:55.214154	2025-11-03 12:11:55.214154	121
122	8	TXN291337	credit	CashInBank	894.00	rejected	Fund request created by user 127	2025-11-03 12:13:00.578316	2025-11-03 12:13:00.578316	122
123	8	TXN987462	credit	UPI	9.00	pending	Fund request created by user 127	2025-11-03 12:48:50.182315	2025-11-03 12:48:50.182315	123
124	8	TXN615513	credit	CashInBank	8.00	pending	Fund request created by user 127	2025-11-03 13:03:02.426815	2025-11-03 13:03:02.426815	124
125	8	TXN626694	credit	NEFT	111.00	pending	Fund request created by user 127	2025-11-03 13:05:08.261346	2025-11-03 13:05:08.261346	125
126	8	TXN968408	credit	IMPS	888.00	pending	Fund request created by user 127	2025-11-03 13:14:49.474161	2025-11-03 13:14:49.474161	126
127	8	TXN277293	credit	NEFT	1223.00	pending	Fund request created by user 127	2025-11-03 13:17:10.664668	2025-11-03 13:17:10.664668	127
128	8	TXN817000	credit	NEFT	22.00	pending	Fund request created by user 127	2025-11-04 05:24:28.121693	2025-11-04 05:24:28.121693	128
129	8	TXN887457	credit	Cash	121.00	pending	Fund request created by user 127	2025-11-04 09:42:23.325127	2025-11-04 09:42:23.325127	129
130	8	TXN574629	credit	Cash	4.00	pending	Fund request created by user 127	2025-11-04 09:44:38.946863	2025-11-04 09:44:38.946863	130
131	8	TXN705629	credit	NEFT	109.00	pending	Fund request created by user 127	2025-11-04 09:51:09.995501	2025-11-04 09:51:09.995501	131
132	8	TXN191040	credit	CashInBank	3.00	pending	Fund request created by user 127	2025-11-04 10:14:26.431731	2025-11-04 10:14:26.431731	132
133	8	TXN379445	credit	Cash	8.00	pending	Fund request created by user 127	2025-11-04 10:15:09.24042	2025-11-04 10:15:09.24042	133
134	8	TXN546368	credit	CashInBank	1.00	pending	Fund request created by user 127	2025-11-04 10:26:07.309481	2025-11-04 10:26:07.309481	134
135	8	TXN271478	credit	Cash	222.00	rejected	Fund request created by user 127	2025-11-04 11:07:34.179949	2025-11-04 11:07:34.179949	135
136	8	TXN450302	fund	CashInBank	9.00	pending	Fund request created by user 127	2025-11-04 11:32:17.840793	2025-11-04 11:32:17.840793	136
137	8	TXN857282	fund	CashInBank	121.00	pending	Fund request created by user 127	2025-11-04 12:13:48.741337	2025-11-04 12:13:48.741337	137
138	8	TXN328412	fund	UPI	400.00	pending	Fund request created by user 127	2025-11-04 12:15:05.924866	2025-11-04 12:15:05.924866	138
139	8	TXN583779	fund	Netbanking	566.00	pending	Fund request created by user 127	2025-11-04 12:57:18.467779	2025-11-04 12:57:18.467779	139
140	8	TXN273586	fund	Cash	11.00	pending	Fund request created by user 127	2025-11-04 13:04:27.975256	2025-11-04 13:04:27.975256	141
141	63	TXN930103	fund	UPI	100.00	pending	Fund request created by user 236	2025-11-11 11:25:46.400863	2025-11-11 11:25:46.400863	142
142	63	TXN940980	fund	NEFT	20.00	rejected	Fund request created by user 236	2025-11-11 11:26:07.864468	2025-11-11 11:26:07.864468	143
\.


--
-- Data for Name: wallets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wallets (id, user_id, balance, created_at, updated_at) FROM stdin;
60	141	230.0	2025-09-12 12:11:31.809681	2025-09-12 12:49:13.271991
59	138	100.0	2025-09-12 12:06:33.547259	2025-09-12 12:22:20.631315
9	139	99482.92	2025-09-08 05:43:00.575812	2025-11-11 05:39:56.072979
63	236	0.0	2025-11-11 11:25:46.378839	2025-11-11 11:25:46.378839
58	136	502194.508000000000015	2025-09-12 10:29:25.138537	2025-11-12 11:02:04.094118
8	127	17898.88	2025-09-06 12:35:37.121371	2025-11-12 13:32:17.894344
61	232	40000.0	2025-11-01 06:57:27.245733	2025-11-01 06:58:09.663409
62	230	10000.0	2025-11-01 14:03:08.658274	2025-11-01 14:08:48.104808
10	134	47263.0	2025-09-08 06:37:14.67418	2025-09-26 06:56:02.60943
7	104	36579.09	2025-09-06 12:32:32.749727	2025-11-04 13:12:47.858363
\.


--
-- Name: account_transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_transactions_id_seq', 22, true);


--
-- Name: banks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.banks_id_seq', 8, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 74, true);


--
-- Name: commissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.commissions_id_seq', 93, true);


--
-- Name: dmt_transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dmt_transactions_id_seq', 88, true);


--
-- Name: dmts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dmts_id_seq', 97, true);


--
-- Name: enquiries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enquiries_id_seq', 19, true);


--
-- Name: fund_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fund_requests_id_seq', 143, true);


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

SELECT pg_catalog.setval('public.service_product_items_id_seq', 19, true);


--
-- Name: service_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.service_products_id_seq', 23, true);


--
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.services_id_seq', 16, true);


--
-- Name: transaction_commissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transaction_commissions_id_seq', 550, true);


--
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transactions_id_seq', 479, true);


--
-- Name: user_services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_services_id_seq', 117, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 242, true);


--
-- Name: wallet_transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wallet_transactions_id_seq', 142, true);


--
-- Name: wallets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wallets_id_seq', 63, true);


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
-- Name: dmt_transactions dmt_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dmt_transactions
    ADD CONSTRAINT dmt_transactions_pkey PRIMARY KEY (id);


--
-- Name: dmts dmts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dmts
    ADD CONSTRAINT dmts_pkey PRIMARY KEY (id);


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
-- Name: index_banks_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_banks_on_user_id ON public.banks USING btree (user_id);


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
-- Name: index_dmt_transactions_on_dmt_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_dmt_transactions_on_dmt_id ON public.dmt_transactions USING btree (dmt_id);


--
-- Name: index_dmt_transactions_on_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_dmt_transactions_on_parent_id ON public.dmt_transactions USING btree (parent_id);


--
-- Name: index_dmt_transactions_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_dmt_transactions_on_user_id ON public.dmt_transactions USING btree (user_id);


--
-- Name: index_dmts_on_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_dmts_on_parent_id ON public.dmts USING btree (parent_id);


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
-- Name: banks fk_rails_465b63d453; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.banks
    ADD CONSTRAINT fk_rails_465b63d453 FOREIGN KEY (user_id) REFERENCES public.users(id);


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
-- Name: dmt_transactions fk_rails_634b3cd572; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dmt_transactions
    ADD CONSTRAINT fk_rails_634b3cd572 FOREIGN KEY (dmt_id) REFERENCES public.dmts(id);


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
-- Name: dmt_transactions fk_rails_9857a0a118; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dmt_transactions
    ADD CONSTRAINT fk_rails_9857a0a118 FOREIGN KEY (user_id) REFERENCES public.users(id);


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

\unrestrict fWsyGh7dyg4XYwg1ZJgRYAMMv315MzYGbkpVTxNJ0jQ2sWuPxbvbgPnk8MIcQoA

