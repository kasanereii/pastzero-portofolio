import { createClient } from '@supabase/supabase-js';
const url = import.meta.env.VITE_SUPABASE_URL;https://zqxezgwtsordfmjxmjpm.supabase.co
const key = import.meta.env.VITE_SUPABASE_ANON_KEY;sb_publishable_tzTMjTFcfWq3d_r-qOvcgw_xfI4gdkt
export const supabase = url && key ? createClient(url, key) : null;
