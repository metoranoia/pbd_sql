create database dbpenilaian;
use dbpenilaian;

create table tblnilaiagama (
  NIM char(9) not null primary key,
  NamaMhs varchar(30) not null,
  Gender enum ('L','P') not null,
  Kelas enum('ABS','BCS','ABC','ACS') not null,
  NA float not null
);

alter table tblnilaiagama drop primary key;
alter table tblnilaiagama add nomor int(99) auto_increment not null primary key first;

load data infile 'D:/tabel nilai agama.txt' into table tblnilaiagama;
-- case 1
select NIM,NamaMhs,Gender,Kelas,NA,
if(86<=NA and NA<=100, "A", 
   if(78<=NA and NA<86,"AB",
      if(70<=NA and NA<78,"B",
         if(62<=NA and NA<70,"BC",
            if(54<=NA and NA<62,"C",
               if(40<=NA and NA<54,"D","E"))))))
NH from tblnilaiagama;

-- case 2
select NamaMhs, case Gender
when 'L' then 'Laki-laki'
else 'Perempuan'
end Jenis_kelamin from tblnilaiagama;

-- case 3
select NIM, NamaMhs, Gender, Kelas, NA, case Kelas
when 'ABS' then 'Gabungan Matematika, Biologi, dan Statistika'
when 'BCS' then 'Gabungan Biologi, Kimia, dan Statistika'
else 'Gabungan Matematika, Biologi, dan Kimia' 
end Ket_kelas, NA from tblnilaiagama;

-- case 4
-- a. mencari jml_mhs berdasarkan gender
select Gender,
count (NamaMhs) jml_mhs
from tblnilaiagama
group by Gender;

-- b. mencari jml_mhs berdasarkan Kelas
select Kelas,
count (NamaMhs) jml_mhs
from tblnilaiagama
group by Kelas;

-- c. mencari rata_NA berdasarkan gender
select Gender,
round(avg (NA),2) rata_NA
from tblnilaiagama
group by Gender;

-- d. mencari rata_NA berdasarkan kelas
select Kelas,
round(avg(NA),3) rata_NA
from tblnilaiagama
group by Kelas;

-- e. mencari nilai max berdasarkan gender
select Gender,
max(NA) nilai_max
from tblnilaiagama
group by Gender;

-- f. mencari nilai max berdasarkan kelas
select Kelas,
max(NA) nilai_max
from tblnilaiagama
group by Kelas;

-- g. mencari nilai max pada mahasiswa laki-laki
select NIM, NamaMhs as Mhs_Laki_Terbaik, Kelas, NA from tblnilaiagama
where Gender = 'L'
order by NA desc
limit 1;

-- h. mencari nilai max pada mahasiswa perempuan
select NIM, NamaMhs as Mhs_Perempuan_Terbaik, Kelas, NA from tblnilaiagama
where Gender = 'P'
order by NA desc
limit 1;

