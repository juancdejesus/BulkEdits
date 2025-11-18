-- ============================================================================
-- Data Update Portal - MySQL Database Schema
-- ============================================================================
-- Version: 1.0
-- Date: November 2025
-- Database: MySQL 8.0+
-- Description: Complete database schema for the Data Update Portal application
-- ============================================================================

-- Create Database
CREATE DATABASE IF NOT EXISTS data_update_portal
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE data_update_portal;

-- ============================================================================
-- APPLICATION SCHEMA - Core Application Tables
-- ============================================================================

-- Roles Table
CREATE TABLE roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255),
    is_global_role BOOLEAN DEFAULT FALSE COMMENT 'True for Admin, Global Submitter, Global Approver, Viewer',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_role_name (role_name)
) ENGINE=InnoDB COMMENT='User role definitions';

-- Insert default roles
INSERT INTO roles (role_name, description, is_global_role) VALUES
    ('Admin', 'Full system access and administration', TRUE),
    ('Global Submitter', 'Can submit jobs for any template', TRUE),
    ('Global Approver', 'Can approve jobs for any template', TRUE),
    ('Template Submitter', 'Can submit jobs for assigned templates only', FALSE),
    ('Template Approver', 'Can approve jobs for assigned templates only', FALSE),
    ('Viewer', 'Read-only access to jobs and reports', TRUE);

-- Users Table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    entra_object_id VARCHAR(100) NOT NULL UNIQUE COMMENT 'Microsoft Entra ID object ID',
    email VARCHAR(255) NOT NULL,
    display_name VARCHAR(255),
    role_id INT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    last_login TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES roles(role_id) ON DELETE RESTRICT,
    INDEX idx_email (email),
    INDEX idx_entra_object_id (entra_object_id),
    INDEX idx_role_id (role_id),
    INDEX idx_is_active (is_active)
) ENGINE=InnoDB COMMENT='Application users synchronized from Entra ID';

-- Templates Table
CREATE TABLE templates (
    template_id INT AUTO_INCREMENT PRIMARY KEY,
    entity_type ENUM('Client', 'Vendor', 'Matter') NOT NULL,
    template_name VARCHAR(255) NOT NULL,
    version VARCHAR(10) NOT NULL,
    file_path VARCHAR(500),
    requires_approval BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    description TEXT,
    created_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(user_id) ON DELETE SET NULL,
    INDEX idx_entity_type (entity_type),
    INDEX idx_is_active (is_active),
    INDEX idx_template_name (template_name),
    UNIQUE KEY uk_template_version (template_name, version)
) ENGINE=InnoDB COMMENT='Upload template definitions';

-- Template Permissions Table
CREATE TABLE template_permissions (
    permission_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    template_id INT NOT NULL,
    permission_type ENUM('Submitter', 'Approver') NOT NULL,
    granted_by INT NOT NULL,
    granted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (template_id) REFERENCES templates(template_id) ON DELETE CASCADE,
    FOREIGN KEY (granted_by) REFERENCES users(user_id) ON DELETE RESTRICT,
    UNIQUE KEY uk_user_template_permission (user_id, template_id, permission_type),
    INDEX idx_user_id (user_id),
    INDEX idx_template_id (template_id),
    INDEX idx_permission_type (permission_type),
    INDEX idx_is_active (is_active)
) ENGINE=InnoDB COMMENT='User permissions for specific templates';

-- Jobs Table
CREATE TABLE jobs (
    job_id INT AUTO_INCREMENT PRIMARY KEY,
    template_id INT NOT NULL,
    submitted_by INT NOT NULL,
    file_name VARCHAR(255),
    file_size BIGINT COMMENT 'File size in bytes',
    file_path VARCHAR(500) COMMENT 'Path to uploaded file',
    status ENUM(
        'Pending',
        'Validating',
        'ValidationFailed',
        'AwaitingApproval',
        'Approved',
        'Rejected',
        'Processing',
        'Completed',
        'Failed',
        'Cancelled'
    ) DEFAULT 'Pending',
    validation_errors JSON COMMENT 'JSON array of validation errors',
    total_rows INT DEFAULT 0,
    processed_rows INT DEFAULT 0,
    approved_by INT,
    approved_at TIMESTAMP NULL,
    approval_comments VARCHAR(1000),
    started_at TIMESTAMP NULL,
    completed_at TIMESTAMP NULL,
    error_message TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (template_id) REFERENCES templates(template_id) ON DELETE RESTRICT,
    FOREIGN KEY (submitted_by) REFERENCES users(user_id) ON DELETE RESTRICT,
    FOREIGN KEY (approved_by) REFERENCES users(user_id) ON DELETE RESTRICT,
    INDEX idx_status (status),
    INDEX idx_submitted_by (submitted_by),
    INDEX idx_template_id (template_id),
    INDEX idx_approved_by (approved_by),
    INDEX idx_created_at (created_at),
    INDEX idx_completed_at (completed_at)
) ENGINE=InnoDB COMMENT='Job submissions and processing tracking';

-- Job Comments Table (for approval workflow communication)
CREATE TABLE job_comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    job_id INT NOT NULL,
    user_id INT NOT NULL,
    comment_text TEXT NOT NULL,
    comment_type ENUM('Submission', 'Approval', 'Rejection', 'Modification', 'General') DEFAULT 'General',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (job_id) REFERENCES jobs(job_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE RESTRICT,
    INDEX idx_job_id (job_id),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB COMMENT='Comments and communication on job requests';

-- ============================================================================
-- AUDIT SCHEMA - Audit and Compliance Tables
-- ============================================================================

-- Audit Log Table
CREATE TABLE audit_log (
    audit_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    job_id INT,
    user_id INT,
    action VARCHAR(100) NOT NULL COMMENT 'Upload, Validate, Approve, Reject, Execute, Delete, etc.',
    entity_type ENUM('Client', 'Vendor', 'Matter', 'User', 'Template', 'System') NULL,
    entity_id VARCHAR(100) COMMENT 'ID of the affected entity',
    old_value JSON COMMENT 'Previous value (for updates)',
    new_value JSON COMMENT 'New value (for updates)',
    ip_address VARCHAR(50),
    user_agent VARCHAR(500),
    session_id VARCHAR(100),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (job_id) REFERENCES jobs(job_id) ON DELETE SET NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL,
    INDEX idx_job_id (job_id),
    INDEX idx_user_id (user_id),
    INDEX idx_action (action),
    INDEX idx_entity_type (entity_type),
    INDEX idx_timestamp (timestamp)
) ENGINE=InnoDB COMMENT='Comprehensive audit trail for all system actions';

-- Data Changes Table (detailed field-level changes)
CREATE TABLE data_changes (
    change_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    job_id INT NOT NULL,
    entity_type ENUM('Client', 'Vendor', 'Matter') NOT NULL,
    entity_id VARCHAR(100) NOT NULL COMMENT 'ID of the record that was changed',
    field_name VARCHAR(100),
    old_value TEXT,
    new_value TEXT,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (job_id) REFERENCES jobs(job_id) ON DELETE CASCADE,
    INDEX idx_job_id (job_id),
    INDEX idx_entity_type_id (entity_type, entity_id),
    INDEX idx_changed_at (changed_at)
) ENGINE=InnoDB COMMENT='Field-level change tracking for data modifications';

-- ============================================================================
-- ERP INTEGRATION SCHEMA - Business Data Tables
-- ============================================================================

-- Clients Table
CREATE TABLE clients (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    client_code VARCHAR(20) NOT NULL UNIQUE,
    client_name VARCHAR(255) NOT NULL,
    status ENUM('Active', 'Inactive', 'Pending', 'Closed') DEFAULT 'Active',
    billing_address TEXT,
    contact_email VARCHAR(255),
    contact_phone VARCHAR(50),
    last_modified_by INT,
    last_modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (last_modified_by) REFERENCES users(user_id) ON DELETE SET NULL,
    INDEX idx_client_code (client_code),
    INDEX idx_client_name (client_name),
    INDEX idx_status (status)
) ENGINE=InnoDB COMMENT='Client master data';

-- Vendors Table
CREATE TABLE vendors (
    vendor_id INT AUTO_INCREMENT PRIMARY KEY,
    vendor_code VARCHAR(20) NOT NULL UNIQUE,
    vendor_name VARCHAR(255) NOT NULL,
    tax_id VARCHAR(50),
    status ENUM('Active', 'Inactive', 'Pending') DEFAULT 'Active',
    address TEXT,
    contact_email VARCHAR(255),
    contact_phone VARCHAR(50),
    payment_terms VARCHAR(100),
    last_modified_by INT,
    last_modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (last_modified_by) REFERENCES users(user_id) ON DELETE SET NULL,
    INDEX idx_vendor_code (vendor_code),
    INDEX idx_vendor_name (vendor_name),
    INDEX idx_status (status),
    INDEX idx_tax_id (tax_id)
) ENGINE=InnoDB COMMENT='Vendor master data';

-- Matters Table
CREATE TABLE matters (
    matter_id INT AUTO_INCREMENT PRIMARY KEY,
    matter_number VARCHAR(50) NOT NULL UNIQUE,
    matter_name VARCHAR(255) NOT NULL,
    client_id INT NOT NULL,
    status ENUM('Open', 'Closed', 'Pending', 'On Hold') DEFAULT 'Open',
    open_date DATE,
    close_date DATE,
    responsible_attorney VARCHAR(255),
    practice_area VARCHAR(100),
    last_modified_by INT,
    last_modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (client_id) REFERENCES clients(client_id) ON DELETE RESTRICT,
    FOREIGN KEY (last_modified_by) REFERENCES users(user_id) ON DELETE SET NULL,
    INDEX idx_matter_number (matter_number),
    INDEX idx_client_id (client_id),
    INDEX idx_status (status),
    INDEX idx_open_date (open_date)
) ENGINE=InnoDB COMMENT='Matter/case master data';

-- ============================================================================
-- NOTIFICATION & SYSTEM TABLES
-- ============================================================================

-- Notifications Table
CREATE TABLE notifications (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    job_id INT,
    notification_type ENUM(
        'JobCompleted',
        'JobFailed',
        'ApprovalRequired',
        'ApprovalGranted',
        'ApprovalRejected',
        'ValidationFailed',
        'SystemAlert'
    ) NOT NULL,
    title VARCHAR(255) NOT NULL,
    message TEXT,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    read_at TIMESTAMP NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (job_id) REFERENCES jobs(job_id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_is_read (is_read),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB COMMENT='User notifications for job events';

-- System Configuration Table
CREATE TABLE system_config (
    config_id INT AUTO_INCREMENT PRIMARY KEY,
    config_key VARCHAR(100) NOT NULL UNIQUE,
    config_value TEXT,
    config_type ENUM('String', 'Number', 'Boolean', 'JSON') DEFAULT 'String',
    description VARCHAR(500),
    is_public BOOLEAN DEFAULT FALSE COMMENT 'If true, value can be exposed to frontend',
    updated_by INT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (updated_by) REFERENCES users(user_id) ON DELETE SET NULL,
    INDEX idx_config_key (config_key)
) ENGINE=InnoDB COMMENT='System-wide configuration settings';

-- Insert default system configurations
INSERT INTO system_config (config_key, config_value, config_type, description, is_public) VALUES
    ('max_file_size_mb', '10', 'Number', 'Maximum upload file size in MB', TRUE),
    ('allowed_file_types', '["xlsx", "xls", "csv"]', 'JSON', 'Allowed file extensions', TRUE),
    ('session_timeout_minutes', '30', 'Number', 'Session timeout in minutes', FALSE),
    ('approval_reminder_hours', '24', 'Number', 'Hours before sending approval reminder', FALSE),
    ('auto_delete_completed_jobs_days', '90', 'Number', 'Days before auto-deleting completed jobs', FALSE);

-- User Sessions Table (for tracking active sessions)
CREATE TABLE user_sessions (
    session_id VARCHAR(100) PRIMARY KEY,
    user_id INT NOT NULL,
    ip_address VARCHAR(50),
    user_agent VARCHAR(500),
    login_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_activity TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    expires_at TIMESTAMP NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_expires_at (expires_at),
    INDEX idx_is_active (is_active)
) ENGINE=InnoDB COMMENT='Active user sessions for security tracking';

-- ============================================================================
-- VIEWS - Useful views for common queries
-- ============================================================================

-- Active Jobs View (excludes completed/cancelled)
CREATE VIEW vw_active_jobs AS
SELECT 
    j.job_id,
    j.status,
    j.file_name,
    j.total_rows,
    j.processed_rows,
    j.created_at,
    t.template_name,
    t.entity_type,
    t.requires_approval,
    u_submit.display_name AS submitted_by_name,
    u_submit.email AS submitted_by_email,
    u_approve.display_name AS approved_by_name,
    j.approved_at
FROM jobs j
INNER JOIN templates t ON j.template_id = t.template_id
INNER JOIN users u_submit ON j.submitted_by = u_submit.user_id
LEFT JOIN users u_approve ON j.approved_by = u_approve.user_id
WHERE j.status NOT IN ('Completed', 'Cancelled', 'Failed');

-- User Permissions View (combined global and template-specific)
CREATE VIEW vw_user_permissions AS
SELECT 
    u.user_id,
    u.display_name,
    u.email,
    r.role_name,
    r.is_global_role,
    tp.template_id,
    t.template_name,
    tp.permission_type,
    tp.is_active AS permission_active
FROM users u
INNER JOIN roles r ON u.role_id = r.role_id
LEFT JOIN template_permissions tp ON u.user_id = tp.user_id AND tp.is_active = TRUE
LEFT JOIN templates t ON tp.template_id = t.template_id
WHERE u.is_active = TRUE;

-- Job Statistics View
CREATE VIEW vw_job_statistics AS
SELECT 
    DATE(j.created_at) AS job_date,
    t.entity_type,
    j.status,
    COUNT(*) AS job_count,
    SUM(j.total_rows) AS total_rows_processed,
    AVG(TIMESTAMPDIFF(MINUTE, j.started_at, j.completed_at)) AS avg_processing_minutes
FROM jobs j
INNER JOIN templates t ON j.template_id = t.template_id
GROUP BY DATE(j.created_at), t.entity_type, j.status;

-- ============================================================================
-- STORED PROCEDURES - Business Logic
-- ============================================================================

-- Procedure to update Client data (called by job execution)
DELIMITER $$

CREATE PROCEDURE sp_update_client(
    IN p_job_id INT,
    IN p_client_code VARCHAR(20),
    IN p_client_name VARCHAR(255),
    IN p_status VARCHAR(20),
    IN p_billing_address TEXT,
    IN p_contact_email VARCHAR(255),
    IN p_modified_by INT
)
BEGIN
    DECLARE v_client_id INT;
    DECLARE v_old_name VARCHAR(255);
    DECLARE v_old_status VARCHAR(20);
    
    -- Start transaction
    START TRANSACTION;
    
    -- Get existing client
    SELECT client_id, client_name, status 
    INTO v_client_id, v_old_name, v_old_status
    FROM clients 
    WHERE client_code = p_client_code;
    
    IF v_client_id IS NULL THEN
        -- Insert new client
        INSERT INTO clients (
            client_code, client_name, status, 
            billing_address, contact_email, last_modified_by
        ) VALUES (
            p_client_code, p_client_name, p_status,
            p_billing_address, p_contact_email, p_modified_by
        );
        
        SET v_client_id = LAST_INSERT_ID();
        
        -- Log the change
        INSERT INTO data_changes (
            job_id, entity_type, entity_id, field_name, old_value, new_value
        ) VALUES (
            p_job_id, 'Client', p_client_code, 'client_name', NULL, p_client_name
        );
    ELSE
        -- Update existing client
        UPDATE clients 
        SET 
            client_name = p_client_name,
            status = p_status,
            billing_address = p_billing_address,
            contact_email = p_contact_email,
            last_modified_by = p_modified_by,
            last_modified_at = CURRENT_TIMESTAMP
        WHERE client_id = v_client_id;
        
        -- Log changes
        IF v_old_name != p_client_name THEN
            INSERT INTO data_changes (
                job_id, entity_type, entity_id, field_name, old_value, new_value
            ) VALUES (
                p_job_id, 'Client', p_client_code, 'client_name', v_old_name, p_client_name
            );
        END IF;
        
        IF v_old_status != p_status THEN
            INSERT INTO data_changes (
                job_id, entity_type, entity_id, field_name, old_value, new_value
            ) VALUES (
                p_job_id, 'Client', p_client_code, 'status', v_old_status, p_status
            );
        END IF;
    END IF;
    
    COMMIT;
END$$

DELIMITER ;

-- ============================================================================
-- INDEXES FOR PERFORMANCE
-- ============================================================================

-- Additional composite indexes for common queries

-- Jobs by status and date
CREATE INDEX idx_jobs_status_created ON jobs(status, created_at);

-- Jobs by user and status
CREATE INDEX idx_jobs_user_status ON jobs(submitted_by, status);

-- Audit log by user and date
CREATE INDEX idx_audit_user_timestamp ON audit_log(user_id, timestamp);

-- Template permissions lookup
CREATE INDEX idx_template_perms_lookup ON template_permissions(template_id, permission_type, is_active);

-- ============================================================================
-- SAMPLE DATA (Optional - for testing)
-- ============================================================================

-- Insert sample admin user
INSERT INTO users (entra_object_id, email, display_name, role_id, is_active) VALUES
    ('00000000-0000-0000-0000-000000000001', 'admin@lawfirm.com', 'System Admin', 1, TRUE),
    ('00000000-0000-0000-0000-000000000002', 'john.smith@lawfirm.com', 'John Smith', 2, TRUE),
    ('00000000-0000-0000-0000-000000000003', 'sarah.johnson@lawfirm.com', 'Sarah Johnson', 3, TRUE);

-- Insert sample templates
INSERT INTO templates (entity_type, template_name, version, file_path, requires_approval, is_active, created_by) VALUES
    ('Client', 'Client Bulk Update', 'v2.1', '/templates/client_bulk_update_v2.1.xlsx', TRUE, TRUE, 1),
    ('Vendor', 'Vendor Registration', 'v1.5', '/templates/vendor_registration_v1.5.xlsx', FALSE, TRUE, 1),
    ('Matter', 'Matter Update', 'v3.0', '/templates/matter_update_v3.0.xlsx', TRUE, TRUE, 1);

-- Insert sample template permissions
INSERT INTO template_permissions (user_id, template_id, permission_type, granted_by) VALUES
    (2, 1, 'Submitter', 1),  -- John can submit Client updates
    (2, 2, 'Submitter', 1),  -- John can submit Vendor registrations
    (3, 1, 'Approver', 1);   -- Sarah can approve Client updates

-- ============================================================================
-- MAINTENANCE SCRIPTS
-- ============================================================================

-- Event to clean up old sessions (runs daily)
CREATE EVENT IF NOT EXISTS cleanup_expired_sessions
ON SCHEDULE EVERY 1 DAY
DO
    DELETE FROM user_sessions 
    WHERE expires_at < NOW() OR 
          (is_active = FALSE AND last_activity < DATE_SUB(NOW(), INTERVAL 7 DAY));

-- Event to clean up old audit logs (runs monthly - keep 7 years)
CREATE EVENT IF NOT EXISTS cleanup_old_audit_logs
ON SCHEDULE EVERY 1 MONTH
DO
    DELETE FROM audit_log 
    WHERE timestamp < DATE_SUB(NOW(), INTERVAL 7 YEAR);

-- ============================================================================
-- GRANT PERMISSIONS (adjust as needed for your environment)
-- ============================================================================

-- Create application user (replace with your actual username/password)
-- CREATE USER IF NOT EXISTS 'data_portal_app'@'localhost' IDENTIFIED BY 'your_secure_password';
-- GRANT SELECT, INSERT, UPDATE, DELETE ON data_update_portal.* TO 'data_portal_app'@'localhost';
-- GRANT EXECUTE ON data_update_portal.* TO 'data_portal_app'@'localhost';
-- FLUSH PRIVILEGES;

-- ============================================================================
-- END OF SCHEMA
-- ============================================================================

-- Verify installation
SELECT 'Database schema created successfully!' AS Status;
SELECT TABLE_NAME, TABLE_TYPE 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'data_update_portal'
ORDER BY TABLE_TYPE, TABLE_NAME;