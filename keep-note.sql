create database qwe1;
use qwe1;
CREATE TABLE User (
    user_id VARCHAR(10) PRIMARY KEY ,
    user_name VARCHAR(20),
    user_added_date DATETIME,
    user_password VARCHAR(20),
    user_mobile VARCHAR(10)
);
CREATE TABLE Note (
    note_id INT PRIMARY KEY ,
    note_title VARCHAR(20),
    note_content VARCHAR(100),
    note_status VARCHAR(10),
    note_creation_date DATETIME
);
CREATE TABLE Category (
    category_id INT PRIMARY KEY ,
    category_name VARCHAR(20),
    category_descr VARCHAR(100),
    category_creation_date DATETIME,
    category_creator VARCHAR(20)
);
CREATE TABLE Reminder (
    reminder_id INT PRIMARY KEY ,
    reminder_name VARCHAR(20),
    reminder_descr VARCHAR(100),
    reminder_type VARCHAR(20),
    reminder_creation_date DATETIME,
    reminder_creator VARCHAR(20)
    
);
CREATE TABLE UserNote (
    usernote_id INT PRIMARY KEY,
    user_id VARCHAR(10),
    note_id INT,
    FOREIGN KEY fk_UserNote_note_id (user_id)
        REFERENCES User (user_id),
    FOREIGN KEY fk_UserNote_note_id (note_id)
        REFERENCES Note (note_id)
);
CREATE TABLE NoteReminder (
    notereminder_id INT PRIMARY KEY,
    note_id INT,
    reminder_id INT,
    FOREIGN KEY fk_NoteReminder_category_id (reminder_id)
        REFERENCES Reminder (reminder_id),
    FOREIGN KEY fk_NoteReminder_note_id (note_id)
        REFERENCES Note (note_id)
);
CREATE TABLE NoteCategory (
    notecategory_id INT PRIMARY KEY,
    note_id INT,
    category_id INT,
    FOREIGN KEY fk_NoteCategory_category_id (category_id)
        REFERENCES Category (category_id),
    FOREIGN KEY fk_NoteCategory_note_id (note_id)
        REFERENCES Note (note_id)
);
insert into User values("1", "Dpk", '2018-06-15', "root", "8680853912");
insert into User values("2", "Abc", '2018-06-14', "root1", "8680853911");
insert into Note values(1, "Note1", "This is note1", "1", "2018-06-15");
insert into Note values(2, "Note2", "This is note2", "2", "2018-06-14");
insert into Category values(1, "Cat1", "This is cat1", "2018-06-15", "Dpk");
insert into Category values(2, "Cat2", "This is cat2", "2018-06-14", "Abc");
insert into Reminder values(1, "Rem1", "This is rem1", "type1", "2018-06-15", "Dpk");
insert into Reminder values(2, "Rem2", "This is rem2", "type2", "2018-06-14", "Abc");
insert into UserNote values(100, "1", 1);
insert into UserNote values(200, "2", 2);
insert into NoteReminder values(1, 1, 1);
insert into NoteReminder values(2, 2, 2);
insert into NoteCategory values(1, 1, 1);
insert into NoteCategory values(2, 2, 2);
SELECT 
    *
FROM
    User
WHERE
    user_id = 1 AND user_password = 'root';
SELECT 
    *
FROM
    Note
WHERE
    note_creation_date = '2018-06-15';
SELECT 
    *
FROM
    Category
WHERE
    category_creation_date > '2018-06-14';
SELECT 
    note_id
FROM
    UserNote
WHERE
    user_id = 1;
UPDATE Note 
SET 
    note_title = 'Note01',
    note_content = 'This is note01',
    note_status = FALSE,
    note_creation_date = '2017-06-15'
WHERE
    note_id = 1;
SELECT 
    *
FROM
    Note
        INNER JOIN
    UserNote ON Note.note_id = UserNote.note_id
WHERE
    UserNote.user_id = 2;
SELECT 
    *
FROM
    Note
        INNER JOIN
    NoteCategory ON Note.note_id = NoteCategory.note_id
WHERE
    NoteCategory.category_id = 2;
SELECT 
    *
FROM
    Reminder
        INNER JOIN
    NoteReminder ON NoteReminder.reminder_id = Reminder.reminder_id
WHERE
    NoteReminder.note_id = 2;
SELECT 
    *
FROM
    Reminder
WHERE
    reminder_id = 1;
insert into Note values(4, "Note4", "This is note4", "0", "2018-06-19");
insert into Note values(5, "Note5", "This is note5", "0", "2018-06-20");
insert into NoteCategory values(3,2,2);
insert into Reminder values(3, "Rem3", "This is rem3", "type1", "2018-06-10", "Dpk");
insert into NoteReminder values(3, 2,2);
DELETE FROM UserNote 
WHERE
    note_id = 1;
DELETE FROM NoteReminder 
WHERE
    note_id = 1;
DELETE FROM NoteCategory 
WHERE
    note_id = 1;
DELETE FROM Note 
WHERE
    note_id = 1;
DELETE FROM NoteCategory 
WHERE
    note_id = 2;
DELETE FROM NoteReminder 
WHERE
    note_id = 2;
DELETE FROM UserNote 
WHERE
    note_id = 2;
DELETE FROM Note 
WHERE
    note_id = 2;
DELIMITER //
create trigger del_note before delete on Note FOR EACH ROW Begin delete from UserNote where note_id=old.note_id; delete from NoteReminder where note_id=old.note_id; delete from NoteCategory where note_id=old.note_id; END; //
DELIMITER ;
DELETE FROM Note 
WHERE
    note_id = 3;
DELIMITER //
create trigger del_user before delete on User FOR EACH ROW Begin delete from UserNote where note_id=old.user_id; delete from NoteReminder where note_id=old.user_id; delete from NoteCategory where note_id=old.user_id; END; //
DELIMITER ;
DELETE FROM User 
WHERE
    user_id = '1';