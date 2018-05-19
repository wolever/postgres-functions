-- to_integer
select to_integer('1');
select to_integer('1.2');
select to_integer('0');
select to_integer('.0');
select to_integer('0.');
select to_integer('foo') is null;
select to_integer('foo', 42);

-- date_round
select date_round('15 minutes', '1990-01-01 10:10:12');
