-- create database testdb;

-- use testdb;

DROP TABLE IF EXISTS USER;

CREATE TABLE  USER (
    user_id varchar(20) PRIMARY KEY,
    user_name VARCHAR(50) NOT NULL,
    user_added_date datetime,
    user_password VARCHAR(50),
    user_mobile NUMERIC(10)
);

DROP TABLE IF EXISTS NOTE;
CREATE TABLE NOTE (
    note_id varchar(20) PRIMARY KEY,
    note_title VARCHAR(100),
    note_content VARCHAR(1000),
    note_status VARCHAR(50),
    note_creation_date datetime
);

DROP TABLE IF EXISTS CATEGORY;
CREATE TABLE CATEGORY (
    category_id varchar(20) PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    category_descr VARCHAR(1000),
    category_creation_date datetime,
    category_creator VARCHAR(50)
);

DROP TABLE IF EXISTS REMINDER;
CREATE TABLE REMINDER (
    reminder_id varchar(20) PRIMARY KEY,
    reminder_name VARCHAR(100) NOT NULL,
    reminder_descr VARCHAR(1000),
    reminder_type VARCHAR(50),
    reminder_creation_date datetime,
    reminder_creator VARCHAR(50)
);

DROP TABLE IF EXISTS NoteCategory;
CREATE TABLE NoteCategory (
    notecategory_id varchar(20) PRIMARY KEY,
    note_id varchar(20),
    category_id varchar(20),
    FOREIGN KEY (note_id)
        REFERENCES NOTE (note_id),
    FOREIGN KEY (category_id)
        REFERENCES CATEGORY (category_id)
);

DROP TABLE IF EXISTS Notereminder;
CREATE TABLE Notereminder (
    notereminder_id varchar(20) PRIMARY KEY,
    note_id varchar(20),
    reminder_id varchar(20),
    FOREIGN KEY (note_id)
        REFERENCES NOTE (note_id),
    FOREIGN KEY (reminder_id)
        REFERENCES REMINDER (reminder_id)
);

DROP TABLE IF EXISTS usernote;
CREATE TABLE usernote (
    usernote_id varchar(20) PRIMARY KEY,
    user_id varchar(20),
    note_id varchar(20),
    FOREIGN KEY (note_id)
        REFERENCES NOTE (note_id),
    FOREIGN KEY (user_id)
        REFERENCES USER (user_id)
);

INSERT into USER(user_id, user_name, user_password, user_mobile) values (1,'Rupa Devi','xyz',6565265);

INSERT into NOTE(note_id, note_title, note_content, note_status) values (1,'class notes','fsdafjbkfjbkdbfkdbfkdbfksdbfkdsbfjkbdjfbd','in-progress');

insert into CATEGORY(category_id, category_name, category_descr, category_creator)
values (1,'Studies','notes about class','Rupa Devi');

INSERT INTO REMINDER(reminder_id, reminder_name, reminder_descr, reminder_type,  reminder_creator)
values (1,'Morning reminder','remind me in everyday morning','DAILY','Rupa Devi');

insert into NoteCategory(notecategory_id, note_id, category_id) values(1,1,1);

insert into Notereminder(notereminder_id, note_id, reminder_id) values(1,1,1);

insert into usernote(usernote_id, user_id, note_id) values(1,1,1);

SELECT * FROM USER where user_id = 'Rupa Devi' and user_password = 'xyz';
    
SELECT * FROM NOTE where note_creation_date = '2019-11-27 13:30:29';   
    
select * From CATEGORY where category_creation_date > '2019-01-01 00:00:00';

select note_id from usernote where user_id = '1';

update NOTE set note_content= ''  where note_id = '1';

select * from NOTE n join usernote un on un.note_id = n.note_id where un.user_id = '1';

select * from NOTE n join NoteCategory nc on nc.note_id = n.note_id where nc.category_id = '1';

Select * from REMINDER r join Notereminder nr on r.reminder_id = nr.reminder_id where nr.note_id = '1';

Select * from REMINDER  where reminder_id = '1';

INSERT into NOTE(note_id, note_title, note_content, note_status) values (2,'class notes2','fsdafjbkfjbkdbfkdbfkdbfksdbfkdsbfjkbdjfbd','in-progress');

insert into usernote(usernote_id, user_id, note_id) values(2,1,2);

INSERT into NOTE(note_id, note_title, note_content, note_status) values (3,'class notes3','fsdafjbkfjbkdbfkdbfkdbfksdbfkdsbfjkbdjfbd','in-progress');

insert into NoteCategory(notecategory_id, note_id, category_id) values(3,1,1);

INSERT INTO REMINDER(reminder_id, reminder_name, reminder_descr, reminder_type,  reminder_creator)
values (2,'Afternoon reminder','remind me in everyday afternoon','DAILY','Rupa Devi');

insert into Notereminder(notereminder_id, note_id, reminder_id) values(1,2,2);

delete from UserNote where note_id=1;
delete from NoteReminder where note_id=1;
delete from NoteCategory where note_id=1;
delete from Note where note_id=1;
delete from NoteCategory where note_id=2;
delete from NoteReminder where note_id=2;
delete from UserNote where note_id=2;
delete from Note where note_id=2;

DELIMITER //
create trigger del_note before delete on Note FOR EACH ROW Begin delete from UserNote where note_id=old.note_id; delete from NoteReminder where note_id=old.note_id; delete from NoteCategory where note_id=old.note_id; END; //
DELIMITER ;
delete from Note where note_id=3;
DELIMITER //
create trigger del_user before delete on User FOR EACH ROW Begin delete from UserNote where note_id=old.user_id; delete from NoteReminder where note_id=old.user_id; delete from NoteCategory where note_id=old.user_id; END; //
DELIMITER ;
delete from User where user_id="1";