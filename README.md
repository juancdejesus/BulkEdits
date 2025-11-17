# Mass Update Hub

A secure, centralized portal that enables authorized business users to submit file-based data update requests. The system validates data, executes approved changes in batch, and maintains full auditability to ensure compliance and operational safety.

## Overview

Mass Update Hub streamlines bulk data operations by reducing IT dependency, improving accuracy through pre-execution validation, and ensuring complete auditability for governance compliance.

## Target Users

- Operations team members
- Finance and administrative analysts
- Data stewards
- System administrators

## Key Features

### File Upload & Validation
- Upload CSV/XLSX files using standardized templates
- Automatic validation engine detects data issues (format, business rules, permissions)
- Preview validation results before execution

### Batch Execution
- Execute validated updates via SQL stored procedures
- Real-time job status tracking (Draft / Validated / Running / Completed / Failed)
- Error reporting with downloadable failed records

### Audit & Compliance
- Complete audit trail logging file uploads, user actions, and before/after values
- Role-based access control for upload, review, and execution
- Enterprise SSO authentication

### Dashboard & Monitoring
- Centralized dashboard for job status tracking
- Job history and audit log access
- Template library management

## Project Structure

```
BulkEdits/
├── Design/
│   ├── Multiple prompts/      # Multi-step UI workflow designs
│   │   ├── approval_queue/
│   │   ├── audit_&_reports_page/
│   │   ├── dashboard_home_page/
│   │   ├── job_history_page/
│   │   ├── job_status_tracking/
│   │   ├── review_&_submit_job/
│   │   ├── template_library/
│   │   ├── template_management_page_1/
│   │   ├── template_management_page_2/
│   │   ├── template_management_page_3/
│   │   ├── template_management_page_4/
│   │   ├── upload_data_file/
│   │   ├── user_management_page/
│   │   └── validation_results/
│   └── Single prompt/          # Single-page UI designs
│       ├── bulk_updater_dashboard/
│       ├── error_review/
│       ├── execution_confirmation/
│       ├── file_upload/
│       ├── job_approval_queue/
│       ├── job_history_&_audit_log/
│       ├── my_update_jobs_dashboard/
│       ├── task_selection_&_template_download/
│       └── validation_summary_(dry_run)/
├── MVP Requirements Document.md
├── Terminology.md
└── README.md
```

## Workflow

1. **Upload File** - User uploads a standardized template file (CSV/XLSX)
2. **Validation** - System validates data integrity, format, and business rules
3. **Preview** - User reviews validation results and valid records
4. **Confirm** - User confirms execution of validated records
5. **Execution** - System performs batch updates via stored procedures
6. **Audit** - System logs all changes and updates job status

## MVP Scope

### Included Features
- File upload (CSV/XLSX with standard templates)
- Validation engine (format, business rules, permissions)
- Preview and confirmation interface
- Batch execution via SQL stored procedures
- Complete audit trail
- Job status dashboard
- Error reporting and downloadable error files
- SSO authentication
- Role-based permissions

### Out of Scope (Future Phases)
- Multi-entity cascading updates
- UI-based manual bulk editing
- Complex data transformations
- Workflow approvals (optional later)
- Scheduled/recurring updates
- Record deletion or creation
- External API integration

## Key Terminology

| Term | Definition |
|------|------------|
| **Job** | A complete upload-and-update process initiated by the user |
| **Batch** | The group of records processed together as part of a job |
| **Validation** | Pre-check step ensuring data accuracy, permissions, and compliance |
| **Execution** | Automated process where validated records are updated |
| **Template** | Standardized CSV/Excel file structure for uploading mass changes |
| **Module** | Business entity being updated (e.g., Client, Vendor, Matter) |
| **Audit Log** | Historical record of all actions, uploads, and data changes |

For complete terminology reference, see [Terminology.md](Terminology.md).

## Documentation

- [MVP Requirements Document](MVP%20Requirements%20Document.md) - Detailed MVP specifications and requirements
- [Terminology Guide](Terminology.md) - Standardized terminology and naming conventions

## Design Assets

The `/Design` folder contains HTML prototypes and screenshots for all UI components:
- **Multiple prompts** - Multi-step workflow interfaces
- **Single prompt** - Single-page interfaces

Each design folder includes:
- `code.html` - HTML prototype
- `screen.png` - Visual mockup

## Version

**MVP v1.0**
Last Updated: November 2025
Owner: Data Governance / IT Engineering

## License

Internal use only - proprietary software
