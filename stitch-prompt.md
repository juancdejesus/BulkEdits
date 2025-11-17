# Google Stitch UI Design Prompts
## Self-Serve Data Update Portal - Screen Generation Guide

---

## 📋 Setup Instructions

Before starting, prepare the following context for each prompt:

**Design System Parameters:**
- Style: Modern, professional, enterprise SaaS
- Design System: Ant Design 5
- Color Palette: Primary (Blue #1677FF), Success (Green #52C41A), Error (Red #FF4D4F), Warning (Orange #FAAD14), Info (Blue #1677FF)
- Typography: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial
- Component Library: Ant Design 5 (antd)
- Layout: Left navigation sidebar + main content area, desktop-first (1920x1080 primary, tablet 768px, mobile 375px)
- Navigation: Fixed left sidebar (200px expanded, 64px collapsed, dark theme #001529)
- Border Radius: 8px (Ant Design 5 default)
- Shadows: Ant Design elevation system

---

## 🎨 Screen Generation Prompts

### Screen 1: Login Page

```
Design a modern login screen for an enterprise internal application called "Data Update Portal" using Ant Design 5.

Layout:
- Split screen design: Left 40% brand area, Right 60% login form
- Left side: Gradient background (blue #1677FF to dark blue #0958D9), display company logo at top, application name "Data Update Portal" in white, subtitle "Secure Bulk Data Management" below
- Right side: White background with centered login card

Login Card (Ant Design Card component):
- Header: "Sign In" in bold, large text (24px)
- Single button: Ant Design primary button "Sign in with Microsoft" - full width, large size, with Microsoft logo icon on left
- Below button: Small grey text (rgba(0, 0, 0, 0.45)) "Authorized users only. Your activity is monitored."
- Card shadow: box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.03), 0 1px 6px -1px rgba(0, 0, 0, 0.02)
- Clean spacing, 24px padding

Style: Professional, minimal, trustworthy, Ant Design 5 aesthetic
No input fields needed (SSO only)
Desktop view: 1920x1080
```

---

### Screen 2: Dashboard / Home Page

```
Design a dashboard home page for a data management portal used by law firm financial staff using Ant Design 5 with left navigation.

Layout Structure (Ant Design Layout):

Left Sidebar (Layout.Sider, fixed, dark theme):
- Width: 200px (collapsible to 64px)
- Background: #001529 (dark blue)
- Top section: Logo + "Data Update Portal" (white text, centered)
- Ant Design Menu mode="inline" theme="dark":
  * DashboardOutlined - "Dashboard" (active/selected, background #1677FF)
  * CloudUploadOutlined - "Upload"
  * FolderOutlined - "Jobs" (expandable with SubMenu)
    - "My Jobs"
    - "All Jobs" 
    - "Job History"
  * CheckSquareOutlined - "Approvals" (for approvers)
  * FileTextOutlined - "Templates"
  * SettingOutlined - "Settings"
  * QuestionCircleOutlined - "Help"
- Bottom: Collapse button (MenuFoldOutlined/MenuUnfoldOutlined)

Top Header Bar (Layout.Header, 56px height, white background):
- Left: Ant Design Breadcrumb "Home > Dashboard"
- Right: Ant Design Space with Badge (notification bell icon with count), QuestionCircle icon (help), Ant Design Dropdown (user profile avatar with name "John Smith", role tag "Global Submitter")

Main Content Area (Layout.Content, padding: 24px):
- Background: #F0F2F5
- Width: Remaining space (1720px on 1920px screen with 200px sidebar)

Content:
- Page title "Dashboard" (Typography.Title level={3})
- 4 Ant Design Statistic cards in a row (Ant Design Row/Col gutter={[24, 24]}, equal width):
  1. "My Active Jobs" - value "8", green trend arrow up, prefix icon
  2. "Pending Approval" - value "3", orange warning icon
  3. "Completed This Month" - value "45", blue success icon
  4. "Failed Jobs" - value "1", red error icon

- Below stats: Two columns (60/40 split using Ant Design Row/Col)
  
Left Column - "Recent Jobs" section (Ant Design Card):
- Ant Design Table with columns: Job ID, Template, Submitted, Status (Ant Design Tag), Actions
- 5 rows of sample data with status tags (Processing=blue, Completed=green, Failed=red, Pending Approval=orange)
- Action buttons: Ant Design Space with Eye icon (view), Download icon
- "View All Jobs" Ant Design Button (type="link") at bottom

Right Column - "Quick Actions" section (Ant Design Card):
- 3 large Ant Design Buttons (block, size="large", stacked with 16px gap):
  1. "Upload New File" - type="primary", CloudUploadOutlined icon
  2. "Download Templates" - type="default", DownloadOutlined icon
  3. "View Approval Queue" - style={{borderColor: '#FAAD14', color: '#FAAD14'}}, CheckSquareOutlined icon

Style: Clean, data-focused, Ant Design 5 aesthetic with dark left sidebar
Desktop view: 1920x1080
Sidebar collapsed state: Show only icons (64px width)
```

---

### Screen 3: Template Library Page

```
Design a template library/catalog page for downloading data update templates using Ant Design 5 with left navigation.

Layout Structure (Ant Design Layout):

Left Sidebar (Layout.Sider, same as Dashboard):
- Dark theme (#001529), 200px width
- Menu with "Templates" item active/selected (background #1677FF)
- Full navigation menu visible

Top Header Bar (Layout.Header, 56px height):
- Left: Ant Design Breadcrumb "Home > Templates"
- Right: User menu, notifications, help icons

Main Content Area (Layout.Content, padding: 24px):
- Page header "Template Library" (Typography.Title level={3})

Search and Filters:
- Ant Design Input.Search (size="large", full width) with FilterOutlined button on right
- Below search: Ant Design Space with filter Tags (checkable): All, Client Templates, Vendor Templates, Matter Templates, Requires Approval

Template Grid (Ant Design Row with Col span={8}, 3 columns, gutter={[24, 24]}):
- Each card is an Ant Design Card with hoverable effect
- Card contains:
  * Template icon (FileExcelOutlined, different color per entity type)
  * Template name (e.g., "Client Bulk Update v2.1") - bold, 16px
  * Ant Design Tag for entity type (Client/Vendor/Matter) - blue/green/purple
  * Ant Design Tag "Requires Approval" (warning color) if applicable
  * Description text (2 lines, color: rgba(0, 0, 0, 0.45))
  * Last updated date (small, grey text)
  * Card.Meta footer with two buttons: 
    - "Download Template" (Ant Design Button type="primary")
    - "View Guide" (Ant Design Button type="link")
  * LockOutlined icon in top-right corner for no-access templates (card with disabled state)

Show 6 template cards total:
1. Client Bulk Update - Active, blue tag, bordered
2. Vendor Registration - Active, green tag
3. Matter Update - Active, purple tag
4. Client Closure - Requires approval tag (warning), blue
5. Vendor Tax ID Update - Locked with disabled card state, greyed
6. Matter Billing Update - Active, purple tag

Style: Card-based, spacious, Ant Design 5 visual hierarchy with dark left sidebar
Desktop view: 1920x1080 (content area: ~1696px width with 200px sidebar + padding)
```

---

### Screen 4: File Upload Page

```
Design a file upload page for submitting bulk data updates using Ant Design 5 with left navigation.

Layout Structure (Ant Design Layout):

Left Sidebar (Layout.Sider, same as Dashboard):
- Dark theme (#001529), 200px width
- Menu with "Upload" item active/selected (background #1677FF)

Top Header Bar (Layout.Header, 56px height):
- Left: Ant Design Breadcrumb "Home > Upload"
- Right: User menu, notifications, help icons

Main Content Area (Layout.Content, padding: 24px):
- Page header "Upload Data File" (Typography.Title level={3})

Step Indicator (Ant Design Steps, horizontal, centered, max-width 900px):
- 4 steps: "Select Template" (status="finish"), "Upload File" (status="process"), "Validate" (status="wait"), "Submit" (status="wait")

Main Content Card (Ant Design Card, centered, max-width 900px):

Step 1 Result (Ant Design Alert, type="success", closable=false):
- CheckCircleOutlined icon + "Template Selected: Client Bulk Update v2.1"
- "Change" Ant Design Button type="link"

Step 2 (active):
- Ant Design Upload.Dragger component (large, 400px height)
- Center content: 
  * InboxOutlined icon (large, grey)
  * "Drag and drop your file here" heading
  * "or" divider
  * "Browse Files" text
  * Supported formats: ".xlsx, .xls, .csv (Max 10 MB)" - small grey text

Below dropzone - Ant Design Alert type="info":
- Title: "Tips"
- Content (bullet points):
  * "Ensure your file follows the template structure"
  * "All required fields must be filled"
  * "Download template guide for field descriptions"

Footer buttons (Ant Design Space):
- Left: "Cancel" (Button type="text")
- Right: "Back" (Button), "Next: Validate" (Button type="primary", disabled until file uploaded)

Show uploaded state variant using Ant Design Upload file list:
- File item displaying: filename "client_updates_nov2024.xlsx", size "2.3 MB", status="done" with CheckCircleOutlined, delete icon

Style: Clean, guided workflow, Ant Design 5 Upload component with dark left sidebar
Desktop view: 1920x1080 (content area: ~1696px width)
```

---

### Screen 5: Validation Results Page

```
Design a validation results page showing data quality checks after file upload using Ant Design 5 with left navigation.

Layout Structure (Ant Design Layout):

Left Sidebar (Layout.Sider, same as Dashboard):
- Dark theme (#001529), 200px width
- Menu with "Upload" item active/selected

Top Header Bar (Layout.Header, 56px height):
- Left: Ant Design Breadcrumb "Home > Upload > Validate"
- Right: User menu, notifications, help icons

Main Content Area (Layout.Content, padding: 24px):
- Page header "Validation Results" (Typography.Title level={3})

Step Indicator (Ant Design Steps, centered, max-width 900px): 
- Show step 3 "Validate" as status="process" (or "finish" if passed)

Validation Summary Card (Ant Design Card, max-width 900px):
- Split layout using Row/Col:
  * Left: Large status icon (CheckCircleOutlined if passed, WarningOutlined if errors, CloseCircleOutlined if failed)
  * Right: Ant Design Statistic components
    - "Total Rows: 150"
    - "Valid Rows: 147" (valueStyle={{ color: '#52C41A' }})
    - "Rows with Errors: 3" (valueStyle={{ color: '#FF4D4F' }})
- Ant Design Tag: "Validation Passed with Warnings" (color="warning") or "Validation Failed" (color="error") or "Validation Passed" (color="success")

Validation Categories (Ant Design Collapse, accordion=true, max-width 900px):

1. Panel 1 - "Schema Validation" - expandIconPosition="start"
   - Header with CheckCircleOutlined (green)
   - Content: "All columns present and correctly formatted"

2. Panel 2 (defaultActiveKey) - "Business Rules Validation" 
   - Header with WarningOutlined (orange) + Ant Design Badge count={3}
   - Content: Ant Design Table (size="small")
     * Columns: Row #, Field, Issue, Value
     * Sample rows with WarningOutlined icon:
       - Row 45, ClientCode, "Duplicate client code", "CLI-1234"
       - Row 78, Status, "Invalid status value", "Archived"
       - Row 92, ClientName, "Missing required field", "(empty)"
     * Each row has suggested fix in Ant Design Tooltip

3. Panel 3 - "Duplicate Check"
   - Header with CheckCircleOutlined (green)
   - Content: "No duplicates found within file"

Action Section (bottom):
- Ant Design Alert type="warning" (if errors): "You can fix errors in your file and re-upload, or proceed with only valid rows (147 rows will be processed)"
- Buttons (Ant Design Space):
  * Left: "Download Error Report" (Button icon={DownloadOutlined})
  * Right: "Re-upload File" (Button) | "Proceed with Valid Rows" (Button type="primary")

Style: Data table focused, Ant Design 5 Collapse component, clear error highlighting with dark left sidebar
Desktop view: 1920x1080 (content area: ~1696px width)
```

---

### Screen 6: Job Confirmation / Review Page

```
Design a job review and submission confirmation page using Ant Design 5 with left navigation.

Layout Structure (Ant Design Layout):

Left Sidebar (Layout.Sider, same as Dashboard):
- Dark theme (#001529), 200px width
- Menu with "Upload" item active/selected

Top Header Bar (Layout.Header, 56px height):
- Left: Ant Design Breadcrumb "Home > Upload > Review"
- Right: User menu, notifications, help icons

Main Content Area (Layout.Content, padding: 24px):
- Page header "Review & Submit" (Typography.Title level={3})

Step Indicator (Ant Design Steps, centered, max-width 900px): 
- Step 4 "Submit" status="process"

Review Summary Card (Ant Design Card, max-width 900px):

Section 1 - File Information (Ant Design Descriptions, size="small", bordered):
- Template: "Client Bulk Update v2.1" with FileExcelOutlined icon
- Uploaded File: "client_updates_nov2024.xlsx" (2.3 MB)
- Upload Date: "Nov 12, 2024 2:34 PM"

Section 2 - Validation Summary (Ant Design Descriptions):
- Total Rows to Process: 147 (use Statistic component)
- Validation Status: Tag color="success" "Passed"
- Rows Skipped: 3 (expandable with Collapse component showing detail)

Section 3 - Processing Details:
- Ant Design Alert type="warning" showIcon, with InfoCircleOutlined:
  * Message: "This template requires approval"
  * Description: "Your request will be routed to: Sarah Johnson (Approver). Expected approval time: 1 business day"
- Or if no approval: Alert type="info" "Updates will be processed immediately upon submission"

Section 4 - Impact Summary (Ant Design Card with grey background):
- Title: "Records to be Updated:"
- Ant Design List with icons:
  * EditOutlined - "145 Client records updated"
  * PlusCircleOutlined - "2 New client records created"
- Ant Design Alert type="warning" banner:
  * "This operation will modify 145 existing records. This action cannot be undone."

Comments Section:
- Ant Design Form.Item label="Comments for Approver (Optional)":
  * Input.TextArea placeholder="Explain the purpose of these updates..." rows={4}

Confirmation:
- Ant Design Checkbox: "I confirm that I have reviewed the data and it is accurate"

Footer Buttons (Ant Design Space, split across width):
- Left: Button type="text" "Cancel", Button "Back"
- Right: Button type="primary" size="large" "Submit Request" (disabled until checkbox checked)

Style: Thorough review layout, Ant Design Descriptions for key-value pairs, clear impact warning with dark left sidebar
Desktop view: 1920x1080 (content area: ~1696px width)
```

---

### Screen 7: Job Status / Tracking Page

```
Design a job status tracking page showing real-time progress using Ant Design 5 with left navigation.

Layout Structure (Ant Design Layout):

Left Sidebar (Layout.Sider, same as Dashboard):
- Dark theme (#001529), 200px width
- Menu with "Jobs" submenu expanded, "All Jobs" active/selected

Top Header Bar (Layout.Header, 56px height):
- Left: Ant Design Button icon={ArrowLeftOutlined} "Back" + Breadcrumb "Home > Jobs > #1247"
- Right: User menu, notifications, help icons

Main Content Area (Layout.Content, padding: 24px):
- Page header "Job #1247" (Typography.Title level={3})

Status Timeline (Ant Design Steps type="navigation", current={3}, max-width 1200px):
- Steps: Submitted > Validated > Awaiting Approval > Approved > Processing > Completed
- Current stage: "Processing" with LoadingOutlined icon
- Completed stages: status="finish" with CheckOutlined
- Future stages: status="wait"

Job Information Card (Ant Design Card):

Header:
- Large Ant Design Badge status="processing" text="Processing" with Spin indicator
- Ant Design Descriptions size="small" layout="horizontal":
  * Submitted by: Avatar + "John Smith" + timestamp "Nov 12, 2024 2:45 PM"

Details Grid (Ant Design Descriptions, column={2}, bordered):
- Template: "Client Bulk Update v2.1"
- File: "client_updates_nov2024.xlsx"
- Total Rows: 147
- Valid Rows: 147
- Approval: Avatar "Sarah Johnson" with Tag color="success" "Approved" + timestamp
- Started: "Nov 12, 2024 3:15 PM"
- Est. Completion: "Nov 12, 2024 3:20 PM"

Progress Section (Ant Design Card bordered={false}):
- Ant Design Progress percent={60} status="active" strokeColor="#1677FF"
- Typography.Text type="secondary": "Processing row 88 of 147"
- Ant Design Space: ClockCircleOutlined + "Last updated: 2 seconds ago" with SyncOutlined (spin)

Activity Log (Ant Design Timeline, mode="left"):
- Timeline.Item color="blue": "3:15 PM - Processing started"
- Timeline.Item color="green": "3:10 PM - Request approved by Sarah Johnson"
- Timeline.Item color="green": "2:50 PM - Validation completed successfully"
- Timeline.Item color="blue": "2:45 PM - File uploaded by John Smith"

Action Buttons (Ant Design Space, bottom right):
- Button icon={ReloadOutlined} "Refresh Status"
- Button type="text" danger "Cancel Job" (only if processing)
- Button type="primary" icon={DownloadOutlined} "Download Results" (only when completed)

Style: Real-time monitoring, Ant Design Progress and Timeline, clear status indication with dark left sidebar
Desktop view: 1920x1080 (content area: ~1696px width)
```

---

### Screen 8: Job History / List Page

```
Design a comprehensive job history page with advanced filtering using Ant Design 5 with left navigation.

Layout Structure (Ant Design Layout):

Left Sidebar (Layout.Sider, same as Dashboard):
- Dark theme (#001529), 200px width
- Menu with "Jobs" submenu expanded, "Job History" active/selected

Top Header Bar (Layout.Header, 56px height):
- Left: Ant Design Breadcrumb "Home > Jobs > History"
- Right: User menu, notifications, help icons

Main Content Area (Layout.Content, padding: 24px):
- Page header "Job History" (Typography.Title level={3})

Filter Bar (Ant Design Card bordered={false}, style={{marginBottom: 24}}):
- Ant Design Space wrap size="middle":
  * Input.Search placeholder="Search by job ID, filename, or user..." style={{width: 300}}
  * RangePicker (date range) with presets
  * Select mode="multiple" placeholder="Select templates" style={{width: 200}}
  * Ant Design Radio.Group buttonStyle="solid" (status filter):
    - All, Completed, Processing, Failed, Pending, Cancelled
- Right side (float right):
  * Button icon={ExportOutlined} "Export to Excel"
  * Button type="link" "Clear Filters"

Jobs Table (Ant Design Table, full width):

Columns:
1. Job ID (sorter: true, render with Typography.Link)
2. Template Name (render with FileExcelOutlined icon + Tag for entity type)
3. Submitted By (render with Avatar.Group + name)
4. Submitted Date (sorter: true, defaultSortOrder: 'descend')
5. Status (render with Ant Design Tag, colors: success/processing/error/warning/default)
6. Total Rows
7. Success/Failed (render as Statistic or "89/0")
8. Approver (render with Avatar or "N/A")
9. Actions (render Ant Design Space with Dropdown for more actions):
   - EyeOutlined - View
   - DownloadOutlined - Download
   - DeleteOutlined - Delete (if pending)

Sample Rows (10 visible with varied data):
- Use rowClassName for zebra striping
- Expandable rows (expandable prop) for additional details

Bottom:
- Ant Design Pagination: 
  * showSizeChanger
  * showTotal={(total) => `Total ${total} items`}
  * pageSizeOptions={[10, 20, 50, 100]}
  * defaultPageSize={10}

Side Statistics (Ant Design Card, position: fixed right sidebar - optional if space allows):
- Title: "Quick Stats"
- Ant Design Statistic.Group:
  * Statistic title="This Week" value={23} suffix="jobs"
  * Statistic title="Success Rate" value={94} suffix="%" valueStyle={{color: '#52C41A'}}
  * Statistic title="Avg. Processing Time" value={4.2} suffix="mins"

Style: Data-rich, Ant Design Table with powerful filtering, efficient sorting and pagination with dark left sidebar
Desktop view: 1920x1080 (content area: ~1696px width provides ample table space)
```

---

### Screen 9: Approval Queue Page (Approver View)

```
Design an approval queue page for approvers to review pending requests using Ant Design 5 with left navigation.

Layout Structure (Ant Design Layout):

Left Sidebar (Layout.Sider, same as Dashboard):
- Dark theme (#001529), 200px width
- Menu with "Approvals" item active/selected (background #1677FF)

Top Header Bar (Layout.Header, 56px height):
- Left: Ant Design Breadcrumb "Home > Approvals"
- Right: Ant Design Badge count={3} showZero={false} + "Pending Approvals" text, user menu, notifications, help icons

Main Content Area (Layout.Content, padding: 24px):
- Page header "Approval Queue" (Typography.Title level={3})

Filter Tabs (Ant Design Tabs):
- TabPane "Pending" key="1" tab={<Badge count={3}>Pending</Badge>}
- TabPane "Approved by Me" key="2" (45)
- TabPane "Rejected" key="3" (2)

Pending Requests (Ant Design Collapse accordion, expandIconPosition="end"):

Panel 1 (defaultActiveKey="1"):
- Header (Ant Design Space split across width):
  * Left: Typography.Title level={5} "Job #1244" + Tag "Standard" or Tag color="error" "Urgent"
  * Right: Typography.Text type="warning" "2 days ago" + Avatar "David Lee" + Tag "Template Submitter"

- Body (Ant Design Tabs size="small" within panel):
  * Tab 1 "Overview":
    - Ant Design Descriptions column={1} bordered size="small":
      * Template, File, Rows, Impact
    - Form.Item label="Requestor Comments":
      * Typography.Paragraph: "Updating billing addresses for Q4 relocations..."
  
  * Tab 2 "Validation Results":
    - Ant Design Result status="success" title="All validations passed"
    - List of validation metrics
  
  * Tab 3 "Data Preview":
    - Ant Design Table size="small" pagination={false} (first 5 rows)
    - Button type="link" "View Full Data"

- Footer (Ant Design Space split):
  * Form.Item label="Approval Comments":
    - Input.TextArea placeholder="Add comments (required for rejection)..." rows={2}
  * Action Buttons (Space):
    - Button danger icon={CloseOutlined} "Reject"
    - Button style={{borderColor: '#FAAD14', color: '#FAAD14'}} icon={EditOutlined} "Request Changes"
    - Button type="primary" size="large" icon={CheckOutlined} "Approve"

Panel 2 (collapsed - Ant Design Card.Meta in collapsed view):
- Summary: Job #1243, Amy White, Matter Update, 123 rows, 1 day ago
- Button type="link" to expand

Panel 3 (collapsed):
- Summary: Job #1242, John Smith, Vendor Update, 45 rows, 3 hours ago

Empty State (Ant Design Empty when no pending):
- Icon: CheckCircleOutlined (large, green)
- Description: Typography.Title level={4} "All caught up!" + Text type="secondary" "No pending approvals at this time"

Style: Action-focused, Ant Design Collapse with rich content, clear decision UI with dark left sidebar
Desktop view: 1920x1080 (content area: ~1696px width gives good space for approval details)
```

---

### Screen 10: Admin - User Management Page

```
Design an admin user management page for managing roles and permissions using Ant Design 5 with left navigation.

Layout Structure (Ant Design Layout):

Left Sidebar (Layout.Sider, same as Dashboard):
- Dark theme (#001529), 200px width
- Menu with "Admin" submenu expanded (SettingOutlined icon)
- "Users" item active/selected (background #1677FF)
- Other admin items visible: "Templates", "Audit Logs"

Top Header Bar (Layout.Header, 56px height):
- Left: Ant Design Breadcrumb "Home > Admin > Users"
- Right: User menu, notifications, help icons

Main Content Area (Layout.Content, padding: 24px):
- Page header "User Management" (Typography.Title level={3})

Action Bar (Ant Design Space split):
- Left: Input.Search placeholder="Search users by name or email..." style={{width: 400}}
- Right: 
  * Button icon={SyncOutlined} "Sync from Entra ID"
  * Button type="primary" icon={UserAddOutlined} "Invite User"

Users Table (Ant Design Table, full width):

Columns:
1. User (render with Avatar, name in bold, email below with Typography.Text type="secondary")
2. Global Role (render with Ant Design Select dropdown showing current role):
   - Options: Admin, Global Submitter, Global Approver, Template Submitter, Template Approver, Viewer
   - Color-coded Tag background
3. Template Permissions (render with Ant Design Tag.CheckableTag, clickable):
   - Shows count "5 Templates" + EllipsisOutlined
   - onClick opens Modal
4. Last Active (render with ClockCircleOutlined + relative time)
5. Status (render with Ant Design Switch checked={isActive})
6. Actions (render with Dropdown overlay={menu}):
   - EditOutlined "Edit"
   - MoreOutlined opens menu with more options

Sample Rows (8 visible):
1. John Smith avatar, john.smith@firm.com, Tag "Global Submitter", "12 Templates", "Today", Switch on
2. Sarah Johnson avatar, sarah.j@firm.com, Tag color="gold" "Global Approver", "All Templates", "2 hours ago", Switch on
3. David Lee avatar, david.lee@firm.com, Tag "Template Submitter", "3 Templates", "Yesterday", Switch on
4. Mary Jones avatar, mary.jones@firm.com, Tag color="red" "Admin", "All Templates", "Today", Switch on

Template Permissions Modal (when "5 Templates" clicked):
- Ant Design Modal title="Template Permissions - David Lee" width={800}
- Ant Design Transfer component:
  * dataSource: all templates
  * targetKeys: assigned template IDs
  * showSearch
  * render item with template icon and permission type Radio.Group (Submitter/Approver)
- Footer: Button type="primary" "Save Changes" | Button "Cancel"

Side Panel (Ant Design Affix offsetTop={80}, right side if space, or Card above table):
- Ant Design Menu mode="inline" (quick filters):
  * SubMenu "By Role": All, Admin, Submitters, Approvers, Viewers
  * SubMenu "By Status": All, Active, Inactive
  * SubMenu "By Access": All, Has Template Access, No Template Access

Bottom:
- Ant Design Pagination showTotal={(total) => `Showing ${start}-${end} of ${total} users`}

Style: Admin-focused, Ant Design Transfer for permissions, powerful inline editing with dark left sidebar
Desktop view: 1920x1080 (content area: ~1696px width provides excellent table space)
```

---

### Screen 11: Admin - Template Management Page

```
Design an admin template management page for configuring templates using Ant Design 5 with left navigation.

Layout Structure (Ant Design Layout):

Left Sidebar (Layout.Sider, same as Dashboard):
- Dark theme (#001529), 200px width
- Menu with "Admin" submenu expanded
- "Templates" item active/selected (background #1677FF)

Top Header Bar (Layout.Header, 56px height):
- Left: Ant Design Breadcrumb "Home > Admin > Templates"
- Right: User menu, notifications, help icons

Main Content Area (Layout.Content, padding: 24px):
- Page header "Template Management" (Typography.Title level={3})

Action Bar:
- Left: Button type="primary" size="large" icon={CloudUploadOutlined} "Upload New Template"
- Right: Ant Design Segmented options={['Grid', 'List']} (view toggle)

Templates Grid (Ant Design Row gutter={[24, 24]}, 3 columns with Col span={8}):

Each Template Card (Ant Design Card hoverable, actions array):
- Cover area (light background with large FileExcelOutlined centered)
- Badge.Ribbon text="Active" color="green" or text="Inactive" color="grey"

- Card.Meta:
  * Avatar: FileExcelOutlined with entity color
  * Title: "Client Bulk Update" + Tag "v2.1"
  * Description: Entity type Tag color="blue" "Client"

- Body (Ant Design Space direction="vertical" size="small"):
  * Settings (Form.Item style):
    - Space: "Requires Approval" + Switch checked
    - Space: "Active" + Switch checked
  
  * Metrics (Ant Design Descriptions size="small" colon={false}):
    - Total Uses: Typography.Text strong "1,247"
    - Active Users: Typography.Text strong "23"
    - Last Updated: "Nov 1, 2024"
  
  * User Assignment (Ant Design Space):
    - Avatar.Group maxCount={3} size="small" (user avatars)
    - Typography.Link "15 submitters" | "3 approvers"

- Actions (Card actions prop):
  * Button type="link" icon={EditOutlined} "Edit"
  * Button type="link" icon={TeamOutlined} "Manage Users"
  * Dropdown with more options

Show 6 template cards:
1. Client Bulk Update - Active, Requires Approval, Badge.Ribbon green
2. Vendor Registration - Active, No Approval
3. Matter Update - Active, Requires Approval
4. Client Closure - Active, Requires Approval
5. Vendor Tax Update - Inactive, Badge.Ribbon grey, Card with opacity: 0.6
6. Matter Billing - Active, No Approval

Manage Users Modal (when "Manage Users" clicked):
- Ant Design Modal title="Manage Template Access - Client Bulk Update v2.1" width={900}
- Ant Design Tabs:
  * TabPane "Submitters": 
    - Input.Search placeholder="Search users..."
    - Ant Design List with removable users
    - Button type="dashed" block icon={PlusOutlined} "Add Users"
  * TabPane "Approvers": Similar layout

Style: Configuration-focused, Ant Design Switch for toggles, visual card grid with metrics and dark left sidebar
Desktop view: 1920x1080 (content area: ~1696px width allows 3 comfortable columns)
```

---

### Screen 12: Audit Log / Reports Page

```
Design an audit log and reporting page for compliance tracking using Ant Design 5 with left navigation.

Layout Structure (Ant Design Layout):

Left Sidebar (Layout.Sider, same as Dashboard):
- Dark theme (#001529), 200px width
- Menu with "Admin" submenu expanded
- "Audit Logs" item active/selected (background #1677FF)

Top Header Bar (Layout.Header, 56px height):
- Left: Ant Design Breadcrumb "Home > Admin > Audit"
- Right: User menu, notifications, help icons

Main Content Area (Layout.Content, padding: 24px):
- Page header "Audit & Reports" (Typography.Title level={3})

Tab Navigation (Ant Design Tabs type="card"):
- TabPane "Audit Logs" key="1"
- TabPane "Data Changes" key="2"
- TabPane "System Reports" key="3"

Audit Logs Tab:

Advanced Filter Panel (Ant Design Collapse, defaultActiveKey="filters"):
- Panel "Advanced Filters":
  * Ant Design Form layout="inline":
    - Form.Item "Date Range": RangePicker with presets (Today, Last 7 Days, Last 30 Days, Custom)
    - Form.Item "Action Type": Select mode="multiple" (Upload, Validate, Approve, Reject, Execute, Delete)
    - Form.Item "User": Select showSearch filterOption
    - Form.Item "Entity Type": Radio.Group buttonStyle="solid" (Client, Vendor, Matter, All)
    - Form.Item "Job ID": Input
  * Space: Button type="primary" icon={SearchOutlined} "Apply Filters" | Button "Reset"

Audit Table (Ant Design Table size="middle" scroll={{x: 1500}}, full width):

Columns:
1. Timestamp (sorter, defaultSortOrder: 'descend', render with ClockCircleOutlined)
2. User (render with Avatar + name)
3. Action (render with Tag, colors by action type)
4. Entity Type (render with Tag)
5. Job ID (render with Typography.Link)
6. Details (render with Button type="link" icon={ExpandOutlined} for expandable row)
7. IP Address (monospace font)
8. Status (render with CheckCircleOutlined success or CloseCircleOutlined error)

Expandable Rows (Table expandable prop):
- Ant Design Descriptions bordered size="small" column={1}:
  * Full action description with all parameters
  * Before/After values if applicable
  * Stack trace if error

Sample Rows:
1. Nov 12 3:15:42 PM | John Smith avatar | Tag "Execute" | Tag "Client" | #1247 link | expand | 192.168.1.50 | success
2. Nov 12 3:10:18 PM | Sarah Johnson avatar | Tag color="green" "Approve" | Tag "Client" | #1244 link | expand | 192.168.1.45 | success

Right Side Panel (Ant Design Card position: sticky or Affix offsetTop={80}):
- Title: "Export Options"
- Form:
  * Form.Item "Date Range": RangePicker
  * Form.Item "Format": Radio.Group (CSV, Excel, PDF)
  * Button type="primary" block icon={ExportOutlined} "Generate Report"
  
- Divider
- Ant Design Statistic.Group:
  * Statistic title="Total Actions Today" value={156} prefix={ThunderboltOutlined}
  * Statistic title="Unique Users" value={12} prefix={UserOutlined}
  * Statistic title="Failed Actions" value={2} valueStyle={{color: '#FF4D4F'}} prefix={CloseCircleOutlined}

Bottom:
- Ant Design Pagination with showSizeChanger
- Or infinite scroll with List.Item and VirtualList for performance

Data Changes Tab (not fully expanded):
- Similar Ant Design Table showing: Timestamp, Job ID, Entity Type, Entity ID, Field, Old Value → New Value (with Ant Design Segmented or Typography.Text delete/mark), Changed By

Style: Compliance-focused, Ant Design Table with expandable rows, detailed filtering with dark left sidebar
Desktop view: 1920x1080 (content area: ~1696px width provides excellent space for wide audit tables)
```

---

### Screen 13: User Profile / Settings Page

```
Design a user profile and settings page using Ant Design 5 with left navigation.

Layout Structure (Ant Design Layout):

Left Sidebar (Layout.Sider, same as Dashboard):
- Dark theme (#001529), 200px width
- Menu with "Settings" item active/selected (background #1677FF)

Top Header Bar (Layout.Header, 56px height):
- Left: Ant Design Breadcrumb "Home > Profile"
- Right: User menu, notifications, help icons

Main Content Area (Layout.Content, padding: 24px):
- Page header "My Profile" (Typography.Title level={3})

Layout: Ant Design Row gutter={24} (60/40 split using Col span)

Left Column (Col span={15}):

Profile Card (Ant Design Card):
- Ant Design Upload component for avatar (circular, with hover overlay "Change Photo")
- Ant Design Form layout="vertical":
  * Form.Item label="Display Name": Input value="John Smith"
  * Form.Item label="Email": Input value="john.smith@firm.com" disabled (with Tag "Entra ID")
  * Form.Item label="Department": Select options (Financial Systems Team selected)
  * Typography.Text type="secondary" "Role: " + Tag color="blue" "Global Submitter" (read-only)

My Permissions Card (Ant Design Card):
- Ant Design Collapse accordion ghost:
  * Panel "Template Access" extra={Typography.Link "View All"}:
    - Typography.Text type="secondary" "You have access to 12 templates"
    - When expanded: Ant Design List with template items, each with Tag showing permission type
  * Panel "System Permissions":
    - Ant Design List split={false}:
      * List.Item prefix={CheckCircleOutlined color green} "Upload files"
      * List.Item prefix={CheckCircleOutlined color green} "View own jobs"
      * List.Item prefix={MinusCircleOutlined color grey} disabled "Approve requests"
      * List.Item prefix={MinusCircleOutlined color grey} disabled "Manage users"

Activity Summary Card (Ant Design Card title="Your Activity (Last 30 Days)"):
- Ant Design Statistic.Group direction="horizontal":
  * Statistic title="Jobs Submitted" value={23} prefix={FileAddOutlined}
  * Statistic title="Success Rate" value={96} suffix="%" valueStyle={{color: '#52C41A'}}
- Typography.Text type="secondary" "Most Used: Client Bulk Update"

Right Column (Col span={9}):

Preferences Card (Ant Design Card title="Preferences"):
- Ant Design Form layout="vertical":
  
  * Divider "Email Notifications"
  * Form.Item: Checkbox.Group vertical:
    - ☑ Job completion notifications
    - ☑ Approval status updates
    - ☑ Validation errors
    - ☐ Weekly summary email
    - ☐ System announcements

  * Divider "Display Settings"
  * Form.Item label="Theme": Radio.Group buttonStyle="solid" (Light, Dark, Auto)
  * Form.Item label="Date Format": Select (MM/DD/YYYY selected)
  * Form.Item label="Timezone": Select showSearch ((EST) Eastern Time)
  * Form.Item label="Rows per page": InputNumber min={10} max={100} value={10}

  * Divider "Security"
  * Ant Design Descriptions size="small" column={1}:
    - Session timeout: "30 minutes" with Tag "Managed"
    - Two-factor auth: Typography.Link "Managed by Microsoft" with LinkOutlined
    - Active sessions: Typography.Link "1 active session" with EyeOutlined

Recent Activity Card (Ant Design Card title="Recent Activity"):
- Ant Design Timeline mode="left" size="small":
  * Timeline.Item label="2 hours ago": "Uploaded client_updates.xlsx"
  * Timeline.Item label="Yesterday": "Downloaded Client Update template"
  * Timeline.Item label="2 days ago": "Approved by Sarah Johnson for job #1240"
  * Typography.Link "View full history"

Footer:
- Button type="primary" size="large" block "Save Changes"

Style: Personal, Ant Design Form with rich preferences, Timeline for activity with dark left sidebar
Desktop view: 1920x1080 (content area: ~1696px width provides comfortable two-column layout)
```

---

### Screen 14: Error / Failed Job Detail Page

```
Design a detailed error page for a failed job with troubleshooting information using Ant Design 5 with left navigation.

Layout Structure (Ant Design Layout):

Left Sidebar (Layout.Sider, same as Dashboard):
- Dark theme (#001529), 200px width
- Menu with "Jobs" submenu expanded, "All Jobs" active/selected

Top Header Bar (Layout.Header, 56px height):
- Left: Ant Design Breadcrumb "Home > Jobs > #1245"
- Right: User menu, notifications, help icons
- Below breadcrumb: Ant Design Alert type="error" banner showIcon message="This job failed during processing"

Main Content Area (Layout.Content, padding: 24px):
- Page header "Job #1245 - Failed" (Typography.Title level={3}, red color)

Status Timeline (Ant Design Steps):
- Shows: Submitted (finish) > Validated (finish) > Approved (finish) > Processing (error) > Completed (wait)
- Processing step with CloseCircleOutlined icon and status="error"

Job Information (Ant Design Descriptions, same as status page but with error emphasis)

Error Summary Card (Ant Design Card bordered style={{borderColor: '#FF4D4F'}}, max-width 1200px):
- Ant Design Result status="error" icon={<CloseCircleOutlined style={{fontSize: 72}}/>}:
  * Title: "Processing Failed"
  * SubTitle: Tag color="error" "Database Error" + " | " + "Nov 11, 2024 4:23 PM"
  * Extra: 
    - Typography.Text code copyable "ERR_DB_1045"

Error Details Section (Ant Design Collapse bordered={false}):
- Panel "Technical Details" extra={Typography.Link copyable}:
  * Ant Design Typography.Paragraph code:
    ```
    SQL Exception: Foreign key constraint violation
    Stored Procedure: erp.UpdateClient
    Failed at row: 127
    Field: ClientCode 'CLI-9999' references non-existent parent record
    ```
- Ant Design Alert type="info" showIcon:
  * Message: "User-Friendly Explanation"
  * Description: "One or more records reference data that doesn't exist in the system. Please verify your data and try again."

Failed Rows Section (Ant Design Card title="Failed Rows"):
- Ant Design Table size="small" pagination={pageSize: 5}:
  * Columns: Row #, Field, Value (Typography.Text code), Error Reason (with Tooltip for details)
  * Row 127: WarningOutlined | ClientCode | CLI-9999 | "Client code not found"
  * Row 134: WarningOutlined | Status | "Terminated" | "Invalid status value"
  * Row 201: WarningOutlined | ClientName | [empty] | "Required field missing"
- Button icon={DownloadOutlined} "Download Failed Rows (CSV)"

Impact Section (Ant Design Card):
- Ant Design Alert type="info" showIcon (if partial success):
  * Message: "Partial Success"
  * Description: 
    - Statistic title="Successfully processed" value={126} prefix={CheckCircleOutlined}
    - Statistic title="Failed" value={108} prefix={CloseCircleOutlined}
    - Typography.Text type="warning" "Note: All changes have been rolled back to maintain data integrity"

Recommended Actions Card (Ant Design Card title="Next Steps"):
- Ant Design Steps direction="vertical" size="small" current={0}:
  * Step title="Download the error report below"
  * Step title="Fix the errors in your original file"
  * Step title="Re-upload using the button below"
- Divider
- Typography.Text type="secondary" "Need help? Contact support: " + Typography.Link "support@firm.com"

Action Buttons (Ant Design Space size="large"):
- Left: Button size="large" icon={DownloadOutlined} "Download Error Report"
- Right: Button type="primary" size="large" icon={CloudUploadOutlined} "Re-upload Corrected File"

Activity Log (Ant Design Timeline): Shows full timeline including error occurrence with error items in red

Style: Helpful error handling, Ant Design Result component, clear next steps, non-blaming tone with dark left sidebar
Desktop view: 1920x1080 (content area: ~1696px width provides good space for error details)
```

---

### Screen 15: Help / Documentation Page

```
Design a help center and documentation page using Ant Design 5 with left navigation.

Layout Structure (Ant Design Layout):

Left Sidebar (Layout.Sider, same as Dashboard):
- Dark theme (#001529), 200px width
- Menu with "Help" item active/selected (background #1677FF)

Top Header Bar (Layout.Header, 56px height):
- Left: Ant Design Breadcrumb "Home > Help"
- Right: User menu, notifications, help icons

Main Content Area (Layout.Content, padding: 24px):
- Page header "Help Center" (Typography.Title level={3})

Hero Search (centered, max-width 800px):
- Ant Design Input.Search size="large" placeholder="How can we help you?" enterButton={<SearchOutlined/>}
- Below: Ant Design Space wrap (popular searches):
  * Tag color="blue" "How to upload"
  * Tag "Template guide"
  * Tag "Approval process"
  * Tag "Error codes"

Content Layout (Ant Design Row gutter={[24, 24]}, 3 equal columns):

Column 1 - Getting Started (Ant Design Card hoverable):
- Card.Meta avatar={<ReadOutlined style={{fontSize: 32}}/>} title="Quick Start Guide"
- Ant Design List itemLayout="horizontal" split={false}:
  * List.Item: Typography.Link icon={RightOutlined} "Your first upload"
  * List.Item: Typography.Link "Understanding templates"
  * List.Item: Typography.Link "How approval works"
  * List.Item: Typography.Link "Troubleshooting common errors"

Column 2 - Video Tutorials (Ant Design Card hoverable):
- Card.Meta avatar={<PlayCircleOutlined style={{fontSize: 32}}/>} title="Video Guides"
- Ant Design List itemLayout="horizontal":
  * List.Item with thumbnail image: 
    - List.Item.Meta title="How to Upload Files" description="3:24" avatar={video thumbnail}
  * Similar items for other videos
  * Typography.Link "View all tutorials"

Column 3 - Resources (Ant Design Card hoverable):
- Card.Meta avatar={<FileTextOutlined style={{fontSize: 32}}/>} title="Documentation"
- Ant Design List:
  * List.Item: Button type="link" icon={FilePdfOutlined} "Template field reference"
  * List.Item: Button type="link" icon={FilePdfOutlined} "Business rules guide"
  * List.Item: Typography.Link icon={LinkOutlined} "API documentation"
  * List.Item: Typography.Link "FAQ"

Below: FAQs Section (Ant Design Collapse accordion expandIconPosition="end", max-width 1200px):

1. Panel "What file formats are supported?" defaultActiveKey:
   - Typography.Paragraph: "We support Excel (.xlsx, .xls) and CSV files up to 10 MB in size..."

2. Panel "How long does approval take?":
   - Typography.Paragraph: "Approval requests are typically reviewed within 1 business day..."

3. Panel "What happens if my job fails?":
   - Typography.Paragraph: "If validation or processing fails, you'll receive a detailed error report..."

4. Panel "Can I cancel a job in progress?":
   - Typography.Paragraph: "Jobs can be cancelled while they're pending approval or in validation..."

5. Panel "Who do I contact for support?":
   - Contact information with icons

Right Sidebar (Col span={6}, Ant Design Affix offsetTop={80}):
- Contact Support Card (Ant Design Card):
  * Ant Design Descriptions column={1} colon={false}:
    - Email: Typography.Link "support@firm.com" with MailOutlined
    - Phone: Typography.Text "x5555" with PhoneOutlined
    - Hours: "M-F 9am-5pm EST" with ClockCircleOutlined
  * Button type="primary" block icon={CustomerServiceOutlined} "Submit a ticket"

- System Status Card (Ant Design Card):
  * Badge status="success" text="All systems operational"
  * Typography.Text type="secondary" size="small" "Last updated: 2 mins ago"
  * Typography.Link "View status page" with LinkOutlined

Style: Helpful, searchable, Ant Design Card grid, self-service focused with prominent FAQs and dark left sidebar
Desktop view: 1920x1080 (content area: ~1696px width provides comfortable three-column layout)
```

```
Design a job review and submission confirmation page.

Top: Page header "Review & Submit" with breadcrumb (Home > Upload > Review)

Step Indicator: Step 4 "Submit" active

Review Summary Card:

Section 1 - File Information:
- Template: "Client Bulk Update v2.1" with small template icon
- Uploaded File: "client_updates_nov2024.xlsx" (2.3 MB)
- Upload Date: "Nov 12, 2024 2:34 PM"

Section 2 - Validation Summary:
- Total Rows to Process: 147
- Validation Status: Green badge "Passed"
- Rows Skipped: 3 (with expandable detail)

Section 3 - Processing Details:
- Alert box (orange/info): "This template requires approval"
  * "Your request will be routed to: Sarah Johnson (Approver)"
  * "Expected approval time: 1 business day"
- Or if no approval needed: "Updates will be processed immediately upon submission"

Section 4 - Impact Summary:
- "Records to be Updated:" with icon breakdown:
  * 145 Client records updated
  * 2 New client records created
- Warning (if major): "This operation will modify 145 existing records. This action cannot be undone."

Comments Section:
- Text area: "Add comments for approver (optional)"
- Placeholder: "Explain the purpose of these updates..."

Confirmation Checkbox:
- "☐ I confirm that I have reviewed the data and it is accurate"

Footer Buttons:
- Left: "Cancel" (text), "Back" (outlined)
- Right: "Submit Request" (blue, large, disabled until checkbox checked)

Style: Thorough review layout, clear impact warning, progressive disclosure
Desktop view: 1920x1080
```

---

### Screen 7: Job Status / Tracking Page

```
Design a job status tracking page showing real-time progress.

Top: Page header with job ID "Job #1247" and back button, breadcrumb (Home > Jobs > #1247)

Status Timeline (horizontal):
- Visual timeline showing: Submitted > Validated > Awaiting Approval > Approved > Processing > Completed
- Current stage highlighted in blue with pulse animation
- Completed stages: green checkmarks
- Current: "Processing" stage with spinner icon
- Future stages: grey

Job Information Card:

Header:
- Large status badge: "Processing" (blue, with spinner)
- Submitted by: User avatar + "John Smith" + timestamp "Nov 12, 2024 2:45 PM"

Details Grid (2 columns):
- Template: "Client Bulk Update v2.1"
- File: "client_updates_nov2024.xlsx"
- Total Rows: 147
- Valid Rows: 147
- Approval: "Approved by Sarah Johnson" with timestamp and green checkmark
- Started: "Nov 12, 2024 3:15 PM"
- Est. Completion: "Nov 12, 2024 3:20 PM"

Progress Section:
- Progress bar (visual): 60% complete (blue)
- Text: "Processing row 88 of 147"
- Live update indicator: "Last updated: 2 seconds ago" with refresh icon

Activity Log (scrollable):
- Timeline style list:
  * "3:15 PM - Processing started"
  * "3:10 PM - Request approved by Sarah Johnson"
  * "2:50 PM - Validation completed successfully"
  * "2:45 PM - File uploaded by John Smith"

Action Buttons (bottom right):
- "Refresh Status" (outlined with refresh icon)
- "Cancel Job" (text, red) - only if still processing
- "Download Results" (blue) - only when completed

Style: Real-time monitoring, clear progress indication, timeline-focused
Desktop view: 1920x1080
```

---

### Screen 8: Job History / List Page

```
Design a comprehensive job history page with advanced filtering.

Top: Page header "Job History" with breadcrumb (Home > Jobs)

Filter Bar (sticky):
- Left side:
  * Search box: "Search by job ID, filename, or user..."
  * Date range picker: "Last 30 Days" dropdown
  * Template filter: Multi-select dropdown "All Templates"
  * Status filter: Chips (All, Completed, Processing, Failed, Pending, Cancelled)
- Right side:
  * "Export to Excel" button (outlined)
  * "Clear Filters" text button

Jobs Table (data grid):

Columns:
1. Job ID (sortable, clickable)
2. Template Name with icon
3. Submitted By (user avatar + name)
4. Submitted Date (sortable)
5. Status (colored badge: green/blue/red/orange/grey)
6. Total Rows
7. Success/Failed counts
8. Approver (if applicable)
9. Actions (icon buttons: view, download, delete if pending)

Sample Rows (10 visible):
1. #1247, Client Update, John Smith, Nov 12 2024, Processing (blue), 147, -, Sarah Johnson, [actions]
2. #1246, Vendor Tax ID, Mary Jones, Nov 11 2024, Completed (green), 89, 89/0, N/A, [actions]
3. #1245, Matter Update, John Smith, Nov 11 2024, Failed (red), 234, 180/54, N/A, [actions]
4. #1244, Client Update, David Lee, Nov 10 2024, Pending Approval (orange), 67, -, Sarah Johnson, [actions]
5. Continue with varied data...

Bottom:
- Pagination: "Showing 1-10 of 247" with page numbers and next/prev buttons
- Rows per page selector: "10 per page" dropdown

Side Note Panel (right, collapsible):
- "Quick Stats" widget
  * This Week: 23 jobs
  * Success Rate: 94%
  * Avg. Processing Time: 4.2 mins

Style: Data-rich, enterprise table, efficient filtering
Desktop view: 1920x1080
```

---

### Screen 9: Approval Queue Page (Approver View)

```
Design an approval queue page for approvers to review pending requests.

Top: Page header "Approval Queue" with breadcrumb (Home > Approvals)
- Right side: Badge showing "3 Pending Approvals"

Filter Tabs:
- "Pending" (3) - active, blue underline
- "Approved by Me" (45)
- "Rejected" (2)

Pending Requests (card-based layout):

Card 1 (expanded):
- Header:
  * Job ID: "#1244" (large)
  * Priority badge: "Standard" (grey) or "Urgent" (red)
  * Days waiting: "2 days ago" in orange
  * Submitted by: User avatar + "David Lee" + role badge "Template Submitter"

- Body (tabbed):
  * Tab 1 "Overview" - active:
    - Template: Client Bulk Update v2.1
    - File: client_updates_nov2024.xlsx
    - Rows: 67 records
    - Impact: "67 client records will be updated"
    - Requestor Comments: Text display "Updating billing addresses for Q4 relocations..."
  
  * Tab 2 "Validation Results":
    - Green badge: "All validations passed"
    - Summary metrics display
  
  * Tab 3 "Data Preview":
    - First 5 rows of data in table format
    - "View Full Data" link

- Footer:
  * Approval Comments: Text area "Add comments (required for rejection)..."
  * Action Buttons:
    - "Reject" (red, outlined, with X icon)
    - "Request Changes" (orange, outlined)
    - "Approve" (green, large, primary, with checkmark icon)

Card 2 (collapsed):
- Summary view: Job #1243, Amy White, Matter Update, 123 rows, 1 day ago
- "Expand" button

Card 3 (collapsed):
- Summary view: Job #1242, John Smith, Vendor Update, 45 rows, 3 hours ago
- "Expand" button

Empty State (if no pending):
- Large checkmark icon (grey)
- "All caught up!" heading
- "No pending approvals at this time"

Style: Action-focused, clear decision making, expandable details
Desktop view: 1920x1080
```

---

### Screen 10: Admin - User Management Page

```
Design an admin user management page for managing roles and permissions.

Top: Page header "User Management" with breadcrumb (Home > Admin > Users)

Action Bar:
- Search: "Search users by name or email..."
- Right side: 
  * "Sync from Entra ID" button (outlined, refresh icon)
  * "Invite User" button (blue, primary)

Users Table:

Columns:
1. User (avatar + name + email below in small text)
2. Global Role (dropdown badge: Admin/Global Submitter/Global Approver/Template Submitter/Template Approver/Viewer)
3. Template Permissions (pill badges showing count: "5 Templates" - clickable)
4. Last Active (date)
5. Status (Active/Inactive toggle switch)
6. Actions (edit icon, more menu icon)

Sample Rows (8 visible):
1. John Smith, john.smith@firm.com, Global Submitter, 12 Templates, Today, Active, [actions]
2. Sarah Johnson, sarah.j@firm.com, Global Approver, All Templates, 2 hours ago, Active, [actions]
3. David Lee, david.lee@firm.com, Template Submitter, 3 Templates, Yesterday, Active, [actions]
4. Mary Jones, mary.jones@firm.com, Admin, All Templates, Today, Active, [actions]

When "5 Templates" clicked - Modal opens:
- Title: "Template Permissions - David Lee"
- Two columns:
  * Left: "Assigned Templates" (list with permission type badges)
    - Client Update v2.1 - Submitter badge
    - Vendor Tax ID - Submitter badge  
    - Matter Update - Approver badge
  * Right: "Available Templates" (list with + icons)
    - Client Closure + Add button
    - Vendor Registration + Add button
- Footer: "Save Changes" (blue) | "Cancel"

Side Panel (right):
- Quick filters:
  * By Role: All, Admin, Submitters, Approvers, Viewers
  * By Status: All, Active, Inactive
  * By Access: All, Has Template Access, No Template Access

Bottom:
- Pagination: Showing 1-8 of 34 users

Style: Admin-focused, bulk action capable, clear permission management
Desktop view: 1920x1080
```

---

### Screen 11: Admin - Template Management Page

```
Design an admin template management page for configuring templates.

Top: Page header "Template Management" with breadcrumb (Home > Admin > Templates)

Action Bar:
- Left: "Upload New Template" button (blue, primary, upload icon)
- Right: View toggle (grid/list icons)

Templates Grid (card view):

Each Template Card (larger than template library):
- Header:
  * Template icon (Excel, colored by type)
  * Status indicator dot (green=active, grey=inactive)
  * More menu icon (3 dots)

- Body:
  * Template Name: "Client Bulk Update" (large, bold)
  * Version: "v2.1" (badge)
  * Entity Type: "Client" (blue badge)
  * Settings:
    - "Requires Approval" toggle switch (on/off)
    - "Active" toggle switch (on/off)

- Metrics (small, grey text):
  * Total Uses: 1,247
  * Active Users: 23
  * Last Updated: Nov 1, 2024

- User Assignment:
  * Submitters: "15 users" (clickable)
  * Approvers: "3 users" (clickable)
  * Quick visual: Small avatar stack (first 3 users)

- Footer actions:
  * "Edit Details" (text button)
  * "Manage Users" (text button)
  * "Download" (icon button)
  * "View History" (icon button)

Show 6 template cards in 2x3 grid:
1. Client Bulk Update - Active, Requires Approval
2. Vendor Registration - Active, No Approval
3. Matter Update - Active, Requires Approval
4. Client Closure - Active, Requires Approval
5. Vendor Tax Update - Inactive, No Approval
6. Matter Billing - Active, No Approval

When "Manage Users" clicked - Modal:
- Title: "Manage Template Access - Client Bulk Update v2.1"
- Two tabs: "Submitters" | "Approvers"
- Each tab shows:
  * Search bar: "Search users..."
  * Assigned users list (removable)
  * "+ Add Users" button opens user picker

Style: Configuration-focused, visual toggles, at-a-glance metrics
Desktop view: 1920x1080
```

---

### Screen 12: Audit Log / Reports Page

```
Design an audit log and reporting page for compliance tracking.

Top: Page header "Audit & Reports" with breadcrumb (Home > Admin > Audit)

Tab Navigation:
- "Audit Logs" (active)
- "Data Changes"
- "System Reports"

Audit Logs Tab:

Advanced Filter Panel (collapsible):
- Date Range: Start/End date pickers with presets (Today, Last 7 Days, Last 30 Days, Custom)
- Action Type: Multi-select chips (Upload, Validate, Approve, Reject, Execute, Delete)
- User: Searchable dropdown
- Entity Type: Client, Vendor, Matter, All
- Job ID: Text input
- "Apply Filters" button (blue) | "Reset" (text)

Audit Table (detailed):

Columns:
1. Timestamp (sortable, precise to seconds)
2. User (avatar + name)
3. Action (colored badge)
4. Entity Type
5. Job ID (clickable link)
6. Details (expandable)
7. IP Address
8. Status (success/failed icon)

Sample Rows (expandable):
1. Nov 12, 2024 3:15:42 PM | John Smith | Execute | Client | #1247 | [+] | 192.168.1.50 | ✓
   - When expanded: "Executed bulk update on 147 client records via stored procedure erp.UpdateClient"
2. Nov 12, 2024 3:10:18 PM | Sarah Johnson | Approve | Client | #1244 | [+] | 192.168.1.45 | ✓
   - When expanded: "Approved job #1244 submitted by David Lee. Comments: 'Data verified with Finance team.'"

Right Side Panel:
- "Export Options":
  * Date range selector
  * Format: CSV / Excel / PDF dropdown
  * "Generate Report" button (blue)
  
- "Quick Stats" widget:
  * Total Actions Today: 156
  * Unique Users: 12
  * Failed Actions: 2 (red)

Bottom:
- Infinite scroll or pagination
- "Load More" button

Data Changes Tab Preview (not expanded):
- Similar table showing before/after values for each field changed
- Columns: Timestamp, Job ID, Entity Type, Entity ID, Field, Old Value, New Value, Changed By

Style: Compliance-focused, detailed logging, exportable data
Desktop view: 1920x1080
```

---

### Screen 13: User Profile / Settings Page

```
Design a user profile and settings page.

Top: Page header "My Profile" with breadcrumb (Home > Profile)

Layout: Two columns (60/40 split)

Left Column:

Profile Card:
- Large user avatar (editable upload)
- Display Name: "John Smith" (editable)
- Email: "john.smith@firm.com" (read-only, Entra ID)
- Department: "Financial Systems Team" (editable dropdown)
- Role Badge: "Global Submitter" (read-only, admin-controlled)

My Permissions Card:
- Section: "Template Access"
  * "You have access to 12 templates" (clickable to expand)
  * When expanded: List of templates with permission type badges (Submitter/Approver)
- Section: "System Permissions"
  * Checklist showing what user can do:
    ☑ Upload files
    ☑ View own jobs
    ☐ Approve requests (greyed if not applicable)
    ☐ Manage users
    etc.

Activity Summary Card:
- "Your Activity (Last 30 Days)"
  * Jobs Submitted: 23
  * Approvals Given: - (if not approver)
  * Success Rate: 96%
  * Most Used Template: "Client Bulk Update"

Right Column:

Preferences Card:
- Email Notifications:
  * ☑ Job completion notifications
  * ☑ Approval status updates
  * ☑ Validation errors
  * ☐ Weekly summary email
  * ☐ System announcements

- Display Settings:
  * Theme: Light / Dark / Auto (toggle)
  * Date Format: MM/DD/YYYY dropdown
  * Timezone: (EST) Eastern Time dropdown
  * Rows per page: 10 dropdown

- Security:
  * Session timeout: 30 minutes (read-only)
  * Two-factor auth: Managed by Microsoft (link to Entra ID)
  * Active sessions: "1 active session" (link to view details)

Recent Activity Card:
- Mini timeline:
  * "2 hours ago - Uploaded client_updates.xlsx"
  * "Yesterday - Downloaded Client Update template"
  * "2 days ago - Approved by Sarah Johnson for job #1240"
  * "View full history" link

Footer:
- "Save Changes" button (blue, bottom right)

Style: Personal, informative, user-centric settings
Desktop view: 1920x1080
```

---

### Screen 14: Error / Failed Job Detail Page

```
Design a detailed error page for a failed job with troubleshooting information.

Top: Page header "Job #1245 - Failed" with breadcrumb (Home > Jobs > #1245)
- Large red alert banner: "This job failed during processing"

Status Timeline (horizontal):
- Shows: Submitted > Validated > Approved > Processing (red X icon) > Completed (greyed)

Job Information (same as status page but with error emphasis):

Error Summary Card (prominent, red accent):
- Icon: Large error icon (red)
- Heading: "Processing Failed"
- Error Type: "Database Error" (badge)
- Timestamp: "Nov 11, 2024 4:23 PM"
- Error Code: "ERR_DB_1045" (monospace, copyable)

Error Details Section:
- Technical Message (expandable):
  ```
  SQL Exception: Foreign key constraint violation
  Stored Procedure: erp.UpdateClient
  Failed at row: 127
  Field: ClientCode 'CLI-9999' references non-existent parent record
  ```
- User-Friendly Message:
  "One or more records reference data that doesn't exist in the system. Please verify your data and try again."

Failed Rows Section:
- Table showing: Row #, Field, Value, Error Reason
  * Row 127, ClientCode, CLI-9999, "Client code not found"
  * Row 134, Status, "Terminated", "Invalid status value"
  * Row 201, ClientName, [empty], "Required field missing"
- "Download Failed Rows" button (CSV export)

Impact Section:
- "Partial Success" info box (if applicable):
  * Successfully processed: 126 rows
  * Failed: 108 rows
  * Note: "All changes have been rolled back to maintain data integrity"

Recommended Actions Card (helpful):
- Numbered steps:
  1. "Download the error report below"
  2. "Fix the errors in your original file"
  3. "Re-upload using the button below"
- Or: "Contact support if you need assistance: support@firm.com"

Action Buttons:
- Left: "Download Error Report" (outlined, blue)
- Right: "Re-upload Corrected File" (blue, primary)

Activity Log:
- Shows full timeline including error occurrence

Style: Helpful error handling, clear next steps, non-blaming tone
Desktop view: 1920x1080
```

---

### Screen 15: Help / Documentation Page

```
Design a help center and documentation page.

Top: Page header "Help Center" with breadcrumb (Home > Help)

Hero Search:
- Large centered search bar: "How can we help you?" with search icon
- Popular searches below: "How to upload", "Template guide", "Approval process", "Error codes"

Content Layout: 3 columns

Column 1 - Getting Started:
Card with icon:
- "📚 Quick Start Guide"
  * "Your first upload" (link)
  * "Understanding templates" (link)
  * "How approval works" (link)
  * "Troubleshooting common errors" (link)

Column 2 - Video Tutorials:
Card with icon:
- "🎥 Video Guides"
  * Thumbnail: "How to Upload Files" (3:24)
  * Thumbnail: "Understanding Validation" (5:12)
  * Thumbnail: "Managing Your Jobs" (4:08)
  * "View all tutorials" link

Column 3 - Resources:
Card with icon:
- "📄 Documentation"
  * "Template field reference" (PDF)
  * "Business rules guide" (PDF)
  * "API documentation" (link)
  * "FAQ" (link)

Below: Accordion FAQs:

1. "What file formats are supported?" (expanded)
   - Answer: "We support Excel (.xlsx, .xls) and CSV files up to 10 MB in size..."

2. "How long does approval take?"
   - Answer: "Approval requests are typically reviewed within 1 business day..."

3. "What happens if my job fails?"
   - Answer: "If validation or processing fails, you'll receive a detailed error report..."

4. "Can I cancel a job in progress?"
   - Answer: "Jobs can be cancelled while they're pending approval or in validation..."

5. "Who do I contact for support?"

Right Sidebar:
- Contact Support Card:
  * Email: support@firm.com
  * Phone: x5555
  * Hours: M-F 9am-5pm EST
  * "Submit a ticket" button

- System Status Card:
  * All systems operational (green dot)
  * Last updated: 2 mins ago
  * "View status page" link

Style: Helpful, searchable, self-service focused
Desktop view: 1920x1080
```

---

## 📱 Responsive Design Prompts

### For Tablet View (768px)

```
Create tablet-optimized version (768px width) of the [SCREEN NAME] page:
- Stack elements vertically where space is tight
- Reduce from 3 columns to 2 columns for cards
- Make tables horizontally scrollable
- Increase touch target sizes to 44x44px minimum
- Adjust font sizes: headings slightly smaller
- Keep critical actions always visible (sticky headers/footers)
```

### For Mobile View (375px)

```
Create mobile-optimized version (375px width) of the [SCREEN NAME] page:
- Single column layout
- Hamburger menu for navigation
- Bottom navigation bar for primary actions
- Collapsible sections by default
- Card-based layout (full width)
- Tables convert to stacked cards
- Floating action button for primary CTA
- Simplified data display (hide non-essential columns)
```

---

## 💡 Additional Prompt Tips

**Color Consistency Request:**
```
Ensure all status colors match Ant Design 5 token system:
- Success/Completed: Green #52C41A (@success-color)
- Processing/In Progress: Blue #1677FF (@primary-color)
- Pending/Warning: Orange #FAAD14 (@warning-color)
- Failed/Error: Red #FF4D4F (@error-color)
- Cancelled/Inactive: Grey rgba(0, 0, 0, 0.25) (@disabled-color)
Use Ant Design Tag component with appropriate color props.
```

**Interactive State Request:**
```
Show Ant Design 5 interactive states for all components:
- Buttons: Ant Design hover effect (slightly lighter background), active state (darker)
- Cards: hoverable prop for elevation change on hover
- Table rows: Ant Design Table rowClassName for hover background
- Links: Ant Design Typography.Link with hover underline
- Form inputs: Ant Design focus state (blue border, box-shadow)
Use Ant Design's built-in interaction states.
```

**Empty State Request:**
```
For each screen, also design the empty state when there's no data using Ant Design 5:
- Ant Design Empty component with custom description
- InboxOutlined or FileSearchOutlined icon (large, grey)
- Friendly heading: "No [items] yet"
- Helpful subtext explaining why it's empty
- Ant Design Button type="primary" to create first item
- Example: Dashboard with no jobs shows Empty component with "Upload your first file" Button
```

**Loading State Request:**
```
Show Ant Design 5 loading states for data-heavy screens:
- Ant Design Skeleton components matching content structure (Skeleton.Input, Skeleton.Button, Skeleton.Avatar)
- Ant Design Spin component for full-page or section loading
- Ant Design Progress for file uploads (type="line" or "circle")
- Table loading: Ant Design Table with loading prop
- Button loading: Button loading prop with LoadingOutlined icon
```

---

## 🎯 Screen Generation Order Recommendation

For best results in Google Stitch, generate screens in this order:

**Phase 1 - Core User Flow (Generate First):**
1. Login Page
2. Dashboard
3. Template Library
4. File Upload
5. Validation Results
6. Job Confirmation
7. Job Status/Tracking

**Phase 2 - Management & Monitoring:**
8. Job History/List
9. Approval Queue
10. Failed Job Detail
11. User Profile/Settings

**Phase 3 - Admin & Documentation:**
12. User Management (Admin)
13. Template Management (Admin)
14. Audit Log/Reports
15. Help/Documentation

---

## 🔄 Iteration Prompts

### To Refine a Generated Screen:

**Add More Detail:**
```
Enhance the [SCREEN NAME] design with these additions:
- Add [specific element]
- Show [specific state/variant]
- Include [specific data example]
- Emphasize [specific section] more prominently
```

**Adjust Layout:**
```
Modify the [SCREEN NAME] layout:
- Change from [current layout] to [new layout]
- Increase/decrease spacing between [elements]
- Make [element] more/less prominent
- Reorganize [section] to improve [specific goal]
```

**Match Brand/Style:**
```
Adjust the [SCREEN NAME] to match our specific brand:
- Use logo: [describe or attach]
- Primary color: [hex code]
- Secondary color: [hex code]
- Font: [font name]
- Style keywords: [minimal/bold/playful/corporate/etc.]
```

**Show Different Scenarios:**
```
Create variants of [SCREEN NAME] showing:
- Success state: [describe scenario]
- Error state: [describe scenario]
- Empty state: [describe scenario]
- Loading state: [describe scenario]
- Mobile view
```

---

## 🎨 Style Refinement Prompts

### For a More Modern Look:
```
Enhance [SCREEN NAME] with Ant Design 5 modern aesthetic:
- Use Ant Design Card with bordered={false} for cleaner look
- Apply Ant Design's subtle box-shadows (token: @shadow-1, @shadow-2)
- Use Ant Design borderRadius token (8px default)
- Add Ant Design Space components for consistent spacing
- Use Ant Design theme customization for subtle background colors
- Implement Ant Design Typography components (Title, Text, Paragraph)
- Use Ant Design icons from @ant-design/icons package
```

### For Better Accessibility:
```
Improve accessibility of [SCREEN NAME] using Ant Design 5:
- Ensure WCAG AAA color contrast using Ant Design color palette
- Use Ant Design Form.Item with proper labels and help text
- Implement Ant Design Tooltip for additional context
- Use Ant Design Alert for important messages with appropriate severity
- Ensure Ant Design Button has proper focus states (built-in)
- Add aria-labels where needed (Ant Design components have good defaults)
- Use Ant Design Typography with appropriate heading hierarchy
```

### For Enterprise Polish:
```
Make [SCREEN NAME] more enterprise-ready with Ant Design 5:
- Use Ant Design Pro layout components (PageHeader, PageContainer)
- Implement Ant Design Descriptions for detailed data display
- Use Ant Design Statistic for key metrics and KPIs
- Add Ant Design Badge and Tag for status indicators
- Implement Ant Design Timeline for activity logs
- Use Ant Design Result component for success/error pages
- Apply Ant Design's professional color scheme
```

---

## 📋 Component Library Prompt

**To Generate Consistent Components Across All Screens:**

```
Create a component library for the FST Data Portal using Ant Design 5 specifications:

1. Buttons (Ant Design Button):
   - Primary: type="primary", background #1677FF
   - Default: type="default", bordered
   - Text: type="text", no background
   - Link: type="link", blue text
   - Sizes: size="small" | "middle" (default) | "large"
   - Danger variant: danger={true} for destructive actions

2. Input Fields (Ant Design Input, Form.Item):
   - Standard Input with placeholder
   - Form.Item with label prop
   - Help text using Form.Item help prop
   - Error state: validateStatus="error", help="Error message"
   - Success state: validateStatus="success" with CheckCircleOutlined
   - Search: Input.Search component
   - TextArea for multi-line input

3. Cards (Ant Design Card):
   - Standard: Card with title and bordered
   - Borderless: bordered={false} for modern look
   - Hoverable: hoverable={true}
   - With actions: actions prop array
   - Loading state: loading={true}
   - 24px padding (default), 8px border radius

4. Status Indicators (Ant Design Tag, Badge):
   - Tag with color prop: "success" | "processing" | "error" | "warning" | "default"
   - Badge with status: "success" | "processing" | "error" | "warning" | "default"
   - Badge with count for notifications
   - Closable tags: closable={true}

5. Data Tables (Ant Design Table):
   - Standard: columns and dataSource props
   - Row selection: rowSelection prop
   - Sortable: sorter in column definition
   - Filterable: filters in column definition
   - Pagination: pagination prop (default enabled)
   - Loading: loading={true}
   - Size: size="small" | "middle" | "large"

6. Navigation (Ant Design Layout, Menu, Breadcrumb):
   - Layout.Header: 64px height, white background
   - Menu: horizontal mode for top nav
   - Breadcrumb: with separator=">"
   - Menu.Item with selected key for active state
   - Sider: 200px width for side navigation (if used)

7. Modals/Dialogs (Ant Design Modal):
   - Standard Modal with title, content, footer
   - Confirm modal: Modal.confirm() for confirmations
   - Width: 520px (small), 720px (medium), 1000px (large)
   - Footer: okText and cancelText props
   - Mask: default dark backdrop
   - Centered: centered={true}

8. Notifications (Ant Design message, notification):
   - Message: message.success/error/warning/info (top center, auto-dismiss 3s)
   - Notification: notification.open (top-right, with description, auto-dismiss 4.5s)
   - Alert: Alert component for inline messages with type prop
   - Closable: closable={true}

Generate visual examples of each Ant Design 5 component with variants (default, hover, active, disabled, error).
Use Ant Design design tokens and follow the official component API.
```

---

## 🖼️ Complete Page Layout Template

**Master Layout Prompt (Apply to Each Screen):**

```
Create [SCREEN NAME] using this Ant Design 5 master layout structure:

Left Sidebar (Ant Design Layout.Sider):
- Fixed position, collapsible
- Width: 200px (expanded), 64px (collapsed)
- Background: #001529 (dark theme)
- Top section: Logo + "Data Update Portal" (white text)
- Menu component (mode="inline", theme="dark"):
  * Navigation items with icons
  * Active item highlighted with #1677FF background
  * Expandable submenus for Jobs, Admin sections
  * Role-based visibility
- Bottom: Collapse trigger button

Top Header Bar (Ant Design Layout.Header):
- Height: 56px
- Background: white
- Left: Ant Design Breadcrumb navigation
- Right: Ant Design Space with notifications (Badge), help (QuestionCircleOutlined), user Dropdown (Avatar + name + role)
- Box-shadow for elevation

Main Content Area (Ant Design Layout.Content):
- Padding: 24px
- Background: #F0F2F5
- Min-height: calc(100vh - 56px)
- Width: Remaining space after sidebar

Page Structure within Content:
- Page header: Typography.Title level={3}, margin-bottom: 24px
- Content sections: Cards with 24px spacing
- Responsive grid: Row and Col with gutter={[24, 24]}

Footer (Ant Design Layout.Footer, if needed):
- Background: white
- Padding: 16px 24px
- Sticky to bottom for forms

Navigation Menu Structure:
- 📊 Dashboard (DashboardOutlined)
- 📤 Upload (CloudUploadOutlined)
- 📋 Jobs (FolderOutlined) - SubMenu:
  * My Jobs
  * All Jobs
  * Job History
- ✅ Approvals (CheckSquareOutlined) - visible for Approvers/Admins
- 📁 Templates (FileTextOutlined)
- ⚙️ Admin (SettingOutlined) - SubMenu (Admins only):
  * Users (TeamOutlined)
  * Templates (FileExcelOutlined)
  * Audit Logs (FileSearchOutlined)
- 👤 Settings (UserOutlined)
- ❓ Help (QuestionCircleOutlined)

Ensure consistent Ant Design spacing: 8px, 16px, 24px, 32px, 48px
Desktop view: 1920x1080 (Content area width: ~1696px with 200px sidebar)
Collapsed sidebar: Content area width: ~1832px with 64px sidebar
```

---

## 🔍 Quality Checklist Prompt

**After Generating Each Screen:**

```
Review the generated [SCREEN NAME] design and verify:

Visual Hierarchy:
☐ Most important action is most prominent
☐ Clear visual flow (F-pattern or Z-pattern)
☐ Appropriate heading sizes (H4 > H5 > H6 > Body)
☐ Consistent spacing between elements

Usability:
☐ All interactive elements look clickable
☐ Form fields clearly labeled
☐ Error states are obvious
☐ Success feedback is clear
☐ Loading states are indicated

Consistency:
☐ Matches design system colors
☐ Uses standard component styles
☐ Icons are consistent style
☐ Typography follows scale
☐ Spacing uses 8px grid

Accessibility:
☐ Sufficient color contrast
☐ Touch targets are 44x44px minimum
☐ Form inputs have labels
☐ Error messages are descriptive
☐ Focus states are visible

Data Display:
☐ Tables are scannable
☐ Important data is emphasized
☐ Empty states are handled
☐ Error scenarios are shown
☐ Status indicators are color-coded

If any items fail, provide specific feedback for refinement.
```

---

## 🚀 Batch Generation Strategy

### Generate Multiple Screens Efficiently:

**Option 1 - User Journey Sets:**
```
Generate a complete user journey for [specific workflow]:

1. Entry point: [Screen name]
2. Step 1: [Screen name]
3. Step 2: [Screen name]
4. Success: [Screen name]
5. Error: [Screen name]

Use consistent design language, matching colors, typography, and components. Show progression between screens with consistent navigation and breadcrumbs.
```

**Option 2 - Role-Based Sets:**
```
Generate all screens for [specific role]:

For Submitter role, create:
- Dashboard (submitter view)
- Template selection
- Upload flow (3 screens)
- Job tracking
- Profile page

Ensure each screen shows appropriate permissions and actions for this role.
```

**Option 3 - Feature Module Sets:**
```
Generate all screens for [specific feature]:

For Approval Workflow feature, create:
- Approval queue (approver view)
- Request detail (expanded)
- Approve confirmation modal
- Reject with comments modal
- Approval history

Show the complete approval flow with all states and transitions.
```

---

## 💎 Pro Tips for Google Stitch

1. **Be Specific About Data:** Include realistic sample data in your prompts for more accurate designs

2. **Request Variants:** Always ask for hover states, empty states, and error states in the same prompt

3. **Use Design System Language:** Reference Material Design 3 components by name (e.g., "MUI DataGrid", "Outlined TextField")

4. **Specify Dimensions:** Always include screen size (1920x1080 for desktop)

5. **Reference Previous Screens:** When generating later screens, mention "using the same header/navigation as Screen 2"

6. **Request Annotations:** Ask for clickable areas, interaction hints, and functional notes

7. **Iterate in Batches:** Generate 3-4 related screens, review, refine, then continue

8. **Export Strategy:** Request designs with clear component separation for easier developer handoff

---

## 📤 Handoff Preparation Prompt

**After All Screens Are Complete:**

```
Prepare a design handoff package for the FST Data Portal:

1. Generate a design system specification document:
   - Color palette with hex codes
   - Typography scale
   - Spacing scale
   - Component specifications
   - Icon library

2. Create annotated versions of key screens showing:
   - Click areas and interactions
   - Conditional visibility rules
   - State transitions
   - Data sources/API calls
   - Validation rules

3. Provide a screen flow diagram:
   - Show all 15 screens connected by user actions
   - Indicate user roles that can access each screen
   - Mark critical paths

4. Export assets:
   - Component library file
   - Icon set (SVG)
   - Logo files
   - Sample images

5. Generate a developer handoff document:
   - Screen-by-screen specifications
   - Component mapping to MUI
   - Responsive breakpoints
   - Animation specifications
```

---

## 🎬 Final Checklist

Before considering design complete:

☐ All 15 core screens designed
☐ Mobile/tablet responsive variants created
☐ Empty states shown for all data-driven screens
☐ Error states and validation feedback designed
☐ Loading states and progress indicators included
☐ All user roles represented (6 role views)
☐ Success and failure scenarios covered
☐ Help documentation and tooltips designed
☐ Accessibility requirements met
☐ Design system documented
☐ Component library established
☐ Interactive prototype created (if applicable)
☐ Developer handoff materials prepared

---

**Good luck with your design generation in Google Stitch! 🎨**

*These prompts are optimized for AI-powered design tools. Adjust specificity based on the tool's capabilities and your project needs.*