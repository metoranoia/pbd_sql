create database dbbuku;
create table tblbuku (
  idbuku char (6),
  judulbuku varchar (255),
  pengarang varchar (255),
  penerbit varchar (255),
  tahunterbit int (4),
  jmlhalaman int,
  primary key (idbuku)
);

desc dbbuku.tblbuku;

select * from tblbuku
load data infile "D:\List Buku.txt" into table tblbuku;

-- case 1 data berdasarkan urutan tahun terbit dari terlama sampai terbaru 
select * from tblbuku
order by tahunterbit asc;

-- case 2 data berdasarkan urutan jml halaman dari terbesar sampai terkecil
select * from tblbuku
order by jmlhalaman desc;

-- case 3 3 besar buku dengan jumlah halaman terbanyak
select * from tblbuku
order by jmlhalaman desc limit 3;

-- case 4 semua buku yg judulnya mengandung frasa stat dengan urutan berdasarkan tahun terbit terlama terbaru
select * from tblbuku
where judulbuku like ('%stat%')
order by tahunterbit asc;

-- case 5 3 besar buku dengan jmlhalaman terbanyak yg judulnya mengandung frasa stat
select * from tblbuku
where judulbuku like ('%stat%')
order by jmlhalaman desc limit 3;

-- CASE 6 RINGKASAN JUMLAH BUKU DARI MASING-MASING PENERBIT
SELECT penerbit,
COUNT (judulbuku) jml_buku
FROM tblbuku
GROUP BY penerbit;

-- CASE 7 RINGKASAN JUMLAH BUKU DARI MASING-MASING PENGARANG
SELECT pengarang,
COUNT (judulbuku) jml_buku
FROM tblbuku
GROUP BY pengarang;

-- CASE 8 RINGKASAN JUMLAH BUKU DARI MASING-MASING PENGARANG BESERTA DENGAN TOTAL KUMULATIF JUMLAH HALAMAN
SELECT pengarang,
COUNT (judulbuku) jml_buku,
SUM (jmlhalaman) total_jml_halaman
FROM tblbuku
GROUP BY pengarang;

-- CASE 9 RINGKASAN JUMLAH BUKU DARI MASING-MASING PENGARANG BESERTA DENGAN TOTAL KUMULATIF JUMLAH HALAMAN DAN RATA-RATA JUMLAH HALAMAN PERBUKUNYA
SELECT pengarang,
COUNT (judulbuku) jml_buku,
SUM (jmlhalaman) total_jml_halaman,
ROUND (AVG (jmlhalaman)) rata_jml_halaman
FROM tblbuku
GROUP BY pengarang;

-- insert into values (menambah record tabel)
insert into tblbuku(idbuku,judulbuku,pengarang,penerbit,tahunterbit,jmlhalaman) 
values
('STK012','Satysashf HHKhkjkdjfi','Victoria','lalaland','2022','534'),
('STK013','Satysashf HHKhkjkdjfi','Victoria','lalaland','2021','533'),
('STK014','Satysashf HHKhkjkdjfi','Victoria','lalaland','2020','539'),
('STK015','Satysashf HHKhkjkdjfi','Victoria','lalaland','2023','512');
-- menghapus record tabel
delete from tblbuku where idbuku='STK014';
-- update record tabel
update tblbuku
set jmlhalaman ='163'
where idbuku = 'STK013';
-- export data ke excel atau sql atau apapun
select * from tblbuku into outfile "D:/List Buku.sql"
