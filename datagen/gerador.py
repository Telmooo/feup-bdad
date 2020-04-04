from random import randint as ri

f = open('out.txt','w')
data = open('Projeto/sql/povoar.sql','r')
medicos = []
tecnicos = []
enfermeiros = []
doencas = []

for line in data:
   if('INSERT INTO Medico (StaffID, Consultorio) VALUES (' in line):
      med = line[50:len(line)-3].split(',')
      medicos.append(int(med[0]))
   if('INSERT INTO Tecnico (StaffID) VALUES (' in line):
      tec = line[38:len(line)-3]
      tecnicos.append(int(tec))
   if('INSERT INTO Enfermeiro (StaffID) VALUES (' in line):
      enf = line[41:len(line)-3]
      enfermeiros.append(int(enf))
   if('INSERT INTO Doenca (DoencaID, Nome, Descricao, Sintomas) VALUES (' in line):
      d = line[65:len(line)-3].split(',')[1]
      d = d[2:-1]
      doencas.append(d)


f.write("\n-- Nurse Intervention\n")
for i in range(1,200):
   s = 'INSERT INTO Evento(EventoID,Descricao, Data, Admissao, Quarto) VALUES ({}, "descricao","{}/{}/{} {}:{}:{}" ,{}, {});\n'

   di = ri(1,28)
   Mi = ri(1,12)
   ai = ri(1960,2019)
   hi = ri(0,23)
   mi = ri(0,59)
   si = ri(0,59)
   a = ri(1,500)
   q = ri(100,249)
   s = s.format(i,di,Mi,ai,hi,mi,si,a,q)

   s2 = 'INSERT INTO Intervencao( EventoID, Descricao) VALUES ({},"descricao");\n'
   s2 = s2.format(i)

   s3 = 'INSERT INTO EnfermeiroInterv( EnfermeiroID, IntervID) VALUES ({},{});\n'
   enfID = enfermeiros[ri(0,len(enfermeiros)-1)]
   s3 = s3.format(enfID,i)
   
   f.write(s)
   f.write(s2)
   f.write(s3)

f.write("\n-- Tecnician Intervention\n")
for i in range(200,500):
   s = 'INSERT INTO Evento(EventoID,Descricao, Data, Admissao, Quarto) VALUES ({}, "descricao","{}/{}/{} {}:{}:{}" ,{}, {});\n'

   di = ri(1,28)
   Mi = ri(1,12)
   ai = ri(1960,2019)
   hi = ri(0,23)
   mi = ri(0,59)
   si = ri(0,59)
   a = ri(1,500)
   q = ri(100,249)
   s = s.format(i,di,Mi,ai,hi,mi,si,a,q)

   s2 = 'INSERT INTO Intervencao( EventoID, Descricao) VALUES ({},"descricao");\n'
   s2 = s2.format(i)

   s3 = 'INSERT INTO TecnicoInterv( TecnicoID, IntervID) VALUES ({},{});\n'
   tecID = tecnicos[ri(0,len(tecnicos)-1)]
   s3 = s3.format(tecID,i)
   
   f.write(s)
   f.write(s2)
   f.write(s3)

f.write("\n-- Medical Intervention\n")
for i in range(500,800):
   s = 'INSERT INTO Evento(EventoID,Descricao, Data, Admissao, Quarto) VALUES ({}, "descricao","{}/{}/{} {}:{}:{}" ,{}, {});\n'

   di = ri(1,28)
   Mi = ri(1,12)
   ai = ri(1960,2019)
   hi = ri(0,23)
   mi = ri(0,59)
   si = ri(0,59)
   a = ri(1,500)
   q = ri(100,249)
   s = s.format(i,di,Mi,ai,hi,mi,si,a,q)

   s2 = 'INSERT INTO Intervencao( EventoID, Descricao) VALUES ({},"descricao");\n'
   s2 = s2.format(i)

   s3 = 'INSERT INTO MedicoInterv( MedicoID, IntervID) VALUES ({},{});\n'
   mID = medicos[ri(0,len(medicos)-1)]
   s3 = s3.format(mID,i)
   
   f.write(s)
   f.write(s2)
   f.write(s3)

exames = ['Sangue','Urina','liquido cefalorraquidiano','liquido sinovial','laringoscopia','broncoscopia','esofagoscopia','cistoscopia','laparoscopia','mediastinoscopia','toracoscopia']

f.write("\n-- Nurse Exam\n")
for i in range(800,950):
   s = 'INSERT INTO Evento(EventoID,Descricao, Data, Admissao, Quarto) VALUES ({}, "descricao","{}/{}/{} {}:{}:{}" ,{}, {});\n'

   di = ri(1,28)
   Mi = ri(1,12)
   ai = ri(1960,2019)
   hi = ri(0,23)
   mi = ri(0,59)
   si = ri(0,59)
   a = ri(1,500)
   q = ri(100,249)
   s = s.format(i,di,Mi,ai,hi,mi,si,a,q)

   s2 = 'INSERT INTO Exame( EventoID, Nome, Descricao) VALUES ({},"{}","descricao");\n'
   s2 = s2.format(i,exames[ri(0,len(exames)-1)])

   s3 = 'INSERT INTO EnfermeiroExame( EnfermeiroID, ExameID) VALUES ({},{});\n'
   enfID = enfermeiros[ri(0,len(enfermeiros)-1)]
   s3 = s3.format(enfID,i)
   
   f.write(s)
   f.write(s2)
   f.write(s3)

f.write("\n-- Tecnician Exam\n")
for i in range(950,1211):
   s = 'INSERT INTO Evento(EventoID,Descricao, Data, Admissao, Quarto) VALUES ({}, "descricao","{}/{}/{} {}:{}:{}" ,{}, {});\n'

   di = ri(1,28)
   Mi = ri(1,12)
   ai = ri(1960,2019)
   hi = ri(0,23)
   mi = ri(0,59)
   si = ri(0,59)
   a = ri(1,500)
   q = ri(100,249)
   s = s.format(i,di,Mi,ai,hi,mi,si,a,q)

   s2 = 'INSERT INTO Exame( EventoID, Nome, Descricao) VALUES ({},"{}","descricao");\n'
   s2 = s2.format(i,exames[ri(0,len(exames)-1)])

   s3 = 'INSERT INTO TecnicoExame( TecnicoID, ExameID) VALUES ({},{});\n'
   tecID = tecnicos[ri(0,len(tecnicos)-1)]
   s3 = s3.format(tecID,i)
   
   f.write(s)
   f.write(s2)
   f.write(s3)

f.write("\n-- Medical Exam\n")
for i in range(1211,1850):
   s = 'INSERT INTO Evento(EventoID,Descricao, Data, Admissao, Quarto) VALUES ({}, "descricao","{}/{}/{} {}:{}:{}" ,{}, {});\n'

   di = ri(1,28)
   Mi = ri(1,12)
   ai = ri(1960,2019)
   hi = ri(0,23)
   mi = ri(0,59)
   si = ri(0,59)
   a = ri(1,500)
   q = ri(100,249)
   s = s.format(i,di,Mi,ai,hi,mi,si,a,q)

   s2 = 'INSERT INTO Exame( EventoID, Nome, Descricao) VALUES ({},"{}","descricao");\n'
   s2 = s2.format(i,exames[ri(0,len(exames)-1)])

   s3 = 'INSERT INTO MedicoExame( MedicoID, ExameID) VALUES ({},{});\n'
   mID = medicos[ri(0,len(medicos)-1)]
   s3 = s3.format(mID,i)
   
   f.write(s)
   f.write(s2)
   f.write(s3)

f.write("\n-- Consultation\n")
for i in range(1850,2300):
   diagnosticos = ['Mal estar','Virose','Infeccao bacteriana','Osso quebrado','Indeterminado','Catapora']*10 + doencas
   
   s = 'INSERT INTO Evento(EventoID,Descricao, Data, Admissao, Quarto) VALUES ({}, "descricao","{}/{}/{} {}:{}:{}" ,{}, {});\n'

   di = ri(1,28)
   Mi = ri(1,12)
   ai = ri(1960,2019)
   hi = ri(0,23)
   mi = ri(0,59)
   si = ri(0,59)
   a = ri(1,500)
   q = ri(100,249)
   s = s.format(i,di,Mi,ai,hi,mi,si,a,q)

   s2 = 'INSERT INTO Consulta( EventoID, Diagnostico, Medico) VALUES ({},"{}",{});\n'
   mID = medicos[ri(0,len(medicos)-1)]
   s2 = s2.format(i,diagnosticos[ri(0,len(diagnosticos)-1)],mID)
   
   f.write(s)
   f.write(s2)

f.write("\n-- Internamento\n")
for i in range(1850,2300):
      
   s = 'INSERT INTO Evento(EventoID,Descricao, Data, Admissao, Quarto) VALUES ({}, "descricao","{}/{}/{} {}:{}:{}" ,{}, {});\n'

   di = ri(1,28)
   Mi = ri(1,12)
   ai = ri(1960,2019)
   hi = ri(0,23)
   mi = ri(0,59)
   si = ri(0,59)
   a = ri(1,500)
   q = ri(100,249)
   s = s.format(i,di,Mi,ai,hi,mi,si,a,q)

   if(ri(0,100) < 70):
      df = di + ri(0,3)
      Mf = Mi + ri(0,2)
      af = ai + ri(0,3)
      hf = hi + ri(1,2)
      mf = mi + ri(0,30)
      sf = si + ri(0,30)
      s2 = 'INSERT INTO Internamento( EventoID, Motivo, DataFim, Ativo) VALUES ({},"{}","{}/{}/{} {}:{}:{}",0);\n'
      s2 = s2.format(i,doencas[ri(0,len(doencas)-1)],df,Mf,af,hf,mf,sf)
   else:
      s2 = 'INSERT INTO Internamento( EventoID, Motivo, DataFim, Ativo) VALUES ({},"{}",NULL,1);\n'
      s2 = s2.format(i,doencas[ri(0,len(doencas)-1)])
   
   f.write(s)
   f.write(s2)

unique = []
f.write("\n-- Event Occourence\n")
for i in range(1,501):

   ev = ri(1,2399)
   if(ev in unique):
      continue
   unique.append(ev)
   
   s = 'INSERT INTO OcorrenciaEvento(OcorrenciaID,EventoID) VALUES ({}, {});\n'
   s = s.format(i,ev)
   
   f.write(s)
   
f.close()
data.close()
