CREATE TABLE IF NOT EXISTS public.parents_profile (
    parent_id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    full_name character varying(150) NOT NULL,
    phone_number character varying(20) NOT NULL UNIQUE,
    password_hash text NOT NULL,
    avatar_url text,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);
