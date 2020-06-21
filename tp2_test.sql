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
drop sequence NO_CRITIQUE_SEQ ; 

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
    VILLE_CIN varchar(40) not null,
    MNT_PRIX_BIL number(4,2) default 12.99 not null,
    constraint PK_BILLET_CINEMA primary key (NOM_CINEMA, CATEGORIE_BIL, PERIODE_JOURNEE_BIL));
    

create table TP2_OEUVRE (
    NO_OEUVRE number(6,0) generated by default as identity(start with 1 increment by 1) not null,
    TITRE_OEU varchar2(30) not null,
    ANNEE_OEU number(4,0) not null,
    GENRE_OEU varchar2(30) not null,
    SYNOPSYS_OEU varchar2(500) not null,
    DUREE_OEU number(3,0) not null,
    CLASSEMENT_OEU number(2,1) null,
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
    MOT_DE_PASSE_UTI varchar2(15) not null, /*A verifier*/
    TYPE_UTI varchar2(30) default 'Utilisateur' not null,
    constraint PK_UTILISATEUR primary key (LOGIN_UTILISATEUR),
    constraint AK_COURRIEL_UTI unique (COURRIEL_UTI)
);

create table TP2_CRITIQUE(
    NO_CRITIQUE number(6,0) not null,
    NO_OEUVRE number(6,0) not null,
    SURNOM_MEMBRE varchar2(10) not null, /*verifier comme login*/ 
    DATE_CRI date default sysdate not null,
    COTE_CRI number(2,1) not null, 
    COMMENTAIRE_CRI VARCHAR2(500) null,
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


create or replace view TP2_VUE_MEMBRE (SURNOM_MEMBRE, NOM_MEM, PRENOM_MEM, COURRIEL_MEM, DATE_NAISSANCE_MEM, MOT_DE_PASSE_MEM) as
    select LOGIN_UTILISATEUR, NOM_UTI, PRENOM_UTI, COURRIEL_UTI, DATE_NAISSANCE_UTI, MOT_DE_PASSE_UTI
        from TP2_UTILISATEUR
            where TYPE_UTI = 'Membre';
            
create or replace view TP2_VUE_EMPLOYE (LOGIN_EMPLOYE, PRENOM_EMP, NOM_EMP, COURRIEL_EMP, MOT_DE_PASSE_EMP) as
    select LOGIN_UTILISATEUR, PRENOM_UTI, NOM_UTI, COURRIEL_UTI, MOT_DE_PASSE_UTI
        from TP2_UTILISATEUR
            where TYPE_UTI = 'Employ�';

alter table TP2_CRITIQUE 
    add constraint FK_CRI_SURNOM_MEM foreign key (SURNOM_MEMBRE) references TP2_VUE_MEMBRE(SURNOM_MEMBRE);
    
create sequence NO_CRITIQUE_SEQ
    start with 5 
    increment by 5 ;

insert into TP2_OEUVRE( TITRE_OEU, ANNEE_OEU, GENRE_OEU, SYNOPSYS_OEU, DUREE_OEU, CLASSEMENT_OEU, COMPAGNIE_OEU) 
    values ('Titanic',1997,'Romance',
        'Southampton, 10 avril 1912. Le paquebot le plus grand et le plus moderne du monde, r�put� pour son insubmersibilit�, 
        le "Titanic", appareille pour son premier voyage. Quatre jours plus tard, il heurte un iceberg. 
        A son bord, un artiste pauvre et une grande bourgeoise tombent amoureux.',188,7.8,'Paramount Pictures');

insert into TP2_OEUVRE( TITRE_OEU, ANNEE_OEU, GENRE_OEU, SYNOPSYS_OEU, DUREE_OEU, CLASSEMENT_OEU, COMPAGNIE_OEU) 
    values ('Joker',2019,'drame',
        'Le film, qui relate une histoire originale in�dite sur grand �cran, se focalise sur la figure embl�matique de 
        l''ennemi jur� de Batman. Il brosse le portrait d''Arthur Fleck, un homme sans concession m�pris� par la soci�t�. ',
        122,8.5,'DC FIlms');

insert into TP2_REALISATEUR (NOM_REA, PRENOM_REA)
    values ('Cameron','James');
    
insert into TP2_REALISATEUR (NOM_REA, PRENOM_REA)
    values ('Phillips','Todd');
    
insert into TP2_REALISATEUR_OEUVRE 
    VALUES(1,1);
    
insert into TP2_REALISATEUR_OEUVRE 
    VALUES(2,2);

insert into TP2_ACTEUR (NOM_ACT, PRENOM_ACT,DATE_NAISSANCE_ACT)
    values ('DiCaprio','Leonardo',to_date('74-11-11','YY-MM-DD'));

