DROP FUNCTION IF EXISTS tok3
;

CREATE FUNCTION tok3(user_input TEXT)
RETURNS TABLE(displaytext_v TEXT, class_v TEXT, id_in_class_v INTEGER, query_tokens_v TEXT, word_similarity_v REAL) AS 
'
DECLARE
	input_lower TEXT := LOWER(user_input);
	tok1 TEXT := split_part(input_lower, '' '', 1);
	tok2 TEXT := split_part(input_lower, '' '', 2);
	tok3 TEXT := split_part(input_lower, '' '', 3);
BEGIN
	RETURN QUERY
	    SELECT
			displaytext || ''                            |||'' AS displaytext_v, 
			class AS class_v,
			id_in_class AS id_in_class_v,
			tok1 || '' | '' || tok2  || '' | '' || tok3 AS query_tokens_v,
			CAST (
				100 *  COALESCE(word_similarity(tok1, searchtext_1) + word_similarity(tok2, searchtext_1) + word_similarity(tok3, searchtext_1), 0) + 
				10 * COALESCE(word_similarity(tok1, searchtext_2) + word_similarity(tok2, searchtext_2) + word_similarity(tok3, searchtext_2), 0) +
				1 * COALESCE(word_similarity(tok1, searchtext_3) + word_similarity(tok2, searchtext_3) + word_similarity(tok3, searchtext_3), 0)
			AS REAL) AS hit_index_v
		FROM 
			public.searchobjects
		WHERE (
			searchtext_1 LIKE ''%'' || tok1 || ''%''
				AND
					searchtext_1 LIKE ''%'' || tok2 || ''%''
						AND	
							searchtext_1 LIKE ''%'' || tok3 || ''%'' 
		)
		OR (
			searchtext_2 LIKE ''%'' || tok1 || ''%''
				AND
					searchtext_2 LIKE ''%'' || tok2 || ''%''
						AND	
							searchtext_2 LIKE ''%'' || tok3 || ''%''
		)
		OR (
			searchtext_3 LIKE ''%'' || tok1 || ''%''
				AND
					searchtext_3 LIKE ''%'' || tok2 || ''%''
						AND	
							searchtext_3 LIKE ''%'' || tok3 || ''%''
		)
		ORDER BY 
				100 *  COALESCE(word_similarity(tok1, searchtext_1) + word_similarity(tok2, searchtext_1) + word_similarity(tok3, searchtext_1), 0) + 
				10 * COALESCE(word_similarity(tok1, searchtext_2) + word_similarity(tok2, searchtext_2) + word_similarity(tok3, searchtext_2), 0) +
				1 * COALESCE(word_similarity(tok1, searchtext_3) + word_similarity(tok2, searchtext_3) + word_similarity(tok3, searchtext_3), 0)
					DESC
		LIMIT 51
	;
END;
' LANGUAGE plpgsql
;
--
--
--CREATE FUNCTION tok3(user_input TEXT)
--RETURNS TABLE(displaytext_v TEXT, class_v TEXT, id_in_class_v INTEGER, query_tokens_v TEXT, word_similarity_v REAL) AS $$
--DECLARE
--	input_lower TEXT := LOWER(user_input);
--	tok1 TEXT := split_part(input_lower, '' '', 1);
--	tok2 TEXT := split_part(input_lower, '' '', 2);
--	tok3 TEXT := split_part(input_lower, '' '', 3);
--BEGIN
--	RETURN QUERY
--	    SELECT 
--			displaytext AS displaytext_v, 
--			class AS class_v,
--			id_in_class AS id_in_class_v,
--			tok1 || '' | '' || tok2  || '' | '' || tok3 AS query_tokens_v,
--			word_similarity(tok1, searchtext_1) + word_similarity(tok2, searchtext_1) + word_similarity(tok3, searchtext_1) AS hit_index_v
--		FROM 
--			public.searchobjects
--		WHERE
--			searchtext_1 LIKE ''%'' || tok1 || ''%''
--				AND
--					searchtext_1 LIKE ''%'' || tok2 || ''%''
--						AND	
--							searchtext_1 LIKE ''%'' || tok3 || ''%''
--		ORDER BY
--			word_similarity(tok1, searchtext_1) + word_similarity(tok2, searchtext_1) + word_similarity(tok3, searchtext_1)
--				DESC
--	;
--END;
--$$ LANGUAGE plpgsql
--;
