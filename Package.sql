--drop
 drop table Donate;
 drop table BloodBank;
 drop table Donar;
 drop table Patient;
 drop table stock;
 --Create Tables
 
 Create table BloodBank(
    BB_Id integer,
    BB_Name varchar(50),
    BB_Address varchar(50),
    BB_ContactNo varchar(10),
    Primary key(BB_Id),
    check(BB_Name like 'B%')
    );
CREATE SEQUENCE B start with 1 increment by 1;
drop sequence B;
 Create table Donar(
    D_Id integer,
    D_Name varchar(20),
    Blood_Group varchar(5),
    D_Address varchar(20),
    D_ContactNo varchar(10),
    disease varchar(1),
    primary key(D_Id)
    );
    
 create table stock(
    S_Id varchar(3),
    Blood_Group varchar(5),
    s_volume integer,
    primary key(S_Id),
    check(S_Id like 'S%')
    );
    
 Create table Donate(
    Donate_Id varchar(5),
    BB_Id integer,
    D_Id integer,
    DoD date,
    S_Id varchar(3),
    primary key(Donate_Id),
    foreign key(D_Id) references Donar(D_Id),
    foreign key(BB_Id) references BloodBank(BB_Id),
    foreign key(S_Id) references Stock(S_Id),
    check(Donate_Id like 'D%')
    );
    
 Create table Patient(
    P_Id varchar(10),
    P_Name varchar(20) not null,
    Blood_Group varchar(5),
    P_Address varchar(20),
    P_ContactNo varchar(10),
    primary key(P_Id),
    check(P_Id like 'P%')
    );
 
--Insertions

insert into BloodBank values(B.nextval,'BB1','Guindy','211');
insert into  BloodBank values(B.nextval,'BB2','Adyar','212');
insert into  BloodBank values(B.nextval,'BB3','Velachery','213');
insert into  BloodBank values(B.nextval,'BB4','Guindy','214');
insert into  BloodBank values(B.nextval,'BB5','Velachery','215');
insert into  BloodBank values(B.nextval,'BB6','Guindy','216');
insert into  BloodBank values(B.nextval,'BB7','Adyar','217');
insert into  BloodBank values(B.nextval,'BB8','Guindy','218');
insert into  BloodBank values(B.nextval,'BB9','Velachery','219');
insert into  BloodBank values(B.nextval,'BB10','Guindy','220');
  
insert into Donar values(101,'Avanthika','B+','Guindy','22321','N');
insert into Donar values(102,'Babu','O+','Adyar','44321','Y');
insert into Donar values(103,'Mia','O-','Egmore','54672','N');
insert into Donar values(104,'Rio','A+','Marina','76832','N');
insert into Donar values(105,'Varsha','AB+','Adyar','98547','N');
insert into Donar values(106,'Thia','B+','Velachery','87438','N');
insert into Donar values(107,'Guru','O+','Marina','98737','Y');
insert into Donar values(108,'Raja','O-','Guindy','82382','N');
insert into Donar values(109,'Yuki','O+','Guindy','28736','N');
insert into Donar values(110,'Movi','AB-','T-Nagar','72638','N');


insert  into Donate values('D1',4,101,'18/11/2021','S1');
insert  into Donate values('D2',2,103,'21/10/2020','S2');
insert  into Donate values('D3',3,104,'16/09/2021','S3');
insert  into Donate values('D4',1,108,'13/04/2021','S2');
insert  into Donate values('D5',9,106,'12/12/2020','S1');
insert  into Donate values('D6',7,110,'29/01/2021','S4');
insert  into Donate values('D7',5,105,'14/05/2021','S5');
insert  into Donate values('D8',6,110,'24/05/2021','S4');
insert  into Donate values('D9',10,108,'29/12/2020','S2');
insert  into Donate values('D10',7,104,'30/03/2021','S3');
insert  into Donate values('D11',1,101,'11/11/2021','S1');
insert into Donate values('D12',8,102,'12/11/2021','S6');


insert into Patient values('P1','Bili','O+','Guindy','78373');
insert into Patient values('P2','Valli','O-','T-Nagar','38728');
insert into Patient values('P3','Bonnie','AB+','Mylapore','93793');
insert into Patient values('P4','Elena','B-','Adyar','02930');
insert into Patient values('P5','Stefan','A+','Marina','34758');
insert into Patient values('P6','Mike','B+','Velachery','83682');
insert into Patient values('P7','Yuno','O-','Egmore','35532');
insert into Patient values('P8','Shifra','O+','Marina','98272');
insert into Patient values('P9','Mukil','0+','Anna Nagar','92873');
insert into Patient values('P10','Shiv','AB+','Adyar','29839');


insert into Stock values('S1','B+',8);
insert into Stock values('S2','O-',8);
insert into Stock values('S3','A+',4);
insert into Stock values('S4','AB-',4);
insert into Stock values('S5','AB+',4);
insert into Stock values('S6','0+',4);

select * from Patient;
--Queries

--1)Available donars for a particular patient
select distinct d.* from patient p,donar d where p.Blood_Group=d.Blood_Group and p.p_id='P1';

--2)Available healthy donars for a particular patient
select distinct d.* from patient p,donar d where p.Blood_Group=d.Blood_Group and p.p_id='P1'and d.disease='N';

--3)Available nearby bloodbank for a particular patient
select distinct b.BB_Id,b.BB_Name from BloodBank b,Patient p where p.P_Address=b.BB_Address and p.p_id='P10';

--4)Information abt donar and nearby bloodbank for patient have particular blood group
select d.D_Id,d.D_Name,b.* from Bloodbank b,Patient p,Donar d where p.Blood_Group=d.Blood_Group and p.P_Address=b.BB_Address and p.blood_group='O+';


--5)stock OF B+ blood
select DISTINCT s.S_Id,s.volume from stock s,Donate d,Donar d1,Patient p where p.Blood_Group=d1.Blood_Group and d1.Blood_Group=s.blood_group and p.Blood_group='B+';

--6)nearby bloodbank available for donar with did=103
select b.BB_Id,b.BB_Address from BloodBank b,Donar d where d.D_Address = b.BB_Address and d.D_Id=103;

--7)number of donations per donar
select distinct count(*),d1.D_Id  from donar d ,donate d1 where d1.D_Id=d.D_Id  group by d1.D_Id;
select count(*),d1.D_Id from donar d inner join donate d1 on d1.D_Id=d.D_Id group by d1.D_Id;

--8)bloodbank details if patient's blood group and address given
select BB_Id,BB_Name,BB_ContactNo from BloodBank b,Patient p where p.P_Address=b.BB_Address and p.Blood_Group='O+'; 

--9)expiry date for blood
SELECT ADD_MONTHS(Dod, 2) as expiry_date FROM Donate;

--10)donar details
select D_name,D_ContactNo,blood_group,p_name,P_ContactNo from Donar natural join Patient;

--plsql

set serveroutput on
declare
    temp int;
    name Donar.D_Name%TYPE;
    D_BG Donar.Blood_Group%type;
    P_BG Patient.Blood_Group%Type;
    Donar_Address Donar.D_Address%type;
    Patient_Address Patient.P_Address%type;

begin
--11)print the name of particular donar
select D_Name into name from Donar where D_Id=102;
dbms_output.put_line('NAME:' || name);

--12)Nearby Donar available for particular patient
select Blood_group into P_BG from patient where P_Id='P1';
select P_Address into Patient_Address from Patient where p_Id='P1';
temp := 101;
while temp<=110
    loop 
        select D_Name into name from Donar where D_Id=temp;
        select Blood_Group into D_BG from Donar where d_Id=temp;
        select D_Address into Donar_Address from Donar where d_Id=temp;
            if (D_BG=P_BG and Donar_Address=Patient_Address)then
                dbms_output.put_line('Desired Donar:' || temp || ' ' || name ||' ' || D_BG ||' '|| Donar_Address);
            end if;
        temp:=temp+1;
    end loop;
end;
--13)update contact number of particular patient
DECLARE
    total_rows int;
BEGIN
    update patient 
    set  P_ContactNo= 28928
    where P_Id='P10';
    if sql%found then 
        total_rows := sql%rowcount;
        dbms_output.put_line(total_rows || ' updated');
    end if;
end;
--14)next due date for donar to donate blood
DECLARE 
   due_date donate.DoD%TYPE;
   cou int :=0; 
   CURSOR c is 
      SELECT ADD_MONTHS(Dod, 3)into due_date FROM Donate;
BEGIN 
   OPEN c; 
   LOOP 
       FETCH c into due_date; 
       if c%found then
        cou := cou+1;
        dbms_output.put_line(due_date);
       end if;
       EXIT WHEN c%notfound; 
       
   END LOOP; 
   CLOSE c; 
END;

--15)trigger while inserting a donar with disease
create or replace trigger disease_insert
before insert on Donar
for each row
enable
when(NEW.D_Id>100)
begin
    if :NEW.disease='Y' then
        dbms_output.put_line('donar with disease is inserted');
        
    end if;
end;

--insert into Donar values(112,'Mov','A-','T-Nagar','73638','Y');
--delete from Donar where D_Id=112;
--16)trigger while updating address
create or replace trigger loc_change
before update on Donar
for each row
enable
when(NEW.D_Address!=OLD.D_Address)
begin
    dbms_output.put_line('old loc:'|| :OLD.D_Address);
    dbms_output.put_line('new loc:'|| :NEW.D_Address);
END;
--update Donar set D_Address='ABC' where D_Id=112;

--17)update stock volume after blood donation

create or replace trigger check_donate6 before insert on donate
for each row
begin
    update stock set s_volume=s_volume+4 where stock.S_Id=( :new.S_Id) ;
END; 

insert  into Donate values('D13',7,105,'29/12/2021','S5');
delete from donate where donate_id='D13' OR DONATE_ID='D14' OR DONATE_ID='D15' OR DONATE_ID='D16';
select s_volume from stock;
select * from donate;

--18)number of blood banks in particular area
DECLARE 
   bb BloodBank.BB_Id%type;
   ba BloodBank.BB_Address%type;
   cou int :=0; 
   CURSOR c is 
      SELECT BB_Id FROM BloodBank where  BB_Address= &ba; 
BEGIN 
   OPEN c; 
   LOOP 
       FETCH c into bb; 
       if c%found then
        cou := cou+1;
       end if;
       EXIT WHEN c%notfound; 
       
   END LOOP; 
   dbms_output.put_line(cou || ' blood banks available ');
   CLOSE c; 
END;
--19)number of donars for patient
DECLARE 
    did Donar.D_Id%type;
   pbg Patient.Blood_Group%type;
   dbg Donar.Blood_Group%type;
   cou int :=0; 
   CURSOR c is 
      SELECT D_Id FROM Donar where Blood_Group=&pbg;
BEGIN 
   OPEN c; 
   LOOP 
       FETCH c into did; 
       if c%found then
        cou := cou+1;
       end if;
       EXIT WHEN c%notfound; 
       
   END LOOP; 
   dbms_output.put_line(cou || ' donars available ');
   CLOSE c; 
END;

--20)function to calculate total donar
CREATE OR REPLACE FUNCTION totalDonar 
RETURN number IS 
   total integer := 0; 
BEGIN 
   SELECT count(*) into total 
   FROM Donar; 
    
   RETURN total; 
END; 
--calling the function
DECLARE 
   c number(2); 
BEGIN 
   c := totalDonar(); 
   dbms_output.put_line('Total no. of donars: ' || c); 
END; 

--21)bloodbank details if patient's blood group and address given
set serveroutput on
declare
    temp int;
    bname BloodBank.BB_Name%TYPE;
    -- Donar.Blood_Group%type;
    pbg Patient.Blood_Group%Type;
    --Donar_Address Donar.D_Address%type;
    Patient_Address Patient.P_Address%type;
    addr BloodBank.BB_Address%type;
BEGIN
select Blood_group into pbg from patient where Blood_Group=&pbg;
select P_Address into Patient_Address from Patient where P_Address=&Patient_Address;
temp := 1;
while temp<=10
    loop 
        --select D_Name into name from Donar where D_Id=temp;
        select BB_Name into bname from BloodBank where BB_Id=temp;
        select BB_Address into addr from BloodBank where BB_Id=temp;
        --select Blood_Group into D_BG from Donar where d_Id=temp;
        --select D_Address into Donar_Address from Donar where d_Id=temp;
            if ( Patient_Address=addr)then
                dbms_output.put_line('Desired BB:' || temp || ' ' || bname ||' ' || addr);
            end if;
        temp:=temp+1;
    end loop;
end;

