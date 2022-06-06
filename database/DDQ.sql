--
--	DATABASE : Remedia, a Libray Database DDQ File 
--	Date: 6/6/2022
-- 	Author: Clara Watson , Jon Moore
-- 	Class : CS 340
--

--
SET foreign_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;



-------------------------
--     Authors Table   --
-------------------------
-- table structure for authors table 
CREATE OR REPLACE TABLE authors (
    authorID int not null unique AUTO_INCREMENT, 
    authorName varchar(150) not null,  
    primary key (authorID)
    foreign key (authorName) references books(authorName), 
);
-- Begin inserting into these columns 
INSERT INTO authors (
    authorID, 
    authorName, 
)
-- insert sample data into authors table
VALUES
(1, 'James Buckley'), (
2, 'Shana Corey'), (
3, 'Ciara Floo''d'), (
4, 'Jose Garibaldi'), (
5, 'Barbara Gibson'), (
6, 'Kevin Henkes'), (
7, 'Gail Herman'), (
8, 'Andrew Joyner'), (
9, 'Jonathan London'), (
10, 'Rupert Matthews'), (
11, 'Walker Melby'), (
12, 'Marissa Moss'), (
13, 'Mary Pope Osborne'), (
14, 'Audrey Penn'), (
15, 'Dav Pilkey'), (
16, 'Dana Meachen Rau'), (
17, 'Amanda Renshaw'), (
18, 'Erin Russel'), (
19, 'Nikki Russel'), (
20, 'Rachel Renee Russell'), (
21, 'Karen Schmidt'), (
22, 'Lisa Schroeder'), (
23, 'Dr. Seuss'), (
24, 'Diane Stanley'), (
25, 'Cara J. Stevens'), (
26, 'Will Terry'), (
27, 'Andrew Thomson'), (
28, 'Tomi Ungerer'), (
29, 'Dan Yaccarino');



-------------------------
--     Books Table   --
-------------------------
-- table structure for bookd table 
CREATE OR REPLACE TABLE books (
    bookID int not null unique AUTO_INCREMENT, 
    bookISBN char(13) not null unique, 
    bookTitle varchar(255) not null, 
    bookYearPublished char(4) not null, 
    bookPublisher varchar(255) not null, 
    bookCopies int not null, 
    genreID int, 
    subjectID int, 
    authorName varchar(255) not null, 
    primary key (bookID), 
    foreign key (genreID) references genre(genreID), 
    foreign key (subjectID) references subject(subjectID), 
);
-- Begin inserting into these columns 
INSERT INTO books (
    bookID, 
    bookISBN, 
    bookTitle, 
    bookYearPublished, 
    bookPublisher,
    bookCopies, 
    genreID, 
    subjectID, 
    authorName
)
-- insert sample data into books table
VALUES 
(1, 9780545708081, 'My secret guide to Paris', 2015, 'Scholastic Press', 2, 3, 9, 'James Buckley'), (
2, 9781499801927, 'The perfect picnic', 2016, 'Little Bee Books', 1, 2, 10, 'Shana Corey'), (
3, 9780714865355, 'Fog Island', 2013, 'Phaidon Press', 1, 2, 9, 'Ciara Floo''d'), (
4, 9780062248978, 'The chosen prince', 2015, 'HarperCollinsPublishers', 1, 3, 20, 'Jose Garibaldi'), (
5, 9780375869884, 'Dinosaurs before dark', 2012, 'Random House', 2, 3, 15, 'Barbara Gibson'), (
6, 9780553510812, 'Shadow of the shark', 2015, 'Random House', 1, 3, 23, 'Kevin Henkes'), (
7, 9780805077247, 'Every Friday', 2007, 'Henry Holt', 1, 3, 9, 'Gail Herman'), (
8, 9781442487673, 'Dork diaries. Tales from a not-so-glam TV star', 2014, 'Aladdin', 2, 3, 8, 'Gail Herman'), (
9, 9781428773981, 'Amelia''s 7th-grade notebook', 2007, 'Simon & Schuste''r', 1, 3, 22, 'Gail Herman'), (
10, 9780878688944, 'A pocket full of kisses', 2004, 'Child & Family Press', 1, 3, 9, 'Gail Herman'), (
11, 9781410945228, 'World''s biggest dinosaurs', 2012, 'Chicago', 1, 5, 3, 'Gail Herman'), (
12, 9780399556456, 'Time for school,  little dinosaur', 2017, 'Random House', 2, 3, 3, 'Gail Herman'), (
13, 9780375856389, 'Monster parade', 2009, 'Random House', 1, 3, 17, 'Gail Herman'), (
14, 9781510737976, 'Dragons never die', 2018, 'Sky Pony Press', 1, 4, 6, 'Gail Herman'), (
15, 9781338712766, 'Cat Kid Comic Club', 2020, 'Scholastic Press', 1, 4, 2, 'Gail Herman'), (
16, 9780515157628, 'Who are the Rolling Stones?', 2017, 'Penguin Random House', 1, 1, 21, 1'Gail Herman'6), (
17, 9780515158045, 'Who are Venus and Serena Williams?', 2017, 'Penguin Random House', 1, 1, 24, 'Gail Herman'), (
18, 9780688154462, 'Circle dogs', 1998, 'Greenwillow Books', 1, 3, 5, 'Gail Herman'), (
19, 9781512481228, 'There''s a walrus in my bed!', 2017, 'Andersen Press USA', 2, 3, 25, 'Gail Herman'), (
20, 9780714845302, 'The art book for children', 2005, 'Phaidon Press', 2, 5, 1, 'Gail Herman'), (
21, 9780399559129, 'Dr. Seuss''s horse museum', 2019, 'Random House', 1, 5, 13, 'Gail Herman'), (
22, 9781503900356, 'The secret valentine', 2018, 'Two Lions', 1, 3, 7, 'Gail Herman'), (
23, 9780152050542, 'What do you love?', 2000, 'Silver Whristle', 1, 3, 14, 'Gail Herman');




-------------------------
--     Checkout Table   --
-------------------------
-- table structure for checkout table 
--	Creates the table for the relationship that
-- 	represent records of students borrowing books
CREATE OR REPLACE TABLE checkedOut(
    checkoutID int not null unique AUTO_INCREMENT,
    checkoutDate date DEFAULT(current_date), 
    returnDate date DEFAULT (NOW() + INTERVAL 7 DAY), 
    studentID int not null, 
    bookISBN char(13) not null, 
    primary key (checkoutID)
    -- foreign key (studentID) 
    --     references students(studentID),
    -- foreign key (bookISBN) 
    --     references books(bookISBN)
    --     on delete cascade
);
-- Begin inserting into these columns 
INSERT INTO checkedOut (
    checkoutID,
    checkoutDate,
    returnDate,
    studentID,
    bookISBN
)
-- Populates checkedout table with sample data
VALUES
(1,"2022-04-16","2022-04-30",22,9784561354861),(
2,"2022-04-18","2022-05-02",16,9784561354862),(
3,"2022-04-19","2022-05-03",12,9784561354863),(
4,"2022-04-19","2022-05-03",12,9784561354864),(
5,"2022-04-20","2022-05-04",13,9784561354865),(
6,"2022-04-21","2022-05-05",4,9784561354866),(
7,"2022-04-21","2022-05-05",4,9784561354867),(
8,"2022-04-22","2022-05-06",24,9784561354868),(
9,"2022-04-23","2022-05-07",21,9784561354869),(
10,"2022-04-24","2022-05-08",8,97845613548670),(
11,"2022-04-25","2022-05-09",20,9784561354871),(
12,"2022-04-26","2022-05-10",14,9784561354872);





-------------------------
--     Genre Table   --
-------------------------
-- table structure for Genre table 
CREATE OR REPLACE TABLE genre(
    genreID int not null unique auto_increment, 
    genreName varchar(50), 
    primary key (genreID)
);
-- Begin inserting into these columns 
INSERT INTO genre(
    genreID,
    genreName
)
-- Populates genre table with sample data
VALUES
(1,	'biography'),(
2,	'children stories'),(
3,	'fiction'),(
4,	'graphic novel'),(
5,	'non-fiction');


-------------------------
--     Borrow Records   --
-------------------------
-- table structure for borrow_records table 
CREATE OR REPLACE TABLE borrow_records(
    borrowID int not null unique auto_increment, 
    bookID int not null,
    genreID int not null,
    primary key (borrowID)
);
-- Begin inserting into these columns 
INSERT INTO borrow_records(
    borrowID,
    bookID, 
    genreID
)
-- Populates borrow_records table with sample data
VALUES
(1, 1,	3),(
2, 4,	3),(
3, 10,	3),(
4, 16,	1),(
5, 22,	3);


-------------------------
--    Students Table   --
-------------------------
-- table structure for students table 
CREATE OR REPLACE TABLE students(
    studentID int not null unique auto_increment, 
    studentFirstName varchar(50) not null, 
    studentLastName varchar(50) not null, 
    studentEmail varchar(255) not null, 
    primary key (studentID)
);
-- Begin inserting into these colums  
INSERT INTO students (
    studentID,
    studentFirstName,
    studentLastName,
    studentEmail
)
-- Populates student table with sample data
VALUES
(111, 'Thomas', 'Carr', 'tcarr111@anna.edu'),(
112, 'Samantha', 'Jen', 'sjen112@anna.edu'),(
113, 'Ashley', 'Harris', 'aharris113@anna.edu'),(
114, 'Nicole', 'Durham', 'ndurham114@anna.edu'),(
115, 'Joanna', 'Gordon', 'jgordon115@anna.edu'),(
116, 'Andrea', 'Ramos', 'aramos116@anna.edu'),(
117, 'Erika', 'Wright', 'ewright117@anna.edu'),(
118, 'Stacey', 'Coffey', 'scoffey118@anna.edu'),(
119, 'Rachel', 'Wagner', 'rwagner119@anna.edu'),(
120, 'Ronald', 'Williams', 'rwilliams120@anna.edu'),(
121, 'Michael', 'Aguilar', 'maguilar121@anna.edu'),(
122, 'Brittany', 'Knight', 'bknight122@anna.edu'),(
123, 'Vincent', 'Palmer', 'vpalmer123@anna.edu'),(
124, 'Sarah', 'Bennett', 'sbennett124@anna.edu'),(
125, 'Stephen', 'Donovan', 'sdonovan125@anna.edu'),(
126, 'Mark', 'Dickson', 'mdickson126@anna.edu'),(
127, 'Chelsea', 'Gomez', 'cgomez127@anna.edu'),(
128, 'Michelle', 'Johnson', 'mjohnson128@anna.edu'),(
129, 'Juan', 'Stewart', 'jstewart129@anna.edu'),(
130, 'Cynthia', 'Cole', 'ccole130@anna.edu'),(
131, 'Jesus', 'Mcfar', 'jmcfar131@anna.edu'),(
132, 'Sara', 'Robinson', 'srobinson132@anna.edu'),(
133, 'Katherine', 'Lynch', 'klynch133@anna.edu'),(
134, 'Douglas', 'Contreras', 'dcontreras134@anna.edu'),(
135, 'Joseph', 'Powell', 'jpowell135@anna.edu');





-------------------------
--     Subject Table   --
-------------------------
-- table structure for subject table 
CREATE OR REPLACE TABLE subject(
    subjectID int not null unique auto_increment, 
    subjectName varchar(255) not null, 
    subjectCount int not null
);
-- Begin inserting into these colums 
INSERT INTO subject (
    subjectID,
    subjectName,
    subjectCount
)
-- Populates subject table with sample data
VALUES
(1, 'art', 2),(
2, 'cats', 1),(
3, 'diary', 2),(
4, 'dinosaurs', 3),(
5, 'dogs', 1),(
6, 'dragons', 1),(
7, 'duck', 1),(
8, 'fame', 1),(
9, 'family', 5),(
10, 'friends', 3),(
11, 'halloween', 1),(
12, 'hippo', 1),(
13, 'horses', 1),(
14, 'love', 3),(
15, 'magic', 2),(
16, 'minecraft', 1),(
17, 'monsters', 1),(
18, 'music', 1),(
19, 'pets', 1),(
20, 'prince/princess', 1),(
21, 'rock', 1),(
22, 'school', 2),(
23, 'sharks', 1),(
24, 'tennnis', 1),(
25, 'walrus', 1),(
26, 'woman', 1);




-- commit 
SET foreign_KEY_CHECKS=1;
COMMIT;