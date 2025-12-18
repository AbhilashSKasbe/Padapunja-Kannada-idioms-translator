CREATE DATABASE IF NOT EXISTS kannada_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE kannada_db;

CREATE TABLE IF NOT EXISTS idioms (
    idiom VARCHAR(255) PRIMARY KEY,
    explanation_english TEXT,
    explanation_kannada TEXT
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255),
    original_sentence TEXT,
    status VARCHAR(50),
    match_type VARCHAR(50),
    idiom VARCHAR(255),
    confidence INT,
    translation TEXT,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS suggestions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    idiom VARCHAR(255) NOT NULL,
    
    explanation_kannada TEXT NOT NULL,
   
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS  feedback (
    id INT AUTO_INCREMENT PRIMARY KEY,
    message TEXT NOT NULL,
    email VARCHAR(255) NOT NULL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;



