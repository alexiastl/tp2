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
    