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

create table TP2_OEUVRE (
    NO_OEUVRE number(6,0) not null,
    TITRE_OEU varchar2(30) not null,
    ANNEE_OEU number(4,0) not null,
    GENRE_OEU varchar2(30) not null,
    SYNOPSYS_OEU varchar2(500) not null,
    DUREE_OEU number(3,0) not null,
    CLASSEMENT_OEU number(2,1) null,
    COMPAGNIE_OEU number(2,1) not null,
    constraint PK_OEUVRE primary key (NO_OEUVRE)
);

create table TP2_REALISATEUR_OEUVRE (
    NO_OEUVRE number(6,0) not null,
    NO_REALISATEUR number(6,0) not null, 
    constraint PK_RO_OEU_REA primary key( NO_OEUVRE, NO_REALISATEUR)/*,
    constraint FK_RO_NO_OEUVRE foreign key(NO_OEUVRE) references TP2_OEUVRE (NO_OEUVRE),
    constraint FK_RO_NO_REA foreign key (NO_REALISATEUR) references REALISATEUR (NO_REALISATEUR)*/
);

create table TP2_REALISATEUR (
    NO_REALISATEUR number(6,0) not null,
    PRENOM_REA varchar2(30) not null,
    NOM_REA varchar2(30) not null,
    constraint PK_REALISATEUR primary key (NO_REALISATEUR)
);

create table TP2_ROLE_OEUVRE (
    NO_OEUVRE number(6,0) not null,
    PERSONNAGE varchar2(50) not null,
    NO_ACTEUR number(6,0) not null,
    constraint PK_ROLE_OEUVRE primary key (NO_OEUVRE, PERSONNAGE)/*,
    constraint FK_RO_NO_OEUVRE foreign key (NO_OEUVRE) references OEUVRE (NO_OEUVRE),
    constraint FK_RO_NO_ACTEUR foreign key (NO_ACTEUR) references ACTEUR (NO_ACTEUR)
*/
);

create table TP2_ACTEUR (
    NO_ACTEUR number(6,0) not null,
    NOM_ACT varchar2(30) not null,
    PRENOM_ACT varchar2(30) not null,
    DATE_NAISSANCE_ACT date not null,
    constraint PK_ACTEUR primary key (NO_ACTEUR) 
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
):

create table TP2_CRITIQUE(
    NO_CRITIQUE number(6,0) not null,
    NO_OEUVRE number(6,0) not null,
    SURNOM_MEMBRE varchar2(10) not null, /*verifier comme login*/ 
    DATE_CRI date default sysdate not null,
    COTE_CRI number(2,1) not null, 
    COMMENTAIRE_CRI VARCHAR2(500) null,
    REPOND_A_NO_CRITIQUE NUMBER(6,0) null,/*
    constraint PK_CRITIQUE primary key(NO_CRITIQUE),
    constraint FK_CRI_NO_OEUVRE foreign key (NO_OEUVRE) references OEUVRE(NO_OEUVRE),
    constraint FK_CRI_SURNOM_MEM foreign key (SURNOM_MEMBRE) references MEMBRE (SURNOM_MEMBRE),
    constraint FK_CRI_REPOND_A foreign key (REPOND_A_NO_CRITIQUE) references CRITIQUE(NO_CRITIQUE),*/
    constraint AK_CRITIQUE unique (NO_OEUVRE, SURNOM_MEMBRE, DATE_CRI)
);