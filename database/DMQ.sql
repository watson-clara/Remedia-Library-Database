--
--	DATABASE : Remedia, a Libray Database DMQ File
--	Date: 6/6/2022
-- 	Author: Clara Watson , Jon Moore
-- 	Class : CS 340
--


----------------------
--      CREATE      --
----------------------
-- create new book
insert into books (bookTitle, bookAuthor, bookISBN)
values (:bookTitle_input, :bookISBN_input)
-- create new student
insert into students (studentFirstName, studentLastName, studentEmail, studentID)
values (:studentFirstName_input, :studentLastName_input, :studentEmail_input, s:tudentID_input)
-- create new student
insert into subject (subjectName)
values (:subjectName_input)
-- create new student
insert into genre (genreName)
values (:genreName_input)

----------------------
--       READ       --
----------------------
-- display entire catalog
select * from books
-- display all students
select * from students
-- display all borrow_records
select * from borrow_records
-- display entire genre table 
select * from genre
-- display entire subject table
select * from subject
-- display all loans
select * from loans
-- display only active loans
select * from loans
where returnDate = NULL
-- display overdue loans
select * from loans
where returnDate = NULL and dueDate < current_date
-- display top 5 books
select * from books 
order by checkoutCounter desc limit 5
-- retrieve number of books currently loaned to a student
select count(*) as 'totalCount' from books
where returnDate in (select returnDate from checkedOut where returnDate = NULL) and studentID = :studentID_input
-- retrieve number of copies of a book checked out
select count(*) as 'copyCount' from checkedOut
where bookID = :bookID_input



----------------------
--      UPDATE      --
----------------------
-- check in book (update return date)
update checkedOut
set returnDate = :returnDate_input where returnDate = NULL
-- edit details of a book
update books
set title = :title_input, author = :author_input, publisher = :publisher_input, year = :year_input, isbn = :isbn_input
where bookID = :bookID_input
-- edit details of a student
update students
set studentFirstName = :studentFirstName_input, studentLastName = :studentLastName_input, studentEmail = :studentEmail
where studentID = :studentID_input

----------------------
--      DELETE      --
----------------------
-- delete a book
delete from books
where bookISBN = :bookISBN_input
-- delete a book (just one copy)
delete from copies
where copyID = :copyID_from_dropdown_input
-- delete a student
delete from students
where studentID = :studentID_input



