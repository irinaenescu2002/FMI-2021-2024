-- TABELUL ANGAJATI 
create table angajati 
(
    cod_angajat number(3) constraint cod_angajat_pk primary key,
    nume varchar2(50) not null constraint nume_angajat_initiale_mari check (nume=initcap(nume)),
    prenume varchar2(50) not null constraint prenume_angajat_initiale_mari check (prenume=initcap(prenume)),
    telefon varchar2(10) not null unique,
    email varchar2(50) not null unique constraint email_angajat_format check (email=lower(email) and email like '%@akira.com'),
    data_angajarii date not null, 
    salariu number(4) not null constraint salariu_angajat_valid check (salariu > 1800),
    nivel varchar2(20) constraint nivel_angajat_tip check (nivel in ('incepator', 'elementar', 'intermediar', 'avansat', 'profesionist'))
);


-- TABELUL CLIENTI
create table clienti
(
    cod_client number(3) constraint cod_client_pk primary key,
    nume varchar2(50) not null constraint nume_client_initiale_mari check (nume=initcap(nume)),
    prenume varchar2(50) not null constraint prenume_client_initiale_mari check (prenume=initcap(prenume)),
    data_nasterii date not null,
    telefon varchar2(10) not null unique,
    nivel varchar2(20) constraint nivel_client_tip check (nivel in ('incepator', 'elementar', 'intermediar', 'avansat', 'profesionist'))
);


-- TABELUL CATEGORII 
create table categorii 
(
    cod_categorie number(3) constraint cod_categorie_pk primary key,
    tip varchar2(100) not null constraint tip_categorie check (tip in ('dresaj', 'sarituri peste obstacole', 'plimbari pe teren accidentat', 'plimbari simple', 'reining')),
    pret_ora_echitatie number(2) not null
);


-- TABELUL FIRME_RESURSE 
create table firme_resurse
( 
    cod_firma number(6) constraint cod_firma_pk primary key,
    nume varchar2(50) not null constraint nume_firma_initiale_mari check (nume=initcap(nume)),
    data_infiintare date not null,
    telefon varchar2(10) not null unique,
    email varchar2(50) not null unique constraint email_firma_format check (email=lower(email) and email like '%@%'),
    tara_sediu varchar2(50) not null constraint tara_sediu_firma_format check (tara_sediu=initcap(tara_sediu)),
    judet_sediu varchar2(50) not null constraint judet_sediu_firma_format check (judet_sediu=initcap(judet_sediu)),
    oras_sediu varchar2(50) not null constraint oras_sediu_firma_format check (oras_sediu=initcap(oras_sediu)),
    strada_sediu varchar2(50) not null constraint strada_sediu_firma_format check (strada_sediu=initcap(strada_sediu)),
    numar_sediu number(3) not null, 
    tip_resurse varchar2(50) not null constraint tip_resurse_firma check (tip_resurse in ('hrana', 'medicamente', 'echipament sportiv')) 
);


-- TABELUL CABINETE_VETERINARE 
create table cabinete_veterinare
( 
    cod_cabinet number(6) constraint cod_cabinet_pk primary key,
    nume varchar2(50) not null constraint nume_cabinet_initiale_mari check (nume=initcap(nume)),
    specializare varchar2(50) not null,
    data_infiintare date not null,
    telefon varchar2(10) not null unique,
    email varchar2(50) not null unique constraint email_cabinet_format check (email=lower(email) and email like '%@%'),
    tara varchar2(50) not null constraint tara_cabinet_format check (tara=initcap(tara)),
    judet varchar2(50) not null constraint judet_cabinet_format check (judet=initcap(judet)),
    oras varchar2(50) not null constraint oras_cabinet_format check (oras=initcap(oras)),
    strada varchar2(50) not null constraint strada_cabinet_format check (strada=initcap(strada)),
    numar number(3) not null
);


-- TABELUL CENTRE_DRESAJ 
create table centre_dresaj
( 
    cod_centru number(6) constraint cod_centru_pk primary key,
    nume varchar2(50) not null constraint nume_centru_initiale_mari check (nume=initcap(nume)),
    data_infiintare date not null,
    telefon varchar2(10) not null unique,
    email varchar2(50) not null unique constraint email_centru_format check (email=lower(email) and email like '%@%'),
    tara varchar2(50) not null constraint tara_centru_format check (tara=initcap(tara)),
    judet varchar2(50) not null constraint judet_centru_format check (judet=initcap(judet)),
    oras varchar2(50) not null constraint oras_centru_format check (oras=initcap(oras)),
    strada varchar2(50) not null constraint strada_centru_format check (strada=initcap(strada)),
    numar number(3) not null, 
    cod_categorie number(3) not null references categorii(cod_categorie)
);


-- TABELUL MEDICI 
create table medici
(
    cod_medic number(3) constraint cod_medic_pk primary key,
    nume varchar2(50) not null constraint nume_medic_initiale_mari check (nume=initcap(nume)),
    prenume varchar2(50) not null constraint prenume_medic_initiale_mari check (prenume=initcap(prenume)),
    telefon varchar2(10) not null unique,
    email varchar2(50) not null unique constraint email_medic_format check (email=lower(email) and email like '%@%'),
    cod_cabinet number(6) references cabinete_veterinare(cod_cabinet)
);


-- TABELUL LOCATII
create table locatii
( 
    cod_locatie number(4) constraint cod_locatie_pk primary key,
    tara_depozit varchar2(50) not null constraint tara_depozit_format check (tara_depozit=initcap(tara_depozit)),
    judet_depozit varchar2(50) not null constraint judet_depozit_format check (judet_depozit=initcap(judet_depozit)),
    oras_depozit varchar2(50) not null constraint oras_depozit_format check (oras_depozit=initcap(oras_depozit)),
    strada_depozit varchar2(50) not null constraint strada_depozit_format check (strada_depozit=initcap(strada_depozit)),
    numar_depozit number(3) not null, 
    cod_firma number(6) not null references firme_resurse(cod_firma)
);


-- TABELUL CAI 
create table cai 
(
    cod_cal number(2) constraint cod_cal_pk primary key,
    nume varchar2(50) not null constraint nume_cal_initiale_mari check (nume=initcap(nume)),
    sex varchar2(1) not null constraint tip_sex check (sex in ('M', 'F')), 
    rasa varchar2(30) not null, 
    culoare varchar2(30) not null,
    data_nasterii date not null,
    cod_centru_dresaj number(6) not null references centre_dresaj(cod_centru)
);


-- TABELUL CONSULTATII 
create table consultatii 
(
   data_consultatie date not null, 
   cod_medic number(3) not null, 
   cod_cal number(2) not null, 
   rezultat varchar2(100) not null, 
   primary key(data_consultatie, cod_medic, cod_cal),
   foreign key (cod_medic) references medici(cod_medic),
   foreign key (cod_cal) references cai(cod_cal)
);


-- TABELUL PROGRAME_CLIENT
create table programe_client 
(
    ora_inceput varchar2(10) not null, 
    ora_sfarsit varchar2(10) not null, 
    ora_inceput_pauza varchar2(10) not null, 
    ora_sfarsit_pauza varchar2(10) not null, 
    primary key (ora_inceput, ora_sfarsit)
);


-- TABELUL PROGRAME_BOXA
create table programe_boxa 
(
    ora_inceput varchar2(10) not null, 
    ora_sfarsit varchar2(10) not null, 
    primary key (ora_inceput, ora_sfarsit)
);


-- TABELUL CONTRACTE 
create table contracte 
(
    data_incheiere date not null,
    cod_angajat number(3) not null, 
    cod_firma number(6) not null, 
    zile_valabilitate number(4),
    primary key (data_incheiere, cod_angajat, cod_firma),
    foreign key (cod_angajat) references angajati(cod_angajat),
    foreign key (cod_firma) references firme_resurse(cod_firma)
);


-- TABELUL AVIZE 
create table avize
(
    numar_inregistrare number(6) constraint numar_inregistrare_aviz_pk primary key, 
    data_emitere date not null,
    data_predare date not null, 
    doctor varchar2(50) not null constraint doctor_initiale_majuscule check (doctor=initcap(doctor)),
    cod_client number(3) not null references clienti(cod_client)
);


-- TABELUL PROGRAMARI 
create table programari 
(
    data_programare date not null,
    ora_inceput varchar2(10) not null, 
    ora_final varchar2(10) not null, 
    cod_client number(3) not null,
    cod_angajat number(3) not null, 
    cod_cal number(3) not null,
    cost number(3) not null, 
    primary key (data_programare, ora_inceput, ora_final),
    foreign key (ora_inceput, ora_final) references programe_client(ora_inceput, ora_sfarsit),
    foreign key (cod_client) references clienti(cod_client),
    foreign key (cod_angajat) references angajati(cod_angajat),
    foreign key (cod_cal) references cai(cod_cal)
);


-- TABELUL INGRIJIRI 
create table ingrijiri 
(
    data_ingrijire date not null,
    ora_inceput varchar2(10) not null, 
    ora_final varchar2(10) not null, 
    cod_angajat number(3) not null, 
    cod_cal number(3) not null,
    observatie varchar2(50), 
    primary key (data_ingrijire, ora_inceput, ora_final, cod_angajat),
    foreign key (ora_inceput, ora_final) references programe_boxa(ora_inceput, ora_sfarsit),
    foreign key (cod_angajat) references angajati(cod_angajat),
    foreign key (cod_cal) references cai(cod_cal)
);


-- SECVENTA CHEIE PRIMARA ANGAJAT
create sequence secventa_pk_angajat
increment by 1
start with 100;


-- SECVENTA CHEIE PRIMARA CLIENT
create sequence secventa_pk_client
increment by 1
start with 200;


-- SECVENTA CHEIE PRIMARA CAL
create sequence secventa_pk_cal
increment by 1
start with 10;


-- INSERARE DE DATE IN TABELUL ANGAJATI
BEGIN

insert into angajati(cod_angajat, nume, prenume, telefon, email, data_angajarii, salariu, nivel)
values (SECVENTA_PK_ANGAJAT.nextval, 'Petrescu', 'Livia Ana', '0734786345', 'petrescu.livia-ana@akira.com', to_date('02-02-2010', 'dd-mm-yyyy'), 4500, 'profesionist');

insert into angajati(cod_angajat, nume, prenume, telefon, email, data_angajarii, salariu, nivel)
values (SECVENTA_PK_ANGAJAT.nextval, 'Preda', 'Mircea', '0739872445', 'preda.mircea@akira.com', to_date('07-09-2012', 'dd-mm-yyyy'), 2300, 'avansat');

insert into angajati(cod_angajat, nume, prenume, telefon, email, data_angajarii, salariu, nivel)
values (SECVENTA_PK_ANGAJAT.nextval, 'Radu', 'Andrei', '0786432900', 'radu.andrei@akira.com', to_date('12-10-2013', 'dd-mm-yyyy'), 2100, 'elementar');

insert into angajati(cod_angajat, nume, prenume, telefon, email, data_angajarii, salariu, nivel)
values (SECVENTA_PK_ANGAJAT.nextval, 'Dima', 'Raluca', '0765480999', 'dima.raluca@akira.com', to_date('12-10-2013', 'dd-mm-yyyy'), 4000, 'profesionist');

insert into angajati(cod_angajat, nume, prenume, telefon, email, data_angajarii, salariu, nivel)
values (SECVENTA_PK_ANGAJAT.nextval, 'Ionescu', 'Cristian George', '0754087662', 'ionescu.cristian-george@akira.com', to_date('22-07-2020', 'dd-mm-yyyy'), 1900, 'incepator');

insert into angajati(cod_angajat, nume, prenume, telefon, email, data_angajarii, salariu, nivel)
values (SECVENTA_PK_ANGAJAT.nextval, 'Dumitru', 'Marian', '0744326755', 'dumitru.marian@akira.com', to_date('01-12-2021', 'dd-mm-yyyy'), 2000, null);

insert into angajati(cod_angajat, nume, prenume, telefon, email, data_angajarii, salariu, nivel)
values (SECVENTA_PK_ANGAJAT.nextval, 'Voinea', 'Elena', '0734987655', 'voinea.elena@akira.com', to_date('02-03-2020', 'dd-mm-yyyy'), 3650, 'avansat');

insert into angajati(cod_angajat, nume, prenume, telefon, email, data_angajarii, salariu, nivel)
values (SECVENTA_PK_ANGAJAT.nextval, 'Albu', 'Mihai Iustin', '0766432900', 'albu.mihai-iustin@akira.com', to_date('05-08-2019', 'dd-mm-yyyy'), 5000, 'profesionist');

insert into angajati(cod_angajat, nume, prenume, telefon, email, data_angajarii, salariu, nivel)
values (SECVENTA_PK_ANGAJAT.nextval, 'Mihaiu', 'Bogdan', '0765112309', 'mihaiu.bogdan@akira.com', to_date('30-09-2017', 'dd-mm-yyyy'), 2800, 'intermediar');

END;
/


-- INSERARE DE DATE IN TABELUL CLIENTI
BEGIN 

insert into clienti(cod_client, nume, prenume, data_nasterii, telefon, nivel)
values (SECVENTA_PK_CLIENT.nextval, 'Udrea', 'Robert George', to_date('16-11-2002', 'dd-mm-yyyy'), '0756432990', null);

insert into clienti(cod_client, nume, prenume, data_nasterii, telefon, nivel)
values (SECVENTA_PK_CLIENT.nextval, 'Popescu', 'Miruna Georgiana', to_date('17-10-2005', 'dd-mm-yyyy'), '0752139800', 'elementar');

insert into clienti(cod_client, nume, prenume, data_nasterii, telefon, nivel)
values (SECVENTA_PK_CLIENT.nextval, 'Luca', 'Ionel', to_date('23-09-2003', 'dd-mm-yyyy'), '0750987123', 'incepator');

insert into clienti(cod_client, nume, prenume, data_nasterii, telefon, nivel)
values (SECVENTA_PK_CLIENT.nextval, 'Cristea', 'Larisa', to_date('01-01-2002', 'dd-mm-yyyy'), '0776543289', 'profesionist');

insert into clienti(cod_client, nume, prenume, data_nasterii, telefon, nivel)
values (SECVENTA_PK_CLIENT.nextval, 'Costea', 'Mihnea', to_date('12-05-2009', 'dd-mm-yyyy'), '0755438907', 'incepator');

insert into clienti(cod_client, nume, prenume, data_nasterii, telefon, nivel)
values (SECVENTA_PK_CLIENT.nextval, 'Preda', 'Denisa', to_date('06-03-2004', 'dd-mm-yyyy'), '0763597664', 'elementar');

insert into clienti(cod_client, nume, prenume, data_nasterii, telefon, nivel)
values (SECVENTA_PK_CLIENT.nextval, 'Paun', 'Nicoleta', to_date('19-12-2003', 'dd-mm-yyyy'), '0787324553', 'intermediar');

insert into clienti(cod_client, nume, prenume, data_nasterii, telefon, nivel)
values (SECVENTA_PK_CLIENT.nextval, 'Dobrescu', 'Teodora Maria', to_date('05-09-2004', 'dd-mm-yyyy'), '0767332896', 'avansat');

insert into clienti(cod_client, nume, prenume, data_nasterii, telefon, nivel)
values (SECVENTA_PK_CLIENT.nextval, 'Teodorescu', 'Mihai', to_date('04-09-2001', 'dd-mm-yyyy'), '0768543200', 'incepator');

insert into clienti(cod_client, nume, prenume, data_nasterii, telefon, nivel)
values (SECVENTA_PK_CLIENT.nextval, 'Savu', 'Iulia', to_date('28-02-2006', 'dd-mm-yyyy'), '0788934756', 'incepator');

END;
/


-- INSERARE DE DATE IN TABELUL CATEGORII
BEGIN 

insert into categorii(cod_categorie, tip, pret_ora_echitatie)
values (1, 'dresaj', 50);

insert into categorii(cod_categorie, tip, pret_ora_echitatie)
values (2, 'sarituri peste obstacole', 60);

insert into categorii(cod_categorie, tip, pret_ora_echitatie)
values (3, 'plimbari pe teren accidentat', 40);

insert into categorii(cod_categorie, tip, pret_ora_echitatie)
values (4, 'reining', 50);

insert into categorii(cod_categorie, tip, pret_ora_echitatie)
values (5, 'plimbari simple', 30);

END;
/ 


-- INSERARE DE DATE IN TABELUL FIRME_RESURSE
BEGIN

insert into firme_resurse(cod_firma, nume, data_infiintare, telefon, email, tara_sediu, judet_sediu, oras_sediu, strada_sediu, numar_sediu, tip_resurse)
values (100101, 'Horse Vet', to_date('28-09-1989', 'dd-mm-yyyy'), '0345000222', 'contact@horsevet.com', 'Romania', 'Prahova', 'Ploiesti', 'Mihai Eminescu', 352, 'medicamente');

insert into firme_resurse(cod_firma, nume, data_infiintare, telefon, email, tara_sediu, judet_sediu, oras_sediu, strada_sediu, numar_sediu, tip_resurse)
values (100202, 'Equestria', to_date('07-12-2000', 'dd-mm-yyyy'), '0211000567', 'contact.us@equestria.com', 'Romania', 'Iasi', 'Iasi', 'Zambilelor', 24, 'echipament sportiv');

insert into firme_resurse(cod_firma, nume, data_infiintare, telefon, email, tara_sediu, judet_sediu, oras_sediu, strada_sediu, numar_sediu, tip_resurse)
values (100303, 'Equine Food', to_date('13-11-1990', 'dd-mm-yyyy'), '0380999111', 'food.for.you@equine.com', 'Romania', 'Bucuresti', 'Sector 6', 'Primaverii', 349, 'hrana');

insert into firme_resurse(cod_firma, nume, data_infiintare, telefon, email, tara_sediu, judet_sediu, oras_sediu, strada_sediu, numar_sediu, tip_resurse)
values (100404, 'Food For H', to_date('01-01-2004', 'dd-mm-yyyy'), '0243555000', 'food@foodforh.com', 'Romania', 'Constanta', 'Mangalia', 'Rozelor', 21, 'hrana');

insert into firme_resurse(cod_firma, nume, data_infiintare, telefon, email, tara_sediu, judet_sediu, oras_sediu, strada_sediu, numar_sediu, tip_resurse)
values (100505, 'Equine Equipment', to_date('21-03-2001', 'dd-mm-yyyy'), '0244909010', 'equipment@equinelife.com', 'Franta', 'Normandie', 'Caen', 'Basse', 27, 'echipament sportiv');

END;
/


-- INSERARE DE DATE IN TABELUL LOCATII
BEGIN

insert into locatii (cod_locatie, tara_depozit, judet_depozit, oras_depozit, strada_depozit, numar_depozit, cod_firma)
values (101, 'Romania', 'Bucuresti', 'Sector 6', 'Tudor Vladimirescu', 87, 100101);

insert into locatii (cod_locatie, tara_depozit, judet_depozit, oras_depozit, strada_depozit, numar_depozit, cod_firma)
values (202, 'Romania', 'Ilfov', 'Chiajna', 'Garii', 34, 100202);

insert into locatii (cod_locatie, tara_depozit, judet_depozit, oras_depozit, strada_depozit, numar_depozit, cod_firma)
values (303, 'Romania', 'Prahova', 'Magurele', 'Narciselor', 523, 100202);

insert into locatii (cod_locatie, tara_depozit, judet_depozit, oras_depozit, strada_depozit, numar_depozit, cod_firma)
values (404, 'Romania', 'Timisoara', 'Timisoara', 'Libertatii', 129, 100404);

insert into locatii (cod_locatie, tara_depozit, judet_depozit, oras_depozit, strada_depozit, numar_depozit, cod_firma)
values (505, 'Romania', 'Bacau', 'Bacau', 'Independentei', 21, 100303);

insert into locatii (cod_locatie, tara_depozit, judet_depozit, oras_depozit, strada_depozit, numar_depozit, cod_firma)
values (606, 'Romania', 'Ilfov', 'Voluntari', 'Veronica Micle', 78, 100505);

insert into locatii (cod_locatie, tara_depozit, judet_depozit, oras_depozit, strada_depozit, numar_depozit, cod_firma)
values (707, 'Franta', 'Occitanie', 'Toulouse', 'Jacques Chirac', 653, 100505);

insert into locatii (cod_locatie, tara_depozit, judet_depozit, oras_depozit, strada_depozit, numar_depozit, cod_firma)
values (808, 'Moldova', 'Chisinau', 'Chisinau', 'Unirii', 23, 100303);

END;
/


-- INSERARE DE DATE IN TABELUL PROGRAME_BOXA
BEGIN

insert into programe_boxa
values ('07:00', '07:30');

insert into programe_boxa
values ('07:30', '08:00');

insert into programe_boxa
values ('08:00', '08:30');

insert into programe_boxa
values ('08:30', '09:00');

insert into programe_boxa
values ('09:00', '09:30');

insert into programe_boxa
values ('09:30', '10:00');

insert into programe_boxa
values ('10:00', '10:30');

insert into programe_boxa
values ('10:30', '11:00');

insert into programe_boxa
values ('19:00', '19:30');

insert into programe_boxa
values ('19:30', '20:00');

insert into programe_boxa
values ('20:00', '20:30');

insert into programe_boxa
values ('20:30', '21:00');

insert into programe_boxa
values ('21:00', '21:30');

END;
/


-- INSERARE DE DATE IN TABELUL PROGRAME_CLIENT
BEGIN

insert into programe_client
values ('11:00', '12:00', '11:25', '11:30');

insert into programe_client
values ('12:00', '13:00', '12:25', '12:30');

insert into programe_client
values ('13:00', '14:00', '13:25', '13:30');

insert into programe_client
values ('14:00', '15:00', '14:25', '14:30');

insert into programe_client
values ('15:00', '16:00', '15:25', '15:30');

insert into programe_client
values ('16:00', '17:00', '16:25', '16:30');

insert into programe_client
values ('17:00', '18:00', '17:25', '17:30');

insert into programe_client
values ('18:00', '19:00', '18:25', '18:30');

END;
/


-- INSERARE DE DATE IN TABELUL CABINETE_VETERINARE
BEGIN

insert into cabinete_veterinare(cod_cabinet, nume, specializare, data_infiintare, telefon, email, tara, judet, oras, strada, numar)
values (111111, 'Animal Vet', 'endoscopie', to_date('19-10-1999', 'dd-mm-yyyy'), '0255675435', 'contact.vet@animalvet.com', 'Romania', 'Ilfov', 'Chiajna', 'Barbu Vacarescu', 89);

insert into cabinete_veterinare(cod_cabinet, nume, specializare, data_infiintare, telefon, email, tara, judet, oras, strada, numar)
values (222222, 'Vet For You', 'vaccinare', to_date('25-08-2014', 'dd-mm-yyyy'), '0355110990', 'vet4u@vet.com', 'Romania', 'Iasi', 'Iasi', 'Primaverii', 234);

insert into cabinete_veterinare(cod_cabinet, nume, specializare, data_infiintare, telefon, email, tara, judet, oras, strada, numar)
values (333333, 'Horse Vet Center', 'chirurgie generala', to_date('19-08-2000', 'dd-mm-yyyy'), '0722675123', 'horsevet@vetcenter.com', 'Romania', 'Ialomita', 'Amara', 'George Enescu', 90);

insert into cabinete_veterinare(cod_cabinet, nume, specializare, data_infiintare, telefon, email, tara, judet, oras, strada, numar)
values (444444, 'Save A Life', 'chirurgie generala', to_date('13-12-1999', 'dd-mm-yyyy'), '0211333545', 'chirurgie@savealife.com', 'Romania', 'Ilfov', 'Voluntari', 'Mihail Kogalniceanu', 891);

insert into cabinete_veterinare(cod_cabinet, nume, specializare, data_infiintare, telefon, email, tara, judet, oras, strada, numar)
values (555555, 'Animal Clinic', 'medicina generala', to_date('11-11-2004', 'dd-mm-yyyy'), '0555898777', 'contact@animalclinic.com', 'Romania', 'Ilfov', 'Chiajna', 'Soarelui', 32);

END;
/


-- INSERARE DE DATE IN TABELUL AVIZE
BEGIN

insert into avize(numar_inregistrare, data_emitere, data_predare, doctor, cod_client)
values (123456, to_date('01-02-2022', 'dd-mm-yyyy'), to_date('02-02-2022', 'dd-mm-yyyy'), 'Ionescu Mihai Petre', 200);

insert into avize(numar_inregistrare, data_emitere, data_predare, doctor, cod_client)
values (123457, to_date('07-02-2022', 'dd-mm-yyyy'), to_date('10-02-2022', 'dd-mm-yyyy'), 'Miclea Ioana', 201);

insert into avize(numar_inregistrare, data_emitere, data_predare, doctor, cod_client)
values (123458, to_date('14-02-2022', 'dd-mm-yyyy'), to_date('17-02-2022', 'dd-mm-yyyy'), 'Ionescu Mihai Petre', 203);

insert into avize(numar_inregistrare, data_emitere, data_predare, doctor, cod_client)
values (123459, to_date('26-02-2022', 'dd-mm-yyyy'), to_date('28-02-2022', 'dd-mm-yyyy'), 'Georgescu Laurentiu', 204);

insert into avize(numar_inregistrare, data_emitere, data_predare, doctor, cod_client)
values (123460, to_date('24-03-2022', 'dd-mm-yyyy'), to_date('27-03-2022', 'dd-mm-yyyy'), 'Trandafir George', 205);

insert into avize(numar_inregistrare, data_emitere, data_predare, doctor, cod_client)
values (123461, to_date('01-03-2022', 'dd-mm-yyyy'), to_date('02-03-2022', 'dd-mm-yyyy'), 'Georgescu Laurentiu', 206);

insert into avize(numar_inregistrare, data_emitere, data_predare, doctor, cod_client)
values (123462, to_date('04-02-2022', 'dd-mm-yyyy'), to_date('08-02-2022', 'dd-mm-yyyy'), 'Ionescu Mihai Petre', 207);

insert into avize(numar_inregistrare, data_emitere, data_predare, doctor, cod_client)
values (123463, to_date('19-02-2022', 'dd-mm-yyyy'), to_date('21-02-2022', 'dd-mm-yyyy'), 'Popescu Paula', 208);

insert into avize(numar_inregistrare, data_emitere, data_predare, doctor, cod_client)
values (123464, to_date('10-03-2022', 'dd-mm-yyyy'), to_date('20-03-2022', 'dd-mm-yyyy'), 'Vasilescu Maria', 209);

END;
/


-- INSERARE DE DATE IN TABELUL MEDICI
BEGIN

insert into medici(cod_medic, nume, prenume, telefon, email, cod_cabinet)
values (111, 'Diaconu', 'Marius', '0789564126', 'diaconumarius@gmail.com', null);

insert into medici(cod_medic, nume, prenume, telefon, email, cod_cabinet)
values (222, 'Pirvu', 'Ecaterina', '0785345876', 'pirvuecaterina@animalvet.com', 111111);

insert into medici(cod_medic, nume, prenume, telefon, email, cod_cabinet)
values (333, 'Mircea', 'Luiza Ioana', '0745234870', 'mircealuiza@vet.com', 222222);

insert into medici(cod_medic, nume, prenume, telefon, email, cod_cabinet)
values (444, 'Popescu', 'Iolanda', '0712876900', 'popescuiolanda@vet.com', 222222);

insert into medici(cod_medic, nume, prenume, telefon, email, cod_cabinet)
values (555, 'Bajenaru', 'Roxana', '0745782338', 'bajenaruroxana@vetcenter.com', 333333);

insert into medici(cod_medic, nume, prenume, telefon, email, cod_cabinet)
values (666, 'Marc', 'Alexandru', '0784678334', 'alexandru.marc@gmail.com', null);

insert into medici(cod_medic, nume, prenume, telefon, email, cod_cabinet)
values (777, 'Brincoveanu', 'Matei Ioan', '0754789341', 'brincoveanumatei@savealife.com', 444444);

insert into medici(cod_medic, nume, prenume, telefon, email, cod_cabinet)
values (888, 'Raducea', 'Amanda', '0785673450', 'raduceaamanda@animalclinic.com', 555555);

END;
/


-- INSERARE DE DATE IN TABELUL CENTRE_DRESAJ
BEGIN 

insert into centre_dresaj(cod_centru, nume, data_infiintare, telefon, email, tara, judet, oras, strada, numar, cod_categorie)
values (101010, 'Riding Center', to_date('07-04-2000', 'dd-mm-yyyy'), '0323456785', 'contactus@ridingcenter.com', 'Romania', 'Brasov', 'Sanpetru', 'Lalelelor', 67, 3);

insert into centre_dresaj(cod_centru, nume, data_infiintare, telefon, email, tara, judet, oras, strada, numar, cod_categorie)
values (202020, 'Jump!', to_date('14-12-2005', 'dd-mm-yyyy'), '0367900900', 'contact@jump.com', 'Romania', 'Prahova', 'Paulesti', 'Marin Preda', 37, 2);

insert into centre_dresaj(cod_centru, nume, data_infiintare, telefon, email, tara, judet, oras, strada, numar, cod_categorie)
values (303030, 'Horse Show', to_date('08-09-1998', 'dd-mm-yyyy'), '0255666900', 'contact@horseshow.com', 'Romania', 'Sibiu', 'Cisnadie', 'Ion Creanga', 324, 1);

insert into centre_dresaj(cod_centru, nume, data_infiintare, telefon, email, tara, judet, oras, strada, numar, cod_categorie)
values (404040, 'Rodeo Life', to_date('02-08-2010', 'dd-mm-yyyy'), '0233555111', 'horses@rodeolife.com', 'Romania', 'Brasov', 'Cristian', 'Pinului', 124, 4);

insert into centre_dresaj(cod_centru, nume, data_infiintare, telefon, email, tara, judet, oras, strada, numar, cod_categorie)
values (505050, 'Horse Jump Center', to_date('02-11-2005', 'dd-mm-yyyy'), '0310000300', 'horses@jumpcenter.com', 'Romania', 'Cluj', 'Cluj', 'Cezar Petrescu', 351, 2);

insert into centre_dresaj(cod_centru, nume, data_infiintare, telefon, email, tara, judet, oras, strada, numar, cod_categorie)
values (606060, 'Horse Relax', to_date('05-12-2009', 'dd-mm-yyyy'), '0455129880', 'relax@horseridingcenter.com', 'Romania', 'Ilfov', 'Voluntari', 'Crinilor', 25, 5);

insert into centre_dresaj(cod_centru, nume, data_infiintare, telefon, email, tara, judet, oras, strada, numar, cod_categorie)
values (707070, 'Jump With Us!', to_date('03-07-2006', 'dd-mm-yyyy'), '0312555777', 'contact@jumpwithus.com', 'Romania', 'Ilfov', 'Chiajna', 'Frumoasa', 154, 2);

insert into centre_dresaj(cod_centru, nume, data_infiintare, telefon, email, tara, judet, oras, strada, numar, cod_categorie)
values (808080, 'Spirit', to_date('02-04-2002', 'dd-mm-yyyy'), '0324775889', 'horses@spirit.com', 'Romania', 'Ialomita', 'Slobozia', 'Mare', 153, 1);

END;
/


-- INSERARE DE DATE IN TABELUL CAI
BEGIN 

insert into cai(cod_cal, nume, sex, rasa, culoare, data_nasterii, cod_centru_dresaj)
values(secventa_pk_cal.nextval, 'Akira', 'F', 'Shagya Arab', 'maro', to_date('03-05-2016', 'dd-mm-yyyy'), 202020); 

insert into cai(cod_cal, nume, sex, rasa, culoare, data_nasterii, cod_centru_dresaj)
values(secventa_pk_cal.nextval, 'Nero', 'M', 'Frizian', 'negru', to_date('09-02-2017', 'dd-mm-yyyy'), 303030);

insert into cai(cod_cal, nume, sex, rasa, culoare, data_nasterii, cod_centru_dresaj)
values(secventa_pk_cal.nextval, 'Diablo', 'M', 'Frizian', 'negru', to_date('18-11-2016', 'dd-mm-yyyy'), 303030);

insert into cai(cod_cal, nume, sex, rasa, culoare, data_nasterii, cod_centru_dresaj)
values(secventa_pk_cal.nextval, 'Fabio', 'M', 'Gypsy Vanner', 'negru cu alb', to_date('24-09-2018', 'dd-mm-yyyy'), 606060);

insert into cai(cod_cal, nume, sex, rasa, culoare, data_nasterii, cod_centru_dresaj)
values(secventa_pk_cal.nextval, 'Rambo', 'M', 'Hanoverian', 'maro', to_date('06-12-2018', 'dd-mm-yyyy'), 707070);

insert into cai(cod_cal, nume, sex, rasa, culoare, data_nasterii, cod_centru_dresaj)
values(secventa_pk_cal.nextval, 'Luna', 'F', 'Arab', 'alb', to_date('09-03-2016', 'dd-mm-yyyy'), 808080);

insert into cai(cod_cal, nume, sex, rasa, culoare, data_nasterii, cod_centru_dresaj)
values(secventa_pk_cal.nextval, 'Dakota', 'F', 'Appaloosa', 'maro cu alb', to_date('30-08-2017', 'dd-mm-yyyy'), 101010);

insert into cai(cod_cal, nume, sex, rasa, culoare, data_nasterii, cod_centru_dresaj)
values(secventa_pk_cal.nextval, 'Marvin', 'M', 'American Quarter', 'maro cu negru', to_date('10-10-2018', 'dd-mm-yyyy'), 404040);

insert into cai(cod_cal, nume, sex, rasa, culoare, data_nasterii, cod_centru_dresaj)
values(secventa_pk_cal.nextval, 'Rock', 'M', 'Morgan', 'maro inchis', to_date('17-12-2018', 'dd-mm-yyyy'), 505050);

insert into cai(cod_cal, nume, sex, rasa, culoare, data_nasterii, cod_centru_dresaj)
values(secventa_pk_cal.nextval, 'Inka', 'F', 'Norwegian Fjord', 'maro cu alb', to_date('23-12-2019', 'dd-mm-yyyy'), 606060);

END; 
/


-- INSERARE DE DATE IN TABELUL CONSULTATII
BEGIN 

insert into consultatii(data_consultatie, cod_medic, cod_cal, rezultat)
values (to_date('16-03-2022', 'dd-mm-yyyy'), 888, 13, 'Clinic sanatos');

insert into consultatii(data_consultatie, cod_medic, cod_cal, rezultat)
values (to_date('18-03-2022', 'dd-mm-yyyy'), 888, 19, 'Necesita odihna 3 zile');

insert into consultatii(data_consultatie, cod_medic, cod_cal, rezultat)
values (to_date('19-03-2022', 'dd-mm-yyyy'), 888, 13, 'Necesita odihna o saptamana');

insert into consultatii(data_consultatie, cod_medic, cod_cal, rezultat)
values (to_date('20-03-2022', 'dd-mm-yyyy'), 222, 16, 'Regim alimentar');

insert into consultatii(data_consultatie, cod_medic, cod_cal, rezultat)
values (to_date('21-03-2022', 'dd-mm-yyyy'), 333, 10, 'Supraveghere in urma vaccinarii');

insert into consultatii(data_consultatie, cod_medic, cod_cal, rezultat)
values (to_date('22-03-2022', 'dd-mm-yyyy'), 444, 10, 'Interpretare reactii vaccinare');

insert into consultatii(data_consultatie, cod_medic, cod_cal, rezultat)
values (to_date('27-03-2022', 'dd-mm-yyyy'), 777, 14, 'Recuperare fizica o luna');

insert into consultatii(data_consultatie, cod_medic, cod_cal, rezultat)
values (to_date('30-03-2022', 'dd-mm-yyyy'), 555, 14, 'Operatie');

insert into consultatii(data_consultatie, cod_medic, cod_cal, rezultat)
values (to_date('16-04-2022', 'dd-mm-yyyy'), 777, 14, 'Verificare stare clinica dupa operatie');

insert into consultatii(data_consultatie, cod_medic, cod_cal, rezultat)
values (to_date('08-04-2022', 'dd-mm-yyyy'), 888, 11, 'Clinic sanatos');

insert into consultatii(data_consultatie, cod_medic, cod_cal, rezultat)
values (to_date('09-04-2022', 'dd-mm-yyyy'), 444, 12, 'Vaccinare cu success');

insert into consultatii(data_consultatie, cod_medic, cod_cal, rezultat)
values (to_date('11-04-2022', 'dd-mm-yyyy'), 222, 15, 'Recomandare regim');

insert into consultatii(data_consultatie, cod_medic, cod_cal, rezultat)
values (to_date('15-04-2022', 'dd-mm-yyyy'), 888, 17, 'Clinic sanatos');

insert into consultatii(data_consultatie, cod_medic, cod_cal, rezultat)
values (to_date('27-04-2022', 'dd-mm-yyyy'), 888, 18, 'Oboseala musculara');

insert into consultatii(data_consultatie, cod_medic, cod_cal, rezultat)
values (to_date('28-04-2022', 'dd-mm-yyyy'), 111, 11, 'Clinic sanatos');

insert into consultatii(data_consultatie, cod_medic, cod_cal, rezultat)
values (to_date('29-04-2022', 'dd-mm-yyyy'), 666, 15, 'Verificare stadiu regim');

END;
/


-- INSERARE DE DATE IN TABELUL CONTRACTE
BEGIN 

insert into contracte (data_incheiere, cod_angajat, cod_firma, zile_valabilitate)
values (to_date('01-05-2016', 'dd-mm-yyyy'), 100, 100303, 1825);

insert into contracte (data_incheiere, cod_angajat, cod_firma, zile_valabilitate)
values (to_date('30-04-2021', 'dd-mm-yyyy'), 104, 100303, 365);

insert into contracte (data_incheiere, cod_angajat, cod_firma, zile_valabilitate)
values (to_date('07-06-2018', 'dd-mm-yyyy'), 101, 100404, 365);

insert into contracte (data_incheiere, cod_angajat, cod_firma, zile_valabilitate)
values (to_date('01-05-2016', 'dd-mm-yyyy'), 102, 100202, 365);

insert into contracte (data_incheiere, cod_angajat, cod_firma, zile_valabilitate)
values (to_date('01-05-2017', 'dd-mm-yyyy'), 103, 100505, 1095);

insert into contracte (data_incheiere, cod_angajat, cod_firma, zile_valabilitate)
values (to_date('01-05-2020', 'dd-mm-yyyy'), 106, 100505, 365);

insert into contracte (data_incheiere, cod_angajat, cod_firma, zile_valabilitate)
values (to_date('05-06-2016', 'dd-mm-yyyy'), 103, 100101, 365);

insert into contracte (data_incheiere, cod_angajat, cod_firma, zile_valabilitate)
values (to_date('02-06-2017', 'dd-mm-yyyy'), 102, 100101, null);

insert into contracte (data_incheiere, cod_angajat, cod_firma, zile_valabilitate)
values (to_date('29-04-2021', 'dd-mm-yyyy'), 106, 100505, null);

insert into contracte (data_incheiere, cod_angajat, cod_firma, zile_valabilitate)
values (to_date('06-06-2018', 'dd-mm-yyyy'), 108, 100404, 365);

insert into contracte (data_incheiere, cod_angajat, cod_firma, zile_valabilitate)
values (to_date('05-05-2019', 'dd-mm-yyyy'), 108, 100404, 730);

insert into contracte (data_incheiere, cod_angajat, cod_firma, zile_valabilitate)
values (to_date('07-05-2021', 'dd-mm-yyyy'), 106, 100404, 365);

insert into contracte (data_incheiere, cod_angajat, cod_firma, zile_valabilitate)
values (to_date('02-05-2022', 'dd-mm-yyyy'), 105, 100404, 730);

END;
/


-- INSERARE DE DATE IN TABELUL PROGRAMARI
BEGIN 

insert into programari(data_programare, ora_inceput, ora_final, cod_client, cod_angajat, cod_cal, cost)
values(to_date('02-02-2022', 'dd-mm-yyyy'), '12:00', '13:00', 200, 104, 13, 0);

insert into programari(data_programare, ora_inceput, ora_final, cod_client, cod_angajat, cod_cal, cost)
values(to_date('10-02-2022', 'dd-mm-yyyy'), '14:00', '15:00', 201, 102, 15, 0);

insert into programari(data_programare, ora_inceput, ora_final, cod_client, cod_angajat, cod_cal, cost)
values(to_date('01-03-2022', 'dd-mm-yyyy'), '15:00', '16:00', 204, 100, 10, 0);

insert into programari(data_programare, ora_inceput, ora_final, cod_client, cod_angajat, cod_cal, cost)
values(to_date('02-04-2022', 'dd-mm-yyyy'), '12:00', '13:00', 203, 108, 19, 0);

insert into programari(data_programare, ora_inceput, ora_final, cod_client, cod_angajat, cod_cal, cost)
values(to_date('03-03-2022', 'dd-mm-yyyy'), '16:00', '17:00', 204, 107, 10, 0);

insert into programari(data_programare, ora_inceput, ora_final, cod_client, cod_angajat, cod_cal, cost)
values(to_date('07-04-2022', 'dd-mm-yyyy'), '14:00', '15:00', 205, 104, 13, 0);

insert into programari(data_programare, ora_inceput, ora_final, cod_client, cod_angajat, cod_cal, cost)
values(to_date('02-05-2022', 'dd-mm-yyyy'), '18:00', '19:00', 206, 101, 16, 0);

insert into programari(data_programare, ora_inceput, ora_final, cod_client, cod_angajat, cod_cal, cost)
values(to_date('12-02-2022', 'dd-mm-yyyy'), '12:00', '13:00', 207, 102, 11, 0);

insert into programari(data_programare, ora_inceput, ora_final, cod_client, cod_angajat, cod_cal, cost)
values(to_date('02-03-2022', 'dd-mm-yyyy'), '13:00', '14:00', 208, 106, 14, 0);

insert into programari(data_programare, ora_inceput, ora_final, cod_client, cod_angajat, cod_cal, cost)
values(to_date('03-05-2022', 'dd-mm-yyyy'), '15:00', '16:00', 209, 105, 13, 0);

insert into programari(data_programare, ora_inceput, ora_final, cod_client, cod_angajat, cod_cal, cost)
values(to_date('09-04-2022', 'dd-mm-yyyy'), '15:00', '16:00', 204, 107, 10, 0);

END;
/


-- INSERARE DE DATE IN TABELUL INGRIJIRI
BEGIN 

insert into ingrijiri(data_ingrijire, ora_inceput, ora_final, cod_angajat, cod_cal, observatie)
values(to_date('08-03-2022', 'dd-mm-yyyy'), '08:00', '08:30', 105, 10, null);

insert into ingrijiri(data_ingrijire, ora_inceput, ora_final, cod_angajat, cod_cal, observatie)
values(to_date('11-03-2022', 'dd-mm-yyyy'), '09:00', '09:30', 105, 11, 'Paie insuficiente');

insert into ingrijiri(data_ingrijire, ora_inceput, ora_final, cod_angajat, cod_cal, observatie)
values(to_date('10-03-2022', 'dd-mm-yyyy'), '20:00', '20:30', 104, 12, null);

insert into ingrijiri(data_ingrijire, ora_inceput, ora_final, cod_angajat, cod_cal, observatie)
values(to_date('16-03-2022', 'dd-mm-yyyy'), '08:00', '08:30', 105, 13, 'Lipsa apa');

insert into ingrijiri(data_ingrijire, ora_inceput, ora_final, cod_angajat, cod_cal, observatie)
values(to_date('19-03-2022', 'dd-mm-yyyy'), '07:00', '07:30', 102, 14, null);

insert into ingrijiri(data_ingrijire, ora_inceput, ora_final, cod_angajat, cod_cal, observatie)
values(to_date('23-03-2022', 'dd-mm-yyyy'), '10:30', '11:00', 105, 15, 'Coama incalcita');

insert into ingrijiri(data_ingrijire, ora_inceput, ora_final, cod_angajat, cod_cal, observatie)
values(to_date('26-03-2022', 'dd-mm-yyyy'), '08:00', '08:30', 103, 16, null);

insert into ingrijiri(data_ingrijire, ora_inceput, ora_final, cod_angajat, cod_cal, observatie)
values(to_date('30-03-2022', 'dd-mm-yyyy'), '19:00', '19:30', 108, 17, 'Fixare potcoave');

insert into ingrijiri(data_ingrijire, ora_inceput, ora_final, cod_angajat, cod_cal, observatie)
values(to_date('03-04-2022', 'dd-mm-yyyy'), '20:00', '20:30', 105, 18, null);

insert into ingrijiri(data_ingrijire, ora_inceput, ora_final, cod_angajat, cod_cal, observatie)
values(to_date('08-04-2022', 'dd-mm-yyyy'), '08:00', '08:30', 106, 19, null);

END;
/


-- DATE INSERATE ULTERIOR CE NE AJUTA LA REZOLVAREA CLARA A SUBCERERILOR SAU A ACTUALIZARILOR
BEGIN 

insert into avize(numar_inregistrare, data_emitere, data_predare, doctor, cod_client)
values (123467, to_date('28-03-2022', 'dd-mm-yyyy'), to_date('29-03-2022', 'dd-mm-yyyy'), 'Zamfir Ionela Mihai', 205);

insert into programari(data_programare, ora_inceput, ora_final, cod_client, cod_angajat, cod_cal, cost)
values(to_date('10-04-2022', 'dd-mm-yyyy'), '18:00', '19:00', 200, 105, 19, 0);

insert into programari(data_programare, ora_inceput, ora_final, cod_client, cod_angajat, cod_cal, cost)
values(to_date('14-04-2022', 'dd-mm-yyyy'), '12:00', '13:00', 207, 103, 11, 0);

insert into angajati(cod_angajat, nume, prenume, telefon, email, data_angajarii, salariu, nivel)
values (SECVENTA_PK_ANGAJAT.nextval, 'Cojocaru', 'Denisa', '0756231890', 'cojocaru.denisa@akira.com', to_date('15-09-2017', 'dd-mm-yyyy'), 2000, null);

END;
/


-- UPDATE PENTRU COSTUL FIECAREI PROGRAMARI IN FUNCTIE DE CATEGORIE 
update programari p
set p.cost = (select pret_ora_echitatie
                    from categorii cat, centre_dresaj cd, cai
                    where cat.cod_categorie = cd.cod_categorie 
                    and cai.cod_centru_dresaj = cd.cod_centru 
                    and cai.cod_cal = p.cod_cal);
/


-- SUBPROGRAM CU DOUA COLECTII

-- Formulati în limbaj natural o problema pe care sa o rezolvati folosind un subprogram stocat 
-- independent care sa utilizeze doua tipuri diferite de colectii studiate. Apelati subprogramul. 

-- Selectati primii 6 angajatii care sunt cel mai prost platiti. In cazul in care exista angajati 
-- cu acelasi salariu, acestia nu vor ocupa acelasi loc – selectia se va face in functie de vechime, 
-- fiind ales angajatul cu vechimea cea mai mare. Pentru fiecare angajat selectat mai sus, afisati 
-- caii cu care acesta a lucrat la antrenamente (programari) si centrul de dresaj de la care provin. 

create or replace procedure subprogram_doua_colectii as 

    type vector is varray(100) of angajati.cod_angajat%type;
    v_angajati vector;
    type tablou_imbricat is table of cai.cod_cal%type;
    t_cai tablou_imbricat;
    var_centru cai.cod_centru_dresaj%type;
    var_nume_centru centre_dresaj.nume%type;
    var_nume_angajat angajati.nume%type;
    var_prenume_angajat angajati.prenume%type;
    var_nume_cal cai.nume%type;

begin
    
    -- Selectez codurile celor mai prost platiti 6 angajati intr-un vector.
    
    with aux as (select cod_angajat, salariu, data_angajarii
                 from angajati
                 order by salariu, data_angajarii)
    select cod_angajat
    bulk collect into v_angajati
    from aux 
    where rownum < 7;
    
    -- Pentru fiecare angajat, selectez caii cu care acesta a lucrat. 
    
    for i in v_angajati.first..v_angajati.last loop
        
        -- Selectez codurile cailor cu care angajatul curent a lucrat intr-un tablou imbricat. 
        
        with aux2 as (select distinct cod_cal
                      from programari
                      where cod_angajat = v_angajati(i))
        select cod_cal
        bulk collect into t_cai
        from aux2; 
        
        select nume, prenume into var_nume_angajat, var_prenume_angajat
        from angajati 
        where cod_angajat = v_angajati(i);
        
        -- Daca nu avem nici o inregistrare in tabel, angajatul nu a lucrat cu 
        -- cai si afisam un mesaj corespunzator. 
        -- Altfel afisam caii si centrele de la care provin. 
        
        dbms_output.put_line('Angajat: ' || var_nume_angajat || ' ' || var_prenume_angajat);
        
        if t_cai.count() = 0 
            then dbms_output.put_line('Angajatul nu a lucrat cu nici un cal.');
        else 
            for j in t_cai.first..t_cai.last loop
                select nume, cod_centru_dresaj into var_nume_cal, var_centru
                from cai
                where cod_cal = t_cai(j);
                
                select nume into var_nume_centru 
                from centre_dresaj
                where cod_centru = var_centru;
                
                dbms_output.put_line('Calul ' || var_nume_cal || ' provine de la centrul ' || var_nume_centru || '.');
            end loop;
        end if;
            
            dbms_output.put_line('-----------------------------------');
            dbms_output.put_line('');
            
            -- La final eliberam tabloul pentru noi cai. 
            
            t_cai.delete();
    end loop;
    
end subprogram_doua_colectii;
/

begin 
    subprogram_doua_colectii();
end;
/


-- SUBPROGRAM DOUA CURSOARE

-- Formulati în limbaj natural o problema pe care sa o rezolvati folosind un 
-- subprogram stocat independent care sa utilizeze 2 tipuri diferite de cursoare 
-- studiate, unul dintre acestea fiind cursor parametrizat. Apelati subprogramul. 

-- Sa se afiseze detalii despre caii centrului de echitatie de o anumita culoare. 
-- Se cere rasa, varsta, categoria pentru care este antrenat, anotimpul in care 
-- s-au nascut si ultimul medic veterinar care i-a consultat. In plus, sa se afizeze 
-- o lista cu clientii care au lucrat cu acesti cai.  

insert into cai(cod_cal, nume, sex, rasa, culoare, data_nasterii, cod_centru_dresaj)
values(secventa_pk_cal.nextval, 'Domino', 'M', 'Lusitano', 'gri', to_date('09-09-2016', 'dd-mm-yyyy'), 101010);

insert into cai(cod_cal, nume, sex, rasa, culoare, data_nasterii, cod_centru_dresaj)
values(secventa_pk_cal.nextval, 'Fiona', 'F', 'Lusitano', 'alb', to_date('23-02-2018', 'dd-mm-yyyy'), 202020);

insert into cai(cod_cal, nume, sex, rasa, culoare, data_nasterii, cod_centru_dresaj)
values(secventa_pk_cal.nextval, 'Russel', 'M', 'Lusitano', 'gri', to_date('29-08-2016', 'dd-mm-yyyy'), 404040);

create or replace procedure subprogram_doua_cursoare (pp_culoare cai.culoare%type) as 
    v_info_cai cai%rowtype;
    v_nume_medic medici.nume%type;
    v_prenume_medic medici.prenume%type;
    index_cai number := 1;
    ok number := 0;
    v_categorie categorii.tip%type;
    cursor c_cai (parametru cai.culoare%type) is 
        select * from cai where instr(upper(culoare), upper(parametru)) != 0;
begin 
    
    -- Pentru a retine caii de o anumita culoare am folosit un cursor 
    -- parametrizat ce primeste ca parametru culoarea.
    
    open c_cai(pp_culoare);
    loop 
    
        -- Am folosit un bloc in loop pentru a trata exceptia in cazul in care 
        -- calul nu a fost consultat de nici un doctor => no_data_found
    
        begin 
        fetch c_cai into v_info_cai;
        exit when c_cai%notfound;
        
        dbms_output.put(index_cai || '. ');
        index_cai := index_cai + 1;
        
        select tip into v_categorie
        from categorii c, centre_dresaj cd
        where v_info_cai.cod_centru_dresaj = cod_centru and c.cod_categorie = cd.cod_categorie;
        
        dbms_output.put_line(v_info_cai.nume || ' este un cal de culoare ' || v_info_cai.culoare
                             || ' de rasa ' || v_info_cai.rasa || '.');
                             
        if v_info_cai.sex = 'F' then 
            dbms_output.put_line('   ' || v_info_cai.nume ||  ' are ' || to_char(trunc(months_between(sysdate, v_info_cai.data_nasterii)/12)) 
                                || ' ani si este antrenata pentru ' || v_categorie || '.');
        else
            dbms_output.put_line('   ' || v_info_cai.nume ||  ' are ' || to_char(trunc(months_between(sysdate, v_info_cai.data_nasterii)/12)) 
                                || ' ani si este antrenat pentru ' || v_categorie || '.');
        end if;
        
        dbms_output.put_line('   Clientii care s-au antrenat cu ' || v_info_cai.nume || ': ');
        
        -- Pentru a retine clientii care au lucrat cu calul respectiv 
        -- am folosit un ciclu cursor cu subcereri si o variabila auxiliara
        -- ce contorizeaza numarul acestora.
        
        for c_client in (select distinct nume, prenume
                         from programari p, clienti c
                         where cod_cal = v_info_cai.cod_cal and p.cod_client = c.cod_client) loop
        ok := ok + 1;
        dbms_output.put_line('   ' || ok || '. ' || c_client.nume || ' ' || c_client.prenume);
        end loop;
        
        if ok = 0 then 
            dbms_output.put_line('   -> nu s-a antrenat nimeni cu ' || v_info_cai.nume);
        end if;
        
        ok := 0;
        
        if extract(month from v_info_cai.data_nasterii) in (12, 1, 2) then 
            dbms_output.put ('   ' || v_info_cai.nume || ' s-a nascut iarna ');
        elsif extract(month from v_info_cai.data_nasterii) in (3, 4, 5) then 
            dbms_output.put ('   ' || v_info_cai.nume || ' s-a nascut primavara ');
        elsif extract(month from v_info_cai.data_nasterii) in (6, 7, 8) then 
            dbms_output.put ('   ' || v_info_cai.nume || ' s-a nascut vara ');
        elsif extract(month from v_info_cai.data_nasterii) in (9, 10, 11) then 
            dbms_output.put ('   ' || v_info_cai.nume || ' s-a nascut toamna ');
        end if;
        
        -- Aici aparea exceptia despre care am vorbit mai sus. 
        
        select nume, prenume into v_nume_medic, v_prenume_medic 
        from medici 
        where cod_medic = (select cod_medic 
                           from consultatii
                           where cod_cal = v_info_cai.cod_cal
                           and data_consultatie = (select max(data_consultatie) max_data
                                                   from consultatii
                                                   where cod_cal = v_info_cai.cod_cal
                                                   group by cod_cal));
                                                   
        dbms_output.put_line('si ultimul sau consult a fost efectuat de catre ' 
                             || v_nume_medic || ' ' || v_prenume_medic || '.');
        
        dbms_output.put_line('');
        
        exception
            when no_data_found then 
                dbms_output.put_line('si nu a fost consultat de nici un doctor.');
                dbms_output.put_line('');
        end;
        
    end loop;
    
    -- Daca nu am gasit cai cu o anumita culoare, afisam acest lucru. 
    
    if c_cai%rowcount = 0 
        then dbms_output.put_line('Nu exista cai de culoarea ' || pp_culoare || '.');
    end if;
    
    close c_cai;

end subprogram_doua_cursoare;
/

declare 
    v_culoare cai.culoare%type := '&vv_culoare';
begin 
    subprogram_doua_cursoare(v_culoare);
end;
/


-- SUBPROGRAM DE TIP FUNCTIE CU CERERE PE TREI TABELE

-- Formulati în limbaj natural o problema pe care sa o rezolvati folosind un 
-- subprogram stocat independent de tip functie care sa utilizeze intr-o singura
-- comanda SQL 3 dintre tabelele definite. Definiti minim 2 exceptii. Apelati subprogramul 
-- astfel încat sa evidentiati toate cazurile tratate. 

-- Sa se afiseze suma totala incasata pe programarile tinute de un angajat identificat cu numarul de telefon.
-- •	Se vor lua in considerare doar angajatii care au salariul mai mare decat 2100 lei. 
-- •	Se vor lua in considerare doar angajatii care au stabilit un nivel de pregatire. 
-- •	In cazul in care numarul de telefon nu este valid, sa se afiseze un mesaj corespunzator. 
-- •	Se vor lua in considerare doar programarile cu clienti care au stabilit un nivel de pregatire. 

insert into programari(data_programare, ora_inceput, ora_final, cod_client, cod_angajat, cod_cal, cost)
values(to_date('09-08-2022', 'dd-mm-yyyy'), '15:00', '16:00', 204, 104, 10, 0);

insert into programari(data_programare, ora_inceput, ora_final, cod_client, cod_angajat, cod_cal, cost)
values(to_date('23-12-2022', 'dd-mm-yyyy'), '16:00', '17:00', 204, 104, 15, 0);

insert into programari(data_programare, ora_inceput, ora_final, cod_client, cod_angajat, cod_cal, cost)
values(to_date('01-09-2022', 'dd-mm-yyyy'), '12:00', '13:00', 200, 102, 18, 0);

insert into programari(data_programare, ora_inceput, ora_final, cod_client, cod_angajat, cod_cal, cost)
values(to_date('12-09-2022', 'dd-mm-yyyy'), '14:00', '15:00', 200, 100, 18, 0);

insert into programari(data_programare, ora_inceput, ora_final, cod_client, cod_angajat, cod_cal, cost)
values(to_date('01-12-2022', 'dd-mm-yyyy'), '12:00', '13:00', 204, 100, 11, 0);

update programari p
set p.cost = (select pret_ora_echitatie
                    from categorii cat, centre_dresaj cd, cai
                    where cat.cod_categorie = cd.cod_categorie 
                    and cai.cod_centru_dresaj = cd.cod_centru 
                    and cai.cod_cal = p.cod_cal);

create or replace function subprogram_functie_3_tabele_si_exceptii (p_telefon in angajati.telefon%type) 
return number is
    telefon_incorect_mic exception;
    telefon_incorect_mare exception;
    salariu_mic exception;
    nivel_null exception;
    suma number := 0;
    v_cod_angajat angajati.cod_angajat%type;
    v_nivel_angajat angajati.nivel%type;
    v_salariu_angajat angajati.salariu%type;
begin
    if length(p_telefon) < 10 then 
        raise telefon_incorect_mic;
    end if;
    
    if length(p_telefon) > 10 then 
        raise telefon_incorect_mare;
    end if;
        
    select cod_angajat, nivel, salariu into v_cod_angajat, v_nivel_angajat, v_salariu_angajat
    from angajati
    where telefon = p_telefon;
    
    if v_nivel_angajat is null then 
        raise nivel_null;
    end if;
    
    if v_salariu_angajat <= 2100 then 
        raise salariu_mic;
    end if;
    
    for programare in (select p.cost
                       from programari p, angajati a, clienti c
                       where p.cod_angajat = a.cod_angajat and
                             p.cod_client = c.cod_client and 
                             p.cod_angajat = v_cod_angajat and
                             c.nivel is not null) loop
        suma := suma + programare.cost;
        end loop;
     return suma;   
    
exception
    when telefon_incorect_mare then 
        dbms_output.put_line('Telefon incorect - prea multe cifre!');
        return null;
    when telefon_incorect_mic then 
        dbms_output.put_line('Telefon incorect - prea putine cifre!');
        return null;
    when nivel_null then 
        dbms_output.put_line('Angajatul nu are un nivel de pregatire!');
        return null;
    when no_data_found then 
        dbms_output.put_line('Nu exista un angajat cu acest numar de telefon!');
        return null;
    when salariu_mic then 
        dbms_output.put_line('Angajatul are un salariu prea mic!');
        return null;
    when others then 
        dbms_output.put_line('Nu s-a putut efectua cererea!');
        return null;
end subprogram_functie_3_tabele_si_exceptii;
/
    
declare 
    v_telefon varchar2(60) := '&vv_telefon';
    v_raspuns number;
begin 
    v_raspuns := subprogram_functie_3_tabele_si_exceptii(v_telefon);
    if v_raspuns is not null then 
        dbms_output.put_line('Suma: ' || v_raspuns);
    else 
        dbms_output.put_line('Suma: -');
    end if;
end;
/


-- SUBPROGRAM DE TIP PROCEDURA CU CERERE PE 5 TABELE

-- Formulati in limbaj natural o problema pe care sa o rezolvati folosind 
-- un subprogram stocat independent de tip procedura care sa utilizeze intr-o 
-- singura comanda SQL 5 dintre tabelele definite. Tratati toate exceptiile care 
-- pot aparea, incluzand exceptiile NO_DATA_FOUND si TOO_MANY_ROWS. Apelati 
-- subprogramul astfel încat sa evidentiati toate cazurile tratate. 

-- Sa se afiseze detalii despre un client al carui prenume este introdus de la tastatura:
-- •	data predarii ultimului aviz medical
-- •	calul cu care a sustinut ultimul antrenament 
-- •	numele angajatului cu care a sustinut ultimul antrenament 
-- In cazul in care sunt mai multi clienti cu acelasi nume, se va alege cel mai tanar. 
 
insert into clienti(cod_client, nume, prenume, data_nasterii, telefon, nivel)
values (SECVENTA_PK_CLIENT.nextval, 'Popescu', 'Robert Octavian', to_date('10-12-2000', 'dd-mm-yyyy'), '0789556432', null);

insert into programari(data_programare, ora_inceput, ora_final, cod_client, cod_angajat, cod_cal, cost)
values(to_date('02-03-2022', 'dd-mm-yyyy'), '14:00', '15:00', 208, 104, 16, 0);

insert into avize(numar_inregistrare, data_emitere, data_predare, doctor, cod_client)
values (123478, to_date('02-03-2022', 'dd-mm-yyyy'), to_date('20-03-2022', 'dd-mm-yyyy'), 'Popescu Maria', 209);

update programari p
set p.cost = (select pret_ora_echitatie
                    from categorii cat, centre_dresaj cd, cai
                    where cat.cod_categorie = cd.cod_categorie 
                    and cai.cod_centru_dresaj = cd.cod_centru 
                    and cai.cod_cal = p.cod_cal);

create or replace procedure subprogram_procedura_5_tabele_si_exceptii_standard (p_prenume clienti.prenume%type) is
    v_cod_client clienti.cod_client%type;
    v_nume_angajat angajati.nume%type;
    v_prenume_angajat angajati.prenume%type;
    v_nume_cal cai.nume%type;
    v_data_programare programari.data_programare%type;
    v_data_aviz avize.data_predare%type;
    v_nume_client clienti.nume%type;
    v_prenume_client clienti.prenume%type;
    majuscula exception;
begin

    if p_prenume != initcap(p_prenume) then 
        raise majuscula;
    end if;

    begin 
        select cod_client, nume, prenume into v_cod_client, v_nume_client, v_prenume_client
        from clienti
        where initcap(prenume) like '%'||p_prenume||'%';
    exception
        when no_data_found then 
            dbms_output.put_line('Nu exista un client cu prenumele ' || initcap(p_prenume) || '!');
            return;
        when too_many_rows then
            select cod_client into v_cod_client 
            from clienti c
            where data_nasterii = (select max(data_nasterii)
                                   from clienti
                                   where initcap(prenume) like '%'||p_prenume||'%')
                  and initcap(prenume) like '%'||p_prenume||'%'; 
    end;
    
    select data_predare, data_programare, cc.nume, a.nume, a.prenume
           into v_data_aviz, v_data_programare, v_nume_cal, v_nume_angajat, v_prenume_angajat
    from clienti c, avize av, programari p, cai cc, angajati a 
    where c.cod_client = v_cod_client and
          c.cod_client = av.cod_client and 
          data_predare = (select max(data_predare)
                          from avize av2
                          where av2.cod_client = v_cod_client) and 
          p.cod_client = c.cod_client and 
          data_programare = (select max(data_programare)
                             from programari p2
                             where p2.cod_client = v_cod_client) and 
          ora_inceput = (select max(ora_inceput)
                         from programari p2
                         where p2.cod_client = v_cod_client and p2.data_programare = p.data_programare) and 
          ora_final = (select max(ora_final)
                       from programari p2
                       where p2.cod_client = v_cod_client and p2.data_programare = p.data_programare) and
          p.cod_cal = cc.cod_cal and 
          p.cod_angajat = a.cod_angajat;
          
    dbms_output.put_line('Client: ' || v_nume_client || ' ' || v_prenume_client);
    dbms_output.put_line('Data predarii ultimului aviz: ' || v_data_aviz);
    dbms_output.put_line('Ultimul cal cu care s-a antrenat: ' || v_nume_cal);
    dbms_output.put_line('Ultimul antrenor cu care a colaborat: ' || v_nume_angajat || ' ' || v_prenume_angajat);

exception
    when majuscula then 
        dbms_output.put_line('Va rugam sa introduceti prenumele scris cu majuscula!');
    when no_data_found then 
        dbms_output.put_line('Clientul nu a adus nici nu aviz sau nu are inregistrata nici o programare!');
    when too_many_rows then 
        dbms_output.put_line('Clientul a adus mai multe avize in aceeasi zi!');
end subprogram_procedura_5_tabele_si_exceptii_standard;
/

declare 
    v_prenume clienti.prenume%type := '&vv_prenume';
begin 
    subprogram_procedura_5_tabele_si_exceptii_standard(v_prenume);
end;
/


-- PACHET CU OBIECTELE DEFINITE ANTERIOR

-- Definiti un pachet care sa contina toate obiectele definite în cadrul proiectului.

create or replace package pachet_obiecte as 
    procedure pkg_subprogram_doua_colectii;
    procedure pkg_subprogram_doua_cursoare (pp_culoare cai.culoare%type);
    function pkg_subprogram_functie_3_tabele_si_exceptii (p_telefon in angajati.telefon%type) return number;
    procedure pkg_subprogram_procedura_5_tabele_si_exceptii_standard (p_prenume clienti.prenume%type);
end pachet_obiecte;
/
    
create or replace package body pachet_obiecte as 

------------------ PRIMUL SUBPROGRAM ----------------------------

procedure pkg_subprogram_doua_colectii as 

    type vector is varray(100) of angajati.cod_angajat%type;
    v_angajati vector;
    type tablou_imbricat is table of cai.cod_cal%type;
    t_cai tablou_imbricat;
    var_centru cai.cod_centru_dresaj%type;
    var_nume_centru centre_dresaj.nume%type;
    var_nume_angajat angajati.nume%type;
    var_prenume_angajat angajati.prenume%type;
    var_nume_cal cai.nume%type;

begin
   
    with aux as (select cod_angajat, salariu, data_angajarii
                 from angajati
                 order by salariu, data_angajarii)
    select cod_angajat
    bulk collect into v_angajati
    from aux 
    where rownum < 7;
    
    for i in v_angajati.first..v_angajati.last loop
        
        with aux2 as (select distinct cod_cal
                      from programari
                      where cod_angajat = v_angajati(i))
        select cod_cal
        bulk collect into t_cai
        from aux2; 
        
        select nume, prenume into var_nume_angajat, var_prenume_angajat
        from angajati 
        where cod_angajat = v_angajati(i);
        
        dbms_output.put_line('Angajat: ' || var_nume_angajat || ' ' || var_prenume_angajat);
        
        if t_cai.count() = 0 
            then dbms_output.put_line('Angajatul nu a lucrat cu nici un cal.');
        else 
            for j in t_cai.first..t_cai.last loop
                select nume, cod_centru_dresaj into var_nume_cal, var_centru
                from cai
                where cod_cal = t_cai(j);
                
                select nume into var_nume_centru 
                from centre_dresaj
                where cod_centru = var_centru;
                
                dbms_output.put_line('Calul ' || var_nume_cal || ' provine de la centrul ' || var_nume_centru || '.');
            end loop;
        end if;
            
            dbms_output.put_line('-----------------------------------');
            dbms_output.put_line('');
 
            t_cai.delete();
    end loop;
    
end pkg_subprogram_doua_colectii;

------------------ AL DOILEA SUBPROGRAM ----------------------------

procedure pkg_subprogram_doua_cursoare (pp_culoare cai.culoare%type) as 
    v_info_cai cai%rowtype;
    v_nume_medic medici.nume%type;
    v_prenume_medic medici.prenume%type;
    index_cai number := 1;
    ok number := 0;
    v_categorie categorii.tip%type;
    cursor c_cai (parametru cai.culoare%type) is 
        select * from cai where instr(upper(culoare), upper(parametru)) != 0;
begin 

    open c_cai(pp_culoare);
    loop 

        begin 
        fetch c_cai into v_info_cai;
        exit when c_cai%notfound;
        
        dbms_output.put(index_cai || '. ');
        index_cai := index_cai + 1;
        
        select tip into v_categorie
        from categorii c, centre_dresaj cd
        where v_info_cai.cod_centru_dresaj = cod_centru and c.cod_categorie = cd.cod_categorie;
        
        dbms_output.put_line(v_info_cai.nume || ' este un cal de culoare ' || v_info_cai.culoare
                             || ' de rasa ' || v_info_cai.rasa || '.');
                             
        if v_info_cai.sex = 'F' then 
            dbms_output.put_line('   ' || v_info_cai.nume ||  ' are ' || to_char(trunc(months_between(sysdate, v_info_cai.data_nasterii)/12)) 
                                || ' ani si este antrenata pentru ' || v_categorie || '.');
        else
            dbms_output.put_line('   ' || v_info_cai.nume ||  ' are ' || to_char(trunc(months_between(sysdate, v_info_cai.data_nasterii)/12)) 
                                || ' ani si este antrenat pentru ' || v_categorie || '.');
        end if;
        
        dbms_output.put_line('   Clientii care s-au antrenat cu ' || v_info_cai.nume || ': ');
        
        for c_client in (select distinct nume, prenume
                         from programari p, clienti c
                         where cod_cal = v_info_cai.cod_cal and p.cod_client = c.cod_client) loop
        ok := ok + 1;
        dbms_output.put_line('   ' || ok || '. ' || c_client.nume || ' ' || c_client.prenume);
        end loop;
        
        if ok = 0 then 
            dbms_output.put_line('   -> nu s-a antrenat nimeni cu ' || v_info_cai.nume);
        end if;
        
        ok := 0;
        
        if extract(month from v_info_cai.data_nasterii) in (12, 1, 2) then 
            dbms_output.put ('   ' || v_info_cai.nume || ' s-a nascut iarna ');
        elsif extract(month from v_info_cai.data_nasterii) in (3, 4, 5) then 
            dbms_output.put ('   ' || v_info_cai.nume || ' s-a nascut primavara ');
        elsif extract(month from v_info_cai.data_nasterii) in (6, 7, 8) then 
            dbms_output.put ('   ' || v_info_cai.nume || ' s-a nascut vara ');
        elsif extract(month from v_info_cai.data_nasterii) in (9, 10, 11) then 
            dbms_output.put ('   ' || v_info_cai.nume || ' s-a nascut toamna ');
        end if;
        
        select nume, prenume into v_nume_medic, v_prenume_medic 
        from medici 
        where cod_medic = (select cod_medic 
                           from consultatii
                           where cod_cal = v_info_cai.cod_cal
                           and data_consultatie = (select max(data_consultatie) max_data
                                                   from consultatii
                                                   where cod_cal = v_info_cai.cod_cal
                                                   group by cod_cal));
                                                   
        dbms_output.put_line('si ultimul sau consult a fost efectuat de catre ' 
                             || v_nume_medic || ' ' || v_prenume_medic || '.');
        
        dbms_output.put_line('');
        
        exception
            when no_data_found then 
                dbms_output.put_line('si nu a fost consultat de nici un doctor.');
                dbms_output.put_line('');
        end;
        
    end loop;

    if c_cai%rowcount = 0 
        then dbms_output.put_line('Nu exista cai de culoarea ' || pp_culoare || '.');
    end if;
    
    close c_cai;

end pkg_subprogram_doua_cursoare;

------------------ AL TREILEA SUBPROGRAM ----------------------------

function pkg_subprogram_functie_3_tabele_si_exceptii (p_telefon in angajati.telefon%type) 
return number is
    telefon_incorect_mic exception;
    telefon_incorect_mare exception;
    salariu_mic exception;
    nivel_null exception;
    suma number := 0;
    v_cod_angajat angajati.cod_angajat%type;
    v_nivel_angajat angajati.nivel%type;
    v_salariu_angajat angajati.salariu%type;
begin
    if length(p_telefon) < 10 then 
        raise telefon_incorect_mic;
    end if;
    
    if length(p_telefon) > 10 then 
        raise telefon_incorect_mare;
    end if;
        
    select cod_angajat, nivel, salariu into v_cod_angajat, v_nivel_angajat, v_salariu_angajat
    from angajati
    where telefon = p_telefon;
    
    if v_nivel_angajat is null then 
        raise nivel_null;
    end if;
    
    if v_salariu_angajat <= 2100 then 
        raise salariu_mic;
    end if;
    
    for programare in (select p.cost
                       from programari p, angajati a, clienti c
                       where p.cod_angajat = a.cod_angajat and
                             p.cod_client = c.cod_client and 
                             p.cod_angajat = v_cod_angajat and
                             c.nivel is not null) loop
        suma := suma + programare.cost;
        end loop;
     return suma;   
    
exception
    when telefon_incorect_mare then 
        dbms_output.put_line('Telefon incorect - prea multe cifre!');
        return null;
    when telefon_incorect_mic then 
        dbms_output.put_line('Telefon incorect - prea putine cifre!');
        return null;
    when nivel_null then 
        dbms_output.put_line('Angajatul nu are un nivel de pregatire!');
        return null;
    when no_data_found then 
        dbms_output.put_line('Nu exista un angajat cu acest numar de telefon!');
        return null;
    when salariu_mic then 
        dbms_output.put_line('Angajatul are un salariu prea mic!');
        return null;
    when others then 
        dbms_output.put_line('Nu s-a putut efectua cererea!');
        return null;
end pkg_subprogram_functie_3_tabele_si_exceptii;

------------------ AL PATRULEA SUBPROGRAM ----------------------------

procedure pkg_subprogram_procedura_5_tabele_si_exceptii_standard (p_prenume clienti.prenume%type) is
    v_cod_client clienti.cod_client%type;
    v_nume_angajat angajati.nume%type;
    v_prenume_angajat angajati.prenume%type;
    v_nume_cal cai.nume%type;
    v_data_programare programari.data_programare%type;
    v_data_aviz avize.data_predare%type;
    v_nume_client clienti.nume%type;
    v_prenume_client clienti.prenume%type;
    majuscula exception;
begin

    if p_prenume != initcap(p_prenume) then 
        raise majuscula;
    end if;

    begin 
        select cod_client, nume, prenume into v_cod_client, v_nume_client, v_prenume_client
        from clienti
        where initcap(prenume) like '%'||p_prenume||'%';
    exception
        when no_data_found then 
            dbms_output.put_line('Nu exista un client cu prenumele ' || initcap(p_prenume) || '!');
            return;
        when too_many_rows then
            select cod_client into v_cod_client 
            from clienti c
            where data_nasterii = (select max(data_nasterii)
                                   from clienti
                                   where initcap(prenume) like '%'||p_prenume||'%')
                  and initcap(prenume) like '%'||p_prenume||'%'; 
    end;
    
    select data_predare, data_programare, cc.nume, a.nume, a.prenume
           into v_data_aviz, v_data_programare, v_nume_cal, v_nume_angajat, v_prenume_angajat
    from clienti c, avize av, programari p, cai cc, angajati a 
    where c.cod_client = v_cod_client and
          c.cod_client = av.cod_client and 
          data_predare = (select max(data_predare)
                          from avize av2
                          where av2.cod_client = v_cod_client) and 
          p.cod_client = c.cod_client and 
          data_programare = (select max(data_programare)
                             from programari p2
                             where p2.cod_client = v_cod_client) and 
          ora_inceput = (select max(ora_inceput)
                         from programari p2
                         where p2.cod_client = v_cod_client and p2.data_programare = p.data_programare) and 
          ora_final = (select max(ora_final)
                       from programari p2
                       where p2.cod_client = v_cod_client and p2.data_programare = p.data_programare) and
          p.cod_cal = cc.cod_cal and 
          p.cod_angajat = a.cod_angajat;
          
    dbms_output.put_line('Client: ' || v_nume_client || ' ' || v_prenume_client);
    dbms_output.put_line('Data predarii ultimului aviz: ' || v_data_aviz);
    dbms_output.put_line('Ultimul cal cu care s-a antrenat: ' || v_nume_cal);
    dbms_output.put_line('Ultimul antrenor cu care a colaborat: ' || v_nume_angajat || ' ' || v_prenume_angajat);

exception
    when majuscula then 
        dbms_output.put_line('Va rugam sa introduceti prenumele scris cu majuscula!');
    when no_data_found then 
        dbms_output.put_line('Clientul nu a adus nici nu aviz sau nu are inregistrata nici o programare!');
    when too_many_rows then 
        dbms_output.put_line('Clientul a adus mai multe avize in aceeasi zi!');
end pkg_subprogram_procedura_5_tabele_si_exceptii_standard;

end pachet_obiecte;
/

begin 
    pachet_obiecte.pkg_subprogram_doua_colectii();
end;
/

declare 
    v_culoare cai.culoare%type := '&vv_culoare';
begin 
    pachet_obiecte.pkg_subprogram_doua_cursoare(v_culoare);
end;
/

declare 
    v_telefon varchar2(60) := '&vv_telefon';
    v_raspuns number;
begin 
    v_raspuns := pachet_obiecte.pkg_subprogram_functie_3_tabele_si_exceptii(v_telefon);
    if v_raspuns is not null then 
        dbms_output.put_line('Suma: ' || v_raspuns);
    else 
        dbms_output.put_line('Suma: -');
    end if;
end;
/

declare 
    v_prenume clienti.prenume%type := '&vv_prenume';
begin 
    pachet_obiecte.pkg_subprogram_procedura_5_tabele_si_exceptii_standard(v_prenume);
end;
/
 
 
-- TRIGGER LMD LA NIVEL DE COMANDA 

-- Pana acum am actualizat pretul fiecarei programari manual, 
-- de acum inainte acest lucru se va face automat cu ajutorul unui trigger LMD la nivel de comanda.

create or replace trigger trigger_lmd_comanda 
    after insert or update of cod_cal on programari 
begin
    update programari p
    set p.cost = (select pret_ora_echitatie
                    from categorii cat, centre_dresaj cd, cai
                    where cat.cod_categorie = cd.cod_categorie 
                    and cai.cod_centru_dresaj = cd.cod_centru 
                    and cai.cod_cal = p.cod_cal);
end;
/

insert into programari(data_programare, ora_inceput, ora_final, cod_client, cod_angajat, cod_cal, cost)
values(to_date('07-09-2022', 'dd-mm-yyyy'), '11:00', '12:00', 202, 101, 10, 0);

select * from programari;

update programari 
set cod_cal = 13
where data_programare = to_date('07-09-2022', 'dd-mm-yyyy') 
      and ora_inceput = '11:00' and ora_final = '12:00';
      
select * from programari;


-- TRIGGER LMD LA NIVEL DE LINIE

-- Sa se interzica modificarea salariilor angajatilor daca noua valoare 
-- este mai mare de 5000 lei. 

create or replace trigger trigger_lmd_linie
    before update of salariu on angajati
    for each row
declare 
    salariu_minim exception;
begin
   if :new.salariu > 5000 then 
        raise salariu_minim;
   end if;
exception
    when salariu_minim then 
        raise_application_error(-20003, 'Nu am actualizat salariul! Acesta va depasi 5000 lei!');
end;
/

update angajati 
set salariu = salariu + 100
where cod_angajat = 104 or cod_angajat = 101;

select * from angajati;

update angajati 
set salariu = salariu + 4000
where cod_angajat = 104 or cod_angajat = 101;

select * from angajati;


-- TRIGGER LDD 

-- Sa se introduca intr-un tabel detalii despre comenzile LDD rulate. 

create table informatii_comenzi_ldd (data date, utilizator varchar2(60), comanda varchar2(60), obiect varchar2(60));

create or replace trigger trigger_ldd 
    after create or alter or drop on schema  
begin
    insert into informatii_comenzi_ldd values 
    (sysdate, sys.login_user, sys.sysevent, sys.dictionary_obj_name);
end;
/

drop table tabel_trigger;
create table tabel_trigger (n number);

select * from informatii_comenzi_ldd;
/


-- PACHET EXTRA

create or replace package pachet_extra as 
    type tablou_imbricat_angajati is table of angajati%rowtype;
    procedure detalii_angajati_nivel (p_nivel angajati.nivel%type);
    type tablou_imbricat_clienti is table of clienti%rowtype;
    procedure detalii_clienti_nivel (p_nivel clienti.nivel%type);
    function suma_totala return number;
    type tablou_indexat_angajati_activi is table of number index by pls_integer;
    procedure clienti_fideli;
    procedure angajati_activi;
    procedure expirare_contract (p_nume_angajat angajati.nume%type,
                                p_prenume_angajat angajati.prenume%type,
                                p_nume_firma firme_resurse.nume%type, 
                                p_data_incheiere contracte.data_incheiere%type);
    function salariu_maxim_nivel (p_nivel angajati.nivel%type) return number;
    function salariu_minim_nivel (p_nivel angajati.nivel%type) return number;
    type tablou_imbricat_programari is table of programari%rowtype;
    procedure detalii_programari (p_data programari.data_programare%type);
    procedure cai_activi;
end pachet_extra;
/

create or replace package body pachet_extra as

procedure detalii_angajati_nivel (p_nivel angajati.nivel%type) is
    v_detalii tablou_imbricat_angajati;
    nivel_inexistent exception;
    numar_programari number;
    counter number := 0;
    ok number := 0;
    begin
        for ang in (select * from angajati) loop
            if ang.nivel = p_nivel 
                then ok := 1; 
            end if;
        end loop;
        
        if ok = 0
            then raise nivel_inexistent;
        end if;
        
        select * bulk collect into v_detalii
        from angajati 
        where nivel = p_nivel;
        
            dbms_output.put_line('Angajatii cu nivelul de pregatire ' || p_nivel || ':');
            for i in v_detalii.first .. v_detalii.last loop
                counter := counter + 1;
                select count(*) into numar_programari
                from programari 
                where cod_angajat = v_detalii(i).cod_angajat;
                
                dbms_output.put_line(counter || '. Angajatul ' || v_detalii(i).nume || ' ' || v_detalii(i).prenume
                                     || ' este angajat de pe data de ' || v_detalii(i).data_angajarii || '.');
                dbms_output.put_line('   Poate fi contactat la numarul de telefon ' || v_detalii(i).telefon || 
                                     ' sau la ' || v_detalii(i).email || '.');
                dbms_output.put_line('   Pana in prezent a tinut ' || numar_programari || ' programari.');
            end loop;

    exception
        when nivel_inexistent 
            then dbms_output.put_line('Nu exista acest nivel de pregatire!');
end detalii_angajati_nivel;

procedure detalii_clienti_nivel (p_nivel clienti.nivel%type) is
    v_detalii tablou_imbricat_clienti;
    nivel_inexistent exception;
    counter number := 0;
    ok number := 0;
    numar_programari number;
    begin
        for clt in (select * from clienti) loop
            if clt.nivel = p_nivel 
                then ok := 1; 
            end if;
        end loop;
        
        if ok = 0
            then raise nivel_inexistent;
        end if;
        
        select * bulk collect into v_detalii
        from clienti 
        where nivel = p_nivel;
        
            dbms_output.put_line('Clientii cu nivelul de pregatire ' || p_nivel || ':');
            for i in v_detalii.first .. v_detalii.last loop
                counter := counter + 1;
                select count(*) into numar_programari
                from programari 
                where cod_client = v_detalii(i).cod_client;
                
                dbms_output.put_line(counter || '. Clientul ' || v_detalii(i).nume || ' ' || v_detalii(i).prenume
                                     || ' este nascut pe data de ' || v_detalii(i).data_nasterii || '.');
                dbms_output.put_line('   Poate fi contactat la numarul de telefon ' || v_detalii(i).telefon || '.');
                dbms_output.put_line('   Pana in prezent a avut ' || numar_programari || ' programari.');         
            end loop;
            
    exception
        when nivel_inexistent 
            then dbms_output.put_line('Nu exista acest nivel de pregatire!');
end detalii_clienti_nivel;

function suma_totala return number is 
    v_suma number;
    begin
        select sum(cost) into v_suma
        from programari;
    return v_suma;
end suma_totala;

procedure clienti_fideli is 
    counter number := 1;
    valoare_curenta number;
    v_cod_client clienti.cod_client%type;
    v_numar_anterior number;
    v_numar number;
    v_nume clienti.nume%type;
    v_prenume clienti.prenume%type;
    v_index number := 0;
    cursor c_info is 
        select cod_client, count(*) as cnt
        from programari 
        group by cod_client
        order by cnt desc;
    begin
        dbms_output.put_line('Clientii fideli ai centrului de echitatie sunt:');
        
        select max(count(*)) into v_numar_anterior
        from programari 
        group by cod_client;
        
        open c_info;
        loop
            fetch c_info into v_cod_client, v_numar;
            exit when counter = 4 or c_info%notfound;
            
            v_index := v_index + 1;
            
            select nume, prenume into v_nume, v_prenume
            from clienti
            where cod_client = v_cod_client;
            
            if v_numar_anterior != v_numar 
                then counter := counter + 1; 
                     v_numar_anterior := v_numar;
            end if;
            
            if counter < 4 then 
                dbms_output.put_line(v_index || '.' || v_nume || ' ' || v_prenume || ' (' || v_numar || ' programari)');
            end if;
            
        end loop;
    end clienti_fideli;
    
procedure angajati_activi is 
    info tablou_indexat_angajati_activi;
    v_count_ingrijiri number;
    v_count_programari number;
    v_count_contracte number;
    v_nume angajati.nume%type;
    v_prenume angajati.prenume%type;
    counter number := 0;
    index_number number := 0;
    max_number number;
    begin 
        dbms_output.put_line('Cei mai activi angajati ai centrului de echitatie sunt:');
    
        for ang in (select cod_angajat from angajati) loop
            
            v_count_ingrijiri := 0;
            v_count_programari := 0;
            v_count_contracte := 0;
            
            for ing in (select * from ingrijiri) loop
                if ing.cod_angajat = ang.cod_angajat then 
                    v_count_ingrijiri := v_count_ingrijiri + 1;
                end if;
            end loop;
            
            for prg in (select * from programari) loop
                if prg.cod_angajat = ang.cod_angajat then 
                    v_count_programari := v_count_programari + 1;
                end if;
            end loop;
            
            for ctr in (select * from contracte) loop
                if ctr.cod_angajat = ang.cod_angajat then 
                    v_count_contracte := v_count_contracte + 1;
                end if;
            end loop;
            
            info(ang.cod_angajat) := v_count_contracte + v_count_programari + v_count_ingrijiri;
        end loop;
    
        while counter != 3 loop
            max_number := -998;
            for i in info.first..info.last loop
                if info(i) >= max_number and info(i) != -999 then 
                    max_number := info(i);
                end if;
            end loop;
            
            for i in info.first..info.last loop
                if info(i) = max_number then 
                    
                    select nume, prenume into v_nume, v_prenume
                    from angajati 
                    where cod_angajat = i;
                    
                    index_number := index_number + 1;
                    dbms_output.put_line(index_number  || '. Angajatul ' || v_nume || ' ' || v_prenume || 
                                         ' cu ' || info(i) || ' contributii.');
                                         
                    info(i) := -999;
                end if;
            end loop;
            
            counter := counter + 1;
        end loop;
           
    end angajati_activi;           
    
procedure expirare_contract (p_nume_angajat angajati.nume%type,
                            p_prenume_angajat angajati.prenume%type,
                            p_nume_firma firme_resurse.nume%type, 
                            p_data_incheiere contracte.data_incheiere%type) is 
    v_zile_valabilitate contracte.zile_valabilitate%type;
    v_cod_angajat contracte.cod_angajat%type;
    v_cod_firma contracte.cod_firma%type;
    aux number;
    begin
        begin 
            select cod_angajat into v_cod_angajat 
            from angajati 
            where prenume = p_prenume_angajat and nume = p_nume_angajat;
        exception
            when no_data_found then 
                dbms_output.put_line('Nu exista angajati cu acest nume!');
            when too_many_rows then 
                dbms_output.put_line('Sunt prea multi angajati cu acest nume!');
        end;
        
        begin 
            select cod_firma into v_cod_firma 
            from firme_resurse 
            where nume = p_nume_firma;
        exception 
            when no_data_found then 
                dbms_output.put_line('Nu exista firma de resurse cu acest nume!');
            when too_many_rows then 
                dbms_output.put_line('Sunt prea multe firme de resurse cu acest nume!');
        end;

            select zile_valabilitate into v_zile_valabilitate
            from contracte 
            where cod_angajat = v_cod_angajat and cod_firma = v_cod_firma and data_incheiere = p_data_incheiere;
            
            if v_zile_valabilitate is null
                then dbms_output.put_line('Contractul nu are un termen de expirare!');
            else 
                if trunc((sysdate-p_data_incheiere)) < v_zile_valabilitate then
                    aux := v_zile_valabilitate - trunc(sysdate-p_data_incheiere);
                    dbms_output.put_line('Contractul este valabil pentru inca ' || aux || ' zile!');
                else 
                    aux := trunc(sysdate-p_data_incheiere) - v_zile_valabilitate;
                    dbms_output.put_line('Contractul nu mai este valabil de ' || aux || ' zile!');
                end if;
            end if;
                
    exception
        when no_data_found then  
            dbms_output.put_line('Nu exista un contract corespondent semnat pe aceasta data!');
            
    end expirare_contract;
    
function salariu_maxim_nivel (p_nivel angajati.nivel%type) return number is
    v_salariu number;
    ok number;
    begin 
        select 1 into ok
        from dual 
        where p_nivel in (select distinct nivel from angajati);
        
        select max(salariu) into v_salariu
        from angajati 
        where nivel = p_nivel;
        
        return v_salariu;
    exception 
        when no_data_found then
            dbms_output.put_line('Nu exista acest nivel de pregatire!');
            return -1;
    end salariu_maxim_nivel;
    
function salariu_minim_nivel (p_nivel angajati.nivel%type) return number is
    v_salariu number;
    ok number;
    begin 
        select 1 into ok
        from dual 
        where p_nivel in (select distinct nivel from angajati);
        
        select min(salariu) into v_salariu
        from angajati 
        where nivel = p_nivel;
        
        return v_salariu;
    exception 
        when no_data_found then
            dbms_output.put_line('Nu exista acest nivel de pregatire!');
            return -1;
    end salariu_minim_nivel;

procedure detalii_programari (p_data programari.data_programare%type) is
    counter number := 0;
    info tablou_imbricat_programari;
    v_nume_client clienti.nume%type;
    v_prenume_client clienti.prenume%type;
    v_prenume_angajat angajati.prenume%type;
    v_nume_angajat angajati.nume%type;
    v_nume_cal cai.nume%type;
    begin 
        select * bulk collect into info
        from programari 
        where data_programare = p_data;
        
        if info.count() = 0 then 
            dbms_output.put_line('Nu au fost facute programari in data de ' || p_data || '!');
        else 
        
        for i in info.first..info.last loop
            select nume, prenume into v_nume_client, v_prenume_client
            from clienti
            where cod_client = info(i).cod_client;
            
            select nume, prenume into v_nume_angajat, v_prenume_angajat 
            from angajati 
            where cod_angajat = info(i).cod_angajat;
            
            select nume into v_nume_cal
            from cai 
            where cod_cal = info(i).cod_cal;
            
            counter := counter + 1;
            
            dbms_output.put_line(counter || '. Clientul ' || v_nume_client || ' ' || v_prenume_client ||
                                 ' s-a antrenat cu ' || v_nume_cal || ' in intervalul ' || 
                                 info(i).ora_inceput || '-' || info(i).ora_final || ', fiind supravegheat de ' ||
                                 v_nume_angajat || ' ' || v_prenume_angajat || '.');
        end loop;
    end if;
    end detalii_programari;
    
procedure cai_activi is 
    counter number := 1;
    valoare_curenta number;
    v_cod_cal cai.cod_cal%type;
    v_numar_anterior number;
    v_numar number;
    v_nume cai.nume%type;
    v_index number := 0;
    cursor c_info is 
        select cod_cal, count(*) as cnt
        from programari 
        group by cod_cal
        order by cnt desc;
    begin
        dbms_output.put_line('Cei mai activi cai centrului de echitatie sunt:');
        
        select max(count(*)) into v_numar_anterior
        from programari 
        group by cod_cal;
        
        open c_info;
        loop
            fetch c_info into v_cod_cal, v_numar;
            exit when counter = 4 or c_info%notfound;
            
            v_index := v_index + 1;
            
            select nume into v_nume
            from cai
            where cod_cal = v_cod_cal;
            
            if v_numar_anterior != v_numar 
                then counter := counter + 1; 
                     v_numar_anterior := v_numar;
            end if;
            
            if counter < 4 then 
                dbms_output.put_line(v_index || '.' || v_nume || ' (' || v_numar || ' programari)');
            end if;
            
        end loop;
    end cai_activi;
    
end pachet_extra;
/

declare 
    v_nivel angajati.nivel%type := '&vv_nivel';
begin 
    pachet_extra.detalii_angajati_nivel(v_nivel);
end;
/

declare 
    v_nivel clienti.nivel%type := '&vv_nivel';
begin 
    pachet_extra.detalii_clienti_nivel(v_nivel);
end;
/

declare 
    v_suma number;
begin 
    v_suma := pachet_extra.suma_totala;
    dbms_output.put_line ('Suma totala incasata pe programari: ' || v_suma || ' lei');
end;
/

begin 
    pachet_extra.clienti_fideli;
end;
/

begin 
    pachet_extra.angajati_activi;
end;
/

declare 
    v_nume angajati.nume%type := '&vv_nume';
    v_prenume angajati.prenume%type := '&vv_prenume';
    v_firma firme_resurse.nume%type := '&vv_firma';
    v_data contracte.data_incheiere%type := '&vv_data';
begin 
    pachet_extra.expirare_contract(v_nume, v_prenume, v_firma, to_date(v_data));
end;
/

declare 
    v_salariu_max number;
    v_nivel angajati.nivel%type := '&vv_nivel';
begin 
    v_salariu_max := pachet_extra.salariu_maxim_nivel(v_nivel);
    dbms_output.put_line('Salariul maxim pe nivelul ' || v_nivel || ' este: ' || v_salariu_max);
end;
/

declare 
    v_salariu_min number;
    v_nivel angajati.nivel%type := '&vv_nivel';
begin 
    v_salariu_min := pachet_extra.salariu_minim_nivel(v_nivel);
    dbms_output.put_line('Salariul minim pe nivelul ' || v_nivel || ' este: ' || v_salariu_min);
end;
/

declare 
    v_data programari.data_programare%type := '&vv_data';
begin 
    pachet_extra.detalii_programari(to_date(v_data));
end;
/

begin 
    pachet_extra.cai_activi;
end;
/

