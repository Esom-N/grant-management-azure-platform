# Community Grant & Funding Management Platform (Azure Cloud Project)

## Overview
This project simulates a real-world digital transformation of a manual government/nonprofit grant management system using **Microsoft Azure** services.

It replaces fragmented processes (emails, spreadsheets, paper forms) with a centralized cloud-based system using:
- Azure SQL Database (structured data)
- Azure Blob Storage (document storage)

---

## Business Problem

Government and nonprofit organizations traditionally manage grant applications using:
- Email attachments
- Excel spreadsheets
- Paper forms
- Shared network folders

### Key Problems:
- Documents frequently get lost or duplicated
- Manual tracking slows down approvals
- No centralized visibility for managers
- Difficult to audit or report on application status

---

## Solution

This system modernizes the workflow by centralizing all data into Azure:

### Workflow:
Applicant  
→ Submit Grant Application  
→ Upload Documents (Azure Blob Storage)  
→ Store Application Data (Azure SQL Database)  
→ Track Review Process  
→ Update Status (Submitted → Under Review → Approved)

---

## Architecture

- **Azure SQL Database**
  - Stores structured data (Applicants, Applications, Reviews)
  - Maintains relationships using foreign keys
  - Tracks application status lifecycle

- **Azure Blob Storage**
  - Stores unstructured files (PDFs, Excel, supporting documents)
  - Provides secure URL-based access

---

## Database Design

Tables include:
- Applicants
- GrantApplications
- Documents
- ReviewHistory

Features:
- Primary keys & foreign keys
- Relational integrity
- Status tracking system
- Audit trail for reviews

---

## Tech Stack

- Microsoft Azure
- Azure SQL Database
- Azure Blob Storage
- SQL Server
- Git & GitHub

---

## Key Features

- End-to-end grant application workflow
- Cloud-based document storage integration
- Review tracking system with audit history
- Structured relational database design
- Application lifecycle management

---

## Business Insights & Recommendations

- Most processing delays occur during document verification stages
- Automating review reminders could significantly reduce approval times
- High-volume grant programs may require additional staffing or prioritization rules
- Centralizing documents in Azure Blob Storage reduces data loss risk and improves collaboration
- Structured SQL tracking enables auditability and compliance reporting

---

## Key Outcome

This project demonstrates how cloud technologies can transform a fragmented manual workflow into a structured, scalable, and auditable digital system suitable for government or enterprise use.

---

## Sample Data Flow

1. Applicant submits application
2. Data stored in Azure SQL Database
3. Documents uploaded to Azure Blob Storage
4. Reviewers update status and add comments
5. Final decision recorded in system
