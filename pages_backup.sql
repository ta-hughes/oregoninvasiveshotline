--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: category; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE category (
    category_id integer NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(100)
);


ALTER TABLE public.category OWNER TO root;

--
-- Name: category_category_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE category_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.category_category_id_seq OWNER TO root;

--
-- Name: category_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE category_category_id_seq OWNED BY category.category_id;


--
-- Name: comment; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE comment (
    comment_id integer NOT NULL,
    body text NOT NULL,
    created_on date NOT NULL,
    edited_on date NOT NULL,
    visibility integer NOT NULL,
    created_by_id integer NOT NULL,
    report_id integer NOT NULL
);


ALTER TABLE public.comment OWNER TO root;

--
-- Name: comment_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE comment_comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comment_comment_id_seq OWNER TO root;

--
-- Name: comment_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE comment_comment_id_seq OWNED BY comment.comment_id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO root;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO root;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO root;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO root;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_flatpage; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE django_flatpage (
    id integer NOT NULL,
    url character varying(100) NOT NULL,
    title character varying(200) NOT NULL,
    content text NOT NULL,
    enable_comments boolean NOT NULL,
    template_name character varying(70) NOT NULL,
    registration_required boolean NOT NULL
);


ALTER TABLE public.django_flatpage OWNER TO root;

--
-- Name: django_flatpage_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE django_flatpage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_flatpage_id_seq OWNER TO root;

--
-- Name: django_flatpage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE django_flatpage_id_seq OWNED BY django_flatpage.id;


--
-- Name: django_flatpage_sites; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE django_flatpage_sites (
    id integer NOT NULL,
    flatpage_id integer NOT NULL,
    site_id integer NOT NULL
);


ALTER TABLE public.django_flatpage_sites OWNER TO root;

--
-- Name: django_flatpage_sites_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE django_flatpage_sites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_flatpage_sites_id_seq OWNER TO root;

--
-- Name: django_flatpage_sites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE django_flatpage_sites_id_seq OWNED BY django_flatpage_sites.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO root;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO root;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO root;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.django_site OWNER TO root;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE django_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_site_id_seq OWNER TO root;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE django_site_id_seq OWNED BY django_site.id;


--
-- Name: image; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE image (
    image_id integer NOT NULL,
    image character varying(100) NOT NULL,
    name character varying(255) NOT NULL,
    created_on timestamp with time zone NOT NULL,
    visibility integer NOT NULL,
    comment_id integer,
    created_by_id integer NOT NULL,
    report_id integer,
    species_id integer
);


ALTER TABLE public.image OWNER TO root;

--
-- Name: image_image_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE image_image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.image_image_id_seq OWNER TO root;

--
-- Name: image_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE image_image_id_seq OWNED BY image.image_id;


--
-- Name: invite; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE invite (
    invite_id integer NOT NULL,
    created_on timestamp with time zone NOT NULL,
    created_by_id integer NOT NULL,
    report_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.invite OWNER TO root;

--
-- Name: invite_invite_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE invite_invite_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.invite_invite_id_seq OWNER TO root;

--
-- Name: invite_invite_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE invite_invite_id_seq OWNED BY invite.invite_id;


--
-- Name: region; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE region (
    region_id integer NOT NULL,
    name character varying(255) NOT NULL,
    center geometry(Point,4326) NOT NULL
);


ALTER TABLE public.region OWNER TO root;

--
-- Name: region_region_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE region_region_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.region_region_id_seq OWNER TO root;

--
-- Name: region_region_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE region_region_id_seq OWNED BY region.region_id;


--
-- Name: report; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE report (
    report_id integer NOT NULL,
    description text NOT NULL,
    location text NOT NULL,
    has_specimen boolean NOT NULL,
    point geometry(Point,4326) NOT NULL,
    created_on timestamp with time zone NOT NULL,
    edrr_status integer NOT NULL,
    is_archived boolean NOT NULL,
    is_public boolean NOT NULL,
    actual_species_id integer,
    claimed_by_id integer,
    created_by_id integer NOT NULL,
    reported_category_id integer NOT NULL,
    reported_species_id integer
);


ALTER TABLE public.report OWNER TO root;

--
-- Name: report_report_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE report_report_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.report_report_id_seq OWNER TO root;

--
-- Name: report_report_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE report_report_id_seq OWNED BY report.report_id;


--
-- Name: severity; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE severity (
    severity_id integer NOT NULL,
    name character varying(255) NOT NULL,
    color character varying(7) NOT NULL
);


ALTER TABLE public.severity OWNER TO root;

--
-- Name: severity_severity_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE severity_severity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.severity_severity_id_seq OWNER TO root;

--
-- Name: severity_severity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE severity_severity_id_seq OWNED BY severity.severity_id;


--
-- Name: species; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE species (
    species_id integer NOT NULL,
    name character varying(255) NOT NULL,
    scientific_name character varying(255) NOT NULL,
    remedy text NOT NULL,
    resources text NOT NULL,
    is_confidential boolean NOT NULL,
    category_id integer NOT NULL,
    severity_id integer NOT NULL
);


ALTER TABLE public.species OWNER TO root;

--
-- Name: species_species_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE species_species_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.species_species_id_seq OWNER TO root;

--
-- Name: species_species_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE species_species_id_seq OWNED BY species.species_id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE "user" (
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    user_id integer NOT NULL,
    email character varying(255) NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    prefix character varying(255) NOT NULL,
    suffix character varying(255) NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    is_active boolean NOT NULL,
    is_staff boolean NOT NULL,
    affiliations text NOT NULL
);


ALTER TABLE public."user" OWNER TO root;

--
-- Name: user_user_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE user_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_user_id_seq OWNER TO root;

--
-- Name: user_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE user_user_id_seq OWNED BY "user".user_id;


--
-- Name: category_id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY category ALTER COLUMN category_id SET DEFAULT nextval('category_category_id_seq'::regclass);


--
-- Name: comment_id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY comment ALTER COLUMN comment_id SET DEFAULT nextval('comment_comment_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY django_flatpage ALTER COLUMN id SET DEFAULT nextval('django_flatpage_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY django_flatpage_sites ALTER COLUMN id SET DEFAULT nextval('django_flatpage_sites_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY django_site ALTER COLUMN id SET DEFAULT nextval('django_site_id_seq'::regclass);


--
-- Name: image_id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY image ALTER COLUMN image_id SET DEFAULT nextval('image_image_id_seq'::regclass);


--
-- Name: invite_id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY invite ALTER COLUMN invite_id SET DEFAULT nextval('invite_invite_id_seq'::regclass);


--
-- Name: region_id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY region ALTER COLUMN region_id SET DEFAULT nextval('region_region_id_seq'::regclass);


--
-- Name: report_id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY report ALTER COLUMN report_id SET DEFAULT nextval('report_report_id_seq'::regclass);


--
-- Name: severity_id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY severity ALTER COLUMN severity_id SET DEFAULT nextval('severity_severity_id_seq'::regclass);


--
-- Name: species_id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY species ALTER COLUMN species_id SET DEFAULT nextval('species_species_id_seq'::regclass);


--
-- Name: user_id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY "user" ALTER COLUMN user_id SET DEFAULT nextval('user_user_id_seq'::regclass);


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: root
--

COPY category (category_id, name, icon) FROM stdin;
1	Micro-Organisms	
2	Aquatic Plants	
3	Land Plants	
4	Aquatic Invertebrates	
5	Aquatic Vertebrates	
6	Insects	
7	Fish	
8	Birds	
9	Mammals	
10	Land Mollusks	
13	Reptiles	
\.


--
-- Name: category_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('category_category_id_seq', 13, true);


--
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: root
--

COPY comment (comment_id, body, created_on, edited_on, visibility, created_by_id, report_id) FROM stdin;
\.


--
-- Name: comment_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('comment_comment_id_seq', 1, false);


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: root
--

COPY django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2015-08-03 14:15:57.301326-07	1	/example/ -- Example	1		14	1
2	2015-08-03 14:16:39.182292-07	1	/pages/example/ -- Example	2	Changed url.	14	1
3	2015-08-03 14:17:45.913152-07	1	/example/ -- Example	2	Changed url.	14	1
4	2015-08-03 14:20:05.431289-07	1	/pages/example/ -- Example	2	Changed url.	14	1
5	2015-08-03 14:23:43.72038-07	1	/pages/ -- Example	2	Changed url.	14	1
6	2015-08-03 14:30:45.262261-07	1	/pages/example/ -- Example	2	Changed url.	14	1
7	2015-08-03 14:33:47.908656-07	1	/pages/example/ -- Example	2	No fields changed.	14	1
8	2015-08-03 14:37:19.377159-07	1	/pages/example/ -- Example	2	Changed content.	14	1
9	2015-08-03 15:04:02.291524-07	1	/pages/example/ -- Example	2	Changed content.	14	1
10	2015-08-03 15:14:15.842137-07	1	/pages/example/ -- Example	2	Changed content.	14	1
11	2015-08-03 15:21:37.921235-07	1	/pages/example/ -- Example	2	Changed content.	14	1
12	2015-08-04 12:02:55.416876-07	1	example.com	3		13	1
13	2015-08-04 12:05:07.387974-07	2	http://oregoninvasiveshotline.org/	1		13	1
14	2015-08-04 12:05:09.123906-07	1	/pages/example/ -- Example	2	Changed sites.	14	1
15	2015-08-04 12:10:15.648296-07	1	/pages/example/ -- Example	2	No fields changed.	14	1
16	2015-08-04 12:10:41.769884-07	1	/pages/example/ -- Example	3		14	1
17	2015-08-04 12:11:13.080918-07	2	/pages/example/ -- Example	1		14	1
18	2015-08-04 12:12:20.237903-07	2	http://oregoninvasiveshotline.org/	3		13	1
19	2015-08-04 12:12:43.90227-07	3	/pages/example	1		13	1
20	2015-08-04 12:12:54.010946-07	2	/pages/example/ -- Example	2	Changed sites.	14	1
21	2015-08-04 12:13:23.725806-07	3	example	2	Changed domain.	13	1
22	2015-08-04 12:13:33.153981-07	2	/pages/example/ -- Example	2	No fields changed.	14	1
23	2015-08-04 12:14:13.154662-07	3	example	3		13	1
24	2015-08-04 12:14:22.968489-07	2	/pages/example/ -- Example	3		14	1
25	2015-08-04 12:20:49.577805-07	3	/pages/example/ -- Example	1		14	1
26	2015-08-04 15:17:34.819323-07	14	 -- 	3		14	1
27	2015-08-04 15:17:34.821872-07	13	 -- 	3		14	1
28	2015-08-04 15:17:34.822694-07	12	 -- 	3		14	1
29	2015-08-04 15:17:34.82336-07	11	 -- 	3		14	1
30	2015-08-04 15:17:34.825106-07	10	 -- 	3		14	1
31	2015-08-04 15:17:34.826-07	7	 -- 	3		14	1
32	2015-08-04 15:17:34.82661-07	6	 -- 	3		14	1
33	2015-08-04 15:17:34.830564-07	5	 -- 	3		14	1
34	2015-08-04 15:17:34.831518-07	4	 -- 	3		14	1
35	2015-08-04 15:40:34.813875-07	16	/SUP/ -- Example2	2	Changed url.	14	1
\.


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 35, true);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: root
--

COPY django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	contenttypes	contenttype
3	sessions	session
4	users	user
5	species	category
6	species	species
7	species	severity
8	regions	region
9	reports	report
10	reports	invite
11	images	image
12	comments	comment
13	sites	site
14	flatpages	flatpage
\.


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('django_content_type_id_seq', 14, true);


--
-- Data for Name: django_flatpage; Type: TABLE DATA; Schema: public; Owner: root
--

COPY django_flatpage (id, url, title, content, enable_comments, template_name, registration_required) FROM stdin;
25	/pages/detect/	Detect	Tips for Finding and Reporting Invasive Species: <span class=""encapsulated active-tab"">[Early Detection](/pages/detect)</span> <span class=""encapsulated"">[Learn](/pages/learn)</span> <span class=""encapsulated"">[Look](/pages/look)</span> <span class=""encapsulated"">[Reporting](/pages/report)</span>\r\n=============\r\n\r\nEarly Detection\r\n============= \r\n\r\nEarly Detection is the Key\r\n------------------------- \r\n\r\nTo protect Oregon from invasive species, it is important to stop new outbreaks before they start. By the time an invader is easily noticeable and begins to cause damage, it is often too late. It can be difficult and expensive to remove an established invader. However, by detecting new outbreaks early and acting quickly to control them, we can avoid many of the environmental and economic losses caused by invasive species.\r\n \r\nYou Can Help\r\n-------------------------\r\n \r\nIn their efforts to detect new outbreaks, invasive species experts in Oregon face the daunting challenge of tracking hundreds of potential new invaders across millions of acres of farms, forests, and waterways. They can't do it alone. They need the help of all Oregonians to be their eyes in the field.\r\n \r\nThe Oregon Invasive Species Online Hotline is designed to help you become involved in this effort. By using the Online Hotline to report suspected invasive species in your area, you'll be contributing vital early detection information to the experts best able to stop the spread of invasives. The Online Hotline also lets you connect directly with an expert to get positive identifications and answers to your questions.\r\n \r\n <span class=""encapsulated"">[NEXT: Learn About the Invaders >>](/pages/learn)</span>\r\n	f		f
26	/pages/look/	Look	Tips for Finding and Reporting Invasive Species: <span class="encapsulated">[Early Detection](/pages/detect)</span> <span class="encapsulated">[Learn](/pages/learn)</span> <span class="encapsulated active-tab">[Look](/pages/look)</span> <span class="encapsulated">[Reporting](/pages/report)</span>\r\n=============\r\n\r\nLook for Invaders\r\n=============\r\n\r\n Once you know what species to watch for, the next step is to look for them. Every time you are outdoors, take a few minutes to scan the area and look for signs of potential invasive species.\r\n \r\n Like a criminal investigator, you will be more successful spotting invasives in the field if you can "get inside the mind" of your suspects. For invasive plants, that means understanding when certain likely invaders emerge in the spring, when they flower and fruit, and when they lose their leaves in the fall. Knowing that certain types of invaders only reside in certain areas will make the task less overwhelming. Learn key habitats for particular invasive species. Some invaders only like shade. Others like the sun. Others only exist in forests, or prairies, or wetlands. What key characteristics makes that plant stand out from the rest of the vegetation? For invasive animals and insects, what kind of damage or evidence do they often leave behind?\r\n \r\n Here are a few tips on where to look:\r\n \r\n * Think pathways. Most invasive species spread along particular pathways such as along roads and trails, at trail heads, and other introduction points. Walk the boundaries of your property, as these new invaders can be creeping in from neighboring lands. Birds and wind also help spread invasive species, so it is possible to find many of these species in the interior of your land. Always keep an eye out for new invaders.\r\n * Think habitat. Which species to be looking for depends on the habitat they invade. Look for aquatic plant species in ditches, lakes, streams, and wetlands; look for terrestrial plant invaders along roadsides, in prairies, and fields; and look for riparian invaders along the edges of rivers, ponds, and even in roadside ditches.\r\n * Think distribution. Early detection means finding species that are still not abundant in a certain area so there is still a possibility or eradication or containment. Many invasive species, such as English Ivy, are already well established in Oregon and are not candidates for early detection and control. As you become more familiar with your environment and the species you'll get better at recognizing the native and established invasives in an area and noticing new species that seem out of place.\r\n \r\n <span class="encapsulated">[NEXT: Report Your Find >>](/pages/report)</span>\r\n \r\n	f		f
27	/pages/report/	Report	Tips for Finding and Reporting Invasive Species: <span class="encapsulated">[Early Detection](/pages/detect)</span> <span class="encapsulated">[Learn](/pages/learn)</span> <span class="encapsulated">[Look](/pages/look)</span> <span class="encapsulated active-tab">[Reporting](/pages/report)</span>\r\n=============\r\n \r\nReporting Your Find\r\n=============\r\n \r\nGathering information in the Field\r\n-------------------------\r\n \r\n When you've spotted a potential invasive species in the field, document your find as accurately as possible so that the species can be positively identified and the location can be found again.\r\n \r\n * Try to identify the species. If you have a guide or watch list reference with you, review the species identification information. It is helpful if you are fairly confident you have found the correct species before you report it. If you are unsure of the identification, document as much information as you can. You can get identification assistance from an expert through the Online Hotline.\r\n * Take a digital photo. Photos are the most reliable method for experts to positively identify a species. Use the three shot method: a wide shot of species and surrounding habitat; a closeup of the species; a detail shot such as leaves or flowers. In the case of insects or animals, if you can't find a specimen to photograph, you many need to take photos of the habitat damage you've found.\r\n * Take notes. Write down a description of the specimen and the area and habitat where you found it. Estimate the number of individuals in the area and how widespread the infestation.\r\n * Note the location. If you have a gps or map, record the location of the site. The more accurate you can be, the easier it will be others to locate you find.\r\n*IMPORTANT - If the species you encountered is clearly on private property, be sure to get permission from the land owner before reporting. \r\n\r\nDocumentation Tools\r\n-------------------------\r\n \r\n Try to bring along the following tools whenever you plan to be out in natural areas. They are helpful for accurately documenting your finds.\r\n \r\n * Digital camera\r\n * A map of the area (USGS Quad maps are ideal) or GPS unit (if possible)\r\n * A notebook and pen for taking notes\r\n * An invasive species guide or watch list for the area (something with photos and descriptions is ideal)\r\n \r\nReport your find to the Online Hotline\r\n-------------------------\r\n \r\n When you return from the field, use the Online Hotline's reporting form to submit your find. You can use the Online Hotline to report a known invader or ask for identification help if you are unsure. Each submission will be reviewed by an expert from the Oregon Invasive Species Council who will review your submission and confirm the identification. You'll receive an email response from the expert with a confirmation and suggestions for what to do next.\r\n \r\n Once confirmed, your submission will go into the public database of submissions to help experts and the public with early detection and tracking of invasive outbreaks in Oregon.\r\n \r\n <span class="encapsulated">[Online Hotline Home >>](/)</span>	f		f
28	/pages/learn/	Learn	Tips for Finding and Reporting Invasive Species: <span class="encapsulated">[Early Detection](/pages/detect)</span> <span class="encapsulated active-tab">[Learn](/pages/learn)</span> <span class="encapsulated">[Look](/pages/look)</span> <span class="encapsulated">[Reporting](/pages/report)</span>\r\n==============\r\n \r\nLearn About the Invaders\r\n==============\r\n \r\nThe first step in early detection is knowing what to look for. Learning about potential invaders in your area will make it easier to spot and identify them when you are outdoors. Start with the natural environments that you know the best: your garden, nearby parks or forests, a favorite fishing hole or hiking trail. Familiarize yourself with the "watch list" of invasive species that are threatening to invade these areas and get to know the native plants and animals species that should be living there.\r\n \r\nOregon has many user-friendly resources to help you identify what's invasive, what's a threat, and and what's native to your area.\r\n \r\n * The Oregon Invasive Species Council maintains a list of the [100 most dangerous invaders](http://www.oregoninvasivespeciescouncil.org/100-worst-list).\r\n * The [Western Invasives Network](http://www.cascadepacific.org/western-invasives-network) maintains a list of invasive plants and noxious weeds that local land managers want you to report. You can click on a region to learn what invaders to look for.\r\n * The [Oregon Department of Agriculture](http://www.oregon.gov/ODA/programs/Weeds/OregonNoxiousWeeds/Pages/AboutOregonWeeds.aspx) regulates and maintains a list of noxious weeds of state-wide importance.\r\n \r\nYou can also use printed or downloadable guides to begin to learn more about invasive species. These resources are helpful to carry with you out in the field for help with identification.\r\n \r\n * **Western Invasive Plant EDRR Guide** Published by the ODA, the guide is a detailed resource for identifying invasive plants. It is available online and as printable PDF files from the [ODA Web site](http://www.oregon.gov/ODA/programs/Weeds/Pages/EDRR.aspx).\r\n * **On the Lookout for Aquatic Invaders** - Created by Sea Grant Oregon, this guide is a resource of information about aquatic species threatening Pacific Northwest waterways. Find out how to get your copy at the [SeaGrant Web site](http://seagrant.oregonstate.edu/sgpubs/H14001-on-the-lookout)\r\n * **GardenSmart Oregon** - A gardener's guide to non-invasive plants, it identifies 25 of the most threatening invasive plants across Oregon and recommends non-invasive alternative plants for gardeners and landscapers. Find out how to get your copy at the [Pacific Northwest Plant Council site](http://www.pnw-ipc.org/docs/gardensmartguide.pdf).\r\n \r\n<span class="encapsulated">[NEXT: Look for Invaders >>](/pages/look)</span>\r\n	f		f
\.


--
-- Name: django_flatpage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('django_flatpage_id_seq', 28, true);


--
-- Data for Name: django_flatpage_sites; Type: TABLE DATA; Schema: public; Owner: root
--

COPY django_flatpage_sites (id, flatpage_id, site_id) FROM stdin;
63	26	1
64	27	1
65	28	1
48	25	1
\.


--
-- Name: django_flatpage_sites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('django_flatpage_sites_id_seq', 65, true);


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: root
--

COPY django_migrations (id, app, name, applied) FROM stdin;
1	users	0001_initial	2015-08-03 11:32:10.156248-07
2	contenttypes	0001_initial	2015-08-03 11:32:10.183142-07
3	admin	0001_initial	2015-08-03 11:32:10.23538-07
4	species	0001_initial	2015-08-03 11:32:10.389379-07
5	reports	0001_initial	2015-08-03 11:32:10.634253-07
6	comments	0001_initial	2015-08-03 11:32:10.798128-07
7	contenttypes	0002_remove_content_type_name	2015-08-03 11:32:10.959756-07
8	images	0001_initial	2015-08-03 11:32:11.036898-07
9	images	0002_auto_20150727_1511	2015-08-03 11:32:11.140633-07
10	regions	0001_initial	2015-08-03 11:32:11.161693-07
11	sessions	0001_initial	2015-08-03 11:32:11.198314-07
12	species	0002_auto_20150707_1614	2015-08-03 11:32:11.25031-07
13	species	0003_auto_20150727_1511	2015-08-03 11:32:11.307986-07
14	species	0004_auto_20150728_0903	2015-08-03 11:32:11.364678-07
15	species	0005_auto_20150730_1319	2015-08-03 11:32:11.414499-07
16	users	0002_auto_20150730_1458	2015-08-03 11:32:11.496012-07
17	sites	0001_initial	2015-08-03 13:33:02.009407-07
18	flatpages	0001_initial	2015-08-03 13:33:02.060096-07
\.


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('django_migrations_id_seq', 18, true);


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: root
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
ai0jjirk5hrsodey2b3ik1d8dc9th20e	ZjUzZjc5MWUzZjg5MjE3YzkzNmIxY2Q3ZjYyYWQwOTVhOWJlNjUxYjp7Il9hdXRoX3VzZXJfaGFzaCI6IjY2ZmIyNTBkMTgwMTJlMzAwMDY1MDM1ODQ2NWJjOWY5ZGU0ZjhhZWQiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=	2015-08-17 12:53:17.138666-07
n9ndqjfv0hibinaes1rnnfb2pd09ukzp	YjEwNWQxMWZlNTlhOWU3NzM1YWY2MjE1ODk4NjY2ZGVjYjI3ZjNmOTp7Il9hdXRoX3VzZXJfaGFzaCI6IjY2ZmIyNTBkMTgwMTJlMzAwMDY1MDM1ODQ2NWJjOWY5ZGU0ZjhhZWQiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=	2015-08-18 15:17:22.245504-07
tjefe6f5hqbn33mbj65mbmql5esrp5pb	YjEwNWQxMWZlNTlhOWU3NzM1YWY2MjE1ODk4NjY2ZGVjYjI3ZjNmOTp7Il9hdXRoX3VzZXJfaGFzaCI6IjY2ZmIyNTBkMTgwMTJlMzAwMDY1MDM1ODQ2NWJjOWY5ZGU0ZjhhZWQiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=	2015-08-18 15:20:15.448253-07
48i5shkuxjdcgli44ehd5idgxpi8bo8w	YjEwNWQxMWZlNTlhOWU3NzM1YWY2MjE1ODk4NjY2ZGVjYjI3ZjNmOTp7Il9hdXRoX3VzZXJfaGFzaCI6IjY2ZmIyNTBkMTgwMTJlMzAwMDY1MDM1ODQ2NWJjOWY5ZGU0ZjhhZWQiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=	2015-08-21 14:26:57.512029-07
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: root
--

COPY django_site (id, domain, name) FROM stdin;
1	example.com	example.com
\.


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('django_site_id_seq', 1, true);


--
-- Data for Name: image; Type: TABLE DATA; Schema: public; Owner: root
--

COPY image (image_id, image, name, created_on, visibility, comment_id, created_by_id, report_id, species_id) FROM stdin;
\.


--
-- Name: image_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('image_image_id_seq', 1, false);


--
-- Data for Name: invite; Type: TABLE DATA; Schema: public; Owner: root
--

COPY invite (invite_id, created_on, created_by_id, report_id, user_id) FROM stdin;
\.


--
-- Name: invite_invite_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('invite_invite_id_seq', 1, false);


--
-- Data for Name: region; Type: TABLE DATA; Schema: public; Owner: root
--

COPY region (region_id, name, center) FROM stdin;
\.


--
-- Name: region_region_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('region_region_id_seq', 1, false);


--
-- Data for Name: report; Type: TABLE DATA; Schema: public; Owner: root
--

COPY report (report_id, description, location, has_specimen, point, created_on, edrr_status, is_archived, is_public, actual_species_id, claimed_by_id, created_by_id, reported_category_id, reported_species_id) FROM stdin;
\.


--
-- Name: report_report_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('report_report_id_seq', 1, false);


--
-- Data for Name: severity; Type: TABLE DATA; Schema: public; Owner: root
--

COPY severity (severity_id, name, color) FROM stdin;
1	native	
2	non-native	
3	invasive	
\.


--
-- Name: severity_severity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('severity_severity_id_seq', 3, true);


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: root
--

COPY spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Data for Name: species; Type: TABLE DATA; Schema: public; Owner: root
--

COPY species (species_id, name, scientific_name, remedy, resources, is_confidential, category_id, severity_id) FROM stdin;
1	Alder root rot	Phytophthora alni			f	1	3
2	Cherry leaf roll	cherry leaf roll nepovius - CLRV			f	1	3
3	Chronic wasting disease	CWD prion			f	1	3
4	Elm yellows	elm yellows phytoplasma			f	1	3
5	Hazelnut bacteria canker	Pseudomonas avellanae			f	1	3
6	Infectious salmon anemia virus	ISAV			f	1	3
7	Oak wilt	Ceratocystis fabacearum			f	1	3
8	Pear trellis rust	Gymnosporangium fuscum			f	1	3
10	Plum pox	plum pox potyvirus - PPV			f	1	3
11	Poplar canker	Xanthomonas populi			f	1	3
12	Potato cyst nematodes	Globodera pallida, Globodera rostochiensis			f	1	3
13	Potato wart	Synchytrium endobioticum			f	1	3
14	Sudden oak death, ramorum canker and blight	Phytophora ramorum			f	1	3
17	Whirling disease	Myxobolus cerebralis			f	1	3
18	Willow watermark disease	Erwinia salicis			f	1	3
22	Waterweed, African	Lagarosiphon major			f	2	3
23	Seaweed, caulerpa	Caulerpa taxifolia			f	2	3
24	Spartina/Cordgrass	Spartina alterniflora, Spartina densiflora, Spartina aglica, Spartina patens**			f	2	3
25	Dead man’s fingers	Codium fragile tomentosoides			f	2	3
26	Water chestnut, European	Trapa natans			f	2	3
27	Salvinia, giant	Salvinia molesta			f	2	3
28	Hydrilla	Hydrilla verticilata			f	2	3
29	Rock snot	Didymosphenia geminata			f	2	3
30	Toxic cyanobacteria	Cylindrospermopsis raciborskii			f	2	3
31	Yellow floating heart	Nymphoides peltata			f	2	3
33	Duckweed, Giant	Landoltia punctata			f	2	3
34	Pondweed, Curly-leaved	Potamogeton crispus			f	2	3
36	African Rue	Peganum harmala	* "Pest Risk Management of _Peganum harmala_ (African rue) in Canada":https://www.richters.com/Issues/invasive/Peganum_harmala_pest_risk_management_document.pdf		f	3	3
37	Camelthorn 	Alhagi pseudalhagi	* "Camelthorn info from California Invasive Plant Council":http://www.cal-ipc.org/ip/management/ipcw/pages/detailreport.cfm@usernumber=4&surveynumber=182.php		f	3	3
39	Coltsfoot	Tussilago farfara			f	3	3
40	Hogweed, Giant	Heracleum mantegazzianum	* "Manage Giant Hogweed":http://www.oregon.gov/ODA/PLANT/WEEDS/profile_gianthogweed.shtml	Want to join forces with your community to fight invasives? There are lots of people involved in this effort already! The links below can connect you with opportunities:\\r                                                                                                                          +\n * "Association of Soil and Water Conservation Districts":http://www.oacd.org/districts.html (Click on your county) \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n * "OPB Silent Invasion":http://www.opb.org/programs/invasives/ (scroll down to events)\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 +\n * "SOLV":http://www.solv.org/programs/invasives.asp\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n * "Invasives Watch Volunteers":http://www.westerninvasivesnetwork.org/pages/nature_conserv.html\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        +\n * "The Nature Conservancy in Oregon":http://www.nature.org/wherewework/northamerica/states/oregon/about/art24312.html	f	3	3
41	Goatgrass, Barbed	Aegilops triuncialis			f	3	3
43	Reed grass, giant	Arundo donax			f	3	3
44	Kudzu	Pueraria lobata			f	3	3
45	Matgrass	Nardus stricta			f	3	3
46	Mile-a-minute weed	Polygonum perfoliatum			f	3	3
47	Broom, Portuguese	Cytisus striatus	* "Portuguese Broom (_Cytisus striatus_) at the California Invasive Plant Council":http://www.cal-ipc.org/ip/management/plant_profiles/Cytisus_striatus.php		f	3	3
48	Nutsedge, purple	Cyperus rotundus			f	3	3
49	Nightshade, silverleaf	Solanum elaegnifolium			f	3	3
50	Bursage, Skeletonleaf	Ambrosia tomentosa	* "Skeletonleaf Bursage (_Ambrosia tomentosa_) info from Pacific Northwest Weed Management Handbook":http://pnwhandbooks.org/weed/other-items/control-problem-weeds/bursage-skeletonleaf-ambrosia-tomentosa		f	3	3
51	Knapweed, squarrose	Centaurea virgata			f	3	3
52	Starthistle, Iberian	Centaurea iberica			f	3	3
62	Patersons curse	Echium plantagineum			f	3	3
65	Acacia, False	Robinia pseudoacacia	* "PCA's Alien Plant Working Group - Black Locust":http://www.nps.gov/plants/ALIEN/fact/rops1.htm		f	3	3
66	Bearded Creeper	Crupina vulgaris	* "Management of Bearded Creeper (_Crupina vulgaris_) in King County, WA":http://www.kingcounty.gov/environment/animalsAndPlants/noxious-weeds/laws/list.aspx		f	3	3
67	Biddy-Biddy	Acaena novae-zelandieae	* "California Department of Food and Agriculture Weed Information - Biddy-Biddy (_Acaena novae-zelandia_)":http://www.cdfa.ca.gov/plant/ipc/weedinfo/acaena.htm#anchor616800		f	3	3
69	Blackberry, Himalayan	Rubus bifrons, [R. aremeniacus, R. discolor, R. procerus]	* "Himalayan and Evergreen Blackberries info from King County, WA":http://www.kingcounty.gov/environment/animalsAndPlants/noxious-weeds/weed-identification/blackberry.aspx	Want to join forces with your community to fight invasives? There are lots of people involved in this effort already! The links below can connect you with opportunities:\\r+\n * "Association of Soil and Water Conservation Districts Directory":http://oacd.org/conservation-districts/directory\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n * "SOLV":http://www.solv.org/\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          +\n * "The Nature Conservancy in Oregon":http://www.nature.org/ourinitiatives/regions/northamerica/unitedstates/oregon/index.htm\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                           +\n 	f	3	3
70	Brome, Cheatgrass	Bromus tectorum	* "More Information from the Rocky Mountain Cheatgrass Management Handbook":http://www.wyomingextension.org/agpubs/pubs/B1246.pdf		f	3	3
71	Brome, False	Brachypodium sylvaticum	* "More Information from the King County, WA Noxious Weeds Inventory":http://www.kingcounty.gov/environment/animalsAndPlants/noxious-weeds/weed-identification/false-brome.aspx	Want to join forces with your community to fight invasives? There are lots of people involved in this effort already! The links below can connect you with opportunities: \\r                                      +\n * "Association of Soil and Water Conservation Districts":http://www.oacd.org/districts.html (Click on your county) \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n * "OPB Silent Invasion":http://www.opb.org/programs/invasives/ (scroll down to events)\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 +\n * "SOLV":http://www.solv.org/programs/invasives.asp\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n * "Invasives Watch Volunteers":http://www.westerninvasivesnetwork.org/pages/nature_conserv.html\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        +\n * "The Nature Conservancy in Oregon":http://www.nature.org/wherewework/northamerica/states/oregon/about/art24312.html\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  +\n 	f	3	3
72	Brome, Foxtail	Bromus rubens	* "Management Information from the Global Invasive Species Database":http://www.issg.org/database/species/management_info.asp?si=596&fr=1&sts=&lang=EN		f	3	3
73	Broom, French	Genista monspessulana	* "French Broom (_Genista monspessulana_) Management Considerations from the USDA Forest Service":http://www.fs.fed.us/database/feis/plants/shrub/genmon/all.html		f	3	3
265	Tree of Heaven	Ailanthus altissima			f	3	3
266	Starthistle, Purple	Centaurea calcitrapa			f	3	3
74	Broom, Scotch	Cytisus scoparius	"Information on broom control from King County, WA":http://your.kingcounty.gov/dnrp/library/water-and-land/weeds/BMPs/Scotch-Broom-Control.pdf	Want to join forces with your community to fight invasives? There are lots of people involved in this effort already! The links below can connect you with opportunities:\\r                                                                             +\n * "Association of Soil and Water Conservation Districts Directory":http://oacd.org/conservation-districts/directory\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n * "SOLV":http://www.solv.org/\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          +\n * "The Nature Conservancy in Oregon":http://www.nature.org/ourinitiatives/regions/northamerica/unitedstates/oregon/index.htm	f	3	3
75	Broom, Spanish	Spartium junceum	* "Spanish Broom (_Spartium junceum_) info from King County, WA":http://www.kingcounty.gov/environment/animalsAndPlants/noxious-weeds/weed-identification/spanish-broom.aspx		f	3	3
76	Broomrape, Small	Orobanche minor	* "More Information from the King County, WA Noxious Weed List":http://www.invasive.org/weedcd/species/2450.htm		f	3	3
77	Buffalobur	Solanum rostratum	* "Buffalobur (_Solanum rostratum_) info from King County, WA":http://www.kingcounty.gov/environment/animalsAndPlants/noxious-weeds/weed-identification/buffalobur.aspx		f	3	3
78	Celandine, Lesser	Ranunculus ficaria	* "Lesser Celandine":http://www.wewetlands.org/files/186_Lesser%20Celandine.pdf	Want to join forces with your community to fight invasives? There are lots of people involved in this effort already! The links below can connect you with opportunities:\\r                                                                                                                                       +\n * "Association of Soil and Water Conservation Districts Directory":http://oacd.org/conservation-districts/directory\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n * "SOLV":http://www.solv.org/\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          +\n * "The Nature Conservancy in Oregon":http://www.nature.org/ourinitiatives/regions/northamerica/unitedstates/oregon/index.htm	f	3	3
79	Cocklebur, Spiny	Xanthium spinosum	* "Spiny Cocklebur information from the Weed Report in _Weed Control in Natural Areas in the United States_ at UC Davis":http://wric.ucdavis.edu/information/natural%20areas/wr_X/Xanthium_spinosum-strumarium.pdf		f	3	3
82	Cutleaf Teasel	Dipsacus laciniatus	* "Manage Cutleaf Teasel":http://www.weedmapper.org/dila4.html	Want to join forces with your community to fight invasives? There are lots of people involved in this effort already! The links below can connect you with opportunities:\\r                                                                                                                                                          +\n * "Association of Soil and Water Conservation Districts":http://www.oacd.org/districts.html (Click on your county) \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n * "OPB Silent Invasion":http://www.opb.org/programs/invasives/ (scroll down to events)\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 +\n * "SOLV":http://www.solv.org/programs/invasives.asp\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n * "Invasives Watch Volunteers":http://www.westerninvasivesnetwork.org/pages/nature_conserv.html\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        +\n * "The Nature Conservancy in Oregon":http://www.nature.org/wherewework/northamerica/states/oregon/about/art24312.html\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  +\n 	f	3	3
93	Hawkweed, Mouse-Ear	Hieracium pilosella			f	3	3
95	Hawkweed, Yellow	Hieracium floribundum			f	3	3
100	Ivy, English	Hedera helix	Thanks for your report!  Unfortunately ivy is too widespread and resources are too thin for land managers to assist with control. Controlling this species is of high importance, and we encourage you to take the steps to control this plant on your property.  Below is some information to help you with this.  Don't despair, you can do it!\\r                                                                   +\n \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       +\n Tackling an infestation of ivy is no easy task, but well worth the investment.  If you notice a small infestation, do not delay in removing it.  The longer one waits to treat ivy, the effort it takes to remedy the situation increases exponentially.   If you have a large infestation that seems overwhelming try breaking the project into smaller more manageable areas, and tackle new areas as time allows.  If you set smaller goals you might be less likely to be discouraged.\\r                                                                                                             +\n \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       +\n Follow these simple steps for an ivy free landscape.  \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 +\n •       Carefully cut vines climbing trees and pull these vines away from the base of the tree. \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       +\n •       Pull vines and roots from ivy creeping along the ground.  Don’t forget your gloves and scissors.  \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             +\n •       Dispose of cut vines in yard waste, or dry out completely and compost\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          +\n •       Re-visit the site regularly to control re-growth\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               +\n \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       +\n For more detailed information on English ivy and its control follow the link below:\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       +\n http://your.kingcounty.gov/dnrp/library/water-and-land/weeds/BMPs/english-ivy-control.pdf\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              +\n \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       +\n \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       +\n   	Want to join forces with your community to fight invasives? There are lots of people involved in this effort already! The links below can connect you with opportunities:\\r                                                                                                                                                                                                                                                                                                                                                                                                                 +\n \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       +\n Association of Soil and Water Conservation Districts (Click on your county) \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           +\n http://www.oacd.org/districts.html\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     +\n \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       +\n OPB Silent Invasion (scroll down to events)\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            +\n http://www.opb.org/programs/invasives/\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 +\n \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       +\n SOLV  \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 +\n http://www.solv.org/programs/invasives.asp\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             +\n \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       +\n Invasives Watch Volunteers\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             +\n http://www.westerninvasivesnetwork.org/pages/nature_conserv.html\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       +\n \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       +\n The Nature Conservancy in Oregon\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       +\n http://www.nature.org/wherewework/northamerica/states/oregon/about/art24312.html\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       +\n 	f	3	3
102	Knapweed, Meadow	Centaurea pratensis	* "Manage Meadow Knapweed":http://cru.cahe.wsu.edu/CEPublications/pnw0566/PNW0566.pdf	Want to join forces with your community to fight invasives? There are lots of people involved in this effort already! The links below can connect you with opportunities:\\r                                                                                                                                +\n * "Association of Soil and Water Conservation Districts":http://www.oacd.org/districts.html (Click on your county) \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n * "OPB Silent Invasion":http://www.opb.org/programs/invasives/ (scroll down to events)\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 +\n * "SOLV":http://www.solv.org/programs/invasives.asp\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n * "Invasives Watch Volunteers":http://www.westerninvasivesnetwork.org/pages/nature_conserv.html\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        +\n * "The Nature Conservancy in Oregon":http://www.nature.org/wherewework/northamerica/states/oregon/about/art24312.html\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  +\n 	f	3	3
104	Knotweed, Giant	Polygonum sachalinense	* "Manage Giant Knotweed":http://extension.oregonstate.edu/catalog/pdf/ec/ec1597-e.pdf	Want to join forces with your community to fight invasives? There are lots of people involved in this effort already! The links below can connect you with opportunities:\\r                                                                                                                             +\n * "Association of Soil and Water Conservation Districts":http://www.oacd.org/districts.html (Click on your county) \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n * "OPB Silent Invasion":http://www.opb.org/programs/invasives/ (scroll down to events)\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 +\n * "SOLV":http://www.solv.org/programs/invasives.asp\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n * "Invasives Watch Volunteers":http://www.westerninvasivesnetwork.org/pages/nature_conserv.html\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        +\n * "The Nature Conservancy in Oregon":http://www.nature.org/wherewework/northamerica/states/oregon/about/art24312.html	f	3	3
108	Policeman's Helmet	Impatiens glandulifera			f	3	3
112	Ragwort, Tansy	Senecio jacobaea	Check out these Documents for recommended methods for controlling Tansy Ragwort\\r                                                                                                                                                                                                                                                                                                                               +\n \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       +\n http://your.kingcounty.gov/dnrp/library/water-and-land/weeds/BMPs/tansy_ragwort-control.pdf\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            +\n http://www.imapinvasives.org/GIST/ESA/esapages/documnts/senejac.pdf\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n http://extension.oregonstate.edu/catalog/pdf/ec/ec1599-e.pdf\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           +\n http://www.co.thurston.wa.us/tcweeds/weeds/fact-sheets/Tansy.pdf\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       +\n \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       +\n 	Check out these resource for additional information\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         +\n \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       +\n http://www.kingcounty.gov/environment/animalsandplants/noxious-weeds/weed-identification/tansy-ragwort.aspx\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            +\n http://www.nwcb.wa.gov/weed_info/Written_findings/Senecio_jacobaea.html\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                +\n http://www.invasive.org/weedcd/pdfs/wow/tansy-ragwort.pdf\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              +\n http://www.oregon.gov/ODA/PLANT/WEEDS/profile_tansyragwort.shtml\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       +\n \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       +\n 	f	3	3
113	Rose, Japanese	Rosa rugosa			f	3	3
114	Rye, Medusahead	Taeniatherum caput-medusae			f	3	3
127	Toadflax, Dalmation	Linaria dalmatica			f	3	3
128	Toadflax, Yellow	Linaria vulgaris			f	3	3
134	Waterflea, fishhook	Cercopagis pengoi			f	4	3
135	Crab, Japanese shore	Hemigrapsus sanguineus			f	4	3
136	Comb Jelly, Leidy&rsquo;s	Mnemiopsis leidyi			f	4	3
137	Crab, Unknown Mitten	Eriocheir spp.*			f	4	3
138	Isopod, New Zealand	Sphaeroma quoyanum			f	4	3
139	Crayfish, Rusty	Orconectes rusticus			f	4	3
140	Sea Squirt	Didemnum lahillei			f	4	3
141	Mussel, Zebra and Quagga	Dreissena polymorpha, Dreissena bugensis			f	4	3
145	Mudsnail, New Zealand	Potamopyrgus antipodarum			f	4	3
148	Clam, Varnish 	Nuttalia obscurata			f	4	3
149	Crab, Harris Mud	Phithropanopeus harrisii			f	4	3
150	Crab, Pea	Tritodynamia horvathi			f	4	3
151	Oyster, Kumamoto	Crassostrea sikamea			f	4	3
152	Mussel, New Zealand green	Perna canaliculus			f	4	3
153	Crab, Atlantic Blue	Callinectes sapidus			f	4	3
155	Clam, Manilla Littleneck	Venerupis phillipinarum			f	4	3
156	Oyster, American	Crassostrea virginica			f	4	3
157	Oyster, Flat	Ostrea edulis			f	4	3
162	Bullfrog, American	Rana catesbeiana			f	5	3
188	Turtle, Red-Eared Slider	Trachemys scripta elegans			f	5	3
189	Trout, Brook 	Salvelinus fontinalis			f	5	3
190	Bee, Africanized honey 	Apis mellifera scutellata			f	6	3
191	Ant, Argentine 	Linepithema humile			f	6	3
192	Beetle, Asian longhorned	Anoplophora glabripennis, A.chinensis			f	6	3
193	Beetle, brown spruce longhorn	Tetropium fuscum, T. castaneum			f	6	3
194	Ash Borer, emerald	Agrilus planipennis			f	6	3
195	Chafer, European	Rhizotrogus majalis			f	6	3
196	Corn borer, European	Ostrinia nubilalis			f	6	3
197	Woodwasp, European 	Sirex noctilio			f	6	3
198	Beetle, granulate ambrosia	Xylosandrus crassiusculus			f	6	3
199	Gypsy Moth, European	Lymantria dispar			f	6	3
200	Fire ant, imported red	Solenopsis invicta			f	6	3
201	Beetle, Japanese	Popillia japonica			f	6	3
202	Wax scale, Japanese	Ceroplastes japonicus			f	6	3
203	Beetle, khapra	Trogoderma granarium			f	6	3
204	Moth, light brown apple 	Epiphyas postvittana			f	6	3
205	Beetle, Mexican bean	Epilachna varivestis			f	6	3
206	Bollworm, old world	Helicoverpa armigera			f	6	3
207	Beetle, Oriental	Anomala orientlis			f	6	3
208	Curculio, plum	Conotrachelus nenuphar			f	6	3
209	Beetle, pine shoot	Tomicus piniperda			f	6	3
210	Sawyers	Monochamus urussovi, M. alternatus			f	6	3
211	Moth, Siberian 	Dendrolimus superans			f	6	3
212	Moth, silver Y	Autographa gamma			f	6	3
213	Beetle, spruce bark	Ips typographus			f	6	3
214	Midge, Swede	Contarinia nasturtii			f	6	3
215	Snail, White garden	Thesbe pisa			f	6	3
219	Sharpshooter, Glassywinged	Homalodisca coagulata			f	6	3
230	Goby, Amur	Rhinogobius brunneus			f	7	3
232	Salmon, Atlantic	Salmo salar			f	7	3
233	Carp, Black	Mylopharyngodon piceus			f	7	3
235	Goby, Round	Neogobius melanostomas			f	7	3
236	Ruffe	Gymnocephalus cernuus			f	7	3
237	Goby, Shimofuri	Tridentiger bifasciatus			f	7	3
238	Snakeheads	Channa spp.			f	7	3
239	Swan, Mute	Cygnus olor			f	8	3
244	Geese, Egyptian 	Alopochen aegyptiacus			f	8	3
245	Pig/Swine, Feral	Sus scrofa			f	9	3
251	Horses, Feral/Wild	Equus caballus			f	9	3
252	Sheep, Feral - Mouflon, Aoudad	Ovis musimon, Ammotragus lervia			f	9	3
253	Burros, Feral	Equus asinus			f	9	3
254	Goats, Feral	Capra hircus			f	9	3
255	Bison, Feral	Bison Bison			f	9	3
257	Slug, European Red	Arion rufus			f	10	3
258	Snail, Wrinkled Dune	Candidula intersecta			f	10	3
259	Snail, Vineyard	Cernuella virgata			f	10	3
260	Snail, Brown-lipped	Cepaea nemoralis			f	10	3
261	Snails, Giant African	Achatina fulica, A. achatina, Archachatina marginata			f	10	3
262	Stink Bug, Brown Marmorated 	Halyomorpha halys			f	6	3
263	Moth, European Grape Berry	Eupoecilia ambiguella			f	6	3
264	Italian Arum	Arum italicum			f	3	3
267	Gypsy Moth, Asian	L. mathura			f	6	3
268	Fire ant, imported black	S. richteri			f	6	3
270	Nutria	Myocastor coypus			f	9	3
271	Knotweed, Japanese	Fallopia japonica	See this site for tips on how to control knotweed:\\r                                                                                                                                                                                                                                                                                                                                                       +\n * "Controlling Knotweed in the Pacific Northwest":http://www.skamaniacounty.org/Noxious_Weeds/TNCreport.htm	Want to join forces with your community to fight invasives? There are lots of people involved in this effort already! The links below can connect you with opportunities:\\r                                                                                                                                                                                                                                                                                                        +\n * "Association of Soil and Water Conservation Districts":http://www.oacd.org/districts.html (Click on your county) \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n * "OPB Silent Invasion":http://www.opb.org/programs/invasives/ (scroll down to events)\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 +\n * "SOLV":http://www.solv.org/programs/invasives.asp\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n * "Invasives Watch Volunteers":http://www.westerninvasivesnetwork.org/pages/nature_conserv.html\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        +\n * "The Nature Conservancy in Oregon":http://www.nature.org/wherewework/northamerica/states/oregon/about/art24312.html\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  +\n 	f	3	3
272	Bluebell, Spanish	Hyacinthoides hispanica			f	3	2
273	Gorse	Ulex europaeus	* "Manage Gorse":http://extension.oregonstate.edu/catalog/pdf/ec/ec1593-e.pdf	Want to join forces with your community to fight invasives? There are lots of people involved in this effort already! The links below can connect you with opportunities:\\r                                                                                                                                                        +\n * "Association of Soil and Water Conservation Districts":http://www.oacd.org/districts.html (Click on your county) \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n * "OPB Silent Invasion":http://www.opb.org/programs/invasives/ (scroll down to events)\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 +\n * "SOLV":http://www.solv.org/programs/invasives.asp\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n * "Invasives Watch Volunteers":http://www.westerninvasivesnetwork.org/pages/nature_conserv.html\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        +\n * "The Nature Conservancy in Oregon":http://www.nature.org/wherewework/northamerica/states/oregon/about/art24312.html	f	3	3
275	Garlic Mustard	Alliaria petiolata	* "Manage Garlic Mustard":http://extension.oregonstate.edu/catalog/pdf/ec/ec1592-e.pdf	Want to join forces with your community to fight invasives? There are lots of people involved in this effort already! The links below can connect you with opportunities:\\r                                                                                                                                  +\n * "Association of Soil and Water Conservation Districts":http://www.oacd.org/districts.html (Click on your county) \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n * "OPB Silent Invasion":http://www.opb.org/programs/invasives/ (scroll down to events)\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 +\n * "SOLV":http://www.solv.org/programs/invasives.asp\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n * "Invasives Watch Volunteers":http://www.westerninvasivesnetwork.org/pages/nature_conserv.html\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        +\n * "The Nature Conservancy in Oregon":http://www.nature.org/wherewework/northamerica/states/oregon/about/art24312.html\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  +\n 	f	3	3
276	Little bittercress	Cardamine oligosperma 			f	3	1
277	Spurge Laurel	Daphne laureola			f	3	3
278	Ornamental Euphorbia	Euphorbia sp.			f	3	2
279	Buttercup, Hornseed	Ranunculus testiculatus			f	3	2
280	Yellow Archangel	Lamiastrum galeobdolon			f	3	3
281	Western Wildcucumber	Marah oreganus			f	3	1
282	Bluebell, English	Hyacinthoides non-scripta			f	3	2
283	Crab, Mole	Emerita spp.			f	4	1
284	Yellow-Flag Iris	Iris pseudacorus		"Best Management Practices from King County":http://your.kingcounty.gov/dnrp/library/water-and-land/weeds/BMPs/yellow-flag-iris-control.pdf	f	2	3
288	Spurge, Japanese	Pachysandra terminalis			f	3	2
290	Shining Geranium	Geranium lucidum			f	3	3
291	Perennial peavine 	Lathyrus latifolius			f	3	3
292	Reed Canarygrass, Ribbon or Variegated 	Phalaris arundinacea var. picta			f	3	3
293	Oyster Plant, Salsify	Tragopogon porrifolius			f	3	2
294	Butterfly Bush	Buddleja davidii	* "Butterfly Bush":http://www.invasive.org/weedcd/pdfs/wow/butterfly_bush.pdf	Want to join forces with your community to fight invasives? There are lots of people involved in this effort already! The links below can connect you with opportunities:\\r                                                                                                                                             +\n * "Association of Soil and Water Conservation Districts Directory":http://oacd.org/conservation-districts/directory\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n * "SOLV":http://www.solv.org/\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          +\n * "The Nature Conservancy in Oregon":http://www.nature.org/ourinitiatives/regions/northamerica/unitedstates/oregon/index.htm\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                           +\n 	f	3	3
296	Sugar Glider	Petaurus breviceps			f	9	2
297	Old Man's Beard	Clematis vitalba			f	3	3
299	Loosestrife, Purple	Lythrum salicaria			f	3	3
309	Knapweed, Diffuse	Centaurea diffusa			f	3	3
310	Field Bindweed	Convolvulus arvensis			f	3	3
311	Oxeye Daisy	Leucanthemum vulgare			f	3	3
312	Knotweed	Fallopia sp.	See this site for tips on how to control knotweed:\\r                                                                                                                                                                                                                                                                                                                                                                      +\n * "Controlling Knotweed in the Pacific Northwest":http://www.skamaniacounty.org/Noxious_Weeds/TNCreport.htm\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            +\n 	Want to join forces with your community to fight invasives? There are lots of people involved in this effort already! The links below can connect you with opportunities:\\r                                                                                                                                                                                                                                                                                                                                                                                                                   +\n * "Association of Soil and Water Conservation Districts":http://www.oacd.org/districts.html (Click on your county) \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n * "OPB Silent Invasion":http://www.opb.org/programs/invasives/ (scroll down to events)\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 +\n * "SOLV":http://www.solv.org/programs/invasives.asp\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n * "Invasives Watch Volunteers":http://www.westerninvasivesnetwork.org/pages/nature_conserv.html\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        +\n * "The Nature Conservancy in Oregon":http://www.nature.org/wherewework/northamerica/states/oregon/about/art24312.html\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  +\n 	f	3	3
316	Herb Robert - Stinky Bob	Geranium robertianum	* "Manage Herb Robert":http://www.westerninvasivesnetwork.org/pdfs/factsheets/HerbRobert_PIP.pdf	Want to join forces with your community to fight invasives? There are lots of people involved in this effort already! The links below can connect you with opportunities:\\r                                                                                                            +\n * "Association of Soil and Water Conservation Districts":http://www.oacd.org/districts.html (Click on your county) \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n * "OPB Silent Invasion":http://www.opb.org/programs/invasives/ (scroll down to events)\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 +\n * "SOLV":http://www.solv.org/programs/invasives.asp\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n * "Invasives Watch Volunteers":http://www.westerninvasivesnetwork.org/pages/nature_conserv.html\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        +\n * "The Nature Conservancy in Oregon":http://www.nature.org/wherewework/northamerica/states/oregon/about/art24312.html	f	3	3
317	Thistle, Russian	Salsola tragus			f	3	3
318	Knapweed, spotted	Centauria stoebe			f	3	3
323	South American waterweed, Brazilian elodea	Egeria densa			f	2	3
325	Parrot feather watermilfoil	Myriophyllum aquaticum			f	2	3
328	Wild Turkey	Meleagris gallopavo			f	8	2
329	Salamander, Northwest	Ambystoma gracile			f	5	1
330	Holly, English	Ilex aquifolium	"English Holly control options":http://www.co.whatcom.wa.us/publicworks/weeds/pdf/HollyControlRec.pdf		f	3	3
332	Cow Parsnip	Heracleum maximum			f	3	1
334	Frog, Pacific Tree	Pseudacris regilla			f	5	1
335	Feverfew	Tanacetum parthenium			f	3	2
336	Japanese Eelgrass	Zostera japonica		Want to join forces with your community to fight invasives? There are lots of people involved in this effort already! The links below can connect you with opportunities:\\r                                                                                                                                                                                                                       +\n * "Association of Soil and Water Conservation Districts":http://www.oacd.org/districts.html (Click on your county) \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n * "OPB Silent Invasion":http://www.opb.org/programs/invasives/ (scroll down to events)\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 +\n * "SOLV":http://www.solv.org/programs/invasives.asp\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n * "Invasives Watch Volunteers":http://www.westerninvasivesnetwork.org/pages/nature_conserv.html\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        +\n * "The Nature Conservancy in Oregon":http://www.nature.org/wherewework/northamerica/states/oregon/about/art24312.html\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  +\n 	f	2	3
337	Crab, Chinese Mitten 	Eriocheir sinensis		Want to join forces with your community to fight invasives? There are lots of people involved in this effort already! The links below can connect you with opportunities:\\r                                                                                                                                                                                                                 +\n * "Association of Soil and Water Conservation Districts":http://www.oacd.org/districts.html (Click on your county) \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n * "OPB Silent Invasion":http://www.opb.org/programs/invasives/ (scroll down to events)\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 +\n * "SOLV":http://www.solv.org/programs/invasives.asp\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n * "Invasives Watch Volunteers":http://www.westerninvasivesnetwork.org/pages/nature_conserv.html\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        +\n * "The Nature Conservancy in Oregon":http://www.nature.org/wherewework/northamerica/states/oregon/about/art24312.html\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  +\n 	f	4	3
338	Colonial Tunicates	Didemnum sp.		Want to join forces with your community to fight invasives? There are lots of people involved in this effort already! The links below can connect you with opportunities:\\r                                                                                                                                                                                                                          +\n * "Association of Soil and Water Conservation Districts":http://www.oacd.org/districts.html (Click on your county) \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n * "OPB Silent Invasion":http://www.opb.org/programs/invasives/ (scroll down to events)\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 +\n * "SOLV":http://www.solv.org/programs/invasives.asp\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n * "Invasives Watch Volunteers":http://www.westerninvasivesnetwork.org/pages/nature_conserv.html\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        +\n * "The Nature Conservancy in Oregon":http://www.nature.org/wherewework/northamerica/states/oregon/about/art24312.html\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  +\n 	f	2	3
339	Asian Kelp	Undaria pinnatifida		Want to join forces with your community to fight invasives? There are lots of people involved in this effort already! The links below can connect you with opportunities:\\r                                                                                                                                                                                                                           +\n * "Association of Soil and Water Conservation Districts":http://www.oacd.org/districts.html (Click on your county) \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n * "OPB Silent Invasion":http://www.opb.org/programs/invasives/ (scroll down to events)\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 +\n * "SOLV":http://www.solv.org/programs/invasives.asp\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n * "Invasives Watch Volunteers":http://www.westerninvasivesnetwork.org/pages/nature_conserv.html\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        +\n * "The Nature Conservancy in Oregon":http://www.nature.org/wherewework/northamerica/states/oregon/about/art24312.html\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  +\n 	f	2	3
341	Nipplewort	Lapsana communis			f	3	3
342	Bird's-Foot Trefoil	Lotus corniculatus			f	3	2
343	Water Primrose	Ludwigia spp.		"ODA Plant Division Profile of Ludwigia":http://www.oregon.gov/ODA/PLANT/WEEDS/pages/weed_waterprimrose.aspx	f	2	3
349	Black Locust	Robinia pseudoacacia			f	3	2
350	Pokeweed, American	Phytolacca americana		*Information on "pokeweed":http://www.emswcd.org/weeds/weeds-toknow/131-pokeweed-phytolacca-americana from East Multnomah Soil and Water Conservation District	f	3	3
352	Nightshade, Bittersweet 	Solanum dulcamara			f	3	3
353	Sulphur cinquefoil 	Potentilla recta			f	3	3
355	Newt, Rough-Skinned	Taricha granulosa			f	5	1
356	Salamander, Pacific Giant	Dicamptodon ensatus			f	5	1
360	Low Oregon Grape	Mahonia nervosa			f	3	1
361	Watermilfoil, Eurasian	Myriophyllum spicatum			f	2	3
363	Snow on the Mountain	Aegopodium podagraria variegata			f	3	2
366	Dove, Eurasian Collared	Streptopelia decaocto			f	8	2
367	Perennial Pepperweed	Lepidium latifolium			f	3	3
368	Japanese Butterbur	Petasites japonicus			f	3	3
372	Elk clover	Aralia californica			f	3	1
373	Snail, European Ear 	Radix auricularia		"USGS Fact Sheet":http://nas.er.usgs.gov/queries/factsheet.aspx?SpeciesID=1012	f	4	2
374	Grape	Vitus sp.			f	3	2
375	Common Reed	Phragmites australis ssp. australis		ODA's Noxious Weed Profile: (http://www.oregon.gov/ODA/PLANT/WEEDS/profile_commonreed.shtml)\\r                                                                                                                                                                                                                                                                                       +\n ODA's Phragmites Identification Page (http://www.oregon.gov/ODA/PLANT/WEEDS/phragmitesidentification.shtml)	f	3	3
377	Bouncingbet, Soapwort	Saponaria officinalis	* "More Information from the Colorado Weed Management Association":http://www.cwma.org/bouncingbet.html		f	3	3
379	Flowering Rush	Butomus umbellatus			f	2	3
380	Peacock	Pavo cristatus			f	8	2
381	Fringe cup	Tellima grandiflora			f	3	1
382	Golden shiner	Notemigonus crysoleucas			f	7	2
383	Starthistle, Maltese 	Centaurea melitensis			f	3	3
385	Orange Jewelweed	Impatiens capensis			f	3	3
387	Water Hyacinth	Eichhornia crassipes			f	2	2
388	Hawthorn, Common or Single-seed	Crataegus monogyna			f	3	3
391	Cyclamen	Cyclamen hederifolium			f	3	2
392	Aralia	Aralia californica			f	3	1
393	Barnacles, Gooseneck	Lepas anatifera			f	4	1
394	Wild Cucumber 	Echinocystis lobata			f	3	1
395	Pacific waterleaf	Hydrophyllum tenuipes			f	3	1
396	Goutweed	Aegopodium podagraria			f	3	2
397	Reed Canarygrass	Phalaris arundinacea			f	3	3
398	Watermilfoil, Parrot feather	Myriophyllum aquaticum			f	2	3
399	Field Sandbur	Cenchrus spinefex			f	3	2
400	Vetch, Common	Vicia sativa			f	3	2
405	Crab, Kelp	Pugettia spp.			f	4	1
406	Periwinkle	Vinca major			f	3	2
408	Star-of-Bethlehem	Ornithogalum umbellatum			f	3	3
409	Spurge, Myrtle	Euphorbia myrsinites	Myrtle Spurge is a escaped garden ornamental that does well in typically dry and disturbed areas. Like most members of the spurge family, the white milky sap can cause severe dermatitis if improperly handled. If you are working on this plant, you should be sure to wear long sleeves, pants, and shoes, as well as rubber gloves and eye protection to prevent exposure to the sap.\\r                 +\n \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       +\n In terms of controlling and preventing the spread of Myrtle Spurge, manual removal can be quite effective. Plants can be dug up in the spring, when the ground is soft. You want to make sure to get as much of the root system as possible and follow up with removal on any regrowth. Myrtle spurge spreads primarily by seed, so you want to prevent seed production and control plants before or as soon as they bloom.\\r                                                                                                                                                                            +\n \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       +\n You can also treat Myrtle Spurge using herbicides, but I recommend this only for very large patches. For these large patches, research out of Colorado suggests that herbicide products containing 2,4-D and dicamba can be effective at controlling Myrtle Spurge. You should check with a local vendor for safe handling and availability. \\r                                                                                                                                                                                                                                                          +\n \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       +\n If after reviewing this documentation, you choose to use chemical control options I strongly recommend that you carefully review the labels for whatever herbicide product you decide to use. As with all herbicides, the Label is the Law. Follow label recommendations and restrictions at all times. The label is designed to reduce harm to you and your property. If any information provided contradicts the label, the label takes precedence. Always follow the label.	For more information about Myrtle Spurge you can check the following resources:\\r                               +\n \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       +\n http://www.oregon.gov/ODA/PLANT/WEEDS/pages/profile_myrtlespurge.aspx\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  +\n http://www.colorado.gov/cs/Satellite?blobcol=urldata&blobheader=application%2Fpdf&blobkey=id&blobtable=MungoBlobs&blobwhere=1231572928498&ssbinary=true\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                +\n http://www.weeds.slco.org/pdf/MyrtleSpurge.pdf\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         +\n http://www.cwma.org/myrtlespurge.html	f	3	3
412	Spotted jewelweed	Impatiens capensis			f	3	2
413	Bryozoan, Magnificent	Pectinatella magnifica			f	4	3
415	Crayfish, Ringed	Orconectes neglectus			f	4	3
416	Blackberry, Cut-leaf	Rubus laciniatus	* "Blackberry information from King County, WA":http://www.kingcounty.gov/environment/animalsAndPlants/noxious-weeds/weed-identification/blackberry.aspx	Want to join forces with your community to fight invasives? There are lots of people involved in this effort already! The links below can connect you with opportunities:\\r                                                            +\n * "Association of Soil and Water Conservation Districts Directory":http://oacd.org/conservation-districts/directory\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    +\n * "SOLV":http://www.solv.org/\\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          +\n * "The Nature Conservancy in Oregon":http://www.nature.org/ourinitiatives/regions/northamerica/unitedstates/oregon/index.htm	f	3	3
420	Floating Marsh-Pennywort	Hydrocotyle ranunculoides	This species is native to the Pacific Northwest, but some recently discovered populations have shown invasive characteristics. Research is ongoing, and locations from this site will be useful in determining the status of these populations.		f	2	3
423	Horse nettle	Solanum carolinense			f	3	3
424	Water Primrose, Six Petal	Ludwigia hexapetala			f	2	3
425	Water Primrose, Floating	Ludwigia peploides			f	2	3
426	Water Primrose, Floating (ssp. peploides)	Ludwigia peploides ssp. peploides			f	2	3
427	Water Primrose, Floating (ssp. montevidensis)	Ludwigia peploides ssp. montevidensis			f	2	3
428	Loosestrife, Garden	Lysimachia vulgaris	"Washington Noxious Weed Board information":http://www.nwcb.wa.gov/detail.asp?weed=89	"King County weed profile":http://www.kingcounty.gov/environment/animalsAndPlants/noxious-weeds/weed-identification/garden-loosestrife.aspx	f	3	3
429	Broom, Bridal Veil	Retama monosperma	* "Management Information from the California Invasive Plant Council":http://www.cal-ipc.org/ip/management/plant_profiles/Retama_monosperma.php		f	3	3
433	Ravenna grass	Saccharum ravennae		http://www.invasive.org/browse/subthumb.cfm?sub=57527\\r                                                                                                                                                                                                                                                                                                                                             +\n http://www.dcnr.state.pa.us/cs/groups/public/documents/document/dcnr_010233.pdf	f	3	3
435	Hellebore, Stinking	Helleborus foetidus		http://en.wikipedia.org/wiki/Helleborus_foetidus\\r                                                                                                                                                                                                                                                                                                                                           +\n \\r                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       +\n 	f	3	2
436	Hellebore, Holly-Leaved	Helleborus argutifolius		http://en.wikipedia.org/wiki/Helleborus_argutifolius	f	3	2
442	Evergreen bugloss	Pentaglottis sempervirens			f	3	2
\.


--
-- Name: species_species_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('species_species_id_seq', 442, true);


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: root
--

COPY "user" (password, last_login, user_id, email, first_name, last_name, prefix, suffix, date_joined, is_active, is_staff, affiliations) FROM stdin;
pbkdf2_sha256$20000$NoIBZJZiAN2F$BcthjP8w08yzBxS2yE4+Nqi/4vR0GaBAER2W2zV+eGQ=	2015-08-07 14:26:57.491058-07	1	foobar@example.com					2015-03-25 11:13:53.949-07	t	t	
\.


--
-- Name: user_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('user_user_id_seq', 1, true);


--
-- Name: category_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY category
    ADD CONSTRAINT category_pkey PRIMARY KEY (category_id);


--
-- Name: comment_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (comment_id);


--
-- Name: django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type_app_label_7e5e21d66c71dff4_uniq; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_7e5e21d66c71dff4_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_flatpage_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY django_flatpage
    ADD CONSTRAINT django_flatpage_pkey PRIMARY KEY (id);


--
-- Name: django_flatpage_sites_flatpage_id_site_id_key; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY django_flatpage_sites
    ADD CONSTRAINT django_flatpage_sites_flatpage_id_site_id_key UNIQUE (flatpage_id, site_id);


--
-- Name: django_flatpage_sites_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY django_flatpage_sites
    ADD CONSTRAINT django_flatpage_sites_pkey PRIMARY KEY (id);


--
-- Name: django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: image_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY image
    ADD CONSTRAINT image_pkey PRIMARY KEY (image_id);


--
-- Name: invite_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY invite
    ADD CONSTRAINT invite_pkey PRIMARY KEY (invite_id);


--
-- Name: region_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY region
    ADD CONSTRAINT region_pkey PRIMARY KEY (region_id);


--
-- Name: report_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY report
    ADD CONSTRAINT report_pkey PRIMARY KEY (report_id);


--
-- Name: severity_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY severity
    ADD CONSTRAINT severity_pkey PRIMARY KEY (severity_id);


--
-- Name: species_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY species
    ADD CONSTRAINT species_pkey PRIMARY KEY (species_id);


--
-- Name: user_email_key; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- Name: user_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (user_id);


--
-- Name: comment_6f78b20c; Type: INDEX; Schema: public; Owner: root; Tablespace: 
--

CREATE INDEX comment_6f78b20c ON comment USING btree (report_id);


--
-- Name: comment_e93cb7eb; Type: INDEX; Schema: public; Owner: root; Tablespace: 
--

CREATE INDEX comment_e93cb7eb ON comment USING btree (created_by_id);


--
-- Name: django_admin_log_417f1b1c; Type: INDEX; Schema: public; Owner: root; Tablespace: 
--

CREATE INDEX django_admin_log_417f1b1c ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_e8701ad4; Type: INDEX; Schema: public; Owner: root; Tablespace: 
--

CREATE INDEX django_admin_log_e8701ad4 ON django_admin_log USING btree (user_id);


--
-- Name: django_flatpage_572d4e42; Type: INDEX; Schema: public; Owner: root; Tablespace: 
--

CREATE INDEX django_flatpage_572d4e42 ON django_flatpage USING btree (url);


--
-- Name: django_flatpage_sites_9365d6e7; Type: INDEX; Schema: public; Owner: root; Tablespace: 
--

CREATE INDEX django_flatpage_sites_9365d6e7 ON django_flatpage_sites USING btree (site_id);


--
-- Name: django_flatpage_sites_c3368d3a; Type: INDEX; Schema: public; Owner: root; Tablespace: 
--

CREATE INDEX django_flatpage_sites_c3368d3a ON django_flatpage_sites USING btree (flatpage_id);


--
-- Name: django_flatpage_url_3605c222788b482_like; Type: INDEX; Schema: public; Owner: root; Tablespace: 
--

CREATE INDEX django_flatpage_url_3605c222788b482_like ON django_flatpage USING btree (url varchar_pattern_ops);


--
-- Name: django_session_de54fa62; Type: INDEX; Schema: public; Owner: root; Tablespace: 
--

CREATE INDEX django_session_de54fa62 ON django_session USING btree (expire_date);


--
-- Name: django_session_session_key_1b92057944c10cdc_like; Type: INDEX; Schema: public; Owner: root; Tablespace: 
--

CREATE INDEX django_session_session_key_1b92057944c10cdc_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: image_1699a6e9; Type: INDEX; Schema: public; Owner: root; Tablespace: 
--

CREATE INDEX image_1699a6e9 ON image USING btree (species_id);


--
-- Name: image_69b97d17; Type: INDEX; Schema: public; Owner: root; Tablespace: 
--

CREATE INDEX image_69b97d17 ON image USING btree (comment_id);


--
-- Name: image_6f78b20c; Type: INDEX; Schema: public; Owner: root; Tablespace: 
--

CREATE INDEX image_6f78b20c ON image USING btree (report_id);


--
-- Name: image_e93cb7eb; Type: INDEX; Schema: public; Owner: root; Tablespace: 
--

CREATE INDEX image_e93cb7eb ON image USING btree (created_by_id);


--
-- Name: invite_6f78b20c; Type: INDEX; Schema: public; Owner: root; Tablespace: 
--

CREATE INDEX invite_6f78b20c ON invite USING btree (report_id);


--
-- Name: invite_e8701ad4; Type: INDEX; Schema: public; Owner: root; Tablespace: 
--

CREATE INDEX invite_e8701ad4 ON invite USING btree (user_id);


--
-- Name: invite_e93cb7eb; Type: INDEX; Schema: public; Owner: root; Tablespace: 
--

CREATE INDEX invite_e93cb7eb ON invite USING btree (created_by_id);


--
-- Name: region_center_id; Type: INDEX; Schema: public; Owner: root; Tablespace: 
--

CREATE INDEX region_center_id ON region USING gist (center);


--
-- Name: report_13021f19; Type: INDEX; Schema: public; Owner: root; Tablespace: 
--

CREATE INDEX report_13021f19 ON report USING btree (reported_category_id);


--
-- Name: report_370f6237; Type: INDEX; Schema: public; Owner: root; Tablespace: 
--

CREATE INDEX report_370f6237 ON report USING btree (reported_species_id);


--
-- Name: report_79d70d71; Type: INDEX; Schema: public; Owner: root; Tablespace: 
--

CREATE INDEX report_79d70d71 ON report USING btree (claimed_by_id);


--
-- Name: report_e93cb7eb; Type: INDEX; Schema: public; Owner: root; Tablespace: 
--

CREATE INDEX report_e93cb7eb ON report USING btree (created_by_id);


--
-- Name: report_ec2479ab; Type: INDEX; Schema: public; Owner: root; Tablespace: 
--

CREATE INDEX report_ec2479ab ON report USING btree (actual_species_id);


--
-- Name: report_point_id; Type: INDEX; Schema: public; Owner: root; Tablespace: 
--

CREATE INDEX report_point_id ON report USING gist (point);


--
-- Name: species_4449c1fa; Type: INDEX; Schema: public; Owner: root; Tablespace: 
--

CREATE INDEX species_4449c1fa ON species USING btree (severity_id);


--
-- Name: species_b583a629; Type: INDEX; Schema: public; Owner: root; Tablespace: 
--

CREATE INDEX species_b583a629 ON species USING btree (category_id);


--
-- Name: user_email_38ff06cdf62c3145_like; Type: INDEX; Schema: public; Owner: root; Tablespace: 
--

CREATE INDEX user_email_38ff06cdf62c3145_like ON "user" USING btree (email varchar_pattern_ops);


--
-- Name: comment_created_by_id_590f2c9eef9c98b4_fk_user_user_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT comment_created_by_id_590f2c9eef9c98b4_fk_user_user_id FOREIGN KEY (created_by_id) REFERENCES "user"(user_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: comment_report_id_2d8db102f21c6686_fk_report_report_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT comment_report_id_2d8db102f21c6686_fk_report_report_id FOREIGN KEY (report_id) REFERENCES report(report_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: djang_content_type_id_7786364361173a2_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT djang_content_type_id_7786364361173a2_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_user_id_517173a786e93da9_fk_user_user_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_517173a786e93da9_fk_user_user_id FOREIGN KEY (user_id) REFERENCES "user"(user_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_flatp_flatpage_id_72ad999820488744_fk_django_flatpage_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY django_flatpage_sites
    ADD CONSTRAINT django_flatp_flatpage_id_72ad999820488744_fk_django_flatpage_id FOREIGN KEY (flatpage_id) REFERENCES django_flatpage(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_flatpage_site_site_id_235724acf083ab11_fk_django_site_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY django_flatpage_sites
    ADD CONSTRAINT django_flatpage_site_site_id_235724acf083ab11_fk_django_site_id FOREIGN KEY (site_id) REFERENCES django_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: image_comment_id_13a386b64b578008_fk_comment_comment_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY image
    ADD CONSTRAINT image_comment_id_13a386b64b578008_fk_comment_comment_id FOREIGN KEY (comment_id) REFERENCES comment(comment_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: image_created_by_id_6c86c8ce5bce02e6_fk_user_user_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY image
    ADD CONSTRAINT image_created_by_id_6c86c8ce5bce02e6_fk_user_user_id FOREIGN KEY (created_by_id) REFERENCES "user"(user_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: image_report_id_4da556bd3f90a3ac_fk_report_report_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY image
    ADD CONSTRAINT image_report_id_4da556bd3f90a3ac_fk_report_report_id FOREIGN KEY (report_id) REFERENCES report(report_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: image_species_id_16b1349ed0dadded_fk_species_species_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY image
    ADD CONSTRAINT image_species_id_16b1349ed0dadded_fk_species_species_id FOREIGN KEY (species_id) REFERENCES species(species_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: invite_created_by_id_62271536f2b1b6f1_fk_user_user_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY invite
    ADD CONSTRAINT invite_created_by_id_62271536f2b1b6f1_fk_user_user_id FOREIGN KEY (created_by_id) REFERENCES "user"(user_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: invite_report_id_4b94ff6670ee9943_fk_report_report_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY invite
    ADD CONSTRAINT invite_report_id_4b94ff6670ee9943_fk_report_report_id FOREIGN KEY (report_id) REFERENCES report(report_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: invite_user_id_7cf921ed07a6bda2_fk_user_user_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY invite
    ADD CONSTRAINT invite_user_id_7cf921ed07a6bda2_fk_user_user_id FOREIGN KEY (user_id) REFERENCES "user"(user_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: r_reported_category_id_3f2ae40eb00d685f_fk_category_category_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY report
    ADD CONSTRAINT r_reported_category_id_3f2ae40eb00d685f_fk_category_category_id FOREIGN KEY (reported_category_id) REFERENCES category(category_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: repo_reported_species_id_4f53aa355784e870_fk_species_species_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY report
    ADD CONSTRAINT repo_reported_species_id_4f53aa355784e870_fk_species_species_id FOREIGN KEY (reported_species_id) REFERENCES species(species_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: report_actual_species_id_21131cef55febcf5_fk_species_species_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY report
    ADD CONSTRAINT report_actual_species_id_21131cef55febcf5_fk_species_species_id FOREIGN KEY (actual_species_id) REFERENCES species(species_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: report_claimed_by_id_1934db1c98383ca1_fk_user_user_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY report
    ADD CONSTRAINT report_claimed_by_id_1934db1c98383ca1_fk_user_user_id FOREIGN KEY (claimed_by_id) REFERENCES "user"(user_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: report_created_by_id_789e1fc38b6214e4_fk_user_user_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY report
    ADD CONSTRAINT report_created_by_id_789e1fc38b6214e4_fk_user_user_id FOREIGN KEY (created_by_id) REFERENCES "user"(user_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: species_category_id_72476416f841b8c9_fk_category_category_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY species
    ADD CONSTRAINT species_category_id_72476416f841b8c9_fk_category_category_id FOREIGN KEY (category_id) REFERENCES category(category_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: species_severity_id_27e4d970c574b6a2_fk_severity_severity_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY species
    ADD CONSTRAINT species_severity_id_27e4d970c574b6a2_fk_severity_severity_id FOREIGN KEY (severity_id) REFERENCES severity(severity_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

