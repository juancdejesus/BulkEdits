# 🧩 Mass Updates – Terminology Guide

## Overview
Standardized terminology for the **Mass Updates** application, ensuring consistent communication between business users, developers, and administrators.

---

## Core Terms

| Term | Definition |
|------|-------------|
| **Job** | A complete upload-and-update process initiated by the user. |
| **Batch** | The group of records processed together as part of a job. |
| **Validation** | The pre-check step that ensures data accuracy, permissions, and compliance before execution. |
| **Execution** | The automated process where validated records are updated in the target system. |
| **Rollback** | Automatic or manual undo of changes applied during an update job in case of errors or rejection. |
| **Audit Log** | The historical record of all user actions, file uploads, and data changes for traceability. |
| **Template** | A standardized CSV or Excel file structure used for uploading mass changes. |
| **Module** | The business entity being updated (e.g., Client, Vendor, Matter, Employee, etc.). |
| **Validation Result** | A detailed report showing which records passed or failed validation checks. |
| **Approval** | Optional review stage where designated users confirm updates before execution. |
| **Execution Queue** | The list of currently running or pending update jobs awaiting system processing. |
| **Status** | The state of a job (Draft, Validated, Pending Approval, Running, Completed, Failed). |
| **Error Report** | A downloadable file containing invalid or failed records with error messages. |
| **User Role** | The permission level defining access to upload, approve, or administer updates. |
| **Notification** | System alert (email or dashboard) sent when a job completes or fails. |

---

## Example Workflow
1. **Upload File** → User uploads a Mass Update template  
2. **Validation** → System checks data integrity and business rules  
3. **Preview** → User reviews valid records and confirms  
4. **Execution** → System performs batch updates  
5. **Audit Log** → System records all changes for traceability  

---

## Naming Consistency
Use these standardized terms in:
- Menu labels and UI text  
- Internal documentation  
- API responses and job metadata  
- Audit and validation reports  

---

**Version:** 1.0  
**Owner:** Data Governance Team  
**Last Updated:** November 2025
