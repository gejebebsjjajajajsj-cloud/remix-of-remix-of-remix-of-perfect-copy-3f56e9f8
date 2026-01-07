-- Add site_id column to site_config table to support multiple sites
ALTER TABLE public.site_config ADD COLUMN site_id text NOT NULL DEFAULT 'default';

-- Update existing records to use 'production' as their site_id (for Vercel)
UPDATE public.site_config SET site_id = 'production';

-- Create a unique constraint on config_key + site_id
ALTER TABLE public.site_config DROP CONSTRAINT IF EXISTS site_config_config_key_key;
ALTER TABLE public.site_config ADD CONSTRAINT site_config_config_key_site_id_unique UNIQUE (config_key, site_id);

-- Create index for faster queries by site_id
CREATE INDEX idx_site_config_site_id ON public.site_config(site_id);