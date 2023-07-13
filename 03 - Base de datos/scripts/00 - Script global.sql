

/* Inicio sección drop table */
drop table param cascade;

drop table config_taller cascade;

drop table agrupador cascade;

drop table det_regis_taller cascade;

drop table regis_taller cascade;

drop table prog_taller cascade;

drop table prog_asign cascade;

drop table producto cascade;

drop table unidad_medida cascade;

drop table categ_producto cascade;

drop table usuario cascade;

drop table config_perfil;

drop table item_menu;

drop table perfil cascade;

drop table periodo_academ cascade;

drop table taller cascade;

drop table asign cascade;

drop table carrera cascade;

/* Fin sección drop table */

/* Inicio sección create table */
create table param (
    cod_param            tinyint not null comment "Código del parámetro del sistema",
    nom_param            varchar(50) not null comment "Nombre del parámetro del sistema",
    valor                varchar(50) comment "Valor del parámetro",
    primary key (cod_param)
) comment "Tabla que almacena los parámetros del sistema";

create table item_menu (
    cod_item_menu        varchar(4) not null comment "Código del ítem de menú",
    nom_item_menu        varchar(50) not null comment "Nombre del ítem de menú",
    descripcion          varchar(500) comment "Descripción del ítem de menú",
    url                  varchar(100) comment "URL del recurso que resuelve el ítem de menú en la aplicación",
    cod_item_menu_padre  varchar(4) comment "Código del ítem de menú padre",
    primary key (cod_item_menu)
) comment "Tabla que almacena las opciones de menú del sistema";

create table config_perfil (
    cod_perfil     tinyint not null comment "el código del perfil al que se le asocia el ítem de menú",
    cod_item_menu  varchar(4) not null comment "el código del ítem de menú asociado al perfil",
    primary key (cod_perfil, cod_item_menu)
) comment "tabla que almacena la configuración de un perfil de acuerdo a las opciones de menú disponibles";

create table agrupador (
    cod_agrupador  tinyint not null comment "Código del agrupador de productos",
    nom_agrupador  varchar(100) not null comment "Nombre del agrupador de productos",
    primary key (cod_agrupador)
) comment "Tabla que contiene los agrupadores de productos en la especificación de un taller";

create table asign (
    sigla            varchar(15) not null comment "Sigla de la asignatura",
    nom_asign        varchar(50) not null comment "Nombre de la asignatura",
    nom_asign_abrev  varchar(30) not null comment "Nombre de la asignatura abreviado",
    cod_carrera      tinyint not null comment "Código de la carrera de la asignatura",
    primary key (sigla)
) comment "Tabla con las asignaturas asociadas que requieren talleres";

create table carrera (
    cod_carrera        tinyint not null comment "Código de la carrera",
    nom_carrera        varchar(30) not null comment "Nombre de la carrera",
    nom_carrera_abrev  varchar(10) comment "Nombre abreviado de la carrera",
    primary key (cod_carrera)
) comment "Tabla con las carreras a ser administradas";

create table categ_producto (
    cod_categ_producto  tinyint not null comment "Código de la categoría del producto",
    nom_categ_producto  varchar(30) not null comment "Nombre de la categoría del producto",
    primary key (cod_categ_producto)
) comment "Tabla con las categorías de productos";

create table config_taller (
    id_producto    int not null comment "Identificador único abstracto del producto asociado al taller",
    id_taller      int not null comment "Identificador del taller para el cual se asocia el producto",
    cod_agrupador  tinyint comment "Código del agrupador de productos para el taller (almuerzo personal por ejemplo)",
    cantidad       dec(12,6) comment "Cantidad del producto requerido para el taller",
    primary key (id_producto, id_taller, cod_agrupador)
) comment "Tabla que asocia productos con un taller específico";

create table det_regis_taller (
    fecha               date not null comment "La fecha de ejecución del taller",
    ano_academ          smallint not null comment "El año académico del registro de ejecución del taller",
    cod_periodo_academ  tinyint not null comment "El período académico del registro de ejecución del taller",
    sigla               varchar(15) not null comment "La sigla de la asignatura que se está programando",
    seccion             tinyint not null comment "La sección programada para el taller",
    id_taller           int not null comment "El identificador único del taller",
    id_producto         int not null comment "Identificador único abstracto del producto indicado en el detalle del registro del taller",
    precio              int not null comment "El precio del producto registrado a la fecha de ejecución del taller",
    cantidad            dec(12,6) not null comment "Cantidad de unidades del producto registrado a la fecha de ejecución del taller",
    primary key (fecha, ano_academ, cod_periodo_academ, sigla, seccion, id_taller, id_producto)
) comment "Detalle del registro de productos asignados a la ejecución de un taller específico";

create table perfil (
    cod_perfil   tinyint not null comment "El código del perfil a asignar a usuarios",
    nom_perfil   varchar(30) not null comment "El nombre del perfil a asignar a usuarios",
    descripcion  varchar(500) not null comment "La descripción del perfil a asignar a usuarios",
    primary key (cod_perfil)
) comment "Tabla que contiene los perfiles a asignar a los usuarios del sistema";

create table periodo_academ (
    cod_periodo_academ        tinyint not null comment "El código del período académico",
    nom_periodo_academ        varchar(30) not null comment "El nombre del período académico",
    nom_periodo_academ_abrev  varchar(12) not null comment "El nombre abreviado del período académico",
    primary key (cod_periodo_academ)
) comment "Tabla que contiene los períodos académicos de progremación de talleres";

create table producto (
    id_producto         int not null auto_increment comment "El identificador único del producto",
    nom_producto        varchar(100) not null comment "El nombre del producto",
    precio              int not null comment "El precio por la unidad de medida del producto",
    cod_unidad_medida   tinyint not null comment "La unidad de medida del producto",
    cod_categ_producto  tinyint not null comment "La categoría del producto",
    primary key (id_producto)
) comment "Tabla que contiene los productos usados en los talleres";

create table prog_asign (
    ano_academ          smallint not null comment "El año académico de programación de la asignatura",
    cod_periodo_academ  tinyint not null comment "El período académico de programación de la asignatura",
    sigla               varchar(15) not null comment "la sigla de la asignatura",
    seccion             tinyint not null comment "La sección para la cual se está programando la asignatura",
    primary key (ano_academ, cod_periodo_academ, sigla, seccion)
) comment "Tabla que contiene la programación de las secciones para las distintas asignaturas a dictar en un período académico";

create table prog_taller (
    fecha               date not null comment "La fecha de programación del taller",
    ano_academ          smallint not null comment "El año académico de la programación del taller",
    cod_periodo_academ  tinyint not null comment "El período académico de la programación del taller",
    sigla               varchar(15) not null comment "La sigla de la asignatura que se está programando",
    seccion             tinyint not null comment "La sección programada para el taller",
    id_taller           int not null comment "El identificador del taller",
    id_usuario          tinyint not null comment "El profesor asignado al taller",
    primary key (fecha, ano_academ, cod_periodo_academ, sigla, seccion, id_taller)
) comment "Tabla que contiene la programación de los talleres";

create table regis_taller (
    fecha               date not null comment "La fecha de ejecución del taller",
    ano_academ          smallint not null comment "El año académico del registro de ejecución del taller",
    cod_periodo_academ  tinyint not null comment "El período académico del registro de ejecución del taller",
    sigla               varchar(15) not null comment "La sigla de la asignatura que se está programando",
    seccion             tinyint not null comment "La sección programada para el taller",
    id_taller           int not null comment "El identificador único del taller",
    id_usuario          tinyint not null comment "El profesor que dictó el taller",
    obs                 varchar(500) not null comment "Eventuales comentarios a la ejecución del taller" default 'Sin comentarios',
    primary key (fecha, ano_academ, cod_periodo_academ, sigla, seccion, id_taller)
) comment "Tabla que contiene los registros de ejecución de los talleres";

create table taller (
    id_taller            int not null auto_increment comment "El identificador del taller",
    titulo_preparacion   varchar(100) comment "El título de la preparación del taller",
    detalle_preparacion  varchar(2000) comment "El detalle de la preparación del taller",
    semana               tinyint not null comment "Un número que indica la semana del taller. Sirve para ordenarlo también.",
    sigla                varchar(15) not null comment "La sigla de la asignatura",
    primary key (id_taller)
) comment "Tabla que contiene los distintos talleres a ser dictados";

create table unidad_medida (
    cod_unidad_medida           tinyint not null comment "El código de la unidad de medida",
    nom_unidad_medida           varchar(20) not null comment "El nombre de la unidad de medida",
    nom_unidad_medida_abrev     varchar(12) not null comment "El nombre abreviado de la unidad de medida",
    cod_unidad_medida_base      tinyint comment "El código de la unidad de medida base para esta unidad de medida",
    factor                      decimal(6,2) comment "El factor de transformación hacia la unidad base, ór ejemplo de gr. a Kg. es 1000",
    primary key (cod_unidad_medida)
) comment "Tabla que contiene las unidades de medida";

create table usuario (
    id_usuario        tinyint not null auto_increment comment "El identificador único abstracto del usuario",
    login             varchar(40) not null comment "El login del usuario",
    hash_password     varchar(256) not null comment "La contraseña encriptada del del usuario",
    primer_apellido   varchar(20) not null comment "El primer apellido del usuario",
    segundo_apellido  varchar(20) comment "El segundo apellido del usuario",
    nom               varchar(20) not null comment "El nombre del usuario",
    nom_preferido     varchar(20) comment "El nombre por el cual el usuario prefiere ser nombrado",
    cod_perfil        tinyint not null comment "El código del perfil del usuario",
    cod_carrera       tinyint comment "La carrera del usuario si es que es un docente",
    primary key (id_usuario)
) comment "Tabla que contiene los usuarios del sistema";
/* Fin sección create table */

/* Inicio sección foreign keys */
alter table unidad_medida
    add constraint unidadmedida_unidadmedida_fk foreign key (cod_unidad_medida_base)
        references unidad_medida (cod_unidad_medida);

alter table asign
    add constraint asign_carrera_fk foreign key (cod_carrera)
        references carrera (cod_carrera);

alter table config_taller
    add constraint configtaller_agrupador_fk foreign key (cod_agrupador)
        references agrupador (cod_agrupador);

alter table config_taller
    add constraint configtaller_producto_fk foreign key (id_producto)
        references producto (id_producto);

alter table config_taller
    add constraint configtaller_taller_fk foreign key (id_taller)
        references taller (id_taller);

alter table det_regis_taller
    add constraint detregistaller_producto_fk foreign key (id_producto)
        references producto (id_producto);

alter table det_regis_taller
    add constraint detregistaller_registaller_fk foreign key (fecha, ano_academ, cod_periodo_academ, sigla, seccion, id_taller)
        references regis_taller (fecha, ano_academ, cod_periodo_academ, sigla, seccion, id_taller);

alter table producto
    add constraint producto_categproducto_fk foreign key (cod_categ_producto)
        references categ_producto (cod_categ_producto);

alter table producto
    add constraint producto_unidadmedida_fk foreign key (cod_unidad_medida)
        references unidad_medida (cod_unidad_medida);

alter table prog_asign
    add constraint progasign_asign_fk foreign key (sigla)
        references asign (sigla);

alter table prog_asign
    add constraint progasign_periodo_academ_fk foreign key (cod_periodo_academ)
        references periodo_academ (cod_periodo_academ);

alter table prog_taller
    add constraint progtaller_progasign_fk foreign key (ano_academ, cod_periodo_academ, sigla, seccion)
        references prog_asign (ano_academ, cod_periodo_academ, sigla, seccion);

alter table prog_taller
    add constraint progtaller_usuario_fk foreign key (id_usuario)
        references usuario (id_usuario);

alter table prog_taller
    add constraint progtaller_taller_fk foreign key (id_taller)
        references taller (id_taller);

alter table regis_taller
    add constraint registaller_progtaller_fk foreign key (fecha, ano_academ, cod_periodo_academ, sigla, seccion, id_taller)
        references prog_taller (fecha, ano_academ, cod_periodo_academ, sigla, seccion, id_taller);

alter table regis_taller
    add constraint registaller_usuario_fk foreign key (id_usuario)
        references usuario (id_usuario);

alter table taller
    add constraint taller_asign_fk foreign key (sigla)
        references asign (sigla);

alter table usuario
    add constraint usuario_carrera_fk foreign key (cod_carrera)
        references carrera (cod_carrera);

alter table usuario
    add constraint usuario_perfil_fk foreign key (cod_perfil)
        references perfil (cod_perfil);

alter table item_menu
    add constraint item_menu_item_menu_fk foreign key (cod_item_menu_padre)
        references item_menu (cod_item_menu);

alter table config_perfil
    add constraint config_perfil_item_menu_fk foreign key (cod_item_menu)
        references item_menu (cod_item_menu);

alter table config_perfil
    add constraint config_perfil_perfil_fk foreign key (cod_perfil)
        references perfil (cod_perfil);
/* Fin sección foreign keys */


/* Inicio tabla: param */
insert into param (
	cod_param,
	nom_param,
	valor)
values (
	1,
	'Año académico vigente',
	'2023');
/* Fin tabla: param */

/* Inicio tabla: agrupador */
insert into agrupador (
	cod_agrupador,
	nom_agrupador)
values (
	1,
	'Taller');

insert into agrupador (
	cod_agrupador,
	nom_agrupador)
values (
	2,
	'Almuerzo personal de servicio');
/* Fin tabla: agrupador */

/* Inicio tabla: carrera */
insert into carrera (
	cod_carrera,
	nom_carrera,
	nom_carrera_abrev)
values (
	1,
	'Gastronomía',
	'GASTRO');

insert into carrera (
	cod_carrera,
	nom_carrera,
	nom_carrera_abrev)
values (
	2,
	'Administración Hotelera',
	'HOTEL');
/* Fin tabla: carrera */

/* Inicio tabla: categ_producto */
insert into categ_producto (
	cod_categ_producto,
	nom_categ_producto)
values (
	0,
	'(Sin categoría)');

insert into categ_producto (
	cod_categ_producto,
	nom_categ_producto)
values (
	1,
	'Frutas y verduras');

insert into categ_producto (
	cod_categ_producto,
	nom_categ_producto)
values (
	2,
	'Carnes, cecinas y embutidos');

insert into categ_producto (
	cod_categ_producto,
	nom_categ_producto)
values (
	3,
	'Mariscos y pescados');

insert into categ_producto (
	cod_categ_producto,
	nom_categ_producto)
values (
	4,
	'Congelados');

insert into categ_producto (
	cod_categ_producto,
	nom_categ_producto)
values (
	5,
	'Ovo lácteos');

insert into categ_producto (
	cod_categ_producto,
	nom_categ_producto)
values (
	6,
	'Abarrotes');

insert into categ_producto (
	cod_categ_producto,
	nom_categ_producto)
values (
	7,
	'Vinos, licores y bebidas');

insert into categ_producto (
	cod_categ_producto,
	nom_categ_producto)
values (
	8,
	'No alimenticios');

insert into categ_producto (
	cod_categ_producto,
	nom_categ_producto)
values (
	9,
	'Artículos de aseo');

insert into categ_producto (
	cod_categ_producto,
	nom_categ_producto)
values (
	10,
	'Equipos y otros');
/* Fin tabla: categ_producto */

/* Inicio tabla: unidad_medida */
insert into unidad_medida (
	cod_unidad_medida,
	nom_unidad_medida,
	nom_unidad_medida_abrev,
	cod_unidad_medida_base,
	factor)
values (
	1,
	'kilogramos',
	'Kg.',
	null,
	null);

insert into unidad_medida (
	cod_unidad_medida,
	nom_unidad_medida,
	nom_unidad_medida_abrev,
	cod_unidad_medida_base,
	factor)
values (
	2,
	'gramos',
	'gr.',
	2,
	1000);

insert into unidad_medida (
	cod_unidad_medida,
	nom_unidad_medida,
	nom_unidad_medida_abrev,
	cod_unidad_medida_base,
	factor)
values (
	3,
	'litros',
	'lt.',
	null,
	null);

insert into unidad_medida (
	cod_unidad_medida,
	nom_unidad_medida,
	nom_unidad_medida_abrev,
	cod_unidad_medida_base,
	factor)
values (
	4,
	'mililitros',
	'ml.',
	3,
	1000);

insert into unidad_medida (
	cod_unidad_medida,
	nom_unidad_medida,
	nom_unidad_medida_abrev,
	cod_unidad_medida_base,
	factor)
values (
	5,
	'unidades',
	'unid',
	null,
	null);

insert into unidad_medida (
	cod_unidad_medida,
	nom_unidad_medida,
	nom_unidad_medida_abrev,
	cod_unidad_medida_base,
	factor)
values (
	6,
	'metros',
	'mt.',
	null,
	null);
/* Fin tabla: unidad_medida */

/* Inicio tabla: asign */
insert into asign (
	sigla,
	nom_asign,
	nom_asign_abrev,
	cod_carrera)
values (
	'ABT3111',
	'Salón básico hotelería',
	'Básico',
	2);

insert into asign (
	sigla,
	nom_asign,
	nom_asign_abrev,
	cod_carrera)
values (
	'ABT3121',
	'Taller de bar',
	'Bar',
	2);

insert into asign (
	sigla,
	nom_asign,
	nom_asign_abrev,
	cod_carrera)
values (
	'ABT3142',
	'Taller de gastronomía de hotelería',
	'Gastronomía de hotelería',
	2);

insert into asign (
	sigla,
	nom_asign,
	nom_asign_abrev,
	cod_carrera)
values (
	'RHT2121',
	'Taller de pisos',
	'Pisos',
	2);

insert into asign (
	sigla,
	nom_asign,
	nom_asign_abrev,
	cod_carrera)
values (
	'TCC3301',
	'Taller de gastronomía optativo',
	'Gastronomía optativo',
	2);

insert into asign (
	sigla,
	nom_asign,
	nom_asign_abrev,
	cod_carrera)
values (
	'ABT2131',
	'Cata de vinos',
	'Cata',
	1);

insert into asign (
	sigla,
	nom_asign,
	nom_asign_abrev,
	cod_carrera)
values (
	'ABT3131',
	'Bar y coctelería',
	'Bar',
	1);

insert into asign (
	sigla,
	nom_asign,
	nom_asign_abrev,
	cod_carrera)
values (
	'ABT3141',
	'Salón comedor básico',
	'Comedor básico',
	1);

insert into asign (
	sigla,
	nom_asign,
	nom_asign_abrev,
	cod_carrera)
values (
	'ABT4151',
	'Salón comedor avanzado',
	'Comedor avanzado',
	1);

insert into asign (
	sigla,
	nom_asign,
	nom_asign_abrev,
	cod_carrera)
values (
	'CIT1111',
	'Taller de cocina básica',
	'Cocina básica',
	1);

insert into asign (
	sigla,
	nom_asign,
	nom_asign_abrev,
	cod_carrera)
values (
	'CIT2111',
	'Taller de cocina institucional',
	'Cocina institucional',
	1);

insert into asign (
	sigla,
	nom_asign,
	nom_asign_abrev,
	cod_carrera)
values (
	'CRT3111',
	'Taller de cocina internacional',
	'Cocina internacional',
	1);

insert into asign (
	sigla,
	nom_asign,
	nom_asign_abrev,
	cod_carrera)
values (
	'CRT4111',
	'Taller de cocina chilena',
	'Cocina chilena',
	1);

insert into asign (
	sigla,
	nom_asign,
	nom_asign_abrev,
	cod_carrera)
values (
	'PRT1131',
	'Taller de panadería',
	'Panadería',
	1);

insert into asign (
	sigla,
	nom_asign,
	nom_asign_abrev,
	cod_carrera)
values (
	'PRT2121',
	'Taller de pastelería',
	'Pastelería',
	1);

insert into asign (
	sigla,
	nom_asign,
	nom_asign_abrev,
	cod_carrera)
values (
	'PTT6697',
	'Portafolio de título',
	'Portafolio',
	1);
/* Fin tabla: asign */

/* Inicio tabla: item_menu */
insert into item_menu (
	cod_item_menu,
	nom_item_menu,
	descripcion,
	url,
	cod_item_menu_padre)
values (
	'01',
	'Administración',
	'Administración de distintas configuraciones del sistema',
	'',
	null);

insert into item_menu (
	cod_item_menu,
	nom_item_menu,
	descripcion,
	url,
	cod_item_menu_padre)
values (
	'0101',
	'Usuarios',
	'Administración de usuarios',
	'usuarios/',
	'01');

insert into item_menu (
	cod_item_menu,
	nom_item_menu,
	descripcion,
	url,
	cod_item_menu_padre)
values (
	'0102',
	'-',
	'Separador',
	'',
	'01');

insert into item_menu (
	cod_item_menu,
	nom_item_menu,
	descripcion,
	url,
	cod_item_menu_padre)
values (
	'0103',
	'Talleres',
	'Administración de talleres',
	'asignaturas/lista/',
	'01');

insert into item_menu (
	cod_item_menu,
	nom_item_menu,
	descripcion,
	url,
	cod_item_menu_padre)
values (
	'0104',
	'Programación',
	'Administración de programación',
	'programacion/lista/',
	'01');

insert into item_menu (
	cod_item_menu,
	nom_item_menu,
	descripcion,
	url,
	cod_item_menu_padre)
values (
	'0105',
	'-',
	'Separador',
	'',
	'01');

insert into item_menu (
	cod_item_menu,
	nom_item_menu,
	descripcion,
	url,
	cod_item_menu_padre)
values (
	'0106',
	'Productos',
	'Administración de programación',
	'/productos/lista/',
	'01');

insert into item_menu (
	cod_item_menu,
	nom_item_menu,
	descripcion,
	url,
	cod_item_menu_padre)
values (
	'0107',
	'-',
	'Separador',
	'',
	'01');

insert into item_menu (
	cod_item_menu,
	nom_item_menu,
	descripcion,
	url,
	cod_item_menu_padre)
values (
	'0108',
	'Registro',
	'Registro de ejecución de talleres',
	'registro/lista',
	'01');

insert into item_menu (
	cod_item_menu,
	nom_item_menu,
	descripcion,
	url,
	cod_item_menu_padre)
values (
	'02',
	'Consultas',
	'Consultas del sistema',
	null,
	null);

insert into item_menu (
	cod_item_menu,
	nom_item_menu,
	descripcion,
	url,
	cod_item_menu_padre)
values (
	'0201',
	'Consulta 01',
	'Consulta 01',
	'consultas/1/',
	'02');

insert into item_menu (
	cod_item_menu,
	nom_item_menu,
	descripcion,
	url,
	cod_item_menu_padre)
values (
	'0202',
	'Consulta 02',
	'Consulta 02',
	'consultas/2/',
	'02');

insert into item_menu (
	cod_item_menu,
	nom_item_menu,
	descripcion,
	url,
	cod_item_menu_padre)
values (
	'0203',
	'Consulta 03',
	'Consulta 03',
	'consultas/3/',
	'02');

insert into item_menu (
	cod_item_menu,
	nom_item_menu,
	descripcion,
	url,
	cod_item_menu_padre)
values (
	'0204',
	'Consulta 04',
	'Consulta 04',
	'consultas/4/',
	'02');

insert into item_menu (
	cod_item_menu,
	nom_item_menu,
	descripcion,
	url,
	cod_item_menu_padre)
values (
	'0205',
	'Consulta 05',
	'Consulta 05',
	'consultas/5/',
	'02');

insert into item_menu (
	cod_item_menu,
	nom_item_menu,
	descripcion,
	url,
	cod_item_menu_padre)
values (
	'03',
	'Reportes',
	'Reportes del sistema',
	null,
	null);

insert into item_menu (
	cod_item_menu,
	nom_item_menu,
	descripcion,
	url,
	cod_item_menu_padre)
values (
	'0301',
	'Reporte 01',
	'Reporte 01',
	'reportes/1/',
	'03');

insert into item_menu (
	cod_item_menu,
	nom_item_menu,
	descripcion,
	url,
	cod_item_menu_padre)
values (
	'0302',
	'Reporte 02',
	'Reporte 02',
	'reportes/2/',
	'03');

insert into item_menu (
	cod_item_menu,
	nom_item_menu,
	descripcion,
	url,
	cod_item_menu_padre)
values (
	'0303',
	'Reporte 03',
	'Reporte 03',
	'reportes/3/',
	'03');

insert into item_menu (
	cod_item_menu,
	nom_item_menu,
	descripcion,
	url,
	cod_item_menu_padre)
values (
	'0304',
	'Reporte 04',
	'Reporte 04',
	'reportes/4/',
	'03');

insert into item_menu (
	cod_item_menu,
	nom_item_menu,
	descripcion,
	url,
	cod_item_menu_padre)
values (
	'0305',
	'Reporte 05',
	'Reporte 05',
	'reportes/5/',
	'03');
/* Fin tabla: item_menu */

/* Inicio tabla: perfil */
insert into perfil (
	cod_perfil,
	nom_perfil,
	descripcion)
values (
	0,
	'Administrador TI',
	'Administrador desde el punto de vista TI del sistema. En resumen, tiene acceso a todo. Es el alfa y el omega del sistema.');

insert into perfil (
	cod_perfil,
	nom_perfil,
	descripcion)
values (
	1,
	'Administrador de carrera',
	'Administrador de entidades del sistema, usuarios y perfiles. También accede a reportes de gestión.');

insert into perfil (
	cod_perfil,
	nom_perfil,
	descripcion)
values (
	2,
	'Docente',
	'Docentes de la carrera responsables de la ejecución del taller.');
/* Fin tabla: perfil */

/* Inicio tabla: config_perfil */
insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	0,
	'01');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	0,
	'0101');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	0,
	'0102');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	0,
	'0103');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	0,
	'0104');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	0,
	'0105');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	0,
	'0106');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	0,
	'0107');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	0,
	'0108');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	0,
	'02');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	0,
	'0201');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	0,
	'0202');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	0,
	'0203');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	0,
	'0204');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	0,
	'0205');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	0,
	'03');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	0,
	'0301');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	0,
	'0302');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	0,
	'0303');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	0,
	'0304');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	0,
	'0305');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	1,
	'01');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	1,
	'0101');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	1,
	'0102');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	1,
	'0103');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	1,
	'0104');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	1,
	'0105');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	1,
	'0106');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	1,
	'02');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	1,
	'0201');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	1,
	'0202');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	1,
	'0203');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	1,
	'0204');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	1,
	'0205');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	1,
	'03');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	1,
	'0301');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	1,
	'0302');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	1,
	'0303');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	1,
	'0304');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	1,
	'0305');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	2,
	'01');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	2,
	'0108');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	2,
	'02');

insert into config_perfil (
	cod_perfil,
	cod_item_menu)
values (
	2,
	'0201');
/* Fin tabla: config_perfil */


/* Inicio tabla: periodo_academ */
insert into periodo_academ (
	cod_periodo_academ,
	nom_periodo_academ,
	nom_periodo_academ_abrev)
values (
	1,
	'Primer semestre',
	'1SEM');

insert into periodo_academ (
	cod_periodo_academ,
	nom_periodo_academ,
	nom_periodo_academ_abrev)
values (
	2,
	'Segundo semestre',
	'2SEM');

insert into periodo_academ (
	cod_periodo_academ,
	nom_periodo_academ,
	nom_periodo_academ_abrev)
values (
	3,
	'Temporada académica de verano',
	'TAV');
/* Fin tabla: periodo_academ */

commit;




/* Inicio tabla: usuario */
insert into usuario (
	id_usuario,
	login,
	hash_password,
	primer_apellido,
	segundo_apellido,
	nom,
	nom_preferido,
	cod_perfil,
	cod_carrera)
values (
	1,
	'admin@duoc.cl',
	'c16fd958b85a1c94d872c219ea06ce8e80223239b1fcefb92ad978445ef095507244be44caae1d766e277b072c184cb3ffe4d0610716e989b2fe5a7c97bf3144',
	'Administrador',
	'',
	'del sistema',
	'admin',
	0,
	null);

insert into usuario (
	id_usuario,
	login,
	hash_password,
	primer_apellido,
	segundo_apellido,
	nom,
	nom_preferido,
	cod_perfil,
	cod_carrera)
values (
	2,
	'jmoya@duoc.cl',
	'274ad1a24014ff7f5102ace0fb916e479dd8900012ccecaf2279ae89b62c2bfbd0cf4b63c2697dbf6cec49cfb2dbcd8d95f0b1021ce70834a3f90bfa467a56f5',
	'Moya',
	'Plaza',
	'Jéssica',
	'Jéssica',
	1,
	1);

insert into usuario (
	id_usuario,
	login,
	hash_password,
	primer_apellido,
	segundo_apellido,
	nom,
	nom_preferido,
	cod_perfil,
	cod_carrera)
values (
	3,
	'maalvarez@duoc.cl',
	'68dbb47e38b2c86c14ceebea4341b4fbc5aa0ec711a72fdbe7036be1ba93bfd8d2f453e53ef7411a8fabb4f6e5282c3c667d750e0e0e2f47162d7bb6d03a2261',
	'Álvarez',
	'Román',
	'Marco',
	'Marco',
	2,
	1);

insert into usuario (
	id_usuario,
	login,
	hash_password,
	primer_apellido,
	segundo_apellido,
	nom,
	nom_preferido,
	cod_perfil,
	cod_carrera)
values (
	4,
	'c.gonzalez6@profesor.duoc.cl',
	'dbb8d24a3166d17cd46539f4dca51ac945174b0ed8491859f690ddb24fe6cb74fbbf3338766d273903b8748da32c5a9c645ff0a2013c7412edc38b64cf8f2ec0',
	'González',
	'Figueroa',
	'Cristian',
	'Cristian',
	2,
	1);

insert into usuario (
	id_usuario,
	login,
	hash_password,
	primer_apellido,
	segundo_apellido,
	nom,
	nom_preferido,
	cod_perfil,
	cod_carrera)
values (
	5,
	'r.ceura@profesor.duoc.cl',
	'dbb8d24a3166d17cd46539f4dca51ac945174b0ed8491859f690ddb24fe6cb74fbbf3338766d273903b8748da32c5a9c645ff0a2013c7412edc38b64cf8f2ec0',
	'Ceura',
	'Vergara',
	'Raúl',
	'Raúl',
	2,
	1);

insert into usuario (
	id_usuario,
	login,
	hash_password,
	primer_apellido,
	segundo_apellido,
	nom,
	nom_preferido,
	cod_perfil,
	cod_carrera)
values (
	6,
	'hec.fonseca@profesor.duoc.cl',
	'dbb8d24a3166d17cd46539f4dca51ac945174b0ed8491859f690ddb24fe6cb74fbbf3338766d273903b8748da32c5a9c645ff0a2013c7412edc38b64cf8f2ec0',
	'Fonseca',
	'Castillo',
	'Héctor',
	'Héctor',
	2,
	1);

insert into usuario (
	id_usuario,
	login,
	hash_password,
	primer_apellido,
	segundo_apellido,
	nom,
	nom_preferido,
	cod_perfil,
	cod_carrera)
values (
	7,
	'xi.castro@profesor.duoc.cl',
	'dbb8d24a3166d17cd46539f4dca51ac945174b0ed8491859f690ddb24fe6cb74fbbf3338766d273903b8748da32c5a9c645ff0a2013c7412edc38b64cf8f2ec0',
	'Castro',
	'Arancibia',
	'Ximena',
	'Ximena',
	2,
	1);

insert into usuario (
	id_usuario,
	login,
	hash_password,
	primer_apellido,
	segundo_apellido,
	nom,
	nom_preferido,
	cod_perfil,
	cod_carrera)
values (
	8,
	'c.valenzuelair@profesor.duoc.cl',
	'dbb8d24a3166d17cd46539f4dca51ac945174b0ed8491859f690ddb24fe6cb74fbbf3338766d273903b8748da32c5a9c645ff0a2013c7412edc38b64cf8f2ec0',
	'Valenzuela',
	'Irrázabal',
	'Carolina',
	'Carolina',
	2,
	1);

insert into usuario (
	id_usuario,
	login,
	hash_password,
	primer_apellido,
	segundo_apellido,
	nom,
	nom_preferido,
	cod_perfil,
	cod_carrera)
values (
	9,
	'sa.navarret@profesor.duoc.cl',
	'dbb8d24a3166d17cd46539f4dca51ac945174b0ed8491859f690ddb24fe6cb74fbbf3338766d273903b8748da32c5a9c645ff0a2013c7412edc38b64cf8f2ec0',
	'Navarrete',
	'Bustamante',
	'Sandra',
	'Sandra',
	2,
	1);

insert into usuario (
	id_usuario,
	login,
	hash_password,
	primer_apellido,
	segundo_apellido,
	nom,
	nom_preferido,
	cod_perfil,
	cod_carrera)
values (
	10,
	'fabi.arancibia@profesor.duoc.cl',
	'dbb8d24a3166d17cd46539f4dca51ac945174b0ed8491859f690ddb24fe6cb74fbbf3338766d273903b8748da32c5a9c645ff0a2013c7412edc38b64cf8f2ec0',
	'Arancibia',
	'Severino',
	'Fabián',
	'Fabián',
	2,
	1);

insert into usuario (
	id_usuario,
	login,
	hash_password,
	primer_apellido,
	segundo_apellido,
	nom,
	nom_preferido,
	cod_perfil,
	cod_carrera)
values (
	11,
	'roci.guzman@profesor.duoc.cl',
	'dbb8d24a3166d17cd46539f4dca51ac945174b0ed8491859f690ddb24fe6cb74fbbf3338766d273903b8748da32c5a9c645ff0a2013c7412edc38b64cf8f2ec0',
	'Guzmán',
	'Acuña',
	'Rocío',
	'Rocío',
	2,
	1);

insert into usuario (
	id_usuario,
	login,
	hash_password,
	primer_apellido,
	segundo_apellido,
	nom,
	nom_preferido,
	cod_perfil,
	cod_carrera)
values (
	12,
	'al.camposa@profesor.duoc.cl',
	'dbb8d24a3166d17cd46539f4dca51ac945174b0ed8491859f690ddb24fe6cb74fbbf3338766d273903b8748da32c5a9c645ff0a2013c7412edc38b64cf8f2ec0',
	'Campos',
	'Acuña',
	'Alejandra',
	'Alejandra',
	2,
	1);

insert into usuario (
	id_usuario,
	login,
	hash_password,
	primer_apellido,
	segundo_apellido,
	nom,
	nom_preferido,
	cod_perfil,
	cod_carrera)
values (
	13,
	'cr.madariagam@profesor.duoc.cl',
	'dbb8d24a3166d17cd46539f4dca51ac945174b0ed8491859f690ddb24fe6cb74fbbf3338766d273903b8748da32c5a9c645ff0a2013c7412edc38b64cf8f2ec0',
	'Madariaga',
	'Martínez',
	'Cristian',
	'Cristian',
	2,
	1);

insert into usuario (
	id_usuario,
	login,
	hash_password,
	primer_apellido,
	segundo_apellido,
	nom,
	nom_preferido,
	cod_perfil,
	cod_carrera)
values (
	14,
	'i.inostroza@profesor.duoc.cl',
	'dbb8d24a3166d17cd46539f4dca51ac945174b0ed8491859f690ddb24fe6cb74fbbf3338766d273903b8748da32c5a9c645ff0a2013c7412edc38b64cf8f2ec0',
	'Inostroza',
	'Rodríguez',
	'Isaac',
	'Isaac',
	2,
	1);

insert into usuario (
	id_usuario,
	login,
	hash_password,
	primer_apellido,
	segundo_apellido,
	nom,
	nom_preferido,
	cod_perfil,
	cod_carrera)
values (
	15,
	'v.fuentealbav@profesor.duoc.cl',
	'dbb8d24a3166d17cd46539f4dca51ac945174b0ed8491859f690ddb24fe6cb74fbbf3338766d273903b8748da32c5a9c645ff0a2013c7412edc38b64cf8f2ec0',
	'Fuentealba',
	'Vargas',
	'Víctor',
	'Víctor',
	2,
	1);

insert into usuario (
	id_usuario,
	login,
	hash_password,
	primer_apellido,
	segundo_apellido,
	nom,
	nom_preferido,
	cod_perfil,
	cod_carrera)
values (
	16,
	'j.premolo@profesor.duoc.cl',
	'dbb8d24a3166d17cd46539f4dca51ac945174b0ed8491859f690ddb24fe6cb74fbbf3338766d273903b8748da32c5a9c645ff0a2013c7412edc38b64cf8f2ec0',
	'Prémolo',
	'Yergues',
	'Juan',
	'Juan',
	2,
	1);

insert into usuario (
	id_usuario,
	login,
	hash_password,
	primer_apellido,
	segundo_apellido,
	nom,
	nom_preferido,
	cod_perfil,
	cod_carrera)
values (
	17,
	'car.perezz@profesor.duoc.cl',
	'dbb8d24a3166d17cd46539f4dca51ac945174b0ed8491859f690ddb24fe6cb74fbbf3338766d273903b8748da32c5a9c645ff0a2013c7412edc38b64cf8f2ec0',
	'Pérez',
	'Zúñiga',
	'Carlos',
	'Carlos',
	2,
	1);

insert into usuario (
	id_usuario,
	login,
	hash_password,
	primer_apellido,
	segundo_apellido,
	nom,
	nom_preferido,
	cod_perfil,
	cod_carrera)
values (
	18,
	'de.reglas@profesor.duoc.cl',
	'dbb8d24a3166d17cd46539f4dca51ac945174b0ed8491859f690ddb24fe6cb74fbbf3338766d273903b8748da32c5a9c645ff0a2013c7412edc38b64cf8f2ec0',
	'Reglas',
	'Villagra',
	'Deyanira',
	'Deyanira',
	2,
	1);

insert into usuario (
	id_usuario,
	login,
	hash_password,
	primer_apellido,
	segundo_apellido,
	nom,
	nom_preferido,
	cod_perfil,
	cod_carrera)
values (
	19,
	'dmunita@duoc.cl',
	'dbb8d24a3166d17cd46539f4dca51ac945174b0ed8491859f690ddb24fe6cb74fbbf3338766d273903b8748da32c5a9c645ff0a2013c7412edc38b64cf8f2ec0',
	'Munita',
	'Toro',
	'Daniela',
	'Daniela',
	1,
	2);

insert into usuario (
	id_usuario,
	login,
	hash_password,
	primer_apellido,
	segundo_apellido,
	nom,
	nom_preferido,
	cod_perfil,
	cod_carrera)
values (
	20,
	'pzamorano@duoc.cl',
	'dbb8d24a3166d17cd46539f4dca51ac945174b0ed8491859f690ddb24fe6cb74fbbf3338766d273903b8748da32c5a9c645ff0a2013c7412edc38b64cf8f2ec0',
	'Zamorano',
	'Moreno',
	'Paola',
	'Paola',
	2,
	2);

insert into usuario (
	id_usuario,
	login,
	hash_password,
	primer_apellido,
	segundo_apellido,
	nom,
	nom_preferido,
	cod_perfil,
	cod_carrera)
values (
	21,
	'j.enero@profesor.duoc.cl',
	'dbb8d24a3166d17cd46539f4dca51ac945174b0ed8491859f690ddb24fe6cb74fbbf3338766d273903b8748da32c5a9c645ff0a2013c7412edc38b64cf8f2ec0',
	'Enero',
	'Rivero',
	'Juan Francisco',
	'Juan',
	2,
	2);

insert into usuario (
	id_usuario,
	login,
	hash_password,
	primer_apellido,
	segundo_apellido,
	nom,
	nom_preferido,
	cod_perfil,
	cod_carrera)
values (
	22,
	'm.gutierrez2@profesor.duoc.cl',
	'dbb8d24a3166d17cd46539f4dca51ac945174b0ed8491859f690ddb24fe6cb74fbbf3338766d273903b8748da32c5a9c645ff0a2013c7412edc38b64cf8f2ec0',
	'Gutiérrez',
	'Cortés',
	'Mauricio',
	'Mauricio',
	2,
	2);
/* Fin tabla: usuario */

commit;


/* Inicio tabla: taller */
insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	1,
	'Inducción al taller',
	'Conocimiento big four. tecnicas de repaso. montaje de mesas. ejecución práctica de montaje de mesas: a la carta y al menú. ejecución práctica de tipos de servicio: al plato, inglesa, francesa, con campana, servicio de bebidas calientes. juego de roles. toma inventario big four.',
	1,
	'ABT3111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	2,
	'Organización del personal de restaurant',
	'Montaje de mesas. demostracion de servicio y atencion de comensales. demosttración toma de comanda. servicio de aperitivos: pisco sour y limonada albahaca. demostracion servicio de pan, demostración servicio de vinos, servicio emplatado en alimentos, servicio de bebidas calientes.',
	2,
	'ABT3111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	3,
	'Organización del personal de restaurant',
	'Procedimientos de atencion y servicio de comensales. montaje de mesas. servicio y atencion de comensales. toma de comanda. servicio de aperitivos: tequila margarita y mojito sin alcohol. servicio de pan a la francesa, servicio emplatado en alimentos, servicio de vinos, servicio de bebidas calientes.',
	3,
	'ABT3111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	4,
	'Organización y desarrollo de los procesos de servicio y atencion de comensales',
	'Actividades de mise en place. actividades de servicio. actividades de servicio de vinos. actividades de servicio de aperitivos: pisco sour peruano y bella luna. servicio de pan a la inglesa, servicio emplatado en alimentos, servicio de té e infusiones',
	4,
	'ABT3111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	5,
	'Servicio de desayuno',
	'Servicio desayuno: mise en place y montaje de salón para el servicio y atencion de 20 comensales. servicio desayuno continental. aplicacion de procedimientos de mise en place. aplicación de procedimientos de protocolo de servicio: aplicación de procedimientos de servicio de bebidas caliente y frias, servicio a la inglesa de té e infusiones',
	5,
	'ABT3111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	6,
	'Mise en place y montaje de salón',
	'Mise en place y montaje de salón para el servicio y atencion de 20 comensales. aplicacion de procedimientos de mise en place. aplicación de procedimientos de servicio. aplicación de procedimientos de servicio de vinos (sommelier). aplicación de procedimientos de servicio de aperitivos: serena libre y florida. servicio de pan a la inglesa, servicio a la inglesa en alimentos, servicio francés en bebidas calientes.',
	6,
	'ABT3111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	7,
	'Mise en place y montaje de salón',
	'Mise en place y montaje de salón para el servicio y atencion de 20 comensales. aplicacion de procedimientos de mise en place. aplicación de procedimientos de servicio. aplicación de procedimientos de servicio de vinos (sommelier). aplicación de procedimientos de servicio de aperitivos: mango sour y paraiso frozen. servicio de pan a la inglesa, servicio a la inglesa en alimentos, servicio de té e infusiones.',
	7,
	'ABT3111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	8,
	'Examen primer grupo',
	'Mise en place y montaje de salón para el servicio y atencion de 20 comensales. aplicacion de procedimientos de mise en place. aplicación de procedimientos de servicio. aplicación de procedimientos de servicio de vinos. aplicación de procedimientos de servicio de aperitivos: bellini y daiquiri de frambuesas. servicio de pan a la inglesa, servicio emplatado en alimentos, servicio de té e infusiones.',
	8,
	'ABT3111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	9,
	'Inducción al taller',
	'Conocimiento big four. tecnicas de repaso. montaje de mesas. ejecución práctica de montaje de mesas: a la carta y al menú. ejecución práctica de tipos de servicio: al plato, inglesa, francesa, con campana, servicio de bebidas calientes. juego de roles. toma inventario big four.',
	9,
	'ABT3111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	10,
	'Organización del personal de restaurant',
	'Montaje de mesas. demostracion de servicio y atencion de comensales. demosttración toma de comanda. servicio de aperitivos: pisco sour y limonada albahaca. demostracion servicio de pan, demostración servicio de vinos, servicio emplatado en alimentos, servicio de bebidas calientes.',
	10,
	'ABT3111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	11,
	'Organización del personal de restaurant',
	'Procedimientos de atencion y servicio de comensales. montaje de mesas. servicio y atencion de comensales. toma de comanda. servicio de aperitivos: tequila margarita y mojito sin alcohol. servicio de pan a la francesa, servicio emplatado en alimentos, servicio de vinos, servicio de bebidas calientes.',
	11,
	'ABT3111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	12,
	'Servicio y atencion de comensales',
	'Organización y desarrollo de los procesos de servicio y atencion de comensales. actividades de mise en place. actividades de servicio. actividades de servicio de vinos. actividades de servicio de aperitivos: pisco sour peruano y bella luna. servicio de pan a la inglesa, servicio emplatado en alimentos, servicio de té e infusiones',
	12,
	'ABT3111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	13,
	'Servicio desayuno',
	'Mise en place y montaje de salón para el servicio y atencion de 20 comensales. servicio desayuno continental. aplicacion de procedimientos de mise en place. aplicación de procedimientos de protocolo de servicio: aplicación de procedimientos de servicio de bebidas caliente y frias, servicio a la inglesa de té e infusiones',
	13,
	'ABT3111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	14,
	'Mise en place y montaje de salón',
	'Mise en place y montaje de salón para el servicio y atencion de 20 comensales. aplicacion de procedimientos de mise en place. aplicación de procedimientos de servicio. aplicación de procedimientos de servicio de vinos (sommelier). aplicación de procedimientos de servicio de aperitivos: serena libre y florida. servicio de pan a la inglesa, servicio a la inglesa en alimentos, servicio francés en bebidas calientes.',
	14,
	'ABT3111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	15,
	'Mise en place y montaje de salón',
	'Mise en place y montaje de salón para el servicio y atencion de 20 comensales. aplicacion de procedimientos de mise en place. aplicación de procedimientos de servicio. aplicación de procedimientos de servicio de vinos (sommelier). aplicación de procedimientos de servicio de aperitivos: mango sour y paraiso frozen. servicio de pan a la inglesa, servicio a la inglesa en alimentos, servicio de té e infusiones.',
	15,
	'ABT3111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	16,
	'Examen primer grupo',
	'Mise en place y montaje de salón para el servicio y atencion de 20 comensales. aplicacion de procedimientos de mise en place. aplicación de procedimientos de servicio. aplicación de procedimientos de servicio de vinos. aplicación de procedimientos de servicio de aperitivos: bellini y daiquiri de frambuesas. servicio de pan a la inglesa, servicio emplatado en alimentos, servicio de té e infusiones.',
	16,
	'ABT3111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	17,
	'Fermentados',
	'Fermentados',
	3,
	'ABT3121');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	18,
	'Destilados',
	'Destilados',
	4,
	'ABT3121');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	19,
	'VDL - ABV - ABA',
	'VDL - ABV - ABA',
	5,
	'ABT3121');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	20,
	'Licores y cremas',
	'Licores y cremas',
	6,
	'ABT3121');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	21,
	'Técnicas de elaboración de cócteles',
	'Cosmopolitan, Manhattan, Caipirihna, Pisco Sour
Preparar goma en clases',
	7,
	'ABT3121');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	22,
	'Coctelera',
	'Daiquiri - Margarita - Aviation - Side Car - Last Word - Alexander - Pisco Sour - White Lady - Florida - Cosmopolitan
Preparar goma',
	8,
	'ABT3121');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	23,
	'Machacados directo al vaso',
	'Negroni - Screw Driver - John Collins - Black Russian - Caipirihna - Long Island Tea - Mint Julep - Old Fashioned
Preparar goma',
	9,
	'ABT3121');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	24,
	'Vaso mezclador - Licuadora',
	'Martiny Dry, Presidente, Manhattan, Boulevardier, Bloody Mary, Frozen Lychee y Menta, Alzheimer, Piña Colada',
	10,
	'ABT3121');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	25,
	'Evaluación práctica',
	'Docentes hacen pedido según progresión del curso, en la clase 8.  Si en esa clase no se hace no hay pedido y se ajusta a lo que pueda facilitar bodega',
	11,
	'ABT3121');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	26,
	'Aperitivos',
	'Side Car, Old Fashioned, Martini Dry, Manhattan, Whisky Sour, Martinez, Americano, Champagmne Cocktail, Kir Royal
Preparar goma',
	12,
	'ABT3121');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	27,
	'Cócteles refrescantes',
	'Daiquiri, Florida, White Lady, Piña Colada, Blue Lagoon, Tequila Sunrise, Gin Fizz, Mojito, Moscow Mule.
Preparar jarabe de goma',
	13,
	'ABT3121');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	28,
	'Cócteles digestivos',
	'Alexander, Black Russian, Grasshopper, Rusty Nail, Irish Coffee, Velvet Hammer, God Father
Preparar Jarabe de goma',
	14,
	'ABT3121');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	29,
	'Evaluación práctica',
	'Docentes hacen pedido según progresión del curso sobre aperitivos, cócteles refrescantes y digestivos. Pedido se hace en clase 12, sin pedido se usara solo lo que bodega pueda facilitar',
	15,
	'ABT3121');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	30,
	'Evaluación práctica',
	'Licor artesanal y creación de cóctel. docentes realizan pedido según progresión del curso. Pedido se hace en clase 13  sin pedido, se usara solo lo que bodega pueda facilitar',
	16,
	'ABT3121');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	31,
	'Evaluación práctica',
	'Exámen práctico. docentes realizan pedido según progresión del curso. pedido se hace en clase 14, sin pedido se usara solo lo que bodega pueda facilitar',
	17,
	'ABT3121');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	32,
	'Técnicas de corte, dressing y ensalada simple, mixta',
	'Técnicas de corte, dressing y ensalada simple, mixta',
	2,
	'ABT3142');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	33,
	'Técnicas de corte, cocción de vegetales y huevos',
	'Técnicas de corte, cocción de vegetales y huevos',
	3,
	'ABT3142');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	34,
	'Técnicas de corte, cocción de vegetales y huevos',
	'Técnicas de corte, cocción de vegetales y huevos',
	4,
	'ABT3142');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	35,
	'Mini sandwichs',
	'Mini sandwichs',
	5,
	'ABT3142');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	36,
	'Servicio de cóctel y bocados fríos',
	'Servicio de cóctel y bocados fríos',
	6,
	'ABT3142');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	37,
	'Mini sandwichs evaluación',
	'Mini sandwichs evaluación',
	7,
	'ABT3142');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	38,
	'Servicio de cóctel y bocados calientes',
	'Servicio de cóctel y bocados calientes',
	8,
	'ABT3142');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	39,
	'Sopas ligadas, potaje y decoraciones basicas',
	'Sopas ligadas, potaje y decoraciones basicas',
	9,
	'ABT3142');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	40,
	'Cerdo, guarniciones y salsa',
	'Cerdo, guarniciones y salsa',
	10,
	'ABT3142');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	41,
	'Cerdo, guarniciones y salsa',
	'Cerdo, guarniciones y salsa',
	11,
	'ABT3142');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	42,
	'Pescado como entrada, puntos de cocción del vacuno',
	'Pescado como entrada, puntos de cocción del vacuno',
	12,
	'ABT3142');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	43,
	'Bocados dulces',
	'Bocados dulces',
	13,
	'ABT3142');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	44,
	'Masas secas',
	'Masas secas',
	14,
	'ABT3142');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	45,
	'Cenas temáticas',
	'Cenas temáticas',
	15,
	'ABT3142');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	46,
	'Pedido base para proyectar el servicio de brunch examen',
	'Pedido base para proyectar el servicio de brunch examen',
	16,
	'ABT3142');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	47,
	'Examen',
	'Servicio de Brunch',
	17,
	'ABT3142');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	48,
	'Pedido semestre',
	'Pedido semestre',
	1,
	'RHT2121');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	49,
	'Técnicas de corte, dressing y ensalada simple, mixta',
	'Técnicas de corte, dressing y ensalada simple, mixta',
	2,
	'TCC3301');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	50,
	'Técnicas de corte, cocción de vegetales y huevos,  ensaladas compuestas',
	'Técnicas de corte, cocción de vegetales y huevos,  ensaladas compuestas',
	3,
	'TCC3301');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	51,
	'Técnicas de corte, cocción de vegetales y huevos',
	'Técnicas de corte, cocción de vegetales y huevos',
	4,
	'TCC3301');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	52,
	'Mini sandwichs',
	'Mini sandwichs',
	5,
	'TCC3301');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	53,
	'Servicio de cóctel y bocados fríos',
	'Servicio de cóctel y bocados fríos',
	6,
	'TCC3301');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	54,
	'Evaluación',
	'Mini sandwichs',
	7,
	'TCC3301');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	55,
	'Servicio de cóctel y bocados calientes',
	'Servicio de cóctel y bocados calientes',
	8,
	'TCC3301');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	56,
	'Sopas ligadas, potaje y decoraciones basicas',
	'Sopas ligadas, potaje y decoraciones basicas',
	9,
	'TCC3301');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	57,
	'Cerdo, guarniciones y salsa',
	'Cerdo, guarniciones y salsa',
	10,
	'TCC3301');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	58,
	'Cerdo, guarniciones y salsa',
	'Cerdo, guarniciones y salsa',
	11,
	'TCC3301');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	59,
	'Pescado como entrada, puntos de cocción vacuno, arroz como acompañamiento',
	'Pescado como entrada, puntos de cocción vacuno, arroz como acompañamiento',
	12,
	'TCC3301');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	60,
	'Bocados dulces',
	'Bocados dulces',
	13,
	'TCC3301');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	61,
	'Masas secas',
	'Masas secas',
	14,
	'TCC3301');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	62,
	'Cenas temáticas',
	'Cenas temáticas',
	15,
	'TCC3301');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	63,
	'Pedido base para proyectar el servicio de brunch examen',
	'Pedido base para proyectar el servicio de brunch examen',
	16,
	'TCC3301');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	64,
	'Examen',
	'Servicio de Brunch',
	17,
	'TCC3301');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	65,
	'Cata de vinos',
	'Cata de vinos',
	1,
	'ABT2131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	66,
	'Cata de vinos',
	'Cata de vinos',
	2,
	'ABT2131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	67,
	'Cata de vinos',
	'Cata de vinos',
	3,
	'ABT2131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	68,
	'Cata de vinos',
	'Vinos blancos',
	4,
	'ABT2131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	69,
	'Cata de vinos',
	'Vinos blancos',
	5,
	'ABT2131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	70,
	'Evaluación práctica',
	'Vinos blancos',
	6,
	'ABT2131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	71,
	'Cata de vinos',
	'Cata de vinos',
	7,
	'ABT2131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	72,
	'Cata de vinos',
	'Vinos tintos',
	8,
	'ABT2131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	73,
	'Cata de vinos',
	'Vinos tintos',
	9,
	'ABT2131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	74,
	'Cata de vinos',
	'Cata y maridaje de vinos tintos',
	10,
	'ABT2131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	75,
	'Evaluación práctica',
	'Vinos tintos',
	11,
	'ABT2131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	76,
	'Cata de vinos',
	'Espumantes',
	12,
	'ABT2131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	77,
	'Cata de vinos',
	'Vinos fortificados',
	13,
	'ABT2131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	78,
	'Cata de vinos',
	'Piscos artesanales',
	14,
	'ABT2131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	79,
	'Cata de vinos',
	'Cervezas artesanales',
	15,
	'ABT2131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	80,
	'Evaluación práctica',
	'Evaluación práctica',
	16,
	'ABT2131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	81,
	'Evaluación práctica',
	'Evaluación práctica',
	17,
	'ABT2131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	82,
	'Demostración práctica',
	'Piscola, Tequila sunrise, Godfather, Screwdriver,Negroni (DIRECTOS). Demostración práctica por parte del docente y 1 réplica por grupo.',
	1,
	'ABT3131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	83,
	'Batidos - Coctelera',
	'Pisco Sour, White Lady, Ruso Blanco,Margarita clásico',
	2,
	'ABT3131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	84,
	'Machacados directo al vaso',
	'Caipirinha, Sour apple vodka,  Mojito, Fresco del Limarí . ',
	3,
	'ABT3131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	85,
	'Evaluación práctica',
	'Pisco Sour peruano, Mojito, Tequila Sunrise.',
	4,
	'ABT3131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	86,
	'Licuados',
	'Piña Colada, Daiquiri de Pepino-plátano, margarita de Fruta.',
	5,
	'ABT3131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	87,
	'Refrescados y clásicos chilenos',
	'Martini dry, Manhattan, Mi to, Capitán, Bitter a la Francesa,Pichuncho,Pantera rosa',
	6,
	'ABT3131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	88,
	'Elaboración especial',
	'Bloody Mary, espresso martini, café irlandes, Bellini, Aperol Spritz,  & evaluación de  Martini dry, bitter a la francesa, daiquiri plátano',
	7,
	'ABT3131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	89,
	'Tragos varios',
	'Old Fashioned, Santiago Sour, Cardonnay Sour, Kirsch Royale, Laguna Azul, Blue Hawaiian',
	8,
	'ABT3131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	90,
	'Pedido examen',
	'Canasta base para creación de propuesta examen.',
	9,
	'ABT3131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	91,
	'Bocados fríos para cocktail',
	'Canapé, crostini y bocados fríos en vajilla.',
	10,
	'ABT3131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	92,
	'Preparaciones para cocktail',
	'Preparaciones en vajilla tipo buffet, roulade y terrina                                                                                                                                               ',
	11,
	'ABT3131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	93,
	'Evaluación',
	'Bocados fríos (canasta sorpresa)',
	12,
	'ABT3131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	94,
	'Preparaciones calientes para evento de pie',
	'Empanadas, brochetas de vacuno, satté.',
	13,
	'ABT3131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	95,
	'Trinchado de filete y hamburguesas',
	'Trinchado de filete y hamburguesas',
	14,
	'ABT3131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	96,
	'Evaluación',
	'Bocados calientes (canasta sorpresa)',
	15,
	'ABT3131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	97,
	'Buffet de sushi',
	'Buffet de sushi',
	16,
	'ABT3131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	98,
	'Bocadillos dulces',
	'Cake pop de bizcocho o galleta molida con manjar boleado. Cup cakes de vainilla rellenos con frutos rojos y frostin de queso. Mini pie de limón.                                                                                                                                              ',
	17,
	'ABT3131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	99,
	'Examen',
	'Pedido examen',
	18,
	'ABT3131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	100,
	'Preparación',
	'Semana 1',
	1,
	'ABT3141');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	101,
	'Preparación',
	'Semana 2',
	2,
	'ABT3141');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	102,
	'Preparación',
	'Semana 3',
	3,
	'ABT3141');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	103,
	'Preparación',
	'Semana 4',
	4,
	'ABT3141');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	104,
	'Preparación',
	'Semana 5',
	5,
	'ABT3141');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	105,
	'Preparación',
	'Semana 6',
	6,
	'ABT3141');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	106,
	'Preparación',
	'Semana 7',
	7,
	'ABT3141');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	107,
	'Preparación',
	'Semana 8',
	8,
	'ABT3141');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	108,
	'Preparación',
	'Semana 9',
	9,
	'ABT3141');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	109,
	'Preparación',
	'Semana 1',
	1,
	'ABT4151');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	110,
	'Preparación',
	'Semana 2',
	2,
	'ABT4151');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	111,
	'Preparación',
	'Semana 3',
	3,
	'ABT4151');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	112,
	'Preparación',
	'Semana 4',
	4,
	'ABT4151');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	113,
	'Preparación',
	'Semana 5',
	5,
	'ABT4151');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	114,
	'Preparación',
	'Semana 6',
	6,
	'ABT4151');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	115,
	'Preparación',
	'Semana 7',
	7,
	'ABT4151');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	116,
	'Preparación',
	'Semana 8',
	8,
	'ABT4151');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	117,
	'Preparación',
	'Semana 9',
	9,
	'ABT4151');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	118,
	'Preparación',
	'Ensaladas',
	1,
	'CIT1111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	119,
	'Preparación',
	'Ensaladas',
	2,
	'CIT1111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	120,
	'Preparación',
	'Fondos, crema de setas, sopa de mariscos, consomé',
	3,
	'CIT1111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	121,
	'Preparación',
	'Fondos, crema de zapallo, sopa de cebolla, crema de espárragos',
	4,
	'CIT1111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	122,
	'Evaluación 1',
	'Crema de zetas, crema de zapallo',
	5,
	'CIT1111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	123,
	'Preparación',
	'Fetuccinni,salsa pomodoro, bolognesa, putanesca y amatriciana',
	6,
	'CIT1111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	124,
	'Preparación',
	'Ravioles rellenos espinaca ricotta, jamon pierna ricotta, ravioles rellenos con ricotta y camarón, salsa tres quesos (gruyere , roquefort y chanco) en base salsa bechamel.',
	7,
	'CIT1111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	125,
	'Preparación',
	'Raviolli,fetuccines, salsa 3 quesos, salsa putanezca',
	8,
	'CIT1111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	126,
	'Preparación',
	'Pollo asado, pollo grillado,puré y derivados, salsa por reducción',
	9,
	'CIT1111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	127,
	'Preparación',
	'pollo a la king, pollo cordon bleu, masa duquesa, vegetales saletados,salsa por reducción ',
	10,
	'CIT1111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	128,
	'Preparación',
	'Pollo cordon bleu, pollo grillado, masa duquesa, vegetales salteados, salsa por reducción',
	11,
	'CIT1111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	129,
	'Preparación',
	'Strogonoff de filete, carne mechada, cazuela, roast beef, lomo grillado, vegetales asados, vegetales salteados, verduras a la polonesa',
	12,
	'CIT1111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	130,
	'Preparación',
	'Osobuco, plateada, carne mongoliana, goulash',
	13,
	'CIT1111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	131,
	'Preparación',
	'Carne mechada, strogonoff, puré rústico, vegetales asados, lomo a la plancha',
	14,
	'CIT1111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	132,
	'Preparación',
	'Reineta a la plancha, congrio frito, arroz pilaf, arroz creole, salsa bechamel',
	15,
	'CIT1111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	133,
	'Preparación',
	'Mariscos, risotto',
	16,
	'CIT1111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	134,
	'Examen',
	'Reineta a la plancha, arroz pilaf, salsa de mariscos(base bechamel)',
	17,
	'CIT1111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	135,
	'Inducción, bases deshidratadas y pre mezclas + sous vide',
	'* Elaboración de puré en caja

* Pechuga de pollo sous vide sazonada con bases deshidratadas

* Sopa de pollo (sobre)

* Crema de espárragos

* Brownie chocolate premezcla',
	1,
	'CIT2111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	136,
	'Elaborando entradas frías y calientes',
	'* Ensalada rusa con mayonesa, sopa de pollo deshidratada, huevo cocido a 72º por 17 minutos. topping de tocino crocante

* Ensalada César pollo, aderezo César. Crema de espárragos deshidratadas, huevo cocido a 85º por 15 minutos

* Ensalada mixta, vinagreta de frambuesa liofilizada, crema de tomtes. Huevo cocinado a 85º por 12 minutos, topping de pesto y nueces

* Ensalada templada con aderezo agridulce de mostaza. Crema de papas deshidratada, huevo cocido a 72 º por 21 minutos, topping papas hilo

',
	2,
	'CIT2111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	137,
	'Dietas especiales',
	'1.- Menú hipocalórico:
Ensalada de repollo zanahoria con lactonesa y frutos secos. reineta sous vide (marinada cítrica) con verduras asadas. gelatina de piña con manzana rallada
2.- Menú hipercalórico
Ensalada capresse con limoneta. lasaña de carne y espinaca. brownie de chocolate
3.- Menú vegetariano:
Ensaladamix de hojas verdes, pepino tomate y aceitunas con dressing de mostaza y miel. albóndigas de carne de soya en salsa pomodoro con pasta lisa. peras pochadas al vino tinto
4.-Menú vegano:
Ensalada primaveral con vinagreta de aceitunas y pimentón asado.  milanesa deberenjenas con humus. arroz con coco
',
	3,
	'CIT2111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	138,
	'Requerimientos alimentarios específicos',
	'1.- Menú para celíacos:
Ensalada apio palta con limoneta. fideos de arroz con salsa bolognesa. Leche asada.
2.- Menú para hipertensos y colesteron alto:
Ensalada de lechuga con choclo, tomte y zanahoria + vinagreta. Bistec con budín de verduras. Crepe con fruta fesca.
3.- Menú para diabéticos:
Ensalada de tomates y pepino con vinagreta. Lentejas con arroz. Brownie de manzana
4.- Menú mediterranéo (como prevención de enfermedades: cáncer, diabetes etc)
Crema de zapallo con crutones al oliva. Pechuga de pollo sous vide con brocolis y coliflor. Macedonia de frutas.
',
	4,
	'CIT2111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	139,
	'Evaluación',
	'1.- Menú hipocalórico
2.- Menú hipercalórico
3.- Menú vegetariano
4.- Menú vegano',
	5,
	'CIT2111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	140,
	'Elaborando principales en base a vacuno y pescado',
	'1.- Albóndigas pomodoro, arroz árabe y vegetales salteados: cebollín, berenjenas, choclo, brócoli, zapallo italiano, pimentón.

2.- Hamburguesas en salsa española. Arroz primavera, vegetales salteados. cebollín, berenjenas, choclo, brócoli, zapallo italiano y pimentón.

3.- Asado alemán con salsa de tomates. Arroz al perejil, vegetales salteados: cebollín, berenjenas,choclo, brócoli, zapallo italiano y pimentón

4.- Pimentones rellenos. Arroz pilaf, vegetales salteados: cebollín, berenjenas,choclo, brócoli, zapallo italiano y pimentón
',
	6,
	'CIT2111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	141,
	'Elaborando principales en base a ave y cerdo',
	'1.- Chapsui de ave/chuleta parrillera la plancha. Papas lyonesa

2.-Chapsui de ave/chuleta de cerdo parrillera a la plancha/papas lyonesa

3.-Trutro de pollo al jugo/chuleta de cerdo a la cazadora/papas lyonesa

4.-Trutro de pollo al jugo/chuleta a la cazadora/papas lyonesa

',
	7,
	'CIT2111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	142,
	'Elaborando línea de servicio',
	'1.- Bistec de res a la plancha con tortilla de verduras y arroz pilaf

2.- Bistec de res a la plancha con tortilla de verduras y arroz primavera

3.- Pechuga de ave a la plancha con tortilla de papas y quinoa al curry

4.- Pechuga de ave a la plancha con tortilla de papas y quinoa',
	8,
	'CIT2111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	143,
	'Evaluación',
	'Todos los grupos elaboran:

Bistec de res a la plancha con salsa española con tortilla de verduras y papas lyonesa. Peras al vino tinto

',
	9,
	'CIT2111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	144,
	'Recetas clásicas de legumbres',
	'1.-  Porotos:
Ensalada chilena/porotos granados con mazamorra y longaniza/jalea de frambuesas con crema

2.- Lentejas:
ensalada chilena/lentejas con arros y gordas/flan

3.- Garbanzos:
ensalada chilena/garbanzos con arroz/ensalada de frutas

4.- Arvejas
ensalada chilena/arvejas partidas con tocino a la parmesana/ compota de manzana',
	10,
	'CIT2111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	145,
	'Mixtura de legumbres',
	'1.- Porotos:
Ensalada de porotos negros con albahaca y pepino + topping de almendras esfiladas
salmón sous vide compañado de tacu tacu

2.- Lentejas:
Ensalada de lentejas rojas con tomate cherry y menta + salsa de yoghurt natural
hamburgeuesas de lentejas con puré de papas con aceitunas

3.- Garbanzos:
Hummus xo masas crujientes con topping de crudities
falafel de garbanzos con arroz árabe

4.- Arvejas:
Ensalada de arvejas con tomate, choclo, menta, limoneta
tortilla de arvejas con verduras de la estación',
	11,
	'CIT2111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	146,
	'Evaluación legumbres',
	'1.-  Porotos:
Ensalada chilena/porotos granados con mazamorra y longaniza/jalea de frambuesas con crema

2.- Lentejas:
Ensalada chilena/lentejas con arroz y gordas/flan

3.- Garbanzos:
Ensalada chilena/garbanzos con arroz/ensalada de frutas

4.- Arvejas
Ensalada chilena/arvejas partidas con tocino a la parmesana/ compota de manzana',
	12,
	'CIT2111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	147,
	'Postres en base a pre mezclas',
	'1.- Brazo de reina/flan

2.- Profiteroles con crema pastelera

3.- Muffins de chocolate con frosting de queso crema y vainilla/ jalea con fruta

4.- Panqueques con crema diplomática/ peras sous vide/sémola con leche',
	13,
	'CIT2111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	148,
	'Elaboración de postres para la cocina institucional',
	'1.- Tartaleta de frutas/peras confitadas sous vide/leche asada

2.- Pie de limón/compòta de manzana jengibre sous vide/babaroisse

3.- Küchen de manzana/manzana sous videarroz con leche de coco

4.- Brownie con mousse de chocolate/peras sous vide/ sémola con leche
',
	14,
	'CIT2111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	149,
	'Exámen final',
	'Exámen final',
	17,
	'CIT2111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	150,
	'Inducción y nivelación',
	'Clase demostrativa/participativa (taller laboratorio/nivelación)
todos los cuartos realizan las mismas preparaciones (técnicas).
* Filetear, limpiar ,porcionar salmón, limpiar, marinar reservar
* Limpiar, mencionar y mostrar partes del filete de vacuno , porcionar, marinar  y reservar
* Fondo de pollo, salsa española mixta, salsa rducción crema (mirepoix, b. garnie, etc)
* Risotto (sabor libre), vegetales salteados /grillados , tulle salada,craquelado ,deshidratado
* Papa a la crema, fettuccini de espinaca (opcional), coulis de vegetales
* Helado(sabor libre) salsa de berries, decoracion de 4/4, brandy snap, chocolate, caramelo,   isomalt, transfer.                                                                                                                                                                                          ',
	1,
	'CRT3111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	151,
	'Evaluación - España',
	'Evaluación clase cocina española. Clase con comensales.
Entradas: Cuarto Frío
- Tortilla de patatas y escalibada.
- Chipirones en su tinta.
- Mantequilla con pimiento del piquillo.
Platos de Fondo: Cuarto Caliente
- Congrio asado a la plancha acompañado de fideuá.
- Cordero braseado acompañado de pisto manchego, patatas bravas y alioli.
- Almuerzo de personal: garbanzos con longaniza y postre.
Postre: Pastelería
- Leche frita, helado de mora, zarzaparrilla.
- Crema catalana, helado de vino dulce e higos.
- Pan: saborizado con morcilla (prietas) y aceitunas verdes/queso.',
	2,
	'CRT3111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	152,
	'Evaluación - España',
	'Evaluación clase cocina española. Clase con comensales.
Entradas: Cuarto Frío
- Tortilla de patatas y escalibada.
- Chipirones en su tinta.
- Mantequilla con pimiento del piquillo.
Platos de Fondo: Cuarto Caliente
- Congrio asado a la plancha acompañado de fideuá.
- Cordero braseado acompañado de pisto manchego, patatas bravas y alioli.
- Almuerzo de personal: garbanzos con longaniza y postre.
Postre: Pastelería
- Leche frita, helado de mora, zarzaparrilla.
- Crema catalana, helado de vino dulce e higos.
- Pan: saborizado con morcilla (prietas) y aceitunas verdes/queso.',
	3,
	'CRT3111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	153,
	'Evaluación - Francia',
	'Cocina francesa. Clase con comensales.
Entradas: Cuarto Frío
- Sopa de cebollas y pan gratinado.
- Degustación de quiche (lorraine, espinaca, setas), mini ensalada con vinagreta.
- Mantequilla Maitre d´Hotel. 
Platos de Fondo: Cuarto Caliente
- Magret de pato sous vide, papa dauphinoise, torneado/sacabocado de vegetales salteados a la mostaza dijon y reducción de naranja y cedrón.
- Costillas de cordero a la francesa, puré habas con queso roquefort, ratatouille y salsa reducción de vino tinto.
- Almuerzo de personal: pescado al horno, puré de papas y postre.
Postre: Pastelería
- Creme brulée con helado de nueces aromatizadas con cava.
- Tarte tatin, helado de creme de cassis.
- Pan: croissant y mini baguette.
',
	4,
	'CRT3111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	154,
	'Evaluación - Francia',
	'EVALUACIÓN COCINA FRANCESA, CLASE CON COMENSALES.
Entradas: Cuarto Frío
- Sopa de cebollas y pan gratinado.
- Degustación de quiche (lorraine, espinaca, setas), mini ensalada con vinagreta.
- Mantequilla Maitre d´Hotel. 
Platos de Fondo: Cuarto Caliente
- Magret de pato sous vide, papa dauphinoise, torneado/sacabocado de vegetales salteados a la mostaza dijon y reducción de naranja y cedrón.
- Costillas de cordero a la francesa, puré habas con queso roquefort, ratatouille y salsa reducción de vino tinto.
- Almuerzo de personal: vacuno bourguignon, papa asada y postre.
Postre: Pastelería
- Creme brulée con helado de nueces aromatizadas con cava.
- Tarte tatin, helado de creme de cassis.
- Pan: croissant y mini baguette.
',
	5,
	'CRT3111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	155,
	'Evaluación asistida - Italia',
	'Cocina Italiana / Evaluación asistida. Clase con comensales.
Entradas: Cuarto Frío
- Lasaña de vegetales, salsa pomodoro y pesto.
- Selección de bruschettas (prosciutto, pulpo y peperonatta).
- Mantequilla de orégano fresco y pistachos.
Platos de Fondo: Cuarto Caliente
- Risotto negro (tinta de calamar) y frutos del mar.
- Canelones rellenos con pollo asado, tocino y ricotta, gratinados con salsa bechamel y acompañados de salsa pomodoro.
- Almuerzo de personal:  Pasta con salsa de champiñón, aceitunas y perejil (base tomate) y postre.
Postre: Pastelería
- Panna cotta de frambuesa, salsa de naranja ácida y helado de nutella, frutas al zabaione.
- Tiramisú, helado de pistacho y salsa de moras con arándanos.
- Pan: ciabatta y focaccia.',
	6,
	'CRT3111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	156,
	'Evaluación asistida - Medio Oriente, Tailandia, Japón',
	'Cocina de Oriente / Evaluación asistida. Clase con comensales.
Entradas: Cuarto Frío
- Duo de Tataki (salmón y atún), salsa ponzu y pequeña ensalada (Japón).
- Hojita de parra rellenas, labban y zahatar (Medio oriente).
- Mantequilla de especias 
Platos de Fondo: Cuarto Caliente
- Pad thai de pollo y tofu (Tailandia).
- Yakisoba de mariscos (Japón).
- Almuerzo de personal: zapallo italiano relleno o guiso, arroz y postre.
- Postre: Pastelería
- Baklawe, helado de dátiles, salsa de té e higos, peras al jengibre con pistachos y decoración de caramelo (Medio oriente).
- Satay de piña, helado de té matcha y coco, salsa de mango picante, lichees y pasta frita (Tailandia).
- Pan: al vapor (Japón), Pita (Medio oriente).',
	7,
	'CRT3111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	157,
	'Evaluación asistida - Perú',
	'Cocina Peruana / Evaluación asistida. Clase con comensales.
Entradas: Cuarto Frío
- Pulpo a la Parrilla, solterito arequipeño y salsa al olivo.
- Causa de camarón y tiradito nikkei de salmón.
- Mantequilla: ají panca y huacatay.
Platos de Fondo: Cuarto Caliente
- Pescado fresco a la chorrillana, arroz chaufa y yuca frita.
- Lomo saltado y tacu tacu.
- Almuerzo de personal: Arroz chaufa de pollo y postre.
Postre: Pastelería
- Suspiro de limeña, helado de mazamorra morada, salsa de maracuyá.
- Crema volteada, helado de plátano, salsa de tumbo.
- Pan: Mollete y de papa amarilla.',
	8,
	'CRT3111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	158,
	'Evaluación final',
	'Examen final, menú dirigido. Clase con comensales.
Entradas: Cuarto Frío
- Degustación de quiche (lorraine, espinaca, setas), mini ensalada con vinagreta (Francia).
- Causa de camarón y tiradito nikkei de salmón (Perú).
- Manteqilla de finas hierbas.
Platos de Fondo: Cuarto Caliente
- Pad thai de pollo (Tailandia).
- Risotto negro (tinta de calamar) y frutos del mar (Italia).
- Almuerzo de personal: pastel de papas y postre.
Postre: Pastelería
- Leche frita, helado de mora, zarzaparrilla (España).
- Tiramisú con helado de nutella y salsa de moras con arándanos (Italia).
- Pan: Vapor (japonés) y Focaccia (italiano).',
	9,
	'CRT3111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	159,
	'Preparación',
	'Langosta marinada, picante de conejo y arroz con ajo, cordero arvejado y puré rústico, 
quinoa con leche y mango, helado de chumbeque y guayaba, catutos con rosa mosqueta, mini chapalele y mini churrascas.',
	1,
	'CRT4111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	160,
	'Evaluación',
	'Pulpo con vinagreta de aceituna azapa/empanada de prieta/queso de cabra; Pastel de jaibas en papa michuñe/arriero; cancato/puré de habas; sobrecostilla al pipeño/porotos granados; mote c/huesillos/helado de cola de mono.',
	2,
	'CRT4111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	161,
	'Evaluación',
	'Pulpo con vinagreta de aceituna azapa/empanada de prieta/queso de cabra; pastel
de jaibas en papa michuñe/arriero; cancato/puré de habas; sobrecostilla al pipeño/porotos granados; mote c/huesillos/helado de cola de mono.',
	3,
	'CRT4111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	162,
	'Preparación',
	'Mini chacarero/causeo de atún y cochayuyo; arrollado de huaso/pequén c/queso; 
pescado del día/arroz al ajo; ccostillar de cerdo/cremoso de motemei; leche nevada/helado de frutillas c/menta.',
	4,
	'CRT4111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	163,
	'Evaluación',
	'Mini chacarero/causeo de atún y cochayuyo; Arrollado de huaso/pequén c/queso; pescado del día/arroz al ajo; Costillar de cerdo/cremoso de motemei; Leche nevada/helado de frutillas c/menta.',
	5,
	'CRT4111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	164,
	'Evaluación guiada',
	'Chupe de setas/pebre de piure; Pulmay/empanadita de mariscos c/queso; Pescado del día/puré de lentejas: Asado de tira/pastelera de choclos c/albahaca; Pie de turrón de vino/helado de papaya.',
	6,
	'CRT4111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	165,
	'Evaluación guiada',
	'Mini sánguche pescado frito/lengua de vacuno; Caldillo de congrio/empanadta 
de charqui; Plateada de cerdo/porotos pallares; Costillas de cordero/charquicán; Mousse de chirimoya alegre y queso de cabra/helado de carmenere y berries.',
	7,
	'CRT4111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	166,
	'Evaluación guiada',
	'Tártaro de centolla/macha con queso, merluza ahumada/huevas de pescado fritas, 
Congrio frito/salsa camarón mailon, Mini parrilla, Leche asada/helado de arándano, limón y menta',
	8,
	'CRT4111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	167,
	'Evaluación final',
	'Pulpo con vinagreta de aceitunas de azapa, empanadita de prieta/queso de cabra, 
Merluza ahumada, huevas de pescado frita, congrio frito, cordero y charquicán, Mousse de chirimoya alegre',
	9,
	'CRT4111');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	168,
	'Inducción',
	'El instructor realizara una masa de pan para luego se replicada por los alumnos.',
	1,
	'PRT1131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	169,
	'Panes nacionales',
	'Pan amasado / Tortillas con chicarrones',
	2,
	'PRT1131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	170,
	'Evaluación',
	'Pan amasado, 1/2 receta por alumno',
	3,
	'PRT1131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	171,
	'Masas con materia grasa',
	'Hallullas/Bocados de dama/Dobladitas',
	4,
	'PRT1131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	172,
	'Masas soft',
	'Pan de molde blanco /Pan frica / Pan de completo',
	5,
	'PRT1131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	173,
	'Masas francesas o batidas',
	'Pan marraqueta / Rosita / Baguette',
	6,
	'PRT1131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	174,
	'Evaluación',
	'Marraqueta 1/2 receta por alumno',
	7,
	'PRT1131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	175,
	'Masas de larga fermentación',
	'Pan ciabatta / Pan toscano / Pan saborizado / Pan pita',
	8,
	'PRT1131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	176,
	'Masas integrales',
	'Pan molde integral / Integral individual / Centeno individual',
	9,
	'PRT1131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	177,
	'Masas dulces de levadura',
	'Conejos / Trenzas / Rollos de canela',
	10,
	'PRT1131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	178,
	'Masas dulces de levadura fritas',
	'Berlines / Donuts',
	11,
	'PRT1131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	179,
	'Evaluación',
	'Masa dulce de levadura (conejo, relleno con crema pastelera) 1/4 receta de masa, 1/4 receta crema pastelera)',
	12,
	'PRT1131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	180,
	'Masa de hoja',
	'Empanadas / Palmeras / Vol au vent / Bandas de manzanas',
	13,
	'PRT1131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	181,
	'Masa danesa - Croissant',
	'Danesa - Croissant',
	14,
	'PRT1131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	182,
	'Dulces chilenos',
	'Chilenitos/ Palitas / Alfajores / Príncipes / Tacitas',
	15,
	'PRT1131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	183,
	'Masas para dulces chilenos',
	'Sopaipillas / Sopaipillas pasadas / Calzones rotos / Picarones',
	16,
	'PRT1131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	184,
	'Examen',
	'Por definir',
	17,
	'PRT1131');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	185,
	'Preparación',
	'Batidos con materia grasa',
	1,
	'PRT2121');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	186,
	'Preparación',
	'Batidos sin materia grasa',
	2,
	'PRT2121');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	187,
	'Preparación',
	'Brazo de reina con manjar y crema chantilly
Brazo de reina con frutillas con manjar y crema chantilly
Brazo de reina con mermelada de guindas, manjar y crema chantilly                                                                                                                                                                                            Brazo de reina con piñas, manjar y crema chantilly ',
	3,
	'PRT2121');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	188,
	'Preparación',
	'Torta de bizcocho relleno con piñas   
Torta de bizcocho selva negra
Torta de bizcocho de amapolas, crema chantilly, manjar    
Torta de bizcocho de limón, relleno con chantilly y frutillas',
	4,
	'PRT2121');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	189,
	'Evaluación',
	'Brazo de reina Selva Negra',
	5,
	'PRT2121');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	190,
	'Preparación',
	'Galletas crujientes, aromatizadas con vainilla, rellenas de mermelada y decoradas con cobertura
Galletas de chocholate mangueadas de chocolate                                                                                                                                                                                                                                         Galletas de parmesano y limon galletas troqueladas de chocolate galletas bicolores
Galletas bicolores ',
	6,
	'PRT2121');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	191,
	'Preparación',
	'Quiche lorraine
Quiche pollo con champiñones
Quiche vegetariano                                                                                                                                                                                                                                                                                                           Tartaletas de frutas
Pie de limón',
	7,
	'PRT2121');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	192,
	'Preparación',
	'Merengue italiano, Merengue frances y Merengue suizo',
	8,
	'PRT2121');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	193,
	'Evaluación',
	'Pie de limón',
	9,
	'PRT2121');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	194,
	'Preparación',
	'Masas amarillas',
	10,
	'PRT2121');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	195,
	'Preparación',
	'Masas escaldadas',
	11,
	'PRT2121');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	196,
	'Evaluación',
	'Masa escaldada',
	12,
	'PRT2121');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	197,
	'Preparación',
	'Flan de vainilla, Leche asada, Arroz con leche, Sémola con leche y creme brulee',
	13,
	'PRT2121');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	198,
	'Preparación',
	'Mousses',
	14,
	'PRT2121');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	199,
	'Preparación',
	'Cheesecake',
	15,
	'PRT2121');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	200,
	'Preparación',
	'Helados / Bavarois',
	16,
	'PRT2121');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	201,
	'Examen',
	'Examen por definir',
	17,
	'PRT2121');

insert into taller (
	id_taller,
	titulo_preparacion,
	detalle_preparacion,
	semana,
	sigla)
values (
	202,
	'Examen',
	'Examen práctico portafolio',
	1,
	'PTT6697');
/* Fin tabla: taller */

commit;


/* Inicio tabla: producto */
insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1,
	'Mitjans cacao 750cc bot.',
	28000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	2,
	'Mitjans café 750cc bot.',
	6490,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	3,
	'Mitjans cassis 750cc bot.',
	26000,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	4,
	'Mitjans triple sec 750cc bot.',
	6090,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	5,
	'Santa Ema reserva/odfjell aramador bot.',
	2599,
	5,
	7);

#N/D
insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	7,
	'450grs marca cuk',
	4800,
	5,
	0);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	8,
	'Aceite',
	3900,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	9,
	'Aceite de ajonjolí',
	3885.71428571429,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	10,
	'Aceite de canola o maravilla chef',
	8016,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	11,
	'Aceite de girasol',
	6000,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	12,
	'Aceite de maravilla',
	5100,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	13,
	'Aceite de oliva',
	8000,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	14,
	'Aceite de oliva 500 cc bot.',
	16000,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	15,
	'Aceite de oliva bot.',
	3900,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	16,
	'Aceite de palta',
	3900,
	3,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	17,
	'Aceite de sésamo',
	3600,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	18,
	'Aceite girasol',
	10000,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	19,
	'Aceite maravilla',
	3550,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	20,
	'Aceite para freir',
	8600,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	21,
	'Aceite pepita de uva',
	8700,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	22,
	'Aceite vegetal',
	9700,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	23,
	'Aceituna',
	8900,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	24,
	'Aceitunas azapa con carozo',
	9996,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	25,
	'Aceitunas azapa sin carozo',
	9200,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	26,
	'Aceitunas de azapa sin carozo',
	7807,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	27,
	'Aceitunas moradas',
	9257,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	28,
	'Aceitunas negra sin carozo',
	7600,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	29,
	'Aceitunas negras',
	9500,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	30,
	'Aceitunas negras sin carozo',
	10000,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	31,
	'Aceitunas sevillana',
	10796,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	32,
	'Aceitunas sevillanas sin carozo',
	8300,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	33,
	'Aceitunas sin carozo',
	1400,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	34,
	'Aceitunas verde',
	10796,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	35,
	'Aceitunas verde sin carozo',
	1100,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	36,
	'Aceitunas verdes',
	6100,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	37,
	'Aceitunas verdes sin carozo',
	2900,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	38,
	'Acelga',
	900,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	39,
	'Acetato de 4,5 cm',
	1300,
	6,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	40,
	'Aceto balsámico',
	1300,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	41,
	'Achicoria',
	1300,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	42,
	'Agua benedictino 1,5 lts. c/gas (libre de sodio) bot.',
	1133.33333333333,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	43,
	'Agua benedictino 1,5 lts. s/gas (libre de sodio) bot.',
	1990,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	44,
	'Agua con gas',
	4000,
	3,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	45,
	'Agua con gas 1,5 lts botella',
	2600,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	46,
	'Agua de coco lata de 500 cc',
	1200,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	47,
	'Agua mineral bidon benedictino',
	4000,
	3,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	48,
	'Agua mineral con gas',
	800,
	3,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	49,
	'Agua mineral con gas bot. 500 cc botella',
	750,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	50,
	'Agua mineral en bidon benedictino',
	1850,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	51,
	'Agua mineral sin gas',
	1850,
	3,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	52,
	'Agua mineral sin gas 1,5 lt benedictino bot',
	1850,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	53,
	'Agua mineral sin gas benedictino bidon ',
	1850,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	54,
	'Agua mineral sin gas bidon 4,5 lt',
	950,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	55,
	'Agua mineral sin gas bidon 4,5 lt ',
	950,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	56,
	'Agua mineral sin gas bot. 500 cc botella',
	1800,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	57,
	'Agua sin gas (1,5 lt) botella',
	9700,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	58,
	'Agua sin gas bidon 6lt',
	950,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	59,
	'Agua tónica de 1,5 lts botella',
	950,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	60,
	'Aguardiente o pisco',
	1800,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	61,
	'Ahumador',
	9700,
	1,
	10);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	62,
	'Ahumador para cristalería',
	0,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	63,
	'Ají ahumado pqtes.',
	0,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	64,
	'Ají amarillo en pasta, frasco de 205g fco',
	1550,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	65,
	'Ají amarillo fresco peruano, 3 uni.',
	2599,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	66,
	'Ají amarillo peruano o pasta',
	13500,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	67,
	'Ají cacho de cabra',
	13500,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	68,
	'Ají de color',
	1000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	69,
	'Ají en escabeche (ají oro)',
	15500,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	70,
	'Ají en pasta',
	15500,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	71,
	'Ají en pasta sin pepa',
	3000,
	2,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	72,
	'Ají japonés polvo',
	13500,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	73,
	'Ají mirasol, 2 unidades',
	15000,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	74,
	'Ají panca en pasta, frasco de 205g fco',
	20076,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	75,
	'Ají panca, 2 unidades',
	2599,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	76,
	'Ají pasta sin pepas',
	20076,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	77,
	'Ají rocoto, 1 unidad',
	3500,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	78,
	'Ají rocoto, 2 unidades',
	12500,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	79,
	'Ají rojo fresco',
	12500,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	80,
	'Ají rojo fresco (2-3 uni)',
	6500,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	81,
	'Ají rojo fresco, 1 unidad',
	6500,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	82,
	'Ají salsa',
	7500,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	83,
	'Ají verde',
	2607.25,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	84,
	'Ají verde chileno',
	2607.25,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	85,
	'Ají verde chileno fresco',
	2607.25,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	86,
	'Ají verde paq',
	2607.25,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	87,
	'Ajinomoto',
	1800,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	88,
	'Ajo',
	37667,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	89,
	'Ajo (1 cabeza)',
	9267,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	90,
	'Ajo (1 unidad)',
	9267,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	91,
	'Ajo (2 cabezas)',
	9276,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	92,
	'Ajo (3 cabezas)',
	9267,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	93,
	'Ajo (3 unidades)',
	9267,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	94,
	'Ajo cabeza',
	9267,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	95,
	'Ajo chilote',
	1036.36363636364,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	96,
	'Ajo diente',
	1000,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	97,
	'Ajo, 3 cabezas',
	1000,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	98,
	'Albahaca',
	9267,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	99,
	'Albahaca fresca',
	9267,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	100,
	'Albahaca fresca (mata)',
	9267,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	101,
	'Albahaca fresca (opciónal)',
	9267,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	102,
	'Albahaca fresca mata',
	1500,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	103,
	'Albahaca fresca paquete',
	2300,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	104,
	'Albahaca fresca pqt',
	1500,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	105,
	'Albahaca mata',
	1500,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	106,
	'Albahaca pqt',
	2300,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	107,
	'Albúmina',
	2300,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	108,
	'Albúmina polvo',
	4014.4,
	2,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	109,
	'Alcachofa baby',
	4014.4,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	110,
	'Alcachofas cóctel conserva',
	10700,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	111,
	'Alcachofas fresca',
	10700,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	112,
	'Alcaparras',
	10700,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	113,
	'Alcaparras frasco',
	7833.33333333333,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	114,
	'Alcaparras frasco de 140 grs',
	7833.33333333333,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	115,
	'Alcohol',
	7833.33333333333,
	3,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	116,
	'Alcohol 70°',
	7998,
	3,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	117,
	'Alcohol al 70 % con atomizador',
	7998,
	3,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	118,
	'Alcohol bot',
	7998,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	119,
	'Alcohol gel',
	7998,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	120,
	'Alga kombu',
	3600,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	121,
	'Alga nori paquetes',
	35000,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	122,
	'Algarrobina, jarabe',
	35000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	123,
	'Almeja fresca',
	12000,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	124,
	'Almejas chicas frescas',
	4000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	125,
	'Almejas congeladas',
	4000,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	126,
	'Almejas frescas',
	3000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	127,
	'Almejas pequeñas o almejas julianas 1kg',
	4000,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	128,
	'Almendras',
	4300,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	129,
	'Almendras efiladas',
	10132.25,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	130,
	'Almidón de maiz',
	7000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	131,
	'Almidón de maíz maicena',
	12000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	132,
	'Amapola',
	12000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	133,
	'Amaretto',
	18995,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	134,
	'Amaretto botella de 750 cc botella',
	22000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	135,
	'Amaretto disaronno',
	10000,
	3,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	136,
	'Amaretto disaronno bot',
	10000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	137,
	'Amargo angostura',
	10000,
	3,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	138,
	'Amargo angostura (botella es de 100 cc) botella',
	15500,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	139,
	'Amargo angostura bot',
	11990,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	140,
	'Amargo angostura bot.',
	11990,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	141,
	'Amargo de angostura bot.',
	11990,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	142,
	'Amarula cream 750cc (original) bot.',
	11990,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	143,
	'Anchoas',
	11990,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	144,
	'Anchoas lata',
	31000,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	145,
	'Anís estrellado frasco',
	6350,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	146,
	'Aperol botella',
	3179,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	147,
	'Apio',
	9000,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	148,
	'Apio (picado o vara)',
	2445,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	149,
	'Apio (vara o picado)',
	4780,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	150,
	'Apio (vara)',
	4780,
	2,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	151,
	'Apio fresco entero',
	4780,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	152,
	'Apio picado',
	4780,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	153,
	'Apio ramas',
	4780,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	154,
	'Apio vara',
	4780,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	155,
	'Apio varas',
	2226.66666666667,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	156,
	'Apricot brandy bot.',
	200,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	157,
	'Arándano',
	20000,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	158,
	'Arándanos',
	3500,
	2,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	159,
	'Arándanos (puratos)',
	3500,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	160,
	'Arándanos frescos',
	3500,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	161,
	'Arándanos frescos o congelados',
	9633,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	162,
	'Aros de Cebollas apanados bolsa de 400 grsmos cuisine bolsa ',
	3000,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	163,
	'Arrollado de huaso',
	840,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	164,
	'Arroz',
	1649,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	165,
	'Arroz arbóreo',
	3800,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	166,
	'Arroz arbóreo scotti o inverni',
	5379,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	167,
	'Arroz común',
	1699,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	168,
	'Arroz grado 1',
	1685.14285714286,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	169,
	'Arroz grado 2',
	2150,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	170,
	'Arroz para sushi',
	3200,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	171,
	'Arvejas congeladas',
	4020,
	1,
	4);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	172,
	'Arvejas partidas',
	2219,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	173,
	'Arvejas peladas frescas o congeladas',
	2219,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	174,
	'Asado de tira',
	13000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	175,
	'Asado de tira (formato regular)',
	13000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	176,
	'Asepcol',
	4835,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	177,
	'Asiento vacuno',
	11500,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	178,
	'Astillas madera frutal para ahumar',
	900,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	179,
	'Astillas o chips de madera',
	900,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	180,
	'Astillas o chipsde madera',
	900,
	1,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	181,
	'Atomizador',
	900,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	182,
	'Atún al aceite tarros',
	1300,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	183,
	'Atún fresco',
	1300,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	184,
	'Atún lomito latas',
	1300,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	185,
	'Avellanas chilenas tostadas',
	3800,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	186,
	'Avellanas europeas tostadas',
	3800,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	187,
	'Azafrán',
	5818666.66666667,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	188,
	'Azúcar',
	1466.66666666667,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	189,
	'Azúcar en cubo caja',
	2600,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	190,
	'Azúcar flor',
	2348.88888888889,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	191,
	'Azúcar flor IANSA',
	2400,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	192,
	'Azúcar granulada',
	1470.71428571429,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	193,
	'Azúcar granulada (opciónal)',
	1500,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	194,
	'Azúcar granulada blanca sachet',
	1500,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	195,
	'Azúcar granulada rubia sachet',
	1500,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	196,
	'Azúcar IANSA',
	1500,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	197,
	'Azúcar impalpable',
	2066,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	198,
	'Azucar invertido',
	3200,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	199,
	'Azúcar rubia',
	22333.3333333333,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	200,
	'Azúcar rubia (granulada o en cubos)',
	2198,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	201,
	'Azúcar rubia en cubos caja 420 gr',
	2198,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	202,
	'Azúcar rubia IANSA',
	2198,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	203,
	'Baguette',
	1200,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	204,
	'Baguette blanca',
	1200,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	205,
	'Baileys original (crema de whisky) 750cc bot.',
	16000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	206,
	'Bandeja de finas hierbas',
	4000,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	207,
	'Bandeja de mix finas hierbas (tomillo,salvia,orégano)',
	17500,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	208,
	'Bandeja de presentacion dorada o plateada 26 cm',
	880,
	5,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	209,
	'Bandeja de presentación dorada o plateada 26 cm',
	880,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	210,
	'Bandeja de presentacion dorada o plateada para brazo de reina',
	880,
	5,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	211,
	'Bandeja de presentacion doradas 20 cm',
	880,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	212,
	'Bandeja de presentación dorados/plateados 20 cm',
	880,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	213,
	'Bandeja huevos de codorniz (12 unid)',
	4000,
	5,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	214,
	'Bandeja mix de hierbas frescas (romero,tomillo,laurel)',
	17500,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	215,
	'Bandeja mix finas hierbas. (oregáno,tomillo,laurel)',
	17500,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	216,
	'Bandeja rectangular con blonda 15cm x 30 cm',
	17500,
	5,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	217,
	'Bandeja tomillo fresco',
	3000,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	218,
	'Bandejas',
	800,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	219,
	'Bandejas con blonda mediana/plato dorado',
	1500,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	220,
	'Bandejas de alumnio desechables c-18',
	1200,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	221,
	'Base de hamburguesas',
	729,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	222,
	'Bebida San Pellegrino naranja',
	1800,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	223,
	'Bebida cola 1 lt bot/lata',
	2000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	224,
	'Bebida fantasía - ginger ale',
	1800,
	3,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	225,
	'Bebida fantasía ginger ale',
	1800,
	3,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	226,
	'Belcolade selection amargo 70%',
	30000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	227,
	'Benedictine bot.',
	26000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	228,
	'Berenjenas',
	970,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	229,
	'Berenjenas baby',
	650,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	230,
	'Berenjenas mediana',
	970,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	231,
	'Berro hidropónico',
	8490,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	232,
	'Berro hidropónico o común',
	8490,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	233,
	'Berros',
	8490,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	234,
	'Berros común',
	8490,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	235,
	'Berros hidropónicos',
	8490,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	236,
	'Betarraga',
	1525,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	237,
	'Betarraga pqte',
	1525,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	238,
	'Bicarbonato ',
	900,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	239,
	'Bicarbonato de sodio',
	900,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	240,
	'Bolsa de aseo grande',
	100,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	241,
	'Bolsa de sellado al vacío gofradas',
	300,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	242,
	'Bolsa de sellado vacío rollo',
	4500,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	243,
	'Bolsa mix de hojas dole 150 grs',
	1500,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	244,
	'Bolsa pan molde 380 gr',
	2549,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	245,
	'Bolsa pan molde blanco',
	2549,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	246,
	'Bolsa pan molde blanco chico',
	2490,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	247,
	'Bolsa prepicada grande',
	2490,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	248,
	'Bolsa sellado vacío mediana',
	2490,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	249,
	'Bolsa vacío',
	2490,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	250,
	'Bolsas de aseo',
	2490,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	251,
	'Bolsas de aseo (2 medianas y 1 grande)',
	59.9,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	252,
	'Bolsas de basura',
	346.554794520548,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	253,
	'Bolsas de basura grande',
	346.554794520548,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	254,
	'Bolsas de basura pqtes.',
	139.9,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	255,
	'Bolsas de sellado al vacío gofradas',
	500,
	5,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	256,
	'Bolsas gofradas',
	600,
	5,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	257,
	'Bombilla negra o transparente',
	49.5,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	258,
	'Bombilla papel',
	49.5,
	5,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	259,
	'Bombillas',
	49.5,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	260,
	'Bombillas (papel o cartón)',
	49.5,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	261,
	'Bombillas de papel',
	50,
	5,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	262,
	'Bot 500 cc bot.',
	6000,
	5,
	0);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	263,
	'Botella de vidrio (1 litro)',
	460,
	5,
	10);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	264,
	'Botella Limones sucedáneo 500ml',
	2149,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	265,
	'Bourbon Jim Bean bot',
	16000,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	266,
	'Brandy',
	11990,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	267,
	'Brandy St. Remy',
	11990,
	3,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	268,
	'Brandy St. Remy bot',
	11990,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	269,
	'Brocheta bambú 15-20 cms',
	30,
	5,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	270,
	'Brochetas bambú twister',
	30,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	271,
	'Brochetas de bambú 12 cm',
	30,
	5,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	272,
	'Brócoli',
	1314,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	273,
	'Brócoli pequeño',
	1290,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	274,
	'Brote alfalfa o arveja',
	7933,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	275,
	'Brotes arvejas bandeja',
	7933,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	276,
	'Brotes diente de dragón',
	4500,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	277,
	'Browies pack de 4 unidades 140 grs. braunichoc',
	1690,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	278,
	'Brownie de chocolate pre mezcla marca selecta 350 grs.',
	2490,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	279,
	'Brownie de chocolate pre mezcla marca selecta 350 grs. caja',
	2229,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	280,
	'Brownie de chocolate premezcla marca selecta 350 grs',
	2229,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	281,
	'Cabello de ángel',
	2851.6,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	282,
	'Cabellos de ángel',
	2929,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	283,
	'Cabernet Franc (750 cc) botella',
	5390,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	284,
	'Cabernet Sauvignon (750 cc) botella',
	5390,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	285,
	'Cabernet Sauvignon 2019 concha y toro gran reserva bot',
	7500,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	286,
	'Cabernet Sauvignon 2020 concha y toro gran reserva bot',
	7500,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	287,
	'Cabernet Sauvignon 2021 concha y toro gran reserva bot',
	7500,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	288,
	'Cabernet Sauvignon bot.',
	6490,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	289,
	'Cabernet Sauvignon botella',
	2750,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	290,
	'Cabernet Sauvignon morande g.reserva/Casa Silva reserva bot.',
	6490,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	291,
	'Cabernet Sauvignon o Carmenere (750 cc) botella',
	6490,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	292,
	'Cacao amargo',
	9260,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	293,
	'Cacao amargo en polvo',
	9260,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	294,
	'Cacao amargo puratos',
	9260,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	295,
	'Cacao en polvo extra amargo puratos',
	9260,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	296,
	'Cacao en polvo puratos',
	9260,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	297,
	'Cacao polvo',
	9260,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	298,
	'Cacao polvo amargo purato',
	9260,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	299,
	'Cachaça 51 - 1000cc bot.',
	9260,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	300,
	'Cachaça botella',
	8000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	301,
	'Café en grano',
	13996,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	302,
	'Café en grano Café Cultura - Lavazza',
	13996,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	303,
	'Café grano entero',
	13996,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	304,
	'Café instantáneo',
	32000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	305,
	'Café polvo para preparar tarro.   50 grs',
	3000,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	306,
	'Café sobre individual',
	3000,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	307,
	'Café soluble sachet',
	3000,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	308,
	'Caja de jalea frutilla o frambuesa',
	2390,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	309,
	'Caja flan de vainilla 90 grs',
	939,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	310,
	'Caja flan sabor vainilla 90 grs.',
	889,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	311,
	'Caja garbanzos Wasil',
	1449,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	312,
	'Caja garbanzos Wasil de 380 grs',
	5354.5,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	313,
	'Caja jalea sabor frambuesa 90 grs',
	889,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	314,
	'Caja jalea sabor frambuesa de 100grs',
	780,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	315,
	'Caja panacota marca Ambrosoli 90 grs',
	980,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	316,
	'Caja panacota premezcla marca Ambrosoli 90 grs',
	898,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	317,
	'Caja Papas deshidratada Maggi de 250 grs.',
	2239,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	318,
	'Caja porotos Wasil',
	1449,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	319,
	'Caja premezcla mousse (sabores)',
	1230,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	320,
	'Caja puré deshidratado',
	2239,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	321,
	'Calamar vaina',
	12900,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	322,
	'Calamares',
	12900,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	323,
	'Calamares pequeños enteros (para rellenar)',
	12900,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	324,
	'Caldo de ave caluga',
	250,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	325,
	'Caldo de pescado bajo en sodio',
	250,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	326,
	'Caldo de verduras bajo en sodio',
	250,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	327,
	'Caldo deshidratado de pescado, 7grs',
	500,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	328,
	'Caldo pescado o crustáceos bajo sodio',
	500,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	329,
	'Callampa seca',
	35000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	330,
	'Callampas desidratadas',
	35000,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	331,
	'Callampas frescas u ostra',
	35000,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	332,
	'Callampas secas',
	10000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	333,
	'Caluga caldo verduras',
	250,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	334,
	'Camarón colita',
	22000,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	335,
	'Camarón ecuatorano',
	22000,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	336,
	'Camarón ecuatoriano 21/25',
	14000,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	337,
	'Camarón ecuatoriano 21/26',
	14000,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	338,
	'Camarón nailon (colita de camarón)',
	14000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	339,
	'Camarón nailon entero',
	14000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	340,
	'Camarones 100/200',
	14400,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	341,
	'Camarones 36/40',
	14400,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	342,
	'Camarones 36/40 pelados crudos',
	14400,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	343,
	'Camarones apanados bolsa 500 grs cuisine bolsa',
	5272,
	5,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	344,
	'Camarones apanados bolsa 500 grs cuisine bolsa ',
	5272,
	5,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	345,
	'Camarones colitas',
	17000,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	346,
	'Camarones ecuatorianos',
	15500,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	347,
	'Camarones nacionales',
	9000,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	348,
	'Camote blanco',
	1490,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	349,
	'Camote blanco común',
	1490,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	350,
	'Camote naranja',
	2790,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	351,
	'Campari 750 cc bot.',
	2790,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	352,
	'Campari bot',
	12000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	353,
	'Campari botella',
	15100,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	354,
	'Canela en en polvo',
	49177.7272727273,
	2,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	355,
	'Canela en en rama',
	106544.888888889,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	356,
	'Canela en polvo',
	55791,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	357,
	'Canela en rama',
	114238,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	358,
	'Canela en rama sobre',
	769,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	359,
	'Canela molida',
	769,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	360,
	'Cápsula diseño ojal 5 cm de diametro',
	260,
	5,
	10);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	361,
	'Caracoles de mar cuello negro',
	5799,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	362,
	'Carcasas de pollo',
	2000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	363,
	'Cardamomo',
	113962,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	364,
	'Cargas para sifón',
	12000,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	365,
	'Carignan (750 cc) botella',
	5940,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	366,
	'Carignan bot.',
	6390,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	367,
	'Carignan casaspatronales bot.',
	6390,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	368,
	'Carmenere (750 cc) botella',
	8000,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	369,
	'Carmenere 2019 Casa Silva gran reserva bot',
	8000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	370,
	'Carmenere 2020 Casa Silva gran reserva bot',
	8000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	371,
	'Carmenere 2021 Casa Silva gran reserva bot',
	7500,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	372,
	'Carne de jaiba',
	23000,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	373,
	'Carne de soya texturizada',
	4158,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	374,
	'Carne de vacuno (posta molida)',
	11000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	375,
	'Carne molida',
	9932,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	376,
	'Carne molida de cordero o vacuno',
	8500,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	377,
	'Carne molida de vacuno',
	9540,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	378,
	'Castaña cajú',
	19000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	379,
	'Cebollas',
	934.48275862069,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	380,
	'Cebollas blanca',
	775,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	381,
	'Cebollas común',
	1300,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	382,
	'Cebollas en escabeche',
	1300,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	383,
	'Cebollas grandes',
	600,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	384,
	'Cebollas medianas',
	2500,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	385,
	'Cebollas monún',
	2500,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	386,
	'Cebollas morada',
	1695,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	387,
	'Cebollas pequeña',
	1695,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	388,
	'Cebollas perla',
	5476.66666666667,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	389,
	'Cebollas perla natural',
	2600,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	390,
	'Cebollín',
	1240,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	391,
	'Cebollín (2 atados)',
	1240,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	392,
	'Cebollín paquetes',
	1240,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	393,
	'Cebollín pqt',
	905,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	394,
	'Cebollín pqte',
	1240,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	395,
	'Cebollín, paquete de 3 unidades pqt',
	1000,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	396,
	'Cedrón fresco',
	980,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	397,
	'Centolla',
	42000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	398,
	'Cerezas en conserva sin carozo tarro',
	2000,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	399,
	'Cerezas marrasquino rojo',
	2000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	400,
	'Cerezas Marrasquino rojos (frasco chico)',
	2000,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	401,
	'Cerezas sin carozo en conserva tarro',
	2000,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	402,
	'Cerveza',
	1600,
	3,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	403,
	'Cerveza austral calafate de 330cc bot',
	1600,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	404,
	'Cerveza fermentada en barrica(curaca Kross) Kross bot',
	2500,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	405,
	'Cerveza golden ale Kross bot',
	1950,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	406,
	'Cerveza importada lata 330 cc lata',
	1600,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	407,
	'Cerveza ipa Royal Guard bot',
	1850,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	408,
	'Cerveza Kross 5 de 330 cc bot',
	1600,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	409,
	'Cerveza nacional lata 330 cc lata',
	1600,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	410,
	'Cerveza negra porter del puerto del puerto bot',
	1890,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	411,
	'Cerveza sin filtrar kutsmann bot',
	2010,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	412,
	'Chalotas',
	3666.66666666667,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	413,
	'Champiñones',
	2300,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	414,
	'Champiñones ostra',
	10087.5,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	415,
	'Champiñones parís',
	8477.41176470588,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	416,
	'Champiñones parís o portobello',
	7950,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	417,
	'Champiñones porto bello',
	10500,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	418,
	'Champiñones portobello',
	8490,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	419,
	'Champiñones shitake',
	18200,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	420,
	'Champiñoneses',
	1590,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	421,
	'Champiñoneses bandejas',
	1590,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	422,
	'Chancaca',
	6123,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	423,
	'Chancaca granulada',
	6123,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	424,
	'Chandelle de lúcuma',
	690,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	425,
	'Chardonnay (750 cc) botella',
	2990,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	426,
	'Chardonnay bot.',
	7250,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	427,
	'Chardonnay vino botella',
	4000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	428,
	'Charqui',
	1190,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	429,
	'Charqui (equino o cabra)',
	1190,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	430,
	'Charqui de vaca o cabra',
	1190,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	431,
	'Chartresusse verde 750 cc bot.',
	29000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	432,
	'Chascú',
	2500,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	433,
	'Chícharos/arvejas secas',
	1200,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	434,
	'Chips de chocolate real belga puratos',
	7500,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	435,
	'Chirimoya fresca',
	2000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	436,
	'Chispero',
	1500,
	5,
	10);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	437,
	'Chistorra o chorizo maduro',
	14200,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	438,
	'Choclo',
	3435,
	1,
	4);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	439,
	'Choclo congelado',
	3435,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	440,
	'Choclo congelado grano pqt',
	3435,
	5,
	4);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	441,
	'Choclo desgranado cong.',
	3435,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	442,
	'Choclo entero',
	1000,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	443,
	'Choclo morado, 2 a 3 unidades',
	4500,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	444,
	'Choclo patasca congelado',
	7725,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	445,
	'Choclo peruano desgranado',
	7725,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	446,
	'Choco transfer',
	3000,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	447,
	'Chococlate M&M 156 grs',
	3300,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	448,
	'Chocolate barra Sahne Nuss',
	3300,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	449,
	'Chocolate bitter',
	54000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	450,
	'Chocolate bitter belcolade 70%',
	54000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	451,
	'Chocolate en rama',
	1600,
	2,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	452,
	'Chocolate en rama caja, 1oo grs',
	1600,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	453,
	'Chocolate en rama costa caja',
	1600,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	454,
	'Chocolate semiamargo cobertura (monedas)',
	1600,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	455,
	'Chocolote en ramas costa cajita',
	1600,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	456,
	'Cholgas',
	6000,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	457,
	'Chorito fresco',
	3000,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	458,
	'Choritos congelados',
	5000,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	459,
	'Choritos frescos',
	1519,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	460,
	'Choritos latas de 190 gramos tarros',
	1519,
	5,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	461,
	'Choritos pequeños frescos',
	2800,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	462,
	'Chorizo artesanal jumbo paquete',
	4999,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	463,
	'Chostillas de cordero',
	9073,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	464,
	'Chuletas de centro',
	9073,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	465,
	'Chuletas de cerdo centro',
	9073,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	466,
	'Chuletas de cerdo parrilleras',
	9073,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	467,
	'Chumbeque',
	7000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	468,
	'Ciboulette',
	13222.2222222222,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	469,
	'Ciboulette (3 ataditos)',
	37500,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	470,
	'Ciboulette paquete',
	1000,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	471,
	'Ciboullete',
	1000,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	472,
	'Cilantro',
	4650,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	473,
	'Cilantro bandeja',
	4650,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	474,
	'Cilantro fresco',
	4650,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	475,
	'Cilantro paquete',
	1661.42857142857,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	476,
	'Cinsault (750 cc) botella',
	4690,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	477,
	'Cinsault de martino(viejas tinajas) bot.',
	7380,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	478,
	'Cinzano bianco 950cc bot.',
	5000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	479,
	'Clavo de olor',
	98000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	480,
	'Clavo de olor entero',
	98000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	481,
	'Clavo de olor sobre',
	459,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	482,
	'Cloro',
	1400,
	3,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	483,
	'CMC',
	2500,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	484,
	'Cobertura amarga carat',
	14000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	485,
	'Cobertura bitter',
	14000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	486,
	'Cobertura bitter 80%',
	14000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	487,
	'Cobertura bitter carat',
	14000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	488,
	'Cobertura blanca',
	8495,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	489,
	'Cobertura blanca carat',
	4500,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	490,
	'Cobertura blanca monedas puratos',
	4500,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	491,
	'Cobertura chocolate bitter',
	14000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	492,
	'Cobertura chocolate blanco',
	4500,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	493,
	'Cobertura coberlux bitter monedas puratos',
	4000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	494,
	'Cobertura semi amarga',
	4000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	495,
	'Cobertura semi amarga carat',
	4000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	496,
	'Coca Cola',
	1150,
	3,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	497,
	'Coca Cola (591 cc) botella',
	1150,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	498,
	'Coca Cola light',
	1150,
	3,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	499,
	'Coca Cola normal lata 330 cc lata',
	1150,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	500,
	'Coca Cola zero',
	1150,
	3,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	501,
	'Coca Cola zero 591 cc bot',
	1150,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	502,
	'Coca Cola zero lata 330 cc lata',
	1150,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	503,
	'Cochayuyo',
	2700,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	504,
	'Coco en cubo dulce',
	12000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	505,
	'Coco en escama',
	7500,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	506,
	'Coco rallado',
	9444.75,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	507,
	'Cofias desechables',
	500,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	508,
	'Cointreau',
	18000,
	3,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	509,
	'Cointreau 750cc Frances (licor de naranja) bot.',
	18000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	510,
	'Cointreau bot.',
	1800,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	511,
	'Cola de mono',
	4300,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	512,
	'Colador o chino',
	4000,
	5,
	10);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	513,
	'Colapez',
	129900,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	514,
	'Colapez en hojas',
	129900,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	515,
	'Colapez, 16 láminas',
	129900,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	516,
	'Colapez, 3 láminas',
	129900,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	517,
	'Colapez, 5 láminas',
	129900,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	518,
	'Coliflor',
	1645,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	519,
	'Colorante hidrosoluble',
	2490,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	520,
	'Colorante hidrosoluble frasco',
	2490,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	521,
	'Colorante liposoluble frasco',
	2490,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	522,
	'Colorante vegetal',
	2490,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	523,
	'Colorante vegetal (3 colores) cajita',
	2490,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	524,
	'Colorante vegetal, variedad',
	2490,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	525,
	'Comandas * (pedir en coordinación o bodega, según sede)',
	100,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	526,
	'Comino',
	20427.25,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	527,
	'Comino molido',
	20427.25,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	528,
	'Concentrado de tomate',
	6553.78571428571,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	529,
	'Concentrado de verduras',
	1700,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	530,
	'Conejo entero, granja',
	20000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	531,
	'Congrio dorado entero fresco',
	18500,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	532,
	'Congrio dorado fresco evicerado',
	16000,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	533,
	'Congrio entero fresco',
	12000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	534,
	'Congrio entero/merluza austral',
	15000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	535,
	'Coñac',
	8900,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	536,
	'Coñac Grand Marnier',
	60000,
	3,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	537,
	'Coñac Grand Marnier (cinta roja) 3/4 bot.',
	60000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	538,
	'Coñac Hennessy v.s. bot',
	52000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	539,
	'Coñac 3 palos bot',
	4000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	540,
	'Coñac botella',
	8000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	541,
	'Copas/vasos de catering',
	12000,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	542,
	'Costilla cordero, carré Francés',
	41500,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	543,
	'Costillar ahumado',
	20000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	544,
	'Costillar de cerdo',
	20000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	545,
	'Costillar de cerdo (desgrasado)',
	20000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	546,
	'Costillas de cordero',
	20000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	547,
	'Crema',
	3853.33333333333,
	3,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	548,
	'Crema Soprole',
	3853.33333333333,
	3,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	549,
	'Crema ácida',
	3853.33333333333,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	550,
	'Crema animal',
	4699,
	3,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	551,
	'Crema avellana/chocolate, Nutella',
	29335,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	552,
	'Crema de cacao blanca tres plumas',
	29335,
	3,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	553,
	'Crema de cacao oscura Mitjans',
	29335,
	3,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	554,
	'Crema de cassis',
	12000,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	555,
	'Crema de coco Cóco López lata',
	1500,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	556,
	'Crema de coco Deyco, 160 ml',
	1500,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	557,
	'Crema de coco lata',
	1500,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	558,
	'Crema de coco sin azúcar añadida',
	3200,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	559,
	'Crema de espárragos deshidratada',
	700,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	560,
	'Crema de espárragos deshidratada sobre',
	700,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	561,
	'Crema de leche',
	2000,
	2,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	562,
	'Crema de leche Soprole',
	2000,
	3,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	563,
	'Crema de menta verde Mitjans',
	6000,
	3,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	564,
	'Crema de Papas deshidratada',
	700,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	565,
	'Crema de tomates deshidratada',
	687,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	566,
	'Crema de violeta routin - 1883 750 cc bot.',
	20000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	567,
	'Crema espesa',
	4500,
	3,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	568,
	'Crema fresca',
	4187.5,
	3,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	569,
	'Crema fresca Soprole',
	4187.5,
	3,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	570,
	'Crema líquida fresca',
	4187.5,
	3,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	571,
	'Crema para batir en tarro',
	4187.5,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	572,
	'Crema para cocinar',
	4300,
	3,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	573,
	'Crema pasionatta',
	4300,
	3,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	574,
	'Crema pastelera instantánea',
	2854.8,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	575,
	'Crema pastelera instantánea de 500grs',
	9474,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	576,
	'Crema pastelera premezcla',
	9474,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	577,
	'Crema vegetal',
	3923,
	3,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	578,
	'Crema vegetal passionata',
	3923,
	3,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	579,
	'Cubeteras de hielo de silicona six pack',
	5000,
	5,
	10);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	580,
	'Cubeteras de silicona six pack',
	5000,
	5,
	10);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	581,
	'Cubiertos plasticos o madera desechables: cuchillo,cuchara,tenedor.',
	37,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	582,
	'Cucharas desechables',
	1200,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	583,
	'Cuero de cerdo',
	3500,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	584,
	'Curaçao azul Mitjans',
	6800,
	3,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	585,
	'Curaçao azul botella',
	8000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	586,
	'Cúrcuma',
	27000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	587,
	'Curry',
	53000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	588,
	'Damasco turco',
	17000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	589,
	'Dátiles s/c',
	16000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	590,
	'Decantador',
	16000,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	591,
	'Decoración rodajas citricos deshidra caja',
	17500,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	592,
	'Demi glace pasta',
	15900,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	593,
	'Desengrasante',
	4986,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	594,
	'Desinfectante aerosol',
	1800,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	595,
	'Desinfectante de superficies',
	1800,
	3,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	596,
	'Desinfectante de verduras (aseplac)',
	3679,
	3,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	597,
	'Destilado Trakal bot',
	22000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	598,
	'Detergente',
	2600,
	3,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	599,
	'Diente de ajo',
	1000,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	600,
	'Diente de dragón',
	4500,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	601,
	'Diente de dragón bandeja',
	4500,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	602,
	'Dolcefruta piña',
	3800,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	603,
	'Drambuie',
	15500,
	3,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	604,
	'Dulce de membrillo',
	3156,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	605,
	'Durazno en conserva',
	5585,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	606,
	'Durazno en conserva latas',
	2100,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	607,
	'Durazno en conserva mitades lata',
	2100,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	608,
	'Durazno en conserva tarro',
	2129,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	609,
	'Duraznos',
	2129,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	610,
	'Duraznos en conserva en mitades tarro',
	3200,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	611,
	'El Abuelo',
	7490,
	5,
	0);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	612,
	'Embudo',
	700,
	5,
	10);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	613,
	'Encuestas de servicio * (ídem anterior)',
	100,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	614,
	'Endulzante en sachet',
	41.98,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	615,
	'Endulzante sachets',
	3500,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	616,
	'Endulzante stevia sachet',
	3500,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	617,
	'Eneldo',
	1700,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	618,
	'Ensalada toscana (dole) 300 grs',
	1990,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	619,
	'Entraña de vacuno/lomo liso o punta ganso',
	19000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	620,
	'Esencia de vainila',
	4550,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	621,
	'Esencia de vainilla',
	4550,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	622,
	'Esencia de vainilla espesales',
	4550,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	623,
	'Espárragos',
	3666.66666666667,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	624,
	'Espárragos frescos',
	3666.66666666667,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	625,
	'Espinaca',
	7950,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	626,
	'Espinaca hoja pequeña',
	7950,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	627,
	'Espinaca hojas',
	7950,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	628,
	'Espinacas',
	7694.14285714286,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	629,
	'Espinacas frescas',
	9000,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	630,
	'Espinacas hojas',
	9000,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	631,
	'Espinas de pescado',
	3500,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	632,
	'Esponja',
	312.392857142857,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	633,
	'Esponja abrasiva',
	312.392857142857,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	634,
	'Esponja abrasiva amarilla',
	312.392857142857,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	635,
	'Esponja abrasiva verde',
	240,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	636,
	'Esponja amarilla',
	180,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	637,
	'Esponja bonobril',
	180,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	638,
	'Esponja con abrasivo',
	312.392857142857,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	639,
	'Esponja de lavado amarilla',
	312.392857142857,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	640,
	'Esponja fibra verde',
	312.392857142857,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	641,
	'Esponja lavado y virrutilla (c/u)',
	312.392857142857,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	642,
	'Esponjas amarillas',
	380,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	643,
	'Espontex',
	525,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	644,
	'Espumadera',
	525,
	5,
	10);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	645,
	'Espumante Freixenet Asti o Mía bot',
	13000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	646,
	'Espumante asti Martini (750 cc) botella',
	13000,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	647,
	'Espumante Brut',
	5663,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	648,
	'Espumante Brut (salón comedor) bot.',
	5663,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	649,
	'Espumante Brut bot',
	5663,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	650,
	'Espumante Brut de 750 cc botella',
	5000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	651,
	'Espumante Brut nature viña mar metodo champenoise bot',
	5890,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	652,
	'Espumante Brut undurraga bot',
	5663,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	653,
	'Espumante cepa País Miguel Torres bot',
	11990,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	654,
	'Espumante demi sec (Valdivieso) bot',
	5790,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	655,
	'Espumante demi sec nacional 750cc bot.',
	5790,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	656,
	'Espumante demi-sec Valdivieso bot',
	5790,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	657,
	'Espumante prosseco de 750 cc botella',
	13000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	658,
	'Espumante rosé nacional 750cc bot.',
	13000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	659,
	'Esterillas de bodega',
	10000,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	660,
	'Fanta lata 330 cc lata',
	450,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	661,
	'Fernet bot',
	8500,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	662,
	'Fetuccinis 400grs pqt',
	9000,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	663,
	'Fetuccinis pqt',
	1289,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	664,
	'Fideo cabello ángel',
	2929,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	665,
	'Fideo de arroz ancho, cock brand',
	6664,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	666,
	'Fideo japonés, sarraseno color café',
	13500,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	667,
	'Fideo vermecelli chino de arroz',
	7814,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	668,
	'Fideos cabellos',
	2929,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	669,
	'Fideos de arroz (fetucchini) pqt',
	1719,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	670,
	'Fideos espirales de 400 grs pqt',
	1129,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	671,
	'Fideos rigati, canuto o corbatita',
	2823,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	672,
	'Filete',
	18000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	673,
	'Filete de atún',
	23000,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	674,
	'Filete de congrio',
	22380,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	675,
	'Filete de res',
	18000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	676,
	'Filete de Salmón fresco',
	22380,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	677,
	'Filete de vacuno',
	18845,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	678,
	'Filete, pescado fresco del dia',
	22380,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	679,
	'Filetes de salmón',
	22380,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	680,
	'Filetillo de pollo',
	11200,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	681,
	'Finas hierbas (bandeja)',
	17500,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	682,
	'Finas hierbas frescas',
	17500,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	683,
	'Finas hierbas mix (bandeja)',
	17500,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	684,
	'Finas hierbas mix (media bandeja)',
	17500,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	685,
	'Finas hierbas surtidas bandeja',
	17500,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	686,
	'Flores comestibles (paquete de 30 gramos) paquete',
	1290,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	687,
	'Flores comestibles bandeja',
	1300,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	688,
	'Flores comestibles bandeja 30 grs',
	1300,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	689,
	'Fondo crustáceo deshidratado',
	6999,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	690,
	'Fondo de alcachofa frasco',
	6999,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	691,
	'Fondo de ave deshidratado',
	6999,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	692,
	'Fondo de crustáceos deshidratado',
	6999,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	693,
	'Fondo de pescado',
	2000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	694,
	'Fondo de pescado bajo en sodio',
	6999,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	695,
	'Fondo de pescado o crustáceos',
	6999,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	696,
	'Fondo de verduras desh',
	10000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	697,
	'Fondo de verduras o ave',
	7000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	698,
	'Fondos de alcachofa en conserva',
	6899,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	699,
	'Frambuesa (puratos)',
	14000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	700,
	'Frambuesas',
	14000,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	701,
	'Frambuesas congelada',
	14000,
	1,
	4);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	702,
	'Frambuesas congeladas',
	18300,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	703,
	'Frambuesas fresca o congelada',
	18300,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	704,
	'Frambuesas frescas',
	18300,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	705,
	'Frambuesas frescas o congeladas',
	2300,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	706,
	'Frambuesas kg, 125g',
	75300,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	707,
	'Frambuesas liofilizadas',
	2992,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	708,
	'Frasco 380 grs. marca suk frascos',
	2992,
	5,
	0);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	709,
	'Frutillas',
	2992,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	710,
	'Frutillas (frescas o congeladas)',
	7937.14285714286,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	711,
	'Frutillas congeladas',
	7937.14285714286,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	712,
	'Frutillas fresca pote ',
	7937.14285714286,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	713,
	'Frutillas frescas',
	2500,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	714,
	'Frutillas frescas o congeladas',
	7963.75,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	715,
	'Frutilllas frescas',
	7890,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	716,
	'Frutos secos en lata o pote 300 grs',
	7937.14285714286,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	717,
	'Galleta Oreo paquetes',
	3200,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	718,
	'Galleta criollita (2 pqts)',
	13490,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	719,
	'Galletas de agua paquetes',
	13490,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	720,
	'Galletas de soda pqtes.',
	800,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	721,
	'Galletas de soda pqts ',
	800,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	722,
	'Galletas de vino (3 paquetes)',
	800,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	723,
	'Galletas pequeñas dulces criollita 100 grs',
	6475,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	724,
	'Galletas pequeñas saladas selz 85 grs',
	13490,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	725,
	'Garam masala',
	13000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	726,
	'Garbanzos',
	43000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	727,
	'Garbanzos pelados',
	3469.5,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	728,
	'Garbanzos remojados',
	3200,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	729,
	'Gargal/changle',
	3200,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	730,
	'Gaseosa ginger ale (1,5 lt) botella',
	3000,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	731,
	'Gaseosa ginger ale (1,5) botella',
	1810,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	732,
	'Gelatina sabor piña caja',
	1810,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	733,
	'Gewürztraminer bot.',
	10394.5,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	734,
	'Gewürztraminer(750 cc) botella',
	7500,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	735,
	'Gin Bombay 750 cc bot.',
	7500,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	736,
	'Gin bot.',
	17000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	737,
	'Ginger ale zero',
	12547.5,
	3,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	738,
	'Ginger beer Fentimans o Britvic',
	1810,
	3,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	739,
	'Glucosa',
	5000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	740,
	'Gordas buena calidad (20 unidades)',
	8900,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	741,
	'Gorro de chef',
	2200,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	742,
	'Granadina',
	1800,
	3,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	743,
	'Granadina Mitjans',
	6500,
	3,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	744,
	'Granadina Mitjans 900cc bot.',
	6500,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	745,
	'Granadina bot.',
	6500,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	746,
	'Granos de café (decoración)',
	6097.5,
	2,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	747,
	'Grasa de cerdo',
	17.2,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	748,
	'Grasa de cerdo (tocino blanco)',
	9200,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	749,
	'Grasa enpelle de cerdo',
	9200,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	750,
	'Guante vinilo o latex talla S o M par',
	9200,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	751,
	'Guantes caja',
	1057.77777777778,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	752,
	'Guantes de latex m pares',
	1057.77777777778,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	753,
	'Guantes de latex par',
	1057.77777777778,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	754,
	'Guantes quirúrgicos 100un caja',
	2359,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	755,
	'Guantes quirúrgicos talla S o M caja',
	1057.77777777778,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	756,
	'Guayaba fresca media madura',
	1057.77777777778,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	757,
	'Guinda marrasquino frasco 140 grs frasco',
	4800,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	758,
	'Habas congeladas',
	4800,
	1,
	4);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	759,
	'Harina',
	5438.75,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	760,
	'Harina de arroz',
	1831.07692307692,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	761,
	'Harina de avellanas o almendras',
	1831.07692307692,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	762,
	'Harina de avena',
	1831.07692307692,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	763,
	'Harina de centeno',
	4553,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	764,
	'Harina de trigo común',
	3000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	765,
	'Harina flor linderos',
	1831.07692307692,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	766,
	'Harina fuerte 10% a 13% proteínas',
	1831.07692307692,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	767,
	'Harina integral',
	1500,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	768,
	'Harina sin polvos',
	3000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	769,
	'Harina tostada',
	24042,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	770,
	'Helado de piña',
	2518,
	3,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	771,
	'Helado de vainilla',
	2900,
	3,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	772,
	'Hielo (en cubos)',
	2900,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	773,
	'Hielo rock cubos compactos',
	725,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	774,
	'Hierba buena',
	1500,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	775,
	'Higos frescos o secos',
	1100,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	776,
	'Higos secos',
	6800,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	777,
	'Hoja de betarraga',
	6800,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	778,
	'Hoja de betarraga pequeña',
	2900,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	779,
	'Hoja de mostaza morada',
	2900,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	780,
	'Hoja de parra, 1 fco c/70 unidades',
	2900,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	781,
	'Hojas de amaranto',
	6700,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	782,
	'Hojas de apio',
	2500,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	783,
	'Hojas de apio paq',
	2500,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	784,
	'Hojas de apio paquete hojas de apio',
	2500,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	785,
	'Hojas de betarraga chica',
	2500,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	786,
	'Hojas de capuccino (espuela galán)',
	2900,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	787,
	'Hojas de colapez laminas',
	4000,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	788,
	'Hojas de menta bandeja',
	1300,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	789,
	'Hojas de menta bandeja chica',
	8900,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	790,
	'Hojas de mostaza',
	8900,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	791,
	'Huacatay',
	2600,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	792,
	'Huachalomo',
	2700,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	793,
	'Huesillos descarozados en conserva frasco',
	13500,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	794,
	'Huesillos descorazonados en conservas (frasco de 425 grs)',
	2500,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	795,
	'Huesillos sin carozo',
	2500,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	796,
	'Hueso de pollo',
	2500,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	797,
	'Huesos de vacuno',
	3500,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	798,
	'Huevas frescas de pescado',
	3233.33333333333,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	799,
	'Huevo',
	4600,
	5,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	800,
	'Huevo de vacuno',
	290.714285714286,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	801,
	'Huevos',
	3500,
	5,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	802,
	'Huevos de codorniz',
	260.972222222222,
	5,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	803,
	'Huevos de codorniz bandeja',
	140,
	5,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	804,
	'Huevos de primera',
	400,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	805,
	'Humo líquido',
	4700,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	806,
	'Humo líquido (opciónal)',
	2700,
	3,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	807,
	'Individual blanco, papel',
	2700,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	808,
	'Infusión de boldo (en bolsitas)',
	150,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	809,
	'Isomalt',
	51.95,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	810,
	'Jabón de manos',
	16900,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	811,
	'Jalea frambuesa 90 grs',
	3600,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	812,
	'Jamón cerdo caramelado pluma',
	969,
	3,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	813,
	'Jamón de pavo trozo',
	9945,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	814,
	'Jamón de pierna cerdo acaramelado en trozo',
	9945,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	815,
	'Jamón pavo acaramelado pluma',
	9945,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	816,
	'Jamón pierna',
	9945,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	817,
	'Jamón pierna artesanal laminado',
	9945,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	818,
	'Jamón pierna laminado',
	9945,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	819,
	'Jamón planchado',
	9945,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	820,
	'Jamón sandwich',
	13500,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	821,
	'Jamón serrano',
	12000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	822,
	'Jamón serrano laminado',
	26490,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	823,
	'Jamón serrano laminado paqte ',
	26490,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	824,
	'Jamón serrano o proscuitto',
	2649,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	825,
	'Jamón serrano paqte',
	26490,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	826,
	'Jamón serrano trujillo',
	3890,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	827,
	'Jarabe de goma',
	47720,
	3,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	828,
	'Jarabe de goma bot.',
	4490,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	829,
	'Jarabe de goma botella',
	4490,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	830,
	'Jarabe de goma botella de 750 cc botella',
	4490,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	831,
	'Jarabe de granadina botella',
	6000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	832,
	'Jarabe goma endulzante bot',
	6000,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	833,
	'Jengibre',
	4490,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	834,
	'Jengibre en vinagre frasco',
	13750,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	835,
	'Jengibre fresco',
	13750,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	836,
	'Jengibre raíz',
	14360,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	837,
	'Jenjibre fresco',
	13600,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	838,
	'Jerez Tío Pepe 750 cc bot.',
	13600,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	839,
	'Jerez botella',
	18000,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	840,
	'Jugo boca ancha bot. 330 cc botella',
	18000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	841,
	'Jugo chicha morada deshidratado c/azúcar',
	500,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	842,
	'Jugo de arándanos (1,5 lt) botella',
	500,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	843,
	'Jugo de cramberries',
	1990,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	844,
	'Jugo de limón sucedáneo',
	3000,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	845,
	'Jugo de naranja',
	2169.5,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	846,
	'Jugo de naranja (florida)',
	1500,
	3,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	847,
	'Jugo de naranja buena calidad',
	1500,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	848,
	'Jugo de naranja caja',
	3500,
	3,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	849,
	'Jugo de naranja en polvo sobre',
	1890,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	850,
	'Jugo de naranja florida',
	1890,
	3,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	851,
	'Jugo de naranja natural 1,5 lt bot/caja',
	1890,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	852,
	'Jugo de piña',
	4000,
	3,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	853,
	'Jugo de piña o naranja',
	1890,
	3,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	854,
	'Jugo de tomate lata',
	1890,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	855,
	'Jugo de tomate tarro 300 ml',
	2000,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	856,
	'Jugo deshidratado (sobre sabores)',
	2000,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	857,
	'Jugo deshidratado sin azúcar',
	233,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	858,
	'Jugo en polvo sin azúcar',
	290,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	859,
	'Jugo en sobre sin azúcar',
	290,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	860,
	'Jugo naranja botella',
	290,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	861,
	'Jugo natural de piña',
	1890,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	862,
	'Kalhua',
	4000,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	863,
	'Kanikama',
	5800,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	864,
	'Katsuo bushi',
	2000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	865,
	'Ketchup',
	250000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	866,
	'Ketchup formato en sobre 100 grs.',
	3600,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	867,
	'Kirsch',
	3610,
	3,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	868,
	'Kirsch luxardo',
	28000,
	3,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	869,
	'Kirsch luxardo 750cc bot.',
	28000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	870,
	'Kiwi',
	3490,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	871,
	'Kross golden ale 300 cc bot',
	1200,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	872,
	'Langosta Juan Fernández viva',
	50000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	873,
	'Langostino grande 16 uni ó 36/40',
	17000,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	874,
	'Langostino grande, 16 uni',
	17000,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	875,
	'Langostinos enteros',
	17000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	876,
	'Lata atún lomo en agua',
	1300,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	877,
	'Lata de cerveza 500cc.',
	1500,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	878,
	'Late harvest blanco Casa Silva bot',
	4500,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	879,
	'Late havest tinto Portal del Alto bot',
	4500,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	880,
	'Laurel',
	20932.7142857143,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	881,
	'Lavalozas',
	1500,
	3,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	882,
	'Lavalozas de 500 cc',
	1500,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	883,
	'Leche',
	1375,
	3,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	884,
	'Leche Soprole',
	1375,
	3,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	885,
	'Leche condensada Nestlé',
	1839,
	3,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	886,
	'Leche condensada Nestlé tarro',
	1839,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	887,
	'Leche condensada (390gr)',
	1839,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	888,
	'Leche condensada lata',
	1839,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	889,
	'Leche condensada tarro',
	1839,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	890,
	'Leche condensada tarros',
	1839,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	891,
	'Leche de almendras',
	18499.5,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	892,
	'Leche de coco',
	1990,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	893,
	'Leche descremada',
	1200,
	3,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	894,
	'Leche en polvo',
	16000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	895,
	'Leche entera',
	1600,
	3,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	896,
	'Leche entera Soprole',
	1600,
	3,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	897,
	'Leche evaporada tarro',
	1849.5,
	5,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	898,
	'Leche líquida',
	1080,
	3,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	899,
	'Leche o crema',
	1200,
	3,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	900,
	'Lechuga costina',
	1395,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	901,
	'Lechuga escarola',
	1090,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	902,
	'Lechuga hidropónica',
	1090,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	903,
	'Lechuga Lollo green',
	1800,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	904,
	'Lechuga Lollo Rosa',
	1800,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	905,
	'Lechuga Lollo rossa',
	1700,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	906,
	'Lechuga Lollo rosse',
	1700,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	907,
	'Lechuga Lollo verde',
	1700,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	908,
	'Lechuga misuna morada',
	1700,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	909,
	'Lechuga mizuna',
	1700,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	910,
	'Lechuga mizuna morada',
	6000,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	911,
	'Lechuga mizuna roja',
	1700,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	912,
	'Lechuga mizuna verde',
	6000,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	913,
	'Lechuga tatsoi',
	6000,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	914,
	'Lengua de vacuno',
	7700,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	915,
	'Lentejas',
	2338.6,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	916,
	'Lentejas Martini (sin remojo)',
	2338.6,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	917,
	'Lentejas Wasil',
	2338.6,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	918,
	'Lentejas Wasil caja',
	1449,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	919,
	'Lentejas nuevas',
	2338.6,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	920,
	'Lentejas o chícharos',
	2338.6,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	921,
	'Levadura',
	16447.2,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	922,
	'Levadura fresca',
	16447.2,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	923,
	'Levadura instantánea',
	17580.75,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	924,
	'Levadura para vinos pqts',
	19192,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	925,
	'Levadura seca instantánea',
	13440,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	926,
	'Licor Frángelico bot',
	30000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	927,
	'Licor St. Germain bot',
	37000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	928,
	'Licor amaretto',
	30000,
	3,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	929,
	'Licor amarula bot',
	28000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	930,
	'Licor araucano bot',
	7000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	931,
	'Licor cola de mono bot',
	5900,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	932,
	'Licor de cacao botella',
	6500,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	933,
	'Licor de café',
	8000,
	3,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	934,
	'Licor de café botella',
	8000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	935,
	'Licor de cassis botella',
	6000,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	936,
	'Licor de cassis, 500 ml botella',
	6000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	937,
	'Licor de cerezas Kirsch',
	5000,
	3,
	7);

#N/D
insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	939,
	'Licor de manzana bot',
	7800,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	940,
	'Licor de menta botella',
	6200,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	941,
	'Licor de oro bot',
	8000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	942,
	'Licor enguindado bot',
	5500,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	943,
	'Lima',
	3200,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	944,
	'Lima o Limones sutil',
	3200,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	945,
	'Limones',
	1695.90909090909,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	946,
	'Limónes',
	1700,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	947,
	'Limones amarillo',
	1600,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	948,
	'Limones amarillos',
	1600,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	949,
	'Limones chilenos',
	1600,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	950,
	'Limones comunes',
	1690,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	951,
	'Limones comunes (salón comedor)',
	1690,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	952,
	'Limones de pica',
	3296.66666666667,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	953,
	'Limones de pica (salón comedor)',
	3296.66666666667,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	954,
	'Limones sutil',
	3850,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	955,
	'Limones sutil (salón comedor y cocina)',
	3850,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	956,
	'Limones sutil o lima',
	3000,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	957,
	'Limpiavidrios',
	2500,
	3,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	958,
	'Líquido limpiador pisos',
	3200,
	3,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	959,
	'Locos cocidos',
	35000,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	960,
	'Lollo green',
	1700,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	961,
	'Lollo Rosa',
	1700,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	962,
	'Lomo liso',
	16000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	963,
	'Lomo liso de vacuno',
	16000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	964,
	'Lomo vetado de vacuno',
	22000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	965,
	'Longaniza',
	9595,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	966,
	'Longanizas',
	9595,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	967,
	'Longanizas ahumada',
	9595,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	968,
	'Longanizas buena calidad',
	9595,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	969,
	'Longanizas buena calidad (20 unidades)',
	9595,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	970,
	'Longanizas buena calidad, 20 u',
	12760,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	971,
	'Luche',
	12000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	972,
	'Lychee lata 400 gr lata',
	5400,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	973,
	'Lychees, 1 tarro 565 grs',
	5400,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	974,
	'Lyches en conserva latas',
	3000,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	975,
	'Machas',
	8000,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	976,
	'Machas en conserva en aceite 190 gramos lata',
	8000,
	5,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	977,
	'Machas frescas',
	8000,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	978,
	'Maestra horneo',
	6800,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	979,
	'Magret de pato, 9 unidades',
	49500,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	980,
	'Maicena',
	12345.0909090909,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	981,
	'Malaya de cerdo',
	13500,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	982,
	'Malbec Caliterra reserva/la ronciere bot.',
	6950,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	983,
	'Malbec (750 cc) botella',
	6950,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	984,
	'Mandarina grande',
	2497,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	985,
	'Mandarina, 4-5 unidades',
	2497,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	986,
	'Mangas desechables 30 cm',
	600,
	5,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	987,
	'Mango congelado',
	4500,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	988,
	'Mango fresco',
	4500,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	989,
	'Mango fresco maduro',
	4500,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	990,
	'Maní',
	3375,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	991,
	'Maní confitado',
	5200,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	992,
	'Maní tostado pelado',
	3375,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	993,
	'Maní tostado sin sal',
	6300,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	994,
	'Manjar',
	4621.5,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	995,
	'Manjar Nestlé',
	4800,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	996,
	'Manjar Nestlé o Fundo Los Alerces',
	4800,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	997,
	'Manjar pastelero',
	4800,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	998,
	'Manjar pastelero Nestlé',
	4800,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	999,
	'Manjar pastelero Nestlé o Fundo Los Alerces',
	4800,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1000,
	'Manteca',
	2500,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1001,
	'Manteca de cerdo',
	2500,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1002,
	'Manteca hidrogenada',
	8000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1003,
	'Manteca vegetal',
	8995,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1004,
	'Manteca vegetal hidrogenada',
	6610.625,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1005,
	'Mantequilla',
	10931.1666666667,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1006,
	'Mantequilla (ghee)',
	10931.1666666667,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1007,
	'Mantequilla con sal',
	10548.4444444444,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1008,
	'Mantequilla con sal 250gr',
	10931.1666666667,
	5,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1009,
	'Mantequilla de maní',
	18000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1010,
	'Mantequilla sin sal',
	14037.25,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1011,
	'Mantequilla sin sal Soprole',
	14037.25,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1012,
	'Manzanas pink lady (1 unidad)',
	2690,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1013,
	'Manzanas pink lady o verdes',
	2690,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1014,
	'Manzanas rojas',
	2423.33333333333,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1015,
	'Manzanas verdes',
	2735.71428571429,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1016,
	'Manzanas verdes frescas',
	1345,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1017,
	'Manzanas verdes o fuji',
	1345,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1018,
	'Maqui congelado,deshidratado o fresco',
	20000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1019,
	'Maqui o cranberry',
	20000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1020,
	'Maracuyá fresco',
	3900,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1021,
	'Margarina de hoja',
	4650,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1022,
	'Margarina de horneo',
	10000,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1023,
	'Margarina de horneo Watt´s',
	10000,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1024,
	'Margarina horneo Watt´s',
	10000,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1025,
	'Margarina maestra hoja',
	10000,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1026,
	'Margarina maestra horneo',
	8500,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1027,
	'Mariscos congelados',
	8900,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1028,
	'Marraqueta',
	1095,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1029,
	'Marrasquino',
	21.4285714285714,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1030,
	'Marrasquino frasco 140 grs frasco',
	21.4285714285714,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1031,
	'Marrasquino frasco frasco',
	21.4285714285714,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1032,
	'Marrasquino frasco peq.',
	21.4285714285714,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1033,
	'Marrasquino rojo',
	21.4285714285714,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1034,
	'Marrasquino rojo frasco',
	21.4285714285714,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1035,
	'Marrasquino rojos',
	6000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1036,
	'Martini Rosso 750cc bot.',
	6000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1037,
	'Martini Rosso bot',
	6000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1038,
	'Martini bianco (dulce) botella',
	5700,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1039,
	'Martini dry botella',
	10000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1040,
	'Martini extra dry 955cc bot.',
	6000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1041,
	'Masa lista para lasaña 400grs carozzi pqt',
	3602.5,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1042,
	'Masa madre deshidratado (otentic)',
	18800,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1043,
	'Masa philo',
	5500,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1044,
	'Masa philo 300 grs pqte',
	5500,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1045,
	'Masa philo, 1 caja',
	16212,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1046,
	'Mata albahaca fresca mata',
	2300,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1047,
	'Mata apio',
	4780,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1048,
	'Mayonesa',
	4350,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1049,
	'Mayonesa Kraft',
	9209.2,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1050,
	'Mayonesa Kraft frasco de 397 grs',
	9209.2,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1051,
	'Mayonesa Supreme',
	7900,
	2,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1052,
	'Mayonesa Supreme o Kraft cc',
	7900,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1053,
	'Mayonesa blanca (Kraft)',
	9209.2,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1054,
	'Mejorador Baguette s-500 ultra puratos',
	18000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1055,
	'Mejorador marraqueta toupan plus puratos',
	18000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1056,
	'Melissa fresca',
	4200,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1057,
	'Menta (paquete de 30 gramos) paquete',
	990,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1058,
	'Menta bandeja',
	994,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1059,
	'Menta bandeja paq',
	1000,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1060,
	'Menta fresca',
	33000,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1061,
	'Menta fresca (salón comedor y cocina)',
	33000,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1062,
	'Menta fresca bandeja',
	990,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1063,
	'Menta fresca pqt',
	990,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1064,
	'Menta pqte',
	990,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1065,
	'Merkén',
	5000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1066,
	'Merkén ahumado',
	5000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1067,
	'Merlot (750 cc) botella',
	3200,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1068,
	'Merluza austral filete',
	7890,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1069,
	'Merluza común (40 unidades medianas)',
	7890,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1070,
	'Merluza común filete fresco',
	7890,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1071,
	'Merluza filete (20 uni grandes)',
	7890,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1072,
	'Mermelada Watt´s guinda 1kg. reposteria',
	1600,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1073,
	'Mermelada damasco',
	1600,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1074,
	'Mermelada de damasco Watt´s',
	1600,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1075,
	'Mermelada de durazno',
	1600,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1076,
	'Mermelada de frambuesa fruitfill',
	1600,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1077,
	'Mermelada de frutilla',
	1600,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1078,
	'Mermelada de guinda fruitfill',
	1600,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1079,
	'Mermelada de higos helios frasco 330 grs. fco',
	2079,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1080,
	'Mermelada de papaya fco ',
	3000,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1081,
	'Mermelada frasco',
	1679,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1082,
	'Mermelada frutilla',
	1600,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1083,
	'Mermelada la fruteria guinda ácida',
	1600,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1084,
	'Mermelada mora',
	1600,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1085,
	'Mermelada repostera de frambuesa',
	1600,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1086,
	'Mermelada rosa mosqueta',
	1600,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1087,
	'Micas ',
	2500,
	5,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1088,
	'Miel',
	38410.5,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1089,
	'Miel de abejas',
	9351,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1090,
	'Miel de palma',
	8000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1091,
	'Miel de papaya',
	12000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1092,
	'Mini brocheta bambù',
	3200,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1093,
	'Mini longanicillas',
	1800,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1094,
	'Mini pizza con choricillo cja de 10 unidades',
	3990,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1095,
	'Mini quiche de champignones cja de 10 unidades',
	3990,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1096,
	'Minis empanadas de pino congeladas paquetes',
	3990,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1097,
	'Minis empanadas de pino pqte',
	3990,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1098,
	'Mirín',
	15000,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1099,
	'Miroir',
	40000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1100,
	'Miroix',
	8000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1101,
	'Mix de hojas mix salad 150 grs cajitas ',
	1890,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1102,
	'Mix de sésamo',
	17500,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1103,
	'Mix finas hierbas bandeja',
	17500,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1104,
	'Mix finas hierbas frescas',
	17500,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1105,
	'Mix frutos del bosque congelados',
	17500,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1106,
	'Mix frutos secos',
	9090,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1107,
	'Mix hierbas (te) 20 unidades caja',
	17500,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1108,
	'Mix sésamo',
	17500,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1109,
	'Molde aluminio tartaleta 20 cms',
	6000,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1110,
	'Molde de aluminio para tartaleta',
	6000,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1111,
	'Moldes desechables cerecinados de 400 gr',
	600,
	5,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1112,
	'Mollejas',
	13000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1113,
	'Mondadiente (bolsita 50 uni) pqt',
	1250,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1114,
	'Mondadientes',
	1250,
	5,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1115,
	'Mondadientes 100un',
	1250,
	5,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1116,
	'Mondadientes bio ely',
	390,
	5,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1117,
	'Mondadientes cajita',
	1250,
	5,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1118,
	'Morande g.reserva/Casa Silva reserva bot.',
	6490,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1119,
	'Moras',
	18320,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1120,
	'Moras congeladas',
	18320,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1121,
	'Moras frescas o congeladas',
	18320,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1122,
	'Moscatel bot.',
	8200,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1123,
	'Mostacilla de colores',
	3500,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1124,
	'Mostaza',
	5636.8,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1125,
	'Mostaza antigua',
	5636.8,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1126,
	'Mostaza de de Dijon',
	16708.75,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1127,
	'Mostaza de Dijon',
	16708.75,
	2,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1128,
	'Mostaza de Dijon (molida)',
	16708.75,
	2,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1129,
	'Mostaza de Dijon frasco',
	16708.75,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1130,
	'Mostaza de Dijon frasco de 210 grs',
	16708.75,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1131,
	'Mostaza en formato en sobre de 100 grs.',
	6711,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1132,
	'Mostaza normal',
	6246,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1133,
	'Mote fresco',
	1400,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1134,
	'Mote trigo fresco',
	1400,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1135,
	'Motemei',
	11000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1136,
	'Mousse instantáneo sabor chocolate',
	1230,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1137,
	'Nabo blanco, mediano',
	1500,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1138,
	'Naranja (1 unidad)',
	1800,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1139,
	'Naranja Thompson',
	1878,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1140,
	'Naranjas',
	1878,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1141,
	'Naranjas medianas',
	360,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1142,
	'Nueces',
	17022.1666666667,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1143,
	'Nueces mariposa',
	27950,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1144,
	'Nueces partidas',
	19900,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1145,
	'Nueces pecanas o comúnes',
	24000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1146,
	'Nueces picadas',
	24000,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1147,
	'Nuez moscada',
	80034.4285714286,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1148,
	'Nuez moscada entera',
	90891,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1149,
	'Nuez moscada molida',
	24000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1150,
	'Olla o fondo (20 litros aprox)',
	0,
	5,
	10);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1151,
	'Oporto',
	4500,
	3,
	6);

#N/D
insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1153,
	'Oporto centenario',
	12500,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1154,
	'Orégano',
	23611.6666666667,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1155,
	'Orégano fresco',
	1400,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1156,
	'Orégano fresco paquete',
	2590,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1157,
	'Orégano seco',
	8000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1158,
	'Osborne 10 años, tawny Oporto 750 cc bot.',
	37000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1159,
	'Osobuco (200 grs)',
	2000,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1160,
	'Ostión con coral',
	28000,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1161,
	'Ostiones A',
	12600,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1162,
	'Ostiónes congelados',
	20000,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1163,
	'Ostras fresca caja 24 uni dades caja ',
	8390,
	5,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1164,
	'Otentic, suplemento puratos',
	22900,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1165,
	'País bot.',
	7200,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1166,
	'País salvaje J.Bouchon bot.',
	7200,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1167,
	'Palillos cóctel paq',
	390,
	5,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1168,
	'Palitos chinos desechables',
	50,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1169,
	'Palitos para sushi',
	50,
	5,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1170,
	'Palmito tarro',
	10500,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1171,
	'Palos de brochetas 12 o 15 cms',
	890,
	5,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1172,
	'Palos de chupete',
	500,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1173,
	'Palta',
	4990,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1174,
	'Palta firme/madura',
	4670,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1175,
	'Palta Hass',
	4670,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1176,
	'Palta hass medianas',
	4670,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1177,
	'Palta Hass, para sushi',
	4990,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1178,
	'Paltas maduras(firmes)',
	4670,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1179,
	'Pan París o Copihue',
	2800,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1180,
	'Pan Baguette',
	1200,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1181,
	'Pan Baguette grande',
	1200,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1182,
	'Pan Baguette la, popular',
	2500,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1183,
	'Pan básico hogaza, la popular',
	3700,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1184,
	'Pan brioch para hamburguesa',
	1800,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1185,
	'Pan Brioche para sandwich',
	1800,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1186,
	'Pan Brioche sandwich',
	1800,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1187,
	'Pan cóctel tapadito bolsa 400 grs',
	4500,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1188,
	'Pan croissant',
	2900,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1189,
	'Pan de molde',
	2500,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1190,
	'Pan de molde blanco (guagua)',
	2500,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1191,
	'Pan de molde guagua',
	2500,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1192,
	'Pan de molde integral',
	2500,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1193,
	'Pan de molde sándwich',
	2500,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1194,
	'Pan hoja pequeño redondo o rectangular',
	2500,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1195,
	'Pan italiano, ciabatta la popular',
	3700,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1196,
	'Pan libanés',
	6000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1197,
	'Pan marraqueta',
	412.5,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1198,
	'Pan molde blanco',
	1500,
	2,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1199,
	'Pan molde blanco láminas',
	1800,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1200,
	'Pan molde blanco pqt',
	2549,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1201,
	'Pan molde guagua',
	1900,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1202,
	'Pan molde guagua blanco grande',
	1900,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1203,
	'Pan molde guagua integral grande',
	1900,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1204,
	'Pan rallado',
	4737.86666666667,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1205,
	'Pan tapadito redondo',
	2500,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1206,
	'Panceta',
	1900,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1207,
	'Panceta ahumada',
	18000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1208,
	'Panceta ahumado laminado',
	19000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1209,
	'Panko',
	4400,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1210,
	'Paños esponja (spontex)',
	3000,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1211,
	'Paños para el piso',
	850,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1212,
	'Paños sacudir micro fibra',
	1100,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1213,
	'Paños spontex',
	3000,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1214,
	'Pañuelo desechable en caja chico',
	800,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1215,
	'Papas',
	1474.73684210526,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1216,
	'Papas amarilla peruana',
	4650,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1217,
	'Papas bandeja',
	1390,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1218,
	'Papas camote',
	1500,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1219,
	'Papas chachera',
	1800,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1220,
	'Papas chancheras',
	1800,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1221,
	'Papas desiree',
	1900,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1222,
	'Papas frita lays tarro 154 grs',
	1600,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1223,
	'Papas mediana, ojalá uniforme',
	1390,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1224,
	'Papas michuñe',
	2200,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1225,
	'Papas semilla',
	2290,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1226,
	'Papas yaganas',
	2200,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1227,
	'Papas yaganas, desiree o karu',
	2200,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1228,
	'Papas yaganass',
	2200,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1229,
	'Papaya confitada',
	3800,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1230,
	'Papaya en conserva',
	3800,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1231,
	'Papayas en almíbar (frasco chico)',
	3800,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1232,
	'Papayas en almíbar frasco grande',
	3800,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1233,
	'Papel',
	20400,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1234,
	'Papel absorbente rollo',
	2700,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1235,
	'Papel aluminio chico',
	8000,
	5,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1236,
	'Papel de arroz, hoja de arroz, 10 uni',
	11000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1237,
	'Papel de arroz, hoja de arroz, 8 uni',
	11000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1238,
	'Papel de guitarra',
	11000,
	5,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1239,
	'Papel de repaso rollo',
	1499,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1240,
	'Papel engrasado',
	1499,
	5,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1241,
	'Papel mantequilla pliego',
	444,
	5,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1242,
	'Papel secante rollo',
	1499,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1243,
	'Paprika',
	12000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1244,
	'Parmesano trozo',
	24000,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1245,
	'Pasas',
	6642.5,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1246,
	'Pasas corinto',
	6642.5,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1247,
	'Pasas rubias',
	8190,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1248,
	'Pasta ají rojo',
	1600,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1249,
	'Pasta de avellana Nutella',
	8000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1250,
	'Pasta de avellanas',
	8000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1251,
	'Pasta de curry amarillo',
	9800,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1252,
	'Pastelera de choclo congelada',
	4890,
	1,
	4);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1253,
	'Pastrami',
	26000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1254,
	'Pastrami laminado',
	26000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1255,
	'Pecheras plasticas',
	1200,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1256,
	'Pechuga de pollo',
	6376.33333333333,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1257,
	'Pechuga de pollo deshuesada',
	5519.625,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1258,
	'Pechuga de pollo o filetillo',
	11200,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1259,
	'Penca',
	15000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1260,
	'Pepinillo',
	3000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1261,
	'Pepinillo dill',
	3000,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1262,
	'Pepinillo frasco',
	3000,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1263,
	'Pepino',
	690,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1264,
	'Pepino ensalada',
	845,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1265,
	'Pepinos',
	500,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1266,
	'Pera',
	1990,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1267,
	'Pera firme',
	1990,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1268,
	'Pera firme (1 unidad)',
	1990,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1269,
	'Peras',
	1945,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1270,
	'Peras firmes, 3 unidades',
	1990,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1271,
	'Perejil',
	5804.54545454545,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1272,
	'Perejil crespo',
	5804.54545454545,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1273,
	'Perejil crespo bandeja',
	10714.2857142857,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1274,
	'Perejil crespo pqte',
	5804.54545454545,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1275,
	'Perejil mata',
	1000,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1276,
	'Perejil paquete',
	1678.57142857143,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1277,
	'Pernil de cerdo (asado o ahumado)',
	8990,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1278,
	'Pescado fresco del dia (congrio/reine.)',
	12000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1279,
	'Pescado fresco del día (filete)',
	12000,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1280,
	'Petazeta paquetes',
	1000,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1281,
	'Physalis',
	9450,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1282,
	'Physalis bandeja',
	9450,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1283,
	'Pickles',
	3700,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1284,
	'Pimentón',
	1400,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1285,
	'Pimentón amarillo',
	1600,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1286,
	'Pimentón conserva lata chica',
	1600,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1287,
	'Pimentón en conserva lata chica',
	1600,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1288,
	'Pimentón en conserva x 125 grs. lata',
	3000,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1289,
	'Pimentón rojo',
	1490,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1290,
	'Pimentón rojo fresco',
	1500,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1291,
	'Pimentón rojo grande',
	1000,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1292,
	'Pimentón rojo tarro',
	1000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1293,
	'Pimentón verde',
	1142.85714285714,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1294,
	'Pimienta',
	27000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1295,
	'Pimienta blanca molida',
	27000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1296,
	'Pimienta mapuche',
	27000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1297,
	'Pimienta negra',
	19500,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1298,
	'Pimienta negra en grano',
	27000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1299,
	'Pimienta negra en polvo, 15 grs',
	500,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1300,
	'Pimienta negra entera',
	27000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1301,
	'Pimienta negra molida',
	46177.3333333333,
	2,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1302,
	'Pimiento amarillo',
	9275,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1303,
	'Pimiento en conserva, lata pequeña',
	9275,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1304,
	'Pimiento rojo',
	1400,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1305,
	'Pimiento verde',
	9275,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1306,
	'Pinchos de bambú 10 cms bolsa',
	2200,
	5,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1307,
	'Pinchos de bambú medianos',
	2200,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1308,
	'Pinoli o nueces',
	19900,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1309,
	'Pinot noir (750 cc) botella',
	6380,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1310,
	'Pinot noir la ronciere cantoalba/ morande reserva bot.',
	6380,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1311,
	'Pinzas de madera pequeñas (perritos)',
	20000,
	5,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1312,
	'Piña',
	2445,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1313,
	'Piña , pelada',
	3500,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1314,
	'Piña caramelo',
	3490,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1315,
	'Piña caramelo grande',
	3490,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1316,
	'Piña conserva rodaja tarro',
	3500,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1317,
	'Piña en conserva de de 822 grs',
	3500,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1318,
	'Piña en conserva tarro',
	3500,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1319,
	'Piña madura',
	2445,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1320,
	'Piña natural',
	2445,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1321,
	'Piñones cocidos',
	2890,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1322,
	'Pipeño cacique bot.',
	6500,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1323,
	'Pipeño dulce',
	6500,
	3,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1324,
	'Pipoca',
	3000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1325,
	'Pisco',
	5200,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1326,
	'Pisco Alto del Carmen 35°',
	5200,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1327,
	'Pisco Espíritu del Elqui 40* trasparente bot',
	8090,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1328,
	'Pisco (aguardiente de uva) peruano  bot.',
	13800,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1329,
	'Pisco 35°',
	8831.66666666667,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1330,
	'Pisco añejado en roble - Mistral Nóbel 40° bot',
	6800,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1331,
	'Pisco bot',
	5200,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1332,
	'Pisco chañaral de carem 42°',
	9100,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1333,
	'Pisco chañaral de carne 35°',
	7900,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1334,
	'Pisco especial 35°',
	5820,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1335,
	'Pisco Nobel añejado 40° Mistral bot',
	8880,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1336,
	'Pisco pedro jimenez Mal Paso botella',
	9300,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1337,
	'Pisco peruano',
	12000,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1338,
	'Pisco peruano (750 cc) botella',
	6490,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1339,
	'Pisco peruano botella',
	20000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1340,
	'Pisco transparente - Alto del Carmen 40° bot',
	8100,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1341,
	'Pistacho pelado sin sal',
	23000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1342,
	'Pistachos pelados',
	23000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1343,
	'Pistachos pelados sin sal',
	23000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1344,
	'Pitilla',
	200,
	6,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1345,
	'Pitilla para bridar',
	200,
	6,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1346,
	'Piure sin peña',
	3000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1347,
	'Plátano barraganete, 2 unidades',
	2890,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1348,
	'Plátanos',
	1200,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1349,
	'Plátanos paq',
	1800,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1350,
	'Plátanos pequeños o comunes',
	1200,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1351,
	'Plateada de cerdo',
	6600,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1352,
	'Plateada vacuno',
	8000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1353,
	'Plato de presentación dorados/plateados individual 8 cm',
	600,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1354,
	'Platos de presentación dorados/plateados (individuales)',
	600,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1355,
	'Platos dorados/plateados 26 cms',
	600,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1356,
	'Platos plasticos chicos de 18 cms pqt',
	990,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1357,
	'Platos plasticos grandes pqt',
	990,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1358,
	'Pliego papel de mantequilla',
	320,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1359,
	'Pollo entero',
	12000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1360,
	'Pollo ganso',
	11000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1361,
	'Pollo pechuga con hueso descongelada',
	6000,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1362,
	'Polvos de hornear',
	9791.25,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1363,
	'Polvos de hornear puratos',
	9791.25,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1364,
	'Pomelo',
	945,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1365,
	'Poroto granado cong.',
	1449,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1366,
	'Poroto negro Wasil caja',
	1449,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1367,
	'Poroto pallar manchado (variedad)',
	1449,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1368,
	'Poroto rojo o blanco Wasil caja',
	1449,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1369,
	'Porotos granados Wasil',
	6459.66666666667,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1370,
	'Porotos granados congelados',
	6459.66666666667,
	1,
	4);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1371,
	'Porotos negros Wasil',
	1449,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1372,
	'Porotos verde frescos',
	1700,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1373,
	'Porotos verdes',
	3400,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1374,
	'Porotos verdes congelados',
	4219,
	1,
	4);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1375,
	'Porotos verdes frescos',
	4219,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1376,
	'Posta molida',
	10490,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1377,
	'Posta negra',
	10490,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1378,
	'Posta negra molida',
	10490,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1379,
	'Posta negra trozo',
	10490,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1380,
	'Posta rosada',
	14092,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1381,
	'Posta rosada molida',
	10490,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1382,
	'Postre (flan, jalea, similar)',
	350,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1383,
	'Postre (jalea, flan, similar)',
	350,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1384,
	'Postre tiramisu postres individuales de 100 grs prox',
	700,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1385,
	'Postre variedad (flan, jalea, etc)',
	470,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1386,
	'Postre variedad (flan, Yogur, etc)',
	470,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1387,
	'Pote plástico desechable para postre',
	339.666666666667,
	5,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1388,
	'Premezcla de brownie marca selecta 350 grs.',
	2229,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1389,
	'Premezcla de merengue',
	8106,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1390,
	'Premezcla muffins marca selecta 380 grs.',
	2229,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1391,
	'Prietas',
	9160,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1392,
	'Prietas buena calidad',
	9160,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1393,
	'Primavera de verduras',
	3425,
	1,
	4);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1394,
	'Primavera de verduras congelados',
	3425,
	1,
	4);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1395,
	'Prosciutto san daniele',
	31996,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1396,
	'Puerros',
	1100,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1397,
	'Pulpa chirimoya',
	13.5,
	1,
	4);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1398,
	'Pulpa de arándanos',
	13.5,
	1,
	4);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1399,
	'Pulpa de cerdo',
	4300,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1400,
	'Pulpa de chirimoya',
	13.5,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1401,
	'Pulpa de cordero con poca grasa',
	24500,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1402,
	'Pulpa de duraznos',
	2600,
	1,
	4);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1403,
	'Pulpa de frambuesa',
	2600,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1404,
	'Pulpa de frambuesa (salón comedor)',
	2600,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1405,
	'Pulpa de frutillas',
	2600,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1406,
	'Pulpa de guayaba',
	2600,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1407,
	'Pulpa de limón',
	2600,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1408,
	'Pulpa de lúcuma',
	2600,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1409,
	'Pulpa de mango',
	3866.66666666667,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1410,
	'Pulpa de maracuyá',
	2600,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1411,
	'Pulpa de maracuyá (uso mixto)',
	2600,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1412,
	'Pulpa de maracuyá, sabor peruano',
	6638,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1413,
	'Pulpa de melón tuna',
	2600,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1414,
	'Pulpa de papaya (opción jugo de papaya)',
	2600,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1415,
	'Pulpa de piña',
	2600,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1416,
	'Pulpa frambuesa',
	2600,
	1,
	4);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1417,
	'Pulpa frutilla',
	2600,
	1,
	4);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1418,
	'Pulpa guallarauco (chirimoya, mango y frambuesa)',
	4667,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1419,
	'Pulpa guallarauco (durazno, frambuesa y frutilla)',
	3800,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1420,
	'Pulpa guallarauco (durazno, frambuesa y piña)',
	3800,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1421,
	'Pulpa guallarauco (durazno, mango y maracuyá)',
	3866,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1422,
	'Pulpa guallarauco (frambuesa y limón)',
	3800,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1423,
	'Pulpa guallarauco (melón, frambuesa y mango)',
	3800,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1424,
	'Pulpa guallarauco (piña, frutilla y maracuyá)',
	3800,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1425,
	'Pulpa guallarauco Limón',
	3800,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1426,
	'Pulpa guayaba',
	3800,
	1,
	4);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1427,
	'Pulpa malón',
	3800,
	1,
	4);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1428,
	'Pulpa mango',
	3800,
	1,
	4);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1429,
	'Pulpa mango (salón comedor)',
	3800,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1430,
	'Pulpa papaya',
	3800,
	1,
	4);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1431,
	'Pulpo',
	14900,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1432,
	'Puré de lúcuma',
	10600,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1433,
	'Puré de lúcuma frasco 400 gr',
	10600,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1434,
	'Puré de Papas deshidratado',
	6499,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1435,
	'Puré en caja deshidratado Maggi 312 gr',
	2239,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1436,
	'Puré instantáneo',
	5200,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1437,
	'Queso azul',
	36900,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1438,
	'Queso azul paquete de 100 grs santa rosa',
	3119,
	5,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1439,
	'Queso azul santa rosa 100 grs pqte',
	3119,
	5,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1440,
	'Queso brie',
	32493,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1441,
	'Queso brie santa rosa',
	3369,
	5,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1442,
	'Queso cabra',
	22000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1443,
	'Queso cabra trozo',
	3500,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1444,
	'Queso camembert',
	30000,
	5,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1445,
	'Queso chanco',
	11000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1446,
	'Queso chanco laminado',
	11600,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1447,
	'Queso chanco trozo',
	11700,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1448,
	'Queso chedar laminado',
	2100,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1449,
	'Queso crema',
	10141,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1450,
	'Queso crema tipo philadelphia',
	10141,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1451,
	'Queso de cabra',
	18722,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1452,
	'Queso de cabra con Orégano',
	27327,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1453,
	'Queso de cabra fresco',
	25788.5,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1454,
	'Queso de cabra maduro',
	29500,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1455,
	'Queso de cabra maduro o seco',
	29500,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1456,
	'Queso de cabra no muy firme',
	29500,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1457,
	'Queso edam',
	26000,
	5,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1458,
	'Queso emmenthal',
	13500,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1459,
	'Queso fresco',
	6780,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1460,
	'Queso gauda',
	13000,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1461,
	'Queso gorgonzola',
	37660,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1462,
	'Queso gouda',
	13000,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1463,
	'Queso gouda laminado',
	13000,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1464,
	'Queso grana padano',
	28995,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1465,
	'Queso granulado para pizza',
	16500,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1466,
	'Queso Gruyère',
	22950,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1467,
	'Queso Gruyère santa rosa',
	25995,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1468,
	'Queso mantecoso',
	15000,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1469,
	'Queso mantecoso santa rosa',
	12698,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1470,
	'Queso mantecoso trozo',
	14000,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1471,
	'Queso mozzarella de búfala',
	32729,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1472,
	'Queso mozzarella de vaca',
	16245,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1473,
	'Queso parmesano',
	23897,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1474,
	'Queso parmesano (trozo)',
	63699,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1475,
	'Queso parmesano en trozo',
	63699,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1476,
	'Queso parmesano trozo',
	63699,
	2,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1477,
	'Queso rallado',
	15500,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1478,
	'Queso rallado sobre de 80 grs',
	1699,
	5,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1479,
	'Queso ricotta',
	17622.5,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1480,
	'Queso roquefort',
	46926.6666666667,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1481,
	'Quinoa',
	8796,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1482,
	'Quinoa mix',
	8796,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1483,
	'Quinoa roja',
	8796,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1484,
	'Rabanitos',
	1190,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1485,
	'Rábanos',
	1190,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1486,
	'Rama de apio',
	500,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1487,
	'Ramequines/ sufleteros/ timables ceramicos',
	0,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1488,
	'Reineta filete fresco',
	16290,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1489,
	'Reineta fileteada',
	16290,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1490,
	'Reineta fresca',
	6000,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1491,
	'Reineta fresca fileteada',
	8000,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1492,
	'Reineta limpia,fileteada',
	16290,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1493,
	'Reineta o corvina fresca filete',
	12500,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1494,
	'Repollo',
	1500,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1495,
	'Repollo blanco',
	1200,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1496,
	'Repollo morado',
	1200,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1497,
	'Ricotta',
	15000,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1498,
	'Riesling (750 cc) botella',
	7190,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1499,
	'Riesling bot.',
	7500,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1500,
	'Rollo absorbente',
	3400,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1501,
	'Rollo de bolsas prepicadas medianas',
	6579.90697674419,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1502,
	'Rollo de papel',
	6579.90697674419,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1503,
	'Rollo de papel absorbente 1',
	6579.90697674419,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1504,
	'Romero bandeja',
	7000,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1505,
	'Romero fresco',
	7000,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1506,
	'Ron',
	4855.71428571429,
	3,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1507,
	'Ron Havana Club añejo 3 años blanco 750 cc bot',
	4855.71428571429,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1508,
	'Ron Havana Club añejo 3 años blanco 750 cc bot.',
	4855.71428571429,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1509,
	'Ron Havana Club añejo especial 750cc bot',
	4855.71428571429,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1510,
	'Ron añejo Abuelo 5 años bot',
	4855.71428571429,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1511,
	'Ron blanco Havana Club',
	4855.71428571429,
	3,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1512,
	'Ron blanco bot',
	4855.71428571429,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1513,
	'Ron blanco bot.',
	4855.71428571429,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1514,
	'Ron blanco botella',
	4855.71428571429,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1515,
	'Ron de coco saborizado 750 cc botella',
	11000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1516,
	'Ron dorado',
	11000,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1517,
	'Rosé de Cabernet Sauvignon (750 cc) botella',
	12000,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1518,
	'Rose la ronciere bot.',
	6500,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1519,
	'Rúcula',
	6600,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1520,
	'Rúcula baby',
	8600,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1521,
	'Sake',
	15000,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1522,
	'Sake (tozai, 720 cc) botella',
	26800,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1523,
	'Sal',
	783.6,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1524,
	'Sal cahuil',
	3500,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1525,
	'Sal común',
	800,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1526,
	'Sal de apio frasco',
	25,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1527,
	'Sal de apio, 100 grs / fco frasco',
	25,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1528,
	'Sal de mar',
	3500,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1529,
	'Sal de mar cahuil',
	3500,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1530,
	'Sal fina común',
	800,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1531,
	'Sal gruesa',
	1000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1532,
	'Salame petit trozo',
	12000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1533,
	'Salchichas gordas',
	11796,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1534,
	'Salmón',
	51900,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1535,
	'Salmón ahumado',
	51900,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1536,
	'Salmón ahumado interfoliado',
	22380,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1537,
	'Salmón filete',
	22380,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1538,
	'Salmón filete fresco',
	22380,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1539,
	'Salmón fileteado',
	18790,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1540,
	'Salmón fresco evicerado',
	20000,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1541,
	'Salmón fresco, entero',
	16000,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1542,
	'Salsa americana pickle',
	1800,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1543,
	'Salsa de caramelo',
	4691,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1544,
	'Salsa de ostión u ostras',
	12000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1545,
	'Salsa de ostra u ostión',
	12000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1546,
	'Salsa de pescado',
	9700,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1547,
	'Salsa de soya',
	11833.3333333333,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1548,
	'Salsa de soya kikkoman o coreana',
	13000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1549,
	'Salsa de tamarindo',
	15000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1550,
	'Salsa de tomates',
	3128.8,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1551,
	'Salsa de tomates italiana',
	2816.5,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1552,
	'Salsa española',
	12300,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1553,
	'Salsa española deshidratada',
	13457.1428571429,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1554,
	'Salsa española o Demi-Glace deshidratada',
	5000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1555,
	'Salsa inglesa',
	17085,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1556,
	'Salsa inglesa frasco de 150 cc frasco',
	3000,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1557,
	'Salsa tomate',
	2633,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1558,
	'Salvado de trigo fino',
	6000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1559,
	'Sauvignon Blanc (750 cc) botella',
	2790,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1560,
	'Sauvignon Blanc bot',
	6000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1561,
	'Sauvignon Blanc bot.',
	7250,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1562,
	'Sauvignon Blanc botella',
	2790,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1563,
	'Sauvignon Blanc tabali pedregoso/viñamar del año bot.',
	7000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1564,
	'Sazonador deshidratado',
	250,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1565,
	'Selladoras al vacío',
	0,
	5,
	10);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1566,
	'Semilla de amapola',
	21000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1567,
	'Semilla de anís',
	14500,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1568,
	'Semillas de sésamo tostado',
	14500,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1569,
	'Sémola',
	3600,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1570,
	'Semolina',
	3150,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1571,
	'Semolina o sémola',
	3600,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1572,
	'Servilleta cóctel',
	519,
	5,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1573,
	'Servilleta cóctel pqtes.',
	519,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1574,
	'Servilleta restaurant',
	1500,
	5,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1575,
	'Servilletas cóctel paq',
	1500,
	5,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1576,
	'Servilletas descartables',
	6.98,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1577,
	'Servilletas papel 100 unid pqt',
	2589,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1578,
	'Servilletas paquete',
	1500,
	5,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1579,
	'Servilletas restaurant',
	1500,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1580,
	'Sésamo',
	14000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1581,
	'Sésamo blanco',
	14000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1582,
	'Sésamo negro',
	18000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1583,
	'Sésamo tostado',
	14000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1584,
	'Sifón',
	1000,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1585,
	'Sobre crema de Espárragos Maggi',
	529,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1586,
	'Sobre mermelada frutilla 250 grs.',
	1099,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1587,
	'Sobre queso parmesano rallado',
	1849,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1588,
	'Sobre sopas Maggi pollo con arroz',
	529,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1589,
	'Sobrecostilla',
	9890,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1590,
	'Sobrecostilla vacuno',
	9890,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1591,
	'Soda botella',
	1000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1592,
	'Solomillo de cerdo',
	5000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1593,
	'Sopa de pollo',
	525,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1594,
	'Spontex',
	652.608333333333,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1595,
	'Sprite (1,5 lt) botella',
	1600,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1596,
	'Sprite lata 330 cc lata',
	800,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1597,
	'Sprite light',
	1600,
	3,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1598,
	'Sprite zero (591 cc) botella',
	1150,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1599,
	'Sumake o sumac',
	45000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1600,
	'Surtido de mariscos',
	3200,
	1,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1601,
	'Surtido de mariscos cong',
	3200,
	3,
	3);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1602,
	'Syrah casas del bosque/leyda bot.',
	6500,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1603,
	'Tabali pedregoso/chocalan reserva bot.',
	6490,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1604,
	'Tabasco bot.',
	3800,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1605,
	'Tabasco frasco de 60 cc frasco',
	3800,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1606,
	'Takuan, rábano dulce encurtido',
	7500,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1607,
	'Tarro de leche condensada tarro',
	1600,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1608,
	'Tarro durazno en conserva mitades',
	5585,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1609,
	'Tarro en duraznos en mitades tarro',
	5585,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1610,
	'Tarro leche evaporada',
	1899,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1611,
	'Tarro piña en conserva',
	2199,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1612,
	'Tarros de piña en conserva tarro',
	2199,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1613,
	'Tatsoi',
	700,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1614,
	'Té Dilmah negro (en bolsitas)',
	77.96,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1615,
	'Té 20 unidades caja',
	880,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1616,
	'Té ahumado lapsang souchong (twinins en hojas)',
	880,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1617,
	'Té dilmah negro (en bolsitas)',
	880,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1618,
	'Té earl gray',
	880,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1619,
	'Té negro en bolsa',
	880,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1620,
	'Té negro en bolsa caja 20 un',
	880,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1621,
	'Té negro en hoja',
	35000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1622,
	'Té verde (en hoja)',
	14756,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1623,
	'Té verde en bolsa',
	880,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1624,
	'Té verde matcha',
	43000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1625,
	'Tegral satin cake puratos',
	15420,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1626,
	'Tequila José Cuervo reposado 750cc bot',
	14000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1627,
	'Tequila blanco El Jimador',
	14000,
	3,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1628,
	'Tequila blanco bot.',
	14000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1629,
	'Tequila blanco botella de 750 cc botella',
	15000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1630,
	'Tequila blanco el merendero blanco 1 litro x unidad c/u bot.',
	14000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1631,
	'Tequila botella',
	14000,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1632,
	'Termocirculadores',
	0,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1633,
	'Terrones de azúcar, 250 grs',
	3.4,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1634,
	'Tinta calamar (frasco pequeño 90 grs)',
	70211,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1635,
	'Tocino',
	26611,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1636,
	'Tocino ahumado',
	25988.8,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1637,
	'Tocino ahumado laminado',
	25988.8,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1638,
	'Tocino laminado',
	26611,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1639,
	'Tofu a granel',
	8900,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1640,
	'Tomate',
	1737.77777777778,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1641,
	'Tomate cherry',
	5980,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1642,
	'Tomate cherry amarillo',
	6700,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1643,
	'Tomate cherry amarillo o mix',
	6700,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1644,
	'Tomate cherry morado',
	6700,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1645,
	'Tomate cherry pera',
	6700,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1646,
	'Tomate cherry rojo',
	5904,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1647,
	'Tomate deshidratado',
	19100,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1648,
	'Tomate en conserva, 1 tarro',
	4223,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1649,
	'Tomate limache',
	1921.42857142857,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1650,
	'Tomate Machalí',
	1921.42857142857,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1651,
	'Tomate Machalí maduro',
	1921.42857142857,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1652,
	'Tomate pera',
	2388.88888888889,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1653,
	'Tomate rocky',
	1921.42857142857,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1654,
	'Tomates',
	1812,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1655,
	'Tomates maduros',
	2500,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1656,
	'Tomates maduros firmes',
	1800,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1657,
	'Tomillo',
	1890,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1658,
	'Tomillo bandeja',
	1890,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1659,
	'Tomillo fresco',
	16000,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1660,
	'Torta milhojas 20 personas',
	18990,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1661,
	'Torta panqueques naranja',
	18990,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1662,
	'Torta tres leches 20 personas',
	18990,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1663,
	'Tortillas mexicanas medianas pqt',
	2290,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1664,
	'Transfer',
	2500,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1665,
	'Transfer colorido',
	2500,
	5,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1666,
	'Transfer diseños',
	2500,
	5,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1667,
	'Trapero',
	818.166666666667,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1668,
	'Trigo mote cocido',
	3200,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1669,
	'Triple sec',
	7900,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1670,
	'Triple sec Mitjans',
	7900,
	3,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1671,
	'Triple sec botella',
	6445,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1672,
	'Truto de pollo entero',
	3890,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1673,
	'Trutro de pollo',
	3890,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1674,
	'Trutro de pollo entero (40 unidades)',
	3890,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1675,
	'Tumbo',
	3500,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1676,
	'Uva roja o verde s/pepas',
	6990,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1677,
	'Uvas frescas blancas',
	2000,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1678,
	'Uvas frescas tintas',
	2000,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1679,
	'Vaina de vainilla',
	4000,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1680,
	'Vaina líquida',
	4000,
	3,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1681,
	'Vaina vainilla',
	4000,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1682,
	'Vainilla escencia',
	4000,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1683,
	'Vainilla líquida',
	8900,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1684,
	'Vainilla líquida, edra',
	12000,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1685,
	'Vainilla vaina',
	4000,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1686,
	'Vara de apio',
	300,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1687,
	'Varilla bambú o mini brocheta 12 0 15 cm',
	12000,
	5,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1688,
	'Vasos descartables pequeños pqt',
	2390,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1689,
	'Vasos plásticos chicos transparentes',
	500,
	5,
	8);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1690,
	'Verduras primavera',
	3425,
	1,
	4);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1691,
	'Vermouth Rosso bot',
	5590,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1692,
	'Vermouth Rosso botella',
	5590,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1693,
	'Vermut Rosso bot',
	5590,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1694,
	'Vienesas (sureñas) (25 unidades) paquete',
	6000,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1695,
	'Vinagre balsámico',
	8853.33333333333,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1696,
	'Vinagre blanco',
	2415.33333333333,
	3,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1697,
	'Vinagre blanco (para agua termocirculador)',
	2690,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1698,
	'Vinagre blanco 1lt bot.',
	2690,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1699,
	'Vinagre blanco 750cc bot.',
	2690,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1700,
	'Vinagre blanco cc',
	2690,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1701,
	'Vinagre de arroz',
	8000,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1702,
	'Vinagre de frambuesa',
	9500,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1703,
	'Vinagre de jerez',
	8000,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1704,
	'Vinagre de manzana',
	4490,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1705,
	'Vinagre de vino blanco',
	2690,
	3,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1706,
	'Vinagre rojo',
	3500,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1707,
	'Vinagre tinto',
	3500,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1708,
	'Vino blanco',
	2690.76923076923,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1709,
	'Vino blanco - cepa Chardonnay bot',
	2690.76923076923,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1710,
	'Vino blanco - cepa Gewürztraminer bot',
	2690.76923076923,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1711,
	'Vino blanco - cepa Moscatel viña choapa bot',
	2690.76923076923,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1712,
	'Vino blanco - cepa Riesling bot',
	2690.76923076923,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1713,
	'Vino blanco - cepa Viognier bot',
	2690.76923076923,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1714,
	'Vino blanco - ensamblaje (hecho con 2 cepas o más) bot',
	2690.76923076923,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1715,
	'Vino blanco cc',
	2690.76923076923,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1716,
	'Vino blanco económico (750 cc, con corcho) botella',
	2690.76923076923,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1717,
	'Vino cabernet franc 750cc bot.',
	2690.76923076923,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1718,
	'Vino carignan varietal 750cc bot.',
	2690.76923076923,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1719,
	'Vino carmenere reserva (salón comedor) bot.',
	2690.76923076923,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1720,
	'Vino carmenere reserva 750cc bot.',
	2690.76923076923,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1721,
	'Vino chardonnay reserva 750cc bot.',
	2690.76923076923,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1722,
	'Vino Espumante Brut (750 cc) botella',
	3999,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1723,
	'Vino Espumante Demi Sec (750 cc) botella',
	3999,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1724,
	'Vino Espumante rosado (750 cc) botella',
	5590,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1725,
	'Vino fortificado opción nacional u Oporto bot',
	2690.76923076923,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1726,
	'Vino gewürztraminer 750cc bot.',
	2690.76923076923,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1727,
	'Vino merlot reserva 750cc bot.',
	2690.76923076923,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1728,
	'Vino Oporto',
	8900,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1729,
	'Vino país  bot.',
	2690.76923076923,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1730,
	'Vino pinot gris 750cc bot.',
	2690.76923076923,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1731,
	'Vino pinot noir reserva (salón comedor) bot.',
	2690.76923076923,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1732,
	'Vino Pipeño',
	2690.76923076923,
	3,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1733,
	'Vino Pipeño blanco bot',
	2690.76923076923,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1734,
	'Vino Pipeño bot',
	2690.76923076923,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1735,
	'Vino reserva carmenere 750cc bot.',
	2690.76923076923,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1736,
	'Vino rosé 750cc  bot.',
	2690.76923076923,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1737,
	'Vino sauvignon blanc reserva 750cc bot.',
	2690.76923076923,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1738,
	'Vino syrah 750cc bot.',
	2690.76923076923,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1739,
	'Vino tinto',
	2768.88888888889,
	3,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1740,
	'Vino tinto - cepa carignan bot',
	2690.76923076923,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1741,
	'Vino tinto - cepa Carmenere bot',
	2690.76923076923,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1742,
	'Vino tinto - cepa malbec bot',
	2690.76923076923,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1743,
	'Vino tinto - cepa Merlot bot',
	2690.76923076923,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1744,
	'Vino tinto - cepa país País salvaje bot',
	2690.76923076923,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1745,
	'Vino tinto - cepa Pinot noir bot',
	2690.76923076923,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1746,
	'Vino tinto - cepa syrah bot',
	2690.76923076923,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1747,
	'Vino tinto Carmenere',
	2690.76923076923,
	3,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1748,
	'Vino tinto Carmenere de 750 cc botella',
	3500,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1749,
	'Vino tinto común bot.',
	2690.76923076923,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1750,
	'Vino tinto económico (750 cc, con corcho) botella',
	2690.76923076923,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1751,
	'Vino varietal cabernet sauvignon 750cc bot.',
	2690.76923076923,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1752,
	'Vino varietal chardonnay 750cc bot.',
	2690.76923076923,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1753,
	'Vino varietal malbec 750cc bot.',
	2690.76923076923,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1754,
	'Vino varietal riesling 750cc bot.',
	2690.76923076923,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1755,
	'Vino viognier (salón comedor) bot.',
	2690.76923076923,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1756,
	'Vinos para descorche (con corcho) bot.',
	2690.76923076923,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1757,
	'Viña mar Brut 750cc bot.',
	2690.76923076923,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1758,
	'Viognier bot.',
	8000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1759,
	'Virutilla fibra verde',
	240,
	5,
	9);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1760,
	'Vodka absolut',
	4190,
	3,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1761,
	'Vodka absolut 750 cc bot.',
	4190,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1762,
	'Vodka botella',
	4190,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1763,
	'Vodka botella de 750 cc botella',
	12000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1764,
	'Wasabi en polvo',
	1500,
	1,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1765,
	'Whisky Jack Daniels 750 cc bot',
	6890,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1766,
	'Whisky Jack Daniels 750 cc bot.',
	6890,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1767,
	'Whisky Jameson',
	6890,
	3,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1768,
	'Whisky Johnny Walker',
	6890,
	3,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1769,
	'Whisky Johnny Walker etiqueta roja 750 cc bot',
	6890,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1770,
	'Whisky botella',
	6890,
	5,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1771,
	'Whisky botella de 750 cc botella',
	1500,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1772,
	'Whisky bourbon bot',
	20000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1773,
	'Whisky etiqueta roja bot',
	20000,
	5,
	7);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1774,
	'Worcestershire sauce bot.',
	3900,
	5,
	6);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1775,
	'Yogur natural',
	529,
	1,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1776,
	'Yogur natural Soprole tipo griego',
	529,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1777,
	'Yogur natural sin azúcar',
	529,
	5,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1778,
	'Yogur vainilla',
	529,
	3,
	5);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1779,
	'Yuca fresca',
	4490,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1780,
	'Zanahoria',
	1533.28571428571,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1781,
	'Zanahoria baby',
	4500,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1782,
	'Zanahoria grande',
	1800,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1783,
	'Zanahoria grandes',
	1000,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1784,
	'Zanahoria mediana',
	1000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1785,
	'Zanahoria, 3 a 4 unidades',
	1800,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1786,
	'Zanahoria, 4 unidades',
	1800,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1787,
	'Zanahorias',
	833.333333333333,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1788,
	'Zanahorias baby',
	3500,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1789,
	'Zanahorias grandes',
	1800,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1790,
	'Zapallo camote',
	2512.5,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1791,
	'Zapallo camote, chileno',
	4200,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1792,
	'Zapallo italiano',
	760,
	5,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1793,
	'Zapallo italiano, 1 unidad grande',
	1900,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1794,
	'Zapallo italiano, 2 unidades med.',
	1900,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1795,
	'Zapallo italiano, 3 unidades',
	1900,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1796,
	'Zapallo italiano, 3 unidades med.',
	1900,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1797,
	'Zapallo italiano, 40 unidades',
	1900,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1798,
	'Zarzaparrilla',
	14500,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1799,
	'Zucchini',
	4000,
	1,
	2);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1800,
	'Zucchini 5 a 6 unidades',
	4000,
	1,
	1);

insert into producto (
	id_producto,
	nom_producto,
	precio,
	cod_unidad_medida,
	cod_categ_producto)
values (
	1801,
	'Zucchini 8 a 9 unidades',
	4000,
	1,
	1);

/* Fin tabla: producto */

commit;



/* Inicio tabla: config_taller */
insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	194,
	1,
	100);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	195,
	1,
	100);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	303,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	307,
	1,
	100);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	616,
	1,
	100);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	1075,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	1077,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	1188,
	1,
	18);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	1192,
	1,
	0.75);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	1193,
	1,
	0.75);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	1579,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	1618,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	1620,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	1623,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	1660,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	1662,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	1699,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	116,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	252,
	1,
	18);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	247,
	1,
	40);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	638,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	750,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	881,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	958,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	1210,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	1234,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	1667,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	1397,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	1427,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	870,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	945,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	1014,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	1140,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	1266,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	258,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	893,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	895,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	1,
	1007,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	2,
	1179,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	2,
	1699,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	2,
	1397,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	2,
	1416,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	2,
	99,
	1,
	0.15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	2,
	945,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	2,
	258,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	2,
	1579,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	2,
	48,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	2,
	58,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	2,
	828,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	2,
	1334,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	2,
	1751,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	2,
	1752,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	3,
	399,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	3,
	1179,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	3,
	1699,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	3,
	1398,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	3,
	1428,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	3,
	945,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	3,
	1060,
	1,
	0.15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	3,
	258,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	3,
	1579,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	3,
	1008,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	3,
	48,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	3,
	58,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	3,
	510,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	3,
	737,
	1,
	1.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	3,
	828,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	3,
	1628,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	3,
	1736,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	3,
	1753,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	4,
	107,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	4,
	257,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	4,
	399,
	1,
	0.15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	4,
	1179,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	4,
	1699,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	4,
	1416,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	4,
	1428,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	4,
	945,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	4,
	1140,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	4,
	1579,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	4,
	1008,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	4,
	141,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	4,
	827,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	4,
	852,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	4,
	1328,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	4,
	1726,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	4,
	1735,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	194,
	1,
	100);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	195,
	1,
	100);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	303,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	307,
	1,
	100);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	616,
	1,
	100);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	1075,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	1077,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	1188,
	1,
	18);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	1192,
	1,
	0.75);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	1193,
	1,
	0.75);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	1618,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	1620,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	1623,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	1660,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	1662,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	1699,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	116,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	252,
	1,
	18);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	247,
	1,
	40);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	638,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	750,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	881,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	958,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	1210,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	1234,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	1667,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	1397,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	1427,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	870,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	945,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	1014,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	1140,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	1266,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	258,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	1579,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	893,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	895,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	5,
	1007,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	6,
	1033,
	1,
	0.15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	6,
	1179,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	6,
	1579,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	6,
	1619,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	6,
	1699,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	6,
	1398,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	6,
	1416,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	6,
	1430,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	6,
	396,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	6,
	945,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	6,
	1056,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	6,
	1060,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	6,
	1140,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	6,
	258,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	6,
	1115,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	6,
	1007,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	6,
	658,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	6,
	745,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	6,
	828,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	6,
	852,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	6,
	1334,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	6,
	1717,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	6,
	1754,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	7,
	1033,
	1,
	0.15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	7,
	1179,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	7,
	1699,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	7,
	1397,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	7,
	1428,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	7,
	1427,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	7,
	396,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	7,
	945,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	7,
	1056,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	7,
	1060,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	7,
	1140,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	7,
	258,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	7,
	1579,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	7,
	895,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	7,
	1007,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	7,
	156,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	7,
	736,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	7,
	1334,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	7,
	1727,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	7,
	1730,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	7,
	1737,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	7,
	1738,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	8,
	1179,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	8,
	1698,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	8,
	1402,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	8,
	1416,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	8,
	1417,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	8,
	1426,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	8,
	396,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	8,
	945,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	8,
	1056,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	8,
	1060,
	1,
	0.15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	8,
	258,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	8,
	1579,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	8,
	895,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	8,
	1007,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	8,
	655,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	8,
	658,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	8,
	828,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	8,
	1513,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	8,
	1718,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	8,
	1720,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	8,
	1721,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	9,
	116,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	9,
	252,
	1,
	18);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	9,
	247,
	1,
	40);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	9,
	638,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	9,
	750,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	9,
	881,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	9,
	958,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	9,
	1210,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	9,
	1234,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	9,
	1667,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	9,
	194,
	1,
	100);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	9,
	195,
	1,
	100);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	9,
	303,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	9,
	307,
	1,
	100);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	9,
	616,
	1,
	100);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	9,
	1179,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	9,
	1579,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	9,
	1620,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	9,
	1696,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	9,
	1008,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	9,
	1756,
	1,
	14);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	10,
	1179,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	10,
	1579,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	10,
	1699,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	10,
	1397,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	10,
	1416,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	10,
	99,
	1,
	0.15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	10,
	945,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	10,
	258,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	10,
	1008,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	10,
	48,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	10,
	58,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	10,
	828,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	10,
	1334,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	10,
	1751,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	10,
	1752,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	11,
	399,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	11,
	1179,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	11,
	1699,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	11,
	1398,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	11,
	1428,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	11,
	945,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	11,
	1060,
	1,
	0.15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	11,
	258,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	11,
	1579,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	11,
	1008,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	11,
	48,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	11,
	58,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	11,
	510,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	11,
	737,
	1,
	1.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	11,
	828,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	11,
	1628,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	11,
	1736,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	11,
	1753,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	12,
	107,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	12,
	399,
	1,
	0.15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	12,
	1179,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	12,
	1699,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	12,
	1416,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	12,
	1428,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	12,
	945,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	12,
	1140,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	12,
	257,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	12,
	1579,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	12,
	1008,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	12,
	141,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	12,
	827,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	12,
	852,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	12,
	1328,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	12,
	1726,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	12,
	1735,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	194,
	1,
	100);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	195,
	1,
	100);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	303,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	307,
	1,
	100);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	616,
	1,
	100);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	1075,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	1077,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	1188,
	1,
	18);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	1192,
	1,
	0.75);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	1193,
	1,
	0.75);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	1579,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	1618,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	1620,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	1623,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	1660,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	1662,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	1699,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	116,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	252,
	1,
	18);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	247,
	1,
	40);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	638,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	750,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	881,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	958,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	1210,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	1234,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	1667,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	1397,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	1427,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	870,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	945,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	1014,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	1140,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	1266,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	258,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	893,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	895,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	13,
	1007,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	14,
	1033,
	1,
	0.15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	14,
	1179,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	14,
	1699,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	14,
	1398,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	14,
	1416,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	14,
	1430,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	14,
	396,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	14,
	945,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	14,
	1056,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	14,
	1060,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	14,
	1140,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	14,
	258,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	14,
	1115,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	14,
	1579,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	14,
	1007,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	14,
	658,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	14,
	745,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	14,
	828,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	14,
	852,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	14,
	1334,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	14,
	1717,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	14,
	1754,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	15,
	258,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	15,
	1033,
	1,
	0.15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	15,
	1179,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	15,
	1699,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	15,
	1397,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	15,
	1428,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	15,
	1427,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	15,
	396,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	15,
	945,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	15,
	1056,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	15,
	1060,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	15,
	1140,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	15,
	1579,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	15,
	895,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	15,
	1007,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	15,
	156,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	15,
	736,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	15,
	1334,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	15,
	1727,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	15,
	1730,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	15,
	1737,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	15,
	1738,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	16,
	1179,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	16,
	1698,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	16,
	1402,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	16,
	1416,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	16,
	1417,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	16,
	1426,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	16,
	396,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	16,
	945,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	16,
	1056,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	16,
	1060,
	1,
	0.15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	16,
	258,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	16,
	1579,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	16,
	895,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	16,
	1007,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	16,
	655,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	16,
	658,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	16,
	828,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	16,
	1513,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	16,
	1718,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	16,
	1720,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	16,
	1721,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	17,
	253,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	17,
	881,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	17,
	1503,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	17,
	1594,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	17,
	1667,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	17,
	259,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	17,
	270,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	18,
	253,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	18,
	1503,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	18,
	1578,
	1,
	2.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	18,
	1689,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	18,
	51,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	18,
	538,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	18,
	735,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	18,
	1329,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	18,
	1507,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	18,
	1509,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	18,
	1626,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	18,
	1630,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	18,
	1761,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	18,
	1765,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	18,
	1769,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	19,
	719,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	19,
	253,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	19,
	881,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	19,
	1503,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	19,
	1594,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	19,
	1667,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	19,
	1578,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	19,
	1689,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	19,
	51,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	19,
	140,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	19,
	351,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	19,
	478,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	19,
	838,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	19,
	1036,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	19,
	1040,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	19,
	1158,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	20,
	719,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	20,
	253,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	20,
	1503,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	20,
	1578,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	20,
	1689,
	1,
	20);

#N/D
insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	20,
	51,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	20,
	142,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	20,
	205,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	20,
	227,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	20,
	509,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	20,
	537,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	20,
	4,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	21,
	108,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	21,
	141,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	21,
	158,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	21,
	192,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	21,
	253,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	21,
	881,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	21,
	1503,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	21,
	1594,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	21,
	1667,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	21,
	944,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	21,
	945,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	21,
	952,
	1,
	0.15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	21,
	1034,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	21,
	1140,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	21,
	259,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	21,
	43,
	1,
	0.8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	21,
	299,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	21,
	509,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	21,
	1036,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	21,
	1329,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	21,
	1761,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	21,
	1766,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	22,
	192,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	22,
	453,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	22,
	1033,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	22,
	253,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	22,
	1503,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	22,
	158,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	22,
	789,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	22,
	952,
	1,
	0.15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	22,
	954,
	1,
	2.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	22,
	1140,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	22,
	259,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	22,
	270,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	22,
	568,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	22,
	869,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	22,
	43,
	1,
	0.8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	22,
	431,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	22,
	538,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	22,
	509,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	22,
	566,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	22,
	735,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	22,
	744,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	22,
	1,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	22,
	4,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	22,
	1329,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	22,
	1507,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	22,
	1630,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	22,
	1761,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	23,
	189,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	23,
	192,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	23,
	1034,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	23,
	253,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	23,
	881,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	23,
	1503,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	23,
	1594,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	23,
	1667,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	23,
	158,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	23,
	788,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	23,
	943,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	23,
	954,
	1,
	1.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	23,
	1140,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	23,
	259,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	23,
	270,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	23,
	42,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	23,
	43,
	1,
	0.8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	23,
	139,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	23,
	299,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	23,
	351,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	23,
	501,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	23,
	735,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	23,
	1036,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	23,
	2,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	23,
	4,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	23,
	1508,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	23,
	1630,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	23,
	1761,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	23,
	1766,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	24,
	192,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	24,
	555,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	24,
	854,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	24,
	972,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	24,
	1034,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	24,
	1301,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	24,
	1526,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	24,
	1604,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	24,
	1774,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	24,
	253,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	24,
	1503,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	24,
	31,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	24,
	782,
	1,
	6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	24,
	789,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	24,
	943,
	1,
	0.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	24,
	954,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	24,
	1140,
	1,
	1.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	24,
	1320,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	24,
	259,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	24,
	270,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	24,
	43,
	1,
	0.8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	24,
	140,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	24,
	351,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	24,
	735,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	24,
	1036,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	24,
	1040,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	24,
	1508,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	24,
	1509,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	24,
	1761,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	24,
	1766,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	25,
	253,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	25,
	881,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	25,
	1503,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	25,
	1594,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	25,
	1667,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	25,
	259,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	25,
	270,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	26,
	869,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	26,
	31,
	1,
	5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	26,
	42,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	26,
	43,
	1,
	0.8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	26,
	107,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	26,
	140,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	26,
	189,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	26,
	192,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	26,
	351,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	26,
	538,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	26,
	735,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	26,
	1034,
	1,
	15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	26,
	1036,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	26,
	1040,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	26,
	3,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	26,
	4,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	26,
	1757,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	26,
	1766,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	26,
	253,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	26,
	881,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	26,
	1503,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	26,
	1594,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	26,
	1667,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	26,
	158,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	26,
	789,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	26,
	954,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	26,
	1140,
	1,
	1.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	26,
	259,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	26,
	270,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	27,
	192,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	27,
	555,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	27,
	1033,
	1,
	12);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	27,
	253,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	27,
	1503,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	27,
	943,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	27,
	952,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	27,
	954,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	27,
	1058,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	27,
	1140,
	1,
	2.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	27,
	1320,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	27,
	259,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	27,
	270,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	27,
	48,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	27,
	51,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	27,
	584,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	27,
	735,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	27,
	738,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	27,
	743,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	27,
	1511,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	27,
	1627,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	27,
	1670,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	27,
	1760,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	28,
	192,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	28,
	354,
	1,
	50);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	28,
	455,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	28,
	1033,
	1,
	15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	28,
	253,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	28,
	881,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	28,
	1503,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	28,
	1594,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	28,
	1667,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	28,
	158,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	28,
	788,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	28,
	1140,
	1,
	5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	28,
	259,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	28,
	270,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	28,
	567,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	28,
	570,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	28,
	51,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	28,
	135,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	28,
	267,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	28,
	538,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	28,
	508,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	28,
	552,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	28,
	553,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	28,
	563,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	28,
	603,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	28,
	933,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	28,
	1760,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	28,
	1767,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	28,
	1768,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	29,
	259,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	29,
	270,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	29,
	253,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	29,
	1503,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	30,
	253,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	30,
	881,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	30,
	1503,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	30,
	1594,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	30,
	1667,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	30,
	259,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	30,
	270,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	31,
	253,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	31,
	1503,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	31,
	259,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	31,
	270,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	32,
	19,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	32,
	1052,
	1,
	500);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	32,
	1128,
	1,
	60);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	32,
	1700,
	1,
	500);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	32,
	115,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	32,
	252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	32,
	507,
	1,
	200);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	32,
	633,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	32,
	751,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	32,
	881,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	32,
	1255,
	1,
	150);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	32,
	1502,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	32,
	272,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	32,
	518,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	32,
	901,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	32,
	945,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	32,
	1215,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	32,
	1264,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	32,
	1271,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	32,
	1289,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	32,
	1293,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	32,
	1640,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	32,
	1787,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	33,
	19,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	33,
	28,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	33,
	184,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	33,
	204,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	33,
	1051,
	1,
	500);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	33,
	1127,
	1,
	60);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	33,
	1700,
	1,
	500);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	33,
	115,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	33,
	252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	33,
	633,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	33,
	881,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	33,
	1502,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	33,
	904,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	33,
	903,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	33,
	945,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	33,
	1215,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	33,
	1271,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	33,
	1289,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	33,
	1293,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	33,
	1373,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	33,
	1640,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	33,
	1787,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	33,
	801,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	33,
	1476,
	1,
	150);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	34,
	19,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	34,
	28,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	34,
	184,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	34,
	204,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	34,
	1051,
	1,
	500);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	34,
	1127,
	1,
	60);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	34,
	1700,
	1,
	500);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	34,
	115,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	34,
	252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	34,
	633,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	34,
	881,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	34,
	1502,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	34,
	904,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	34,
	903,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	34,
	945,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	34,
	1215,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	34,
	1271,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	34,
	1289,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	34,
	1293,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	34,
	1373,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	34,
	1640,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	34,
	1787,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	34,
	801,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	34,
	1476,
	1,
	150);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	12,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	13,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	188,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	759,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	767,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	922,
	1,
	0.12);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	1051,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	1127,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	1142,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	1286,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	1403,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	1409,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	1547,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	1568,
	1,
	0.03);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	1708,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	115,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	633,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	881,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	1502,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	817,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	962,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	1257,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	25,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	94,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	98,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	147,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	233,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	379,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	470,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	472,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	836,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	945,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	961,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	960,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	1519,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	1641,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	1653,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	1657,
	1,
	0.02);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	1787,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	1536,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	1114,
	1,
	100);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	801,
	1,
	6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	883,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	1010,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	1449,
	1,
	0.45);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	35,
	1775,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	36,
	13,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	36,
	28,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	36,
	37,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	36,
	40,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	36,
	112,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	36,
	1114,
	1,
	100);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	36,
	1126,
	1,
	0.06);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	36,
	1170,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	36,
	1180,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	36,
	1190,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	36,
	115,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	36,
	252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	36,
	633,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	36,
	881,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	36,
	1502,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	36,
	821,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	36,
	962,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	36,
	1254,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	36,
	233,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	36,
	623,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	36,
	715,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	36,
	903,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	36,
	945,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	36,
	1269,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	36,
	1505,
	1,
	0.02);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	36,
	1519,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	36,
	1641,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	36,
	1536,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	36,
	547,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	36,
	1437,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	36,
	1449,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	36,
	1451,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	36,
	1497,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	12,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	13,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	188,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	1051,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	1127,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	1142,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	1179,
	1,
	40);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	1194,
	1,
	40);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	1205,
	1,
	40);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	1286,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	1403,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	1409,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	1547,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	1568,
	1,
	0.03);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	1708,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	115,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	633,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	881,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	1502,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	824,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	962,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	1257,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	25,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	94,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	98,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	147,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	233,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	379,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	470,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	472,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	836,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	945,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	961,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	960,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	1519,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	1641,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	1653,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	1657,
	1,
	0.02);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	1787,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	1536,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	1117,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	801,
	1,
	6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	883,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	1010,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	1449,
	1,
	0.45);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	37,
	1775,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	13,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	20,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	113,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	388,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	759,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	990,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	1009,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	1044,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	1051,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	1129,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	1204,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	1209,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	1260,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	1542,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	1708,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	115,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	633,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	881,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	1502,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	1257,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	1381,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	30,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	82,
	1,
	0.01);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	386,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	379,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	1271,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	1285,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	1289,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	342,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	372,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	676,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	1171,
	1,
	100);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	547,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	801,
	1,
	16);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	1000,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	1010,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	1449,
	1,
	0.22);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	1468,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	38,
	1475,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	39,
	14,
	1,
	500);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	39,
	19,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	39,
	203,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	39,
	691,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	39,
	759,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	39,
	1198,
	1,
	400);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	39,
	1715,
	1,
	500);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	39,
	115,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	39,
	252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	39,
	633,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	39,
	881,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	39,
	1502,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	39,
	1637,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	39,
	94,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	39,
	272,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	39,
	379,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	39,
	518,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	39,
	835,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	39,
	1215,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	39,
	1218,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	39,
	1271,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	39,
	1396,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	39,
	1790,
	1,
	1.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	39,
	1792,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	39,
	547,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	39,
	801,
	1,
	12);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	39,
	1005,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	39,
	1476,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	40,
	13,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	40,
	22,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	40,
	71,
	1,
	50);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	40,
	1127,
	1,
	100);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	40,
	1287,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	40,
	1553,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	40,
	1696,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	40,
	1708,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	40,
	1739,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	40,
	115,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	40,
	252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	40,
	633,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	40,
	881,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	40,
	1502,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	40,
	464,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	40,
	544,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	40,
	1399,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	40,
	1592,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	40,
	94,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	40,
	379,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	40,
	415,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	40,
	1215,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	40,
	1271,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	40,
	1780,
	1,
	6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	40,
	1792,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	40,
	547,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	40,
	883,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	40,
	1005,
	1,
	250);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	41,
	13,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	41,
	22,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	41,
	71,
	1,
	50);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	41,
	1127,
	1,
	100);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	41,
	1287,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	41,
	1553,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	41,
	1696,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	41,
	1708,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	41,
	1739,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	41,
	115,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	41,
	252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	41,
	633,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	41,
	881,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	41,
	1502,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	41,
	464,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	41,
	544,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	41,
	1399,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	41,
	1592,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	41,
	94,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	41,
	379,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	41,
	415,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	41,
	1215,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	41,
	1271,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	41,
	1780,
	1,
	6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	41,
	1792,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	41,
	547,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	41,
	883,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	41,
	1005,
	1,
	250);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	42,
	13,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	42,
	22,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	42,
	87,
	1,
	0.03);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	42,
	168,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	42,
	203,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	42,
	1127,
	1,
	0.03);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	42,
	115,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	42,
	252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	42,
	633,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	42,
	881,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	42,
	1502,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	42,
	963,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	42,
	386,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	42,
	415,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	42,
	468,
	1,
	0.04);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	42,
	472,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	42,
	835,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	42,
	954,
	1,
	2.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	42,
	960,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	42,
	961,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	42,
	1285,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	42,
	1289,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	42,
	1293,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	42,
	1553,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	42,
	1792,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	42,
	1488,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	42,
	1538,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	42,
	547,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	130,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	188,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	190,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	292,
	1,
	0.06);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	304,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	446,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	485,
	1,
	0.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	488,
	1,
	0.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	494,
	1,
	0.7);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	535,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	621,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	759,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	787,
	1,
	18);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	845,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	849,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	862,
	1,
	0.04);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	995,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	1099,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	1362,
	1,
	0.07);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	1566,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	115,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	633,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	881,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	1502,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	160,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	704,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	945,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	1140,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	1241,
	1,
	5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	547,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	577,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	801,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	1010,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	1449,
	1,
	0.45);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	43,
	1775,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	44,
	130,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	44,
	188,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	44,
	190,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	44,
	485,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	44,
	621,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	44,
	759,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	44,
	889,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	44,
	1516,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	44,
	115,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	44,
	252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	44,
	633,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	44,
	881,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	44,
	1502,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	44,
	702,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	44,
	711,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	44,
	945,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	44,
	1105,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	44,
	1143,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	44,
	986,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	44,
	547,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	44,
	801,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	44,
	883,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	44,
	1010,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	44,
	1450,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	12,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	13,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	113,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	165,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	759,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	1153,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	1482,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	1553,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	1708,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	1739,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	115,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	633,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	881,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	1502,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	1257,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	1592,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	94,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	235,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	379,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	386,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	415,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	468,
	1,
	0.04);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	472,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	836,
	1,
	0.01);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	954,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	960,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	961,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	992,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	1175,
	1,
	1.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	1215,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	1285,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	1289,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	1293,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	1490,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	1534,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	547,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	883,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	1005,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	45,
	1476,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	13,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	22,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	28,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	35,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	112,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	128,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	130,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	190,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	192,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	203,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	306,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	485,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	604,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	607,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	617,
	1,
	0.02);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	768,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	860,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	888,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	921,
	1,
	0.07);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	994,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	1049,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	1073,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	1084,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	1107,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	1142,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	1202,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	1203,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	1342,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	1409,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	1416,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	1615,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	115,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	633,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	881,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	818,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	822,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	962,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	1093,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	1637,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	158,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	379,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	700,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	709,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	945,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	961,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	960,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	1140,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	1173,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	1215,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	1289,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	1293,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	1348,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	1519,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	1640,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	1536,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	1114,
	1,
	100);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	1572,
	1,
	100);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	1687,
	1,
	50);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	547,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	577,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	801,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	883,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	893,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	1007,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	1443,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	1444,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	1446,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	1449,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	1457,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	1470,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	1476,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	46,
	1778,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	13,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	22,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	28,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	35,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	112,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	128,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	130,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	190,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	192,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	203,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	306,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	485,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	604,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	607,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	617,
	1,
	0.02);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	768,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	860,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	888,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	921,
	1,
	0.07);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	994,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	1049,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	1073,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	1084,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	1107,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	1142,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	1202,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	1203,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	1342,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	1409,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	1416,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	1615,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	115,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	252,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	633,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	881,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	818,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	822,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	962,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	1093,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	1637,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	158,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	379,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	700,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	709,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	945,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	961,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	960,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	1140,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	1173,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	1215,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	1289,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	1293,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	1348,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	1519,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	1640,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	1536,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	1114,
	1,
	100);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	1572,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	1687,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	547,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	577,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	801,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	883,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	893,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	1007,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	1443,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	1444,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	1446,
	1,
	0.02);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	1449,
	1,
	0.07);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	1457,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	1470,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	1476,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	47,
	1778,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	48,
	447,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	48,
	448,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	48,
	716,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	48,
	723,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	48,
	724,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	48,
	1222,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	48,
	181,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	48,
	594,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	48,
	634,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	48,
	754,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	48,
	957,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	48,
	1212,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	48,
	1214,
	1,
	0.02);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	48,
	1242,
	1,
	0.07);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	48,
	1594,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	48,
	1667,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	48,
	49,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	48,
	56,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	48,
	406,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	48,
	409,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	48,
	499,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	48,
	502,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	48,
	660,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	48,
	840,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	48,
	1596,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	49,
	19,
	1,
	0.005);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	49,
	1052,
	1,
	0.8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	49,
	1128,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	49,
	1700,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	49,
	115,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	49,
	252,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	49,
	507,
	1,
	0.8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	49,
	633,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	49,
	751,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	49,
	881,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	49,
	1255,
	1,
	0.015);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	49,
	1502,
	1,
	0.7);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	49,
	272,
	1,
	0.015);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	49,
	518,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	49,
	901,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	49,
	945,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	49,
	1215,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	49,
	1264,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	49,
	1271,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	49,
	1289,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	49,
	1293,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	49,
	1640,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	49,
	1787,
	1,
	0.015);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	50,
	19,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	50,
	28,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	50,
	184,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	50,
	204,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	50,
	1051,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	50,
	1127,
	1,
	0.015);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	50,
	1700,
	1,
	0.005);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	50,
	115,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	50,
	252,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	50,
	633,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	50,
	881,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	50,
	1502,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	50,
	904,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	50,
	903,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	50,
	945,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	50,
	1215,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	50,
	1271,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	50,
	1289,
	1,
	0.015);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	50,
	1293,
	1,
	0.005);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	50,
	1373,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	50,
	1640,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	50,
	1787,
	1,
	0.8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	50,
	801,
	1,
	0.005);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	50,
	1476,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	51,
	28,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	51,
	115,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	51,
	252,
	1,
	0.75);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	51,
	633,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	51,
	881,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	51,
	1502,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	51,
	19,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	51,
	184,
	1,
	0.8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	51,
	204,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	51,
	904,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	51,
	903,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	51,
	945,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	51,
	1051,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	51,
	1127,
	1,
	0.015);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	51,
	1215,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	51,
	1271,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	51,
	1289,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	51,
	1293,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	51,
	1373,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	51,
	1640,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	51,
	1700,
	1,
	2.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	51,
	1787,
	1,
	1.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	51,
	801,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	51,
	1476,
	1,
	1.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	12,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	13,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	188,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	759,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	767,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	922,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	1051,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	1127,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	1142,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	1286,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	1403,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	1409,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	1547,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	1568,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	1708,
	1,
	0.15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	115,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	252,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	633,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	881,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	1502,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	817,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	962,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	1257,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	25,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	94,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	98,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	147,
	1,
	2.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	233,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	379,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	470,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	472,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	836,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	945,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	961,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	960,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	1519,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	1641,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	1653,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	1657,
	1,
	2.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	1787,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	1536,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	1114,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	801,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	883,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	1010,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	1449,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	52,
	1775,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	53,
	13,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	53,
	28,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	53,
	37,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	53,
	40,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	53,
	112,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	53,
	1126,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	53,
	1170,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	53,
	1180,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	53,
	1190,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	53,
	115,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	53,
	252,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	53,
	633,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	53,
	881,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	53,
	1502,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	53,
	821,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	53,
	962,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	53,
	1254,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	53,
	233,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	53,
	623,
	1,
	1.7);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	53,
	715,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	53,
	903,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	53,
	945,
	1,
	2.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	53,
	1269,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	53,
	1505,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	53,
	1519,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	53,
	1641,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	53,
	1536,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	53,
	1114,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	53,
	547,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	53,
	1437,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	53,
	1449,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	53,
	1451,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	53,
	1497,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	12,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	13,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	188,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	1051,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	1127,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	1142,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	1179,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	1194,
	1,
	0.425);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	1205,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	1286,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	1403,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	1409,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	1547,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	1568,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	1708,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	115,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	252,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	633,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	881,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	1502,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	824,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	962,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	1257,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	25,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	94,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	98,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	147,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	233,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	379,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	470,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	472,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	836,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	945,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	961,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	960,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	1519,
	1,
	0.175);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	1641,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	1653,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	1657,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	1787,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	1536,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	1117,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	801,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	883,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	1010,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	1449,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	54,
	1775,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	13,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	20,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	113,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	388,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	759,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	990,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	1009,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	1044,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	1051,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	1129,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	1204,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	1209,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	1260,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	1542,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	1708,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	115,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	633,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	881,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	1502,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	1257,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	1381,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	30,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	82,
	1,
	0.01);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	386,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	379,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	1271,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	1285,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	1289,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	342,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	372,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	676,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	1171,
	1,
	100);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	547,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	801,
	1,
	16);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	1000,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	1010,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	1449,
	1,
	0.22);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	1468,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	55,
	1475,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	56,
	14,
	1,
	500);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	56,
	19,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	56,
	203,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	56,
	691,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	56,
	759,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	56,
	1198,
	1,
	400);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	56,
	1715,
	1,
	500);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	56,
	115,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	56,
	252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	56,
	633,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	56,
	881,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	56,
	1502,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	56,
	1637,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	56,
	94,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	56,
	272,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	56,
	379,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	56,
	518,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	56,
	835,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	56,
	1215,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	56,
	1218,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	56,
	1271,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	56,
	1396,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	56,
	1790,
	1,
	1.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	56,
	1792,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	56,
	547,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	56,
	801,
	1,
	12);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	56,
	1005,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	56,
	1476,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	57,
	13,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	57,
	22,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	57,
	71,
	1,
	50);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	57,
	1127,
	1,
	100);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	57,
	1287,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	57,
	1553,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	57,
	1696,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	57,
	1708,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	57,
	1739,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	57,
	115,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	57,
	252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	57,
	633,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	57,
	881,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	57,
	1502,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	57,
	464,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	57,
	544,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	57,
	1399,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	57,
	1592,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	57,
	94,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	57,
	379,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	57,
	415,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	57,
	1215,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	57,
	1271,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	57,
	1780,
	1,
	6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	57,
	1792,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	57,
	547,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	57,
	883,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	57,
	1005,
	1,
	250);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	58,
	13,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	58,
	22,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	58,
	71,
	1,
	50);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	58,
	1127,
	1,
	100);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	58,
	1287,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	58,
	1553,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	58,
	1696,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	58,
	1708,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	58,
	1739,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	58,
	115,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	58,
	252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	58,
	633,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	58,
	881,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	58,
	1502,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	58,
	464,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	58,
	544,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	58,
	1399,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	58,
	1592,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	58,
	94,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	58,
	379,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	58,
	415,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	58,
	1215,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	58,
	1271,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	58,
	1780,
	1,
	6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	58,
	1792,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	58,
	547,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	58,
	883,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	58,
	1005,
	1,
	250);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	59,
	13,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	59,
	22,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	59,
	87,
	1,
	0.03);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	59,
	168,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	59,
	203,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	59,
	1127,
	1,
	0.03);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	59,
	115,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	59,
	252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	59,
	633,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	59,
	881,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	59,
	1502,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	59,
	963,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	59,
	386,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	59,
	415,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	59,
	468,
	1,
	0.04);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	59,
	472,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	59,
	835,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	59,
	954,
	1,
	2.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	59,
	960,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	59,
	961,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	59,
	1285,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	59,
	1289,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	59,
	1293,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	59,
	1553,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	59,
	1792,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	59,
	1488,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	59,
	1538,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	59,
	547,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	130,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	188,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	190,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	292,
	1,
	0.06);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	304,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	446,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	485,
	1,
	0.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	488,
	1,
	0.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	494,
	1,
	0.7);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	535,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	621,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	759,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	787,
	1,
	18);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	845,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	849,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	862,
	1,
	0.04);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	995,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	1099,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	1241,
	1,
	5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	1362,
	1,
	0.07);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	1566,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	115,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	633,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	881,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	1502,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	160,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	704,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	945,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	1140,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	547,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	577,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	801,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	1010,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	1449,
	1,
	0.45);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	60,
	1775,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	61,
	130,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	61,
	188,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	61,
	190,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	61,
	485,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	61,
	621,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	61,
	759,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	61,
	889,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	61,
	1516,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	61,
	115,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	61,
	252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	61,
	633,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	61,
	881,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	61,
	1502,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	61,
	702,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	61,
	711,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	61,
	945,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	61,
	1105,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	61,
	1143,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	61,
	986,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	61,
	547,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	61,
	801,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	61,
	883,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	61,
	1010,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	61,
	1450,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	12,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	13,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	113,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	165,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	759,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	1153,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	1482,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	1553,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	1708,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	1739,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	115,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	633,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	881,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	1502,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	1257,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	1592,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	94,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	235,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	379,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	386,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	415,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	468,
	1,
	0.04);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	472,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	836,
	1,
	0.01);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	954,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	960,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	961,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	992,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	1175,
	1,
	1.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	1215,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	1285,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	1289,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	1293,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	1490,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	1534,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	547,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	883,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	1005,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	62,
	1476,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	13,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	22,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	28,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	35,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	112,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	128,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	130,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	190,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	192,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	203,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	306,
	1,
	0.02);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	485,
	1,
	0.07);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	604,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	607,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	617,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	768,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	860,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	888,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	921,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	994,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	1049,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	1073,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	1084,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	1107,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	1142,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	1202,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	1203,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	1342,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	1409,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	1416,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	1615,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	115,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	252,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	633,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	881,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	818,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	822,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	962,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	1093,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	1637,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	158,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	379,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	700,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	709,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	946,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	961,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	960,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	1140,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	1173,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	1215,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	1289,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	1293,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	1348,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	1519,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	1640,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	1536,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	1114,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	1572,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	1687,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	547,
	1,
	0.02);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	577,
	1,
	0.07);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	801,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	883,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	893,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	1007,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	1443,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	1444,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	1446,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	1449,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	1457,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	1470,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	1476,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	63,
	1778,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	13,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	22,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	28,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	35,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	112,
	1,
	0.015);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	128,
	1,
	0.005);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	130,
	1,
	0.8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	190,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	192,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	203,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	306,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	485,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	604,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	607,
	1,
	0.7);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	617,
	1,
	0.8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	768,
	1,
	0.015);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	860,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	888,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	921,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	994,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	1049,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	1073,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	1084,
	1,
	0.015);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	1107,
	1,
	0.005);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	1142,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	1202,
	1,
	0.8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	1203,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	1342,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	1409,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	1416,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	1615,
	1,
	0.015);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	115,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	252,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	633,
	1,
	0.015);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	881,
	1,
	2.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	818,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	822,
	1,
	0.005);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	962,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	1093,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	1637,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	158,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	379,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	700,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	709,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	946,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	961,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	960,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	1140,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	1173,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	1215,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	1289,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	1293,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	1348,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	1519,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	1640,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	1536,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	1114,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	1572,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	1687,
	1,
	0.005);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	547,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	577,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	801,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	883,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	893,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	1007,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	1443,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	1444,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	1446,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	1449,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	1457,
	1,
	1.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	1470,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	1476,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	64,
	1778,
	1,
	0.8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	65,
	924,
	1,
	0.125);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	65,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	65,
	1500,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	65,
	1573,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	65,
	1594,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	65,
	263,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	65,
	512,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	65,
	612,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	65,
	644,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	65,
	1150,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	65,
	1677,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	65,
	1678,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	65,
	51,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	66,
	606,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	66,
	974,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	66,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	66,
	807,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	66,
	1500,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	66,
	1573,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	66,
	1594,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	66,
	54,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	66,
	63,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	66,
	83,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	66,
	393,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	66,
	945,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	66,
	1312,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	66,
	1364,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	67,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	67,
	807,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	67,
	1500,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	67,
	1573,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	67,
	1594,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	67,
	55,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	67,
	720,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	67,
	1560,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	67,
	1708,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	68,
	15,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	68,
	1180,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	68,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	68,
	807,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	68,
	1500,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	68,
	1573,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	68,
	1594,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	68,
	1453,
	1,
	0.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	68,
	1454,
	1,
	0.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	68,
	426,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	68,
	1122,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	68,
	1561,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	69,
	8,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	69,
	15,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	69,
	34,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	69,
	203,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	69,
	424,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	69,
	721,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	69,
	1523,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	69,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	69,
	807,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	69,
	1573,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	69,
	1594,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	69,
	825,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	69,
	386,
	1,
	0.15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	69,
	475,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	69,
	712,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	69,
	946,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	69,
	1016,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	69,
	1080,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	69,
	361,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	69,
	1535,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	69,
	1441,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	69,
	1449,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	69,
	733,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	69,
	1499,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	69,
	1758,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	70,
	15,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	70,
	1081,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	70,
	1180,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	70,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	70,
	807,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	70,
	1500,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	70,
	1573,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	70,
	1594,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	70,
	1440,
	1,
	0.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	70,
	1452,
	1,
	0.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	70,
	426,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	70,
	733,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	70,
	1561,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	71,
	7,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	71,
	262,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	71,
	611,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	71,
	708,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	71,
	1118,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	71,
	5,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	71,
	1603,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	72,
	15,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	72,
	1028,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	72,
	1523,
	1,
	0.07);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	72,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	72,
	807,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	72,
	1500,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	72,
	1573,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	72,
	1594,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	72,
	462,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	72,
	823,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	72,
	1254,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	72,
	1440,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	72,
	53,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	72,
	367,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	72,
	982,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	72,
	1310,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	72,
	1602,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	73,
	14,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	73,
	203,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	73,
	1096,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	73,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	73,
	807,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	73,
	1500,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	73,
	1573,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	73,
	1594,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	73,
	163,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	73,
	477,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	73,
	1166,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	73,
	1322,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	73,
	1518,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	74,
	14,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	74,
	203,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	74,
	449,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	74,
	720,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	74,
	1094,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	74,
	1095,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	74,
	1523,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	74,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	74,
	807,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	74,
	1500,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	74,
	1594,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	74,
	380,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	74,
	475,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	74,
	713,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	74,
	946,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	74,
	460,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	74,
	1116,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	74,
	1573,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	74,
	1469,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	74,
	285,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	74,
	286,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	74,
	287,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	74,
	369,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	74,
	370,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	74,
	371,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	75,
	15,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	75,
	203,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	75,
	1097,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	75,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	75,
	807,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	75,
	1500,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	75,
	1573,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	75,
	1594,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	75,
	288,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	75,
	366,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	75,
	1165,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	76,
	720,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	76,
	1079,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	76,
	1523,
	1,
	0.02);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	76,
	254,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	76,
	807,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	76,
	1500,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	76,
	1572,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	76,
	1594,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	76,
	945,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	76,
	1101,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	76,
	344,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	76,
	1163,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	76,
	1439,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	76,
	645,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	76,
	651,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	76,
	653,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	76,
	656,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	77,
	604,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	77,
	720,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	77,
	1384,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	77,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	77,
	807,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	77,
	1500,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	77,
	1573,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	77,
	1594,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	77,
	1438,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	77,
	1467,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	77,
	838,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	77,
	878,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	77,
	879,
	1,
	2);

#N/D
insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	78,
	15,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	78,
	424,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	78,
	1180,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	78,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	78,
	807,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	78,
	1500,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	78,
	1573,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	78,
	1594,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	78,
	945,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	78,
	976,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	78,
	1327,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	78,
	1329,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	78,
	1332,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	78,
	1335,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	79,
	162,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	79,
	277,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	79,
	720,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	79,
	1180,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	79,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	79,
	807,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	79,
	1500,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	79,
	1573,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	79,
	1594,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	79,
	945,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	79,
	1020,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	79,
	344,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	79,
	52,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	79,
	404,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	79,
	405,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	79,
	407,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	79,
	410,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	79,
	411,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	80,
	14,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	80,
	277,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	80,
	424,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	80,
	1180,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	80,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	80,
	807,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	80,
	1500,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	80,
	1573,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	80,
	343,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	80,
	410,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	80,
	653,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	80,
	878,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	80,
	1335,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	81,
	14,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	81,
	1180,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	81,
	1661,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	81,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	81,
	807,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	81,
	1500,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	81,
	1573,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	81,
	822,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	81,
	1453,
	1,
	0.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	81,
	290,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	81,
	656,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	81,
	1563,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	82,
	746,
	1,
	0.75);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	82,
	773,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	82,
	1029,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	82,
	240,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	82,
	632,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	82,
	752,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	82,
	1234,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	82,
	945,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	82,
	1141,
	1,
	1.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	82,
	261,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	82,
	1167,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	82,
	1575,
	1,
	2.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	82,
	134,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	82,
	223,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	82,
	352,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	82,
	736,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	82,
	745,
	1,
	2.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	82,
	830,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	82,
	851,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	82,
	1037,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	82,
	1329,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	82,
	1629,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	82,
	1763,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	82,
	1771,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	83,
	451,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	83,
	561,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	83,
	773,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	83,
	1032,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	83,
	1523,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	83,
	240,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	83,
	1234,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	83,
	948,
	1,
	0.75);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	83,
	956,
	1,
	0.75);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	83,
	261,
	1,
	25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	83,
	1167,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	83,
	1311,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	83,
	752,
	1,
	5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	83,
	1575,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	83,
	137,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	83,
	736,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	83,
	830,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	83,
	932,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	83,
	934,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	83,
	1329,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	83,
	1629,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	83,
	1671,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	83,
	1763,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	84,
	591,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	84,
	773,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	84,
	240,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	84,
	632,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	84,
	752,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	84,
	1234,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	84,
	86,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	84,
	783,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	84,
	947,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	84,
	956,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	84,
	1015,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	84,
	1059,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	84,
	261,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	84,
	1575,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	84,
	300,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	84,
	830,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	84,
	1336,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	84,
	1514,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	84,
	1591,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	84,
	1763,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	85,
	773,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	85,
	1032,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	85,
	240,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	85,
	752,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	85,
	1234,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	85,
	948,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	85,
	956,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	85,
	1059,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	85,
	1141,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	85,
	261,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	85,
	1167,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	85,
	107,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	85,
	137,
	1,
	0.01);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	85,
	830,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	85,
	831,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	85,
	851,
	1,
	0.175);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	85,
	1339,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	85,
	1514,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	85,
	1629,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	86,
	556,
	1,
	0.75);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	86,
	773,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	86,
	1029,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	86,
	240,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	86,
	632,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	86,
	752,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	86,
	1234,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	86,
	158,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	86,
	706,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	86,
	709,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	86,
	948,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	86,
	1265,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	86,
	1313,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	86,
	1349,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	86,
	1409,
	1,
	0.425);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	86,
	261,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	86,
	1167,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	86,
	830,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	86,
	1514,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	86,
	1629,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	86,
	1763,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	87,
	36,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	87,
	773,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	87,
	1032,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	87,
	240,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	87,
	752,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	87,
	1234,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	87,
	261,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	87,
	1167,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	87,
	897,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	87,
	137,
	1,
	0.02);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	87,
	352,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	87,
	540,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	87,
	745,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	87,
	830,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	87,
	932,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	87,
	1037,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	87,
	1038,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	87,
	1039,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	87,
	1329,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	87,
	1772,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	36,
	1,
	200);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	305,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	773,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	843,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	855,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	1029,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	1299,
	1,
	0.005);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	1398,
	1,
	200);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	1402,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	1527,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	1531,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	1556,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	1605,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	240,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	632,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	752,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	1234,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	784,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	956,
	1,
	1.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	1141,
	1,
	5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	1349,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	261,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	1167,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	107,
	1,
	100);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	561,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	45,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	146,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	540,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	650,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	657,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	736,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	830,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	932,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	1039,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	1336,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	1514,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	1629,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	1763,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	88,
	1771,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	89,
	452,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	89,
	773,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	89,
	861,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	89,
	1633,
	1,
	250);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	89,
	240,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	89,
	752,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	89,
	1234,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	89,
	688,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	89,
	709,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	89,
	952,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	89,
	956,
	1,
	1.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	89,
	1059,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	89,
	1141,
	1,
	5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	89,
	1313,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	89,
	261,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	89,
	107,
	1,
	100);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	89,
	561,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	89,
	137,
	1,
	0.02);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	89,
	427,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	89,
	585,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	89,
	650,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	89,
	830,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	89,
	936,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	89,
	1329,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	89,
	1514,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	89,
	1515,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	89,
	1748,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	89,
	1763,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	89,
	1771,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	90,
	706,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	90,
	773,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	90,
	1029,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	90,
	1409,
	1,
	1.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	90,
	240,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	90,
	752,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	90,
	1234,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	90,
	709,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	90,
	952,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	90,
	956,
	1,
	1.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	90,
	1059,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	90,
	1141,
	1,
	5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	90,
	1313,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	90,
	107,
	1,
	100);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	90,
	561,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	90,
	45,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	90,
	59,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	90,
	427,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	90,
	585,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	90,
	745,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	90,
	830,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	90,
	1329,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	90,
	1514,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	90,
	1763,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	13,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	113,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	129,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	144,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	182,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	529,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	1049,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	1181,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	1191,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	1295,
	1,
	0.015);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	1583,
	1,
	0.005);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	1696,
	1,
	0.8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	1707,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	812,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	815,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	1253,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	1638,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	23,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	94,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	237,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	275,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	470,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	475,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	833,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	960,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	1064,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	1274,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	1289,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	1293,
	1,
	0.7);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	1641,
	1,
	0.015);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	341,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	568,
	1,
	0.7);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	801,
	1,
	0.8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	1463,
	1,
	0.015);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	91,
	1777,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	92,
	13,
	1,
	0.005);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	92,
	40,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	92,
	1154,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	92,
	1295,
	1,
	0.8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	92,
	1523,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	92,
	252,
	1,
	0.005);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	92,
	637,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	92,
	741,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	92,
	882,
	1,
	0.005);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	92,
	1092,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	92,
	1114,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	92,
	1211,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	92,
	1501,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	92,
	1594,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	92,
	1759,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	92,
	1257,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	92,
	386,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	92,
	960,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	92,
	961,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	92,
	1641,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	92,
	1780,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	92,
	1792,
	1,
	0.015);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	92,
	346,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	92,
	1537,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	92,
	568,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	92,
	801,
	1,
	0.015);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	13,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	40,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	113,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	129,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	144,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	182,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	529,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	1049,
	1,
	2.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	1154,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	1181,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	1191,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	1295,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	1523,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	1583,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	1696,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	1707,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	252,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	637,
	1,
	0.15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	741,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	882,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	1092,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	1114,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	1211,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	1501,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	1594,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	1759,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	812,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	815,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	1253,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	1257,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	1638,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	23,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	94,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	237,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	275,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	386,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	470,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	475,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	833,
	1,
	1.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	960,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	961,
	1,
	0.8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	1064,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	1274,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	1289,
	1,
	0.015);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	1293,
	1,
	2.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	1641,
	1,
	1.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	1780,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	1792,
	1,
	0.75);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	341,
	1,
	2.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	346,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	1537,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	568,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	801,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	1463,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	93,
	1777,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	19,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	188,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	199,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	527,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	759,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	894,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	1000,
	1,
	1.7);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	1088,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	1098,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	1108,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	1154,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	1295,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	1362,
	1,
	2.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	1523,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	1547,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	1739,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	252,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	637,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	741,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	882,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	1211,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	1501,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	1594,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	1759,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	672,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	1257,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	1379,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	1635,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	23,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	94,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	379,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	413,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	833,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	1504,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	1641,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	975,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	1306,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	568,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	801,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	94,
	1447,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	19,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	249,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	865,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	1049,
	1,
	0.175);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	1124,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	1186,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	1262,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	1300,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	1344,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	1523,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	1707,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	252,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	637,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	741,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	882,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	1211,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	1501,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	1594,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	1759,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	672,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	747,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	792,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	1635,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	94,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	379,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	412,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	945,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	960,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	1215,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	1504,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	1640,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	1780,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	1240,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	801,
	1,
	0.425);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	1005,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	95,
	1448,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	19,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	68,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	526,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	759,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	865,
	1,
	0.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	1088,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	1124,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	1154,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	1184,
	1,
	12);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	1260,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	1362,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	1657,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	637,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	741,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	882,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	1211,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	1501,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	1594,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	1759,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	675,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	1257,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	1376,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	1379,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	94,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	379,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	392,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	473,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	1289,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	1293,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	335,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	1600,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	271,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	568,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	1000,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	1049,
	1,
	0.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	1448,
	1,
	0.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	96,
	1462,
	1,
	1.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	97,
	19,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	97,
	121,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	97,
	170,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	97,
	188,
	1,
	1.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	97,
	659,
	1,
	12);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	97,
	759,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	97,
	1088,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	97,
	1209,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	97,
	1547,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	97,
	1581,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	97,
	1582,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	97,
	1696,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	97,
	1764,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	97,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	97,
	637,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	97,
	741,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	97,
	882,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	97,
	1211,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	97,
	1501,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	97,
	1594,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	97,
	1759,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	97,
	1257,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	97,
	392,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	97,
	470,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	97,
	834,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	97,
	1178,
	1,
	1.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	97,
	1264,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	97,
	346,
	1,
	1.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	97,
	679,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	97,
	863,
	1,
	0.8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	97,
	1169,
	1,
	25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	97,
	801,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	97,
	1449,
	1,
	1.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	98,
	188,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	98,
	190,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	98,
	199,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	98,
	491,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	98,
	492,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	98,
	717,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	98,
	759,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	98,
	890,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	98,
	994,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	98,
	1123,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	98,
	1172,
	1,
	60);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	98,
	1280,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	98,
	1362,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	98,
	1682,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	98,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	98,
	637,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	98,
	741,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	98,
	882,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	98,
	1211,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	98,
	1501,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	98,
	1594,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	98,
	1759,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	98,
	158,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	98,
	709,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	98,
	945,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	98,
	952,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	98,
	1058,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	98,
	1282,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	98,
	568,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	98,
	801,
	1,
	60);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	98,
	883,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	98,
	1005,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	98,
	1449,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	98,
	940,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	13,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	19,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	188,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	199,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	526,
	1,
	0.01);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	759,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	865,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	892,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	1048,
	1,
	0.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	1089,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	1102,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	1124,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	1154,
	1,
	0.01);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	1180,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	1185,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	1201,
	1,
	0.7);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	1204,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	1251,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	1260,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	1307,
	1,
	50);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	1547,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	1739,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	637,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	741,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	882,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	1211,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	1501,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	1594,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	1759,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	375,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	1257,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	1638,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	94,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	379,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	386,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	394,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	475,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	601,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	835,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	902,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	945,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	1175,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	1215,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	1289,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	1293,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	1504,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	1641,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	1654,
	1,
	1.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	322,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	341,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	1601,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	568,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	801,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	1000,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	1446,
	1,
	0.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	99,
	1448,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	100,
	117,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	100,
	200,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	100,
	250,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	100,
	301,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	100,
	525,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	100,
	614,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	100,
	632,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	100,
	753,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	100,
	1239,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	100,
	1576,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	100,
	1594,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	100,
	1622,
	1,
	0.03);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	100,
	1696,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	100,
	1716,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	100,
	1750,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	45,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	57,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	117,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	145,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	197,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	200,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	251,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	260,
	1,
	12);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	284,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	301,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	358,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	481,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	497,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	501,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	525,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	609,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	613,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	614,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	632,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	753,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	772,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	829,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	835,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	839,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	945,
	1,
	5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	1057,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	1067,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	1140,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	1239,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	1309,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	1423,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	1576,
	1,
	25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	1594,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	1598,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	1614,
	1,
	15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	1622,
	1,
	0.03);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	1667,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	1692,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	101,
	1696,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	45,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	57,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	117,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	145,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	197,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	200,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	251,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	260,
	1,
	12);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	291,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	301,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	358,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	481,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	497,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	501,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	525,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	613,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	614,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	632,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	753,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	772,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	829,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	835,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	839,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	945,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	983,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	1014,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	1057,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	1140,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	1239,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	1424,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	1517,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	1576,
	1,
	25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	1594,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	1595,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	1598,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	1614,
	1,
	15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	1622,
	1,
	0.03);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	1631,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	1667,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	1671,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	102,
	1696,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	45,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	57,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	117,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	145,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	197,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	200,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	251,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	260,
	1,
	12);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	301,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	358,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	368,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	481,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	497,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	501,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	525,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	613,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	614,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	632,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	731,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	734,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	736,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	745,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	753,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	772,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	829,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	835,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	935,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	945,
	1,
	5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	1239,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	1422,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	1576,
	1,
	25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	1594,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	1598,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	1614,
	1,
	15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	1622,
	1,
	0.03);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	1667,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	1696,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	103,
	1722,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	45,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	57,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	117,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	145,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	146,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	197,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	200,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	251,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	260,
	1,
	12);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	301,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	353,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	358,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	481,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	497,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	501,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	525,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	613,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	614,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	632,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	646,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	753,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	772,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	835,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	1067,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	1140,
	1,
	5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	1239,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	1419,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	1576,
	1,
	25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	1594,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	1598,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	1617,
	1,
	15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	1622,
	1,
	0.03);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	1667,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	1692,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	1696,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	104,
	1723,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	45,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	57,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	117,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	145,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	197,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	200,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	251,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	260,
	1,
	12);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	283,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	301,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	353,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	358,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	481,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	497,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	501,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	525,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	613,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	614,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	632,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	736,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	753,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	772,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	835,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	1057,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	1140,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	1239,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	1420,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	1559,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	1576,
	1,
	25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	1594,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	1598,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	1614,
	1,
	15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	1622,
	1,
	0.06);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	1667,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	1692,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	1696,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	1722,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	105,
	1724,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	45,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	57,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	117,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	145,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	197,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	200,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	251,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	260,
	1,
	12);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	301,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	358,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	365,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	481,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	497,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	501,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	525,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	613,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	614,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	632,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	686,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	753,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	772,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	808,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	829,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	945,
	1,
	6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	1156,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	1239,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	1421,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	1498,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	1514,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	1522,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	1576,
	1,
	25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	1594,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	1598,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	1614,
	1,
	15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	1622,
	1,
	0.03);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	1667,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	1696,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	106,
	1762,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	45,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	57,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	107,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	117,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	138,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	145,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	197,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	200,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	251,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	260,
	1,
	12);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	301,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	358,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	476,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	481,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	497,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	501,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	525,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	613,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	614,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	632,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	730,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	753,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	772,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	829,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	835,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	945,
	1,
	6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	952,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	1057,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	1239,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	1338,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	1418,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	1562,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	1576,
	1,
	25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	1594,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	1598,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	1614,
	1,
	15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	1622,
	1,
	0.03);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	1667,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	107,
	1696,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	108,
	45,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	108,
	57,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	108,
	138,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	108,
	289,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	108,
	425,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	108,
	497,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	108,
	501,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	108,
	745,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	108,
	835,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	108,
	842,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	108,
	945,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	108,
	1140,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	108,
	1598,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	108,
	1671,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	108,
	1692,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	108,
	1762,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	108,
	1770,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	109,
	192,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	109,
	252,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	109,
	302,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	109,
	881,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	109,
	633,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	109,
	639,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	109,
	853,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	109,
	893,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	109,
	939,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	109,
	945,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	109,
	1010,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	109,
	1017,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	109,
	1213,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	109,
	1242,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	109,
	1319,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	109,
	1331,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	109,
	1667,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	13,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	44,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	62,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	83,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	179,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	188,
	1,
	2.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	199,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	224,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	265,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	386,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	408,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	454,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	475,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	496,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	498,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	500,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	571,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	590,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	794,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	832,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	833,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	893,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	954,
	1,
	2.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	1063,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	1140,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	1180,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	1277,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	1333,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	1410,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	1414,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	1597,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	1640,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	1691,
	1,
	0.15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	1709,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	110,
	1746,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	13,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	44,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	62,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	83,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	179,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	188,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	199,
	1,
	2.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	224,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	265,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	386,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	408,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	454,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	475,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	496,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	498,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	500,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	571,
	1,
	1.7);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	590,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	794,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	832,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	833,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	893,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	954,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	1063,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	1140,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	1180,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	1277,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	1333,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	1410,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	1414,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	1597,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	1640,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	1691,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	1709,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	111,
	1746,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	112,
	13,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	112,
	30,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	112,
	47,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	112,
	48,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	112,
	66,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	112,
	104,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	112,
	224,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	112,
	386,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	112,
	400,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	112,
	429,
	1,
	0.175);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	112,
	454,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	112,
	475,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	112,
	496,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	112,
	498,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	112,
	500,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	112,
	571,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	112,
	649,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	112,
	832,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	112,
	833,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	112,
	893,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	112,
	954,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	112,
	1063,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	112,
	1091,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	112,
	1180,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	112,
	1289,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	112,
	1326,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	112,
	1406,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	112,
	1409,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	112,
	1413,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	112,
	1597,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	112,
	1712,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	112,
	1742,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	113,
	48,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	113,
	188,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	113,
	190,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	113,
	454,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	113,
	496,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	113,
	498,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	113,
	500,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	113,
	571,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	113,
	654,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	113,
	704,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	113,
	710,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	113,
	771,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	113,
	832,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	113,
	833,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	113,
	846,
	1,
	1.7);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	113,
	893,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	113,
	954,
	1,
	0.425);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	113,
	1035,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	113,
	1062,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	113,
	1140,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	113,
	1231,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	113,
	1326,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	113,
	1400,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	113,
	1403,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	113,
	1597,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	113,
	1616,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	113,
	1714,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	113,
	1740,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	113,
	1745,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	13,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	48,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	50,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	114,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	190,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	225,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	222,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	364,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	386,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	388,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	454,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	496,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	498,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	500,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	571,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	615,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	661,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	677,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	745,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	770,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	832,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	850,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	893,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	954,
	1,
	2.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	1050,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	1063,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	1130,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	1140,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	1180,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	1276,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	1317,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	1340,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	1403,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	1410,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	1415,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	1584,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	1597,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	1710,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	1733,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	114,
	1741,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	13,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	29,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	158,
	1,
	0.175);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	163,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	190,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	454,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	571,
	1,
	0.425);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	615,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	702,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	711,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	813,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	814,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	893,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	954,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	1018,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	1063,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	1120,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	1140,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	1173,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	1283,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	1400,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	1409,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	1445,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	1451,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	1468,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	1532,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	1641,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	61,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	579,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	590,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	180,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	47,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	48,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	224,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	352,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	403,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	496,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	498,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	500,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	597,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	832,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	1597,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	1691,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	1713,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	115,
	1744,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	188,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	199,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	454,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	557,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	615,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	770,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	952,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	954,
	1,
	0.175);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	1063,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	1406,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	1409,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	1410,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	1415,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	571,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	893,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	46,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	48,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	136,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	225,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	268,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	300,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	496,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	498,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	500,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	652,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	832,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	845,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	852,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	926,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	927,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	929,
	1,
	0);

#N/D
insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	1510,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	1597,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	1711,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	1734,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	116,
	1773,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	188,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	201,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	454,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	557,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	615,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	793,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	118,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	252,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	598,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	633,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	636,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	1667,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	61,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	580,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	590,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	1584,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	833,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	945,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	1063,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	1406,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	1409,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	1410,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	1415,
	1,
	0.425);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	179,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	364,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	1574,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	571,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	770,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	893,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	48,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	224,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	265,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	352,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	496,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	498,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	500,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	539,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	597,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	661,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	742,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	832,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	852,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	871,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	930,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	931,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	941,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	942,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	1323,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	1330,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	1512,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	1597,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	1693,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	1709,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	1725,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	117,
	1743,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	118,
	22,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	118,
	1127,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	118,
	1297,
	1,
	0.01);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	118,
	1523,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	118,
	1696,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	118,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	118,
	637,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	118,
	741,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	118,
	882,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	118,
	1211,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	118,
	1501,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	118,
	1594,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	118,
	1759,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	118,
	945,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	118,
	1215,
	1,
	60);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	118,
	1494,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	118,
	1640,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	118,
	1787,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	118,
	801,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	13,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	24,
	1,
	0.015);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	143,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	245,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	535,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	865,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	876,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	1049,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	1127,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	1696,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	637,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	741,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	882,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	1211,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	1501,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	1594,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	1759,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	96,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	468,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	900,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	903,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	904,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	945,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	1155,
	1,
	0.01);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	1215,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	1257,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	1264,
	1,
	6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	1290,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	1372,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	1654,
	1,
	5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	547,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	799,
	1,
	45);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	1459,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	119,
	1476,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	12,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	13,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	332,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	759,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	1708,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	637,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	741,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	882,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	1211,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	1501,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	1594,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	1759,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	362,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	375,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	797,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	1208,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	1257,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	94,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	147,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	379,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	415,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	417,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	475,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	945,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	1215,
	1,
	1.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	1271,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	1289,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	1396,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	1640,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	1780,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	125,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	346,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	458,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	568,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	801,
	1,
	15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	803,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	120,
	1005,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	12,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	13,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	528,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	759,
	1,
	2.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	1151,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	1180,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	1294,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	1523,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	1708,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	252,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	637,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	741,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	882,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	1211,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	1501,
	1,
	2.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	1594,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	1759,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	362,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	797,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	1206,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	94,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	147,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	206,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	236,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	379,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	412,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	472,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	624,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	835,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	1215,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	1271,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	1289,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	1396,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	1659,
	1,
	0.001);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	1780,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	1790,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	568,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	801,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	1005,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	121,
	1466,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	122,
	697,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	122,
	759,
	1,
	0.15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	122,
	1708,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	122,
	252,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	122,
	637,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	122,
	741,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	122,
	882,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	122,
	1211,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	122,
	1501,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	122,
	1594,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	122,
	1759,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	122,
	1207,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	122,
	94,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	122,
	236,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	122,
	330,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	122,
	379,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	122,
	415,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	122,
	417,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	122,
	835,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	122,
	1215,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	122,
	1273,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	122,
	1790,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	122,
	213,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	122,
	547,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	122,
	801,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	122,
	1005,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	13,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	29,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	112,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	143,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	193,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	696,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	759,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	1550,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	1570,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	1708,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	1739,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	252,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	637,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	741,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	882,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	1211,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	1501,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	1594,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	1759,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	374,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	1636,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	67,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	94,
	1,
	1.7);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	101,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	147,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	236,
	1,
	2.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	379,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	468,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	628,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	1271,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	1289,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	1652,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	1780,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	801,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	123,
	1476,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	124,
	13,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	124,
	759,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	124,
	1570,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	124,
	1708,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	124,
	252,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	124,
	637,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	124,
	741,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	124,
	882,
	1,
	0.425);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	124,
	1211,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	124,
	1501,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	124,
	1594,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	124,
	1759,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	124,
	816,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	124,
	1257,
	1,
	0.175);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	124,
	379,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	124,
	468,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	124,
	628,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	124,
	334,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	124,
	568,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	124,
	801,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	124,
	895,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	124,
	1005,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	124,
	1445,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	124,
	1466,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	124,
	1476,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	124,
	1480,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	124,
	1497,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	125,
	13,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	125,
	33,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	125,
	76,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	125,
	112,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	125,
	143,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	125,
	759,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	125,
	1551,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	125,
	1570,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	125,
	1739,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	125,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	125,
	637,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	125,
	741,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	125,
	882,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	125,
	1211,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	125,
	1501,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	125,
	1594,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	125,
	1759,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	125,
	375,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	125,
	94,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	125,
	154,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	125,
	236,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	125,
	379,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	125,
	629,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	125,
	1271,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	125,
	1273,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	125,
	1289,
	1,
	1.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	125,
	1783,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	125,
	345,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	125,
	801,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	125,
	1005,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	125,
	1476,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	125,
	1479,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	126,
	13,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	126,
	22,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	126,
	68,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	126,
	112,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	126,
	759,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	126,
	1157,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	126,
	1288,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	126,
	1696,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	126,
	1708,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	126,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	126,
	637,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	126,
	741,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	126,
	882,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	126,
	1211,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	126,
	1501,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	126,
	1594,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	126,
	1759,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	126,
	1359,
	1,
	5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	126,
	1361,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	126,
	1273,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	126,
	379,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	126,
	412,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	126,
	415,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	126,
	468,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	126,
	1215,
	1,
	5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	126,
	1289,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	126,
	568,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	126,
	895,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	126,
	1005,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	13,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	22,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	129,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	281,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	759,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	1127,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	1147,
	1,
	0.001);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	1204,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	1345,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	1708,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	637,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	741,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	882,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	1211,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	1501,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	1594,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	1759,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	819,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	820,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	1256,
	1,
	5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	94,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	379,
	1,
	5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	412,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	415,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	624,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	628,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	1215,
	1,
	5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	1276,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	1289,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	1293,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	1396,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	1659,
	1,
	0.001);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	1780,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	1781,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	1792,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	568,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	801,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	883,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	1005,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	127,
	1460,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	13,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	22,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	759,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	1127,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	1147,
	1,
	0.002);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	1204,
	1,
	1.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	1708,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	637,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	741,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	882,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	1211,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	1501,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	1594,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	1759,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	819,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	820,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	1256,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	94,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	1273,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	217,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	281,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	412,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	415,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	1215,
	1,
	5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	1275,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	1289,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	1293,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	1396,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	1780,
	1,
	12);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	1781,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	1792,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	568,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	801,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	883,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	1005,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	128,
	1460,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	22,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	168,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	528,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	759,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	1204,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	1243,
	1,
	0.005);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	1553,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	1739,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	637,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	741,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	882,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	1211,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	1501,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	1594,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	1759,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	174,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	177,
	1,
	2.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	677,
	1,
	1.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	963,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	964,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	1360,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	1380,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	272,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	379,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	388,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	415,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	442,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	471,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	518,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	628,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	1215,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	1261,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	1275,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	1289,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	1373,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	1686,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	1787,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	1788,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	1790,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	1235,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	568,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	895,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	1005,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	129,
	1477,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	13,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	187,
	1,
	0.002);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	528,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	759,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	980,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	1147,
	1,
	0.001);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	1547,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	1553,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	1701,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	1708,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	1739,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	637,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	741,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	882,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	1211,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	1501,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	1594,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	1759,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	177,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	797,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	1159,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	1352,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	1636,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	94,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	103,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	154,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	384,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	390,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	414,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	415,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	468,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	475,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	1215,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	1276,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	1289,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	1505,
	1,
	0.01);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	1659,
	1,
	0.01);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	1787,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	547,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	801,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	1005,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	130,
	1244,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	131,
	22,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	131,
	168,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	131,
	528,
	1,
	0.15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	131,
	759,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	131,
	1243,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	131,
	1477,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	131,
	1553,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	131,
	1739,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	131,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	131,
	637,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	131,
	741,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	131,
	882,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	131,
	1211,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	131,
	1501,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	131,
	1594,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	131,
	1759,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	131,
	677,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	131,
	964,
	1,
	5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	131,
	1360,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	131,
	155,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	131,
	379,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	131,
	388,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	131,
	415,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	131,
	470,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	131,
	1215,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	131,
	1261,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	131,
	1275,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	131,
	1289,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	131,
	1783,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	131,
	1788,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	131,
	1790,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	131,
	568,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	131,
	895,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	131,
	1005,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	132,
	12,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	132,
	13,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	132,
	129,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	132,
	169,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	132,
	281,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	132,
	759,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	132,
	877,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	132,
	1245,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	132,
	1297,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	132,
	1523,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	132,
	1566,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	132,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	132,
	637,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	132,
	741,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	132,
	882,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	132,
	1211,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	132,
	1501,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	132,
	1594,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	132,
	1759,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	132,
	470,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	132,
	475,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	132,
	945,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	132,
	1273,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	132,
	1653,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	132,
	532,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	132,
	1490,
	1,
	17);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	132,
	1540,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	132,
	801,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	132,
	883,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	132,
	1005,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	12,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	68,
	1,
	0.01);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	165,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	693,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	1048,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	1154,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	1189,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	1294,
	1,
	0.001);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	1523,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	1708,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	637,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	741,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	882,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	1211,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	1501,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	1594,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	1759,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	83,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	94,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	379,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	412,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	475,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	945,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	123,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	347,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	346,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	372,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	456,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	457,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	959,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	977,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	1162,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	1005,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	133,
	1473,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	134,
	13,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	134,
	22,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	134,
	132,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	134,
	169,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	134,
	759,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	134,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	134,
	637,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	134,
	741,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	134,
	882,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	134,
	1211,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	134,
	1501,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	134,
	1594,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	134,
	1759,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	134,
	94,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	134,
	412,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	134,
	470,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	134,
	1276,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	134,
	1653,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	134,
	1027,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	134,
	1491,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	134,
	883,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	134,
	1005,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	135,
	22,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	135,
	244,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	135,
	280,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	135,
	560,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	135,
	1435,
	1,
	5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	135,
	1564,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	135,
	1593,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	135,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	135,
	241,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	135,
	643,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	135,
	1632,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	135,
	1667,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	135,
	1257,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	135,
	436,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	135,
	1565,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	135,
	468,
	1,
	0.02);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	135,
	1241,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	135,
	547,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	135,
	801,
	1,
	5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	135,
	898,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	135,
	1005,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	11,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	13,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	144,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	559,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	564,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	565,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	707,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	883,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	844,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	1005,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	1049,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	1089,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	1127,
	1,
	0.15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	1142,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	1199,
	1,
	6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	1555,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	1564,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	1593,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	1697,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	1704,
	1,
	0.7);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	642,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	643,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	1667,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	1257,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	1635,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	171,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	436,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	1632,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	94,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	105,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	243,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	380,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	900,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	945,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	1175,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	1215,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	1266,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	1304,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	1486,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	1641,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	1780,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	340,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	256,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	801,
	1,
	15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	136,
	1476,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	17,
	1,
	0.002);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	22,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	128,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	168,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	192,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	279,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	312,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	355,
	1,
	0.002);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	363,
	1,
	0.001);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	373,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	506,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	527,
	1,
	0.001);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	528,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	663,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	732,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	768,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	891,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	990,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1041,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1088,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1106,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1124,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1142,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1147,
	1,
	0.001);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1154,
	1,
	0.02);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1204,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1301,
	1,
	0.006);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1523,
	1,
	0.008);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1547,
	1,
	0.01);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1550,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1683,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1695,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1739,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	436,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	642,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	643,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1667,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	375,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1565,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1632,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	29,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	94,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	105,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	228,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	233,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	273,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	379,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	625,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	901,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	945,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1014,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1058,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1140,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1215,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1263,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1269,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1276,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1284,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1485,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1495,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1496,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1519,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1640,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1641,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1658,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1780,
	1,
	6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1489,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	255,
	1,
	6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1241,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1387,
	1,
	15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	577,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	799,
	1,
	15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	895,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1005,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1459,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	137,
	1478,
	1,
	5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	13,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	22,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	164,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	192,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	197,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	246,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	292,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	357,
	1,
	0.001);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	621,
	1,
	0.002);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	669,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	690,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	759,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	762,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	916,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	1089,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	1142,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	1147,
	1,
	0.001);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	1154,
	1,
	0.002);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	1197,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	1204,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	1301,
	1,
	0.008);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	1362,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	1523,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	1557,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	1683,
	1,
	0.001);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	1696,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	1707,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	1708,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	255,
	1,
	6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	436,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	642,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	643,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	1387,
	1,
	15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	1565,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	1632,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	1667,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	1257,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	1377,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	1380,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	94,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	147,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	272,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	379,
	1,
	6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	421,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	439,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	518,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	709,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	833,
	1,
	0.002);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	844,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	848,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	870,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	880,
	1,
	0.001);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	960,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	961,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	1014,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	1140,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	1173,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	1215,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	1263,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	1276,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	1289,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	1312,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	1348,
	1,
	5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	1640,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	1780,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	1790,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	572,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	801,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	893,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	895,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	138,
	1478,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	9,
	1,
	0.002);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	22,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	128,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	168,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	192,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	278,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	312,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	355,
	1,
	0.02);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	363,
	1,
	0.001);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	373,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	506,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	527,
	1,
	0.001);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	528,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	577,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	662,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	732,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	768,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	891,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	990,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1041,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1088,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1106,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1124,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1142,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1147,
	1,
	0.001);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1154,
	1,
	0.002);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1204,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1301,
	1,
	0.006);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1523,
	1,
	0.008);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1547,
	1,
	0.01);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1557,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1683,
	1,
	0.001);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1695,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1739,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	255,
	1,
	6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	436,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	642,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	643,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1387,
	1,
	15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1565,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1632,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1667,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	375,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	29,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	94,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	105,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	228,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	233,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	273,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	379,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	625,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	901,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	945,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1014,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1058,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1140,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1215,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1263,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1269,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1276,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1284,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1485,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1495,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1496,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1519,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1640,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1641,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1658,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1780,
	1,
	6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1489,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	799,
	1,
	15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	895,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1005,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1459,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	139,
	1478,
	1,
	5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	18,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	13,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	164,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	188,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	221,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	528,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	664,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	759,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	1204,
	1,
	0.35);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	1245,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	1366,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	1550,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	1552,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	1547,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	1708,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	1739,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	436,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	642,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	643,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	1667,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	375,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	439,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	1393,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	94,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	228,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	272,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	379,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	390,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	420,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	472,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	625,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	833,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	945,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	1140,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	1276,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	1289,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	1293,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	1640,
	1,
	1.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	1780,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	1792,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	801,
	1,
	9);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	1005,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	140,
	1473,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	141,
	13,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	141,
	22,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	141,
	324,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	141,
	980,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	141,
	1124,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	141,
	1550,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	141,
	1547,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	141,
	1580,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	141,
	252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	141,
	436,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	141,
	642,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	141,
	643,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	141,
	1667,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	141,
	465,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	141,
	466,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	141,
	1257,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	141,
	1673,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	141,
	94,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	141,
	153,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	141,
	272,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	141,
	379,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	141,
	390,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	141,
	415,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	141,
	600,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	141,
	1103,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	141,
	1217,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	141,
	1271,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	141,
	1289,
	1,
	6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	141,
	1640,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	141,
	1780,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	141,
	1792,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	141,
	1005,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	142,
	13,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	142,
	22,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	142,
	164,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	142,
	587,
	1,
	0.02);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	142,
	1124,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	142,
	1245,
	1,
	0.01);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	142,
	1481,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	142,
	1708,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	142,
	252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	142,
	436,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	142,
	642,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	142,
	643,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	142,
	1667,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	142,
	1256,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	142,
	1377,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	142,
	1374,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	142,
	1690,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	142,
	94,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	142,
	106,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	142,
	272,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	142,
	379,
	1,
	6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	142,
	393,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	142,
	628,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	142,
	1215,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	142,
	1225,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	142,
	1271,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	142,
	1289,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	142,
	1654,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	142,
	1780,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	142,
	801,
	1,
	15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	142,
	1005,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	143,
	22,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	143,
	188,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	143,
	980,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	143,
	1552,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	143,
	1739,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	143,
	252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	143,
	436,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	143,
	642,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	143,
	643,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	143,
	1667,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	143,
	1377,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	143,
	438,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	143,
	94,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	143,
	379,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	143,
	628,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	143,
	1062,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	143,
	1215,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	143,
	1269,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	143,
	1271,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	143,
	1289,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	143,
	1780,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	143,
	577,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	143,
	801,
	1,
	20);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	22,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	168,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	172,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	188,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	309,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	313,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	333,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	726,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	883,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	916,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	1197,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	1708,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	436,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	642,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	643,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	1667,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	966,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	1533,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	1636,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	1252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	1370,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	83,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	94,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	214,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	379,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	472,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	709,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	870,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	1015,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	1140,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	1289,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	1348,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	1654,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	1780,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	1790,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	577,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	799,
	1,
	5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	144,
	1478,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	17,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	22,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	128,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	132,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	164,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	282,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	311,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	918,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	320,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	916,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	1132,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	1204,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	1371,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	1663,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	255,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	436,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	642,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	643,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	1565,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	1632,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	1667,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	171,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	440,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	758,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	1370,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	94,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	106,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	207,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	379,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	625,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	945,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	1047,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	1058,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	1140,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	1215,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	1245,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	1263,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	1271,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	1289,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	1640,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	1641,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	1780,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	1539,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	799,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	883,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	1005,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	145,
	1775,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	22,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	168,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	172,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	188,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	309,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	313,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	333,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	726,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	916,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	1197,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	1708,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	436,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	642,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	643,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	1667,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	966,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	1533,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	1636,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	1252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	1370,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	83,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	94,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	214,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	379,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	475,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	709,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	870,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	1015,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	1140,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	1289,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	1348,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	1654,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	1780,
	1,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	1790,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	577,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	799,
	1,
	5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	883,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	146,
	1478,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	147,
	22,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	147,
	188,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	147,
	190,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	147,
	308,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	147,
	310,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	147,
	316,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	147,
	319,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	147,
	356,
	1,
	0.005);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	147,
	574,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	147,
	621,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	147,
	759,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	147,
	994,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	147,
	1362,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	147,
	1390,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	147,
	1449,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	147,
	1543,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	147,
	1586,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	147,
	252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	147,
	436,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	147,
	642,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	147,
	643,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	147,
	1358,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	147,
	1387,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	147,
	1667,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	147,
	713,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	147,
	1015,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	147,
	1058,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	147,
	1140,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	147,
	577,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	147,
	801,
	1,
	15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	147,
	883,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	147,
	1005,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	22,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	164,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	190,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	192,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	314,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	315,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	356,
	1,
	0.005);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	357,
	1,
	0.003);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	506,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	575,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	621,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	768,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	887,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	892,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	1100,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	1136,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	1362,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	1388,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	1389,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	1569,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	1608,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	1610,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	1611,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	1739,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	252,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	255,
	1,
	10);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	436,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	642,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	643,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	1241,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	1387,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	1565,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	1632,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	1667,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	701,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	709,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	833,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	870,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	945,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	1015,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	1058,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	1140,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	1269,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	1348,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	577,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	801,
	1,
	12);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	883,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	148,
	1007,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	13,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	22,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	29,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	168,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	190,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	192,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	264,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	311,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	317,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	318,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	363,
	1,
	0.01);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	576,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	608,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	668,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	670,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	698,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	768,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	811,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	856,
	1,
	5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	866,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	916,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	980,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1089,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1131,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1147,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1197,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1200,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1204,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1247,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1362,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1547,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1551,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1553,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1569,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1585,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1587,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1588,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1610,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1707,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1708,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1739,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	255,
	1,
	6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	436,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	581,
	1,
	60);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	642,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	643,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1356,
	1,
	6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1357,
	1,
	6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1241,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1387,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1565,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1577,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1632,
	1,
	0);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1667,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1688,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	465,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	816,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1257,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1377,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1378,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1638,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	171,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1394,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	94,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	154,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	215,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	273,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	276,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	379,
	1,
	6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	390,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	415,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	468,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	618,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	628,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	713,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	870,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1015,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1046,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1062,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1140,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1143,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1175,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1187,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1215,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1264,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1271,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1304,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1348,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1485,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1654,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1780,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1790,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1792,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1492,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	994,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1005,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	149,
	1775,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	13,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	19,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	128,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	166,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	190,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	192,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	266,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	486,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	488,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	523,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	739,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	759,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	809,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	994,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	1127,
	1,
	0.15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	1142,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	1552,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	1570,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	1681,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	1708,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	1739,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	637,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	741,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	882,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	1211,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	1501,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	1594,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	1759,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	677,
	1,
	1.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	796,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	797,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	91,
	1,
	0.08);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	149,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	161,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	381,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	416,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	419,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	624,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	627,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	681,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	704,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	714,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	837,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	1223,
	1,
	1.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	1271,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	1285,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	1289,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	1520,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	1646,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	1653,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	1785,
	1,
	0.5);

#N/D
insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	1541,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	1087,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	1241,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	1665,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	550,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	577,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	799,
	1,
	30);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	883,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	1010,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	150,
	1473,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	13,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	22,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	32,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	110,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	167,
	2,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	187,
	1,
	0.001);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	190,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	192,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	281,
	1,
	0.8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	327,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	354,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	355,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	486,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	513,
	1,
	0.01);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	528,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	647,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	722,
	1,
	0.45);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	728,
	2,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	739,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	759,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	776,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	859,
	2,
	6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	880,
	1,
	0.02);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	923,
	1,
	0.06);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	980,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1049,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1113,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1148,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1183,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1204,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1303,
	1,
	0.12);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1386,
	2,
	40);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1528,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1552,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1634,
	1,
	0.09);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1647,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1669,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1685,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1696,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1708,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1728,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1739,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	637,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	741,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	882,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1211,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1501,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1594,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1759,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	437,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	826,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	970,
	2,
	2.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1392,
	1,
	0.15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1401,
	1,
	5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	79,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	89,
	2,
	0.04);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	92,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	150,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	228,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	229,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	379,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	381,
	2,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	389,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	415,
	1,
	0.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	684,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	705,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	904,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	910,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	950,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	985,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1060,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1121,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1223,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1270,
	1,
	0.7);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1271,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1271,
	2,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1273,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1289,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1289,
	2,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1293,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1396,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1652,
	1,
	1.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1653,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1780,
	2,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1786,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1791,
	2,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1795,
	1,
	0.9);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1798,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	127,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	321,
	1,
	0.8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	323,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	461,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	531,
	1,
	5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	873,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1087,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1665,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	550,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	577,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	799,
	1,
	50);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	883,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1003,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1010,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	151,
	1451,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	13,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	22,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	32,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	110,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	167,
	2,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	187,
	1,
	0.001);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	190,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	192,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	281,
	1,
	0.8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	327,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	354,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	355,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	486,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	513,
	1,
	0.01);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	528,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	647,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	722,
	1,
	0.45);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	728,
	2,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	739,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	759,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	776,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	859,
	2,
	6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	880,
	1,
	0.02);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	923,
	1,
	0.06);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	980,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1049,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1148,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1183,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1204,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1303,
	1,
	0.12);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1386,
	2,
	40);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1528,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1552,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1634,
	1,
	0.09);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1647,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1669,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1685,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1696,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1708,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1728,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1739,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	637,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	741,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	882,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1211,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1501,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1594,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1759,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	437,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	826,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	970,
	2,
	2.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1392,
	1,
	0.15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1401,
	1,
	5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	79,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	89,
	2,
	0.04);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	92,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	150,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	228,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	229,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	379,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	381,
	2,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	389,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	415,
	1,
	0.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	684,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	705,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	904,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	910,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	950,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	985,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1060,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1121,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1223,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1270,
	1,
	0.7);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1271,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1271,
	2,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1273,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1289,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1289,
	2,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1293,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1396,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1652,
	1,
	1.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1653,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1780,
	2,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1786,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1791,
	2,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1795,
	1,
	0.9);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1798,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	127,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	321,
	1,
	0.8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	323,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	461,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	531,
	1,
	5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	873,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1087,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1113,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1665,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	550,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	577,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	799,
	1,
	50);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	883,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1003,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1010,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	152,
	1451,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	13,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	19,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	21,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	190,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	192,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	242,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	304,
	1,
	0.01);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	354,
	1,
	0.002);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	486,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	488,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	513,
	1,
	0.012);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	524,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	528,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	535,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	554,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	647,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	739,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	758,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	759,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	847,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	858,
	2,
	6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	880,
	1,
	0.005);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	923,
	1,
	0.07);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	980,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1127,
	1,
	0.15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1144,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1154,
	1,
	0.03);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1164,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1182,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1385,
	2,
	40);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1434,
	2,
	1.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1553,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1647,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1669,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1681,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1702,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1703,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1708,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1728,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1739,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	637,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	741,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	882,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1211,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1501,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1594,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1759,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	542,
	1,
	5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	797,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	979,
	1,
	3.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1636,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	90,
	2,
	0.04);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	93,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	105,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	148,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	161,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	229,
	1,
	6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	379,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	379,
	2,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	414,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	415,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	418,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	468,
	1,
	0.04);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	627,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	683,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	705,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	713,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	906,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	912,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	950,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1013,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1060,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1121,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1137,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1140,
	1,
	1.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1223,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1267,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1271,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1289,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1289,
	2,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1396,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1520,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1642,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1646,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1652,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1653,
	2,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1676,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1789,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1794,
	1,
	0.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1800,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1071,
	2,
	8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1665,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	550,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	577,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	801,
	1,
	40);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	883,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	899,
	2,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1010,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1010,
	2,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1021,
	1,
	0.7);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1458,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1466,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1480,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	153,
	1708,
	2,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	13,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	19,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	21,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	190,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	192,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	304,
	1,
	0.01);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	354,
	1,
	0.002);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	486,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	488,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	513,
	1,
	0.012);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	524,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	528,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	528,
	2,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	535,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	554,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	647,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	739,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	758,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	759,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	847,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	858,
	2,
	6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	880,
	1,
	0.005);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	923,
	1,
	0.07);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	980,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1127,
	1,
	0.15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1144,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1154,
	1,
	0.03);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1164,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1182,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1385,
	2,
	40);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1553,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1553,
	2,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1647,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1669,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1681,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1702,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1703,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1708,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1728,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1739,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	252,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	637,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	741,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	882,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1211,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1501,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1594,
	1,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1759,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	542,
	1,
	5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	797,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	979,
	1,
	3.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1589,
	2,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1636,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1636,
	2,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	90,
	2,
	0.04);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	93,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	105,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	148,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	161,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	229,
	1,
	6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	379,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	379,
	2,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	388,
	2,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	414,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	415,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	415,
	2,
	0.8);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	418,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	468,
	1,
	0.04);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	627,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	683,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	705,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	713,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	905,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	912,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	950,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1013,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1060,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1121,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1137,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1140,
	1,
	1.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1223,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1223,
	2,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1267,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1271,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1271,
	2,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1289,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1396,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1520,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1643,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1646,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1652,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1676,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1789,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1789,
	2,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1794,
	1,
	0.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1800,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	242,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1665,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	550,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	577,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	801,
	1,
	40);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	883,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1010,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1021,
	1,
	0.7);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1458,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1466,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1480,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	154,
	1739,
	2,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	13,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	19,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	30,
	1,
	0.15);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	30,
	2,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	37,
	1,
	1.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	60,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	133,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	166,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	190,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	192,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	266,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	293,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	304,
	1,
	0.02);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	327,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	355,
	1,
	0.03);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	415,
	2,
	0.6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	480,
	1,
	0.005);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	486,
	1,
	0.3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	488,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	515,
	1,
	0.032);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	551,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	605,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	671,
	2,
	5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	718,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	739,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	759,
	1,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	847,
	1,
	0.5);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	857,
	2,
	6);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	923,
	1,
	0.06);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	980,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	1195,
	1,
	2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	1204,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	1308,
	1,
	0.1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	1341,
	1,
	0.25);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	1386,
	2,
	40);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	1478,
	2,
	4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	1550,
	2,
	3);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	1571,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	1634,
	1,
	0.09);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	1648,
	1,
	0.4);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	1665,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	1669,
	1,
	0.05);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	1681,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	1695,
	1,
	0.2);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	1708,
	1,
	1);

insert into config_taller (
	id_taller,
	id_producto,
	cod_agrupador,
	cantidad)
values (
	155,
	1,
