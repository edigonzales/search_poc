--SELECT 
--	'ch.so.agi.av.gebaeudeadressen.gebaeudeeingaenge' AS class,
--	adr.t_id::text AS id_in_class,
--	strassenname AS streetname, 
--	CASE 
--		WHEN regexp_replace(hausnummer, '\d', '', 'g') = '' THEN '0' 
--		ELSE regexp_replace(hausnummer, '\d', '', 'g') 
--	END AS streetnumber_appendix, 
--	regexp_replace(hausnummer, E'\\D','','g')::int AS streetnumber_prefix, 
--	ortschaft AS city, 
--	strassenname || ' ' || hausnummer || ', ' || plz::text || ' ' || ortschaft || ' (Adresse)' AS displaytext, 
--	LOWER(replace(replace(strassenname || ' ' || hausnummer || ' ' || plz::text || ' ' || ortschaft, '-', ' '), '.',' ')) AS searchtext_1 
--FROM 
--	agi_mopublic_pub.mopublic_gebaeudeadresse AS adr 
--	LEFT JOIN agi_mopublic_pub.mopublic_gemeindegrenze AS gem 
--	ON ST_Intersects(adr.lage, gem.geometrie)
--WHERE hausnummer ~ E'^\\d+$';
--;


SELECT 
	'ch.so.agi.av.gebaeudeadressen.gebaeudeeingaenge' AS class,
	t_id AS id_in_class,
	strassenname || ' ' || hausnummer || ', ' || plz || ' ' || ortschaft || ' (Adresse)' AS displaytext,
	LOWER(strassenname || ' ' || hausnummer || ' ' || plz || ' ' || ortschaft) AS searchtext_1
FROM agi_mopublic_pub.mopublic_gebaeudeadresse
;


--SELECT 
--	'ch.so.agi.av.gebaeudeadressen.gebaeudeeingaenge' AS class,
--	t_id AS id_in_class,
--	strassenname || ' ' || hausnummer || ', ' || plz || ' ' || ortschaft || ' (Adresse)' AS displaytext,
--	LOWER(strassenname || ' ' || hausnummer || ' ' || plz || ' ' || ortschaft) AS searchtext_1,
--	to_tsvector(LOWER(strassenname || ' ' || hausnummer || ' ' || plz || ' ' || ortschaft)) AS vec_1
--FROM agi_mopublic_pub.mopublic_gebaeudeadresse
--;
