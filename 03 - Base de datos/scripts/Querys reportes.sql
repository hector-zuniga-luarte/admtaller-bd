
/* Reporte 1: Valorización por taller */
select c.nom_carrera as nom_carrera,
	a.sigla as sigla,
	a.nom_asign as nom_asign,
    t.semana as semana,
    t.titulo_preparacion as titulo_preparacion,
    round(sum(p.precio * ct.cantidad), 0) as total_taller
from asign a
join taller t on t.sigla = a.sigla
join config_taller ct on t.id_taller = ct.id_taller
join producto p on ct.id_producto = p.id_producto
join carrera c on a.cod_carrera = c.cod_carrera
where c.cod_carrera = 1
group by c.nom_carrera,
	a.sigla,
	a.nom_asign,
    t.semana,
    t.titulo_preparacion
order by c.cod_carrera asc,
	a.sigla asc,
    t.semana asc;

/* Reporte2 : Presupuesto estimado por asignatura */
select c.nom_carrera as nom_carrera,
	pa.sigla as sigla,
    a.nom_asign as nom_asign,
	count(pa.seccion) as total_seccion,
    (select round(sum(pr.precio * cota.cantidad), 0)
		from config_taller cota
		join producto pr on cota.id_producto = pr.id_producto
		join taller ta on cota.id_taller = ta.id_taller
		where ta.sigla = pa.sigla) as total_asign,
    (count(pa.seccion) * (select round(sum(pr.precio * cota.cantidad), 0) as total_taller
                            from config_taller cota
                            join producto pr on cota.id_producto = pr.id_producto
                            join taller ta on cota.id_taller = ta.id_taller
                            where ta.sigla = pa.sigla)) as total
from prog_asign pa
join asign a on pa.sigla = a.sigla
join carrera c on a.cod_carrera = c.cod_carrera
where pa.ano_academ = 2023
group by pa.sigla
order by c.cod_carrera asc,
	a.sigla asc;

/* Reporte 3: Asignación y registro de docentes */
select c.nom_carrera as nom_carrera,
	u.primer_apellido as primer_apellido,
	u.segundo_apellido as segundo_apellido,
    u.nom_preferido as nom_preferido,
    (case
		when pt.sigla is not null then pt.sigla
        else '(Sin asignación)'
        end) as sigla,
    pt.seccion as seccion,
    pa.nom_periodo_academ as nom_periodo_academ,
  	count(pt.id_taller) as total_taller_asignado,
    count(rt.id_taller) as total_taller_registrado,
    (case
		when pt.sigla is not null then 0
        else 1
        end) as orden_asignacion
from prog_taller pt
right outer join usuario u on pt.id_usuario = u.id_usuario
left outer join regis_taller rt on pt.fecha = rt.fecha and pt.ano_academ = rt.ano_academ and pt.cod_periodo_academ = rt.cod_periodo_academ and pt.sigla = rt.sigla and pt.seccion = rt.seccion and pt.id_taller = rt.id_taller and pt.id_usuario = rt.id_usuario
join carrera c on u.cod_carrera = c.cod_carrera
left outer join periodo_academ pa on pt.cod_periodo_academ = pa.cod_periodo_academ
where (pt.ano_academ = 2023 or pt.ano_academ is null) and
	u.cod_perfil = 2
group by c.nom_carrera,
	u.primer_apellido,
	u.segundo_apellido,
    u.nom_preferido,
    pt.sigla,
    pt.seccion,
    pa.nom_periodo_academ
order by c.cod_carrera asc,
	orden_asignacion asc,
	pt.sigla asc,
    pa.cod_periodo_academ asc,
	u.primer_apellido asc,
    u.segundo_apellido asc,
    u.nom_preferido asc;

/* Reporte 4: Resumen por producto para un período de tiempo */
select cp.nom_categ_producto as nom_categ_producto,
	ct.id_producto as id_producto,
    p.nom_producto as nom_producto,
    sum(ct.cantidad) as cantidad_producto,
    sum(p.precio) as precio_producto,
    sum(ct.cantidad) * sum(p.precio) as precio_total_producto
from prog_taller pt,
    config_taller ct,
    producto p,
    categ_producto cp
where p.cod_categ_producto = cp.cod_categ_producto and
	ct.id_producto = p.id_producto and
	pt.id_taller = ct.id_taller and
	pt.fecha between '2024-04-15' and '2024-04-21'
group by cp.nom_categ_producto,
	ct.id_producto,
    p.nom_producto
order by cp.nom_categ_producto asc,
	p.nom_producto asc,
	pt.fecha asc,
	pt.sigla asc,
    pt.seccion asc;

/* Reporte 5: Detalle por producto y taller para un período de tiempo */
select cp.nom_categ_producto as nom_categ_producto,
	ct.id_producto as id_producto,
    p.nom_producto as nom_producto,
    ct.cantidad as cantidad,
    p.precio as precio,
    (ct.cantidad * p.precio) as precio_total,
    pt.fecha as fecha,
	pt.ano_academ as ano_academ,
	pt.cod_periodo_academ as cod_periodo_academ,
    pt.sigla as sigla,
    a.nom_asign as nom_asign,
    pt.seccion as seccion,
    t.semana,
    t.titulo_preparacion as titulo_preparacion
from prog_taller pt,
	asign a,
    config_taller ct,
    taller t,
    producto p,
    categ_producto cp
where p.cod_categ_producto = cp.cod_categ_producto and
	ct.id_producto = p.id_producto and
	pt.id_taller = t.id_taller and
	pt.sigla = t.sigla and
	pt.sigla = a.sigla and
	pt.id_taller = ct.id_taller and
	pt.fecha between '2024-04-15' and '2024-04-21'
order by cp.nom_categ_producto asc,
	p.nom_producto asc,
	pt.fecha asc,
	pt.sigla asc,
    pt.seccion asc,
    t.semana asc;
