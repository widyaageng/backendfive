--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(20) NOT NULL,
    games_played integer DEFAULT 0,
    best_guess integer
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (98, 'user_1655659804413', 2, 999999);
INSERT INTO public.users VALUES (97, 'user_1655659804414', 5, 999999);
INSERT INTO public.users VALUES (100, 'user_1655659861650', 2, 999999);
INSERT INTO public.users VALUES (99, 'user_1655659861651', 5, 999999);
INSERT INTO public.users VALUES (102, 'user_1655659876478', 2, 999999);
INSERT INTO public.users VALUES (90, 'user_1655659629039', 2, 999999);
INSERT INTO public.users VALUES (101, 'user_1655659876479', 5, 999999);
INSERT INTO public.users VALUES (88, 'Widya', 3, 999999);
INSERT INTO public.users VALUES (89, 'user_1655659629040', 5, 999999);
INSERT INTO public.users VALUES (104, 'user_1655659931226', 2, 999999);
INSERT INTO public.users VALUES (92, 'user_1655659665281', 2, 999999);
INSERT INTO public.users VALUES (103, 'user_1655659931227', 5, 999999);
INSERT INTO public.users VALUES (91, 'user_1655659665282', 5, 999999);
INSERT INTO public.users VALUES (94, 'user_1655659730495', 2, 999999);
INSERT INTO public.users VALUES (106, 'user_1655659946728', 2, 999999);
INSERT INTO public.users VALUES (93, 'user_1655659730496', 5, 999999);
INSERT INTO public.users VALUES (105, 'user_1655659946729', 5, 999999);
INSERT INTO public.users VALUES (96, 'user_1655659761152', 2, 999999);
INSERT INTO public.users VALUES (108, 'user_1655659974482', 2, 999999);
INSERT INTO public.users VALUES (95, 'user_1655659761153', 5, 999999);
INSERT INTO public.users VALUES (107, 'user_1655659974483', 5, 999999);
INSERT INTO public.users VALUES (110, 'user_1655660028313', 2, 999999);
INSERT INTO public.users VALUES (109, 'user_1655660028314', 5, 999999);
INSERT INTO public.users VALUES (111, 'Joe', 1, 999999);
INSERT INTO public.users VALUES (113, 'user_1655660088633', 2, 999999);
INSERT INTO public.users VALUES (112, 'user_1655660088634', 5, 999999);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 113, true);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- PostgreSQL database dump complete
--

