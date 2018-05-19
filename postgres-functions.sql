/*
to_integer(value string, dflt=NULL)

Casts a string to an integer, returning ``dflt`` if casting fails.

Returns NULL if the value is null.
*/
create function to_integer(value text, dflt integer=NULL)
returns integer
language plpgsql immutable called on null input as $pgsql$
begin
    if value is null then
        return null;
    end if;

    return value::integer;
exception
    when invalid_text_representation then
        return dflt;
end;
$pgsql$;

/*
date_round(round_to text, timestamp)

Rounds a date to some interval:

> select date_round('15 minutes', '1990-01-01T10:10:12')
'1990-01-01T10:00:00'
*/
create function date_round(round_to text, ts timestamp with time zone)
returns timestamp with time zone
language plpgsql immutable as $pgsql$
declare
    interval float := extract('epoch' from round_to::interval);
begin
    return (
        timestamp with time zone 'epoch' +
        interval '1 second' * round(extract('epoch' from ts) / interval) * interval
    );
end;
$pgsql$;
