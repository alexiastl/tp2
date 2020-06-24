set SERVEROUTPUT ON

drop table TP2_PLATEFORME cascade constraints;
drop table TP2_HORAIRE_PLATEFORME cascade constraints;
drop table TP2_CHAINE cascade constraints;
drop table TP2_HORAIRE_CHAINE cascade constraints;
drop table TP2_CINEMA cascade constraints;
drop table TP2_HORAIRE_CINEMA cascade constraints;
drop table TP2_BILLET_CINEMA cascade constraints;
drop table TP2_OEUVRE cascade constraints;
drop table TP2_REALISATEUR_OEUVRE cascade constraints;
drop table TP2_REALISATEUR cascade constraints;
drop table TP2_ROLE_OEUVRE cascade constraints;
drop table TP2_ACTEUR cascade constraints;
drop table TP2_UTILISATEUR cascade constraints;
drop table TP2_CRITIQUE cascade constraints;
drop sequence NO_CRITIQUE_SEQ;

create table TP2_PLATEFORME(
    NOM_PLATEFORME varchar2(40) not null,
    COMPAGNIE_PLA varchar2(40) not null,
    URL_PLA varchar(40) not null,
    constraint PK_PLATEFORME primary key (NOM_PLATEFORME));
    
create table TP2_HORAIRE_PLATEFORME(
    NOM_PLATEFORME varchar2(40) not null,
    NO_OEUVRE number(6,0) not null,
    DATE_HEURE_HORP date not null,
    constraint PK_HORAIRE_PLATEFORME primary key (NOM_PLATEFORME, NO_OEUVRE, DATE_HEURE_HORP));
    
create table TP2_CHAINE(
    NOM_CHAINE varchar2(40) not null,
    COMPAGNIE_CHA varchar2(40) not null,
    URL_CHA varchar(40) not null,
    constraint PK_CHAINE primary key (NOM_CHAINE));
    
create table TP2_HORAIRE_CHAINE(
    NOM_CHAINE varchar2(40) not null,
    NO_OEUVRE number(6,0) not null,
    DATE_HEURE_HORCH date not null,
    constraint PK_HORAIRE_CHAINE primary key (NOM_CHAINE, NO_OEUVRE, DATE_HEURE_HORCH));
    
create table TP2_CINEMA(
    NOM_CINEMA varchar2(40) not null,
    COMPAGNIE_CIN varchar2(40) not null,
    ADR_CIN varchar(50) not null,
    VILLE_CIN varchar(40) not null,
    TELEPHONE_CIN char(13) not null,
    constraint PK_CINEMA primary key (NOM_CINEMA));
    
create table TP2_HORAIRE_CINEMA(
    NOM_CINEMA varchar2(40) not null,
    NO_OEUVRE number(6,0) not null,
    DATE_DEBUT_HORC date not null,
    HEURE_HORC date not null,
    DATE_FIN_HORC date not null,
    constraint PK_HORAIRE_CINEMA primary key (NOM_CINEMA, NO_OEUVRE, DATE_DEBUT_HORC, HEURE_HORC));

create table TP2_BILLET_CINEMA(
    NOM_CINEMA varchar2(40) not null,
    CATEGORIE_BIL varchar2(40) not null,
    PERIODE_JOURNEE_BIL varchar(40) not null,
    MNT_PRIX_BIL number(4,2) default 12.99 not null,
    constraint PK_BILLET_CINEMA primary key (NOM_CINEMA, CATEGORIE_BIL, PERIODE_JOURNEE_BIL));
    

create table TP2_OEUVRE (
    NO_OEUVRE number(6,0) generated by default as identity(start with 1 increment by 1) not null,
    TITRE_OEU varchar2(30) not null,
    ANNEE_OEU number(4,0) not null,
    GENRE_OEU varchar2(30) not null,
    SYNOPSIS_OEU varchar2(500) not null,
    DUREE_OEU number(3,0) not null,
    CLASSEMENT_OEU varchar2(10) not null,
    COMPAGNIE_OEU varchar2(30) not null,
    constraint PK_OEUVRE primary key (NO_OEUVRE)
);

create table TP2_REALISATEUR (
    NO_REALISATEUR number(6,0) generated by default as identity(start with 1 increment by 1) not null,
    PRENOM_REA varchar2(30) not null,
    NOM_REA varchar2(30) not null,
    constraint PK_REALISATEUR primary key (NO_REALISATEUR)
);

create table TP2_REALISATEUR_OEUVRE (
    NO_OEUVRE number(6,0) not null,
    NO_REALISATEUR number(6,0) not null, 
    constraint PK_RO_OEU_REA primary key( NO_OEUVRE, NO_REALISATEUR)
);

create table TP2_ACTEUR (
    NO_ACTEUR number(6,0) generated by default as identity(start with 1 increment by 1) not null,
    NOM_ACT varchar2(30) not null,
    PRENOM_ACT varchar2(30) not null,
    DATE_NAISSANCE_ACT date not null,
    COURRIEL_ACT varchar2(30) not null,
    constraint PK_ACTEUR primary key (NO_ACTEUR) 
);

create table TP2_ROLE_OEUVRE (
    NO_OEUVRE number(6,0) not null,
    PERSONNAGE varchar2(50) not null,
    NO_ACTEUR number(6,0) not null,
    constraint PK_ROLE_OEUVRE primary key (NO_OEUVRE, PERSONNAGE)
);



create table TP2_UTILISATEUR (
    LOGIN_UTILISATEUR varchar2(10)not null, /*A VERIFIER*/
    NOM_UTI varchar2(30) not null,
    PRENOM_UTI varchar2(30) not null,
    COURRIEL_UTI varchar2(30) not null,
    DATE_NAISSANCE_UTI date not null,
    MOT_DE_PASSE_UTI varchar2(12) not null, /*A verifier*/
    TYPE_UTI varchar2(30) default 'Utilisateur' not null,
    constraint PK_UTILISATEUR primary key (LOGIN_UTILISATEUR),
    constraint AK_COURRIEL_UTI unique (COURRIEL_UTI)
);

/* On suppose qu'une critique paren*/
create table TP2_CRITIQUE(
    NO_CRITIQUE number(6,0) not null,
    NO_OEUVRE number(6,0) not null,
    SURNOM_MEMBRE varchar2(10) not null, /*verifier comme login*/ 
    DATE_CRI date default sysdate not null,
    COTE_CRI number(3,1) null, 
    COMMENTAIRE_CRI VARCHAR2(500) default ' ' not null,
    REPOND_A_NO_CRITIQUE NUMBER(6,0) null,
    constraint PK_CRITIQUE primary key(NO_CRITIQUE),
    constraint AK_CRITIQUE unique (NO_OEUVRE, SURNOM_MEMBRE, DATE_CRI)
);

alter table TP2_HORAIRE_PLATEFORME
    add (constraint FK_PLA_NOM_PLATEFORME foreign key (NOM_PLATEFORME) references TP2_PLATEFORME(NOM_PLATEFORME),
    constraint FK_PLA_NO_OEUVRE foreign key (NO_OEUVRE) references TP2_OEUVRE(NO_OEUVRE));
    
alter table TP2_HORAIRE_CHAINE
    add (constraint FK_PLA_NOM_CHAINE foreign key (NOM_CHAINE) references TP2_CHAINE(NOM_CHAINE),
    constraint FK_CHA_NO_OEUVRE foreign key (NO_OEUVRE) references TP2_OEUVRE(NO_OEUVRE));
    
alter table TP2_HORAIRE_CINEMA
    add (constraint FK_HC_NOM_CINEMA foreign key (NOM_CINEMA) references TP2_CINEMA(NOM_CINEMA),
    constraint FK_HC_NO_OEUVRE foreign key (NO_OEUVRE) references TP2_OEUVRE(NO_OEUVRE));
    
alter table TP2_BILLET_CINEMA
    add constraint FK_BIL_NOM_CINEMA foreign key (NOM_CINEMA) references TP2_CINEMA(NOM_CINEMA);

alter table TP2_REALISATEUR_OEUVRE
    add constraint FK_REA_O_NO_OEUVRE foreign key(NO_OEUVRE) references TP2_OEUVRE (NO_OEUVRE);
    
alter table TP2_REALISATEUR_OEUVRE
    add constraint FK_REA_O_NO_REA foreign key (NO_REALISATEUR) references TP2_REALISATEUR (NO_REALISATEUR);
    
alter table TP2_ROLE_OEUVRE
    add constraint FK_ROL_NO_OEUVRE foreign key (NO_OEUVRE) references TP2_OEUVRE (NO_OEUVRE);
    
alter table TP2_ROLE_OEUVRE
    add constraint FK_RO_NO_ACTEUR foreign key (NO_ACTEUR) references TP2_ACTEUR (NO_ACTEUR);

alter table TP2_CRITIQUE 
    add constraint FK_CRI_NO_OEUVRE foreign key (NO_OEUVRE) references TP2_OEUVRE(NO_OEUVRE);

alter table TP2_CRITIQUE 
    add constraint FK_CRI_REPOND_A foreign key (REPOND_A_NO_CRITIQUE) references TP2_CRITIQUE(NO_CRITIQUE);
alter table TP2_CRITIQUE 
    add constraint FK_CRI_SURNOM_MEM foreign key (SURNOM_MEMBRE) references TP2_UTILISATEUR(LOGIN_UTILISATEUR);
    
create sequence NO_CRITIQUE_SEQ
    start with 5 
    increment by 5 ;

insert into TP2_OEUVRE( TITRE_OEU, ANNEE_OEU, GENRE_OEU, SYNOPSIS_OEU, DUREE_OEU, CLASSEMENT_OEU, COMPAGNIE_OEU) 
    values ('Titanic',1997,'romance',
        'Southampton, 10 avril 1912. Le paquebot le plus grand et le plus moderne du monde, r�put� pour son insubmersibilit�, 
        le "Titanic", appareille pour son premier voyage. Quatre jours plus tard, il heurte un iceberg. 
        A son bord, un artiste pauvre et une grande bourgeoise tombent amoureux.',188,'G','Paramount Pictures');

insert into TP2_OEUVRE( TITRE_OEU, ANNEE_OEU, GENRE_OEU, SYNOPSIS_OEU, DUREE_OEU, CLASSEMENT_OEU, COMPAGNIE_OEU) 
    values ('Joker',2019,'drame',
        'Le film, qui relate une histoire originale in�dite sur grand �cran, se focalise sur la figure embl�matique de 
        l''ennemi jur� de Batman. Il brosse le portrait d''Arthur Fleck, un homme sans concession m�pris� par la soci�t�. ',
        122,'12+','DC FIlms');

insert into TP2_OEUVRE( TITRE_OEU, ANNEE_OEU, GENRE_OEU, SYNOPSIS_OEU, DUREE_OEU, CLASSEMENT_OEU, COMPAGNIE_OEU) 
    values ('Cadavres � tous les clics',2019,'thriller','Plusieurs membres du site Quebingeton sont d�c�d�s de fa�on
    suspecte.',
        96,'18+','Horror Studio');

insert into TP2_REALISATEUR (NOM_REA, PRENOM_REA)
    values ('Cameron','James');
    
insert into TP2_REALISATEUR (NOM_REA, PRENOM_REA)
    values ('Phillips','Todd');
    
insert into TP2_REALISATEUR_OEUVRE 
    VALUES(1,1);
    
insert into TP2_REALISATEUR_OEUVRE 
    VALUES(2,2);

insert into TP2_PLATEFORME(NOM_PLATEFORME, COMPAGNIE_PLA, URL_PLA)
    values('Netflix', 'Netflix', 'http://www.netflix.com');
    
insert into TP2_PLATEFORME(NOM_PLATEFORME, COMPAGNIE_PLA, URL_PLA)
    values('HBO', 'HBO Go', 'http://www.hbo.com');
    
insert into TP2_HORAIRE_PLATEFORME(NOM_PLATEFORME, NO_OEUVRE, DATE_HEURE_HORP)
    values('Netflix', 1, to_date('2018-05-22 19:30', 'YYYY-MM-DD HH24:MI'));
    
insert into TP2_HORAIRE_PLATEFORME(NOM_PLATEFORME, NO_OEUVRE, DATE_HEURE_HORP)
    values('HBO', 2, to_date('2020-03-13 12:30', 'YYYY-MM-DD HH24:MI'));
    
insert into TP2_CHAINE(NOM_CHAINE, COMPAGNIE_CHA, URL_CHA)
    values('TVA', 'Groupe TVA', 'http://www.tva.ca');
    
insert into TP2_CHAINE(NOM_CHAINE, COMPAGNIE_CHA, URL_CHA)
    values('VRAK', 'Bell Media', 'http://www.vrak.tv');
    
insert into TP2_HORAIRE_CHAINE(NOM_CHAINE, NO_OEUVRE, DATE_HEURE_HORCH)
    values('TVA', 1, to_date('2018-05-17 12:30', 'YYYY-MM-DD HH24:MI'));
    
insert into TP2_HORAIRE_CHAINE(NOM_CHAINE, NO_OEUVRE, DATE_HEURE_HORCH)
    values('VRAK', 2, to_date('2020-06-17 18:45', 'YYYY-MM-DD HH24:MI'));

insert into TP2_HORAIRE_CHAINE(NOM_CHAINE, NO_OEUVRE, DATE_HEURE_HORCH)
    values('TVA', 3, to_date('2019-12-12 12:30', 'YYYY-MM-DD HH24:MI'));
    
insert into TP2_HORAIRE_CHAINE(NOM_CHAINE, NO_OEUVRE, DATE_HEURE_HORCH)
    values('VRAK', 3, to_date('2017-07-30 18:45', 'YYYY-MM-DD HH24:MI'));

insert into TP2_CINEMA(NOM_CINEMA, COMPAGNIE_CIN, ADR_CIN, VILLE_CIN, TELEPHONE_CIN)
    values('Cineplex Odeon Beauport', 'Cineplex', '825 Rue Cl�menceau', 'Qu�bec', '(418)661-9494');
    
insert into TP2_CINEMA(NOM_CINEMA, COMPAGNIE_CIN, ADR_CIN, VILLE_CIN, TELEPHONE_CIN)
    values('Cineplex Laval', 'Cineplex', '2800 Ave du Cosmod�me', 'Laval', '(450)978-0212');
    
insert into TP2_HORAIRE_CINEMA(NOM_CINEMA, NO_OEUVRE, DATE_DEBUT_HORC, HEURE_HORC, DATE_FIN_HORC)
    values('Cineplex Odeon Beauport', 1, to_date('2020-01-17', 'YYYY-MM-DD'), to_date('11:30', 'HH24:MI'), to_date('2020-03-02', 'YYYY-MM-DD'));
    
insert into TP2_HORAIRE_CINEMA(NOM_CINEMA, NO_OEUVRE, DATE_DEBUT_HORC, HEURE_HORC, DATE_FIN_HORC)
    values('Cineplex Laval', 2, to_date('2020-02-18', 'YYYY-MM-DD'), to_date('14:30', 'HH24:MI'), to_date('2020-04-08', 'YYYY-MM-DD'));
    
insert into TP2_BILLET_CINEMA(NOM_CINEMA, CATEGORIE_BIL, PERIODE_JOURNEE_BIL, MNT_PRIX_BIL)
    values('Cineplex Odeon Beauport', 'Adulte', 'Apr�s-midi', 11.99);

insert into TP2_BILLET_CINEMA(NOM_CINEMA, CATEGORIE_BIL, PERIODE_JOURNEE_BIL, MNT_PRIX_BIL)
    values('Cineplex Odeon Beauport', 'Adulte', 'Soir', 12.99);

insert into TP2_BILLET_CINEMA(NOM_CINEMA, CATEGORIE_BIL, PERIODE_JOURNEE_BIL, MNT_PRIX_BIL)
    values('Cineplex Odeon Beauport', '�tudiant', 'Soir', 5.99);
    
insert into TP2_BILLET_CINEMA(NOM_CINEMA, CATEGORIE_BIL, PERIODE_JOURNEE_BIL, MNT_PRIX_BIL)
    values('Cineplex Laval', 'Enfant', 'Avant-midi', 9.99);

insert into TP2_BILLET_CINEMA(NOM_CINEMA, CATEGORIE_BIL, PERIODE_JOURNEE_BIL, MNT_PRIX_BIL)
    values('Cineplex Laval', 'Adulte', 'Avant-midi', 11.99);

insert into TP2_ACTEUR (NOM_ACT, PRENOM_ACT,DATE_NAISSANCE_ACT, COURRIEL_ACT)
    values ('DiCaprio','Leonardo',to_date('74-11-11','YY-MM-DD'), 'LeoDiCaprio74@gmail.com');

insert into TP2_ACTEUR (NOM_ACT, PRENOM_ACT,DATE_NAISSANCE_ACT, COURRIEL_ACT)
    values ('Phoenix','Joaquin',to_date('74-10-28','YY-MM-DD'), 'PhoenixJoaquin74@hotmail.com');

insert into TP2_ROLE_OEUVRE (NO_OEUVRE, PERSONNAGE, NO_ACTEUR)
    values (1,'Jack Dawson',1);
    
insert into TP2_ROLE_OEUVRE (NO_OEUVRE, PERSONNAGE, NO_ACTEUR)
    values (2,'Arthur Fleck / Le Joker',2);

insert into TP2_UTILISATEUR (LOGIN_UTILISATEUR, NOM_UTI, PRENOM_UTI, COURRIEL_UTI,DATE_NAISSANCE_UTI,MOT_DE_PASSE_UTI,TYPE_UTI)
    values ('MovieLover','Doe','Jane','janedoe@gmail.com',to_date('80-8-6','YY-MM-DD'),'motdepass','Membre');
    
insert into TP2_UTILISATEUR (LOGIN_UTILISATEUR, NOM_UTI, PRENOM_UTI, COURRIEL_UTI,DATE_NAISSANCE_UTI,MOT_DE_PASSE_UTI,TYPE_UTI)
    values ('KenKen','Plastic','Ken','kenken@gmail.com',to_date('98-03-21','YY-MM-DD'),'jaimebarbie','Membre');

insert into TP2_UTILISATEUR (LOGIN_UTILISATEUR, NOM_UTI, PRENOM_UTI, COURRIEL_UTI,DATE_NAISSANCE_UTI,MOT_DE_PASSE_UTI,TYPE_UTI)
    values ('BarbieDoll','Doll','Barbie','barbie@gmail.com',to_date('99-8-8','YY-MM-DD'),'jaimeKen','Membre');

insert into TP2_UTILISATEUR (LOGIN_UTILISATEUR, NOM_UTI, PRENOM_UTI, COURRIEL_UTI,DATE_NAISSANCE_UTI,MOT_DE_PASSE_UTI,TYPE_UTI)
    values ('BobMod','Tremblay','Bob','bobmoderateur@quebingeton.com',to_date('90-03-03','YY-MM-DD'),'fG54pot*','Employ�');    

create or replace view TP2_VUE_MEMBRE (SURNOM_MEMBRE, NOM_MEM, PRENOM_MEM, COURRIEL_MEM, DATE_NAISSANCE_MEM, MOT_DE_PASSE_MEM) as
    select LOGIN_UTILISATEUR, NOM_UTI, PRENOM_UTI, COURRIEL_UTI, DATE_NAISSANCE_UTI, MOT_DE_PASSE_UTI
        from TP2_UTILISATEUR
            where TYPE_UTI = 'Membre';
            
create or replace view TP2_VUE_EMPLOYE (LOGIN_EMPLOYE, PRENOM_EMP, NOM_EMP, COURRIEL_EMP, MOT_DE_PASSE_EMP) as
    select LOGIN_UTILISATEUR, PRENOM_UTI, NOM_UTI, COURRIEL_UTI, MOT_DE_PASSE_UTI
        from TP2_UTILISATEUR
            where TYPE_UTI = 'Employ�';



insert into TP2_CRITIQUE(NO_CRITIQUE,NO_OEUVRE,SURNOM_MEMBRE,DATE_CRI,COTE_CRI,COMMENTAIRE_CRI) 
    values (NO_CRITIQUE_SEQ.nextval,1, 'MovieLover',to_date('20-01-03','YY-MM-DD'),10.0,'C''est trop triste...');

insert into TP2_CRITIQUE(NO_CRITIQUE,NO_OEUVRE,SURNOM_MEMBRE,COTE_CRI,COMMENTAIRE_CRI,REPOND_A_NO_CRITIQUE) 
    values (NO_CRITIQUE_SEQ.nextval,1, 'BobMod',null,'C''est vrai!!',5);
    
insert into TP2_CRITIQUE(NO_CRITIQUE,NO_OEUVRE,SURNOM_MEMBRE,DATE_CRI,COTE_CRI,COMMENTAIRE_CRI) 
    values (NO_CRITIQUE_SEQ.nextval,1, 'KenKen',to_date('20-01-03','YY-MM-DD'),5,'Fuck j''aime pas les drames');

insert into TP2_CRITIQUE(NO_CRITIQUE,NO_OEUVRE,SURNOM_MEMBRE,COTE_CRI,COMMENTAIRE_CRI) 
    values (NO_CRITIQUE_SEQ.nextval,1, 'BarbieDoll',8,'j''aime');
    
insert into TP2_CRITIQUE(NO_CRITIQUE,NO_OEUVRE,SURNOM_MEMBRE,COTE_CRI,COMMENTAIRE_CRI,REPOND_A_NO_CRITIQUE) 
    values (NO_CRITIQUE_SEQ.nextval,1, 'KenKen',null,'Allo',10);

/*d)*/
delete from TP2_HORAIRE_PLATEFORME
    where add_months(DATE_HEURE_HORP, 24) < sysdate;
 /*f)*/
select TITRE_OEU, ANNEE_OEU, SYNOPSIS_OEU
    from TP2_OEUVRE
        where COMPAGNIE_OEU = 'Paramount Pictures'
            order by ANNEE_OEU desc;
/*i) i)*/            
select NOM_CHAINE
    from TP2_CHAINE
        where URL_CHA like 'http://%' and NOM_CHAINE not in(
            select NOM_PLATEFORME
                from TP2_PLATEFORME
                    where URL_PLA like 'http://%');
/*i) ii)*/                
(select NOM_CHAINE
    from TP2_CHAINE
        where URL_CHA like 'http://%')
minus
(select NOM_PLATEFORME
    from TP2_PLATEFORME
        where URL_PLA like 'http://%');
/*i) iii)*/   
select NOM_CHAINE
    from TP2_CHAINE
        where not exists(
            select NOM_PLATEFORME
                from TP2_PLATEFORME
                    where URL_CHA not like 'http://%' and URL_PLA not like 'http://%');

/*e)*/
update TP2_CRITIQUE
    set COMMENTAIRE_CRI = '#####'
    where lower(COMMENTAIRE_CRI) like '%fuck%';

/*h)*/
select NOM_CINEMA, count(CATEGORIE_BIL)as NOMBRE_CATEGORIE_BIL, count(PERIODE_JOURNEE_BIL) as NOMBRE_PERIODE_JOURNEE, 
avg(MNT_PRIX_BIL) as PRIX_MOYEN_BIL, MAX(MNT_PRIX_BIL)as PRIX_MAX_BIL, 
MAX(MNT_PRIX_BIL)- avg(MNT_PRIX_BIL)  as DIFFERENCE_MOYEN_MAX
    from TP2_BILLET_CINEMA
    group by NOM_CINEMA;
    
/*g)i)*/
select NOM_CHAINE, COMPAGNIE_CHA, URL_CHA
    from TP2_CHAINE
    where NOM_CHAINE in 
        (select NOM_CHAINE
            from TP2_HORAIRE_CHAINE
            where DATE_HEURE_HORCH > to_date('2019-11-30','YYYY-MM-DD') 
            and NO_OEUVRE in (select NO_OEUVRE
                                from TP2_OEUVRE
                                where TITRE_OEU = 'Cadavres � tous les clics'));
/*g)j)*/
select  NOM_CHAINE, COMPAGNIE_CHA, URL_CHA
    from (TP2_HORAIRE_CHAINE join TP2_CHAINE  using (NOM_CHAINE)) join TP2_OEUVRE using (NO_OEUVRE)
    where TITRE_OEU = 'Cadavres � tous les clics' and DATE_HEURE_HORCH > to_date('2019-11-30','YYYY-MM-DD');
/*g)k)*/
select NOM_CHAINE, COMPAGNIE_CHA, URL_CHA
    from TP2_CHAINE CH
    where exists (select NO_OEUVRE 
                    from TP2_HORAIRE_CHAINE HC
                    where (CH.NOM_CHAINE=HC.NOM_CHAINE and DATE_HEURE_HORCH > to_date('2019-11-30','YYYY-MM-DD' )
                    and exists (select NO_OEUVRE 
                                    from TP2_OEUVRE O
                                    where TITRE_OEU ='Cadavres � tous les clics' and HC.NO_OEUVRE = O.NO_OEUVRE)));
                                    
/*c)*/

insert into TP2_UTILISATEUR(LOGIN_UTILISATEUR, NOM_UTI, PRENOM_UTI, COURRIEL_UTI, DATE_NAISSANCE_UTI, MOT_DE_PASSE_UTI, TYPE_UTI)
    select substr(PRENOM_ACT,1,3) || substr(NOM_ACT,1,2) || floor(dbms_random.value(1,100)), NOM_ACT, PRENOM_ACT, COURRIEL_ACT,
    DATE_NAISSANCE_ACT, '123', 'Acteur'
        from TP2_ACTEUR;

create or replace view TP2_VUE_CRITIQUE (SURNOM_MEM,DATE_NAISSANCE_MEM, NO_CRITIQUE,NO_CRITIQUE_REPONDUE,CHEMIN,NIVEAU) as
    select substr(lpad(' ', LEVEL*2 , ' ') || SURNOM_MEMBRE,1,30) as ARBRE,
            DATE_NAISSANCE_UTI, NO_CRITIQUE, REPOND_A_NO_CRITIQUE,
            sys_connect_by_path(SURNOM_MEMBRE, '/') as CHEMIN,
            level as NIVEAU
        from TP2_UTILISATEUR U join TP2_CRITIQUE C on U.LOGIN_UTILISATEUR = C.SURNOM_MEMBRE
        connect by prior NO_CRITIQUE = REPOND_A_NO_CRITIQUE
        start with REPOND_A_NO_CRITIQUE is null;
col ARBRE format a40
col CHEMIN format a40  
    
select *
    from TP2_VUE_CRITIQUE;
    
/* 2) a) */
    
create or replace trigger TRG_AIU_DATE_HORC_FILM
    after insert or update of DATE_DEBUT_HORC, DATE_FIN_HORC on TP2_HORAIRE_CINEMA

declare
    V_NB_ERREUR number;
    
begin
    select count(A.NO_OEUVRE) into V_NB_ERREUR
        from TP2_HORAIRE_CINEMA A, TP2_HORAIRE_CINEMA B
            where (A.NOM_CINEMA = B.NOM_CINEMA and A.NO_OEUVRE = B.NO_OEUVRE and (A.DATE_DEBUT_HORC <> B.DATE_DEBUT_HORC or A.DATE_FIN_HORC <> B.DATE_FIN_HORC) and
            (A.DATE_DEBUT_HORC between B.DATE_DEBUT_HORC and B.DATE_FIN_HORC or A.DATE_FIN_HORC between B.DATE_DEBUT_HORC and B.DATE_FIN_HORC));
            
    if V_NB_ERREUR > 0 then
        raise_application_error(-20056, 'Il ne peut pas y avoir de chevauchement d' || '''horaire pour un m�me film au m�me cin�ma');
    end if;

end TRG_AIU_DATE_HORC_FILM;
/


/* Requetes de validation pour la 2) a)
insert into TP2_HORAIRE_CINEMA(NOM_CINEMA, NO_OEUVRE, DATE_DEBUT_HORC, HEURE_HORC, DATE_FIN_HORC)
    values('Cineplex Odeon Beauport', 1, to_date('2020-04-18', 'YYYY-MM-DD'), to_date('11:30', 'HH24:MI'), to_date('2020-06-02', 'YYYY-MM-DD')); 
    
update TP2_HORAIRE_CINEMA
    set DATE_DEBUT_HORC = to_date('2020-02-17', 'YYYY-MM-DD')
        where DATE_DEBUT_HORC = '2020-04-18';
        
insert into TP2_HORAIRE_CINEMA(NOM_CINEMA, NO_OEUVRE, DATE_DEBUT_HORC, HEURE_HORC, DATE_FIN_HORC)
    values('Cineplex Odeon Beauport', 1, to_date('2020-02-19', 'YYYY-MM-DD'), to_date('11:30', 'HH24:MI'), to_date('2020-03-14', 'YYYY-MM-DD'));*/

create or replace function FCT_COTE_MOYENNE_FILM_REA (P_I_TITRE_FIL varchar2,P_I_NO_REALISATEUR number) return number
is
    V_COTE_MOYENNE number (3,1);
begin
    select avg(COTE_CRI) 
        into V_COTE_MOYENNE
        from (TP2_OEUVRE natural join TP2_REALISATEUR_OEUVRE) natural join TP2_CRITIQUE
        where NO_REALISATEUR = P_I_NO_REALISATEUR and TITRE_OEU = P_I_TITRE_FIL;
    return V_COTE_MOYENNE;
end FCT_COTE_MOYENNE_FILM_REA;
/

select FCT_COTE_MOYENNE_FILM_REA('Titanic',1) from DUAL;

create or replace procedure SP_PURGER_HORAIRE(P_I_DATE date) 
is
begin
    delete from TP2_HORAIRE_CHAINE
        where DATE_HEURE_HORCH < P_I_DATE;
    delete from TP2_HORAIRE_CINEMA
        where DATE_DEBUT_HORC < P_I_DATE;
    delete from TP2_HORAIRE_PLATEFORME
        where DATE_HEURE_HORP < P_I_DATE;
end SP_PURGER_HORAIRE;
/

create or replace function FCT_GENERER_MOT_DE_PASSE (P_I_TAILLE_MDP number) return varchar2
is
    V_TAILLE_MDP number(4):= P_I_TAILLE_MDP;
    V_POSSIBILITES constant char(62) := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    V_MOT_DE_PASSE varchar2(12) := '';
    V_CHARACTER_COURANT char(1); 
begin
    if P_I_TAILLE_MDP < 8 
        then V_TAILLE_MDP := 8;
    elsif P_I_TAILLE_MDP > 12 
        then V_TAILLE_MDP := 12;
    end if;
    for iteration in 1 .. V_TAILLE_MDP
        loop
            V_CHARACTER_COURANT := substr(V_POSSIBILITES,dbms_random.value(1,62),1);
            V_MOT_DE_PASSE := concat (V_MOT_DE_PASSE,V_CHARACTER_COURANT);
        end loop;
    return V_MOT_DE_PASSE;
end FCT_GENERER_MOT_DE_PASSE;
/
select FCT_GENERER_MOT_DE_PASSE (4) from dual;

/* 2) e) Cette fonction permet de trouver la moyenne des c�tes des films par genre et ann�e d'oeuvre. Cela permettrait � Quebingeton d'am�liorer son chiffre d'affaire
car il pourrait facilement �valuer la tendance de quelles sont les genres qui font fureurs et lesquels ne plaisent pas � ses spectateurs. De ce fait, Quebingeton
pourrait mettre davantage d'emphase sur l'acquisition des genres les plus populaires.*/
create or replace function FCT_COTE_MOYENNE_FILM_GENRE (P_I_GENRE_OEU varchar2, P_I_ANNEE_OEU number) return number
is
    V_COTE_MOYENNE number (3,1);
begin
    select avg(COTE_CRI) into V_COTE_MOYENNE
        from (TP2_OEUVRE natural join TP2_REALISATEUR_OEUVRE) natural join TP2_CRITIQUE
            where GENRE_OEU = P_I_GENRE_OEU and ANNEE_OEU = P_I_ANNEE_OEU;
    return V_COTE_MOYENNE;
end FCT_COTE_MOYENNE_FILM_GENRE;
/
select FCT_COTE_MOYENNE_FILM_GENRE('romance', '1997') from DUAL;
    
