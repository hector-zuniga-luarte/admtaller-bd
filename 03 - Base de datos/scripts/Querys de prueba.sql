
/* Querys para prueba de registro */

/* Cantidad de registros de docentes */
select count(*)
from regis_taller;

/* Cantidad de productos registrados */
select count(*)
from det_regis_taller;




/* Querys de prueba */
select *
from config_taller
where cod_agrupador <> 0;

select p.nom_producto as producto,
	cp.nom_categ_producto as categoria,
    ct.cantidad as cantidad,
    um.nom_unidad_medida_abrev as unidad,
    p.precio as precio_unit,
    p.precio * ct.cantidad as sub_total,
    a.nom_agrupador as agrupador
from config_taller ct,
	producto p,
    categ_producto cp,
    unidad_medida um,
    agrupador a
where a.cod_agrupador = ct.cod_agrupador and
	p.cod_unidad_medida = um.cod_unidad_medida and
	ct.id_producto = p.id_producto and
	p.cod_categ_producto = cp.cod_categ_producto and
	ct.id_taller = 151
order by a.nom_agrupador asc,
	cp.nom_categ_producto asc,
    p.nom_producto asc;


select *
from taller
where sigla = "ABT3131"
order by semana asc


select u.id_usuario as id_usuario,
    u.login as login,
    null as hash_password,
    u.primer_apellido as primer_apellido,
    u.segundo_apellido as segundo_apellido,
    u.nom as nom,
    u.nom_preferido as nom_preferido,
    u.cod_perfil as cod_perfil,
    u.cod_carrera as cod_carrera,
    p.nom_perfil as nom_perfil,
    c.nom_carrera as nom_carrera
from usuario u,
	perfil p,
    carrera c
where u.cod_perfil = p.cod_perfil and
    u.cod_carrera = c.cod_carrera and
    id_usuario = 2;



/* Query para primera página que muestra las asignaturas en las que el profesor al menos tiene una asignación de asignatura */
select distinct pa.ano_academ as ano_academ,
	pa.cod_periodo_academ as cod_periodo_academ,
    pa.sigla as sigla,
    a.nom_asign as nom_asign,
    pa.seccion as seccion
from prog_asign pa
join prog_taller pt on pa.ano_academ = pt.ano_academ and pa.cod_periodo_academ = pt.cod_periodo_academ and pa.sigla = pt.sigla and pa.seccion = pt.seccion
join asign a on pa.sigla = a.sigla
where pt.id_usuario = 3 and
	pa.ano_academ = 2023
    
/* Query para segunda página que muestra los talleres programados con ese profesor asignado */
select pt.fecha as fecha,
    t.semana as semana,
    t.titulo_preparacion as titulo_preparacion
from prog_taller pt
join taller t on pt.id_taller = t.id_taller
where pt.ano_academ = 2023;


/* Desarrollo registro de talleres */

/* Query para primera página que muestra las asignaturas en las que el profesor al menos tiene una asignación de asignatura */
select distinct pa.ano_academ as ano_academ,
	pa.cod_periodo_academ as cod_periodo_academ,
    pa.sigla as sigla,
    a.nom_asign as nom_asign,
    pa.seccion as seccion
from prog_asign pa
join prog_taller pt on pa.ano_academ = pt.ano_academ and pa.cod_periodo_academ = pt.cod_periodo_academ and pa.sigla = pt.sigla and pa.seccion = pt.seccion
join asign a on pa.sigla = a.sigla
where pt.id_usuario = 3 and
	pa.ano_academ = 2023


   
/* Query para segunda página que muestra los talleres programados con ese profesor asignado */
select pt.fecha as fecha,
    t.semana as semana,
    t.titulo_preparacion as titulo_preparacion,
    pt.id_taller as id_taller,
    u.nom_preferido as nom_preferido,
    u.primer_apellido as primer_apellido,
    u.segundo_apellido as segundo_apellido,
    (case
		when pt.id_usuario = 3 then 0
        else 1
        end) as indicador_usuario,
	(select count(*)
    from regis_taller rt
    where rt.fecha = pt.fecha and
			rt.ano_academ = pt.ano_academ and
			rt.cod_periodo_academ = pt.cod_periodo_academ and
			rt.sigla = pt.sigla and
			rt.seccion = pt.seccion and
			rt.id_taller = pt.id_taller) as indicador_registro
from prog_taller pt
join taller t on pt.id_taller = t.id_taller
join usuario u on pt.id_usuario = u.id_usuario
where pt.ano_academ = 2023 and
	pt.cod_periodo_academ = 1 and
    pt.sigla = 'ABT3131' and
    pt.seccion = 3
order by pt.fecha asc,
	t.semana asc;

