

# Remedia, a Libray Database App.py file
# Descripton: connects the database to our html forms by implementing flask
# Date: 6/6/2022
# Author: Clara Watson , Jon Moore
# Class : CS 340
#
#
# Sources: modeled on CS340 starter code


from flask import Flask, flash, render_template, json, redirect
from flask_mysqldb import MySQL
from flask import request
import os
import database.db_connector as db

app = Flask(__name__)
db_connection = db.connect_to_database()

#connects to the server 
app.config['MYSQL_HOST'] = 'classmysql.engr.oregonstate.edu'
app.config['MYSQL_USER'] = 'cs340_moorejo3'
app.config['MYSQL_PASSWORD'] = '3673' #last 4 of onid
app.config['MYSQL_DB'] = 'cs340_moorejo3'
app.config['MYSQL_CURSORCLASS'] = "DictCursor"


mysql = MySQL(app)


# routes for home page/dashboard
@app.route('/', methods=["POST", "GET"])

# -----DASHBOARD--------------------------------------------------------
@app.route('/dashboard', methods=["POST", "GET"])
def root():

    if request.method == "POST":
        if request.form.get("checkout"):
            bookISBN = request.form["ISBN"]
            studentID = request.form["studentID"]

            query = "INSERT INTO checkedOut (bookISBN, studentID) VALUES (%s,%s);"
            cur = mysql.connection.cursor()
            cur.execute(query, (bookISBN, studentID))
            
            mysql.connection.commit()
    return render_template('dashboard.j2')
# ---------------------------------------------------------------------    
 
 
    
# -----CATALOG--------------------------------------------------------
@app.route('/catalog', methods=["POST", "GET"])
def catalog():
    if request.method == "GET":
        #populate the books table on the catalog page
        query = "(SELECT books.bookID, books.bookTitle, books.authorName, books.bookPublisher, books.bookYearPublished, books.bookISBN, books.bookCopies FROM books);"
        cur = mysql.connection.cursor()
        cur.execute(query)
        data = cur.fetchall()
        # populate the author table on the catalog page
        query2 = "(SELECT authors.authorID, authors.authorName FROM authors);"
        cur2 = mysql.connection.cursor()
        cur2.execute(query2)
        data2 = cur2.fetchall()
        # populate the genre table on the catalog page
        query3 = "(SELECT genre.genreID, genre.genreName FROM genre);"
        cur3 = mysql.connection.cursor()
        cur3.execute(query3)
        data3 = cur3.fetchall()
        # populate the genre table on the catalog page
        query4 = "(SELECT subject.subjectID, subject.subjectName FROM subject);"
        cur4 = mysql.connection.cursor()
        cur4.execute(query4)
        data4 = cur4.fetchall()
        return render_template('catalog.j2', data=data, data2=data2, data3=data3, data4=data4)
    # Get user input from form to add a book to the table 
    if request.method == "POST":
        # the add book form updates the books database with the new book, and the author database with the new author
        if request.form.get("add_book"):
            bookTitle = request.form["Title"]
            authorName = request.form["authorName"]            
            bookPublisher = request.form["Publisher"]
            bookYearPublished = request.form["Year"]
            bookISBN = request.form["ISBN"]
            bookCopies = request.form["Copies"]
            # updates the book database
            query = "INSERT INTO books (bookTitle, authorName, bookPublisher, bookYearPublished, bookISBN, bookCopies) VALUES (%s,%s,%s,%s,%s,%s);"
            cur = mysql.connection.cursor()
            cur.execute(query, (bookTitle, authorName, bookPublisher, bookYearPublished, bookISBN, bookCopies))
            mysql.connection.commit()
            # updates the author databse
            query3 = "INSERT INTO authors (authorName) VALUES ( %s );" 
            cur3 = mysql.connection.cursor()
            cur3.execute(query3, [authorName])
            mysql.connection.commit()
            #redirects the user back to the catalog page
            return redirect('/catalog')
        # adds an author to the author database   
        if request.form.get("add_author"):
            authorName = request.form["authorName"]
            query = "INSERT INTO authors (authorName) VALUES (%s);"
            cur = mysql.connection.cursor()
            cur.execute(query, [authorName])
            mysql.connection.commit()
            return redirect('/catalog')
        if request.form.get("add_subject"):
            subjectName = request.form["Subject"]
            query = "INSERT INTO subject (subjectName) VALUES (%s);"
            cur = mysql.connection.cursor()
            cur.execute(query, [subjectName])
            mysql.connection.commit()
            return redirect('/catalog')
        if request.form.get("add_genre"):
            genreName = request.form["Genre"]
            query = "INSERT INTO genre (genreName) VALUES (%s);"
            cur = mysql.connection.cursor()
            cur.execute(query, [genreName])
            mysql.connection.commit()
            return redirect('/catalog')
        
    # return back to the catalog page
    return render_template('catalog.j2')
# ---------------------------------------------------------------------


# -----BOOKS-------------------------------------------------------
# route for deleting books
@app.route("/delete_book/<int:bookID>", methods=['GET','POST'])
def delete_book(bookID):
    if request.method== "GET":
        # populates the book being edited
        query = "SELECT * FROM books WHERE bookID = %s;"
        cur = mysql.connection.cursor()
        cur.execute(query, [bookID])
        data = cur.fetchall()
        return render_template("delete_book.j2", data=data)
    # updates the book in the database
    if request.method=="POST":
         # Get user input from form
        if request.form.get("delete_book"):
            bookID = request.form["bookID"]
            query = "DELETE FROM books WHERE bookID = %s;"
            cur = mysql.connection.cursor()
            cur.execute(query, [bookID])
            mysql.connection.commit()
            return redirect ('/catalog')
# route for editing books
@app.route("/edit_book/<int:bookID>", methods=['GET','POST'])
def edit_book(bookID):
    if request.method== "GET":
        # populates the book being edited
        query = "SELECT * FROM books WHERE bookID = %s;"
        cur = mysql.connection.cursor()
        cur.execute(query, [bookID])
        data = cur.fetchall()
        return render_template("edit_book.j2", data=data)
    # updates the book in the database
    if request.method=="POST":
         # Get user input from form
        if request.form.get("edit_book"):
            bookID = request.form["bookID"]
            bookTitle = request.form["title"]
            authorName = request.form["authorName"]
            bookPublisher = request.form["publisher"]
            bookYearPublished = request.form["year"]
            bookISBN = request.form["isbn"]
            bookCopies = request.form["copies"]
            query = "UPDATE books SET bookTitle = %s, authorName = %s, bookPublisher = %s, bookYearPublished = %s, bookISBN = %s, bookCopies = %s WHERE bookID = %s;"
            cur = mysql.connection.cursor()
            cur.execute(query, [bookTitle, authorName, bookPublisher, bookYearPublished, bookISBN, bookCopies, bookID])
            mysql.connection.commit()
            return redirect ('/catalog')
# ---------------------------------------------------------------------


# -----AUTHORS--------------------------------------------------------
# route for deleting authors
@app.route("/delete_author/<int:authorID>")
def delete_author(authorID):
    if request.method== "GET":
        query = "SELECT * FROM authors WHERE authorID = %s;"
        cur = mysql.connection.cursor()
        cur.execute(query, [authorID])
        data = cur.fetchall()
        return render_template("delete_author.j2", data2=data)
    # updates the author in the database
    if request.method=="POST":
        if request.form.get("delete_author"):
            authorID = request.form["authorID"]
            query = "DELETE FROM authors WHERE authorID = %s;"
            cur = mysql.connection.cursor()
            cur.execute(query, [authorID])
            mysql.connection.commit()
        return redirect("/catalog")
# route for editing authors
@app.route("/edit_author/<int:authorID>", methods=['GET','POST'])
def edit_author(authorID):
    # populates the current author being edited
    if request.method== "GET":
        query = "SELECT * FROM authors WHERE authorID = %s;"
        cur = mysql.connection.cursor()
        cur.execute(query, [authorID])
        data = cur.fetchall()
        return render_template("edit_author.j2", data2=data)
    # updates the author in the database
    if request.method=="POST":
        if request.form.get("edit_author"):
            authorID = request.form["authorID"]
            authorName = request.form["authorName"]
            query = "UPDATE authors SET authorName = %s WHERE authorID = %s;"
            cur = mysql.connection.cursor()
            cur.execute(query, (authorName, authorID))
            mysql.connection.commit()
            return redirect ('/catalog')
# ---------------------------------------------------------------------


# -----LOANS PAGE--------------------------------------------------------
# route the loan page, where the user can see books currently checked out
@app.route('/loans', methods=["POST", "GET"])
def loans():
    # populates the loan table
    if request.method == "GET":
        query = "(SELECT checkedOut.checkoutID, checkedOut.checkoutDate, checkedOut.returnDate, checkedOut.studentID, checkedOut.bookISBN FROM checkedOut);"        
        cur = mysql.connection.cursor()
        cur.execute(query)
        data = cur.fetchall()
        
        query2 = "(SELECT borrow_records.borrowID,borrow_records.bookID,borrow_records.genreID  FROM borrow_records);"        
        cur2 = mysql.connection.cursor()
        cur2.execute(query2)
        data2 = cur2.fetchall()
        
        return render_template('loans.j2',  data2=data2, data=data)
    # creates a new loan and adds it to the database
    if request.method == "POST":
        if request.form.get("add_loan"):
            checkoutID = request.form["ID"]
            checkoutDate = request.form["Checkout"]
            returnDate = request.form["Due"]
            studentID = request.form["StudentID"]
            bookISBN = request.form["ISBN"]
            query = "INSERT INTO students (checkoutID, checkoutDate, returnDate, studentID, bookISBN ) VALUES (%s,%s,%s,%s,%s);"
            cur = mysql.connection.cursor()
            cur.execute(query, (checkoutID, checkoutDate, returnDate, studentID, bookISBN))
            mysql.connection.commit()
            return redirect('/loans')
 # route for editing Loans       
@app.route("/edit_loans/<int:checkoutID>", methods=['GET','POST'])
def edit_loans(checkoutID):
    # populates the current laon being edited
    if request.method== "GET":
        query = "SELECT * FROM checkedOut WHERE checkoutID = %s;"
        cur = mysql.connection.cursor()
        cur.execute(query, (checkoutID,))
        data = cur.fetchall()
        return render_template("edit_loans.j2", data=data)
     # updates the loan in the database
    if request.method=="POST":
        query = "DELETE FROM checkedOut WHERE checkoutID = %s;"
        cur = mysql.connection.cursor()
        cur.execute(query, [checkoutID])
        mysql.connection.commit()
        return redirect ('/loans')
# ---------------------------------------------------------------------


# -----STUDENTS PAGE--------------------------------------------------------
# route to the students page, where the user can see and edit current students, as well as add new ones
@app.route('/students', methods=["GET", "POST"])
def students():
    if request.method == "GET":
        # populates the main student table on the student page
        query = "SELECT students.studentID, students.studentFirstName AS 'First', students.studentLastName AS 'Last', students.studentEmail AS 'Email' FROM students;"        
        cur = mysql.connection.cursor()
        cur.execute(query)
        data = cur.fetchall()
        return render_template("students.j2", data=data)
    if request.method == "POST":
        # handles the 'add student' form
        if request.form.get("add_student"):
            # studentID = request.form["ID"]
            studentFirstName = request.form["First"]
            studentLastName = request.form["Last"]
            studentEmail = request.form["Email"]
            query = "INSERT INTO students (studentFirstName, studentLastName, studentEmail) VALUES (%s,%s,%s);"
            cur = mysql.connection.cursor()
            cur.execute(query, (studentFirstName, studentLastName, studentEmail))
            mysql.connection.commit()
            return redirect('/students')
# route for deleting students
@app.route("/delete_student/<int:studentID>", methods=['GET','POST'])
def delete_student(studentID):
    # populates the current student being deleted
    if request.method== "GET":
        query = "SELECT * FROM students WHERE studentID = %s;"
        cur = mysql.connection.cursor()
        cur.execute(query, [studentID])
        data = cur.fetchall()
        return render_template("delete_students.j2", data=data)
    # updates the student in the database
    if request.method=="POST":
        if request.form.get("delete_students"):
            studentID = request.form["studentID"]
            query = "DELETE FROM students WHERE studentID = %s;"
            cur = mysql.connection.cursor()
            cur.execute(query, [studentID])
            mysql.connection.commit()
            return redirect ('/students')
# route for editing students
@app.route("/edit_students/<int:studentID>", methods=['GET','POST'])
def edit_students(studentID):
    # populates the current student being edited
    if request.method== "GET":
        query = "SELECT * FROM students WHERE studentID = %s;"
        cur = mysql.connection.cursor()
        cur.execute(query, [studentID])
        data = cur.fetchall()
        return render_template("edit_students.j2", data=data)
    # updates the student in the database
    if request.method=="POST":
        if request.form.get("edit_students"):
            studentID = request.form["studentID"]
            studentFirstName = request.form["First"]
            studentLastName = request.form["Last"]
            studentEmail = request.form["Email"]
            query = "UPDATE students SET studentFirstName = %s, studentLastName = %s, studentEmail = %s WHERE studentID = %s;"
            cur = mysql.connection.cursor()
            cur.execute(query, (studentFirstName, studentLastName, studentEmail, studentID))
            mysql.connection.commit()
            return redirect ('/students')
# ---------------------------------------------------------------------


    









#executes
if __name__ == "__main__":

    # connect to port on server
    port = int(os.environ.get('PORT', 48519))
    app.run(port=port, debug=True)
