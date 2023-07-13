
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
    obs                 varchar(500) not null comment "Eventuales comentarios a la ejecución del taller" default 'Sin observaciones',
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
