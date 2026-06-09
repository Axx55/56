-- ============================================
-- 002: باقي جداول نظام مسارات
-- ============================================

-- 1. المدن
CREATE TABLE IF NOT EXISTS public.cities (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    name character varying(100) NOT NULL,
    name_en character varying(100),
    sort_order integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);

-- 2. الأحياء
CREATE TABLE IF NOT EXISTS public.districts (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    name character varying(100) NOT NULL,
    name_en character varying(100),
    city_id uuid REFERENCES public.cities(id) ON DELETE CASCADE,
    sort_order integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);

-- 3. المستويات التعليمية
CREATE TABLE IF NOT EXISTS public.education_levels (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    name character varying(100) NOT NULL,
    name_en character varying(100),
    sort_order integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);

-- 4. المدارس
CREATE TYPE school_type AS ENUM ('government', 'private', 'international');
CREATE TYPE school_status AS ENUM ('active', 'inactive', 'under_maintenance');

CREATE TABLE IF NOT EXISTS public.schools (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    name character varying(200) NOT NULL,
    name_en character varying(200),
    district_id uuid REFERENCES public.districts(id) ON DELETE SET NULL,
    city_id uuid REFERENCES public.cities(id) ON DELETE SET NULL,
    type school_type DEFAULT 'government',
    status school_status DEFAULT 'active' NOT NULL,
    latitude double precision,
    longitude double precision,
    address text,
    phone character varying(20),
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);

-- 5. نقاط التجمع
CREATE TABLE IF NOT EXISTS public.gathering_points (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    name character varying(200) NOT NULL,
    address text,
    latitude double precision,
    longitude double precision,
    district_id uuid REFERENCES public.districts(id) ON DELETE SET NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);

-- 6. أيام الدراسة
CREATE TABLE IF NOT EXISTS public.study_days (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    day_name character varying(20) NOT NULL,
    day_name_en character varying(20),
    day_number integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);

-- 7. خطط النقل
CREATE TYPE trip_type AS ENUM ('go', 'return_both', 'go_and_return');

CREATE TABLE IF NOT EXISTS public.transport_plans (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    school_id uuid REFERENCES public.schools(id) ON DELETE CASCADE,
    gathering_point_id uuid REFERENCES public.gathering_points(id) ON DELETE SET NULL,
    name character varying(200),
    trip_type trip_type,
    price numeric(10, 2),
    start_time time,
    end_time time,
    study_days integer[], -- array of day_numbers from study_days
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);

-- 8. الطلاب
CREATE TYPE gender AS ENUM ('male', 'female');
CREATE TYPE student_status AS ENUM ('active', 'pending', 'suspended');

CREATE TABLE IF NOT EXISTS public.students (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    parent_id uuid REFERENCES public.parents_profile(parent_id) ON DELETE CASCADE NOT NULL,
    full_name character varying(150) NOT NULL,
    gender gender DEFAULT 'male',
    date_of_birth date,
    education_level_id uuid REFERENCES public.education_levels(id) ON DELETE SET NULL,
    school_id uuid REFERENCES public.schools(id) ON DELETE SET NULL,
    location text,
    latitude double precision,
    longitude double precision,
    avatar_url text,
    status student_status DEFAULT 'pending' NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);

-- 9. الاشتراكات
CREATE TYPE subscription_status AS ENUM ('active', 'inactive', 'suspended', 'expired', 'cancelled', 'trial_pending', 'trial_active', 'trial_expired');
CREATE TYPE subscription_period AS ENUM ('monthly', 'semester', 'yearly');
CREATE TYPE subscription_type AS ENUM ('monthly', 'term', 'yearly');

CREATE TABLE IF NOT EXISTS public.subscriptions (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    student_id uuid REFERENCES public.students(id) ON DELETE CASCADE NOT NULL,
    transport_plan_id uuid REFERENCES public.transport_plans(id) ON DELETE SET NULL,
    status subscription_status DEFAULT 'inactive' NOT NULL,
    period subscription_period DEFAULT 'monthly' NOT NULL,
    type subscription_type DEFAULT 'monthly' NOT NULL,
    start_date date,
    end_date date,
    amount numeric(10, 2),
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);

-- 10. الفواتير
CREATE TYPE bill_status AS ENUM ('pending', 'paid', 'overdue', 'cancelled');

CREATE TABLE IF NOT EXISTS public.bills (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    subscription_id uuid REFERENCES public.subscriptions(id) ON DELETE CASCADE,
    parent_id uuid REFERENCES public.parents_profile(parent_id) ON DELETE CASCADE NOT NULL,
    amount numeric(10, 2) NOT NULL,
    paid_amount numeric(10, 2) DEFAULT 0,
    status bill_status DEFAULT 'pending' NOT NULL,
    due_date date,
    paid_at timestamp with time zone,
    payment_method character varying(50),
    receipt_url text,
    notes text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);

-- 11. فواتير الدفعات
CREATE TYPE batch_bill_status AS ENUM ('pending', 'processed', 'cancelled');

CREATE TABLE IF NOT EXISTS public.batch_bills (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    batch_name character varying(200),
    status batch_bill_status DEFAULT 'pending',
    total_bills integer DEFAULT 0,
    total_amount numeric(12, 2) DEFAULT 0,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);

-- 12. البنوك
CREATE TABLE IF NOT EXISTS public.banks (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    name character varying(200) NOT NULL,
    account_number character varying(50),
    account_name character varying(200),
    iban character varying(34),
    created_at timestamp with time zone DEFAULT now() NOT NULL
);

-- 13. الشكاوى
CREATE TYPE complaint_status AS ENUM ('open', 'in_progress', 'resolved', 'closed');

CREATE TABLE IF NOT EXISTS public.complaints (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id uuid REFERENCES public.parents_profile(parent_id) ON DELETE CASCADE,
    subject character varying(200) NOT NULL,
    description text NOT NULL,
    status complaint_status DEFAULT 'open' NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);

-- 14. التقييمات
CREATE TABLE IF NOT EXISTS public.ratings (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id uuid REFERENCES public.parents_profile(parent_id) ON DELETE CASCADE,
    stars integer NOT NULL CHECK (stars >= 1 AND stars <= 5),
    comment text,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);

-- 15. طلبات إضافة طفل
CREATE TYPE request_status AS ENUM ('pending', 'approved', 'rejected');

CREATE TABLE IF NOT EXISTS public.add_child_requests (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    parent_id uuid REFERENCES public.parents_profile(parent_id) ON DELETE CASCADE NOT NULL,
    student_id uuid REFERENCES public.students(id) ON DELETE SET NULL,
    student_name character varying(150),
    status request_status DEFAULT 'pending' NOT NULL,
    rejection_reason text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);

-- 16. الإشعارات
CREATE TYPE notification_type AS ENUM (
    'bill_payment_confirmed', 'bill_payment_rejected', 'bill_created', 'bill_overdue',
    'child_request_approved', 'child_request_rejected', 'child_request_pending',
    'subscription_activated', 'subscription_expired', 'subscription_cancelled',
    'system_announcement', 'trip_update', 'general'
);

CREATE TABLE IF NOT EXISTS public.notifications (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id uuid REFERENCES public.parents_profile(parent_id) ON DELETE CASCADE,
    type notification_type NOT NULL,
    title character varying(200) NOT NULL,
    body text NOT NULL,
    is_read boolean DEFAULT false NOT NULL,
    related_id uuid,
    related_type character varying(50),
    created_at timestamp with time zone DEFAULT now() NOT NULL
);

-- 17. سجل الرحلات
CREATE TYPE trip_record_status AS ENUM ('upcoming', 'completed', 'cancelled');

CREATE TABLE IF NOT EXISTS public.trip_records (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    student_id uuid REFERENCES public.students(id) ON DELETE CASCADE,
    driver_name character varying(100),
    trip_date date,
    start_time time,
    end_time time,
    status trip_record_status DEFAULT 'upcoming' NOT NULL,
    pickup_location text,
    dropoff_location text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);

-- 18. خطوات الإعداد (onboarding)
CREATE TABLE IF NOT EXISTS public.onboarding_steps (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    title character varying(200) NOT NULL,
    description text NOT NULL,
    icon_url text,
    step_number integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);

-- ============================================
-- إنشاء الفهارس (Indexes)
-- ============================================
CREATE INDEX IF NOT EXISTS idx_students_parent_id ON public.students(parent_id);
CREATE INDEX IF NOT EXISTS idx_students_school_id ON public.students(school_id);
CREATE INDEX IF NOT EXISTS idx_subscriptions_student_id ON public.subscriptions(student_id);
CREATE INDEX IF NOT EXISTS idx_subscriptions_transport_plan_id ON public.subscriptions(transport_plan_id);
CREATE INDEX IF NOT EXISTS idx_bills_subscription_id ON public.bills(subscription_id);
CREATE INDEX IF NOT EXISTS idx_bills_parent_id ON public.bills(parent_id);
CREATE INDEX IF NOT EXISTS idx_bills_status ON public.bills(status);
CREATE INDEX IF NOT EXISTS idx_notifications_user_id ON public.notifications(user_id);
CREATE INDEX IF NOT EXISTS idx_notifications_is_read ON public.notifications(is_read);
CREATE INDEX IF NOT EXISTS idx_complaints_user_id ON public.complaints(user_id);
CREATE INDEX IF NOT EXISTS idx_add_child_requests_parent_id ON public.add_child_requests(parent_id);
CREATE INDEX IF NOT EXISTS idx_trip_records_student_id ON public.trip_records(student_id);
CREATE INDEX IF NOT EXISTS idx_districts_city_id ON public.districts(city_id);
CREATE INDEX IF NOT EXISTS idx_schools_district_id ON public.schools(district_id);
CREATE INDEX IF NOT EXISTS idx_schools_city_id ON public.schools(city_id);
CREATE INDEX IF NOT EXISTS idx_transport_plans_school_id ON public.transport_plans(school_id);

-- ============================================
-- تحديث updated_at تلقائياً
-- ============================================
CREATE OR REPLACE FUNCTION public.update_updated_at()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$;

CREATE TRIGGER trigger_students_updated_at
    BEFORE UPDATE ON public.students
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();

CREATE TRIGGER trigger_schools_updated_at
    BEFORE UPDATE ON public.schools
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();

CREATE TRIGGER trigger_transport_plans_updated_at
    BEFORE UPDATE ON public.transport_plans
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();

CREATE TRIGGER trigger_subscriptions_updated_at
    BEFORE UPDATE ON public.subscriptions
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();

CREATE TRIGGER trigger_bills_updated_at
    BEFORE UPDATE ON public.bills
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();

CREATE TRIGGER trigger_complaints_updated_at
    BEFORE UPDATE ON public.complaints
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();

CREATE TRIGGER trigger_add_child_requests_updated_at
    BEFORE UPDATE ON public.add_child_requests
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();

CREATE TRIGGER trigger_trip_records_updated_at
    BEFORE UPDATE ON public.trip_records
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();
