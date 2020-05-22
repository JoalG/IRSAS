CREATE OR REPLACE VIEW IRSSAS_VIEW AS
        select (SUM(ai.valor * i.valor) * 100) as irssas, ai.asada_id as asada_id
        from INDICADORXASADA ai
                 inner join INDICADOR i on (ai.indicador_id = i.id)
        group by ai.asada_id;

CREATE OR REPLACE VIEW SUBCOMPONENTE_IRSSAS_VIEW AS
        SELECT (SUM(ai.valor * i.valor) * 100 / s.valor) * 100 as subcomponente, s.id as subcomponente_id, ai.asada_id as asada_id
        FROM INDICADORXASADA ai
                INNER JOIN INDICADOR i ON (ai.indicador_id = i.id)
                INNER JOIN SUBCOMPONENTE s ON (i.subcomponente_id = s.id)
        GROUP BY ai.asada_id, s.id;

CREATE OR REPLACE VIEW COMPONENTE_IRSSAS_VIEW AS
        SELECT (SUM(ai.valor * i.valor) * 100 / c.valor) * 100 as componente, c.id as componente_id, ai.asada_id as asada_id
        FROM INDICADORXASADA ai
                INNER JOIN INDICADOR i ON (ai.indicador_id = i.id)
                INNER JOIN SUBCOMPONENTE s ON (i.subcomponente_id = s.id)
                INNER JOIN COMPONENTE c ON (s.componente_id = c.id)
        GROUP BY ai.asada_id, c.id;