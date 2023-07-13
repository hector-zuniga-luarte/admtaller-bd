
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
