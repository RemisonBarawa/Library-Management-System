-- Creating the database for the Library Management System
CREATE DATABASE IF NOT EXISTS LibraryManagement;
USE LibraryManagement;

-- Creating the Authors table to store author information
CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    AuthorName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Bio TEXT
);

-- Creating the Categories table to store book categories
CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL UNIQUE,
    Description TEXT
);

-- Creating the Books table to store book details
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    AuthorID INT NOT NULL,
    CategoryID INT NOT NULL,
    ISBN VARCHAR(13) UNIQUE NOT NULL,
    PublicationYear YEAR,
    TotalCopies INT NOT NULL DEFAULT 1 CHECK (TotalCopies >= 1),
    AvailableCopies INT NOT NULL CHECK (AvailableCopies <= TotalCopies),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID) ON DELETE RESTRICT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID) ON DELETE RESTRICT
);

-- Creating the Members table to store member details
CREATE TABLE Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    JoinDate DATE NOT NULL DEFAULT (CURRENT_DATE)
);

-- Creating the BorrowingRecords table to track borrowing history
CREATE TABLE BorrowingRecords (
    BorrowID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT NOT NULL,
    MemberID INT NOT NULL,
    BorrowDate DATE NOT NULL DEFAULT (CURRENT_DATE),
    DueDate DATE NOT NULL,
    ReturnDate DATE,
    Fine DECIMAL(5, 2) DEFAULT 0.00,
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE RESTRICT,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE RESTRICT,
    CHECK (DueDate > BorrowDate),
    CHECK (ReturnDate IS NULL OR ReturnDate >= BorrowDate)
);

-- Inserting sample data into Authors
INSERT INTO Authors (AuthorName, Email, Bio) VALUES
('J.K. Rowling', 'jkrowling@example.com', 'Author of the Harry Potter series'),
('George Orwell', 'georgeorwell@example.com', 'Author of 1984 and Animal Farm');

-- Inserting sample data into Categories
INSERT INTO Categories (CategoryName, Description) VALUES
('Fiction', 'Fictional literature'),
('Non-Fiction', 'Non-fictional literature');

-- Inserting sample data into Books
INSERT INTO Books (Title, AuthorID, CategoryID, ISBN, PublicationYear, TotalCopies, AvailableCopies) VALUES
('Harry Potter and the Sorcerer\'s Stone', 1, 1, '9780590353427', 1997, 5, 5),
('1984', 2, 1, '9780451524935', 1949, 3, 3);

-- Inserting sample data into Members
INSERT INTO Members (FirstName, LastName, Email, Phone, JoinDate) VALUES
('John', 'Doe', 'johndoe@example.com', '1234567890', '2025-01-01'),
('Jane', 'Smith', 'janesmith@example.com', '0987654321', '2025-02-01');

-- Inserting sample data into BorrowingRecords
INSERT INTO BorrowingRecords (BookID, MemberID, BorrowDate, DueDate, ReturnDate, Fine) VALUES
(1, 1, '2025-05-01', '2025-05-15', NULL, 0.00),
(2, 2, '2025-05-02', '2025-05-16', '2025-05-10', 0.00);
