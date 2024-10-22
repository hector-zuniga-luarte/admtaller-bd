
/* Script para generar datos de detalle de ejecución de talleres con precios un 10% menos */
insert into det_regis_taller
select rt.fecha as fecha,
	rt.ano_academ as ano_academ,
    rt.cod_periodo_academ as cod_periodo_academ,
    rt.sigla as sigla,
    rt.seccion as seccion,
    rt.id_taller as id_taller,
    ct.id_producto as id_producto,
    p.precio as precio,
    ct.cantidad as cantidad
from regis_taller rt
join config_taller ct on ct.id_taller = rt.id_taller
join producto p on ct.id_producto = p.id_producto
where rt.fecha = '2023-05-27' and
	rt.ano_academ = 2023 and
    rt.cod_periodo_academ = 1 and
    rt.sigla = 'ABT3131' and
    rt.seccion = 3 and
    rt.id_taller = 93
