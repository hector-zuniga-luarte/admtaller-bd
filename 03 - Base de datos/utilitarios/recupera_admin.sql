
/* Inicio script que restaura los datos del usuario admin a sus "datos iniciales de fábrica" incluyendo la contraseña por defecto */
update usuario
set login = 'admin@duoc.cl',
    hash_password = 'c16fd958b85a1c94d872c219ea06ce8e80223239b1fcefb92ad978445ef095507244be44caae1d766e277b072c184cb3ffe4d0610716e989b2fe5a7c97bf3144', /* SD:72-03 */
	primer_apellido = 'Administrador',
	segundo_apellido = '',
	nom = 'del sistema',
	nom_preferido = 'admin',
	cod_perfil = 0,
	cod_carrera = null
where id_usuario = 1;

commit;
/* Fin script que restaura los datos del usuario admin a sus "datos iniciales de fábrica" incluyendo la contraseña por defecto */
