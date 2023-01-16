# Remedia Library Database

## Title:
Anna Elementary School’s Remedia Library Upgrade

## Team Members: 
**Clara Watson, Jon Moore**

## URL
http://flip2.engr.oregonstate.edu:48519/
*Must use VPN*

## Summary:
Remedia is a media management service that builds databases for individuals looking to organize their personal collections. Anna Elementary School has enlisted Remedia to take on the task of transferring their library into a website and database.

Anna is a school of about 500 students, and the library consists of over 7,000 books. Students check out on average 2 books per week, making that over 1,000 check out records per week to keep track of. Over the course of this project we have worked very hard to create a database with website interactions for Anna Elementary to utilize.

Our original website design was a bit confusing and consisted of six pages all with different purposes of their own; however, upon getting feedback we decided to downsize to four pages: a dashboard page, catalog page, student page, and loans page. At first we did not have an M:M relationship, but we were able to include this in our updated version. It was important to us not only to have M:1 relationships, but also M:M for optimal functionality within our database.

We have also spent an ample amount of time perfecting our user interface. For example, after receiving feedback we decided to implement a few key features to make our users' experience on our website simple and easy to use. One of these features was prefilling the input text boxes with data when the user goes to edit something in the database.

We originally did not include separate pages for deleting things off the tables, but we decided that this posed a risk where users could accidentally delete something. Now the delete buttons redirect to a separate page where the user is asked if they are sure they want to delete. We also implemented smaller changes like adding pattern requirements to our html inputs to make sure the user is entering the correct data form.

We are very pleased with the final outcome of our website and database and hope that the students, teachers, and faculty at Anna Elementary School will be too.

## Project Outline:
**Webpages:** 
* Dashboard
    * Quick-checkout
        *A form that will update the loans page. This is representing a student checking out a book from the library.
    * Description of pages
        * Dashboard: landing page, will have widgets and quick links
        * Catalog: main display page of books in the Library, as well as creation,
editing, and deleting
        * Students: main display page of students, as well as creation, editing, and
deleting
* Loans: generates pre-designated reports, pulling data from databases
    * Catalog
        * Add Forms
    * Add Book
        *This form adds to our book table as well as our author table. It
asks the user for a title, author, publisher, year, ISBN, and how
many copies the library has. 
    * Add Author
        * A simple form to add a new author to the library system. 
    * Add Subject
        * A simple form to add a new subject to the library system. 
    * Add Genre
        *A simple form to add a new genre to the library system. 
* Book Records
    * A table that displays the books that are currently in the database.
    *  Has the ability to edit the books.
        *  The edit button links to a new page that auto displays the book being edited and allows the user to update the changes.
        * Has the ability to delete book from the database.
            *  The delete button redirects to a separate page asking the user if
they are sure they want to delete the book and then updates the database accordingly.
*  Students
    * Add students
        * A simple form to add a new student to the library system.
        * The student ID will be automatically generated.
    * Student Records
        *  A table showing a summary of all of the students currently in the system.
        * The librarian has the ability to edit the students information in the
database.
* The edit button links to a separate page that pre-populates the form with the students information allowing the user to make changes. Then the database is updated accordingly.
    *  There is also the ability to delete students from the database.
        * The delete button redirects the user to a page asking if they are
sure before going on to make changes in the database.
*  Loans
    * Checked Out
        * A table showing a summary of the books currently checked out of the library
        * This is where the librarian can mark the book as returned.
    * Borrow Records
        * A table that connects books with their genres through their IDs.

**Steps:**
    1. Proposal and outline with ERD
    2. Normalized Schema + DDL with Sample Data
    3. Design HTML interface + DML SQL
    4. Add CRUD to one M:M entity HTML page (e.g. Invoices)
    5. Implement MOST remaining entities/pages
    6. Submit final completed project

## Database Outline:
* **Students** stores details of the students of the school
    * studentID: INT, auto_increment, unique, not NULL, PK
    * studentfirstName: VARCHAR(255), not NULL
    * studentlastName: VARCHAR(255), not NULL
    * studentEmail: VARCHAR(255), not NULL   
    **Relationship:**   
    ➔ 1:M between Students and Check-Outs   

* **CheckedOut**  records the books that are checked out of the library
    * checkoutID: INT, auto_increment, unique, not NULL, PK
    * studentID: INT, not NULL,
    * bookISBN: char(13), not NULL
    * checkoutDate: DATE, DEFAULT(curdate())
    * returnDate: DATE, DEFAULT (curdate() + 7)   
    **Relationships:**  
    ➔ 1:M between Checked-Out and Books   
    ➔ 1:M between Checked-Out and Students   
    ➔ M:M also acts as a join table   
  
* **Books**  stores details of the books in the library
    * bookID: INT, auto_increment, unique, not NULL, PK
    * bookISBN: CHAR(13), not NULL FK
    * bookTitle: VARCHAR(255), not NULL
    * authorName: VARCHAR(150), not NULL FK
    * bookYearPublished: CHAR(4)
    * bookPublisher: VARCHAR(255), not NULL
    * genreID: INT, auto_increment, unique, not NULL, FK
    * subjectID: int, auto_increment, unique, not NULL, FK
    * bookCopies: INT, not NULL  
    **Relationships:**   
    ➔ M:1 between Checked-Out to Books   
    ➔ 1:MbetweenBookstoAuthor   
    ➔ 1:M between Books to Subject   
    ➔ 1:M between Books to Genre    
    ➔ 1:M between Books to Borrow_Records    
    
*  **Author**  stores details of the different authors in the library
    * authorID: INT, auto_increment, unique, not NULL, PK
    * authorName: VARCHAR(150), not NULL    
    **Relationships:**   
    ➔ M:1betweenBookstoAuthor   
    
* **Subject**  stores details of the subjects represented in the library
    * subjectID: int, auto_increment, unique, not NULL, PK
    * subjectName: CHAR(255), not NULL
    * subjectCount: INT, not NULL, zero fill, calculated sum of books in subject   
    **Relationships:**   
    ➔ 1:M between Subject and Books   
        
* **Genre**  stores details of the genres represented in the library
    * genreID: INT, auto_increment, unique, not NULL, PK
    * genreName: VARCHAR(45), not NULL, unique    
    **Relationships:**   
    ➔ 1:M between Genres and Books   
      
## Entity-Relationship Diagram
   ![ERD!](https://github.com/watson-clara/CS340-Database-Final/blob/db6ec4e6e111dbeb9a9370c00de49e29d22c2550/templates/images/ERD.png "ERD")
   
## Schema
   ![Schema!](https://github.com/watson-clara/CS340-Database-Final/blob/db6ec4e6e111dbeb9a9370c00de49e29d22c2550/templates/images/schema.png "Schema")
   


