program tubesHari;
uses crt;
const
	nMax = 100;
type
	kls = record
		ekonomi, bisnis, eksekutif : longint;
	end;

	dataKereta = record
		nama : string;
		tujuan : string;
		asal : string;
		waktu : string;
		kelas : kls;
	end;

	reservasiKereta = record
		hari : string;
		passenger : string;
		tujuan : string;
		sampai : string;
		berangkat : string;
		noID : integer;
		kerjaan : string;
		harga : real;
		kelas : string;
		namaKereta :string;
		arrKursi : array [1..20] of string;
	end;
var
	
	reservasi : array[1..nMax] of reservasiKereta;
	kereta : array [1..nMax] of dataKereta;
	jumlahdata:longint;
	jumTiket : longint;
	filee : file of dataKereta;
	fileeResv : file of reservasiKereta;
	harii, posisi, category, j : integer;

	procedure load();
	begin
		assign(filee,'kereta.dat');
		reset(filee);
		while not eof(filee) do
			begin
				inc(jumlahdata);
				read(filee,kereta[jumlahdata]);
			end;
			close(filee);
	end;
	procedure save();
	var
		i: longint;
	begin
		assign(filee,'kereta.dat');
		rewrite(filee);
		for i:= 1 to jumlahdata do
			begin
				write(filee,kereta[i]);
			end;
		close(filee);
	end;

	procedure loadResv();
	begin
		assign(fileeResv,'reservasi.dat');
		reset(fileeResv);
		while not eof(fileeResv) do
			begin
				inc(jumTiket);
				read(fileeResv,reservasi[jumTiket]);
			end;
			close(fileeResv);
	end;

	procedure saveServ();
	var
		i: longint;
	begin
		assign(fileeResv,'reservasi.dat');
		rewrite(fileeResv);
		for i:= 1 to jumTiket do
			begin
				write(fileeResv,reservasi[i]);
			end;
		close(fileeResv);
	end;

	procedure hapusKereta();
	var
		nama: string;
		i, j : integer;
		temp: dataKereta;
		status : boolean;
		posisi : integer;
		option: char;
	begin
		clrscr;
		repeat
		i:=1;
		status:=FALSE;
			write('Cari data kereta yang ingin dihapus berdasarkan ''NAMA'' : ' ); readln(nama);
			repeat
					if (nama=kereta[i].nama) then
					begin
						status:=TRUE;
						posisi:=i;
						temp:=kereta[i];
					end;
					i:=i+1; 
			until(i>jumlahdata);
			if (status=TRUE) then
				begin
					writeln('FOUND, Data yang anda cari untuk dihapus :');
					writeln('Kereta ke - ',posisi);
					writeln('Nama Kereta           : ',temp.nama);
					writeln('waktu keberangkatan   : ',temp.waktu);
					writeln('Awal Keberangkatan    : ',temp.asal);
					writeln('Tujuan Keberangkatan  : ',temp.tujuan);
					writeln('Harga Kelas Ekonomi   : ',temp.kelas.ekonomi);
					writeln('Harga Kelas Bisnis    : ',temp.kelas.bisnis);
					writeln('Harga Kelas Eksekutif : ',temp.kelas.eksekutif);
					writeln();
					writeln('Tekan ''ENTER'' untuk menghapus data... '); readln();
					for j:=posisi to jumlahdata do
						begin
							kereta[posisi]:=kereta[posisi+1];
						end;
					jumlahdata:=jumlahdata-1;
				end
			else
				writeln('data tidak ketemu');
		writeln();
		write('Ingin melakukan penghapusan data lagi? [y/t]'); readln(option);
		clrscr;
	until(option='t');
	end;

	procedure editKereta();
	var
		temp:dataKereta;
		i : integer;
		posisi : integer;
		nama : string;
		status : boolean;
		option : char;
	begin
		clrscr;
		repeat
		status:=FALSE;
		i:=1;
			write('Cari data kereta yang ingin dirubah berdasarkan ''NAMA'' : ' ); readln(nama);
			while (i<=jumlahdata) do
				begin
					if (nama=kereta[i].nama) then
					begin
						status:=TRUE;
						posisi:=i;
						temp:=kereta[i];
					end;
					i:=i+1; 
				end;
			if (status=TRUE) then
				begin
					writeln('FOUND, Data yang anda cari untuk dirubah:');
					writeln('Kereta ke - ',posisi);
					writeln('Nama Kereta           : ',temp.nama);
					writeln('Awal Keberangkatan    : ',temp.asal);
					writeln('Tujuan Keberangkatan  : ',temp.tujuan);
					writeln('Waktu Keberangkatan   : ',temp.waktu);
					writeln('Harga Kelas Ekonomi   : ',temp.kelas.ekonomi);
					writeln('Harga Kelas Bisnis    : ',temp.kelas.bisnis);
					writeln('Harga Kelas Eksekutif : ',temp.kelas.eksekutif);
					writeln();
					writeln('Tekan ''ENTER'' untuk merubah data... '); readln();
					write('Nama Kereta          : '); 	readln(kereta[posisi].nama);
					write('Awal Keberangkatan   : '); 	readln(kereta[posisi].asal);
					write('Tujuan Keberangkatan : '); 	readln(kereta[posisi].tujuan);
					write('Waktu Keberangkatan  : ');	readln(kereta[posisi].waktu);
					write('Harga Kelas Ekonomi  : '); 	readln(kereta[posisi].kelas.ekonomi);
					write('Harga Kelas Bisnis   : ');	readln(kereta[posisi].kelas.bisnis);
					write('Harga Kelas Eksekutif: ');   readln(kereta[posisi].kelas.eksekutif);	
				end
			else
				writeln('Data yang ingin dirubah tidak ketemu');
				{end if}
			writeln();
			write('Ingin melakukan perubahan data lagi? [y/t]'); readln(option);
			clrscr;
		until (option='t');
		writeln('press any key to back....');
		readln;
	end;

	procedure lihatKereta();
	var
		flag,i, pass: Integer;
		pilihan, option : char;
		temp:dataKereta;
	begin
		clrscr;
		flag:=1; 
		i:=1;
		while (i<=jumlahdata) do
			begin		
				if flag <= 2 then
					begin
						flag:=flag+1;
						writeln('kereta ke - ',i);
						writeln('nama kereta          : ',kereta[i].nama);
						writeln('awal keberangkatan   : ',kereta[i].asal);
						writeln('tujuan keberangkatan : ',kereta[i].tujuan);
						writeln('waktu keberangkatan  : ',kereta[i].waktu);
						writeln('harga kelas ekonomi  : ',kereta[i].kelas.ekonomi);
						writeln('harga kelas bisnis   : ',kereta[i].kelas.bisnis);
						writeln('harga kelas eksekutif : ',kereta[i].kelas.eksekutif);
						i:=i+1;
						writeln;				
					end
				else
					begin
						flag:=1;
						write('press any key to continue.. '); readln;
						clrscr;
					end;
			end;
		writeln('urutkan [y/t] : '); readln(option);
		if (option='y') then
		begin
			writeln('urutkan berdasarkan nama : ');
			writeln('1. asscending');
			writeln('2. desscending');
			write('pilihan : '); readln(pilihan);
			if (pilihan='1') then
				begin
					pass:=1;
					while (pass <= jumlahdata-1) do
						begin
							i:=1;
							while (i<=jumlahdata-pass) do
							begin
								if kereta[i].nama > kereta[i+1].nama then
								begin
									temp := kereta[i];
									kereta[i]:=kereta[i+1];
									kereta[i+1]:=temp;
								end;
								i := i+1;
							end;
							pass := pass + 1;
						end;	
				end
			else {if PILIHAN='2' then}
				begin
					pass:=1;
					while (pass <= jumlahdata-1) do
						begin
							i:=1;
							while (i<=jumlahdata-pass) do
							begin
								if kereta[i].nama < kereta[i+1].nama then
								begin
									temp := kereta[i];
									kereta[i]:=kereta[i+1];
									kereta[i+1]:=temp;
								end;
								i := i+1;
							end;
							pass := pass + 1;
						end;
				end;
			clrscr;
			flag:=1; 
			i:=1;
			while (i<=jumlahdata) do
				begin		
					if flag <= 2 then
						begin
							flag:=flag+1;
							writeln('kereta ke - ',i);
							writeln('nama kereta           : ',kereta[i].nama);
							writeln('awal keberangkatan    : ',kereta[i].asal);
							writeln('tujuan keberangkatan  : ',kereta[i].tujuan);
							writeln('harga kelas ekonomi   : ',kereta[i].kelas.ekonomi);
							writeln('waktu keberangkatan   : ',kereta[i].waktu);
							writeln('harga kelas bisnis    : ',kereta[i].kelas.bisnis);
							writeln('harga kelas eksekutif : ',kereta[i].kelas.eksekutif);
							i:=i+1;
							writeln;				
						end
					else
						begin
							flag:=1;
							write('press any key to continue.. '); readln;
							clrscr;
						end;
				end;
			
		end;
		//until(option='t');
	readln;
	end;

	procedure tambahKereta();
	begin
		clrscr;
		jumlahdata:=jumlahdata+1;
		writeln('*HOME >> MENU PETUGAS >> TAMBAH KERETA');
		writeln('=======================================================');
		write('Nama Kereta          : '); 	readln(kereta[jumlahData].nama);
		write('Awal Keberangkatan   : '); 	readln(kereta[jumlahData].asal);
		write('Tujuan Keberangkatan : '); 	readln(kereta[jumlahData].tujuan);
		write('Waktu Keberankatan   : ');	readln(kereta[jumlahData].waktu);
		write('Harga Kelas Ekonomi  : '); 	readln(kereta[jumlahData].kelas.ekonomi);
		write('Harga Kelas Bisnis   : ');	readln(kereta[jumlahData].kelas.bisnis);
		write('Harga Kelas Eksekutif: '); readln(kereta[jumlahData].kelas.eksekutif);
		write('tekan ''ENTER'' untuk kembali');
		readln;
	end;

	procedure menuPetugas();
	var
		pilihan : char;
	begin
		repeat
			clrscr;
			writeln('==========ADMIN APLIKASI BOOKING TIKET KERETA==========');
			writeln('--------------------MENU PETUGAS-----------------------');
			writeln('*HOME >> MENU PETUGAS');
			writeln('=======================================================');
			writeln('1. Tambah Kereta');
			writeln('2. Edit Kereta');
			writeln('3. Hapus Kereta');
			writeln('4. Lihat Kereta');
			writeln('5. Kembali');
			write('Masukan Pilihan : ');
			repeat
				readln(pilihan);
				case pilihan of
				'1' : begin tambahKereta(); end;
				'2' : begin editKereta(); end;
				'3' : begin hapusKereta(); end;
				'4' : begin lihatKereta(); end
				else
					write('Pilihan tidak valid, silahkan masukan pilihan 1/2 : ');
				end;
			until (pilihan='1') or (pilihan='2') or (pilihan='3') or (pilihan='4') or (pilihan='5');
		until (pilihan='5');
	clrscr;
	end;

	function prosesHarga(getDiskon : boolean; hari : string; hargaKelas:longint): real;
	var
		diskon: real;
		hargaTiket : real;

	begin
		if (getDiskon=TRUE) then
			begin
				if (hari='senin') or (hari='selasa') or (hari='rabu') or (hari='kamis') or (hari='jumat') then
					diskon:=0.5
				else if (hari='sabtu') or (hari='minggu') then
					diskon:=0.3;
				hargaTiket:= hargaKelas-(hargaKelas*diskon);
			end
		else 
			begin
				hargaTiket:= hargaKelas;
			end;
		prosesHarga:=hargaTiket;
	end;

	procedure reservasiTiket();
	var
		i, k, poss: integer;
		hargaKelas, nomorID : longint;
		asal, tujuan, day, kursi, kelasKereta, kerja : string;
		status, getDiskon: boolean;
		penumpang : string;
		option, pilihan : char;
		diskon, hargaTiket: real;
	begin
		clrscr;
		hargaTiket:=0;
		writeln('=============APLIKASI BOOKING TIKET KERETA=============');
		writeln('=------------------RESERVASI TIKET--------------------=');
		writeln('=*HOME >> MENU UTAMA >> RESERVASI TIKET               =');
		writeln('=======================================================');
		writeln();
//-------------PROSES MENENTUKAN TUJUAN
		writeln('cari kereta ...'); readln();
		writeln('tentukan awal keberangkatan : '); 
			i:=1;
			repeat
				write(kereta[i].asal,' - ');
				i:=i+1;
			until (i>jumlahdata); 
		write('masukan pilihan : '); readln(asal);
		writeln();
		writeln('tentukan tujuan keberangkatan : ');
			i:=1;
			repeat
				write(kereta[i].tujuan,' - ');
				i:=i+1;
			until (i>jumlahdata);
		write('masukan pilihan : '); readln(tujuan);
		writeln();
		status:=FALSE;
		i:=1;
		repeat
			if (asal=kereta[i].asal) and (tujuan=kereta[i].tujuan) then
			begin
				status:=TRUE;
				posisi:=i;
			end;
		i:=i+1;
		until (i>jumlahdata);
		
		if (status=TRUE) then
		begin
			writeln('kereta yang mungkin anda pilih : ');
			writeln('');
			writeln('nama kereta : ',kereta[posisi].nama);
			writeln('awal keberangkatan : ',kereta[posisi].asal);
			writeln('tujuan keberangkatan : ',kereta[posisi].tujuan);
			writeln('waktu keberangkatan : ',kereta[posisi].waktu);
		end
		else
			write('kereta tidak tersedia');
//-------------------------LANJUTAN PILIH KERETA
		if (status=TRUE) then
			begin
				write('pilih hari keberangkatan [senin-minggu] : ');
				repeat
					readln(day);
				until(day='senin') or (day='selasa') or (day='rabu') or (day='kamis') or (day='jumat') or (day='sabtu') or (day='minggu');
					
				writeln();
				write('pilih kelas kereta [ekonomi - bisnis - eksekutif] : '); 
				repeat
					readln(kelasKereta);
				until (kelasKereta='ekonomi') or (kelasKereta='bisnis') or (kelasKereta='eksekutif');

				if kelasKereta='ekonomi' then
				begin
					hargaKelas:=kereta[posisi].kelas.ekonomi;
				end
				else if kelasKereta='bisnis' then
				begin
					hargaKelas:=kereta[posisi].kelas.bisnis;
				end
				else if kelasKereta='eksekutif' then
				begin
					hargaKelas:=kereta[posisi].kelas.eksekutif;
				end;
//--------------------------------------------------
				writeln();
				write('cari dan pilih kursi [1-20] : '); readln(kursi);
				status:=FALSE;
				i:=1;
				if jumTiket=0 then
					status:=TRUE;
				while i<=jumTiket do
				begin
					if (reservasi[i].hari=day) and (reservasi[i].namaKereta = kereta[posisi].nama) and (reservasi[i].kelas = kelasKereta) then
					begin
						for j := 1 to 20 do
							begin
								if (reservasi[i].arrKursi[j]<>kursi) then
								begin
									poss:=j;
									status:=TRUE;
								end;
							end;
					end 
					else
						status := TRUE;
					i:=i+1;
		
				end;

	//--------------------------------------------------
				if (status=TRUE) then
					writeln('kursi tersedia')
				else
					writeln('kursi tidak tersedia');
					readln;

//-------------------------DATA PENUMPANG
				clrscr;
				if status=TRUE then
				begin
					writeln('Masukan Data Diri');
					write('Nama Pemesan                              : '); readln(penumpang);
					write('Nomor Identitas (5 Digit terakhir no KTP) : '); readln(nomorID);
					writeln('Pekerjaan  : ');
					writeln('1. TNI');
					writeln('2. UMUM');
					write('pilihan : '); 
					repeat
						readln(option);
					until (option='1') or (option='2');
					getDiskon:=FALSE;
					kerja:='UMUM';
					if (option='1') then begin
						getDiskon:=TRUE;
						kerja:='TNI';
					end;
				end;
					//j:=0;///
	//-------------------------------proses harga		
				hargaTiket:=prosesHarga(getDiskon, day, hargaKelas);
				
				poss:=0;
				if (status=TRUE) then
					begin
						jumTiket:=jumTiket+1;
						 poss:=poss+1;
						 reservasi[jumTiket].hari := day; {hari pemesanan}
						 reservasi[jumTiket].namaKereta := kereta[posisi].nama; {nama kereta yang dipesan}
						 reservasi[jumTiket].kelas	:= kelasKereta; {kelas yang dipilih}
						 reservasi[jumTiket].berangkat 	:= kereta[posisi].asal; {berangkat}
						 reservasi[jumTiket].sampai := kereta[posisi].tujuan; {sampai}
						 reservasi[jumTiket].arrKursi[poss] := kursi; {kursi yang dipesan}
						 reservasi[jumTiket].passenger:= penumpang; {nama pemesan kereta}
						 reservasi[jumTiket].noID 	:= nomorID; {no id pemesan}
						 reservasi[jumTiket].kerjaan := kerja; {pekerjaan}
						 reservasi[jumTiket].harga 	:= hargaTiket; {harga tiket}
					 
						 writeln('tiket ke - ',jumTiket);
						 writeln('Hari Berangkat    : ',reservasi[jumTiket].hari);
						 writeln('Nama Kereta       : ',reservasi[jumTiket].namaKereta);
						 writeln('Kelas             : ',reservasi[jumTiket].Kelas);
						 writeln('Berangkat         : ',reservasi[jumTiket].berangkat);
						 writeln('Tujuan            : ',reservasi[jumTiket].sampai);
						 writeln('Nomor Kursi       : ',reservasi[jumTiket].arrKursi[poss]);
						 writeln('Nama Pemesan      : ',reservasi[jumTiket].passenger);
						 writeln('No ID             : ',reservasi[jumTiket].noID);
						 writeln('Pekerjaan         : ',reservasi[jumTiket].kerjaan);
						 writeln('Harga             : IDR ',reservasi[jumTiket].harga:0:0);	
						 readln;

//----------------------cara pembayaran
						clrscr;
						writeln('Pilih Cara Pembayaran');
						writeln('1.Cash');
						writeln('2.Transfer');
						write('Pilihan Anda : '); readln(pilihan);
						if (pilihan='1') then
							begin
				                writeln('Pembayaran dapat dilakukan via:');
				                writeln('1.Pos Indonesia');
				                writeln('2.Indomart');
				                writeln('3.PayTren');
				                writeln('4.Outlet-outlet yang memiliki bertanda khusus PT.KAI');
				            end
				        else
					        begin
								writeln('Melalui Teller atau ATM a/n PT.KA Indonesia');
								writeln('BCA, noRek     :012345');
								writeln('Mandiri, noRek :678932');
								writeln('BNI, noRek     :323211');
								writeln('BRI, noRek     :098765');
		    	            end;
						writeln('Pemesanan berhasil, silahkan bayar 8 jam dari sekarang');
					end;	
				end;	
	readln;
	end;

	procedure lihatTiket();
	var
	flag,pass,j, i_min, kanan, kiri, tengah: Integer;
	i, angka : longint;
	pilihan, option : char;
	temp:reservasiKereta;
	found : boolean;	
	namee : string;	
	begin
		clrscr;
		flag:=1;
		i:=1; 
		while (i<=jumTiket) do
			begin		
				if flag <= 2 then
					begin
						flag:=flag+1;
						writeln('tiket ke - ',i);
						writeln('Hari Berangkat    : ',reservasi[i].hari);
						writeln('Nama Kereta       : ',reservasi[i].namaKereta);
						writeln('Kelas             : ',reservasi[i].Kelas);
						writeln('Berangkat         : ',reservasi[i].berangkat);
						writeln('Tujuan            : ',reservasi[i].sampai);
						for j := 1 to 20 do
							if(reservasi[i].arrKursi[j] <> '')then
								writeln('Nomor Kursi       : ',reservasi[i].arrKursi[1]);
						writeln('Nama Pemesan      : ',reservasi[i].passenger);
						writeln('No ID             : ',reservasi[i].noID);
						writeln('Pekerjaan         : ',reservasi[i].kerjaan);
						writeln('Harga             : IDR ',reservasi[i].harga:0:0);	
						i:=i+1;
						writeln;				
					end
				else
					begin
						flag:=1;
						write('press any key to continue.. '); readln;
						clrscr;
					end;
			end;
//------------------SORTING DAN SEARCHING--------------------------------

			writeln('urutkan [y/t] : '); readln(option);
			if (option='y') then
			begin
			clrscr;
				writeln('1. urutkan berdasarkan Harga: ');
				writeln('2. urutkan berdasarkan Nama Pemesan');
				write('Pilihan : '); readln(option);
				
				//SELECTION SORT CARI HARGA
				if (option='1') then
				begin
				clrscr;
					writeln('1. Termurah to Terbesar');
					writeln('2. Terbesar to Termurah');
					write('pilihan : '); readln(pilihan);
					if (pilihan='1') then
			 			begin
				 			pass:=1;
				 			while pass <= jumTiket-1 do
					 			begin
					 				i:=pass + 1;
					 				i_min := pass;
					 					while i <= jumTiket do
					 					begin
					 						if (reservasi[i_min].harga>reservasi[i].harga) then begin
					 							i_min:=i;
					 						end;
					 						i:=i+1;
					 					end;
					 				temp:=reservasi[i_min];
					 				reservasi[i_min]:=reservasi[pass];
					 				reservasi[pass]:=temp;
					 				pass:=pass+1;
					 			end;

						end
					else 
						begin
							pass:=1;
				 			while pass <= jumTiket-1 do
					 			begin
					 				i:=pass + 1;
					 				i_min := pass;
					 					while i <= jumTiket do
					 					begin
					 						if (reservasi[i_min].harga<reservasi[i].harga) then begin
					 							i_min:=i;
					 						end;
					 						i:=i+1;
					 					end;
					 				temp:=reservasi[i_min];
					 				reservasi[i_min]:=reservasi[pass];
					 				reservasi[pass]:=temp;
					 				pass:=pass+1;
					 			end;
						end;
						clrscr;
						//harii:=1;
						flag:=1;
						i:=1; 
						while (i<=jumTiket) do
							begin		
								if flag <= 2 then
									begin
										flag:=flag+1;
										writeln('tiket ke - ',i);
										writeln('Hari Berangkat    : ',reservasi[i].hari);
										writeln('Nama Kereta       : ',reservasi[i].namaKereta);
										writeln('Kelas             : ',reservasi[i].Kelas);
										writeln('Berangkat         : ',reservasi[i].berangkat);
										writeln('Tujuan            : ',reservasi[i].sampai);
										for j := 1 to 20 do
											if(reservasi[i].arrKursi[j] <> '')then
												writeln('Nomor Kursi       : ',reservasi[i].arrKursi[1]);
										writeln('Nama Pemesan      : ',reservasi[i].passenger);
										writeln('No ID             : ',reservasi[i].noID);
										writeln('Pekerjaan         : ',reservasi[i].kerjaan);
										writeln('Harga             : IDR ',reservasi[i].harga:0:0);	
										i:=i+1;
										writeln;				
										end
								else
									begin
										flag:=1;
										write('press any key to continue.. '); readln;
										clrscr;
									end;
							end;
			//----------SEARCHING BINARY
							write('ingin melakukan proses pencarian harga ? [y/t] '); readln(option);
							if (option='y') then
							begin
								clrscr;
								write('Masukan Harga yang ingin dicari : '); readln(angka);
								writeln;
								kanan:=jumTiket;
								kiri:=1;
								found:=FALSE;
								while (kiri<=kanan) and (found=FALSE) do
									begin
										tengah:=(kiri+kanan) div 2;
										if (angka>reservasi[tengah].harga) then
											kiri:=tengah+1
										else if (angka<reservasi[tengah].harga) then
											kanan:=tengah-1
										else
											found:=TRUE;
									end;
								if (found=TRUE) then
								begin
									writeln('tiket ke - ',tengah);
									writeln('Hari Berangkat    : ',reservasi[tengah].hari);
									writeln('Nama Kereta       : ',reservasi[tengah].namaKereta);
									writeln('Kelas             : ',reservasi[tengah].Kelas);
									writeln('Berangkat         : ',reservasi[tengah].berangkat);
									writeln('Tujuan            : ',reservasi[tengah].sampai);
									writeln('Nomor Kursi       : ',reservasi[tengah].arrKursi[1]);
									writeln('Nama Pemesan      : ',reservasi[tengah].passenger);
									writeln('No ID             : ',reservasi[tengah].noID);
									writeln('Pekerjaan         : ',reservasi[tengah].kerjaan);
									writeln('Harga             : IDR ',reservasi[tengah].harga:0:0);	
									readln();
								end
								else 
									writeln('Data Tidak Ada . . . ');
								end;
					end

				//INSERTION SORT NAMA PEMESAN
				else {option = 2}
				begin
				clrscr;
					writeln('1. Asscending');
					writeln('2. desscending');
					write('pilihan : '); readln(pilihan);
					if (pilihan='1') then
						begin
							pass:=1;
							while pass<=jumTiket-1 do
								begin
									i:=pass+1;
									temp:=reservasi[i];
									while (reservasi[i].passenger < reservasi[i-1].passenger) do
									begin
										reservasi[i]:=reservasi[i-1];
										i:=i-1;
									end;
									reservasi[i]:=temp;
									pass:=pass+1;
								end;
						end
					else
						begin
							pass:=1;
							while (pass<=jumTiket-1) do
								begin
									i:=pass+1;
									temp:=reservasi[i];
									while (reservasi[i].passenger > reservasi[i-1].passenger) and (i>1) do
									begin
										reservasi[i]:=reservasi[i-1];
										i:=i-1;
									end;
									reservasi[i]:=temp;
									pass:=pass+1;
								end;
						end;
						clrscr;
						harii:=1;
						flag:=1;
						i:=1; 
						while (i<=jumTiket) do
							begin		
								if flag <= 2 then
									begin
										flag:=flag+1;
										writeln('tiket ke - ',i);
										writeln('Hari Berangkat    : ',reservasi[i].hari);
										writeln('Nama Kereta       : ',reservasi[i].namaKereta);
										writeln('Kelas             : ',reservasi[i].Kelas);
										writeln('Berangkat         : ',reservasi[i].berangkat);
										writeln('Tujuan            : ',reservasi[i].sampai);
										for j := 1 to 20 do
											if(reservasi[i].arrKursi[j] <> '')then
												writeln('Nomor Kursi       : ',reservasi[i].arrKursi[1]);
										writeln('Nama Pemesan      : ',reservasi[i].passenger);
										writeln('No ID             : ',reservasi[i].noID);
										writeln('Pekerjaan         : ',reservasi[i].kerjaan);
										writeln('Harga             : IDR ',reservasi[i].harga:0:0);	
										i:=i+1;
										writeln;				
									end
								else
									begin
										flag:=1;
										write('press any key to continue.. '); readln;
										clrscr;
									end;
							end;
			// -------------------- SEQUENTIAL SEARCH
							write('ingin melakukan proses pencarian nama penumpang ? [y/t] '); readln(option);
							if (option='y') then
							begin
								clrscr;
								write('Masukan Harga yang ingin dicari : '); readln(namee);
								writeln;
								i:=1;
								found:=FALSE;
								while (i<=jumTiket) do
									begin
										if (namee=reservasi[i].passenger) then
											found:=TRUE;
										i:=i+1;
									end;
								if (found=TRUE) then
								begin
									writeln('tiket ke - ',tengah);
									writeln('Hari Berangkat    : ',reservasi[tengah].hari);
									writeln('Nama Kereta       : ',reservasi[tengah].namaKereta);
									writeln('Kelas             : ',reservasi[tengah].Kelas);
									writeln('Berangkat         : ',reservasi[tengah].berangkat);
									writeln('Tujuan            : ',reservasi[tengah].sampai);
									writeln('Nomor Kursi       : ',reservasi[tengah].arrKursi[1]);
									writeln('Nama Pemesan      : ',reservasi[tengah].passenger);
									writeln('No ID             : ',reservasi[tengah].noID);
									writeln('Pekerjaan         : ',reservasi[tengah].kerjaan);
									writeln('Harga             : IDR ',reservasi[tengah].harga:0:0);	
									readln();
								end
								else 
									writeln('Data Tidak Ada . . . ');
								end;			
				end;		
	readln;
	end;
end;

	procedure refundTiket();
	begin
		clrscr;
		writeln('=----------------CARA REFUND TIKET--------------------=');
		writeln('=*HOME >> MENU UTAMA >> CARA REFUND TIKET             =');
		writeln('=======================================================');
		writeln('1. Pergi ke Menu Lihat Tiket');
		writeln('2. Cari data tiket');
		writeln('3. Minta Form pembatalan ke tempat stasiun atau tempat pembayaran atau tempat berlogo KA');
		writeln('4. Fotocopy Kartu Identitas + Tiket + Form Pembatalan (rangkap 2)');
		writeln('5. Permohonan diserahkan ke pihak KA terdekat (tempat berlogo KA) atau stasiun terdekat maks 30 menit sebelum keberangkatan');
		writeln('6. Biaya pembatalan adalah 25% dari Harga tiket yang dipesan');
		readln();
	end;

	procedure lapor();
	var
		nama, identitas, lokasi, keluhan: string;
		pilihan : char;
	begin
		clrscr;
		writeln('=----------------------LAPOR--------------------------=');
		writeln('=*HOME >> MENU UTAMA >> LAPOR                         =');
		writeln('=======================================================');
		writeln('1. Lapor Pengaduan Terhadap Pelayanan Agen');
		writeln('2. Lapor Informasi Kecelakaan');
		write('masukan pilihan'); readln(pilihan);
		if (pilihan='1') then
			begin
				clrscr;
				write('nama                       : '); readln(nama);
				write('no identitas (KTP/SIM/NIM) : '); readln(identitas);
				writeln('pilihan : ');
				write('layanan buruk - user interface tidak bagus - kompleksitas kurang');
				write('jawab : '); readln(keluhan);
				readln;
			end
		else
			begin
				clrscr;
				write('nama                       : '); readln(nama);
				write('no identitas (KTP/SIM/NIM) : '); readln(identitas);
				write('lokasi kecelakaan          : '); readln(lokasi);
				readln;
			end;
	end;

	procedure menuPenumpang();
	var
		pilihan : char;
	begin
		repeat
			clrscr;
			writeln('====SELAMAT DATANG DI APLIKASI BOOKING TIKET KERETA====');
			writeln('=--------------------MENU UTAMA-----------------------=');
			writeln('=*HOME >> MENU UTAMA                                  =');
			writeln('=======================================================');
			writeln('1. Reservasi Tiket');
			writeln('2. Cara Refund Tiket');
			writeln('3. Lapor');
			writeln('4. Lihat Tiket');
			writeln('5. Kembali');
		
			write('	Masukan Pilihan :  ');
			repeat
				readln(pilihan);
				case pilihan of
				'1' : begin reservasiTiket(); end;
				'2' : begin refundTiket(); end;
				'3' : begin lapor(); end;
				'4' : begin lihatTiket(); end;
			//	'5' : begin lihatTiket(); end
				else
					write('Pilihan tidak valid, silahkan masukan pilihan 1/2/3/4/5 : ');
				end;
			until (pilihan='1') or (pilihan='2') or (pilihan='3') or (pilihan='4') or (pilihan='5');
		until (pilihan='5');
	clrscr;
	end;
	procedure menuAwal();
	var
		pilihan: char;
	begin 
		repeat
			clrscr;
			writeln('Welcome!');
			writeln('===APLIKASI BOOKING TIKET KERETA===');
			writeln('Silahkan Login Sebagai : ');
			writeln('1. Penumpang');
			writeln('2. Petugas');
			writeln('3. keluar');
			write('Masukan Pilihan : '); 
			repeat
				readln(pilihan);
				case pilihan of
				'1' : begin menuPenumpang(); end;
				'2' : begin menuPetugas(); end;
				'3' : begin end
				else
					write('Pilihan tidak valid, silahkan masukan pilihan 1/2/3 : ');
				end;
			until (pilihan='1') or (pilihan='2') or (pilihan='3');
		until(pilihan='3');
		readln;
	end;
//---------------PROGRAM UTAMA
	begin
		clrscr;
		jumlahdata := 0;
		Assign(filee, 'kereta.dat');
	    {$I-} Reset(filee);
	    {$I+} if IOResult<>0 then Rewrite(filee);
	    close(filee);
	    Assign(fileeResv, 'reservasi.dat');
	    {$I-} Reset(fileeResv);
	    {$I+} if IOResult<>0 then Rewrite(fileeResv);
	    close(fileeResv);
	    load;
	    loadResv;
			menuAwal();
		save;
		saveServ;
	end.
