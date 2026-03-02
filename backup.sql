--
-- PostgreSQL database dump
--

\restrict 6uQhIfx13nIQnqa3AyBVbejVVtVgeQ0EuczsiGeLUNoO28id4x83edQUQRJy3eA

-- Dumped from database version 14.20 (Ubuntu 14.20-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.20 (Ubuntu 14.20-0ubuntu0.22.04.1)

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
-- Name: api_clients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.api_clients (
    id bigint NOT NULL,
    name character varying,
    user_code character varying NOT NULL,
    api_key character varying NOT NULL,
    active boolean DEFAULT true,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.api_clients OWNER TO postgres;

--
-- Name: api_clients_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.api_clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_clients_id_seq OWNER TO postgres;

--
-- Name: api_clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.api_clients_id_seq OWNED BY public.api_clients.id;


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
    scheme_id bigint,
    commission_rate numeric
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
    parent_id integer,
    customer_id character varying,
    recipient_id bigint,
    fee numeric,
    tid character varying,
    tds numeric,
    service_tax numeric,
    commission numeric,
    txstatus_desc character varying,
    collectable_amount numeric,
    user_id bigint
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
-- Name: eko_banks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eko_banks (
    id bigint NOT NULL,
    bank_id character varying,
    name character varying,
    ifsc_prefix character varying,
    bank_code character varying,
    status boolean,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.eko_banks OWNER TO postgres;

--
-- Name: eko_banks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.eko_banks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.eko_banks_id_seq OWNER TO postgres;

--
-- Name: eko_banks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.eko_banks_id_seq OWNED BY public.eko_banks.id;


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
    account_number character varying,
    deposit_account_no character varying,
    deposit_ifsc_code character varying,
    ifsc_code character varying
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
    updated_at timestamp(6) without time zone NOT NULL,
    status character varying,
    pending_note text,
    user_id bigint
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
    updated_at timestamp(6) without time zone NOT NULL,
    status character varying,
    pending_note text,
    user_id bigint,
    lead_id character varying
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
-- Name: refund_requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.refund_requests (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    transaction_id bigint,
    parent_id bigint,
    refund_id character varying,
    refund_type character varying,
    amount numeric(15,2),
    reason text,
    status character varying,
    admin_note text,
    processed_at timestamp(6) without time zone,
    processed_by integer,
    attachment_url character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.refund_requests OWNER TO postgres;

--
-- Name: refund_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.refund_requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.refund_requests_id_seq OWNER TO postgres;

--
-- Name: refund_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.refund_requests_id_seq OWNED BY public.refund_requests.id;


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
    updated_at timestamp(6) without time zone NOT NULL,
    user_id bigint
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
    name character varying,
    oprator_type character varying,
    status character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    category_id bigint,
    operator_id bigint
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
-- Name: support_tickets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.support_tickets (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    ticket_number character varying,
    full_name character varying,
    email character varying,
    service_type character varying,
    reference_id character varying,
    subject character varying,
    description text,
    status character varying,
    status_updated_at timestamp(6) without time zone,
    resolution_note text,
    resolved_at timestamp(6) without time zone,
    assigned_agent_id integer,
    attachment_url character varying,
    parent_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.support_tickets OWNER TO postgres;

--
-- Name: support_tickets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.support_tickets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.support_tickets_id_seq OWNER TO postgres;

--
-- Name: support_tickets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.support_tickets_id_seq OWNED BY public.support_tickets.id;


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
    state character varying,
    tid character varying,
    tds numeric(10,2),
    commission numeric(10,2),
    status_text character varying,
    txstatus_desc character varying,
    category_id bigint
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
    set_pin_status boolean DEFAULT false,
    user_code character varying,
    eko_onboard_first_step boolean DEFAULT false,
    eko_profile_second_step boolean DEFAULT false,
    eko_status_otp boolean DEFAULT false,
    eko_verify_otp boolean DEFAULT false,
    eko_biometric_kyc boolean DEFAULT false,
    permanent_address character varying,
    permanent_landmark character varying,
    permanent_postal_code character varying,
    permanent_city character varying,
    permanent_state character varying,
    permanent_pincode character varying
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
-- Name: wallet_histories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wallet_histories (
    id bigint NOT NULL,
    wallet_id bigint NOT NULL,
    user_id integer,
    parent_id integer,
    amount numeric,
    before_balance numeric,
    after_balance numeric,
    transaction_type character varying,
    remark character varying,
    reference_id character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.wallet_histories OWNER TO postgres;

--
-- Name: wallet_histories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wallet_histories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wallet_histories_id_seq OWNER TO postgres;

--
-- Name: wallet_histories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wallet_histories_id_seq OWNED BY public.wallet_histories.id;


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
-- Name: api_clients id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_clients ALTER COLUMN id SET DEFAULT nextval('public.api_clients_id_seq'::regclass);


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
-- Name: eko_banks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eko_banks ALTER COLUMN id SET DEFAULT nextval('public.eko_banks_id_seq'::regclass);


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
-- Name: refund_requests id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refund_requests ALTER COLUMN id SET DEFAULT nextval('public.refund_requests_id_seq'::regclass);


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
-- Name: support_tickets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.support_tickets ALTER COLUMN id SET DEFAULT nextval('public.support_tickets_id_seq'::regclass);


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
-- Name: wallet_histories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallet_histories ALTER COLUMN id SET DEFAULT nextval('public.wallet_histories_id_seq'::regclass);


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
-- Data for Name: api_clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_clients (id, name, user_code, api_key, active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2026-01-29 05:05:14.755701	2026-01-29 05:05:14.755707
\.


--
-- Data for Name: banks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.banks (id, bank_name, account_name, ifsc_code, account_number, account_type, first_name, last_name, initial_balance, created_at, updated_at, user_id) FROM stdin;
1	Gautam	\N	SURY0BK0000	779776876567576576	savings	Siddharth	\N	0.0	2026-01-29 05:23:58.722918	2026-01-29 05:23:58.722918	1
2	Bank of Baroda	Admin khan	BARB0KHARAD	9924000100007471	\N	Admin	khan	\N	2026-01-29 06:43:35.202223	2026-01-29 06:43:35.202223	2
3	Bank of Baroda	master 1	BARB0KHARAD	4569456456485645	\N	master	1	\N	2026-01-29 07:10:57.891573	2026-01-29 07:10:57.891573	3
4	rt	\N	HDFC0000003	4569456456485645	\N	\N	\N	\N	2026-01-29 09:14:04.686193	2026-01-29 09:14:04.686193	4
5	Axis Bank	dealer 1	UTIB0002193	6867866867867	\N	dealer	1	\N	2026-01-29 10:34:43.472654	2026-01-29 10:34:43.472654	4
6	Bank of Baroda	retailer singh	BARB0KHARAD	1234567890	\N	retailer	singh	\N	2026-01-29 10:51:34.079988	2026-01-29 10:51:34.079988	5
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, title, image, status, service_id, created_at, updated_at) FROM stdin;
1	Prepaid	\N	\N	1	2026-01-29 10:17:21.747714	2026-01-29 10:17:21.747714
2	Postpaid	\N	\N	1	2026-01-29 10:17:30.547543	2026-01-29 10:17:30.547543
4	Insurance	\N	\N	2	2026-01-30 09:59:13.605989	2026-01-30 09:59:13.605989
5	Electricity bill	\N	\N	2	2026-01-30 10:16:13.611846	2026-01-30 10:16:13.611846
6	Gas Bill	\N	\N	2	2026-01-30 10:16:21.577153	2026-01-30 10:16:21.577153
7	Water Bill	\N	\N	2	2026-01-30 10:16:29.038142	2026-01-30 10:16:29.038142
8	Fastag Recharge	\N	\N	2	2026-01-30 10:17:06.560737	2026-01-30 10:17:06.560737
9	Challan payment	\N	\N	2	2026-01-31 06:56:09.547412	2026-01-31 06:56:09.547412
10	Boraband bill	\N	\N	2	2026-01-31 06:56:21.445758	2026-01-31 06:56:21.445758
11	Credit card bill	\N	\N	2	2026-01-31 06:56:46.258501	2026-01-31 06:56:46.258501
12	Loan Repayment	\N	\N	2	2026-01-31 06:56:58.43427	2026-01-31 06:56:58.43427
\.


--
-- Data for Name: commissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.commissions (id, commission_type, from_role, to_role, value, created_at, updated_at, service_product_item_id, scheme_id, commission_rate) FROM stdin;
1	percentage	superadmin	admin	100.0	2026-01-29 10:17:49.726724	2026-01-29 10:17:49.726724	1	1	\N
2	commission	admin	master	10.0	2026-01-29 11:36:35.17024	2026-01-29 11:36:35.158267	1	2	\N
3	commission	admin	dealer	30.0	2026-01-29 11:36:35.184966	2026-01-29 11:36:35.180857	1	2	\N
4	commission	admin	retailer	50.0	2026-01-29 11:36:35.198651	2026-01-29 11:36:35.194035	1	2	\N
5	percentage	superadmin	admin	100.0	2026-01-30 10:02:01.922506	2026-01-30 10:02:01.922506	2	1	\N
6	percentage	superadmin	admin	100.0	2026-01-31 06:54:43.954614	2026-01-31 06:54:43.954614	3	1	\N
\.


--
-- Data for Name: dmt_transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dmt_transactions (id, dmt_id, user_id, status, txn_id, sender_mobile_number, bank_name, account_number, amount, created_at, updated_at, parent_id) FROM stdin;
\.


--
-- Data for Name: dmts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dmts (id, full_name, account_number, confirm_account_number, phone_number, bank_name, branch_name, ifsc_code, sender_full_name, sender_phone_number, sender_aadhar_number, sender_aadhar_otp_email, beneficiaries_status, sender_name, receiver_name, sender_mobile_number, receiver_mobile_number, status, aadhaar_number_otp, aadhaar_number_otp_expriry, datetime, created_at, updated_at, amount, parent_id, customer_id, recipient_id, fee, tid, tds, service_tax, commission, txstatus_desc, collectable_amount, user_id) FROM stdin;
\.


--
-- Data for Name: eko_banks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eko_banks (id, bank_id, name, ifsc_prefix, bank_code, status, created_at, updated_at) FROM stdin;
1	1	Axis Bank	UTIB0002193	UTIB	t	2026-01-29 05:46:51.48245	2026-01-29 05:46:51.48245
2	2	Bank of Baroda	BARB0KHARAD	BARB	t	2026-01-29 05:46:51.517843	2026-01-29 05:46:51.517843
3	3	Bank of India	BKID0000500	BKID	t	2026-01-29 05:46:51.538074	2026-01-29 05:46:51.538074
4	4	Central Bank of India	CBIN0280658	CBIN	t	2026-01-29 05:46:51.549533	2026-01-29 05:46:51.549533
5	5	Citibank	NULL	CITI	t	2026-01-29 05:46:51.559495	2026-01-29 05:46:51.559495
6	6	HDFC Bank	HDFC0000007	HDFC	t	2026-01-29 05:46:51.57142	2026-01-29 05:46:51.57142
7	7	ICICI Bank	NULL	ICIC	t	2026-01-29 05:46:51.583156	2026-01-29 05:46:51.583156
8	8	IDBI Bank	IBKL0000007	IBKL	t	2026-01-29 05:46:51.592119	2026-01-29 05:46:51.592119
9	9	Indian Bank	IDIB000K168	IDIB	t	2026-01-29 05:46:51.602777	2026-01-29 05:46:51.602777
10	10	Indian Overseas Bank	IOBA0000005	IOBA	t	2026-01-29 05:46:51.614172	2026-01-29 05:46:51.614172
11	11	Punjab National Bank	PUNB0038600	PUNB	t	2026-01-29 05:46:51.624497	2026-01-29 05:46:51.624497
12	13	Union Bank of India	UBIN0530786	UBIN	t	2026-01-29 05:46:51.634249	2026-01-29 05:46:51.634249
13	14	UCO Bank	NULL	UCBA	f	2026-01-29 05:46:51.641326	2026-01-29 05:46:51.641326
14	16	Yes Bank	NULL	YESB	t	2026-01-29 05:46:51.653627	2026-01-29 05:46:51.653627
15	17	Dena Bank	BKDN0510259	BKDN	t	2026-01-29 05:46:51.665998	2026-01-29 05:46:51.665998
16	18	Abhyudaya Co-Op Bank	NULL	ABHY	t	2026-01-29 05:46:51.67711	2026-01-29 05:46:51.67711
17	19	Abu Dhabi Commercial Bank	NULL	ADCB	f	2026-01-29 05:46:51.68771	2026-01-29 05:46:51.68771
18	20	Allahabad Bank	ALLA0212052	ALLA	t	2026-01-29 05:46:51.698824	2026-01-29 05:46:51.698824
19	21	Andhra Bank	ANDB0000005	ANDB	t	2026-01-29 05:46:51.709068	2026-01-29 05:46:51.709068
20	22	Bank of America	NULL	BOFA	t	2026-01-29 05:46:51.718898	2026-01-29 05:46:51.718898
21	23	Bank of Bahrain and Kuwait	NULL	BBKM	f	2026-01-29 05:46:51.728772	2026-01-29 05:46:51.728772
22	24	Bank of Ceylon	NULL	BCEY	f	2026-01-29 05:46:51.746023	2026-01-29 05:46:51.746023
23	25	Bank of Maharashtra	MAHB0000001	MAHB	t	2026-01-29 05:46:51.759088	2026-01-29 05:46:51.759088
24	26	Bank Of Tokyo Mitsubishi Ufj Ltd	NULL	BOTM	f	2026-01-29 05:46:51.769976	2026-01-29 05:46:51.769976
25	27	Barclays Bank	NULL	BARC	t	2026-01-29 05:46:51.781285	2026-01-29 05:46:51.781285
26	28	Bassein Catholic Co-Op Bank	NULL	BACB	t	2026-01-29 05:46:51.791396	2026-01-29 05:46:51.791396
27	29	Bnp Paribas Bank	NULL	BNPA	t	2026-01-29 05:46:51.803453	2026-01-29 05:46:51.803453
28	30	Canara Bank	CNRB0000259	CNRB	t	2026-01-29 05:46:51.812344	2026-01-29 05:46:51.812344
29	32	Catholic Syrian Bank	CSBK0000282	CSBK	t	2026-01-29 05:46:51.826442	2026-01-29 05:46:51.826442
30	33	Chinatrust Commercial Bank	NULL	CTCB	f	2026-01-29 05:46:51.844897	2026-01-29 05:46:51.844897
31	34	Citizen Credit Co-Op Bank	NULL	CCBL	t	2026-01-29 05:46:51.862004	2026-01-29 05:46:51.862004
32	35	City Union Bank	CIUB0000005	CIUB	t	2026-01-29 05:46:51.874613	2026-01-29 05:46:51.874613
33	37	Corporation Bank	NULL	CORP	t	2026-01-29 05:46:51.886543	2026-01-29 05:46:51.886543
34	38	Credit Agricole Corporate And Investment Bank Calyon Bank	NULL	CRLY	f	2026-01-29 05:46:51.903062	2026-01-29 05:46:51.903062
35	39	DBS Bank	NULL	DBSS	t	2026-01-29 05:46:51.913977	2026-01-29 05:46:51.913977
36	41	Deutsche Bank AG	NULL	DEUT	f	2026-01-29 05:46:51.924671	2026-01-29 05:46:51.924671
37	42	Development Credit Bank	NULL	DCBL	t	2026-01-29 05:46:51.936691	2026-01-29 05:46:51.936691
38	43	Dhanlaxmi Bank	NULL	DLXB	t	2026-01-29 05:46:51.947895	2026-01-29 05:46:51.947895
39	44	Deposit Insurance and Credit Guarantee Corporation	NULL	DICG	f	2026-01-29 05:46:51.961016	2026-01-29 05:46:51.961016
40	45	Dombivli Nagari Sahakari Bank	NULL	DNSB	t	2026-01-29 05:46:51.971792	2026-01-29 05:46:51.971792
41	46	Firstrand Bank	NULL	FIRN	f	2026-01-29 05:46:51.983575	2026-01-29 05:46:51.983575
42	47	HSBC	NULL	HSBC	t	2026-01-29 05:46:51.998373	2026-01-29 05:46:51.998373
43	48	IndusInd Bank	INDB0000002	INDB	t	2026-01-29 05:46:52.011588	2026-01-29 05:46:52.011588
44	49	ING Vysya Bank	VYSA0005090	VYSA	t	2026-01-29 05:46:52.027058	2026-01-29 05:46:52.027058
45	50	Janakalyan Sahakari Bank	NULL	JSBL	t	2026-01-29 05:46:52.038701	2026-01-29 05:46:52.038701
46	51	Janata Sahakari Bank Pune	NULL	JSBP	t	2026-01-29 05:46:52.050711	2026-01-29 05:46:52.050711
47	52	JP Morgan Chase Bank	NULL	CHAS	f	2026-01-29 05:46:52.066365	2026-01-29 05:46:52.066365
48	53	Kapole Co-Op Bank	NULL	KCBL	f	2026-01-29 05:46:52.079017	2026-01-29 05:46:52.079017
49	54	Karnataka Bank	KARB0000005	KARB	t	2026-01-29 05:46:52.089872	2026-01-29 05:46:52.089872
50	55	Karur Vysya Bank	NULL	KVBL	t	2026-01-29 05:46:52.102568	2026-01-29 05:46:52.102568
51	56	Kotak Mahindra Bank	KKBK0000731	KKBK	t	2026-01-29 05:46:52.119833	2026-01-29 05:46:52.119833
52	57	Mahanagar Co-Op Bank	NULL	MCBL	t	2026-01-29 05:46:52.130491	2026-01-29 05:46:52.130491
53	58	Maharashtra State Co-Op Bank	NULL	MSCI	t	2026-01-29 05:46:52.142292	2026-01-29 05:46:52.142292
54	59	Mashreq Bank PSC	NULL	MSHQ	f	2026-01-29 05:46:52.156183	2026-01-29 05:46:52.156183
55	60	Mizuho Corporate Bank	NULL	MHCB	f	2026-01-29 05:46:52.169913	2026-01-29 05:46:52.169913
56	61	New India Co-Op Bank Ltd	NULL	NICB	f	2026-01-29 05:46:52.184125	2026-01-29 05:46:52.184125
57	62	NKGSB Co-Op Bank	NULL	NKGS	t	2026-01-29 05:46:52.197574	2026-01-29 05:46:52.197574
58	63	Nutan Nagarik Sahakari Bank	NNSB	NNSB	t	2026-01-29 05:46:52.210669	2026-01-29 05:46:52.210669
59	64	Oman International Bank Saog	NULL	OIBA	f	2026-01-29 05:46:52.223762	2026-01-29 05:46:52.223762
60	65	Oriental Bank of Commerce	ORBC0101319	ORBC	t	2026-01-29 05:46:52.236016	2026-01-29 05:46:52.236016
61	66	Parsik Janata Sahakari Bank	NULL	PJSB	t	2026-01-29 05:46:52.251198	2026-01-29 05:46:52.251198
62	67	Punjab And Maharashtra Co-Op Bank	NULL	PMCB	t	2026-01-29 05:46:52.266414	2026-01-29 05:46:52.266414
63	68	Punjab and Sind Bank	PSIB0000005	PSIB	t	2026-01-29 05:46:52.280702	2026-01-29 05:46:52.280702
64	69	Rajkot Nagarik Sahakari Bank	NULL	RNSB	t	2026-01-29 05:46:52.293229	2026-01-29 05:46:52.293229
65	70	Reserve Bank of India	NULL	RBIS	f	2026-01-29 05:46:52.306364	2026-01-29 05:46:52.306364
66	71	Shinhan Bank	NULL	SHBK	t	2026-01-29 05:46:52.319594	2026-01-29 05:46:52.319594
67	72	Societe Generale Bank	NULL	SOGE	f	2026-01-29 05:46:52.333841	2026-01-29 05:46:52.333841
68	73	South Indian Bank	NULL	SIBL	t	2026-01-29 05:46:52.348979	2026-01-29 05:46:52.348979
69	74	Standard Chartered Bank	NULL	SCBL	t	2026-01-29 05:46:52.363357	2026-01-29 05:46:52.363357
70	76	State Bank of Mauritius/Mool	NULL	STCB	f	2026-01-29 05:46:52.381685	2026-01-29 05:46:52.381685
71	81	Tamilnad Mercantile Bank	TMBL0000151	TMBL	t	2026-01-29 05:46:52.394007	2026-01-29 05:46:52.394007
72	82	Bank of Nova Scotia	NULL	NOSC	f	2026-01-29 05:46:52.406546	2026-01-29 05:46:52.406546
73	83	Ahmedabad Mercantile Co-Op Bank	NULL	AMCB	t	2026-01-29 05:46:52.422576	2026-01-29 05:46:52.422576
74	84	Bharat Co-Op Bank Mumbai	NULL	BCBM	t	2026-01-29 05:46:52.434911	2026-01-29 05:46:52.434911
75	85	Cosmos Co-Op Bank	NULL	COSB	t	2026-01-29 05:46:52.446604	2026-01-29 05:46:52.446604
76	86	Federal Bank	NULL	FDRL	t	2026-01-29 05:46:52.460294	2026-01-29 05:46:52.460294
77	87	Greater Bombay Co-Op Bank	NULL	GBCB	t	2026-01-29 05:46:52.471795	2026-01-29 05:46:52.471795
78	88	Jammu and Kashmir Bank	NULL	JAKA	t	2026-01-29 05:46:52.483777	2026-01-29 05:46:52.483777
79	89	Kalupur Commercial Co-Op Bank	NULL	KCCB	t	2026-01-29 05:46:52.493624	2026-01-29 05:46:52.493624
80	90	Karnataka State Apex Co-Op Bank	NULL	KSBC	f	2026-01-29 05:46:52.506472	2026-01-29 05:46:52.506472
81	91	Kalyan Janata Sahakari Bank	NULL	KJSB	t	2026-01-29 05:46:52.519458	2026-01-29 05:46:52.519458
82	92	Lakshmi Vilas Bank	NULL	LAVB	t	2026-01-29 05:46:52.536067	2026-01-29 05:46:52.536067
83	93	Mehsana Urban Co-Op Bank	NULL	MSNU	t	2026-01-29 05:46:52.5475	2026-01-29 05:46:52.5475
84	94	Nainital Bank	NULL	NTBL	t	2026-01-29 05:46:52.558748	2026-01-29 05:46:52.558748
85	95	The Ratnakar Bank Ltd	NULL	RATN	t	2026-01-29 05:46:52.569103	2026-01-29 05:46:52.569103
86	96	Royal Bank of Scotland	NULL	ABNA	f	2026-01-29 05:46:52.596398	2026-01-29 05:46:52.596398
87	97	Saraswat Co-Op Bank	NULL	SRCB	t	2026-01-29 05:46:52.610804	2026-01-29 05:46:52.610804
88	98	Shamrao Vithal Co-Op Bank	NULL	SVCB	t	2026-01-29 05:46:52.621858	2026-01-29 05:46:52.621858
89	99	The Surat Peoples Co-Op Bank	NULL	SPCB	t	2026-01-29 05:46:52.632137	2026-01-29 05:46:52.632137
90	100	Thane Janata Sahakari Bank	NULL	TJSB	t	2026-01-29 05:46:52.643635	2026-01-29 05:46:52.643635
91	101	Tamilnadu State Apex Co-Op Bank	NULL	TNSC	t	2026-01-29 05:46:52.654469	2026-01-29 05:46:52.654469
92	102	West Bengal State Co-Op Bank	NULL	WBSC	f	2026-01-29 05:46:52.667588	2026-01-29 05:46:52.667588
93	103	Vijaya Bank	NULL	VIJB	t	2026-01-29 05:46:52.680711	2026-01-29 05:46:52.680711
94	108	State Bank of India	SBIN0009062	SBIN	t	2026-01-29 05:46:52.691562	2026-01-29 05:46:52.691562
95	109	A P Mahesh Co-Op Urban Bank Ltd	NULL	APMC	t	2026-01-29 05:46:52.703137	2026-01-29 05:46:52.703137
96	110	Karad Urban Co-Op Bank	NULL	KUCB	t	2026-01-29 05:46:52.725341	2026-01-29 05:46:52.725341
97	111	Karnataka State Co-Op Apex Bank	NULL	KSCB	f	2026-01-29 05:46:52.736544	2026-01-29 05:46:52.736544
98	112	Nashik Merchants Co-Op Bank	NULL	NMCB	t	2026-01-29 05:46:52.747162	2026-01-29 05:46:52.747162
99	113	UBS AG Bank	NULL	UBSW	f	2026-01-29 05:46:52.757463	2026-01-29 05:46:52.757463
100	114	United Bank of India	UTBI0CON702	UTBI	t	2026-01-29 05:46:52.776357	2026-01-29 05:46:52.776357
101	115	Kangra Co-Op Bank	NULL	KANG	f	2026-01-29 05:46:52.789531	2026-01-29 05:46:52.789531
102	116	Kangra Central Co-Op Bank	NULL	KACE	t	2026-01-29 05:46:52.801337	2026-01-29 05:46:52.801337
103	117	Prathama Bank	NULL	PRTH	t	2026-01-29 05:46:52.815238	2026-01-29 05:46:52.815238
104	119	Chaitanya Godavari Grameena Bank	UBIN0CG7999	ACGG	t	2026-01-29 05:46:52.826327	2026-01-29 05:46:52.826327
105	121	Rushikulya Gramin Bank	ANDB0008999	ANDG	f	2026-01-29 05:46:52.839722	2026-01-29 05:46:52.839722
106	122	Sharda Gramin Bank	ALLA0SG5001	ASGB	f	2026-01-29 05:46:52.853116	2026-01-29 05:46:52.853116
107	123	Nainital Almora Kshetriya Gramin Bank	BARB0NAKGBX	BARG	f	2026-01-29 05:46:52.865893	2026-01-29 05:46:52.865893
108	124	Baroda Rajasthan Gramin Bank	BARB0BRGBXX	BARR	t	2026-01-29 05:46:52.879724	2026-01-29 05:46:52.879724
109	125	Baroda Uttar Pradesh Gramin Bank	BARB0BUPGBX	BARU	t	2026-01-29 05:46:52.891705	2026-01-29 05:46:52.891705
110	126	Baroda Gujarat Gramin Bank	BARB0BGGBXX	BGGB	t	2026-01-29 05:46:52.901789	2026-01-29 05:46:52.901789
111	127	Jhabua Dhar Kshetriya Gramin Bank	BARB0JDKGBX	BJDG	f	2026-01-29 05:46:52.916103	2026-01-29 05:46:52.916103
112	129	Durg Rajnandgaon Gramin Bank	BKDN0800000	BKDR	f	2026-01-29 05:46:52.927171	2026-01-29 05:46:52.927171
113	130	Baitarani Gramin Bank	BKID0BAITGB	BKIB	f	2026-01-29 05:46:52.940788	2026-01-29 05:46:52.940788
114	131	Aryavart Gramin Bank	BKID0ARYAGB	BKIG	t	2026-01-29 05:46:52.953699	2026-01-29 05:46:52.953699
115	133	Wainganga Krishna Gramin Bank	BKID0WAINGB	BWKG	f	2026-01-29 05:46:52.965847	2026-01-29 05:46:52.965847
116	134	Uttar Bihar Gramin Bank	CBIN0R10001	CBBB	t	2026-01-29 05:46:52.977788	2026-01-29 05:46:52.977788
117	135	Ballia Etawah Gramin Bank	CBIN0R30001	CBIG	f	2026-01-29 05:46:52.988416	2026-01-29 05:46:52.988416
118	136	Hadoti Kshetriya Gramin Bank	CBIN0R70036	CBIH	f	2026-01-29 05:46:53.001573	2026-01-29 05:46:53.001573
119	137	Surguja Kshetriya Gramin Bank	CBIN0R60051	CKGB	f	2026-01-29 05:46:53.014591	2026-01-29 05:46:53.014591
120	138	South Malabar Gramin Bank	CNRB00SMGB4	CMGB	f	2026-01-29 05:46:53.026318	2026-01-29 05:46:53.026318
121	139	Chickmangalur Kodagu Gramin Bank	CORP0CK0001	CORG	f	2026-01-29 05:46:53.038904	2026-01-29 05:46:53.038904
122	140	Pragathi Gramin Bank	CNRB000PGB1	CPGB	f	2026-01-29 05:46:53.050235	2026-01-29 05:46:53.050235
123	141	Shreyas Gramin Bank	CNRB000SGB7	CSGB	f	2026-01-29 05:46:53.06481	2026-01-29 05:46:53.06481
124	142	Satpura Narmada Kshetriya Gramin Bank	CBIN0R20002	CSUG	f	2026-01-29 05:46:53.078935	2026-01-29 05:46:53.078935
125	143	Uttar Banga Kshetriya Gramin Bank	CBIN0R40012	CUKG	f	2026-01-29 05:46:53.089167	2026-01-29 05:46:53.089167
126	144	Vidharbha Kshetriya Gramin Bank	CBIN0R50002	CVAG	f	2026-01-29 05:46:53.09924	2026-01-29 05:46:53.09924
127	145	Madhya Bharat Gramin Bank	NULL	FBIG	f	2026-01-29 05:46:53.112708	2026-01-29 05:46:53.112708
128	146	Gurgaon Gramin Bank	GGBK0000001	GGBK	f	2026-01-29 05:46:53.122735	2026-01-29 05:46:53.122735
129	147	Malwa Gramin Bank	HDFC0001431	HDFG	f	2026-01-29 05:46:53.136346	2026-01-29 05:46:53.136346
130	148	Mewar Anchalik Gramin Bank	ICIC00MEWAR	ICIG	f	2026-01-29 05:46:53.147202	2026-01-29 05:46:53.147202
131	149	Pallavan Grama Bank	IDIB0PLB001	IDIG	f	2026-01-29 05:46:53.159795	2026-01-29 05:46:53.159795
132	150	Neelachal Gramya Bank	IOBA0000159	INGB	f	2026-01-29 05:46:53.170761	2026-01-29 05:46:53.170761
133	151	Pandyan Gramin Bank	IOBA0PGB001	IOBG	t	2026-01-29 05:46:53.182457	2026-01-29 05:46:53.182457
134	153	J&K Grameen Bank	JAKA0GRAMEN	JAKG	t	2026-01-29 05:46:53.195096	2026-01-29 05:46:53.195096
135	154	Maharashtra Gramin Bank	NULL	MAHG	t	2026-01-29 05:46:53.206608	2026-01-29 05:46:53.206608
136	156	Rajasthan Gramin Bank	PUNB0001300	PRGB	f	2026-01-29 05:46:53.220115	2026-01-29 05:46:53.220115
137	157	Sarva UP Gramin Bank	PUNB0SUPGB5	PSGB	t	2026-01-29 05:46:53.232592	2026-01-29 05:46:53.232592
138	158	Sutlej Gramin Bank	PSIB0SGB002	PSIG	t	2026-01-29 05:46:53.24433	2026-01-29 05:46:53.24433
139	159	Himachal Gramin Bank	PUNB0HPGB04	PUHG	t	2026-01-29 05:46:53.254456	2026-01-29 05:46:53.254456
140	160	Madhya Bihar Gramin Bank	PUNB0MBGB06	PUNG	t	2026-01-29 05:46:53.268866	2026-01-29 05:46:53.268866
141	161	Sarva Haryana Gramin Bank	PUNB0HGB001	PUNH	t	2026-01-29 05:46:53.281083	2026-01-29 05:46:53.281083
142	162	Andhra Pradesh Grameena Vikas Bank	NULL	APGV	t	2026-01-29 05:46:53.295007	2026-01-29 05:46:53.295007
143	163	Arunachal Pradesh Rural Bank	SBIN0RRARGB	SBAP	t	2026-01-29 05:46:53.305734	2026-01-29 05:46:53.305734
144	164	MG Baroda Gramin Bank	SBBJ0RRMRGB	SBBG	f	2026-01-29 05:46:53.317508	2026-01-29 05:46:53.317508
145	165	Telangana Grameena Bank	NULL	SBHG	t	2026-01-29 05:46:53.332044	2026-01-29 05:46:53.332044
146	166	Chhattisgarh Gramin Bank	SBIN0RRCHGB	SBIC	t	2026-01-29 05:46:53.343183	2026-01-29 05:46:53.343183
147	167	Ellaqui Dehati Bank	SBIN0RRELGB	SBIE	t	2026-01-29 05:46:53.354683	2026-01-29 05:46:53.354683
148	168	Mizoram Rural Bank	SBIN0RRMIGB	SBIG	t	2026-01-29 05:46:53.369267	2026-01-29 05:46:53.369267
149	169	Jharkhand Gramin Bank	NULL	SBIJ	f	2026-01-29 05:46:53.379793	2026-01-29 05:46:53.379793
150	170	Kaveri Grameena Bank	NULL	SBMG	t	2026-01-29 05:46:53.394772	2026-01-29 05:46:53.394772
151	171	Vidisha Bhopal Kshetriya Gramin Bank	SBIN0RRVDGB	SBOG	f	2026-01-29 05:46:53.409646	2026-01-29 05:46:53.409646
152	172	Krishna Gramin Bank	SBIN0RRKRGB	SKRG	f	2026-01-29 05:46:53.424019	2026-01-29 05:46:53.424019
153	173	Langpi Dehangi Rural Bank	SBIN0RRLDGB	SLDR	t	2026-01-29 05:46:53.437257	2026-01-29 05:46:53.437257
154	174	Meghalaya Rural Bank	SBIN0RRMEGB	SMEG	t	2026-01-29 05:46:53.450585	2026-01-29 05:46:53.450585
155	176	Parvatiya Gramin Bank	SBIN0RRPRGB	SPGB	f	2026-01-29 05:46:53.463439	2026-01-29 05:46:53.463439
156	177	Purvanchal Gramin Bank	SBIN0RRPUGB	SRGB	t	2026-01-29 05:46:53.474368	2026-01-29 05:46:53.474368
157	179	Saurashtra Gramin Bank	SBIN0RRSRGB	SSGB	t	2026-01-29 05:46:53.487289	2026-01-29 05:46:53.487289
158	180	Samastipur Kshetriya Gramin Bank	SBIN0RRSMGB	SSKG	f	2026-01-29 05:46:53.501021	2026-01-29 05:46:53.501021
159	181	Uttarakhand Gramin Bank	SBIN0RRUTGB	SUTG	t	2026-01-29 05:46:53.517844	2026-01-29 05:46:53.517844
160	182	Utkal Gramya Bank	SBIN0RRUKGB	SUUG	t	2026-01-29 05:46:53.532503	2026-01-29 05:46:53.532503
161	184	Karnataka Vikas Grameena Bank	KVGB0001510	KVGB	t	2026-01-29 05:46:53.543595	2026-01-29 05:46:53.543595
162	185	Andhra Pragathi Grameena Bank	NULL	APGB	t	2026-01-29 05:46:53.557501	2026-01-29 05:46:53.557501
163	186	North Malabar Gramin Bank	SYNB0004200	SYNM	f	2026-01-29 05:46:53.573231	2026-01-29 05:46:53.573231
164	187	Assam Gramin Vikash Bank	PUNB0RRBAGB	UASG	t	2026-01-29 05:46:53.583721	2026-01-29 05:46:53.583721
165	188	Kashi Gomati Samyut Gramin Bank	UBIN0RRBKGS	UBKG	t	2026-01-29 05:46:53.596638	2026-01-29 05:46:53.596638
166	189	Mahakaushal Kshetriya Gramin Bank	UCBA0RRBMKG	UCBG	f	2026-01-29 05:46:53.607228	2026-01-29 05:46:53.607228
167	190	Bihar Kshetriya Gramin Bank	UCBA0RRBBKG	UCBK	t	2026-01-29 05:46:53.622061	2026-01-29 05:46:53.622061
168	191	Kalinga Gramya Bank	UCBA0RRBKGB	UCKG	f	2026-01-29 05:46:53.631853	2026-01-29 05:46:53.631853
169	192	Jaipur Thar Gramin Bank	UCBA0RRBJTG	UJTG	f	2026-01-29 05:46:53.643698	2026-01-29 05:46:53.643698
170	193	Paschim Banga Gramin Bank	UCBA0RRBPBG	UPBG	t	2026-01-29 05:46:53.654244	2026-01-29 05:46:53.654244
171	194	Rewa Sidhi Gramin Bank	UBIN0RRBRSG	URSG	f	2026-01-29 05:46:53.66843	2026-01-29 05:46:53.66843
172	196	Manipur Rural Bank	UTBI0RRBMRB	UTBG	t	2026-01-29 05:46:53.683071	2026-01-29 05:46:53.683071
173	197	Tripura Gramin Bank	PUNB0RRBTGB	UTGB	t	2026-01-29 05:46:53.695017	2026-01-29 05:46:53.695017
174	198	Visveshwaraya Gramin Bank	VIJB0009999	VIJG	f	2026-01-29 05:46:53.710421	2026-01-29 05:46:53.710421
175	199	Swarna Bharat Trust Cyber Grameen	ANDB0001538	SBCG	f	2026-01-29 05:46:53.722135	2026-01-29 05:46:53.722135
176	200	Neft Malwa Gramin Bank	STBP0RRMLGB	NMGB	f	2026-01-29 05:46:53.731469	2026-01-29 05:46:53.731469
177	202	Barclays Credit Card	BARC0INBBIR	BACC	t	2026-01-29 05:46:53.74746	2026-01-29 05:46:53.74746
178	203	Citibank Credit Card	CITI0000003	CICC	f	2026-01-29 05:46:53.757957	2026-01-29 05:46:53.757957
179	204	HDFC Bank Credit Card	HDFC0000128	HDCC	t	2026-01-29 05:46:53.769143	2026-01-29 05:46:53.769143
180	205	HSBC Credit Card	HSBC0400002	HSCC	f	2026-01-29 05:46:53.78439	2026-01-29 05:46:53.78439
181	206	ICICI Bank Credit Card	ICIC0000103	ICCC	f	2026-01-29 05:46:53.79552	2026-01-29 05:46:53.79552
182	207	Kotak Mahindra Credit Card	KKBK0000958	KKCC	t	2026-01-29 05:46:53.806916	2026-01-29 05:46:53.806916
183	208	State Bank of India Credit Card	SBIN00CARDS	SBCC	f	2026-01-29 05:46:53.820096	2026-01-29 05:46:53.820096
184	209	Standard Chartered Credit Card	SCBL0036001	SCCC	f	2026-01-29 05:46:53.832526	2026-01-29 05:46:53.832526
185	210	Axis Bank Credit Card	UTIB0000400	ABCC	t	2026-01-29 05:46:53.848206	2026-01-29 05:46:53.848206
186	211	Vijaya Credit Card	VIJB0009020	VICC	t	2026-01-29 05:46:53.860389	2026-01-29 05:46:53.860389
187	212	American Express Credit Card	SCBL0036020	AMEX	f	2026-01-29 05:46:53.875313	2026-01-29 05:46:53.875313
188	213	Janaseva Sahakari Bank	NULL	JANA	t	2026-01-29 05:46:53.886661	2026-01-29 05:46:53.886661
189	214	Kallappanna Awade Ichalkaranji Janata Sahkari Bank	NULL	KAIJ	t	2026-01-29 05:46:53.897345	2026-01-29 05:46:53.897345
190	215	Pandharpur Merchant Co-Op Bank	ICIC00PMCBL	ICIP	t	2026-01-29 05:46:53.909687	2026-01-29 05:46:53.909687
191	216	The Gayatri Co Operative Urban Bank Ltd	HDFC0CTGCUB	HDGB	t	2026-01-29 05:46:53.921609	2026-01-29 05:46:53.921609
192	217	Pochampally Co-Op Urban Bank	HDFC0CPCUBL	HDFP	t	2026-01-29 05:46:53.933304	2026-01-29 05:46:53.933304
193	218	Dr Annasaheb Chougule Urban Co-Op Bank	HDFC0CDACUB	HDFA	t	2026-01-29 05:46:53.948518	2026-01-29 05:46:53.948518
194	219	Surat District Co-Op Bank	SDCB0000001	SDCB	t	2026-01-29 05:46:53.962844	2026-01-29 05:46:53.962844
195	220	Suco Souharda Sahakari Bank	HDFC0CSUCOB	HDFS	t	2026-01-29 05:46:53.973889	2026-01-29 05:46:53.973889
196	221	Pune Peoples Co-Op Bank	IBKL0548PPC	IBKP	t	2026-01-29 05:46:53.992135	2026-01-29 05:46:53.992135
197	222	Shri Arihant Co-Op Bank	ICIC00ARIHT	ICSA	t	2026-01-29 05:46:54.003849	2026-01-29 05:46:54.003849
198	223	The National Co-Op Bank Ltd	YESB0NBL002	KKBN	t	2026-01-29 05:46:54.016869	2026-01-29 05:46:54.016869
199	224	Parshwanath Co-Op Bank	HDFC0CPCB01	HDPA	t	2026-01-29 05:46:54.028971	2026-01-29 05:46:54.028971
200	225	Apna Sahakari Bank	NULL	ASBL	t	2026-01-29 05:46:54.040483	2026-01-29 05:46:54.040483
201	226	Jalore Nagrik Sahakari Bank	HDFC0CJALOR	HDJC	t	2026-01-29 05:46:54.054091	2026-01-29 05:46:54.054091
202	227	Varachha Co-Op Bank	VARA0000001	VARA	t	2026-01-29 05:46:54.066102	2026-01-29 05:46:54.066102
203	228	Janata Co-Op Bank Malegaon	HDFC0CJBMLG	HDFJ	t	2026-01-29 05:46:54.078499	2026-01-29 05:46:54.078499
204	229	Shri Basaveshwar Sahakari Bank Niyamit Bagalkot	ICIC00SBSBN	ICIS	t	2026-01-29 05:46:54.090474	2026-01-29 05:46:54.090474
205	230	Shirpur Peoples Co-Op Bank	KKBK0SPCB01	KKBS	t	2026-01-29 05:46:54.102273	2026-01-29 05:46:54.102273
206	232	Kerala Gramin Bank	NULL	KLGB	t	2026-01-29 05:46:54.120503	2026-01-29 05:46:54.120503
207	233	Pragathi Krishna Gramin Bank	NULL	PKGB	t	2026-01-29 05:46:54.142667	2026-01-29 05:46:54.142667
208	234	Yadagiri Lakshmi Narasimha Swamy Co-Op Urban Bank	YESB0YLNS01	YESP	t	2026-01-29 05:46:54.155675	2026-01-29 05:46:54.155675
209	235	Hutatma Sahakari Bank	ICIC00HSBLW	ICIH	t	2026-01-29 05:46:54.169807	2026-01-29 05:46:54.169807
210	236	Himachal Pradesh State Co-Op Bank	NULL	HPSC	t	2026-01-29 05:46:54.180277	2026-01-29 05:46:54.180277
211	237	Adarsh Urban Co-Op Bank Hyderabad	ICIC00ADRSH	ICIA	t	2026-01-29 05:46:54.195155	2026-01-29 05:46:54.195155
212	238	Mayani Urban Co-Op Bank	ICIC00TMUCB	ICIM	t	2026-01-29 05:46:54.207083	2026-01-29 05:46:54.207083
213	239	Pandharpur Urban Co-Op Bank	ICIC00PUCCB	ICPU	t	2026-01-29 05:46:54.222141	2026-01-29 05:46:54.222141
214	240	Vananchal Gramin Bank	SBIN0RRVCGB	SVAG	t	2026-01-29 05:46:54.233321	2026-01-29 05:46:54.233321
215	241	Punjab Gramin Bank	NULL	PPGB	t	2026-01-29 05:46:54.24652	2026-01-29 05:46:54.24652
216	242	Shri Veershaiv Co-Op Bank Ltd	NULL	SVSH	t	2026-01-29 05:46:54.262044	2026-01-29 05:46:54.262044
217	243	Thrissur District Central Co-Op Bank	IBKL0269TDC	TDCB	t	2026-01-29 05:46:54.274172	2026-01-29 05:46:54.274172
218	244	Vishweshwar Sahakari Bank Ltd	VSBL0000001	VSBL	t	2026-01-29 05:46:54.285196	2026-01-29 05:46:54.285196
219	245	Raipur Urban Mercantile Co-Op Bank	HDFC0CTRUMC	HDRU	t	2026-01-29 05:46:54.29605	2026-01-29 05:46:54.29605
220	246	Zila Sahkari Bank	NULL	ICZS	f	2026-01-29 05:46:54.310173	2026-01-29 05:46:54.310173
221	247	Titwala	SBIN0016389	SBIT	f	2026-01-29 05:46:54.321528	2026-01-29 05:46:54.321528
222	248	Dombivli East	SBIN0007124	SBDO	f	2026-01-29 05:46:54.334737	2026-01-29 05:46:54.334737
223	250	MGCB Main	WBSC0MGCB01	WBMG	f	2026-01-29 05:46:54.347128	2026-01-29 05:46:54.347128
224	251	Sindhudurg District Central Co-Op Bank	HDFC0CSINDC	HDSI	t	2026-01-29 05:46:54.359694	2026-01-29 05:46:54.359694
225	252	Hamirpur District Co-Op Bank Mahoba	UPCB00HDCCB	ICMA	t	2026-01-29 05:46:54.369692	2026-01-29 05:46:54.369692
226	253	Shivalik Mercantile Co-Op Bank	NULL	SMCB	t	2026-01-29 05:46:54.38375	2026-01-29 05:46:54.38375
227	254	Hasti Co-Op Bank	HCBL0000001	HCBL	t	2026-01-29 05:46:54.398456	2026-01-29 05:46:54.398456
228	255	Rajgurunagar Sahakari Bank	RSBL0000003	RSBL	t	2026-01-29 05:46:54.40968	2026-01-29 05:46:54.40968
229	256	Bandhan Bank	BDBL0001000	BDBL	t	2026-01-29 05:46:54.424915	2026-01-29 05:46:54.424915
230	257	Dapoli Urban Co-Op Bank	IBKL0116DPC	IBDU	f	2026-01-29 05:46:54.439969	2026-01-29 05:46:54.439969
231	258	Gujarat State Co-Op Bank	NULL	GSCB	t	2026-01-29 05:46:54.450928	2026-01-29 05:46:54.450928
232	259	Municipal Co-Op Bank	MUBL0000001	MUBL	t	2026-01-29 05:46:54.464136	2026-01-29 05:46:54.464136
233	260	Rajapur Urban Co-Op Bank	ICIC00RUCBL	ICRU	t	2026-01-29 05:46:54.474107	2026-01-29 05:46:54.474107
234	261	Ahmedabad District Central Co-Op Bank	GSCB0ADC001	GSAD	t	2026-01-29 05:46:54.486724	2026-01-29 05:46:54.486724
235	262	IDFC First Bank Limited	IDFB0000001	IDFB	t	2026-01-29 05:46:54.502203	2026-01-29 05:46:54.502203
236	263	Rajasthan Marudhara Gramin Bank	NULL	SBRM	t	2026-01-29 05:46:54.518357	2026-01-29 05:46:54.518357
237	264	Suvarnayug Sahakari Bank	HDFC0CSUVRN	SUSB	t	2026-01-29 05:46:54.531267	2026-01-29 05:46:54.531267
238	265	Sutex Co-Op Bank	SUTB0248001	SUTB	t	2026-01-29 05:46:54.548849	2026-01-29 05:46:54.548849
239	266	Nagar Sahkari Bank	YESB0NSB001	NASB	f	2026-01-29 05:46:54.56319	2026-01-29 05:46:54.56319
240	267	Irinjalakuda Town Co-Op Bank	HDFC0CITC01	IRTO	t	2026-01-29 05:46:54.575948	2026-01-29 05:46:54.575948
241	268	Shivajirao Bhosale Sahakari Bank	HDFC0CSBB01	SHBH	t	2026-01-29 05:46:54.59464	2026-01-29 05:46:54.59464
242	269	Thane Bharat Sahakari Bank	NULL	TBSB	t	2026-01-29 05:46:54.607255	2026-01-29 05:46:54.607255
243	270	Maratha Co-Op Bank	IBKL0101MCB	MCOB	t	2026-01-29 05:46:54.626375	2026-01-29 05:46:54.626375
244	271	Pithoragarh Jila Sahkari Bank	IBKL0768PJS	IBJS	t	2026-01-29 05:46:54.638738	2026-01-29 05:46:54.638738
245	272	Pune Cantonment Sahakari Bank	HDFC0CPCSBL	PCSB	t	2026-01-29 05:46:54.651073	2026-01-29 05:46:54.651073
246	274	The Malad Sahakari Bank Ltd	HDFC0CMALAD	MASB	t	2026-01-29 05:46:54.668545	2026-01-29 05:46:54.668545
247	275	Shree Mahalaxmi Co-Op Bank	IBKL0116MC0	SML	t	2026-01-29 05:46:54.679176	2026-01-29 05:46:54.679176
248	276	Moradabad Zila Sahkari Bank	NULL	MZSB	f	2026-01-29 05:46:54.691993	2026-01-29 05:46:54.691993
249	277	Siwan Central Co-Op Bank	IBKL01076SB	SCCB	t	2026-01-29 05:46:54.705353	2026-01-29 05:46:54.705353
250	278	Madhyanchal Gramin Bank	SBIN0RRMBGB	MGBS	t	2026-01-29 05:46:54.717119	2026-01-29 05:46:54.717119
251	279	Triveni Kshetriya Gramin Bank	NULL	TKGB	f	2026-01-29 05:46:54.731928	2026-01-29 05:46:54.731928
252	280	The Ratnakar Bank Credit Card	RATN0CRCARD	RRCC	f	2026-01-29 05:46:54.744459	2026-01-29 05:46:54.744459
253	281	Punjab National Bank Credit Card	PUNB0112000	PBCC	f	2026-01-29 05:46:54.75576	2026-01-29 05:46:54.75576
254	283	IndusInd Bank Credit Card	INDB0000018	IBCC	t	2026-01-29 05:46:54.771375	2026-01-29 05:46:54.771375
255	284	Canara Bank Credit Card	CNRB0001912	CBCC	t	2026-01-29 05:46:54.793014	2026-01-29 05:46:54.793014
256	285	IDBI Bank Credit Card	IBKL0NEFT01	IDCC	t	2026-01-29 05:46:54.808063	2026-01-29 05:46:54.808063
257	286	Union Bank of India Credit Card	ANDB0000205	UBCC	t	2026-01-29 05:46:54.826092	2026-01-29 05:46:54.826092
258	287	Bank Of India Credit Card	BKID0000101	BKCC	t	2026-01-29 05:46:54.839759	2026-01-29 05:46:54.839759
259	288	Bank Of Baroda Credit Card	BARB0COLABA	BABC	t	2026-01-29 05:46:54.850455	2026-01-29 05:46:54.850455
260	289	Odisha Gramya Bank	IOBA0ROGB01	IOGB	t	2026-01-29 05:46:54.862474	2026-01-29 05:46:54.862474
261	290	The Udaipur Mahila Samridhi Urban Co-Op Bank Ltd	NULL	UMSC	t	2026-01-29 05:46:54.877552	2026-01-29 05:46:54.877552
262	291	Delhi State Co-Op Bank	NULL	DSCB	f	2026-01-29 05:46:54.890967	2026-01-29 05:46:54.890967
263	292	Citizen Co-Op Bank Noida	NULL	COBL	t	2026-01-29 05:46:54.924905	2026-01-29 05:46:54.924905
264	293	Chikhli Urban Co-Op Bank	HDFC0CCUB01	CUCB	t	2026-01-29 05:46:54.941126	2026-01-29 05:46:54.941126
265	294	Poornawadi Nagrik Sahakari Bank	HDFC0CPNSBL	PNSB	t	2026-01-29 05:46:54.952538	2026-01-29 05:46:54.952538
266	295	Ahmednagar Mer Co-Op Bank	HDFC0CMBANK	AGBL	t	2026-01-29 05:46:54.969117	2026-01-29 05:46:54.969117
267	296	Pavana Sahakari Bank	IBKL0087PSB	PSBL	t	2026-01-29 05:46:54.987648	2026-01-29 05:46:54.987648
268	297	Fingrowth Co-Op Bank Ltd	HDFC0CTUCBL	UCBL	t	2026-01-29 05:46:55.002551	2026-01-29 05:46:55.002551
269	298	Airtel Payments Bank	AIRP0000001	AIRP	t	2026-01-29 05:46:55.015079	2026-01-29 05:46:55.015079
270	299	Jalgaon Peoples Co-Op Bank	NULL	JPCB	t	2026-01-29 05:46:55.030242	2026-01-29 05:46:55.030242
271	300	Vasai Vikas Co-Op Bank	VVSB0000001	VVSB	t	2026-01-29 05:46:55.04102	2026-01-29 05:46:55.04102
272	301	Equitas Small Finance Bank	NULL	ESFB	t	2026-01-29 05:46:55.0524	2026-01-29 05:46:55.0524
273	302	Noble Co-Op Bank	ICIC00NOBCL	NCBL	t	2026-01-29 05:46:55.063709	2026-01-29 05:46:55.063709
274	303	Jalaun District Co-Op Bank	UPCB00JDCBL	JDCB	t	2026-01-29 05:46:55.081491	2026-01-29 05:46:55.081491
275	304	Vaidyanath Urban Co-Op Bank	NULL	VUCB	f	2026-01-29 05:46:55.094913	2026-01-29 05:46:55.094913
276	305	Sapthagiri Grameena Bank	IDIB0SGB001	SGCB	t	2026-01-29 05:46:55.107397	2026-01-29 05:46:55.107397
277	306	Ambarnath Jai Hind Co-Op Bank	ICIC00AJHCB	AJHB	t	2026-01-29 05:46:55.122879	2026-01-29 05:46:55.122879
278	307	Seva Vikas Co-Op Bank	NULL	SVBL	f	2026-01-29 05:46:55.138332	2026-01-29 05:46:55.138332
279	308	Pachora Peoples Co-Op Bank	NULL	PPCB	f	2026-01-29 05:46:55.150529	2026-01-29 05:46:55.150529
280	309	India Post Payment Bank	null	IPOS	t	2026-01-29 05:46:55.161442	2026-01-29 05:46:55.161442
281	310	Bombay Mercantile Co-Op Bank	NULL	BMCL	t	2026-01-29 05:46:55.175226	2026-01-29 05:46:55.175226
282	311	Malda District Central Co-Op Bank	NULL	MDCB	f	2026-01-29 05:46:55.186575	2026-01-29 05:46:55.186575
283	312	Ujjivan Small Finance Bank	NULL	UJVN	t	2026-01-29 05:46:55.201344	2026-01-29 05:46:55.201344
284	313	Jamia Co-Op Bank	NULL	JCBL	t	2026-01-29 05:46:55.21206	2026-01-29 05:46:55.21206
285	314	Integral Urban Co-Op Bank	NULL	IUCB	t	2026-01-29 05:46:55.223723	2026-01-29 05:46:55.223723
286	315	ESAF Small Finance Bank	NULL	ESMF	t	2026-01-29 05:46:55.237658	2026-01-29 05:46:55.237658
287	316	Mogaveera Co-Op Bank	NULL	MGCB	f	2026-01-29 05:46:55.249055	2026-01-29 05:46:55.249055
288	317	Akhand Anand Co-Op Bank	NULL	AACB	t	2026-01-29 05:46:55.261084	2026-01-29 05:46:55.261084
289	318	Sardar Bhiladwala Pardi Peoples Co-Op Bank	NULL	SBPP	t	2026-01-29 05:46:55.274548	2026-01-29 05:46:55.274548
290	319	Manvi Pattana Souharda Sahakari Bank	NULL	MPSS	t	2026-01-29 05:46:55.28837	2026-01-29 05:46:55.28837
291	320	Shree Sharada Sahakari Bank	NULL	SSSB	t	2026-01-29 05:46:55.303352	2026-01-29 05:46:55.303352
292	321	Aircel Smart Money	NULL	ASML	t	2026-01-29 05:46:55.315126	2026-01-29 05:46:55.315126
293	322	Mumbai District Central Co-Op Bank	NULL	DCCL	t	2026-01-29 05:46:55.331044	2026-01-29 05:46:55.331044
294	323	The Thane District Central Co-Op Bank	NULL	TCCB	f	2026-01-29 05:46:55.345368	2026-01-29 05:46:55.345368
295	324	Zoroastrian Co-Op Bank	ZCBL0000002	ZCBL	t	2026-01-29 05:46:55.357465	2026-01-29 05:46:55.357465
296	325	Saurashtra Co-Op Bank	NULL	SSCB	t	2026-01-29 05:46:55.371436	2026-01-29 05:46:55.371436
297	326	Kurmanchal Nagar Sahkari Bank	KNSB0000001	KNSB	t	2026-01-29 05:46:55.387128	2026-01-29 05:46:55.387128
298	327	Suryoday Small Finance Bank	NULL	SURY	t	2026-01-29 05:46:55.398442	2026-01-29 05:46:55.398442
299	328	Akola Janata Commercial Co-Op Bank	NULL	AKJB	t	2026-01-29 05:46:55.411672	2026-01-29 05:46:55.411672
300	329	Sahebrao Deshmukh Co-Op Bank	NULL	SAHE	f	2026-01-29 05:46:55.427139	2026-01-29 05:46:55.427139
301	330	Shri Chhatrapati Rajarshi Shahu Urban Co-Op Bank	NULL	CRUB	f	2026-01-29 05:46:55.440455	2026-01-29 05:46:55.440455
302	331	Akola District Central Co-Op Bank	ADCC0000000	ADCC	t	2026-01-29 05:46:55.451315	2026-01-29 05:46:55.451315
303	332	Hindusthan Co-Op Bank	NULL	THCB	t	2026-01-29 05:46:55.467575	2026-01-29 05:46:55.467575
304	333	Sadhana Sahakari Bank	NULL	SSBL	t	2026-01-29 05:46:55.480806	2026-01-29 05:46:55.480806
305	334	Sabarkantha District Central Co-Op Bank	NULL	SDCC	t	2026-01-29 05:46:55.491756	2026-01-29 05:46:55.491756
306	335	Sharad Sahakari Bank Manchar	NULL	SSBM	f	2026-01-29 05:46:55.505936	2026-01-29 05:46:55.505936
307	336	Udaipur Urban Co-Op Bank	UUCB0000001	UUCB	t	2026-01-29 05:46:55.516545	2026-01-29 05:46:55.516545
308	337	Vikas Souharda Co-Op Bank	NULL	VSCB	t	2026-01-29 05:46:55.527774	2026-01-29 05:46:55.527774
309	338	Priyadarshani Nagari Sahakari Bank	NULL	PNSL	t	2026-01-29 05:46:55.541276	2026-01-29 05:46:55.541276
310	339	Kaira District Central Co-Op Bank	ICIC00KAIRA	KAIB	t	2026-01-29 05:46:55.552278	2026-01-29 05:46:55.552278
311	340	Murshidabad District Central Co-Op Bank	NULL	MCCB	f	2026-01-29 05:46:55.562904	2026-01-29 05:46:55.562904
312	341	Kottayam Co-Op Urban Bank	NULL	KCUB	t	2026-01-29 05:46:55.578476	2026-01-29 05:46:55.578476
313	342	Panipat Urban Co-Op Bank	YESB0PUCB01	PUCB	t	2026-01-29 05:46:55.589227	2026-01-29 05:46:55.589227
314	343	Telangana State Co-Op Apex Bank	NULL	TSAB	t	2026-01-29 05:46:55.604714	2026-01-29 05:46:55.604714
315	344	Assam Co-Op Apex Bank	NULL	ACAB	f	2026-01-29 05:46:55.61856	2026-01-29 05:46:55.61856
316	346	Surat National Co-Op Bank	NULL	SUNB	t	2026-01-29 05:46:55.635255	2026-01-29 05:46:55.635255
317	347	FINO Payments Bank	NULL	FINO	t	2026-01-29 05:46:55.64909	2026-01-29 05:46:55.64909
318	348	Narmada Malwa Gramin Bank	NULL	MRGB	f	2026-01-29 05:46:55.662391	2026-01-29 05:46:55.662391
319	349	Markandey Nagari Sahakari Bank	NULL	MSBL	f	2026-01-29 05:46:55.676998	2026-01-29 05:46:55.676998
320	350	Bijnor Urban Co-Op Bank	NULL	BCBL	t	2026-01-29 05:46:55.687905	2026-01-29 05:46:55.687905
321	351	Adarsh Mahila Mercantile Co-Op Bank	NULL	AMMC	f	2026-01-29 05:46:55.700514	2026-01-29 05:46:55.700514
322	352	Adarsh Co-Op Bank Rajasthan	NULL	ACBR	t	2026-01-29 05:46:55.713185	2026-01-29 05:46:55.713185
323	353	The Baramati Sahakari Bank Ltd	NULL	BARA	t	2026-01-29 05:46:55.726928	2026-01-29 05:46:55.726928
324	354	Jalna Merchant Co-Op Bank	NULL	JMBL	t	2026-01-29 05:46:55.738353	2026-01-29 05:46:55.738353
325	355	Kanaka Mahalakshmi Co-Op Bank	NULL	KMCB	t	2026-01-29 05:46:55.751892	2026-01-29 05:46:55.751892
326	356	Lokmangal Co-Op Bank	NULL	LCBL	t	2026-01-29 05:46:55.764038	2026-01-29 05:46:55.764038
327	357	Odisha State Co-Op Bank	ORCB0000001	ORCB	t	2026-01-29 05:46:55.777964	2026-01-29 05:46:55.777964
328	358	Prime Co-Op Bank Ltd	NULL	PMEC	t	2026-01-29 05:46:55.798724	2026-01-29 05:46:55.798724
329	359	Solapur Janata Sahakari Bank	NULL	SJSB	f	2026-01-29 05:46:55.812132	2026-01-29 05:46:55.812132
330	360	Raigad District Central Co-Op Bank	NULL	TRDC	t	2026-01-29 05:46:55.825981	2026-01-29 05:46:55.825981
331	361	Sangli District Central Co-Op Bank	NULL	ISDC	f	2026-01-29 05:46:55.836147	2026-01-29 05:46:55.836147
332	362	Urban Co-Op Bank Siddharthanagar	NULL	UCBS	t	2026-01-29 05:46:55.851936	2026-01-29 05:46:55.851936
333	363	Zila Sahakari Bank Lucknow	NULL	ZSBL	t	2026-01-29 05:46:55.865445	2026-01-29 05:46:55.865445
334	364	AU Small Finance Bank	NULL	AUBL	t	2026-01-29 05:46:55.880905	2026-01-29 05:46:55.880905
335	365	District Co-Op Bank Agra	NULL	AGCB	f	2026-01-29 05:46:55.891273	2026-01-29 05:46:55.891273
336	366	Janata Sahakari Bank Osmanabad	NULL	OJSB	f	2026-01-29 05:46:55.905503	2026-01-29 05:46:55.905503
337	367	Rajarshi Shahu Sah Bank Pune	RSSB0000001	CRBL	t	2026-01-29 05:46:55.924066	2026-01-29 05:46:55.924066
338	368	Sant Sopankaka Sahakari Bank Saswad	SANT0000002	SANT	t	2026-01-29 05:46:55.935918	2026-01-29 05:46:55.935918
339	369	Deccan Merchants Co-Op Bank	NULL	DMCB	f	2026-01-29 05:46:55.94837	2026-01-29 05:46:55.94837
340	370	Nanded Disctrict Central Co-Op Bank	NULL	NDCB	f	2026-01-29 05:46:55.960888	2026-01-29 05:46:55.960888
341	371	Bhagalpur Central Co-Op Bank	NULL	BCCB	f	2026-01-29 05:46:55.976531	2026-01-29 05:46:55.976531
342	372	Almora Urban Co-Op Bank	NULL	AUCB	f	2026-01-29 05:46:55.987561	2026-01-29 05:46:55.987561
343	373	Zila Sahakari Bank Haridwar	NULL	ZSBH	t	2026-01-29 05:46:56.000486	2026-01-29 05:46:56.000486
344	374	Etah District Co-Op bank	NULL	EDCB	f	2026-01-29 05:46:56.010691	2026-01-29 05:46:56.010691
345	375	Andhra Pradesh State Co-Op Bank	NULL	APBL	t	2026-01-29 05:46:56.025358	2026-01-29 05:46:56.025358
346	376	Jharkhand State Co-Op Bank	NULL	JSCB	f	2026-01-29 05:46:56.039291	2026-01-29 05:46:56.039291
347	377	Sangamner Merchant Co-Op Bank	NULL	TSMC	t	2026-01-29 05:46:56.049335	2026-01-29 05:46:56.049335
348	378	The Satara District Central Co-Op Bank Ltd	SDCE0000001	SDCE	f	2026-01-29 05:46:56.060971	2026-01-29 05:46:56.060971
349	379	Pune District Central Co-Op Bank	NULL	PDCC	t	2026-01-29 05:46:56.072249	2026-01-29 05:46:56.072249
350	380	The Khamgaon Urban Co-Op Bank Ltd	NULL	KUCC	t	2026-01-29 05:46:56.082076	2026-01-29 05:46:56.082076
351	381	Chartered Sahakari Bank Niyamitha	NULL	CSBN	t	2026-01-29 05:46:56.100004	2026-01-29 05:46:56.100004
352	382	The Gandhinagar Urban Co-Op Bank Ltd	NULL	TGUC	f	2026-01-29 05:46:56.113371	2026-01-29 05:46:56.113371
353	383	Valsad District Central Co-Op Bank Ltd	NULL	VDCC	t	2026-01-29 05:46:56.122732	2026-01-29 05:46:56.122732
354	384	Jijamata Mahila Sah Bank Ltd Pune	NULL	CJMS	t	2026-01-29 05:46:56.133388	2026-01-29 05:46:56.133388
355	385	Capital Small Finance Bank	NULL	CLBL	t	2026-01-29 05:46:56.147882	2026-01-29 05:46:56.147882
356	386	The Muslim Co-Op Bank Ltd	NULL	TMCO	t	2026-01-29 05:46:56.15982	2026-01-29 05:46:56.15982
357	387	The Gandhinagar Nagrik Co-Op Bank Ltd	NULL	TGNC	t	2026-01-29 05:46:56.176058	2026-01-29 05:46:56.176058
358	388	The Rajasthan State Co-Op Bank Ltd	NULL	RSCB	t	2026-01-29 05:46:56.187452	2026-01-29 05:46:56.187452
359	389	Ratnagiri District Central Co-Op Bank Ltd	NULL	RDCC	f	2026-01-29 05:46:56.204061	2026-01-29 05:46:56.204061
360	390	Jila Sahakari Kendriya Bank Khandwa	CBIN0MPDCAR	MPDC	t	2026-01-29 05:46:56.216719	2026-01-29 05:46:56.216719
361	391	Jila Sahakari Kendriya Bank Maryadit Rajnandgaon	NULL	SJSD	f	2026-01-29 05:46:56.230458	2026-01-29 05:46:56.230458
362	392	Kokan Mercantile Co-Op Bank Ltd	NULL	KKCB	f	2026-01-29 05:46:56.241734	2026-01-29 05:46:56.241734
363	393	Annasaheb Savant Co-Op Urban Bank	NULL	AHAD	f	2026-01-29 05:46:56.254353	2026-01-29 05:46:56.254353
364	394	Prerana Co-Op Bank Ltd	NULL	PCBL	t	2026-01-29 05:46:56.272943	2026-01-29 05:46:56.272943
365	395	The Chembur Nagarik Sahakari Bank Ltd	NULL	CNSB	t	2026-01-29 05:46:56.282968	2026-01-29 05:46:56.282968
366	396	The Bhagyodaya Co-Op Bank Ltd	NULL	TBCB	t	2026-01-29 05:46:56.294313	2026-01-29 05:46:56.294313
367	397	Saibaba Nagari Sahakari Bank Ltd	UTIB0SSNS01	SSNS	t	2026-01-29 05:46:56.30459	2026-01-29 05:46:56.30459
368	398	Central Madhya Pradesh Gramin Bank	NULL	CMPG	f	2026-01-29 05:46:56.317469	2026-01-29 05:46:56.317469
369	399	Jio Payments Bank Ltd	JIOP0000001	JIOP	t	2026-01-29 05:46:56.32656	2026-01-29 05:46:56.32656
370	400	The Co-Op Bank Of Rajkot Ltd	NULL	CBOR	t	2026-01-29 05:46:56.340148	2026-01-29 05:46:56.340148
371	401	Vijay Commercial Co-Op Bank	KKBK0VCCB01	VCCB	t	2026-01-29 05:46:56.353077	2026-01-29 05:46:56.353077
372	402	Samarth Sahakari Bank Ltd	NULL	SMRT	t	2026-01-29 05:46:56.364347	2026-01-29 05:46:56.364347
373	403	Khalilabad Nagar Sah Bank Semariawa	NULL	KHBK	f	2026-01-29 05:46:56.378781	2026-01-29 05:46:56.378781
374	404	Zila Sahakari Bank Ltd Rampur	NULL	RAMP	t	2026-01-29 05:46:56.393099	2026-01-29 05:46:56.393099
375	405	Zila Sahakari Bank Ltd Moradabad	NULL	MORD	f	2026-01-29 05:46:56.406143	2026-01-29 05:46:56.406143
376	406	Narmada Jhabua Gramin Bank	NULL	NJGB	f	2026-01-29 05:46:56.420295	2026-01-29 05:46:56.420295
377	407	Home Credit Finance Bank	NULL	HCFB	t	2026-01-29 05:46:56.43153	2026-01-29 05:46:56.43153
378	408	DCB Bank	NULL	DCBB	t	2026-01-29 05:46:56.443231	2026-01-29 05:46:56.443231
379	409	Bajaj Finance Bank	NULL	BFBB	t	2026-01-29 05:46:56.456481	2026-01-29 05:46:56.456481
380	410	Rae Bareli District Co-Op Bank Ltd	NULL	RBDC	t	2026-01-29 05:46:56.472031	2026-01-29 05:46:56.472031
381	411	Karnala Nagari Sahakari Bank	NULL	KNBB	t	2026-01-29 05:46:56.48534	2026-01-29 05:46:56.48534
382	412	Meghalaya Co-Op Apex Bank	NULL	MCAB	t	2026-01-29 05:46:56.498516	2026-01-29 05:46:56.498516
383	413	Bharuch District Central Co-Op Bank Ltd	NULL	BDCC	t	2026-01-29 05:46:56.50985	2026-01-29 05:46:56.50985
384	414	Gopinath Patil Parsik Janata Sahakari Bank Ltd	NULL	GPPJ	t	2026-01-29 05:46:56.520196	2026-01-29 05:46:56.520196
385	416	Aditya Birla Idea Payments Bank	NULL	ABPB	t	2026-01-29 05:46:56.533838	2026-01-29 05:46:56.533838
386	417	Indrayani Co-Op Bank Ltd	ICIC00ICBLP	ICBL	t	2026-01-29 05:46:56.544852	2026-01-29 05:46:56.544852
387	418	Contai Co-Op Bank Ltd	ICIC00CCBLT	CBLT	t	2026-01-29 05:46:56.557798	2026-01-29 05:46:56.557798
388	419	The Punjab State Co-Op Bank	UTIB0PSCB01	PSCB	t	2026-01-29 05:46:56.567822	2026-01-29 05:46:56.567822
389	420	Kolhapur Mahila Sahakari Bank Ltd	NULL	CKMB	t	2026-01-29 05:46:56.577621	2026-01-29 05:46:56.577621
390	421	The Chandigarh State Co-Op Bank Ltd	NULL	CSCB	t	2026-01-29 05:46:56.589811	2026-01-29 05:46:56.589811
391	422	The Villupuram District Central Co-Op Bank Ltd	NULL	VDCB	f	2026-01-29 05:46:56.604328	2026-01-29 05:46:56.604328
392	423	Uttar Pradesh State Co-Op Bank Ltd	UPCB0000001	UPCB	t	2026-01-29 05:46:56.618305	2026-01-29 05:46:56.618305
393	424	The Ajara Urban Co-Op Bank Ltd	AJAR0000001	AUBB	t	2026-01-29 05:46:56.628	2026-01-29 05:46:56.628
394	426	Samata Co-Op Development Bank	NULL	SAMA	f	2026-01-29 05:46:56.638368	2026-01-29 05:46:56.638368
395	427	Bhagini Nivedita Sahakari Bank Ltd	BNSB0000002	NBNK	t	2026-01-29 05:46:56.650969	2026-01-29 05:46:56.650969
396	428	Model Co-Op Bank Ltd	NULL	MDBK	t	2026-01-29 05:46:56.66051	2026-01-29 05:46:56.66051
397	429	The Satara Sahakari Bank Ltd	NULL	TSSB	t	2026-01-29 05:46:56.670363	2026-01-29 05:46:56.670363
398	430	The Mehsana Nagrik Sahakari Bank Ltd	IBKL0443MNB	MNSB	t	2026-01-29 05:46:56.681205	2026-01-29 05:46:56.681205
399	431	Tehri Garhwal Zila Sahakari Bank Ltd	NULL	TGZS	t	2026-01-29 05:46:56.698171	2026-01-29 05:46:56.698171
400	432	Utkarsh Small Finance Bank	NULL	UTKS	t	2026-01-29 05:46:56.713015	2026-01-29 05:46:56.713015
401	433	Shivajirao Bhosale Sahakari Bank Ltd	NULL	NULL	f	2026-01-29 05:46:56.726263	2026-01-29 05:46:56.726263
402	435	Shahjahanpur District Central Co-Op Bank Ltd	NULL	SDDB	f	2026-01-29 05:46:56.736696	2026-01-29 05:46:56.736696
403	436	The Kolhapur Urban Co-Op Bank Ltd Kolhapur	NULL	KUBL	t	2026-01-29 05:46:56.750961	2026-01-29 05:46:56.750961
404	437	Uttar Daudpur Samabay Krishi Unnayan Samity Ltd	NULL	UDSK	f	2026-01-29 05:46:56.764493	2026-01-29 05:46:56.764493
405	438	Durgapur Steel Peoples Co-Op Bank Ltd	NULL	DURG	t	2026-01-29 05:46:56.777037	2026-01-29 05:46:56.777037
406	439	The Sitamarhi Central Co-Op Bank	NULL	ISCB	f	2026-01-29 05:46:56.789649	2026-01-29 05:46:56.789649
407	440	Shree Kadi Nagarik Sahakari Bank Ltd	YESB0KNB006	KNBL	t	2026-01-29 05:46:56.802928	2026-01-29 05:46:56.802928
408	441	The Ahmednagar District Central Co-Op Bank Ltd	ICIC00ADCCB	ACCB	t	2026-01-29 05:46:56.812533	2026-01-29 05:46:56.812533
409	442	Sardargunj Mercantile Co-Op Bank Ltd	UTIB0SSMC01	SSMC	t	2026-01-29 05:46:56.828344	2026-01-29 05:46:56.828344
410	443	Himatnagar Nagrik Sahakari Bank Ltd	IBKL0218HNS	HNSB	t	2026-01-29 05:46:56.844347	2026-01-29 05:46:56.844347
411	444	Pali Urban Co-Op Bank Ltd	HDFC0CPUB03	CPUB	t	2026-01-29 05:46:56.856749	2026-01-29 05:46:56.856749
412	445	Janata Sahakari Bank Ltd Ajara	IBKL0116JSB	LJSB	t	2026-01-29 05:46:56.870264	2026-01-29 05:46:56.870264
413	446	Dr.Appashab urf Sa.Re.Patil Jasingpur Udgaon Sahakari Bank Ltd,Jaysingpur	ICIC00JUSBL	JUSB	t	2026-01-29 05:46:56.884658	2026-01-29 05:46:56.884658
414	447	The Ranuj Nagrik Sahakari Bank Ltd	HDFC0CRANUJ	RANU	t	2026-01-29 05:46:56.895249	2026-01-29 05:46:56.895249
415	448	Sandur Pattana Souharda Sahakari Bank Ltd	IBKL0776SPS	SPSB	t	2026-01-29 05:46:56.905307	2026-01-29 05:46:56.905307
416	449	Nirmal Urban Co-Op Bank Nagpur	HDFC0CNB311	CNBL	t	2026-01-29 05:46:56.919672	2026-01-29 05:46:56.919672
417	450	The Mangalore Catholic Co-Op Bank Ltd	IBKL0078MCC	TMCC	t	2026-01-29 05:46:56.931864	2026-01-29 05:46:56.931864
418	451	Peoples Urban Co-Op Bank Ltd	IBKL0341PUB	TPCB	t	2026-01-29 05:46:56.947928	2026-01-29 05:46:56.947928
419	453	Bhadradri Co-Op Urban Bank Ltd	SRCB0BCB808	BCUB	t	2026-01-29 05:46:56.960301	2026-01-29 05:46:56.960301
420	454	The Manipur State Co-Op Bank	YESB0MSCB01	MSCB	t	2026-01-29 05:46:56.972307	2026-01-29 05:46:56.972307
421	455	The Financial Co-Op Bank Ltd	YESB0FINCO2	FSCB	t	2026-01-29 05:46:56.985845	2026-01-29 05:46:56.985845
422	456	The Kodungallur Town Co-Op Bank Ltd	IBKL0269KTC	KTCB	t	2026-01-29 05:46:56.995489	2026-01-29 05:46:56.995489
423	457	Shree Panchganga Nagari Sahakari Bank	IBKL0464PNS	SPNB	t	2026-01-29 05:46:57.009474	2026-01-29 05:46:57.009474
424	458	Malviya Urban Co-Op Bank Ltd	HDFC0CMUCBL	MUCB	t	2026-01-29 05:46:57.019723	2026-01-29 05:46:57.019723
425	460	Saraspur Nagrik Sahakari Bank	GSCB0USNCBL	SCNB	t	2026-01-29 05:46:57.031972	2026-01-29 05:46:57.031972
426	461	Patan Nagarik Sahakari Bank Ltd	GSCB0UPATAN	UPAT	t	2026-01-29 05:46:57.042362	2026-01-29 05:46:57.042362
427	462	The Mehsana District Central Co-Op Bank Ltd	GSCB0MSN001	MSNB	t	2026-01-29 05:46:57.054143	2026-01-29 05:46:57.054143
428	463	Khagaria District Central Co-Op Bank Ltd	IBKL01077KD	KDCB	t	2026-01-29 05:46:57.070088	2026-01-29 05:46:57.070088
429	464	The Yavatmal Urban Co-Op Bank Ltd	IBKL0041Y01	YUCB	t	2026-01-29 05:46:57.08081	2026-01-29 05:46:57.08081
430	465	The Aurangabad District Central Co-Op Bank Ltd	IBKL01192AC	ACBL	t	2026-01-29 05:46:57.090117	2026-01-29 05:46:57.090117
431	466	The Rohika Central Co-Op Bank Ltd Madhubani	IBKL01066RC	RCCB	t	2026-01-29 05:46:57.101157	2026-01-29 05:46:57.101157
432	467	Uttrakhand Co-Op Bank Ltd	HDFC0CUCOBL	UCOB	t	2026-01-29 05:46:57.113962	2026-01-29 05:46:57.113962
433	468	Khattri Co-Op Urban Bank Ltd	YESB0KCUB01	BKCB	t	2026-01-29 05:46:57.126688	2026-01-29 05:46:57.126688
434	469	The Surat Mercantile Co-Op Bank Ltd	YESB0SMCB05	SMBC	t	2026-01-29 05:46:57.136857	2026-01-29 05:46:57.136857
435	470	Chittorgarh Urban Co-Op Bank Ltd	HDFC0CCUCBL	CCUC	t	2026-01-29 05:46:57.148863	2026-01-29 05:46:57.148863
436	471	The Kanara District Central Co-Op Bank Ltd Sirsi	KSCB0016001	KDCC	t	2026-01-29 05:46:57.160375	2026-01-29 05:46:57.160375
437	472	The Karnavati Co-Op Bank Ltd	NULL	TKCB	f	2026-01-29 05:46:57.170055	2026-01-29 05:46:57.170055
438	473	The Washim Urban Co-Op Bank Ltd Washim	HDFC0CWUCBL	WUCB	t	2026-01-29 05:46:57.180007	2026-01-29 05:46:57.180007
439	474	Sarvodaya Sahakari Bank Ltd	YESB0SSBL01	SSBH	t	2026-01-29 05:46:57.192179	2026-01-29 05:46:57.192179
440	475	Ambajogai Peoples Co-Op Bank Ltd	HDFC0CAPCBL	CAPC	t	2026-01-29 05:46:57.202207	2026-01-29 05:46:57.202207
441	476	Manjeri Co-Op Urban Bank Ltd	ICIC00MCUBL	MCUB	t	2026-01-29 05:46:57.218119	2026-01-29 05:46:57.218119
442	477	Mansing Co-Op Bank Ltd Dudhondi	HDFC0CMCBLD	CMCB	t	2026-01-29 05:46:57.228587	2026-01-29 05:46:57.228587
443	478	Shri Adinath Co-Op Bank Ltd	HDFC0CSACBL	SACB	t	2026-01-29 05:46:57.238475	2026-01-29 05:46:57.238475
444	479	The Commercial Co-Op Bank Ltd Kolhapur	HDFC0CTCCBK	CCBK	t	2026-01-29 05:46:57.253037	2026-01-29 05:46:57.253037
445	480	The Vijay Co-Op Bank Ltd	HDFC0CTVCBL	VCBL	t	2026-01-29 05:46:57.263536	2026-01-29 05:46:57.263536
446	481	Veraval Mercantile Co-Op Bank	HDFC0CVMCBA	VMCB	t	2026-01-29 05:46:57.273604	2026-01-29 05:46:57.273604
447	482	The Baroda City Co-Op Bank Ltd	KKBK0BCCB04	BCOB	t	2026-01-29 05:46:57.285383	2026-01-29 05:46:57.285383
448	483	Shri Janata Sahakari Bank Ltd Halol	GSCB0USJSBL	USJB	t	2026-01-29 05:46:57.296482	2026-01-29 05:46:57.296482
449	484	The Bhavana Rishi Co-Op Urban Bank Ltd	YESB0BRCB01	BRCB	t	2026-01-29 05:46:57.307752	2026-01-29 05:46:57.307752
450	485	Adarsh Mahila Nagari Sahakari Bank Ltd Aurangabad	YESB0AMSB01	AMSB	t	2026-01-29 05:46:57.31982	2026-01-29 05:46:57.31982
451	486	Associate Co-Op Bank Ltd	GSCB0ASCB02	ASCB	t	2026-01-29 05:46:57.332363	2026-01-29 05:46:57.332363
452	487	Uttarkashi Zila Sahakari Bank Ltd	YESB0DCBU01	DCBU	t	2026-01-29 05:46:57.34535	2026-01-29 05:46:57.34535
453	488	Sampada Sahakari Bank Ltd	IBKL0459SBS	SBSL	t	2026-01-29 05:46:57.356972	2026-01-29 05:46:57.356972
454	489	The Ottapalam Co-Op Urban Bank Ltd	IBKL0763OCB	OCBL	t	2026-01-29 05:46:57.369175	2026-01-29 05:46:57.369175
455	490	The Nawanagar Co-Op Bank	IBKL0427NCB	NCOB	t	2026-01-29 05:46:57.378133	2026-01-29 05:46:57.378133
456	491	The Deola Merchant Co-Op Bank Ltd	IBKL0157001	DMOB	t	2026-01-29 05:46:57.390677	2026-01-29 05:46:57.390677
457	492	Madhya Pradesh Rajya Sahakari Bank Maryadit	CBIN0MPABAA	MPAB	t	2026-01-29 05:46:57.402902	2026-01-29 05:46:57.402902
458	493	Aman Sahakari Bank Ltd Ichalkaranji	ICIC00AMSBL	ASMB	t	2026-01-29 05:46:57.41516	2026-01-29 05:46:57.41516
459	494	The Manmandir Co-Op Bank Ltd Vita	ICIC00MMCBL	MMCB	t	2026-01-29 05:46:57.428377	2026-01-29 05:46:57.428377
460	495	Balotra Urban Co-Op Bank Ltd	ICIC00BALUC	BALU	t	2026-01-29 05:46:57.439608	2026-01-29 05:46:57.439608
461	496	Rajkot District Central Co-Op Bank	GSCB0RJT001	RDCB	t	2026-01-29 05:46:57.452758	2026-01-29 05:46:57.452758
462	497	Bhatpara Naihati Co-Op Bank Ltd	WBSC0BUCB01	BUCB	t	2026-01-29 05:46:57.4628	2026-01-29 05:46:57.4628
463	498	Wai Urban Co-Op Bank Ltd	SVCB0016101	WUBL	t	2026-01-29 05:46:57.473543	2026-01-29 05:46:57.473543
464	499	Navi Mumbai Co-Op Bank Ltd	NULL	NMCL	t	2026-01-29 05:46:57.483347	2026-01-29 05:46:57.483347
465	500	Sudha Co-Op Urban Bank Ltd	HDFC0CSUCUB	SCUB	t	2026-01-29 05:46:57.495089	2026-01-29 05:46:57.495089
466	501	Angul Central Co-Op Bank Ltd	ORCB0ANG001	YEAC	t	2026-01-29 05:46:57.5076	2026-01-29 05:46:57.5076
467	502	Balasore Bhadrak Central Co-Op Bank	ORCB0BLS001	BBCC	t	2026-01-29 05:46:57.518094	2026-01-29 05:46:57.518094
468	503	Banki Central Co-Op Bank Ltd	ORCB0BNK001	BCYS	t	2026-01-29 05:46:57.532317	2026-01-29 05:46:57.532317
469	504	Berhampore Central Co-Op Bank Ltd	ORCB0BER001	IBBC	t	2026-01-29 05:46:57.546518	2026-01-29 05:46:57.546518
470	505	Bhawanipatna Central Co-Op Bank Ltd	ORCB0BWP001	ICBC	t	2026-01-29 05:46:57.557744	2026-01-29 05:46:57.557744
471	506	Bolangir Central Co-Op Bank Ltd	ORCB0BLR001	YSBC	t	2026-01-29 05:46:57.570981	2026-01-29 05:46:57.570981
472	507	Boudh Central Co-Op Bank Ltd	ORCB0BOU001	YSBB	t	2026-01-29 05:46:57.582177	2026-01-29 05:46:57.582177
473	508	Cuttack Central Co-Op Bank Ltd	ORCB0CTC001	CCCB	t	2026-01-29 05:46:57.593955	2026-01-29 05:46:57.593955
474	509	Khordha Central Co-Op Bank Ltd	ORCB0KHU001	KCCC	t	2026-01-29 05:46:57.604955	2026-01-29 05:46:57.604955
475	510	Mayurbhanj Central Co-Op Bank Ltd	ORCB0MYB001	MCCC	t	2026-01-29 05:46:57.618855	2026-01-29 05:46:57.618855
476	511	Nayagarh Central Co-Op Bank Ltd	ORCB0NGR001	NCCC	t	2026-01-29 05:46:57.630907	2026-01-29 05:46:57.630907
477	512	Sambalpur Central Co-Op Bank Ltd	ORCB0SBP001	SCYS	t	2026-01-29 05:46:57.6489	2026-01-29 05:46:57.6489
478	513	Samruddhi Co-Op Bank Ltd	IBKL0041SCB	SSBB	t	2026-01-29 05:46:57.667429	2026-01-29 05:46:57.667429
479	514	The District Co-Op Bank Ltd	NULL	TDCC	f	2026-01-29 05:46:57.679559	2026-01-29 05:46:57.679559
480	515	Sundargarh Central Co-Op Bank Ltd	ORCB0SUN001	SCBB	t	2026-01-29 05:46:57.689624	2026-01-29 05:46:57.689624
481	516	United Puri Nimapara Central Co-Op Bank	ORCB0UPN001	UPNC	t	2026-01-29 05:46:57.705514	2026-01-29 05:46:57.705514
482	517	Abhinandan Urban Co-Op Bank Ltd	HDFC0CMAN01	AUUB	t	2026-01-29 05:46:57.719092	2026-01-29 05:46:57.719092
483	518	Bhilwara Urban Co-Op Bank Ltd	HDFC0CBHLUB	BUCN	t	2026-01-29 05:46:57.732402	2026-01-29 05:46:57.732402
484	519	Sumerpur Merchantile Urban Co-Op Bank Ltd	HDFC0CS1812	SMUC	t	2026-01-29 05:46:57.743061	2026-01-29 05:46:57.743061
485	520	The Eenadu Co-Op Urban Bank Ltd	HDFC0CEENAD	ECUB	t	2026-01-29 05:46:57.755981	2026-01-29 05:46:57.755981
486	521	M S Co-Op Bank Ltd	IBKL0553MSC	MSSB	t	2026-01-29 05:46:57.769793	2026-01-29 05:46:57.769793
487	522	Sterling Urban Co-Op Bank Ltd	HDFC0CSTUCB	SUCC	t	2026-01-29 05:46:57.782005	2026-01-29 05:46:57.782005
488	523	Vallabh Vidyanagar Commercial Co-Op Bank Ltd	HDFC0CVVCCB	VVCC	t	2026-01-29 05:46:57.793804	2026-01-29 05:46:57.793804
489	524	Godavari Urban Co-Op Bank Ltd Vazirabad	YESB0GUCB01	GUCC	t	2026-01-29 05:46:57.808338	2026-01-29 05:46:57.808338
490	525	Baroda Central Co-Op Bank	GSCB0BRD001	BCCC	t	2026-01-29 05:46:57.820027	2026-01-29 05:46:57.820027
491	526	Darussalam Co-Op Urban Bank Ltd	HDFC0CDUCBL	DCUB	t	2026-01-29 05:46:57.834796	2026-01-29 05:46:57.834796
492	527	Shree Warana Sahakari Bank Ltd	HDFC0CSWSBL	SWSS	t	2026-01-29 05:46:57.84861	2026-01-29 05:46:57.84861
493	528	The Panchsheel Mercantile Co-Op Bank Ltd	YESB0PMCB02	TPMB	t	2026-01-29 05:46:57.860619	2026-01-29 05:46:57.860619
494	529	Unjha Nagarik Sahakari Bank Ltd	GSCB0UUNJBL	UNSB	t	2026-01-29 05:46:57.872177	2026-01-29 05:46:57.872177
495	530	Adar P D Patil Sahakari Bank	HDFC0CPDPBK	APDB	t	2026-01-29 05:46:57.884094	2026-01-29 05:46:57.884094
496	531	C G Rajya Sahakari Bank Maryadit Raipur	CBIN0CGDCBN	CGSB	t	2026-01-29 05:46:57.899602	2026-01-29 05:46:57.899602
497	532	Samata Sahakari Bank Ltd	SRCB0SAM001	SSBC	t	2026-01-29 05:46:57.911041	2026-01-29 05:46:57.911041
498	533	Mahesh Sahakari Bank Pune	SRCB0MSBLPN	MSBP	t	2026-01-29 05:46:57.921256	2026-01-29 05:46:57.921256
499	534	The Madanapalle Co-Op Town Bank Ltd	HDFC0CMPLTB	MCTB	t	2026-01-29 05:46:57.933087	2026-01-29 05:46:57.933087
500	535	Shrimant Malojiraje Sahakari Bank Ltd	ICIC00SMSBL	SMSB	t	2026-01-29 05:46:57.94413	2026-01-29 05:46:57.94413
501	536	Deendayal Nagari Sahakari Bank Ltd	ICIC00DDNSB	DNBB	t	2026-01-29 05:46:57.958461	2026-01-29 05:46:57.958461
502	537	District Co-Op Bank Ltd Dehradun	YESB0DZSB01	DCOB	t	2026-01-29 05:46:57.972902	2026-01-29 05:46:57.972902
503	538	The Urban Co-Op Bank Ltd Dharangaon	ICIC00TUCBD	UCBD	t	2026-01-29 05:46:57.983328	2026-01-29 05:46:57.983328
504	539	Lakhimpur Urban Co-Op Bank Ltd	ICIC00LKUCB	LCUB	t	2026-01-29 05:46:57.996105	2026-01-29 05:46:57.996105
505	540	Sundarlal Sawaji Urban Co-Op Bank Ltd	SRCB0SSB001	SSCU	t	2026-01-29 05:46:58.009404	2026-01-29 05:46:58.009404
506	541	Manorma Co-Op Bank Ltd Solapur	HDFC0CMANCB	MCBB	t	2026-01-29 05:46:58.023333	2026-01-29 05:46:58.023333
507	542	Junagadh Commercial Co-Op Bank Ltd	HDFC0CJCCBL	JCCB	t	2026-01-29 05:46:58.035967	2026-01-29 05:46:58.035967
508	543	Fincare Small Finance Bank Ltd	FSFB0000000	FSFB	t	2026-01-29 05:46:58.047082	2026-01-29 05:46:58.047082
509	544	Idukki District Co-Op Bank Ltd	IDUK0000000	IDUK	t	2026-01-29 05:46:58.062741	2026-01-29 05:46:58.062741
510	545	Jalgaon Janata Sahakari Bank Ltd	JJSB0000000	JJSB	t	2026-01-29 05:46:58.076874	2026-01-29 05:46:58.076874
511	546	Janaseva Sahakari Bank Borivali Ltd	JASB0000000	JASB	t	2026-01-29 05:46:58.087922	2026-01-29 05:46:58.087922
512	547	Textile Traders Co-Op Bank Ltd	TTCB0000000	TTCB	t	2026-01-29 05:46:58.099701	2026-01-29 05:46:58.099701
513	548	Pragati Sahakari Bank Ltd	NULL	PSBB	t	2026-01-29 05:46:58.109979	2026-01-29 05:46:58.109979
514	549	Bhavnagar District Central Co-Op Bank Ltd	GSCB0BVN001	BVNL	t	2026-01-29 05:46:58.120683	2026-01-29 05:46:58.120683
515	550	The Banaskantha District Central Co-Op Bank Ltd	GSCB0BKD001	BKDL	t	2026-01-29 05:46:58.132956	2026-01-29 05:46:58.132956
516	551	Pune Merchants Co-Op Bank Ltd	IBKL0548PMC	PMCL	t	2026-01-29 05:46:58.148382	2026-01-29 05:46:58.148382
517	552	Latur Urban Co-Op Bank	IBKL0497LUC	LUCL	t	2026-01-29 05:46:58.159691	2026-01-29 05:46:58.159691
518	553	The Gandevi Peoples Co-Op Bank Ltd	IBKL0068GP1	GPCB	t	2026-01-29 05:46:58.172693	2026-01-29 05:46:58.172693
519	555	Central Co-Op Bank Ltd Ara	IBKL0722CCB	CCBA	t	2026-01-29 05:46:58.185734	2026-01-29 05:46:58.185734
520	556	Mahaveer Co-Op Urban Bank Ltd	HDFC0CMCUBL	MBCL	t	2026-01-29 05:46:58.199047	2026-01-29 05:46:58.199047
521	557	The Jalgaon District Central Co-Op Bank Ltd	ICIC00JDCCB	JDBL	t	2026-01-29 05:46:58.212658	2026-01-29 05:46:58.212658
522	558	Etawah District Co-Op Bank Ltd Etawah	ICIC00ETAWH	ETAW	t	2026-01-29 05:46:58.224632	2026-01-29 05:46:58.224632
523	559	Bihar State Co-Op Bank Ltd	YESB0BSCB01	BSCB	t	2026-01-29 05:46:58.236057	2026-01-29 05:46:58.236057
524	560	Almora Zila Sahakari Bank Ltd	YESB0AZSB01	AZSB	t	2026-01-29 05:46:58.251889	2026-01-29 05:46:58.251889
525	561	Nainital District Co-Op Bank Ltd	YESB0NDCB01	NDCL	t	2026-01-29 05:46:58.265604	2026-01-29 05:46:58.265604
526	562	North East Small Finance Bank Ltd	NESF0000000	NESF	t	2026-01-29 05:46:58.276436	2026-01-29 05:46:58.276436
527	563	Alapuzha District Co-Op Bank Ltd	UTIB0SADC83	SADC	t	2026-01-29 05:46:58.287969	2026-01-29 05:46:58.287969
528	564	Chamoli Zila Sahakari Bank Ltd	IBKL070CZSB	CZSB	t	2026-01-29 05:46:58.305405	2026-01-29 05:46:58.305405
529	565	Navsarjan Industrial Co-OP Bank Ltd	HDFC0CNICBL	CNIC	t	2026-01-29 05:46:58.315571	2026-01-29 05:46:58.315571
530	566	Kankaria Maninagar Nagrik Sahakari Bank Ltd	HDFC0CKMNSB	KMNB	t	2026-01-29 05:46:58.326669	2026-01-29 05:46:58.326669
531	567	The Sarvodaya Nagrik Sahkari Bank Ltd	GSCB0UTSNBL	SNBL	t	2026-01-29 05:46:58.338507	2026-01-29 05:46:58.338507
532	568	The Kurla Nagarik Sahakari Bank Ltd	ICIC00KURLA	KURL	t	2026-01-29 05:46:58.349911	2026-01-29 05:46:58.349911
533	569	The Bharat Co-Op Bank Ltd	IBKL0008BCB	IBCB	t	2026-01-29 05:46:58.361095	2026-01-29 05:46:58.361095
534	570	Jana Small Finance Bank Ltd	JSFB0000001	JSFB	t	2026-01-29 05:46:58.37446	2026-01-29 05:46:58.37446
535	571	Gadchiroli District Central Co-Op Bank	GDCB0000001	GDCB	t	2026-01-29 05:46:58.388089	2026-01-29 05:46:58.388089
536	572	Shri Anand Nagari Sahakari Bank Limited	YESB0SANB99	SANB	t	2026-01-29 05:46:58.403401	2026-01-29 05:46:58.403401
537	573	Belagavi Shree Basveshwar Co-Op Bank Ltd	UTIB0S63SBC	SBCL	t	2026-01-29 05:46:58.41577	2026-01-29 05:46:58.41577
538	574	Bhopal Co-Op Central Bank Ltd	CBIN0MPDCAE	BCAE	t	2026-01-29 05:46:58.426413	2026-01-29 05:46:58.426413
539	575	Kashmir Mercantile Co-Op Bank Ltd Kashmir	HDFC0CKAMCO	KAMC	t	2026-01-29 05:46:58.437009	2026-01-29 05:46:58.437009
540	576	The Sevalia Urban Co-Op Bank Ltd	ICIC00SEVUC	SEVC	t	2026-01-29 05:46:58.448501	2026-01-29 05:46:58.448501
541	577	The Laxmi Co-Op Bank Ltd Solapur	NULL	LCOS	t	2026-01-29 05:46:58.458904	2026-01-29 05:46:58.458904
542	578	The Sarvodaya Co-Op Bank Ltd Mum	NULL	CSBM	f	2026-01-29 05:46:58.469704	2026-01-29 05:46:58.469704
543	579	Janakalyan Co-Op Bank Ltd	NULL	JBLN	f	2026-01-29 05:46:58.484417	2026-01-29 05:46:58.484417
544	580	Deogiri Nagari Sahakari Bank Ltd	NULL	DEOB	t	2026-01-29 05:46:58.497284	2026-01-29 05:46:58.497284
545	581	The Kapurthala Central Co-Op Bank Ltd	NULL	SKPT	f	2026-01-29 05:46:58.510182	2026-01-29 05:46:58.510182
546	582	Patliputra Central Co-Op Bank Ltd	NULL	IPCC	t	2026-01-29 05:46:58.521732	2026-01-29 05:46:58.521732
547	583	The Begusarai District Central Co-Op Bank	NULL	BDCB	f	2026-01-29 05:46:58.535325	2026-01-29 05:46:58.535325
548	584	Kozhikode District Co-Op Bank	KDCB0000001	KDDB	t	2026-01-29 05:46:58.547823	2026-01-29 05:46:58.547823
549	585	Shushruti Souharda Sahakara Bank Niyamita	NULL	SSBN	t	2026-01-29 05:46:58.561741	2026-01-29 05:46:58.561741
550	586	The Rajkot Commercial Co-Op Bank Ltd	NULL	RCBB	t	2026-01-29 05:46:58.575509	2026-01-29 05:46:58.575509
551	587	The Bardoli Nagrik Sahakari bank Ltd	NULL	BNBL	t	2026-01-29 05:46:58.586049	2026-01-29 05:46:58.586049
552	588	Urban Co-Op Bank Ltd Bareilly	NULL	UCBB	t	2026-01-29 05:46:58.600884	2026-01-29 05:46:58.600884
553	589	The United Co-Op Bank Ltd	NULL	TUBL	f	2026-01-29 05:46:58.616501	2026-01-29 05:46:58.616501
554	590	The Faridabad Central Co-Op Bank Ltd	NULL	SFCB	f	2026-01-29 05:46:58.629031	2026-01-29 05:46:58.629031
555	591	The Muzaffarpur Central Co-Op Bank Ltd	NULL	IMCC	f	2026-01-29 05:46:58.641274	2026-01-29 05:46:58.641274
556	592	The South Canara District Central Co-Op Bank	NULL	SCDC	f	2026-01-29 05:46:58.652597	2026-01-29 05:46:58.652597
557	593	The Ernakulam District Co-Op Bank Ltd	NULL	BEDC	f	2026-01-29 05:46:58.66614	2026-01-29 05:46:58.66614
558	594	Vasai Janata Sahkari Bank Ltd	NULL	VJBL	f	2026-01-29 05:46:58.683533	2026-01-29 05:46:58.683533
559	595	Sangli Sahakari Bank Ltd	NULL	SBBB	t	2026-01-29 05:46:58.694926	2026-01-29 05:46:58.694926
560	596	Australia And New Zealand Banking Group Ltd	NULL	ANZB	f	2026-01-29 05:46:58.70518	2026-01-29 05:46:58.70518
561	597	DMK Jaoli Bank	NULL	DMKJ	t	2026-01-29 05:46:58.715577	2026-01-29 05:46:58.715577
562	598	Doha Bank	NULL	DOHB	f	2026-01-29 05:46:58.725507	2026-01-29 05:46:58.725507
563	599	Emirates Nbd India	NULL	EBIL	t	2026-01-29 05:46:58.744628	2026-01-29 05:46:58.744628
564	600	Export Import Bank Of India	NULL	EIBI	f	2026-01-29 05:46:58.756313	2026-01-29 05:46:58.756313
565	601	Haryana State Co-Op Bank	NULL	HARC	t	2026-01-29 05:46:58.767303	2026-01-29 05:46:58.767303
566	602	Woori Bank	NULL	HVBK	f	2026-01-29 05:46:58.777905	2026-01-29 05:46:58.777905
567	603	Bank Internasional Indonesia	NULL	IBBK	f	2026-01-29 05:46:58.789669	2026-01-29 05:46:58.789669
568	604	Industrial Bank Of Korea	NULL	IBKO	f	2026-01-29 05:46:58.806169	2026-01-29 05:46:58.806169
569	605	Industrial And Commercial Bank Of China Ltd	NULL	ICBK	f	2026-01-29 05:46:58.819316	2026-01-29 05:46:58.819316
570	606	Keb Hana Bank	NULL	KOEX	f	2026-01-29 05:46:58.830488	2026-01-29 05:46:58.830488
571	607	Krung Thai Bank Pcl	NULL	KRTH	f	2026-01-29 05:46:58.841262	2026-01-29 05:46:58.841262
572	608	Sir M Visvesvaraya Co-Op Bank Ltd	NULL	MVCB	f	2026-01-29 05:46:58.855396	2026-01-29 05:46:58.855396
573	609	National Australia Bank Ltd	NULL	NATA	f	2026-01-29 05:46:58.868696	2026-01-29 05:46:58.868696
574	610	National Bank Of Abu Dhabi PJSC	NULL	NBAD	f	2026-01-29 05:46:58.883522	2026-01-29 05:46:58.883522
575	611	National Bank For Agriculture And Rural Development	NULL	NBRD	f	2026-01-29 05:46:58.893886	2026-01-29 05:46:58.893886
576	612	Nagpur Nagrik Sahakari Bank Ltd	NULL	NGSB	f	2026-01-29 05:46:58.908306	2026-01-29 05:46:58.908306
577	613	Nagar Urban Co-Op Bank	NULL	NUCB	f	2026-01-29 05:46:58.922111	2026-01-29 05:46:58.922111
578	614	The Navnirman Co-Op Bank Ltd	NULL	NVNM	t	2026-01-29 05:46:58.932611	2026-01-29 05:46:58.932611
579	615	Qatar National Bank Saq	NULL	QNBA	f	2026-01-29 05:46:58.945397	2026-01-29 05:46:58.945397
580	616	Rabobank International	NULL	RABO	f	2026-01-29 05:46:58.956265	2026-01-29 05:46:58.956265
581	617	IDRBT Bank	NULL	RBIH	f	2026-01-29 05:46:58.97178	2026-01-29 05:46:58.97178
582	618	Sber Bank	NULL	SABR	f	2026-01-29 05:46:58.986458	2026-01-29 05:46:58.986458
583	619	Small Industries Development Bank Of India	NULL	SIDB	f	2026-01-29 05:46:58.99915	2026-01-29 05:46:58.99915
584	620	Shikshak Sahakari Bank Ltd	NULL	SKSB	f	2026-01-29 05:46:59.010073	2026-01-29 05:46:59.010073
585	621	Tumkur Grain Merchants Co-Op Bank Ltd	NULL	TGMB	t	2026-01-29 05:46:59.023532	2026-01-29 05:46:59.023532
586	622	United Overseas Bank Ltd	NULL	UOVB	f	2026-01-29 05:46:59.037474	2026-01-29 05:46:59.037474
587	623	Westpac Banking Corporation	NULL	WPAC	f	2026-01-29 05:46:59.04795	2026-01-29 05:46:59.04795
588	624	Credit Suisse AG Bank	NULL	CRES	t	2026-01-29 05:46:59.066012	2026-01-29 05:46:59.066012
589	625	Sumitomo Mitsui Banking Co-Op Bank	NULL	SMBB	f	2026-01-29 05:46:59.07877	2026-01-29 05:46:59.07877
590	626	Tripura State Co-Op Bank Ltd	NULL	TSCB	f	2026-01-29 05:46:59.09107	2026-01-29 05:46:59.09107
591	627	The Yamuna Nagar Central Co-Op Bank Ltd	NULL	YCCB	f	2026-01-29 05:46:59.106832	2026-01-29 05:46:59.106832
592	628	The Banaskantha Mercantile Co-Op Bank Ltd	HDFC0CTBMCB	BMCB	t	2026-01-29 05:46:59.122105	2026-01-29 05:46:59.122105
593	629	Kota Nagrik Sahkari Bank Ltd kota	HDFC0CKNB02	CKNB	t	2026-01-29 05:46:59.135416	2026-01-29 05:46:59.135416
594	630	The Commercial Co-Op Bank Ltd	HDFC0COMMCO	COMM	t	2026-01-29 05:46:59.14641	2026-01-29 05:46:59.14641
595	631	The Naroda Nagrik Co-Op Bank Ltd	GSCB0UNNCBL	NNCB	t	2026-01-29 05:46:59.160448	2026-01-29 05:46:59.160448
596	632	The Godhra Urban Co-Op Bank Ltd	UTIB0SGUCB1	SGUC	t	2026-01-29 05:46:59.175419	2026-01-29 05:46:59.175419
597	633	Solapur Siddheshwar Sahakari Bank Ltd	HDFC0CSIDDH	SIDD	t	2026-01-29 05:46:59.187017	2026-01-29 05:46:59.187017
598	634	Sharad Nagari Sahakari Bank Ltd	NULL	SNSB	f	2026-01-29 05:46:59.20016	2026-01-29 05:46:59.20016
599	635	The Tarn Taran Central Co-Op Bank Ltd	NULL	STTN	f	2026-01-29 05:46:59.212036	2026-01-29 05:46:59.212036
600	636	Purnea District Central Co-Op Bank	NULL	PCCB	f	2026-01-29 05:46:59.223685	2026-01-29 05:46:59.223685
601	637	The Panchkula Central Co-Op Bank Ltd	NULL	SPKL	f	2026-01-29 05:46:59.271856	2026-01-29 05:46:59.271856
602	638	The Kottakkal Co-Op Urban Bank Ltd	UTIB0SKCU78	SKUB	t	2026-01-29 05:46:59.318639	2026-01-29 05:46:59.318639
603	639	Jampeta Urban Co-Op Bank	UTIB0SJCUB2	CBNB	t	2026-01-29 05:46:59.359489	2026-01-29 05:46:59.359489
604	640	Karnataka Gramin Bank	SBIN0RRCKGB	RKGB	t	2026-01-29 05:46:59.377361	2026-01-29 05:46:59.377361
605	641	Ahmednagar Sahar Sahakari Bank Maryadit	SVCB0008011	ASSB	t	2026-01-29 05:46:59.388563	2026-01-29 05:46:59.388563
606	642	Gujarat Ambuja Co-Op Bank Ltd	GSCB0UGACBL	GACB	t	2026-01-29 05:46:59.40079	2026-01-29 05:46:59.40079
607	643	The Business Co-Op Bank Ltd	YESBOBCBL02	BOBC	t	2026-01-29 05:46:59.411966	2026-01-29 05:46:59.411966
608	644	The Nawada Central Co-Op Bank Ltd	YESB0NCCB01	NCCB	t	2026-01-29 05:46:59.43032	2026-01-29 05:46:59.43032
609	645	The Adinath Co-Op Bank Ltd	YESB0ACB002	ACOB	t	2026-01-29 05:46:59.443419	2026-01-29 05:46:59.443419
610	646	Shree Dharati Co-Op Bank Ltd	IBKL01642SD	SCDB	t	2026-01-29 05:46:59.458098	2026-01-29 05:46:59.458098
611	647	Rajkot Peoples Co-Op Bank Ltd	IBKL01642RP	RPCB	t	2026-01-29 05:46:59.471984	2026-01-29 05:46:59.471984
612	648	Sirsi Urban Sahakari Bank Ltd	IBKL0069S01	USBL	t	2026-01-29 05:46:59.483398	2026-01-29 05:46:59.483398
613	649	Sangola Urban Co-Op Bank Ltd	NULL	SUCB	f	2026-01-29 05:46:59.500462	2026-01-29 05:46:59.500462
614	650	The Hoshiarpur Central Co-Op Bank Ltd	NULL	SHSP	f	2026-01-29 05:46:59.513306	2026-01-29 05:46:59.513306
615	651	Vaijapur Merchants Bank	NULL	VMBL	f	2026-01-29 05:46:59.524034	2026-01-29 05:46:59.524034
616	652	Jila Sahakari Kendriya Bank Maryadit Dhar	CBIN0MPDCAK	JSKB	t	2026-01-29 05:46:59.536371	2026-01-29 05:46:59.536371
617	653	Peoples Co-Op Bank Ltd Dholka	HDFC0CPCBLD	PCBD	t	2026-01-29 05:46:59.549908	2026-01-29 05:46:59.549908
618	654	The Udaipur Mahila Urban Co-Op Bank Ltd	ICIC00UMUCB	UMUC	t	2026-01-29 05:46:59.564146	2026-01-29 05:46:59.564146
619	655	The Aska Co-Op Central Bank Ltd	ORCB0ASK001	ASKA	t	2026-01-29 05:46:59.574487	2026-01-29 05:46:59.574487
620	656	Keonjhar Central Co-Op Bank Ltd	ORCB0KJR001	SKCC	t	2026-01-29 05:46:59.591348	2026-01-29 05:46:59.591348
621	657	The Koraput Central Co-Op Bank Ltd	ORCB0KPT001	SKOC	t	2026-01-29 05:46:59.601164	2026-01-29 05:46:59.601164
622	658	Nagaland Rural Bank	SBIN0RRNLGB	NLGB	t	2026-01-29 05:46:59.61613	2026-01-29 05:46:59.61613
623	659	The Udupi Co-Op Town Bank	UTIB0SUCTBL	UCTB	t	2026-01-29 05:46:59.630534	2026-01-29 05:46:59.630534
624	660	Coastal Local Area Bank Ltd	MAHB000CB01	CLAB	t	2026-01-29 05:46:59.641366	2026-01-29 05:46:59.641366
625	661	The Bhagyalakshmi Mahila Sah Bank	HDFC0CBLMSB	BMSB	t	2026-01-29 05:46:59.655458	2026-01-29 05:46:59.655458
626	662	The Ssk Co-Op Bank Ltd	UTIB0SSSKCB	SSSK	t	2026-01-29 05:46:59.668098	2026-01-29 05:46:59.668098
627	663	Valmiki Urban Co-Op Bank Ltd	UTIB0SVAUB1	SVAU	t	2026-01-29 05:46:59.683517	2026-01-29 05:46:59.683517
628	664	The Bhandara District Central Co-Op Bank Ltd	YESB0BHN001	BHNL	t	2026-01-29 05:46:59.696228	2026-01-29 05:46:59.696228
629	665	The Nagar Sahakari Bank Ltd	UTIB0NBGKP1	NBKG	t	2026-01-29 05:46:59.711689	2026-01-29 05:46:59.711689
630	666	The Uttarsanda Peoples Co-Op Bank	UTIB0SUPCB1	SUPC	t	2026-01-29 05:46:59.72528	2026-01-29 05:46:59.72528
631	667	The Kakatiya Co-Op Urban Bank	UTIB0SKCUB1	SKCU	t	2026-01-29 05:46:59.734746	2026-01-29 05:46:59.734746
632	668	The Kranthi Co-Op Urban Bank Ltd	UTIB0SKRN01	SKRN	t	2026-01-29 05:46:59.752109	2026-01-29 05:46:59.752109
633	669	Sri Vasavamba Co-Op Bank Ltd	HDFC0CSVCBA	VCBA	t	2026-01-29 05:46:59.762929	2026-01-29 05:46:59.762929
634	670	The Union Co-Op Bank Ltd	HDFC0CUCBNR	UCBN	t	2026-01-29 05:46:59.773934	2026-01-29 05:46:59.773934
635	671	Citizens Co-Op Bank Ltd	IBKL01642C1	CCOB	t	2026-01-29 05:46:59.787048	2026-01-29 05:46:59.787048
636	672	Jawahar Sahakari Bank Ltd	IBKL0116JCB	JSBH	t	2026-01-29 05:46:59.801662	2026-01-29 05:46:59.801662
637	673	Bapuji Co-Op Bank Ltd	IBKL0364BCB	BOBL	t	2026-01-29 05:46:59.814335	2026-01-29 05:46:59.814335
638	674	Uttrakhand State Co-Co Bank Ltd	ICIC00USCBD	USCB	t	2026-01-29 05:46:59.825941	2026-01-29 05:46:59.825941
639	675	Udham Singh Nagar District Co-Op Bank Ltd	ICIC00USNDC	USND	t	2026-01-29 05:46:59.841987	2026-01-29 05:46:59.841987
640	676	The Burdwan Central Co-Op Bank Ltd	HDFC0CBCCBL	CBCB	t	2026-01-29 05:46:59.854223	2026-01-29 05:46:59.854223
641	677	Pimpri Chinchwad Sahakari Bank	IBKL0087PCS	PSCL	t	2026-01-29 05:46:59.866963	2026-01-29 05:46:59.866963
642	678	The Maharaja Co-Op Urban Bank Ltd	IBKL0031MCB	IMCB	t	2026-01-29 05:46:59.877429	2026-01-29 05:46:59.877429
643	679	The Kerala State Co-Op Bank Ltd	KSBK0000001	KCSB	t	2026-01-29 05:46:59.886905	2026-01-29 05:46:59.886905
644	680	The Visakhapatnam Co-Op Bank Ltd	IBKL0031VCB	TVCB	t	2026-01-29 05:46:59.901089	2026-01-29 05:46:59.901089
645	681	Sarvodaya Commercial Co-Op Bank Ltd	IBKL0443SCC	SCOB	t	2026-01-29 05:46:59.91441	2026-01-29 05:46:59.91441
646	682	The Samastipur District Central Co-Op Bank Ltd	IBKL0065SDC	SDCL	t	2026-01-29 05:46:59.927955	2026-01-29 05:46:59.927955
647	683	Belgaum Zilla Rani Channamma Mahila Sahakari Bank Niyamit	IBKL0101BZR	BZRB	t	2026-01-29 05:46:59.93845	2026-01-29 05:46:59.93845
648	684	The Chandrapur District Central Co-Op Bank Ltd	YESB0CDC016	CDBL	t	2026-01-29 05:46:59.950434	2026-01-29 05:46:59.950434
649	685	Ajantha Urban Co-Op Bank Ltd	YESB0AUCB01	AUCL	t	2026-01-29 05:46:59.965153	2026-01-29 05:46:59.965153
650	686	Mudgal Urban Co-Op Bank Ltd	UTIB0SMUB01	SMUB	t	2026-01-29 05:46:59.975695	2026-01-29 05:46:59.975695
651	687	Jodhpur Nagrik Sahakari Bank Ltd	HDFC0CJNB08	CJNB	t	2026-01-29 05:46:59.986584	2026-01-29 05:46:59.986584
652	688	Wardhman Urban Co-Op Bank Ltd	IBKL0510WUC	WUCL	t	2026-01-29 05:46:59.999335	2026-01-29 05:46:59.999335
653	689	Mizoram Co-Op Apex Bank Ltd	YESB0MAB001	MABL	t	2026-01-29 05:47:00.012026	2026-01-29 05:47:00.012026
654	690	The Naval Dockyard Co-Op Bank Ltd	IBKL0452ND1	NDBL	t	2026-01-29 05:47:00.024133	2026-01-29 05:47:00.024133
655	691	Vardhaman Mahila Co-Op Urban Bank Ltd	HDFC0CVB222	CVBL	t	2026-01-29 05:47:00.035563	2026-01-29 05:47:00.035563
656	692	Jammu And Kashmir State Co-Op Bank	UTIB0SJKCB1	SJKB	t	2026-01-29 05:47:00.045025	2026-01-29 05:47:00.045025
657	693	Jivan Commercial Co-Op Bank Ltd	IBKL0JIVAN1	JIVA	t	2026-01-29 05:47:00.057499	2026-01-29 05:47:00.057499
658	694	Krishna Bhima Samruddhi Local Area Bank	HDFC0CKBS01	KBSL	t	2026-01-29 05:47:00.069825	2026-01-29 05:47:00.069825
659	695	The Dahod Urban Co-Op Bank Ltd	HDFC0CDUCBE	TDUC	t	2026-01-29 05:47:00.084783	2026-01-29 05:47:00.084783
660	696	Shri Mahila Sewa Sahakari Bank Ltd	HDFC0CSMSSB	SMSS	t	2026-01-29 05:47:00.099017	2026-01-29 05:47:00.099017
661	697	Mahatma Fule Urban Co-Op Bank Ltd Amravati	HDFC0CMFUCB	MFUC	t	2026-01-29 05:47:00.109536	2026-01-29 05:47:00.109536
662	698	The Tiruvalla East Co-Op Bank	IBKL0029T03	TTEC	t	2026-01-29 05:47:00.121979	2026-01-29 05:47:00.121979
663	699	The Gandhi Co-Op Urban Bank Ltd	YESB0GCUB01	TGCU	t	2026-01-29 05:47:00.132349	2026-01-29 05:47:00.132349
664	700	The Anand Mercantile Co-Op Bank Ltd	HDFC0CAMCBK	AMBL	t	2026-01-29 05:47:00.14543	2026-01-29 05:47:00.14543
665	701	Nagrik Sahakari Bank Maryadit Vidisha	HDFC0CNSBMV	NSMV	t	2026-01-29 05:47:00.154846	2026-01-29 05:47:00.154846
666	702	Udyam Vikas Sahakari bank	HDFC0CUDYAM	UVSB	t	2026-01-29 05:47:00.167946	2026-01-29 05:47:00.167946
667	703	The Texco Co-Op Bank Ltd	YESB0TCB002	TCBL	t	2026-01-29 05:47:00.180625	2026-01-29 05:47:00.180625
668	704	Uma Co-Op Bank Ltd	YESB0UMA002	UMCB	t	2026-01-29 05:47:00.194182	2026-01-29 05:47:00.194182
669	705	Shri Shivayogi Murughendra Swami Urban Co-Op Bank Ltd	HDFC0CSSMSB	SMSU	t	2026-01-29 05:47:00.208918	2026-01-29 05:47:00.208918
670	706	Jila Sahakari Kendriya Bank Maryadit Vidisha	CBIN0MPDCBM	JSKV	t	2026-01-29 05:47:00.21936	2026-01-29 05:47:00.21936
671	707	Jila Sahakari Kendriya Bank Maryadit Ujjain	CBIN0MPDCBL	JSKU	t	2026-01-29 05:47:00.228777	2026-01-29 05:47:00.228777
672	708	Jila Sahakari Kendriya Bank Maryadit Dewas	CBIN0MPDCAJ	JSKD	t	2026-01-29 05:47:00.242033	2026-01-29 05:47:00.242033
673	709	The Sultan S Battery Co-Op Urban Bank Ltd	IBKL01708SB	SBCB	t	2026-01-29 05:47:00.264679	2026-01-29 05:47:00.264679
674	710	Sri Rama Co-Op Bank Ltd	HDFC0CSRCBL	SRBB	t	2026-01-29 05:47:00.287196	2026-01-29 05:47:00.287196
675	711	Sri Guru Raghavendra Sahakara Bank Niyamitha	IBKL0868GRS	SGRS	t	2026-01-29 05:47:00.303543	2026-01-29 05:47:00.303543
676	712	Navanagara Urban Co-Op Bank Ltd	HDFC0CNUCBK	NUBB	t	2026-01-29 05:47:00.315934	2026-01-29 05:47:00.315934
677	713	Subhadra Local Area Bank Ltd	HDFC0CSLABK	SLAB	t	2026-01-29 05:47:00.325306	2026-01-29 05:47:00.325306
678	714	Parbhani District Central Co-Op Bank	NULL	PDBH	f	2026-01-29 05:47:00.337391	2026-01-29 05:47:00.337391
679	715	The Gopalganj Central Gopalganj Co-Op Bank Ltd	IBKL01011GC	GCBL	t	2026-01-29 05:47:00.351308	2026-01-29 05:47:00.351308
680	716	The Bhatkal Urban Co-Op Bank Ltd	NULL	SBUL	f	2026-01-29 05:47:00.360946	2026-01-29 05:47:00.360946
681	717	Vaishya Nagari Sahakari Bank Ltd	UTIB0SVNS01	SVNS	t	2026-01-29 05:47:00.376196	2026-01-29 05:47:00.376196
682	718	The Fatehgarh Sahib Central Co-Op Bank Ltd	NULL	SFGH	f	2026-01-29 05:47:00.390193	2026-01-29 05:47:00.390193
683	719	Indore Cloth Mkt Co-Op Bank	YESB0ICMB02	ICMB	t	2026-01-29 05:47:00.40042	2026-01-29 05:47:00.40042
684	720	The Solapur Dist Central Co-Op Bank	NULL	BSDC	t	2026-01-29 05:47:00.412334	2026-01-29 05:47:00.412334
685	721	Latur District Central Co-Op Bank Ltd	IBKL0497LDC	ILDC	t	2026-01-29 05:47:00.42701	2026-01-29 05:47:00.42701
686	722	NSDL Payment Bank Limited	NULL	NSPB	t	2026-01-29 05:47:00.443566	2026-01-29 05:47:00.443566
687	723	The Pimpalgaon Merchants Co-Op Bank Ltd	HDFC0CPIMCO	CPIM	t	2026-01-29 05:47:00.454157	2026-01-29 05:47:00.454157
688	724	Mizoram Urban Co-Op Development Bank	YESB0MUDC01	MUDC	t	2026-01-29 05:47:00.468004	2026-01-29 05:47:00.468004
689	725	Indore Paraspar Sahakari Bank Ltd	ICIC00INPRS	INPR	t	2026-01-29 05:47:00.480505	2026-01-29 05:47:00.480505
690	726	The Co-Op Bank Of Mehsana Ltd	GSCB0UCOBML	CBML	t	2026-01-29 05:47:00.493762	2026-01-29 05:47:00.493762
691	727	The Gurgaon Central Co-Op Bank Ltd	NULL	BGBL	f	2026-01-29 05:47:00.507204	2026-01-29 05:47:00.507204
692	728	Dharamvir Sambhaji Urban Co-Op Bank	NULL	DSUB	f	2026-01-29 05:47:00.521479	2026-01-29 05:47:00.521479
693	729	Ramrajya Sahakari Bank Ltd	NULL	RRSB	f	2026-01-29 05:47:00.534131	2026-01-29 05:47:00.534131
694	730	Lonavala Sahakari Bank Ltd	NULL	LSAB	f	2026-01-29 05:47:00.545761	2026-01-29 05:47:00.545761
695	731	Sangli Urban Co Op Bank Ltd	NULL	CSUC	f	2026-01-29 05:47:00.557742	2026-01-29 05:47:00.557742
696	732	Jilla Kendriya Sahakari Maryadit Morena	CBIN0MPDCAV	DCAV	t	2026-01-29 05:47:00.573826	2026-01-29 05:47:00.573826
697	733	Jila Sahakari Maryadit Narsinghpur	CBIN0MPDCAW	DCAW	t	2026-01-29 05:47:00.588567	2026-01-29 05:47:00.588567
698	734	Jila Sahakari Maryadit Hoshangabad	CBIN0MPDCAN	DCAN	t	2026-01-29 05:47:00.602136	2026-01-29 05:47:00.602136
699	735	Jila Sahakari Maryadit Damoh	CBIN0MPDCAH	DCAH	t	2026-01-29 05:47:00.61554	2026-01-29 05:47:00.61554
700	736	Indore Premier Co-Op Bank	CBIN0MPDCAO	DCAO	t	2026-01-29 05:47:00.632109	2026-01-29 05:47:00.632109
701	737	The A.P. Raja Rajeswari Mahila Co-Op Urban Bank Ltd	UTIB0SAPRR2	APRR	t	2026-01-29 05:47:00.652152	2026-01-29 05:47:00.652152
702	738	Palus Sahakari Bank Ltd	UTIB0SPSB01	PSLB	t	2026-01-29 05:47:00.663812	2026-01-29 05:47:00.663812
703	739	Mahanagar Nagrik Sahakari Bank Ltd	YESB0MNSB01	MBSL	t	2026-01-29 05:47:00.676345	2026-01-29 05:47:00.676345
704	740	Urban Co-Op Bank Deharadun	YESB0DUCB01	DUCB	t	2026-01-29 05:47:00.688043	2026-01-29 05:47:00.688043
705	741	Smriti Nagrik Sahakari Bank	YESB0SNSB01	YNSB	t	2026-01-29 05:47:00.699408	2026-01-29 05:47:00.699408
706	742	Manndeshi Mahila Sahakari Bank	YESB0MAN001	MANB	t	2026-01-29 05:47:00.710922	2026-01-29 05:47:00.710922
707	743	Panchmahal District Co-Op Bank	GSCB0PDC001	PDCB	t	2026-01-29 05:47:00.722169	2026-01-29 05:47:00.722169
708	744	Sadhana Sahakari Bank Ltd,Nagpur	IBKL0041SB2	ISSB	t	2026-01-29 05:47:00.731892	2026-01-29 05:47:00.731892
709	745	The Thodupuzha Urban Co-Op Bank Ltd	ICIC00TPZCB	TPZC	t	2026-01-29 05:47:00.74289	2026-01-29 05:47:00.74289
710	746	The Modasa Nagarik Sahkari Bank Ltd	KKBK0MNSB01	KMNS	t	2026-01-29 05:47:00.754286	2026-01-29 05:47:00.754286
711	747	Mahaveer Co-Op Bank,Belgaum	HDFC0CTMCBL	CTMC	t	2026-01-29 05:47:00.765094	2026-01-29 05:47:00.765094
712	748	Nandura Urban Co-Op Bank Ltd	HDFC0CNUCBN	CNUC	t	2026-01-29 05:47:00.780583	2026-01-29 05:47:00.780583
713	749	Andman and Nicobar State Co-Op Bank Ltd	HDFC0CANSCB	ANCB	t	2026-01-29 05:47:00.795196	2026-01-29 05:47:00.795196
714	750	Balasinor Nagarik Sahkari Bank Ltd	HDFC0CBNSBL	BNSB	t	2026-01-29 05:47:00.807034	2026-01-29 05:47:00.807034
715	751	Zila Sahkari Bank Garhwal Kotdwar	ICIC00ZSKTW	ZSKT	t	2026-01-29 05:47:00.816664	2026-01-29 05:47:00.816664
716	752	Shree Murugharajendra Co-Op Bank Ltd	UTIB0SSMCBL	SMLB	t	2026-01-29 05:47:00.829359	2026-01-29 05:47:00.829359
717	753	Shimsha Sahakara Bank Niyamitha	BARB0VJCBSS	VSSB	t	2026-01-29 05:47:00.839063	2026-01-29 05:47:00.839063
718	754	The Kodinar Taluka Cooperative Banking Union Ltd	GSCB0KDT001	KDTL	t	2026-01-29 05:47:00.850472	2026-01-29 05:47:00.850472
719	755	Jilla Sahakari Kendriya Bank Maryadit Rajgarh	CBIN0MPDCAZ	DCAZ	t	2026-01-29 05:47:00.861941	2026-01-29 05:47:00.861941
720	756	Nagrik Sahakari Bank Maryadit Gwalior	INDB0NSBG01	NSBG	t	2026-01-29 05:47:00.873176	2026-01-29 05:47:00.873176
721	757	The Kodagu District Co-Op Central Bank Ltd	KSCB0011001	KCDB	t	2026-01-29 05:47:00.885235	2026-01-29 05:47:00.885235
722	758	Tirupati Urban Co-Op Bank Ltd	HDFC0CTUB02	TUCB	t	2026-01-29 05:47:00.899242	2026-01-29 05:47:00.899242
723	759	Shree Mahavir Sahakari Bank Ltd	KKBK0SMSB01	SMSL	t	2026-01-29 05:47:00.910995	2026-01-29 05:47:00.910995
724	760	The Gandhidham Mercantile Co-Op Bank Ltd	GSCB0UGMCBL	TGMC	t	2026-01-29 05:47:00.924084	2026-01-29 05:47:00.924084
725	761	The Railway Employees Co-Op Bank Ltd	UTIB0SRECB1	TREB	t	2026-01-29 05:47:00.934751	2026-01-29 05:47:00.934751
726	762	The Amravati Zila Parishad Shikshak Sahakari Bank	YESB0ASSB01	AZPS	t	2026-01-29 05:47:00.945184	2026-01-29 05:47:00.945184
727	763	Indraprastha Sahakari Bank Ltd	UTIB0SIPSB1	ISBL	t	2026-01-29 05:47:00.954352	2026-01-29 05:47:00.954352
728	764	The Merchants Souharda Sahakari Bank Ltd	UTIB0SMCB51	TMSS	t	2026-01-29 05:47:00.965232	2026-01-29 05:47:00.965232
729	765	The Kollam District Co-Op Bank Ltd	YESB0KLMDCB	TKDC	t	2026-01-29 05:47:00.976824	2026-01-29 05:47:00.976824
730	766	The Chanasma Nagrik Sahakari Bank Ltd	GSCB0UCHANA	CBBL	t	2026-01-29 05:47:00.98736	2026-01-29 05:47:00.98736
731	767	Samarth Sahakari Bank Ltd Jalna	HDFC0CSSBMJ	SSBJ	t	2026-01-29 05:47:01.000859	2026-01-29 05:47:01.000859
732	768	Kakinada Co-Op Town Bank Ltd	UTIB0SKCTBL	KCTB	t	2026-01-29 05:47:01.013626	2026-01-29 05:47:01.013626
733	769	Coimbatore District Central Co-Op Bank Ltd	TNSC0010000	CDCB	t	2026-01-29 05:47:01.024958	2026-01-29 05:47:01.024958
734	770	The Bangalore City Co-Op Bank Ltd	INDB0BCCB02	TBCC	t	2026-01-29 05:47:01.038288	2026-01-29 05:47:01.038288
735	771	Mahila Nagrik Sahakari Bank Maryadit Mahasamund	HDFC0CMNSBM	MNSM	t	2026-01-29 05:47:01.053478	2026-01-29 05:47:01.053478
736	772	The New Urban Co-Op Bank Ltd Rampur	HDFC0CNUCBL	NUBR	t	2026-01-29 05:47:01.064162	2026-01-29 05:47:01.064162
737	773	Shiva Sahakari Bank Niyamitha	UTIB0SSVA01	SSBS	t	2026-01-29 05:47:01.07961	2026-01-29 05:47:01.07961
738	774	The Guruvayur Co-Op Urban Bank Ltd	ICIC00GCUBL	TGCB	t	2026-01-29 05:47:01.090493	2026-01-29 05:47:01.090493
739	775	The National Central Co-Op Bank Ltd Bettiah	IBKL01248NC	NCBB	t	2026-01-29 05:47:01.100489	2026-01-29 05:47:01.100489
740	776	The Jain Sahakari Bank Ltd	IBKL0452JSB	JSBB	t	2026-01-29 05:47:01.112244	2026-01-29 05:47:01.112244
741	777	Vaishya Nagari Sahakari Bank Ltd Mumbai	IBKL0501VSB	VNSB	t	2026-01-29 05:47:01.126001	2026-01-29 05:47:01.126001
742	778	The Kannur District Co-Op Bank Ltd	UTIB0SKDC01	KDBB	t	2026-01-29 05:47:01.136864	2026-01-29 05:47:01.136864
743	779	Sarakari Naukarara Sahakari Bank Niyamit	UTIB0SSNSBK	NSBK	t	2026-01-29 05:47:01.147195	2026-01-29 05:47:01.147195
744	780	The Gurdaspur Central Co-Op Bank Ltd	NULL	SGDS	f	2026-01-29 05:47:01.160807	2026-01-29 05:47:01.160807
745	781	The Sirsa Central Co-Op Bank Ltd	NULL	SIRS	f	2026-01-29 05:47:01.172783	2026-01-29 05:47:01.172783
746	782	Jila Sahkari Kendriya Bank Maryadit,Jagdalpur	UTIB0SJSJ01	SJSJ	t	2026-01-29 05:47:01.183414	2026-01-29 05:47:01.183414
747	783	Yes Bank Credit Card	YESB0CMSNOC	YBCC	f	2026-01-29 05:47:01.194243	2026-01-29 05:47:01.194243
748	784	Kolar And Chikballapura District Co-Op Bank Ltd	NULL	KCDC	f	2026-01-29 05:47:01.207916	2026-01-29 05:47:01.207916
749	785	Beed District Central Co-Op Bank Ltd	NULL	SBDC	f	2026-01-29 05:47:01.217535	2026-01-29 05:47:01.217535
750	786	The Bellary District Co-Op Central Bank Ltd	IBKL0103901	BCDB	t	2026-01-29 05:47:01.230113	2026-01-29 05:47:01.230113
751	787	Yavatmal Dist Central Co-Op Bank Ltd	UTIB0SYDC01	SYDC	t	2026-01-29 05:47:01.240446	2026-01-29 05:47:01.240446
752	788	Sree Charan Souhardha Co-Op Bank Ltd	NULL	SCSC	t	2026-01-29 05:47:01.249841	2026-01-29 05:47:01.249841
753	789	Pune Urban Co-Op Bank Ltd	HDFC0CCPUBL	CCPU	t	2026-01-29 05:47:01.260939	2026-01-29 05:47:01.260939
754	790	Chikmagalur Pattana Sahakara Bank	UTIB0SCPSBN	SCPS	t	2026-01-29 05:47:01.272264	2026-01-29 05:47:01.272264
755	791	Veerashaiva Sahakari Bank Ltd	HDFC0CVSBHO	CVSB	t	2026-01-29 05:47:01.2846	2026-01-29 05:47:01.2846
756	792	Kolhapur District Central Co-Op Bank Ltd	IBKL0463KDC	KDBC	t	2026-01-29 05:47:01.295365	2026-01-29 05:47:01.295365
757	793	Loknete Dattaji Patil Sahkari Bank Ltd	IBKL01992L1	LDSB	t	2026-01-29 05:47:01.308549	2026-01-29 05:47:01.308549
758	794	The Maharashtra Mantralaya And Allied Offices Co-Op Bank Ltd	IBKL0004MCB	CSUB	t	2026-01-29 05:47:01.317488	2026-01-29 05:47:01.317488
759	795	The Shillong Co-Op Urban Bank Ltd	IBKL0158SCU	MMAB	t	2026-01-29 05:47:01.327997	2026-01-29 05:47:01.327997
760	796	Bellad Bagewadi Urban Souharada Sahakari Bank	IBKL0101BBU	BBUS	t	2026-01-29 05:47:01.33818	2026-01-29 05:47:01.33818
761	797	The Mandvi Nagarik Sahakari Bank Ltd	GSCB0UTMNBL	MNBL	t	2026-01-29 05:47:01.35054	2026-01-29 05:47:01.35054
762	798	Hanamasagar Urban Co-Op Bank Ltd	UTIB0SHUCBL	HUCB	t	2026-01-29 05:47:01.363424	2026-01-29 05:47:01.363424
763	799	Bhuj Commercial Co-Op Bank Ltd	UTIB0BCCB01	BCCL	t	2026-01-29 05:47:01.374005	2026-01-29 05:47:01.374005
764	800	Shree Basaveshwar Urban Co-op Bank Ltd	UTIB0SBUBRN	BUBR	t	2026-01-29 05:47:01.386428	2026-01-29 05:47:01.386428
765	801	Ilkal Co-Op Bank Ltd	UTIB0SICB25	SICB	t	2026-01-29 05:47:01.396928	2026-01-29 05:47:01.396928
766	802	Sadalga Urban Souharda Sahakari Bank Niyamit	UTIB0SSUSSB	SUSS	t	2026-01-29 05:47:01.408179	2026-01-29 05:47:01.408179
767	803	Karnataka Mahila Sahkara Bank Nmt Chikmagalur	UTIB0SCJMSB	SCJB	t	2026-01-29 05:47:01.420424	2026-01-29 05:47:01.420424
768	804	Shri Chatrapati Shivaji Maharaj Sahakari Bank Niyamith Gulbarga	UTIB0SCSMSB	CSMS	t	2026-01-29 05:47:01.430329	2026-01-29 05:47:01.430329
769	805	Dausa Urban Co-Op Bank Ltd	UTIB0SDUCB3	SDUC	t	2026-01-29 05:47:01.443344	2026-01-29 05:47:01.443344
770	806	The Kanyakumari District Central Co-Op Bank	NULL	KKDB	f	2026-01-29 05:47:01.457725	2026-01-29 05:47:01.457725
771	807	The Cuddalore District Central Co-Op Bank	NULL	CDCC	f	2026-01-29 05:47:01.46796	2026-01-29 05:47:01.46796
772	808	The Kumbakonam District Central Co-Op Bank	NULL	KDBL	f	2026-01-29 05:47:01.477916	2026-01-29 05:47:01.477916
773	809	The Thoothukudi District Central Co-Op Bank	NULL	TDBL	f	2026-01-29 05:47:01.490596	2026-01-29 05:47:01.490596
774	810	The Tirunelveli District Central Co-Op Bank	NULL	TTBL	f	2026-01-29 05:47:01.508762	2026-01-29 05:47:01.508762
775	811	The Vellore District Central Co-Op Bank	NULL	VDBL	f	2026-01-29 05:47:01.52424	2026-01-29 05:47:01.52424
776	812	Dharmapuri District Central Co-Op Bank	NULL	DDBL	f	2026-01-29 05:47:01.542943	2026-01-29 05:47:01.542943
777	813	Sri Sudha Co-Op Bank Ltd	HDFC0CSUDHA	SUDH	t	2026-01-29 05:47:01.555559	2026-01-29 05:47:01.555559
778	814	The Dhanera Mercantile Co-Op Bank Ltd	HDFC0CDMCBL	CDMC	t	2026-01-29 05:47:01.566365	2026-01-29 05:47:01.566365
779	816	Sanmitra Mahila Nagari Sahakari Bank Maryadit Chandrapur	HDFC0CSMNSB	SMNS	t	2026-01-29 05:47:01.58113	2026-01-29 05:47:01.58113
780	817	Colour Merchants Co-Op Bank Ltd	HDFC0CCMCBL	CCMC	t	2026-01-29 05:47:01.591914	2026-01-29 05:47:01.591914
781	818	The Gandhidham Co-Op Bank Ltd	HDFC0CGCBLG	GCLB	t	2026-01-29 05:47:01.608156	2026-01-29 05:47:01.608156
782	819	Shree Samarth Sah Bank Ltd Nashik	HDFC0CSSBNK	SBNK	t	2026-01-29 05:47:01.620142	2026-01-29 05:47:01.620142
783	820	The Dahod Mercantile Co-Op Bank Ltd	HDFC0CDMCBD	MCBD	t	2026-01-29 05:47:01.63291	2026-01-29 05:47:01.63291
784	821	Shri Laxmikrupa Urban Co-Op Bank Ltd	HDFC0CSLKUB	SLKU	t	2026-01-29 05:47:01.643937	2026-01-29 05:47:01.643937
785	822	The Godhra City Co-Op Bank Ltd	HDFC0CGCCB1	GCCB	t	2026-01-29 05:47:01.657473	2026-01-29 05:47:01.657473
786	823	Sreenidhi Souharda Sahakari Bank Niyamitha	INDB0SSBN01	SBNL	t	2026-01-29 05:47:01.671633	2026-01-29 05:47:01.671633
787	824	Jila Sahakari Kendriya Bank Maryadit Guna	CBIN0MPDCAL	MDCA	t	2026-01-29 05:47:01.684393	2026-01-29 05:47:01.684393
788	825	Jila Sahakari Kendriya Bank Mydt Khargone	CBIN0MPDCAS	PDCA	t	2026-01-29 05:47:01.69866	2026-01-29 05:47:01.69866
789	826	Vikramaditya Nagrik Sahakari Bank	YESB0VNSB01	VNBS	t	2026-01-29 05:47:01.714517	2026-01-29 05:47:01.714517
790	827	Rajsamand Urban Co-Op Bank Udaipur	YESB0RUCB05	RUCB	t	2026-01-29 05:47:01.727189	2026-01-29 05:47:01.727189
791	828	Jila Sahakari Kendriya Bank Maryadit Sagar	CBIN0MPDCBC	MCBC	t	2026-01-29 05:47:01.739351	2026-01-29 05:47:01.739351
792	829	Sahyadri Sahakari Bank Ltd	NULL	TSBL	f	2026-01-29 05:47:01.751787	2026-01-29 05:47:01.751787
793	830	Bangiya Gramin Vikash Bank	NULL	BGVB	f	2026-01-29 05:47:01.77024	2026-01-29 05:47:01.77024
794	831	Arunachal Pradesh State Co-Op,Apex Bank Ltd.	NULL	ARCB	f	2026-01-29 05:47:01.782428	2026-01-29 05:47:01.782428
795	832	Pusad Urban Co-Op Bank Ltd.	YESB0PUB001	PUBC	t	2026-01-29 05:47:01.796488	2026-01-29 05:47:01.796488
796	833	The Vaishali District Central Co-Op Bank	IBKL0724VDC	VCDB	t	2026-01-29 05:47:01.810043	2026-01-29 05:47:01.810043
797	834	Sardar Singh Nagrik Sahkari Bank Ltd	HDFC0CSSNSB	CSSN	t	2026-01-29 05:47:01.821692	2026-01-29 05:47:01.821692
798	835	Baran Nagrik Sahkari Bank Ltd	HDFC0CBNB01	BSNB	t	2026-01-29 05:47:01.833457	2026-01-29 05:47:01.833457
799	836	The Shahada Peoples Co-Op Bank Ltd	YESB0SPCB01	SPBC	t	2026-01-29 05:47:01.844137	2026-01-29 05:47:01.844137
800	837	Sri Kanyakaparameswari Co-Op Bank Ltd	UTIB0SSKPCB	SSKP	t	2026-01-29 05:47:01.855589	2026-01-29 05:47:01.855589
801	838	Jijau Commercial Co-Op Bank Ltd	IBKL0JCB001	JCBC	t	2026-01-29 05:47:01.865164	2026-01-29 05:47:01.865164
802	839	Vyavsayik Sahakari Bank	YESB0VSBL02	VSLB	t	2026-01-29 05:47:01.875978	2026-01-29 05:47:01.875978
803	840	Shriram Urban Co-Op Bank Ltd	KKBK0SUCB01	SUBC	t	2026-01-29 05:47:01.887176	2026-01-29 05:47:01.887176
804	841	Amreli Jilla Madhyastha Sahakari Bank Ltd	GSCB0AMR001	AMRB	f	2026-01-29 05:47:01.898164	2026-01-29 05:47:01.898164
805	842	The Womens Co-Op Bank Ltd	IBKL0546WCB	WCBL	t	2026-01-29 05:47:01.909789	2026-01-29 05:47:01.909789
806	843	The Jain Co-Op Bank Ltd	NULL	JCLB	f	2026-01-29 05:47:01.922428	2026-01-29 05:47:01.922428
807	844	The Panvel Co-Op Urban bank Ltd	IBKL0189PUC	PCUB	t	2026-01-29 05:47:01.934336	2026-01-29 05:47:01.934336
808	845	Wana Nagrik Sahakari Bank Ltd	YESB0WANA01	WANA	t	2026-01-29 05:47:01.945922	2026-01-29 05:47:01.945922
809	846	UP Postal Primary Co-Op Bank Ltd	ICIC00PPCBL	PPBC	t	2026-01-29 05:47:01.95748	2026-01-29 05:47:01.95748
810	847	The Babasaheb Deshmukh Sahakari Bank Ltd	IBKL0467BDS	BDSS	t	2026-01-29 05:47:01.96901	2026-01-29 05:47:01.96901
811	848	The Abhinav SahakariBank Ltd	NULL	ABSL	t	2026-01-29 05:47:01.979013	2026-01-29 05:47:01.979013
812	849	The VSV Co-Op Bank Ltd	HDFC0CVSVCB	VSVB	t	2026-01-29 05:47:01.991564	2026-01-29 05:47:01.991564
813	850	The Urban Co-Op Bank Ltd No 1758 Perinthalmanna	URBN0000001	URBN	t	2026-01-29 05:47:02.003474	2026-01-29 05:47:02.003474
814	851	Pragati Mahila Nagrik Sahakari Bank Ltd Bhilai	YESB0PMNSB1	PMNS	t	2026-01-29 05:47:02.013413	2026-01-29 05:47:02.013413
815	852	HCBL Co-Op Bank Ltd	YESB0HCBL01	HBBL	t	2026-01-29 05:47:02.024621	2026-01-29 05:47:02.024621
816	853	Sree Mahayogi Lakshmamma Co-Op Bank	UTIB0SAVB01	SAVB	t	2026-01-29 05:47:02.036753	2026-01-29 05:47:02.036753
817	854	Nagarik Samabay Bank Ltd	NULL	NSBL	f	2026-01-29 05:47:02.048335	2026-01-29 05:47:02.048335
818	855	The District Co-Op Central Bank Ltd Medak	TSAB0017001	KDDBL	t	2026-01-29 05:47:02.059683	2026-01-29 05:47:02.059683
819	856	The Karimnagar District Co-Op Central Bank	TSAB0020001	MDDBL	t	2026-01-29 05:47:02.074324	2026-01-29 05:47:02.074324
820	857	Guardian Souharda Sahakari Bank Niyamita	SVCB0002001	GSSB	t	2026-01-29 05:47:02.084434	2026-01-29 05:47:02.084434
821	858	Rajarambapu Sahakari Bank Ltd Peth	RRBP0000001	RRBP	t	2026-01-29 05:47:02.095626	2026-01-29 05:47:02.095626
822	859	Mahalakshmi Co-Op Bank Limited,Udupi	IBKL0186MC2	MCLB	t	2026-01-29 05:47:02.11064	2026-01-29 05:47:02.11064
823	860	The Dindigul Central Co-Op Bank Ltd	NULL	DCCB	f	2026-01-29 05:47:02.121638	2026-01-29 05:47:02.121638
824	861	Sriramanagar Pattana Sahakara Bank Niyamith	IBKL01543SR	SRPB	t	2026-01-29 05:47:02.13233	2026-01-29 05:47:02.13233
825	862	Janatha Seva Co-Op Bank	JTSC0000002	JTSC	t	2026-01-29 05:47:02.143106	2026-01-29 05:47:02.143106
826	863	Nandani Sahakari Bank Ltd Nandani	HDFC0CNSBLN	NSBD	t	2026-01-29 05:47:02.153583	2026-01-29 05:47:02.153583
827	864	Nagaland State Co-Op Bank Ltd	UTIB0SNSCB1	NSCB	t	2026-01-29 05:47:02.163194	2026-01-29 05:47:02.163194
828	865	Balageria Central Co-Op Bank Ltd	NULL	BCLB	f	2026-01-29 05:47:02.17558	2026-01-29 05:47:02.17558
829	866	The Ludhiana Central Co-Op Bank Ltd	NULL	SLDH	f	2026-01-29 05:47:02.187169	2026-01-29 05:47:02.187169
830	867	Jogindra Central Co-Op Bank Ltd	YESB0JCCB01	JCCL	t	2026-01-29 05:47:02.203176	2026-01-29 05:47:02.203176
831	868	Arihant Urban Co-Op Bank Ltd	HDFC0CACOBL	ACLB	t	2026-01-29 05:47:02.216823	2026-01-29 05:47:02.216823
832	869	The Bantra Co Opertive Bank Ltd	HDFC0CBCBBK	BCCK	t	2026-01-29 05:47:02.230597	2026-01-29 05:47:02.230597
833	870	Godavari Urban Co-Op Bank Ltd	HDFC0CGCB01	CGCB	t	2026-01-29 05:47:02.241477	2026-01-29 05:47:02.241477
834	871	Mahesh Urban Co-Op Bank Ltd	YESB0SMBLHO	MBLH	t	2026-01-29 05:47:02.253308	2026-01-29 05:47:02.253308
835	872	Warangal Urban Co-Op Bank Ltd	YESB0WUCB01	WBUL	t	2026-01-29 05:47:02.26576	2026-01-29 05:47:02.26576
836	873	Abasaheb Patil Rendal Sahakari Bank Ltd	IBKL0116RSB	APRS	t	2026-01-29 05:47:02.276493	2026-01-29 05:47:02.276493
837	874	Reserve Bank Employees Co-Op Bank Ltd	INDB0RBECBL	RBEC	t	2026-01-29 05:47:02.289051	2026-01-29 05:47:02.289051
838	875	Rajadhani Co-Op Urban Bank Ltd	KKBK0RCUB01	RCUB	t	2026-01-29 05:47:02.301845	2026-01-29 05:47:02.301845
839	876	The Kopargaon Peoples Co-Op Bank Ltd	SVCB0035002	KPCB	t	2026-01-29 05:47:02.312468	2026-01-29 05:47:02.312468
840	877	Dhule Vikas Sahakari Bank Ltd	ICIC00DVSBL	DVSB	t	2026-01-29 05:47:02.324429	2026-01-29 05:47:02.324429
841	878	Koilkuntla Co-Op Bank Ltd	INDB0KCBL01	KBCL	t	2026-01-29 05:47:02.341078	2026-01-29 05:47:02.341078
842	879	Appasaheb Birnale Sahakari Bank Ltd Dudhgaon	IBKL01894AB	ABSB	t	2026-01-29 05:47:02.351092	2026-01-29 05:47:02.351092
843	880	Progressive Co-Op Bank Ltd	NULL	PCLB	f	2026-01-29 05:47:02.362195	2026-01-29 05:47:02.362195
844	881	IDFC First Bank Limited - Credit Card	IDFB0000001	IFCC	t	2026-01-29 05:47:02.373909	2026-01-29 05:47:02.373909
845	882	Federal Bank Credit Card	FDRL00CARDS	FBCC	t	2026-01-29 05:47:02.38704	2026-01-29 05:47:02.38704
846	883	The District Central CooOp Bank Ltd Khammam	TSAB0022001	KOCB	t	2026-01-29 05:47:02.400509	2026-01-29 05:47:02.400509
847	884	Shree Talaja Nagrik Sahakari Bank Ltd	HDFC0CTALAJ	STNS	t	2026-01-29 05:47:02.412742	2026-01-29 05:47:02.412742
848	885	S S L S A Kurundwad Urban Bank Ltd	IBKL0116SBK	SLSA	t	2026-01-29 05:47:02.423508	2026-01-29 05:47:02.423508
849	887	Betul Nagrik Sahakari Bank Mydt	UTIB0001350	BTNB	t	2026-01-29 05:47:02.437203	2026-01-29 05:47:02.437203
850	888	AP Janata Co-Op Urban Bank Ltd	HDFC0CAPJBK	AJCB	t	2026-01-29 05:47:02.449498	2026-01-29 05:47:02.449498
851	889	Muzaffarnagar District Co-Operative Bank Ltd	UPCB00MUZAF	MUZA	t	2026-01-29 05:47:02.462319	2026-01-29 05:47:02.462319
852	890	Chaitanya Mahila Sahakari Bank Ltd Vijayapur	UTIB0SCHAIT	CMSB	t	2026-01-29 05:47:02.471938	2026-01-29 05:47:02.471938
853	891	PUDUVAI BHARATHIAR GRAMA BANK	IDIB0PBG001	PBGB	t	2026-01-29 05:47:02.483361	2026-01-29 05:47:02.483361
854	892	Nagar Sahkari Bank Ltd,Maharajgan	YESB0NSB006	NBSL	t	2026-01-29 05:47:02.495999	2026-01-29 05:47:02.495999
855	893	The Warangal District Co-Op Central Bank Ltd	TSAB0021001	WDCB	t	2026-01-29 05:47:02.507969	2026-01-29 05:47:02.507969
856	894	Vidarbha Merchants Urban Co-Op Bank Ltd	YESB0VMUB00	VMUB	t	2026-01-29 05:47:02.520176	2026-01-29 05:47:02.520176
857	895	Siddheshwar Urban Co-Op Bank Maryadit Sillod	ICIC00SIDUC	SUMS	t	2026-01-29 05:47:02.533785	2026-01-29 05:47:02.533785
858	896	The Sarangpur Co-Op Bank Ltd	GSCB0UTSCBL	TREA	t	2026-01-29 05:47:02.544675	2026-01-29 05:47:02.544675
859	897	Northern Railway Primary Co-Op Bank	UTIB0SNRP03	NRPC	t	2026-01-29 05:47:02.556757	2026-01-29 05:47:02.556757
860	898	Nagarik Sahakari Bank Maryadit Durg	HDFC0CNSBLD	NSBM	t	2026-01-29 05:47:02.572779	2026-01-29 05:47:02.572779
861	899	The Chandwad Merchants Co-Op Bank Ltd	ICIC00CMCBL	CBCL	t	2026-01-29 05:47:02.587183	2026-01-29 05:47:02.587183
862	900	Ujjain Paraspar Sahakari Bank Mydt	YESB0UPSBL1	UPSM	t	2026-01-29 05:47:02.602583	2026-01-29 05:47:02.602583
863	901	The Urban Co-Op Bank Ltd Saharanpur	IBKL0236UCS	TBLS	t	2026-01-29 05:47:02.617748	2026-01-29 05:47:02.617748
864	902	The Santrampur Urban Co-Op Ltd Saharanpur	GSCB0000001	TSCS	t	2026-01-29 05:47:02.633424	2026-01-29 05:47:02.633424
865	903	The Nanded Merchants Coop Bank Ltd Nanded	IBKL0500NMC	TNMN	t	2026-01-29 05:47:02.645195	2026-01-29 05:47:02.645195
866	904	The Raichur District Central Co-Op Bank Ltd Raichur	IBKL0296RDC	TRDR	t	2026-01-29 05:47:02.65787	2026-01-29 05:47:02.65787
867	906	The Konark Urban Co-Op Bank Ltd	YESB0KNUCB1	KNUC	t	2026-01-29 05:47:02.670428	2026-01-29 05:47:02.670428
868	907	Shri Chhani Nagrik Bank Ltd	HDFC0CSCNSB	CSNB	t	2026-01-29 05:47:02.68532	2026-01-29 05:47:02.68532
869	908	The Chiplun Urban Co-Op Bank Ltd	SVCB0006020	CCUB	t	2026-01-29 05:47:02.700502	2026-01-29 05:47:02.700502
870	909	The Sardargunj Mercantile Co-Op Bank Ltd Patan	NULL	TSMP	t	2026-01-29 05:47:02.713173	2026-01-29 05:47:02.713173
871	910	The dholpur Urban Co-Op Bank Ltd Dholpur	HDFC0CDUCB1	TDUO	t	2026-01-29 05:47:02.723131	2026-01-29 05:47:02.723131
872	911	Kashipur Urban Co-Op Bank Ltd	HDFC0CKUCPL	KUCO	t	2026-01-29 05:47:02.733815	2026-01-29 05:47:02.733815
873	912	Shri Yashwant Sahakari Bank Maryadit Kuditre	IBKL0463YSB	SYMK	t	2026-01-29 05:47:02.746786	2026-01-29 05:47:02.746786
874	913	The Mumbai Mahanagarpalika Shikshan Vibhag Sahakari Bank Ltd	MDCB0680289	TMMS	t	2026-01-29 05:47:02.756882	2026-01-29 05:47:02.756882
875	914	Brahmadeodada Mane Sahakari Bank Ltd Solapur	YESB0BMSB01	BMSS	t	2026-01-29 05:47:02.767601	2026-01-29 05:47:02.767601
876	915	The Veraval peoples Co-Op Bank Ltd	HDFC0CVPCBL	TVPC	t	2026-01-29 05:47:02.778136	2026-01-29 05:47:02.778136
877	917	Vasundhara Mahila Nagari Sahakari Bank Ltd	ICIC00VMNSL	VMNS	t	2026-01-29 05:47:02.790572	2026-01-29 05:47:02.790572
878	918	Zila Sahakari Bank Ltd Unnao	UPCB00UDCCB	UDDC	t	2026-01-29 05:47:02.801441	2026-01-29 05:47:02.801441
879	919	Zila Sahakari Bank Ltd Varanasi	UPCB00VDCBL	VCLD	t	2026-01-29 05:47:02.814051	2026-01-29 05:47:02.814051
880	920	Sri Ganapathi Urban Co-Op Bank	UTIB0SSGUCB	GUCB	t	2026-01-29 05:47:02.826907	2026-01-29 05:47:02.826907
881	921	The Nagaur Central Co-Op Bank Ltd	NULL	TNCD	f	2026-01-29 05:47:02.837533	2026-01-29 05:47:02.837533
882	923	Axis Bank Tehatta	NULL	ABTT	f	2026-01-29 05:47:02.852788	2026-01-29 05:47:02.852788
883	924	LIC Employees Co-Op Bank Ltd Udupi	IBKL0186LEC	LICU	t	2026-01-29 05:47:02.864021	2026-01-29 05:47:02.864021
884	925	The Bapunagar Mahila Co-Op Bank Ltd	GSCB0UBMCBL	TBML	t	2026-01-29 05:47:02.876729	2026-01-29 05:47:02.876729
885	926	The Rander Peoples Co-Op Bank Ltd	HDFC0CRPCBL	TRPC	t	2026-01-29 05:47:02.887613	2026-01-29 05:47:02.887613
886	927	Sri Seetharaghava Souharda Sahakara Bank Niyamitha	UTIB0SSSSBN	SBSN	t	2026-01-29 05:47:02.901261	2026-01-29 05:47:02.901261
887	928	RBL (Ratnakar) Bank Credit Card	RATN0CRCARD	AUCC	t	2026-01-29 05:47:02.911909	2026-01-29 05:47:02.911909
888	929	The Sarvodaya Sahakari Bank Ltd Modasa	GSCB0USSBLM	USSB	t	2026-01-29 05:47:02.925797	2026-01-29 05:47:02.925797
889	930	Cherpalcheri Co-Op Urban Bank Ltd	IBKL0763CCB	CPOB	t	2026-01-29 05:47:02.938972	2026-01-29 05:47:02.938972
890	931	Shree Vardhaman Sahakari Bank Ltd	YESB0SVSB01	SVSB	t	2026-01-29 05:47:02.957426	2026-01-29 05:47:02.957426
891	932	The Nabadwip Co-Op Credit Bank Ltd	HDFC0CNCCBL	CNCC	t	2026-01-29 05:47:02.970436	2026-01-29 05:47:02.970436
892	933	Amazon Pay Axis Bank	@apl	APAB	f	2026-01-29 05:47:02.984503	2026-01-29 05:47:02.984503
893	934	Amazon Pay Yes Bank	@yapl	APYB	f	2026-01-29 05:47:02.998982	2026-01-29 05:47:02.998982
894	935	Amazon Pay RBL Bank	@rapl	APRB	f	2026-01-29 05:47:03.011192	2026-01-29 05:47:03.011192
895	936	Bajaj Finserv Axis Bank	@abfspay	BFAB	f	2026-01-29 05:47:03.023359	2026-01-29 05:47:03.023359
896	937	CRED Axis Bank	@axisb	CAB	f	2026-01-29 05:47:03.037615	2026-01-29 05:47:03.037615
897	938	IDFC FIRST Bank	@idfcbank	IFB	t	2026-01-29 05:47:03.050942	2026-01-29 05:47:03.050942
898	939	Goibibo ICICI bank	@icici	GIB	f	2026-01-29 05:47:03.069907	2026-01-29 05:47:03.069907
899	940	Google Pay Axis Bank	@okaxis	GPAB	f	2026-01-29 05:47:03.080948	2026-01-29 05:47:03.080948
900	941	Google Pay HDFC Bank	@oksbi	GPHDFC	f	2026-01-29 05:47:03.091695	2026-01-29 05:47:03.091695
901	942	Google Pay ICICI	@okicici	GPICICI	f	2026-01-29 05:47:03.103299	2026-01-29 05:47:03.103299
902	943	Groww\tYes Bank	@yesg	GYB	f	2026-01-29 05:47:03.115131	2026-01-29 05:47:03.115131
903	944	Jupiter Money\tAxis Bank Limited	@jupiteraxis	JMAB	f	2026-01-29 05:47:03.12632	2026-01-29 05:47:03.12632
904	945	Kiwi\tAxis Bank Limited	@goaxb	KABL	f	2026-01-29 05:47:03.138725	2026-01-29 05:47:03.138725
905	946	Make My Trip IndusInd Bank	@indus	MMTIB	f	2026-01-29 05:47:03.15513	2026-01-29 05:47:03.15513
906	947	MobiKwik HDFC Bank	@ikwik	MHDFC	f	2026-01-29 05:47:03.166571	2026-01-29 05:47:03.166571
907	948	Navi Axis Bank	@naviaxis	NAB	f	2026-01-29 05:47:03.181001	2026-01-29 05:47:03.181001
908	949	Niyo Global ICICI Bank	@NIYOICICI	NGICICI	f	2026-01-29 05:47:03.193157	2026-01-29 05:47:03.193157
909	950	Phonepe Yes Bank	@ybl	PYB	f	2026-01-29 05:47:03.206337	2026-01-29 05:47:03.206337
910	951	Phonepe ICICI Bank	@ibl	PICICI	f	2026-01-29 05:47:03.220056	2026-01-29 05:47:03.220056
911	952	Phonepe Axis Bank	@axl	PAB	f	2026-01-29 05:47:03.232994	2026-01-29 05:47:03.232994
912	953	Samsung Pay Axis Bank	@pingpay	SPAB	f	2026-01-29 05:47:03.246006	2026-01-29 05:47:03.246006
913	954	Shriram One HDFC Bank	@shriramhdfcbank	SOHDFC	f	2026-01-29 05:47:03.259187	2026-01-29 05:47:03.259187
914	955	Slice\tAxis Bank	@sliceaxis	SAB	f	2026-01-29 05:47:03.274368	2026-01-29 05:47:03.274368
915	956	TataNeu ICICI Bank	@tapicici	TNICICI	f	2026-01-29 05:47:03.285671	2026-01-29 05:47:03.285671
916	957	Timepay The Cosmos Co-Operative Bank Ltd.	@timecosmos	TTCCB	f	2026-01-29 05:47:03.303618	2026-01-29 05:47:03.303618
917	958	WhatsApp ICICI Bank	@waicici	WICICI	f	2026-01-29 05:47:03.319741	2026-01-29 05:47:03.319741
918	959	WhatsApp Axis Bank	@waaxis	WAB	f	2026-01-29 05:47:03.332313	2026-01-29 05:47:03.332313
919	960	WhatsApp HDFC Bank	@wahdfcbank	WHDFC	f	2026-01-29 05:47:03.349126	2026-01-29 05:47:03.349126
920	961	WhatsApp State Bank of India	@wasbi	WSBI	f	2026-01-29 05:47:03.360595	2026-01-29 05:47:03.360595
\.


--
-- Data for Name: enquiries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enquiries (id, first_name, last_name, email, phone_number, aadhaar_number, pan_card, status, role_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: fund_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fund_requests (id, user_id, requested_by, amount, status, approved_by, approved_at, remark, image, transaction_type, mode, bank_reference_no, payment_mode, deposit_bank, your_bank, created_at, updated_at, reject_note, account_number, deposit_account_no, deposit_ifsc_code, ifsc_code) FROM stdin;
1	2	1	10000.0	success	\N	\N	dedo	\N	IMPS	fund	86876876	\N	Gautam	Bank of Baroda	2026-01-29 06:44:24.609704	2026-01-29 06:53:33.998609	\N	9924000100007471	779776876567576576	SURY0BK0000	BARB0KHARAD
2	3	2	1000.0	pending	\N	\N		\N	IMPS	fund	34534	\N	Bank of Baroda	Bank of Baroda	2026-01-29 07:11:49.048103	2026-01-29 07:11:49.048103	\N	4569456456485645	9924000100007471	BARB0KHARAD	BARB0KHARAD
4	3	2	1000.0	success	\N	\N	h	https://res.cloudinary.com/siddtec/image/upload/v1769671381/a76rhypl3z0lvnvowcf7.png	UPI	fund	34534	\N	Bank of Baroda	Bank of Baroda	2026-01-29 07:23:01.60327	2026-01-29 07:24:08.636328	\N	4569456456485645	9924000100007471	BARB0KHARAD	BARB0KHARAD
3	3	2	1000.0	success	\N	\N	hj	\N	Netbanking	fund	34534	\N	Bank of Baroda	Bank of Baroda	2026-01-29 07:21:06.040396	2026-01-29 08:57:54.598797	\N	4569456456485645	9924000100007471	BARB0KHARAD	BARB0KHARAD
5	4	3	900.0	success	\N	\N	fd	https://res.cloudinary.com/siddtec/image/upload/v1769683081/rjsvsmfckqzi4beelir6.png	NEFT	fund	ee	\N	Bank of Baroda	Axis Bank	2026-01-29 10:38:01.619373	2026-01-29 10:44:13.41915	\N	6867866867867	4569456456485645	BARB0KHARAD	UTIB0002193
6	5	4	500.0	success	\N	\N	fgf	https://res.cloudinary.com/siddtec/image/upload/v1769684684/umu7nbd1pyzbaqwezgdg.png	IMPS	fund	9878979789	\N	Axis Bank	Bank of Baroda	2026-01-29 11:04:44.869138	2026-01-29 11:06:12.716871	\N	1234567890	\N	UTIB0002193	BARB0KHARAD
\.


--
-- Data for Name: instant_loans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instant_loans (id, first_name, last_name, email, employee_status, mobile, dob, pan_number, aadhaar_number, monthly_income, credit_score, fetch_credit_score, created_at, updated_at, status, pending_note, user_id) FROM stdin;
\.


--
-- Data for Name: personal_loans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personal_loans (id, first_name, last_name, email, mobile, dob, pan_number, aadhaar_number, employee_status, employer_name, office_pin_code, monthly_income, credit_score, fetch_credit_score, pincode, created_at, updated_at, status, pending_note, user_id, lead_id) FROM stdin;
1	Mohammad Aamir	\N	mohammadaamir2002@gmail.com	9809809809	2000-01-14	BAJPC4350M	\N	salaried	dsf	\N	800000.0	660	\N	201206	2026-01-31 06:14:43.035661	2026-01-31 06:14:43.035661	\N	\N	\N	\N
2	manikant	\N	jgfg@g.com	9305096443	2004-02-01	BAJPC4350M	\N	salaried	dsf	\N	80000.0	877	\N	999999	2026-01-31 07:17:49.975741	2026-01-31 09:58:55.700225	approved	dsvsdv	5	\N
3	SIDDHARTH GAUTAM	\N	mohammadaamir2002@gmail.com	9305096443	2002-02-08	BAJPC4350M	\N	student	berojgar	\N	799930.0	888	\N	221122	2026-01-31 10:15:25.950667	2026-01-31 13:26:04.099025	rejected	ojiuhyggtfrd	5	\N
4	SIDDHARTH GAUTAM	Pop	mohammad@gmail.com	8697697698	2026-02-13	BAJPC4350M	\N	salaried	berojgar	212121	90000.0	900	\N	999999	2026-02-23 09:12:39.115159	2026-02-23 09:12:39.115159	\N	\N	\N	\N
5	Test	Khan	loan@gmail.com	7899878987	2026-02-06	PUNJK8989J	\N	self-employed	berojgar	212121	8000000.0	900	\N	999999	2026-02-23 09:29:42.595153	2026-02-23 09:29:42.595153	\N	\N	\N	\N
6	Test	Khan	mmj@gmail.com	7898789878	2002-02-07	PUNJK8989J	\N	salaried	berojgar	324898	9000000.0	900	\N	221122	2026-02-23 09:32:02.300329	2026-02-23 09:32:02.300329	\N	\N	\N	0a3ce312-52b8-4ac2-a080-67957635bc66
7	aleem	tyagi	testt@gmail.com	8787787878	2002-07-11	PUNJK8989B	\N	salaried	berojgar	333333	899999.0	890	\N	999999	2026-02-23 09:41:17.413857	2026-02-23 09:41:17.413857	\N	\N	\N	23aceb74-f6ab-431a-9aa8-e192e39923b5
8	Loppu	Khan	mohammadaamir2002@gmail.com	8787788998	2003-03-07	PUNJD9899J	\N	salaried	KING	123456	100000.0	850	\N	201206	2026-02-23 09:52:15.61689	2026-02-23 09:52:15.61689	\N	\N	\N	a2407f32-6899-4f92-8401-e6e78bd45ec4
\.


--
-- Data for Name: refund_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.refund_requests (id, user_id, transaction_id, parent_id, refund_id, refund_type, amount, reason, status, admin_note, processed_at, processed_by, attachment_url, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, title, created_at, updated_at) FROM stdin;
1	superadmin	2026-01-29 05:13:08.85804	2026-01-29 05:13:08.85804
2	admin	2026-01-29 05:13:19.59747	2026-01-29 05:13:19.59747
3	master	2026-01-29 05:13:23.956545	2026-01-29 05:13:23.956545
4	dealer	2026-01-29 05:13:27.554261	2026-01-29 05:13:27.554261
5	retailer	2026-01-29 05:13:32.318959	2026-01-29 05:13:32.318959
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
20251129094447
20251203090609
20251217064042
20251218060818
20251218065957
20251218120625
20251219112010
20260107123011
20260107124628
20260108064129
20260108065428
20260108072639
20260108110559
20260112053320
20260112071740
20260123073304
20260123094237
20260127101001
20260129114926
20260131071128
20260131102426
20260223091558
\.


--
-- Data for Name: schemes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schemes (id, scheme_name, scheme_type, commision_rate, created_at, updated_at, user_id) FROM stdin;
1	Gold	\N	\N	2026-01-29 05:16:53.735671	2026-01-29 05:16:53.735671	1
2	Gold	Percentage	\N	2026-01-29 06:58:40.557453	2026-01-29 06:58:40.557453	2
\.


--
-- Data for Name: service_product_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.service_product_items (id, name, oprator_type, status, created_at, updated_at, category_id, operator_id) FROM stdin;
1	Airtel Prepaid	\N	\N	2026-01-29 10:17:49.715795	2026-01-29 10:17:49.715795	1	\N
2	life insurance corporation	\N	\N	2026-01-30 10:02:01.906511	2026-01-30 10:02:01.906511	4	\N
3	North Bihar Power	\N	\N	2026-01-31 06:54:43.942889	2026-01-31 06:54:43.942889	5	\N
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
1	Mobile Recharge	\N	2026-01-29 05:18:42.160878	2026-01-29 05:18:42.160878	\N	\N
2	BBPS	\N	2026-01-29 05:18:48.437332	2026-01-29 05:18:48.437332	\N	\N
3	DTH/Cable	\N	2026-01-29 05:18:55.007304	2026-01-29 05:18:55.007304	\N	\N
4	Insurance	\N	2026-01-29 07:01:10.973459	2026-01-29 07:01:10.973459	\N	\N
5	Loan	\N	2026-01-29 07:01:16.514814	2026-01-29 07:01:16.514814	\N	\N
\.


--
-- Data for Name: support_tickets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.support_tickets (id, user_id, ticket_number, full_name, email, service_type, reference_id, subject, description, status, status_updated_at, resolution_note, resolved_at, assigned_agent_id, attachment_url, parent_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: transaction_commissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transaction_commissions (id, transaction_id, user_id, role, commission_amount, created_at, updated_at, service_product_item_id) FROM stdin;
1	1	2	\N	5.0	2026-01-29 11:33:46.969893	2026-01-29 11:33:46.969893	1
2	2	2	\N	5.0	2026-01-30 10:07:54.341205	2026-01-30 10:07:54.341205	2
3	3	2	\N	5.0	2026-01-31 06:54:53.021935	2026-01-31 06:54:53.021935	3
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactions (id, tx_id, operator, transaction_type, account_or_mobile, amount, status, user_id, created_at, updated_at, consumer_name, subscriber_or_vc_number, bill_no, landline_no, std_code, consumer_no, bank, mobile, vehicle_no, payment_method, ifsc_code, pan, upi_id, receiver_name, card_number, state, tid, tds, commission, status_text, txstatus_desc, category_id) FROM stdin;
1	TXN837506	Airtel Prepaid	Recharge	\N	5.0	SUCCESS	5	2026-01-29 11:33:46.86976	2026-01-29 11:34:57.534461	\N	\N	\N	\N	\N	\N	\N	7989878978	\N	\N	\N	\N	\N	\N	\N	\N	768676866787	\N	5.00	\N	\N	1
2	TXN310942	life insurance corporation	Recharge	\N	2996.0	SUCCESS	5	2026-01-30 10:07:54.272228	2026-01-30 10:07:54.272228	Nishant Sharma	\N	\N	\N	\N	\N	\N	9305096443	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	5.00	\N	\N	4
3	TXN330139	North Bihar Power	Recharge	\N	100.0	PENDING	5	2026-01-31 06:54:52.954486	2026-01-31 13:42:55.54673	AMIT KUMAR PANDEY	\N	\N	\N	\N	\N	\N	7888888888	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	5
\.


--
-- Data for Name: user_services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_services (id, assigner_id, assignee_id, service_id, created_at, updated_at) FROM stdin;
1	1	2	1	2026-01-29 05:19:09.332421	2026-01-29 05:19:09.332421
2	1	2	2	2026-01-29 05:19:09.340336	2026-01-29 05:19:09.340336
3	1	2	3	2026-01-29 05:19:09.347453	2026-01-29 05:19:09.347453
4	1	2	4	2026-01-29 07:01:54.245368	2026-01-29 07:01:54.245368
5	1	2	5	2026-01-29 07:01:54.254273	2026-01-29 07:01:54.254273
6	2	3	4	2026-01-29 07:02:36.19164	2026-01-29 07:02:36.19164
7	2	3	5	2026-01-29 07:02:36.203059	2026-01-29 07:02:36.203059
8	2	3	3	2026-01-29 07:02:36.214331	2026-01-29 07:02:36.214331
9	2	3	1	2026-01-29 07:02:36.222955	2026-01-29 07:02:36.222955
10	2	3	2	2026-01-29 07:02:36.230534	2026-01-29 07:02:36.230534
11	3	4	1	2026-01-29 09:03:41.013912	2026-01-29 09:03:41.013912
12	3	4	3	2026-01-29 09:03:41.025997	2026-01-29 09:03:41.025997
13	3	4	5	2026-01-29 09:03:41.03189	2026-01-29 09:03:41.03189
14	3	4	4	2026-01-29 09:03:41.037156	2026-01-29 09:03:41.037156
15	3	4	2	2026-01-29 09:03:41.044774	2026-01-29 09:03:41.044774
16	4	5	1	2026-01-29 10:11:53.751789	2026-01-29 10:11:53.751789
17	4	5	2	2026-01-29 10:11:53.75887	2026-01-29 10:11:53.75887
18	4	5	3	2026-01-29 10:11:53.764073	2026-01-29 10:11:53.764073
19	4	5	4	2026-01-29 10:11:53.768622	2026-01-29 10:11:53.768622
20	4	5	5	2026-01-29 10:11:53.773753	2026-01-29 10:11:53.773753
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, first_name, last_name, email, password_digest, role, otp, verify_otp, otp_expires_at, phone_number, country_code, alternative_number, aadhaar_number, pan_card, date_of_birth, gender, business_name, business_owner_type, business_nature_type, business_registration_number, gst_number, pan_number, address, city, state, pincode, landmark, username, scheme, referred_by, bank_name, account_number, ifsc_code, account_holder_name, notes, session_token, created_at, updated_at, role_id, status, company_type, company_name, cin_number, registration_certificate, user_admin_id, confirm_password, domain_name, scheme_id, service_id, pan_card_image, aadhaar_image, passport_photo, store_shop_photo, address_proof_photo, parent_id, set_pin, confirm_pin, latitude, longitude, captured_at, last_seen_at, ip_address, location, kyc_status, kyc_method, aadhaar_front_image, aadhaar_back_image, aadhaar_otp, pan_otp, pan_status, aadhaar_status, image, kyc_verifications, kyc_verified_at, kyc_data, email_otp, email_otp_sent_at, set_mpin, confirm_mpin, status_mpin, status_pin, email_otp_status, email_otp_verified_at, set_pin_status, user_code, eko_onboard_first_step, eko_profile_second_step, eko_status_otp, eko_verify_otp, eko_biometric_kyc, permanent_address, permanent_landmark, permanent_postal_code, permanent_city, permanent_state, permanent_pincode) FROM stdin;
5	Retaler	1	retailer@gmail.com	$2a$12$Uoxgg5a.QrbmNyFMLDTRI.eUOZeNkasOKlwFgTQfiMdq4UcrIj2RG	\N	\N	\N	\N	7567567576	+91	\N	777777777777	DAJPC4150P	2026-01-15	male	ghg	self	retail				fgf	fg	up	566665		retailer	\N	Admin	klkl	788888888888888	BARB0ABHAYK	fgfgg	Created from admin panel	TP8r4RmyFqFEUUeinaDoQwRm	2026-01-29 10:11:53.734705	2026-02-23 05:07:10.462422	5	t	\N	\N	\N	\N	\N	12345678	\N	2	\N	\N	\N	\N	\N	\N	4	123456	123456	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	t	f	t	2026-02-23 05:07:10.460989	f	\N	f	f	f	f	f	fgf		\N	fg	up	566665
3	master	1	master@gmail.com	$2a$12$8pvNtcgQwfBHVydWLgPHP.mMYYx1R4DWC7Qci3x1qyRaecSjOJ9NW	\N	\N	\N	\N	8989898999	+91	\N	222222222222	DAJPC4150P	2026-01-09	male	trty	self	retail	thf			Muradnagr	Ghaziabad	Uttar Pradesh	201206		master	\N	Admin	\N	922010023211252	SBIN0000001	kbjhmb	Created from admin panel	1MCMGxfjx9hssR3eLkwxucrc	2026-01-29 07:02:36.170925	2026-01-29 07:09:03.220965	3	t	\N	\N	\N	\N	\N	12345678	\N	2	\N	\N	\N	\N	\N	\N	2	123456	123456	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	t	f	t	2026-01-29 07:08:54.101906	f	\N	f	f	f	f	f	Muradnagr		\N	Ghaziabad	Uttar Pradesh	201206
1	\N	\N	superadmin@gmail.com	$2a$12$VEEMwtn8Cmqxb0vXFIAiPOvwp14KVubP4A/2sDyKo5fSFS9F5jFKe	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	5AXz1ygEE6YE5k6SNTdWKngT	2026-01-29 05:14:15.435769	2026-02-18 09:30:12.959538	1	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	123456	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	f	f	f	\N	f	\N	f	f	f	f	f	\N	\N	\N	\N	\N	\N
4	Dealer	1	dealer@gmail.com	$2a$12$vzo5tPEbLHjQ3z.qNS8FCOI1CpEFxTuq79m8wtFiyakBUGeonm/Ea	\N	\N	\N	\N	8798979789	+91		222222222222	DAJPC4150P	2026-01-16	male	trty	self	wholesale				Sector	Greater Noida	UP	201310		dealer	\N	Admin	rt	4569456456485645	HDFC0000003	567578587757	Created from admin panel	8xLPtStvCKQLnd3TtK9T4Cf2	2026-01-29 09:03:40.991429	2026-01-29 09:56:04.209375	4	t					\N	12345678		2	\N	https://res.cloudinary.com/siddtec/image/upload/v1769679892/users/pan/qzogai29sgslxw0kgikx.png					3	123456	123456	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	t	f	t	2026-01-29 09:55:55.020943	f	\N	f	f	f	f	f	Sector		\N	Greater Noida	UP	201310
2	Admin	wim	admin@gmail.com	$2a$12$wmR8yRpnjW7Q8g2jRaWruOhDxVnkasn52kJGtQFqYvjhcKrQiV.9S	\N	\N	\N	\N	4344343434343	\N	03443434334	876876876867233	JKGJGHJ688978	2026-01-07		lkjljkjlkjlkjlkj	lkjljkjlkjlkjlkj	lkjljkjlkjlkjlkj	lkjljkjlkjlkjlkj		\N		Noida	Uttar Pradesh	ds233232	\N	admin123	\N		Axis	687687676776876	IFDD96875	Retailers	\N	8jFyxZBwQ7xUnv54kuLvSNj7	2026-01-29 05:18:26.792933	2026-02-19 08:40:21.532831	2	t	\N	\N	\N	\N	\N	123456		1	\N	\N	\N	\N	\N	\N	1	123456	123456	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	\N	\N	t	f	t	2026-02-19 08:40:21.531729	f	\N	f	f	f	f	f	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: wallet_histories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wallet_histories (id, wallet_id, user_id, parent_id, amount, before_balance, after_balance, transaction_type, remark, reference_id, created_at, updated_at) FROM stdin;
1	2	1	\N	10000.0	100000.0	90000.0	debit	Wallet Transfer	1	2026-01-29 06:53:33.984404	2026-01-29 06:53:33.984404
2	1	2	1	10000.0	0.0	10000.0	credit	Fund Request Approved	1	2026-01-29 06:53:33.994376	2026-01-29 06:53:33.994376
3	1	2	1	1000.0	10000.0	9000.0	debit	Wallet Transfer	4	2026-01-29 07:24:08.612574	2026-01-29 07:24:08.612574
4	3	3	2	1000.0	0.0	1000.0	credit	Fund Request Approved	4	2026-01-29 07:24:08.629004	2026-01-29 07:24:08.629004
5	1	2	1	1000.0	9000.0	8000.0	debit	Wallet Transfer	3	2026-01-29 08:57:54.57659	2026-01-29 08:57:54.57659
6	3	3	2	1000.0	1000.0	2000.0	credit	Fund Request Approved	3	2026-01-29 08:57:54.589793	2026-01-29 08:57:54.589793
7	3	3	2	900.0	2000.0	1100.0	debit	Wallet Transfer	5	2026-01-29 10:44:13.405774	2026-01-29 10:44:13.405774
8	4	4	3	900.0	0.0	900.0	credit	Fund Request Approved	5	2026-01-29 10:44:13.415095	2026-01-29 10:44:13.415095
9	4	4	3	500.0	900.0	400.0	debit	Wallet Transfer	6	2026-01-29 11:06:12.694474	2026-01-29 11:06:12.694474
10	5	5	4	500.0	0.0	500.0	credit	Fund Request Approved	6	2026-01-29 11:06:12.710177	2026-01-29 11:06:12.710177
11	5	5	4	5.0	500.0	495.0	debit	Recharge Amount Deducted	TXN837506	2026-01-29 11:33:46.832938	2026-01-29 11:33:46.832938
12	1	2	1	5.0	8000.0	8005.0	credit	Recharge Commission	TXN837506	2026-01-29 11:33:46.94133	2026-01-29 11:33:46.94133
15	5	5	4	2996.0	400000.0	397004.0	debit	Recharge Amount Deducted	TXN310942	2026-01-30 10:07:54.245114	2026-01-30 10:07:54.245114
16	1	2	1	5.0	8005.0	8010.0	credit	Recharge Commission	TXN310942	2026-01-30 10:07:54.317061	2026-01-30 10:07:54.317061
17	5	5	4	100.0	397004.0	396904.0	debit	Recharge Amount Deducted	TXN330139	2026-01-31 06:54:52.934167	2026-01-31 06:54:52.934167
18	1	2	1	5.0	8010.0	8015.0	credit	Recharge Commission	TXN330139	2026-01-31 06:54:53.000066	2026-01-31 06:54:53.000066
\.


--
-- Data for Name: wallet_transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wallet_transactions (id, wallet_id, tx_id, mode, transaction_type, amount, status, description, created_at, updated_at, fund_request_id) FROM stdin;
1	1	TXN228513	fund	IMPS	10000.00	success	Fund request created by user 2	2026-01-29 06:44:24.688278	2026-01-29 06:53:34.00811	1
2	3	TXN125511	fund	IMPS	1000.00	pending	Fund request created by user 3	2026-01-29 07:11:49.123685	2026-01-29 07:11:49.123685	2
4	3	TXN789214	fund	UPI	1000.00	success	Fund request created by user 3	2026-01-29 07:23:01.641003	2026-01-29 07:24:08.649401	4
3	3	TXN797111	fund	Netbanking	1000.00	success	Fund request created by user 3	2026-01-29 07:21:06.074379	2026-01-29 08:57:54.608957	3
5	4	TXN394785	fund	NEFT	900.00	success	Fund request created by user 4	2026-01-29 10:38:01.675488	2026-01-29 10:44:13.426853	5
6	5	TXN336720	fund	IMPS	500.00	success	Fund request created by user 5	2026-01-29 11:04:44.919259	2026-01-29 11:06:12.724578	6
\.


--
-- Data for Name: wallets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wallets (id, user_id, balance, created_at, updated_at) FROM stdin;
2	1	90000.0	2026-01-29 06:51:35.902148	2026-01-29 06:53:33.962774
3	3	1100.0	2026-01-29 07:11:49.079269	2026-01-29 10:44:13.383074
4	4	400.0	2026-01-29 10:38:01.648854	2026-01-29 11:06:12.68454
6	5	200000000.0	2026-01-30 09:45:16.632675	2026-01-30 09:45:16.632675
5	5	396904.0	2026-01-29 11:04:44.897645	2026-01-31 06:54:52.900483
1	2	8015.0	2026-01-29 06:44:24.644798	2026-01-31 06:54:52.992564
\.


--
-- Name: account_transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_transactions_id_seq', 1, false);


--
-- Name: api_clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.api_clients_id_seq', 1, false);


--
-- Name: banks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.banks_id_seq', 6, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 12, true);


--
-- Name: commissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.commissions_id_seq', 6, true);


--
-- Name: dmt_transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dmt_transactions_id_seq', 1, false);


--
-- Name: dmts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dmts_id_seq', 1, false);


--
-- Name: eko_banks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.eko_banks_id_seq', 920, true);


--
-- Name: enquiries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enquiries_id_seq', 1, false);


--
-- Name: fund_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fund_requests_id_seq', 6, true);


--
-- Name: instant_loans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.instant_loans_id_seq', 1, false);


--
-- Name: personal_loans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personal_loans_id_seq', 8, true);


--
-- Name: refund_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.refund_requests_id_seq', 1, false);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 5, true);


--
-- Name: schemes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.schemes_id_seq', 2, true);


--
-- Name: service_product_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.service_product_items_id_seq', 3, true);


--
-- Name: service_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.service_products_id_seq', 1, false);


--
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.services_id_seq', 5, true);


--
-- Name: support_tickets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.support_tickets_id_seq', 1, false);


--
-- Name: transaction_commissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transaction_commissions_id_seq', 3, true);


--
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transactions_id_seq', 3, true);


--
-- Name: user_services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_services_id_seq', 20, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 5, true);


--
-- Name: wallet_histories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wallet_histories_id_seq', 18, true);


--
-- Name: wallet_transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wallet_transactions_id_seq', 6, true);


--
-- Name: wallets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wallets_id_seq', 6, true);


--
-- Name: account_transactions account_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_transactions
    ADD CONSTRAINT account_transactions_pkey PRIMARY KEY (id);


--
-- Name: api_clients api_clients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_clients
    ADD CONSTRAINT api_clients_pkey PRIMARY KEY (id);


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
-- Name: eko_banks eko_banks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eko_banks
    ADD CONSTRAINT eko_banks_pkey PRIMARY KEY (id);


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
-- Name: refund_requests refund_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refund_requests
    ADD CONSTRAINT refund_requests_pkey PRIMARY KEY (id);


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
-- Name: support_tickets support_tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.support_tickets
    ADD CONSTRAINT support_tickets_pkey PRIMARY KEY (id);


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
-- Name: wallet_histories wallet_histories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallet_histories
    ADD CONSTRAINT wallet_histories_pkey PRIMARY KEY (id);


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
-- Name: index_api_clients_on_api_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_api_clients_on_api_key ON public.api_clients USING btree (api_key);


--
-- Name: index_api_clients_on_user_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_api_clients_on_user_code ON public.api_clients USING btree (user_code);


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
-- Name: index_dmts_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_dmts_on_user_id ON public.dmts USING btree (user_id);


--
-- Name: index_enquiries_on_role_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_enquiries_on_role_id ON public.enquiries USING btree (role_id);


--
-- Name: index_fund_requests_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_fund_requests_on_user_id ON public.fund_requests USING btree (user_id);


--
-- Name: index_instant_loans_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_instant_loans_on_user_id ON public.instant_loans USING btree (user_id);


--
-- Name: index_personal_loans_on_lead_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_personal_loans_on_lead_id ON public.personal_loans USING btree (lead_id);


--
-- Name: index_personal_loans_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_personal_loans_on_user_id ON public.personal_loans USING btree (user_id);


--
-- Name: index_refund_requests_on_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_refund_requests_on_parent_id ON public.refund_requests USING btree (parent_id);


--
-- Name: index_refund_requests_on_transaction_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_refund_requests_on_transaction_id ON public.refund_requests USING btree (transaction_id);


--
-- Name: index_refund_requests_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_refund_requests_on_user_id ON public.refund_requests USING btree (user_id);


--
-- Name: index_schemes_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_schemes_on_user_id ON public.schemes USING btree (user_id);


--
-- Name: index_service_product_items_on_category_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_service_product_items_on_category_id ON public.service_product_items USING btree (category_id);


--
-- Name: index_service_product_items_on_operator_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_service_product_items_on_operator_id ON public.service_product_items USING btree (operator_id);


--
-- Name: index_service_products_on_category_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_service_products_on_category_id ON public.service_products USING btree (category_id);


--
-- Name: index_support_tickets_on_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_support_tickets_on_parent_id ON public.support_tickets USING btree (parent_id);


--
-- Name: index_support_tickets_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_support_tickets_on_user_id ON public.support_tickets USING btree (user_id);


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
-- Name: index_transactions_on_category_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_transactions_on_category_id ON public.transactions USING btree (category_id);


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
-- Name: index_wallet_histories_on_wallet_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_wallet_histories_on_wallet_id ON public.wallet_histories USING btree (wallet_id);


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
-- Name: personal_loans fk_rails_093fd0e42a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_loans
    ADD CONSTRAINT fk_rails_093fd0e42a FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: transactions fk_rails_0ea2ad3927; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT fk_rails_0ea2ad3927 FOREIGN KEY (category_id) REFERENCES public.categories(id);


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
-- Name: service_product_items fk_rails_2bc40d3811; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_product_items
    ADD CONSTRAINT fk_rails_2bc40d3811 FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: instant_loans fk_rails_302011e71d; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instant_loans
    ADD CONSTRAINT fk_rails_302011e71d FOREIGN KEY (user_id) REFERENCES public.users(id);


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
-- Name: schemes fk_rails_5f26bb7d01; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schemes
    ADD CONSTRAINT fk_rails_5f26bb7d01 FOREIGN KEY (user_id) REFERENCES public.users(id);


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
-- Name: dmts fk_rails_d2c33b0ffc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dmts
    ADD CONSTRAINT fk_rails_d2c33b0ffc FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: support_tickets fk_rails_d445c1f8e8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.support_tickets
    ADD CONSTRAINT fk_rails_d445c1f8e8 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: categories fk_rails_db8b64c2f7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT fk_rails_db8b64c2f7 FOREIGN KEY (service_id) REFERENCES public.services(id);


--
-- Name: refund_requests fk_rails_e79f3cdfbe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refund_requests
    ADD CONSTRAINT fk_rails_e79f3cdfbe FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: wallet_histories fk_rails_f1a783a004; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallet_histories
    ADD CONSTRAINT fk_rails_f1a783a004 FOREIGN KEY (wallet_id) REFERENCES public.wallets(id);


--
-- PostgreSQL database dump complete
--

\unrestrict 6uQhIfx13nIQnqa3AyBVbejVVtVgeQ0EuczsiGeLUNoO28id4x83edQUQRJy3eA

