create or replace procedure cambio_ids()
begin
    begin transaction
        begin try
            insert into INDICADORXASADA select ia.id, (1 - texto) *100 * l.pendiente - l.ordenada as ids, texto*100 as txt from INDICADORXASADA ia inner join LINEAL l on (l.indicador_id = ia.indicador_id) where ia.indicador_id = 24 and texto <= 1
            on duplicate key update valor = values(ids), texto = values(txt);
            insert into INDICADORXASADA select ia.id, (100 - texto) * l.pendiente - l.ordenada as ids, texto as txt from INDICADORXASADA ia inner join LINEAL l on (l.indicador_id = ia.indicador_id) where ia.indicador_id = 24 and texto > 1
            on duplicate key update valor = values(ids), texto = values(txt);
            commit;
        end try
        begin catch
            rollback;
        end catch
    commit
end;