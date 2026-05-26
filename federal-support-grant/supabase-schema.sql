-- ============================================================
--  FEDERAL SUPPORT GRANT — Run this in Supabase SQL Editor
--  Go to: supabase.com → Your Project → SQL Editor → Paste → Run
-- ============================================================

-- 1. Create applications table
CREATE TABLE applications (
  id                BIGSERIAL PRIMARY KEY,
  reference_number  TEXT UNIQUE NOT NULL,
  first_name        TEXT NOT NULL,
  last_name         TEXT NOT NULL,
  email             TEXT NOT NULL,
  phone             TEXT,
  date_of_birth     DATE,
  state             TEXT,
  address           TEXT,
  applicant_type    TEXT,
  grant_category    TEXT,
  amount_requested  NUMERIC,
  purpose           TEXT,
  income_range      TEXT,
  status            TEXT DEFAULT 'pending',
  submitted_at      TIMESTAMPTZ DEFAULT NOW(),
  reviewed_at       TIMESTAMPTZ,
  admin_notes       TEXT
);

-- 2. Turn on Row Level Security
ALTER TABLE applications ENABLE ROW LEVEL SECURITY;

-- 3. Allow anyone to submit an application (INSERT)
CREATE POLICY "Allow public to submit"
  ON applications
  FOR INSERT
  WITH CHECK (true);

-- 4. Only logged-in admin can read applications
CREATE POLICY "Admin can read all"
  ON applications
  FOR SELECT
  USING (auth.role() = 'authenticated');

-- 5. Only logged-in admin can update status
CREATE POLICY "Admin can update"
  ON applications
  FOR UPDATE
  USING (auth.role() = 'authenticated');

-- ✅ Done. Go to Table Editor to confirm the table was created.
