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

-- CREARE TABEL ANGAJATI
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

-- CREARE TABEL CLIENTI 
create table clienti
(
    cod_client number(3) constraint cod_client_pk primary key,
    nume varchar2(50) not null constraint nume_client_initiale_mari check (nume=initcap(nume)),
    prenume varchar2(50) not null constraint prenume_client_initiale_mari check (prenume=initcap(prenume)),
    data_nasterii date not null,
    telefon varchar2(10) not null unique,
    nivel varchar2(20) constraint nivel_client_tip check (nivel in ('incepator', 'elementar', 'intermediar', 'avansat', 'profesionist'))
);

-- CREARE TABEL CATEGORII 
create table categorii 
(
    cod_categorie number(3) constraint cod_categorie_pk primary key,
    tip varchar2(100) not null constraint tip_categorie check (tip in ('dresaj', 'sarituri peste obstacole', 'plimbari pe teren accidentat', 'plimbari simple', 'reining')),
    pret_ora_echitatie number(2) not null
);

-- CREARE TABEL FIRME_RESURSE 
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

-- CREARE TABEL CABINETE_VETERINARE 
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

-- CREARE TABEL CENTRE_DRESAJ 
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

-- CREARE TABEL MEDICI 
create table medici
(
    cod_medic number(3) constraint cod_medic_pk primary key,
    nume varchar2(50) not null constraint nume_medic_initiale_mari check (nume=initcap(nume)),
    prenume varchar2(50) not null constraint prenume_medic_initiale_mari check (prenume=initcap(prenume)),
    telefon varchar2(10) not null unique,
    email varchar2(50) not null unique constraint email_medic_format check (email=lower(email) and email like '%@%'),
    cod_cabinet number(6) references cabinete_veterinare(cod_cabinet)
);

-- CREARE TABEL LOCATII
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

-- CREARE TABEL CAI 
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

-- CREARE TABEL CONSULTATII 
create table consultatii 
(
   data_consultatie date not null, 
   cod_medic number(3) not null, 
   cod_cal number(2) not null, 
   rezultat varchar2(100) not null, 
   primary key(data_consultatie, cod_medic, cod_cal),
   foreign key (cod_medic) references medici(cod_medic),
   foreign key (cod_cal) references cai(cod_cal)
)

-- CREARE TABEL PROGRAME_CLIENT
create table programe_client 
(
    ora_inceput varchar2(10) not null, 
    ora_sfarsit varchar2(10) not null, 
    ora_inceput_pauza varchar2(10) not null, 
    ora_sfarsit_pauza varchar2(10) not null, 
    primary key (ora_inceput, ora_sfarsit)
);

-- CREARE TABEL PROGRAME_BOXA
create table programe_boxa 
(
    ora_inceput varchar2(10) not null, 
    ora_sfarsit varchar2(10) not null, 
    primary key (ora_inceput, ora_sfarsit)
);

-- CREARE TABEL CONTRACTE 
create table contracte 
(
    data_incheiere date not null,
    cod_angajat number(3) not null, 
    cod_firma number(6) not null, 
    zile_valabilitate number(4),
    primary key (data_incheiere, cod_angajat, cod_firma),
    foreign key (cod_angajat) references angajati(cod_angajat),
    foreign key (cod_firma) references firme_resurse(cod_firma)
)

-- CREARE TABEL AVIZE 
create table avize
(
    numar_inregistrare number(6) constraint numar_inregistrare_aviz_pk primary key, 
    data_emitere date not null,
    data_predare date not null, 
    doctor varchar2(50) not null constraint doctor_initiale_majuscule check (doctor=initcap(doctor)),
    cod_client number(3) not null references clienti(cod_client)
);

-- CREARE TABEL PROGRAMARI 
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

-- CREARE TABEL INGRIJIRI 
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

-- INSERARE DE DATE IN TABELUL ANGAJATI 
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

-- INSERARE DE DATE IN TABELUL CLIENTI
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

-- INSERARE DE DATE IN TABELUL CATEGORII
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

-- INSERARE DE DATE IN TABELUL FIRME_RESURSE
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

-- INSERARE DE DATE IN TABELUL LOCATII
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

-- INSERARE DE DATE IN TABELUL PROGRAME_BOXA
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

-- INSERARE DE DATE IN TABELUL PROGRAME_CLIENT
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

-- INSERARE DE DATE IN TABELUL CABINETE_VETERINARE
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

-- INSERARE DE DATE IN TABELUL AVIZE
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

insert into avize(numar_inregistrare, data_emitere, data_predare, doctor, cod_client)
values (123465, to_date('01-04-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 'Vasilescu Maria', 210);

-- INSERARE DE DATE IN TABELUL MEDICI
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

-- INSERARE DE DATE IN TABELUL CENTRE_DRESAJ
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

-- INSERARE DE DATE IN TABELUL CAI
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

-- INSERARE DE DATE IN TABELUL CONSULTATII
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

-- INSERARE DE DATE IN TABELUL CONTRACTE
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

-- INSERARE DE DATE IN TABELUL PROGRAMARI
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
values(to_date('09-04-2022', 'dd-mm-yyyy'), '12:00', '13:00', 210, 102, 15, 0);

insert into programari(data_programare, ora_inceput, ora_final, cod_client, cod_angajat, cod_cal, cost)
values(to_date('09-04-2022', 'dd-mm-yyyy'), '15:00', '16:00', 204, 107, 10, 0);

-- INSERARE DE DATE IN TABELUL INGRIJIRI
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

-- DATE INSERATE ULTERIOR CE NE AJUTA LA REZOLVAREA CLARA A SUBCERERILOR SAU A ACTUALIZARILOR
insert into avize(numar_inregistrare, data_emitere, data_predare, doctor, cod_client)
values (123467, to_date('28-03-2022', 'dd-mm-yyyy'), to_date('29-03-2022', 'dd-mm-yyyy'), 'Zamfir Ionela Mihai', 205);

insert into programari(data_programare, ora_inceput, ora_final, cod_client, cod_angajat, cod_cal, cost)
values(to_date('10-04-2022', 'dd-mm-yyyy'), '18:00', '19:00', 200, 105, 19, 0);

insert into programari(data_programare, ora_inceput, ora_final, cod_client, cod_angajat, cod_cal, cost)
values(to_date('14-04-2022', 'dd-mm-yyyy'), '12:00', '13:00', 207, 103, 11, 0);

insert into angajati(cod_angajat, nume, prenume, telefon, email, data_angajarii, salariu, nivel)
values (SECVENTA_PK_ANGAJAT.nextval, 'Cojocaru', 'Denisa', '0756231890', 'cojocaru.denisa@akira.com', to_date('15-09-2017', 'dd-mm-yyyy'), 2000, null);


-- La inserarea program?rilor �n tabel, costul acestora a fost trecut 0. 
-- S? se actualizeze pre?ul conform categoriei pentru care se antreneaz? clien?ii la programarea respectiv?. 

update programari p
set p.cost = (select pret_ora_echitatie
              from categorii cat, centre_dresaj cd, cai
              where cat.cod_categorie = cd.cod_categorie 
              and cai.cod_centru_dresaj = cd.cod_centru 
              and cai.cod_cal = p.cod_cal);
              
-- 12 randuri actualizate

-- Angaja?ii centrului de echita?ie au fost �n?tiin?a?i printr-un email al unei 
-- firme de resurse c? aceasta ?i-a �nchis toate depozitele din Rom�nia. 
-- ?tiind c? email-ul este equipment@equinelife.com, 
-- s? se elimine loca?iile depozitelor �nchise din baza de date. 

delete from locatii 
where upper(tara_depozit) = 'ROMANIA' 
and cod_firma = (select cod_firma 
                 from firme_resurse
                 where lower(email) = 'equipment@equinelife.com');
                 
-- 1 rand sters 

-- La programarea din data de 7 aprilie 2022 desf??urat? �n intervalul orar 14:00 � 15:00, 
-- angajatul centrului de echita?ie a fost �n?tiin?a? de c?tre client c? �n ultimul 
-- aviz pe care l-a adus s-a strecurat o gre?eal?: numele medicului era de fapt Zamfir Ionel Mihai. 
-- Modifica?i acest aspect �n baza de date. 

update avize 
set doctor = 'Zamfir Ionel Mihai' 
where data_predare = 
(select max(data_predare)
from avize 
group by cod_client
having cod_client = (select cod_client
                    from programari 
                    where data_programare = to_date('07-04-2022', 'dd-mm-yyyy') and 
                    ora_inceput = '14:00' and ora_final = '15:00'))
and cod_client = (select cod_client
                  from programari 
                  where data_programare = to_date('07-04-2022', 'dd-mm-yyyy') and 
                  ora_inceput = '14:00' and ora_final = '15:00');

-- 1 rand actualizat

-- Pentru fiecare nivel al pregatirii in domeniul echitatiei, sa se afiseze numele, prenumele si 
-- salariul celor mai bine platiti angajati, precum si numarul de lectii pe care l-au tinut.
-- Ordonati aceste rezultate descrescator in functie de salariu.

with programari_angajati as 
(select cod_angajat, count(*) as numar_programari from programari group by cod_angajat)
select nume, prenume, salariu, a.nivel, numar_programari
from angajati a, (select nivel, max(salariu) as maxim_salarii
                from angajati 
                group by nivel) aux, programari_angajati p
where a.salariu = aux.maxim_salarii and a.nivel = aux.nivel and p.cod_angajat = a.cod_angajat
order by salariu desc;

-- 5 rezultate 

-- S? se afi?eze mesaje despre caii maro ai centrului de echita?ie dup? cum urmeaz?:
-- '{nume} este un cal {culoare} de rasa {rasa} avand {varsta} ani si fiind antrenat pentru {categorie}.'
-- Sa se afiseze intr-o coloana separata anotimpul in care acestia s-au nascut si ultimul medic veterinar care i-a consultat. 

with ultima_consultatie as 
(select max(data_consultatie) as max_data, cod_cal
from consultatii
group by cod_cal)
select concat(concat(concat(concat(concat(cai.nume, ' este un cal '), culoare), ' de rasa '), rasa), ' avand ')
|| concat(concat(concat(to_char(trunc(months_between(sysdate, data_nasterii)/12)),' ani si fiind antrenat pentru '), cat.tip), '.') 
as informatii, case
               when extract(month from data_nasterii) in (12, 1, 2) then 'iarna'
               when extract(month from data_nasterii) in (3, 4, 5) then 'primavara'
               when extract(month from data_nasterii) in (6, 7, 8) then 'vara'
               when extract(month from data_nasterii) in (9, 10, 11) then 'toamna'
               end as Anotimp, med.nume || ' ' || med.prenume as Doctor
from cai, categorii cat, centre_dresaj cd, ultima_consultatie uc, consultatii cst, medici med
where instr(upper(culoare), 'MARO') != 0 and cai.cod_centru_dresaj = cd.cod_centru and cd.cod_categorie = cat.cod_categorie
and cai.cod_cal = uc.cod_cal and uc.max_data = cst.data_consultatie and cst.cod_medic = med.cod_medic;

-- 6 rezultate 

--Centrul de echitatie se g�nde?te s? modifice salariile salariatilor 
--care au fost angajati in luni ale anului in care au fost angajati mai mult de 1 angajat.
--Modificarea se face in functie de nivelul fiecarui salariat:
--- daca este profesionist, salariul se mareste cu 25%
--- daca este avansat, salariul se mareste cu 500 ron
--- daca este intermediar, salariul se micsoreaza cu 250 ron
--- daca este incepator, salariul se micsoreaza cu 5%
--- daca nu este precizat nivelul, salariul se mareste cu 100 rom
--- altfel, nu se modifica
-- Sa se afiseze numele, prenumele, data_angajarii, nivelul, salariul si noua propunere de salariu pentru fiecare angajat. 
-- Daca nu este precizat nivelul sa se afiseze un mesaj corespunzator in locul valorii null.

select nume, prenume, data_angajarii, nvl(nivel, 'nu este precizat nivelul'), salariu, 
       decode (nvl(initcap(nivel), 'Nu este precizat nivelul'), 
       'Profesionist', salariu + 25/100*salariu,
       'Avansat', salariu + 500,
       'Intermediar', salariu - 250,
       'Incepator', salariu - 5/100*salariu,
       'Nu este precizat nivelul', salariu + 100,
       salariu) as propunere_salariu
from angajati
where extract(month from data_angajarii) in
(select extract(month from data_angajarii) as luna
from angajati 
group by extract(month from data_angajarii)
having count(*) > 1);

-- 5 rezultate 

-- S? se selecteze numele firmelor ?i tipul de resurse furnizate pentru firmele care
-- au depozite �n judetele �n care se afl? ?i cabinetele veterinare �n care se g?sesc 
-- medicii veterinari ce au consultat toate iepele centrului de echita?ie. 

select nume, tip_resurse
from firme_resurse
where cod_firma in (select cod_firma
                    from locatii 
                    where judet_depozit in (select distinct judet
                                            from cabinete_veterinare, medici
                                            where cod_medic in (select distinct cod_medic
                                                                from consultatii 
                                                                where cod_cal in (select cod_cal
                                                                                  from cai 
                                                                                  where sex = 'F')) 
                                                            and medici.cod_cabinet = cabinete_veterinare.cod_cabinet));

-- 1 rezultat 

-- Sa se afiseze detalii despre lectiile de echitatie la care au participat 
-- clienti care au adus ultimul aviz medical in luna februarie. In locul codurilor de identificare
-- sa se afiseze numele clientului, angajatului si calului. 

select data_programare, ora_inceput, ora_final, 
(select nume || ' ' || prenume 
from clienti cc
where p.cod_client = cc.cod_client) as client,
(select nume || ' ' || prenume 
from angajati aa 
where p.cod_angajat = aa.cod_angajat) as angajat,
(select nume 
from cai ccc 
where p.cod_cal = ccc.cod_cal) as cal
from programari p -- selectez din programari programarile corespunzatoare acelor clienti
where p.cod_client = 
(select cod_client
from clienti c -- selectez din clienti clientii cu avize cu luna maxima = februarie
where c.cod_client = p.cod_client and extract(month from (select data_predare
                            from avize av -- selectez din avize luna maxima 
                            where c.cod_client = av.cod_client and 
                            data_predare = (select max(data_predare) from avize aav where aav.cod_client = c.cod_client group by cod_client))) = 2); 

-- 10 rezultate 

-- Sa se afi?eze numele cailor, codul centrului de dresaj si numele centrului de dresaj de la care provin pentru caii care au culoarea 
-- maro ?i sunt de sex feminin ?i centrele de dresaj care au luna �nfiin??rii decembrie. 
-- Cerere:
--R1 = PROJECT(CAI, cod_cal, nume, culoare, sex, cod_centru_dresaj)
--R2 = SELECT(R1, instr(upper(culoare), 'MARO') != 0)
--R3 = SELECT(R2, sex = 'F')
--R4 = PROJECT(R3, nume, cod_centru_dresaj)
--R5 = PROJECT(CENTRE_DESAJ, cod_centru, nume, data_infiintare)
--R6 = SELECT(R5, extract(month from data_infiintare) = 12)
--R7 = PROJECT(R6, nume, cod_centru)
--Rezultat = JOIN(R4, R7)

select cd.cod_centru, cd.nume, c.nume from 
(select nume, cod_centru_dresaj from (select * from (select * from (select cod_cal, nume, culoare, sex, cod_centru_dresaj
from cai)
where instr(upper(culoare), 'MARO') != 0)
where sex = 'F')) c,
(select nume, cod_centru from (select * from (select cod_centru, nume, data_infiintare
from centre_dresaj) 
where extract(month from data_infiintare) = 12)) cd
where c.cod_centru_dresaj = cd.cod_centru;

-- 2 rezultate 

-- Cerere optimizata 

select cod_centru, c.nume, cd.nume
from (select * from centre_dresaj where extract(month from data_infiintare) = 12) cd,
(select * from cai where instr(upper(culoare), 'MARO') != 0 and sex = 'F') c
where cd.cod_centru = c.cod_centru_dresaj;

select cod_centru, c.nume, cd.nume
from cai c, centre_dresaj cd
where cod_centru_dresaj = cod_centru 
and extract(month from data_infiintare) = 12 
and instr(upper(culoare), 'MARO') != 0 
and sex = 'F';

-- 2 rezultate 

