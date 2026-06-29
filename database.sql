-- =========================================
-- Community Grant & Funding Management Platform
-- Azure SQL Database Schema + Sample Data
-- =========================================

-- =========================================
-- 1. CREATE TABLES (CORE SYSTEM)
-- =========================================

-- Stores applicant information
CREATE TABLE Applicants (
    ApplicantID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100),
    Organization NVARCHAR(150),
    Email NVARCHAR(150)
);

-- Stores grant applications submitted by applicants
CREATE TABLE GrantApplications (
    ApplicationID INT IDENTITY(1,1) PRIMARY KEY,
    ApplicantID INT,
    Program NVARCHAR(150),
    SubmissionDate DATETIME,
    Status NVARCHAR(50)
);

-- Stores documents uploaded to Azure Blob Storage
CREATE TABLE Documents (
    DocumentID INT IDENTITY(1,1) PRIMARY KEY,
    ApplicationID INT,
    FileName NVARCHAR(200),
    UploadDate DATETIME,
    BlobURL NVARCHAR(500)   -- Link to Azure Blob Storage file
);

-- Tracks review process and comments from staff
CREATE TABLE ReviewHistory (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    ApplicationID INT,
    Reviewer NVARCHAR(100),
    ReviewDate DATETIME,
    Comments NVARCHAR(500)
);

-- =========================================
-- 2. FOREIGN KEY RELATIONSHIPS
-- =========================================

-- Link applications to applicants
ALTER TABLE GrantApplications
ADD CONSTRAINT FK_Applications_Applicants
FOREIGN KEY (ApplicantID) REFERENCES Applicants(ApplicantID);

-- Link documents to applications
ALTER TABLE Documents
ADD CONSTRAINT FK_Documents_Applications
FOREIGN KEY (ApplicationID) REFERENCES GrantApplications(ApplicationID);

-- Link reviews to applications
ALTER TABLE ReviewHistory
ADD CONSTRAINT FK_Reviews_Applications
FOREIGN KEY (ApplicationID) REFERENCES GrantApplications(ApplicationID);

-- =========================================
-- 3. SAMPLE DATA INSERTION
-- =========================================

-- Insert sample applicant
INSERT INTO Applicants (Name, Organization, Email)
VALUES ('John Doe', 'Helping Hands Org', 'john@email.com');

-- Insert sample grant application
INSERT INTO GrantApplications (ApplicantID, Program, SubmissionDate, Status)
VALUES (1, 'Community Development Grant', GETDATE(), 'Submitted');

-- Insert sample document (stored in Azure Blob Storage)
INSERT INTO Documents (ApplicationID, FileName, UploadDate, BlobURL)
VALUES (
    1,
    'BusinessPlan.pdf',
    GETDATE(),
    'https://grantblobstorage482910.blob.core.windows.net/applications/BusinessPlan.pdf'
);

-- Insert review history entries (simulating workflow progression)
INSERT INTO ReviewHistory (ApplicationID, Reviewer, ReviewDate, Comments)
VALUES (1, 'Admin User', GETDATE(), 'Application under initial review');

INSERT INTO ReviewHistory (ApplicationID, Reviewer, ReviewDate, Comments)
VALUES (1, 'Jane Smith (Grant Officer)', GETDATE(), 'Initial review completed - documents verified');

INSERT INTO ReviewHistory (ApplicationID, Reviewer, ReviewDate, Comments)
VALUES (1, 'Senior Manager', GETDATE(), 'Approved for funding');

-- =========================================
-- 4. WORKFLOW STATUS UPDATES
-- =========================================

-- Move application through lifecycle stages
UPDATE GrantApplications
SET Status = 'Under Review'
WHERE ApplicationID = 1;

UPDATE GrantApplications
SET Status = 'Approved'
WHERE ApplicationID = 1;

-- =========================================
-- 5. DASHBOARD REPORTING QUERY
-- Demonstrates how application, document,
-- and review information can be combined
-- into a single reporting view.
-- =========================================

SELECT 
    a.Name,
    a.Organization,
    ga.Program,
    ga.Status,
    d.FileName,
    d.BlobURL,
    rh.Reviewer,
    rh.Comments
FROM Applicants a
JOIN GrantApplications ga ON a.ApplicantID = ga.ApplicantID
LEFT JOIN Documents d ON ga.ApplicationID = d.ApplicationID
LEFT JOIN ReviewHistory rh ON ga.ApplicationID = rh.ApplicationID;
