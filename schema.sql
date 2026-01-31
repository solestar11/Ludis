-- Users, Athletes, Coaches, Institutions, Videos, Contact Requests
-- + Full-text search for athletes

-- Users
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL CHECK (role IN ('athlete', 'coach', 'institution')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Institutions
CREATE TABLE institutions (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    domain_email VARCHAR(255) NOT NULL UNIQUE,
    verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Athletes
CREATE TABLE athletes (
    user_id INT PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    sport VARCHAR(50) NOT NULL,
    position VARCHAR(50),
    graduation_year INT,
    gpa NUMERIC(3,2),
    height_cm INT,
    weight_kg INT,
    school VARCHAR(255),
    verified BOOLEAN DEFAULT FALSE,
    verification_status VARCHAR(20) DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Coaches
CREATE TABLE coaches (
    user_id INT PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    institution_id INT REFERENCES institutions(id),
    verified BOOLEAN DEFAULT FALSE,
    verification_status VARCHAR(20) DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Athlete Videos
CREATE TABLE athlete_videos (
    id SERIAL PRIMARY KEY,
    athlete_id INT REFERENCES athletes(user_id) ON DELETE CASCADE,
    video_url TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Contact Requests
CREATE TABLE contact_requests (
    id SERIAL PRIMARY KEY,
    coach_id INT REFERENCES coaches(user_id) ON DELETE CASCADE,
    athlete_id INT REFERENCES athletes(user_id) ON DELETE CASCADE,
    request_type VARCHAR(50) NOT NULL CHECK (request_type IN ('evaluation','camp','interest')),
    message TEXT,
    status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending','approved','rejected')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Full-text search for athletes
ALTER TABLE athletes ADD COLUMN tsv tsvector;
CREATE FUNCTION athletes_tsv_trigger() RETURNS trigger AS $$
BEGIN
  NEW.tsv :=
    setweight(to_tsvector('english', coalesce(NEW.first_name,'')), 'A') ||
    setweight(to_tsvector('english', coalesce(NEW.last_name,'')), 'A') ||
    setweight(to_tsvector('english', coalesce(NEW.sport,'')), 'B') ||
    setweight(to_tsvector('english', coalesce(NEW.position,'')), 'B') ||
    setweight(to_tsvector('english', coalesce(NEW.school,'')), 'C');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE ON athletes FOR EACH ROW EXECUTE FUNCTION athletes_tsv_trigger();
CREATE INDEX idx_athletes_tsv ON athletes USING GIN(tsv);
