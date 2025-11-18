-- ============================================================================
-- Data Update Portal - Stored Procedures for API Endpoints
-- ============================================================================
-- Version: 1.0
-- Date: November 2025
-- Description: Complete CRUD stored procedures for all entities
-- ============================================================================

USE data_update_portal;

-- Set delimiter for procedure creation
DELIMITER $$

-- ============================================================================
-- USERS PROCEDURES
-- ============================================================================

-- Create User
DROP PROCEDURE IF EXISTS sp_create_user$$
CREATE PROCEDURE sp_create_user(
    IN p_entra_object_id VARCHAR(100),
    IN p_email VARCHAR(255),
    IN p_display_name VARCHAR(255),
    IN p_role_id INT,
    IN p_created_by INT
)
BEGIN
    DECLARE v_user_id INT;
    
    -- Check if user already exists
    IF EXISTS (SELECT 1 FROM users WHERE entra_object_id = p_entra_object_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User with this Entra ID already exists';
    END IF;
    
    START TRANSACTION;
    
    INSERT INTO users (
        entra_object_id, email, display_name, role_id, is_active
    ) VALUES (
        p_entra_object_id, p_email, p_display_name, p_role_id, TRUE
    );
    
    SET v_user_id = LAST_INSERT_ID();
    
    -- Audit log
    INSERT INTO audit_log (user_id, action, entity_type, entity_id, new_value)
    VALUES (p_created_by, 'CreateUser', 'User', v_user_id, 
            JSON_OBJECT('email', p_email, 'role_id', p_role_id));
    
    COMMIT;
    
    -- Return created user
    SELECT * FROM users WHERE user_id = v_user_id;
END$$

-- Update User
DROP PROCEDURE IF EXISTS sp_update_user$$
CREATE PROCEDURE sp_update_user(
    IN p_user_id INT,
    IN p_email VARCHAR(255),
    IN p_display_name VARCHAR(255),
    IN p_role_id INT,
    IN p_is_active BOOLEAN,
    IN p_modified_by INT
)
BEGIN
    DECLARE v_old_data JSON;
    
    IF NOT EXISTS (SELECT 1 FROM users WHERE user_id = p_user_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User not found';
    END IF;
    
    START TRANSACTION;
    
    -- Store old values
    SELECT JSON_OBJECT(
        'email', email,
        'display_name', display_name,
        'role_id', role_id,
        'is_active', is_active
    ) INTO v_old_data
    FROM users WHERE user_id = p_user_id;
    
    UPDATE users 
    SET 
        email = p_email,
        display_name = p_display_name,
        role_id = p_role_id,
        is_active = p_is_active,
        updated_at = CURRENT_TIMESTAMP
    WHERE user_id = p_user_id;
    
    -- Audit log
    INSERT INTO audit_log (user_id, action, entity_type, entity_id, old_value, new_value)
    VALUES (p_modified_by, 'UpdateUser', 'User', p_user_id, v_old_data,
            JSON_OBJECT('email', p_email, 'display_name', p_display_name, 
                       'role_id', p_role_id, 'is_active', p_is_active));
    
    COMMIT;
    
    -- Return updated user
    SELECT * FROM users WHERE user_id = p_user_id;
END$$

-- Delete User (soft delete - set inactive)
DROP PROCEDURE IF EXISTS sp_delete_user$$
CREATE PROCEDURE sp_delete_user(
    IN p_user_id INT,
    IN p_deleted_by INT
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM users WHERE user_id = p_user_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User not found';
    END IF;
    
    START TRANSACTION;
    
    UPDATE users 
    SET is_active = FALSE, updated_at = CURRENT_TIMESTAMP
    WHERE user_id = p_user_id;
    
    -- Audit log
    INSERT INTO audit_log (user_id, action, entity_type, entity_id)
    VALUES (p_deleted_by, 'DeleteUser', 'User', p_user_id);
    
    COMMIT;
    
    SELECT 'User deactivated successfully' AS message;
END$$

-- Get User by ID
DROP PROCEDURE IF EXISTS sp_get_user$$
CREATE PROCEDURE sp_get_user(
    IN p_user_id INT
)
BEGIN
    SELECT 
        u.*,
        r.role_name,
        r.is_global_role,
        (SELECT COUNT(*) FROM template_permissions WHERE user_id = u.user_id AND is_active = TRUE) AS template_permission_count
    FROM users u
    INNER JOIN roles r ON u.role_id = r.role_id
    WHERE u.user_id = p_user_id;
END$$

-- Get All Users
DROP PROCEDURE IF EXISTS sp_get_all_users$$
CREATE PROCEDURE sp_get_all_users(
    IN p_is_active BOOLEAN,
    IN p_role_id INT,
    IN p_limit INT,
    IN p_offset INT
)
BEGIN
    SELECT 
        u.*,
        r.role_name,
        r.is_global_role,
        (SELECT COUNT(*) FROM template_permissions WHERE user_id = u.user_id AND is_active = TRUE) AS template_permission_count
    FROM users u
    INNER JOIN roles r ON u.role_id = r.role_id
    WHERE (p_is_active IS NULL OR u.is_active = p_is_active)
    AND (p_role_id IS NULL OR u.role_id = p_role_id)
    ORDER BY u.created_at DESC
    LIMIT p_limit OFFSET p_offset;
    
    -- Return total count
    SELECT COUNT(*) AS total_count
    FROM users u
    WHERE (p_is_active IS NULL OR u.is_active = p_is_active)
    AND (p_role_id IS NULL OR u.role_id = p_role_id);
END$$

-- ============================================================================
-- TEMPLATES PROCEDURES
-- ============================================================================

-- Create Template
DROP PROCEDURE IF EXISTS sp_create_template$$
CREATE PROCEDURE sp_create_template(
    IN p_entity_type VARCHAR(20),
    IN p_template_name VARCHAR(255),
    IN p_version VARCHAR(10),
    IN p_file_path VARCHAR(500),
    IN p_requires_approval BOOLEAN,
    IN p_description TEXT,
    IN p_created_by INT
)
BEGIN
    DECLARE v_template_id INT;
    
    START TRANSACTION;
    
    INSERT INTO templates (
        entity_type, template_name, version, file_path, 
        requires_approval, is_active, description, created_by
    ) VALUES (
        p_entity_type, p_template_name, p_version, p_file_path,
        p_requires_approval, TRUE, p_description, p_created_by
    );
    
    SET v_template_id = LAST_INSERT_ID();
    
    -- Audit log
    INSERT INTO audit_log (user_id, action, entity_type, entity_id, new_value)
    VALUES (p_created_by, 'CreateTemplate', 'Template', v_template_id,
            JSON_OBJECT('template_name', p_template_name, 'version', p_version));
    
    COMMIT;
    
    SELECT * FROM templates WHERE template_id = v_template_id;
END$$

-- Update Template
DROP PROCEDURE IF EXISTS sp_update_template$$
CREATE PROCEDURE sp_update_template(
    IN p_template_id INT,
    IN p_template_name VARCHAR(255),
    IN p_version VARCHAR(10),
    IN p_requires_approval BOOLEAN,
    IN p_is_active BOOLEAN,
    IN p_description TEXT,
    IN p_modified_by INT
)
BEGIN
    DECLARE v_old_data JSON;
    
    IF NOT EXISTS (SELECT 1 FROM templates WHERE template_id = p_template_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Template not found';
    END IF;
    
    START TRANSACTION;
    
    SELECT JSON_OBJECT(
        'template_name', template_name,
        'version', version,
        'requires_approval', requires_approval,
        'is_active', is_active
    ) INTO v_old_data
    FROM templates WHERE template_id = p_template_id;
    
    UPDATE templates 
    SET 
        template_name = p_template_name,
        version = p_version,
        requires_approval = p_requires_approval,
        is_active = p_is_active,
        description = p_description,
        updated_at = CURRENT_TIMESTAMP
    WHERE template_id = p_template_id;
    
    INSERT INTO audit_log (user_id, action, entity_type, entity_id, old_value, new_value)
    VALUES (p_modified_by, 'UpdateTemplate', 'Template', p_template_id, v_old_data,
            JSON_OBJECT('template_name', p_template_name, 'version', p_version, 
                       'requires_approval', p_requires_approval, 'is_active', p_is_active));
    
    COMMIT;
    
    SELECT * FROM templates WHERE template_id = p_template_id;
END$$

-- Delete Template (soft delete)
DROP PROCEDURE IF EXISTS sp_delete_template$$
CREATE PROCEDURE sp_delete_template(
    IN p_template_id INT,
    IN p_deleted_by INT
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM templates WHERE template_id = p_template_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Template not found';
    END IF;
    
    START TRANSACTION;
    
    UPDATE templates 
    SET is_active = FALSE, updated_at = CURRENT_TIMESTAMP
    WHERE template_id = p_template_id;
    
    INSERT INTO audit_log (user_id, action, entity_type, entity_id)
    VALUES (p_deleted_by, 'DeleteTemplate', 'Template', p_template_id);
    
    COMMIT;
    
    SELECT 'Template deactivated successfully' AS message;
END$$

-- Get Template
DROP PROCEDURE IF EXISTS sp_get_template$$
CREATE PROCEDURE sp_get_template(
    IN p_template_id INT
)
BEGIN
    SELECT 
        t.*,
        u.display_name AS created_by_name,
        (SELECT COUNT(*) FROM jobs WHERE template_id = t.template_id) AS total_uses,
        (SELECT COUNT(DISTINCT user_id) FROM template_permissions WHERE template_id = t.template_id AND is_active = TRUE) AS active_users
    FROM templates t
    LEFT JOIN users u ON t.created_by = u.user_id
    WHERE t.template_id = p_template_id;
END$$

-- Get All Templates
DROP PROCEDURE IF EXISTS sp_get_all_templates$$
CREATE PROCEDURE sp_get_all_templates(
    IN p_entity_type VARCHAR(20),
    IN p_is_active BOOLEAN,
    IN p_user_id INT,
    IN p_limit INT,
    IN p_offset INT
)
BEGIN
    -- If user_id provided, filter by user's permissions
    IF p_user_id IS NOT NULL THEN
        SELECT 
            t.*,
            u.display_name AS created_by_name,
            (SELECT COUNT(*) FROM jobs WHERE template_id = t.template_id) AS total_uses,
            (SELECT COUNT(DISTINCT user_id) FROM template_permissions WHERE template_id = t.template_id AND is_active = TRUE) AS active_users,
            CASE 
                WHEN EXISTS (
                    SELECT 1 FROM users usr 
                    INNER JOIN roles r ON usr.role_id = r.role_id 
                    WHERE usr.user_id = p_user_id AND r.role_name IN ('Admin', 'Global Submitter', 'Global Approver')
                ) THEN TRUE
                WHEN EXISTS (
                    SELECT 1 FROM template_permissions 
                    WHERE template_id = t.template_id AND user_id = p_user_id AND is_active = TRUE
                ) THEN TRUE
                ELSE FALSE
            END AS has_access
        FROM templates t
        LEFT JOIN users u ON t.created_by = u.user_id
        WHERE (p_entity_type IS NULL OR t.entity_type = p_entity_type)
        AND (p_is_active IS NULL OR t.is_active = p_is_active)
        ORDER BY t.created_at DESC
        LIMIT p_limit OFFSET p_offset;
    ELSE
        SELECT 
            t.*,
            u.display_name AS created_by_name,
            (SELECT COUNT(*) FROM jobs WHERE template_id = t.template_id) AS total_uses,
            (SELECT COUNT(DISTINCT user_id) FROM template_permissions WHERE template_id = t.template_id AND is_active = TRUE) AS active_users
        FROM templates t
        LEFT JOIN users u ON t.created_by = u.user_id
        WHERE (p_entity_type IS NULL OR t.entity_type = p_entity_type)
        AND (p_is_active IS NULL OR t.is_active = p_is_active)
        ORDER BY t.created_at DESC
        LIMIT p_limit OFFSET p_offset;
    END IF;
    
    -- Return total count
    SELECT COUNT(*) AS total_count
    FROM templates t
    WHERE (p_entity_type IS NULL OR t.entity_type = p_entity_type)
    AND (p_is_active IS NULL OR t.is_active = p_is_active);
END$$

-- ============================================================================
-- TEMPLATE PERMISSIONS PROCEDURES
-- ============================================================================

-- Create Template Permission
DROP PROCEDURE IF EXISTS sp_create_template_permission$$
CREATE PROCEDURE sp_create_template_permission(
    IN p_user_id INT,
    IN p_template_id INT,
    IN p_permission_type VARCHAR(20),
    IN p_granted_by INT
)
BEGIN
    DECLARE v_permission_id INT;
    
    -- Check if permission already exists
    IF EXISTS (
        SELECT 1 FROM template_permissions 
        WHERE user_id = p_user_id 
        AND template_id = p_template_id 
        AND permission_type = p_permission_type
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Permission already exists';
    END IF;
    
    START TRANSACTION;
    
    INSERT INTO template_permissions (
        user_id, template_id, permission_type, granted_by, is_active
    ) VALUES (
        p_user_id, p_template_id, p_permission_type, p_granted_by, TRUE
    );
    
    SET v_permission_id = LAST_INSERT_ID();
    
    INSERT INTO audit_log (user_id, action, entity_type, entity_id, new_value)
    VALUES (p_granted_by, 'GrantTemplatePermission', 'Template', p_template_id,
            JSON_OBJECT('user_id', p_user_id, 'permission_type', p_permission_type));
    
    COMMIT;
    
    SELECT * FROM template_permissions WHERE permission_id = v_permission_id;
END$$

-- Update Template Permission (reactivate or change type)
DROP PROCEDURE IF EXISTS sp_update_template_permission$$
CREATE PROCEDURE sp_update_template_permission(
    IN p_permission_id INT,
    IN p_permission_type VARCHAR(20),
    IN p_is_active BOOLEAN,
    IN p_modified_by INT
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM template_permissions WHERE permission_id = p_permission_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Permission not found';
    END IF;
    
    START TRANSACTION;
    
    UPDATE template_permissions 
    SET 
        permission_type = p_permission_type,
        is_active = p_is_active
    WHERE permission_id = p_permission_id;
    
    INSERT INTO audit_log (user_id, action, entity_type)
    VALUES (p_modified_by, 'UpdateTemplatePermission', 'Template');
    
    COMMIT;
    
    SELECT * FROM template_permissions WHERE permission_id = p_permission_id;
END$$

-- Delete Template Permission (soft delete)
DROP PROCEDURE IF EXISTS sp_delete_template_permission$$
CREATE PROCEDURE sp_delete_template_permission(
    IN p_permission_id INT,
    IN p_deleted_by INT
)
BEGIN
    DECLARE v_user_id INT;
    DECLARE v_template_id INT;
    
    SELECT user_id, template_id INTO v_user_id, v_template_id
    FROM template_permissions WHERE permission_id = p_permission_id;
    
    IF v_user_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Permission not found';
    END IF;
    
    START TRANSACTION;
    
    UPDATE template_permissions 
    SET is_active = FALSE
    WHERE permission_id = p_permission_id;
    
    INSERT INTO audit_log (user_id, action, entity_type, entity_id, old_value)
    VALUES (p_deleted_by, 'RevokeTemplatePermission', 'Template', v_template_id,
            JSON_OBJECT('user_id', v_user_id));
    
    COMMIT;
    
    SELECT 'Permission revoked successfully' AS message;
END$$

-- Get Template Permission
DROP PROCEDURE IF EXISTS sp_get_template_permission$$
CREATE PROCEDURE sp_get_template_permission(
    IN p_permission_id INT
)
BEGIN
    SELECT 
        tp.*,
        u.display_name AS user_name,
        u.email AS user_email,
        t.template_name,
        t.entity_type,
        g.display_name AS granted_by_name
    FROM template_permissions tp
    INNER JOIN users u ON tp.user_id = u.user_id
    INNER JOIN templates t ON tp.template_id = t.template_id
    INNER JOIN users g ON tp.granted_by = g.user_id
    WHERE tp.permission_id = p_permission_id;
END$$

-- Get All Template Permissions
DROP PROCEDURE IF EXISTS sp_get_all_template_permissions$$
CREATE PROCEDURE sp_get_all_template_permissions(
    IN p_user_id INT,
    IN p_template_id INT,
    IN p_permission_type VARCHAR(20),
    IN p_is_active BOOLEAN,
    IN p_limit INT,
    IN p_offset INT
)
BEGIN
    SELECT 
        tp.*,
        u.display_name AS user_name,
        u.email AS user_email,
        t.template_name,
        t.entity_type,
        g.display_name AS granted_by_name
    FROM template_permissions tp
    INNER JOIN users u ON tp.user_id = u.user_id
    INNER JOIN templates t ON tp.template_id = t.template_id
    INNER JOIN users g ON tp.granted_by = g.user_id
    WHERE (p_user_id IS NULL OR tp.user_id = p_user_id)
    AND (p_template_id IS NULL OR tp.template_id = p_template_id)
    AND (p_permission_type IS NULL OR tp.permission_type = p_permission_type)
    AND (p_is_active IS NULL OR tp.is_active = p_is_active)
    ORDER BY tp.granted_at DESC
    LIMIT p_limit OFFSET p_offset;
    
    SELECT COUNT(*) AS total_count
    FROM template_permissions tp
    WHERE (p_user_id IS NULL OR tp.user_id = p_user_id)
    AND (p_template_id IS NULL OR tp.template_id = p_template_id)
    AND (p_permission_type IS NULL OR tp.permission_type = p_permission_type)
    AND (p_is_active IS NULL OR tp.is_active = p_is_active);
END$$

-- ============================================================================
-- JOBS PROCEDURES
-- ============================================================================

-- Create Job
DROP PROCEDURE IF EXISTS sp_create_job$$
CREATE PROCEDURE sp_create_job(
    IN p_template_id INT,
    IN p_submitted_by INT,
    IN p_file_name VARCHAR(255),
    IN p_file_size BIGINT,
    IN p_file_path VARCHAR(500),
    IN p_total_rows INT
)
BEGIN
    DECLARE v_job_id INT;
    DECLARE v_requires_approval BOOLEAN;
    
    -- Check if template requires approval
    SELECT requires_approval INTO v_requires_approval
    FROM templates WHERE template_id = p_template_id;
    
    START TRANSACTION;
    
    INSERT INTO jobs (
        template_id, submitted_by, file_name, file_size, file_path,
        status, total_rows
    ) VALUES (
        p_template_id, p_submitted_by, p_file_name, p_file_size, p_file_path,
        IF(v_requires_approval, 'AwaitingApproval', 'Pending'), p_total_rows
    );
    
    SET v_job_id = LAST_INSERT_ID();
    
    INSERT INTO audit_log (job_id, user_id, action, entity_type, entity_id, new_value)
    VALUES (v_job_id, p_submitted_by, 'UploadJob', 'System', v_job_id,
            JSON_OBJECT('file_name', p_file_name, 'total_rows', p_total_rows));
    
    COMMIT;
    
    SELECT * FROM jobs WHERE job_id = v_job_id;
END$$

-- Update Job
DROP PROCEDURE IF EXISTS sp_update_job$$
CREATE PROCEDURE sp_update_job(
    IN p_job_id INT,
    IN p_status VARCHAR(50),
    IN p_validation_errors JSON,
    IN p_processed_rows INT,
    IN p_error_message TEXT,
    IN p_modified_by INT
)
BEGIN
    DECLARE v_old_status VARCHAR(50);
    
    SELECT status INTO v_old_status FROM jobs WHERE job_id = p_job_id;
    
    IF v_old_status IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Job not found';
    END IF;
    
    START TRANSACTION;
    
    UPDATE jobs 
    SET 
        status = p_status,
        validation_errors = p_validation_errors,
        processed_rows = COALESCE(p_processed_rows, processed_rows),
        error_message = p_error_message,
        started_at = IF(p_status = 'Processing' AND started_at IS NULL, CURRENT_TIMESTAMP, started_at),
        completed_at = IF(p_status IN ('Completed', 'Failed', 'Cancelled'), CURRENT_TIMESTAMP, completed_at),
        updated_at = CURRENT_TIMESTAMP
    WHERE job_id = p_job_id;
    
    INSERT INTO audit_log (job_id, user_id, action, entity_type, entity_id, old_value, new_value)
    VALUES (p_job_id, p_modified_by, 'UpdateJobStatus', 'System', p_job_id,
            JSON_OBJECT('status', v_old_status),
            JSON_OBJECT('status', p_status, 'processed_rows', p_processed_rows));
    
    COMMIT;
    
    SELECT * FROM jobs WHERE job_id = p_job_id;
END$$

-- Approve Job
DROP PROCEDURE IF EXISTS sp_approve_job$$
CREATE PROCEDURE sp_approve_job(
    IN p_job_id INT,
    IN p_approved_by INT,
    IN p_comments VARCHAR(1000)
)
BEGIN
    DECLARE v_current_status VARCHAR(50);
    
    SELECT status INTO v_current_status FROM jobs WHERE job_id = p_job_id;
    
    IF v_current_status != 'AwaitingApproval' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Job is not awaiting approval';
    END IF;
    
    START TRANSACTION;
    
    UPDATE jobs 
    SET 
        status = 'Approved',
        approved_by = p_approved_by,
        approved_at = CURRENT_TIMESTAMP,
        approval_comments = p_comments,
        updated_at = CURRENT_TIMESTAMP
    WHERE job_id = p_job_id;
    
    -- Add comment
    IF p_comments IS NOT NULL THEN
        INSERT INTO job_comments (job_id, user_id, comment_text, comment_type)
        VALUES (p_job_id, p_approved_by, p_comments, 'Approval');
    END IF;
    
    INSERT INTO audit_log (job_id, user_id, action, entity_type, entity_id)
    VALUES (p_job_id, p_approved_by, 'ApproveJob', 'System', p_job_id);
    
    -- Create notification for submitter
    INSERT INTO notifications (user_id, job_id, notification_type, title, message)
    SELECT submitted_by, p_job_id, 'ApprovalGranted', 
           'Job Approved', 
           CONCAT('Your job #', p_job_id, ' has been approved')
    FROM jobs WHERE job_id = p_job_id;
    
    COMMIT;
    
    SELECT * FROM jobs WHERE job_id = p_job_id;
END$$

-- Reject Job
DROP PROCEDURE IF EXISTS sp_reject_job$$
CREATE PROCEDURE sp_reject_job(
    IN p_job_id INT,
    IN p_rejected_by INT,
    IN p_comments VARCHAR(1000)
)
BEGIN
    DECLARE v_current_status VARCHAR(50);
    
    SELECT status INTO v_current_status FROM jobs WHERE job_id = p_job_id;
    
    IF v_current_status != 'AwaitingApproval' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Job is not awaiting approval';
    END IF;
    
    IF p_comments IS NULL OR p_comments = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Rejection comments are required';
    END IF;
    
    START TRANSACTION;
    
    UPDATE jobs 
    SET 
        status = 'Rejected',
        approved_by = p_rejected_by,
        approved_at = CURRENT_TIMESTAMP,
        approval_comments = p_comments,
        updated_at = CURRENT_TIMESTAMP
    WHERE job_id = p_job_id;
    
    INSERT INTO job_comments (job_id, user_id, comment_text, comment_type)
    VALUES (p_job_id, p_rejected_by, p_comments, 'Rejection');
    
    INSERT INTO audit_log (job_id, user_id, action, entity_type, entity_id)
    VALUES (p_job_id, p_rejected_by, 'RejectJob', 'System', p_job_id);
    
    INSERT INTO notifications (user_id, job_id, notification_type, title, message)
    SELECT submitted_by, p_job_id, 'ApprovalRejected',
           'Job Rejected',
           CONCAT('Your job #', p_job_id, ' has been rejected. Reason: ', p_comments)
    FROM jobs WHERE job_id = p_job_id;
    
    COMMIT;
    
    SELECT * FROM jobs WHERE job_id = p_job_id;
END$$

-- Delete Job (soft cancel)
DROP PROCEDURE IF EXISTS sp_delete_job$$
CREATE PROCEDURE sp_delete_job(
    IN p_job_id INT,
    IN p_deleted_by INT
)
BEGIN
    DECLARE v_current_status VARCHAR(50);
    
    SELECT status INTO v_current_status FROM jobs WHERE job_id = p_job_id;
    
    IF v_current_status IN ('Processing', 'Completed') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete a job that is processing or completed';
    END IF;
    
    START TRANSACTION;
    
    UPDATE jobs 
    SET status = 'Cancelled', updated_at = CURRENT_TIMESTAMP
    WHERE job_id = p_job_id;
    
    INSERT INTO audit_log (job_id, user_id, action, entity_type, entity_id)
    VALUES (p_job_id, p_deleted_by, 'CancelJob', 'System', p_job_id);
    
    COMMIT;
    
    SELECT 'Job cancelled successfully' AS message;
END$$

-- Get Job
DROP PROCEDURE IF EXISTS sp_get_job$$
CREATE PROCEDURE sp_get_job(
    IN p_job_id INT
)
BEGIN
    SELECT 
        j.*,
        t.template_name,
        t.entity_type,
        t.requires_approval,
        u_submit.display_name AS submitted_by_name,
        u_submit.email AS submitted_by_email,
        u_approve.display_name AS approved_by_name,
        u_approve.email AS approved_by_email
    FROM jobs j
    INNER JOIN templates t ON j.template_id = t.template_id
    INNER JOIN users u_submit ON j.submitted_by = u_submit.user_id
    LEFT JOIN users u_approve ON j.approved_by = u_approve.user_id
    WHERE j.job_id = p_job_id;
    
    -- Also return comments
    SELECT 
        jc.*,
        u.display_name AS user_name
    FROM job_comments jc
    INNER JOIN users u ON jc.user_id = u.user_id
    WHERE jc.job_id = p_job_id
    ORDER BY jc.created_at ASC;
END$$

-- Get All Jobs
DROP PROCEDURE IF EXISTS sp_get_all_jobs$$
CREATE PROCEDURE sp_get_all_jobs(
    IN p_status VARCHAR(50),
    IN p_template_id INT,
    IN p_submitted_by INT,
    IN p_date_from DATETIME,
    IN p_date_to DATETIME,
    IN p_limit INT,
    IN p_offset INT
)
BEGIN
    SELECT 
        j.*,
        t.template_name,
        t.entity_type,
        u_submit.display_name AS submitted_by_name,
        u_approve.display_name AS approved_by_name
    FROM jobs j
    INNER JOIN templates t ON j.template_id = t.template_id
    INNER JOIN users u_submit ON j.submitted_by = u_submit.user_id
    LEFT JOIN users u_approve ON j.approved_by = u_approve.user_id
    WHERE (p_status IS NULL OR j.status = p_status)
    AND (p_template_id IS NULL OR j.template_id = p_template_id)
    AND (p_submitted_by IS NULL OR j.submitted_by = p_submitted_by)
    AND (p_date_from IS NULL OR j.created_at >= p_date_from)
    AND (p_date_to IS NULL OR j.created_at <= p_date_to)
    ORDER BY